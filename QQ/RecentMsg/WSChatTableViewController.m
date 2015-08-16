//
//  WSChatTableViewController.m
//  QQ
//
//  Created by weida on 15/8/15.
//  Copyright (c) 2015年 weida. All rights reserved.
//

#import "WSChatTableViewController.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatModel.h"
#import "WSChatTimeTableViewCell.h"

#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])

@interface WSChatTableViewController ()
@property(nonatomic,strong)NSMutableArray *DataSource;
@end

@implementation WSChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"张金磊";

    
    self.tableView.estimatedRowHeight = 150;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kBkColorTableView;
    
   
   
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"1%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    [self.tableView registerClass:[WSChatTextTableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"0%@%ld",kReuseIDSeparate,(long)WSChatCellType_Text]];
    
    [self.tableView registerClass:[WSChatTimeTableViewCell class] forCellReuseIdentifier:kTimeCellReusedID];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.DataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSChatModel *model = self.DataSource[indexPath.row];
    
    WSChatBaseTableViewCell *cell;
    
    NSString *reuseID = nil;
    
    if (model.chatCellType == WSChatCellType_Time)
    {
        reuseID = kTimeCellReusedID;
    }else
    {
        reuseID = [NSString stringWithFormat:@"%d-%ld",model.isSender,(long)model.chatCellType];
    }
    
   cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
   
    [cell setModel:model];
    
    return cell;
}


-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    _DataSource = [NSMutableArray arrayWithCapacity:20];
    
    for (NSInteger i = 0; i<20; i++)
    {
        WSChatModel *model = [[WSChatModel alloc]init];
        
        switch (i%3) {
            case 0:
            case 1:
                
                 model.chatCellType = WSChatCellType_Text;
                
                 model.content = @"我撒风景撒发生";
                
                break;
            default:
                
                model.chatCellType = WSChatCellType_Time;
                
                model.content = @"下午9:00";
                
                break;
        }
        
        model.isSender = i%2;
       

        [_DataSource addObject:model];
    }
    
    
    return _DataSource;
}

@end
