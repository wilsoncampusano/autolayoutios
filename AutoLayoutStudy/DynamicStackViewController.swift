//
//  DynamicStackViewController.swift
//  AutoLayoutStudy
//
//  Created by Wilson Campusano on 3/23/18.
//  Copyright © 2018 Wilson Campusano. All rights reserved.
//

import UIKit

class DynamicStackViewController: UIViewController{
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let insets = UIEdgeInsets(top: 20.0, left: 0.0,bottom: 0.0,right: 0.0)
		scrollView.contentInset = insets
		scrollView.scrollIndicatorInsets = insets
	}
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var stackView: UIStackView!
	
	@IBAction func addEntry(_ sender: UIButton) {
		let stack = stackView
		let index = (stack?.arrangedSubviews.count)! - 1
		let addView = stack?.arrangedSubviews[index]
		
		let scroll = scrollView
		let offset = CGPoint(x: (scroll?.contentOffset.x)!, y: (scroll?.contentOffset.y)! + (addView?.frame.size.height)!)
		
		let newView = createEntry()
		newView.isHidden = true
		
		stack?.insertArrangedSubview(newView, at: index)
		
		UIView.animate(withDuration: 0.25, animations:{ () -> Void in
												newView.isHidden = false
												scroll?.contentOffset = offset
		})
	}
	
	@objc func deleteStackView(sender: UIButton){
		if let view = sender.superview {
			UIView.animate(withDuration: 0.25, animations: {()-> Void in
				view.isHidden = true
			}, completion: {(success) -> Void in
				view.removeFromSuperview()
			})
		}
	}
	
	private func createEntry() -> UIView{
		let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
		let number = "\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())"
		
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .firstBaseline
		stack.distribution = .fill
		stack.spacing = 8
		
		let dateLabel = UILabel()
		dateLabel.text = date
		dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
		
		let numberLabel = UILabel()
		numberLabel.text = number
		numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		
		let deleteButton = UIButton(type: .roundedRect)
		deleteButton.setTitle("Delete", for: .normal)
		deleteButton.addTarget(self, action: #selector(DynamicStackViewController.deleteStackView(sender:)), for: .touchUpInside)
		
		stack.addArrangedSubview(dateLabel)
		stack.addArrangedSubview(numberLabel)
		stack.addArrangedSubview(deleteButton)
		
		return stack
		
	}
	
	private func randomHexQuad() -> String{
		return NSString(format:"%X%X%X%X", arc4random() % 16,arc4random() % 16,arc4random() % 16,arc4random() % 16) as String
	}
}
