//
//  ViewController.swift
//  Move Text Up
//
//  Created by Warren Hansen on 4/16/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var constraintTextStackBottom: NSLayoutConstraint!
    
    var constraintInitially: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.delegate = self
        constraintInitially = self.constraintTextStackBottom.constant
        setupViewResizerOnKeyboardShown()
    }
    
    // set up return and tap to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInput.resignFirstResponder()
        return true
    }
    
    // set up keyboard notifications
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillShowForResizing),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.keyboardWillHideForResizing),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func keyboardWillHideForResizing(notification: Notification) {
        keyBoardMove(moveUp: false)
    }
    
    func keyboardWillShowForResizing(notification: Notification) {
        keyBoardMove(moveUp: true)
    }

    // animate the keyboard move and fade the image
    func keyBoardMove (moveUp: Bool) -> Void {
        
        var alpha: CGFloat
        var constraint: CGFloat
        print ( "KEYBOARD UP:  \(moveUp) "    )
        if moveUp {
            alpha = 0.3
            constraint = self.constraintInitially! + 180}
        else {
            alpha = 1.0
            constraint =  self.constraintInitially!
        }
        let animInterval = 3.0
        print ("ALPHA: \(alpha)   CONSTRAIN: \(constraint)  ANIM:  \(animInterval)" )
        UIView.animate (withDuration: animInterval,
                        delay: 0.2,
                        options: .curveEaseIn,
                        animations: { () -> Void in
                            self.topImage.alpha = alpha
                            self.constraintTextStackBottom.constant = constraint
                            self.view.layoutIfNeeded()
        },
                        completion: nil )
    }
    
}

