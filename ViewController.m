//
//  ViewController.m
//  ccccc
//
//  Created by ze on 16/1/12.
//  Copyright © 2016年 ze. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong)UIView *headv;
@property (nonatomic, strong)UIView *floatingView;
 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *_tb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    _tb.tableHeaderView = [self headv];
    _tb.delegate = self;

    
    _tb.dataSource = self;
    [self.view addSubview:_tb];
    [self addInHeader];
    
   
}

- (void)addInHeader
{
    [self.floatingView removeFromSuperview];
    
    [self.headv addSubview:self.floatingView];
    CGRect r = self.floatingView.frame;
    r.origin.y = 200 - 50;
    self.floatingView.frame = r;
}


- (void)addInSelf
{
    [self.floatingView removeFromSuperview];
    [self.view addSubview:self.floatingView];
    [self.view bringSubviewToFront:self.floatingView];
    
    CGRect r = self.floatingView.frame;
    r.origin.y = 64;
    self.floatingView.frame = r;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scr y :%@", @(scrollView.contentOffset.y));
    CGFloat delta = 150 - scrollView.contentOffset.y;
    NSLog(@"delta %@", @(delta));
    if (delta <= 64) {
        if ([self.headv.subviews containsObject:self.floatingView]) {
            [self addInSelf];
        }
    }
    else{
        if ([self.view.subviews containsObject:self.floatingView]) {
            [self addInHeader];
        }
    }
}

- (UIView *)headv
{
    if (!_headv) {
        _headv = ({
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
            v.backgroundColor = [UIColor cyanColor];
            v;
        });
    }
    return _headv;
}


- (UIView*)floatingView
{
    if (!_floatingView) {
        _floatingView = ({
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            v.backgroundColor = [UIColor redColor];
            v;
        });
    }
    return _floatingView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const ide = @"ide";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ide];

    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
