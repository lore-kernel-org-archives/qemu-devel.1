Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7A6C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D290206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="REsC3JjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D290206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDEU-0000ua-97
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDDr-0000EH-SF; Wed, 06 May 2020 02:07:59 -0400
Received: from mail-eopbgr10112.outbound.protection.outlook.com
 ([40.107.1.112]:25924 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDDo-0004DK-MT; Wed, 06 May 2020 02:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0uDl/CC3nrjmxt9oIoupS2XsERioNeTV6vC+5WONIXt92ciH+ic/Lq/sxl80YnuHH0nvd0rnetpwqpchWhGQhiQz92pByipRT2BN7cBWN9fh7/FBntXSjnW+DJJIERHaCZbVlsTdBjre9wpXkvuXhJAycXH12KyylLt2Nm5KsAdOR+2pEc4GUeMI3jfbfihRpBAoml2xVvkUGejCMq3hxm2ZTChS2gVcfX3OxRhYag8zCL5TzwoORBZyJX5bWSmdZ66ReMPwYJbW9hrwM2Vj8Fiwho7VVMIF9KyELx4QEtWm3XPNANvkyFBaJZsR9+jIl8XNU4Y+pkdXt/HmPh/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CudwLW9vjVX4wUhbDbP0HNeI/G+9PfmqQbiMA5gyvOE=;
 b=BwQT7rl/EqT0QodeGg1+8jB5dwQApHnahX8PSOYjWVPyOLYlGWPaDxqPvrS5vOSjfAuEzWe4S0Cvo4fa7OzD8Be2vlXtEoivgD0VZ2qXCj+H5MFIBVCAKXf59gpmAXwFD/Ov5CP4e2NHPQzcMsoMUwCYckemjBCxLkwSBhwxJP/T6eGoUaOUPtpsUKELuLTeObp4Z61JK4PKmP2Nv4NE/IipJBKOz8lLs+9IYBRbFEZi+S9eG7JrxYlcziY+eRxK3rSCIJ/F7X0f9BbqcHGm2Ar+DGMESMmVKqYNhW52TaPnyD9ZADO4umUSQJc3FhdUF4DAI4lUe2Z/DVbMpVR6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CudwLW9vjVX4wUhbDbP0HNeI/G+9PfmqQbiMA5gyvOE=;
 b=REsC3JjKoVQSybyR4d6zXm6XAXWaJLQRoMQYkD40T5Wz02B3bZDSZnVoZAst3Eww901lhcrOaLBNMiwH47I3/T6D6g5YM9Fi9uOBU+7qyURaOwk4+GTo78Bofejg0oE+zweEx+jV99UJ/KlBoi5bdzgLLw10dLTLoXearHfOTAw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 06:07:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:07:51 +0000
Subject: Re: [PATCH v2 3/4] backup: Make sure that source and target size match
To: Kevin Wolf <kwolf@redhat.com>
References: <20200430142755.315494-1-kwolf@redhat.com>
 <20200430142755.315494-4-kwolf@redhat.com>
 <d5de1915-523b-fbdb-2ebe-8c31cf0e0cdf@virtuozzo.com>
 <20200505100334.GH5759@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506090750415
Message-ID: <f91f3d3d-5c20-dfde-c9e0-506f8618c585@virtuozzo.com>
Date: Wed, 6 May 2020 09:07:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200505100334.GH5759@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Wed, 6 May 2020 06:07:51 +0000
X-Tagtoolbar-Keys: D20200506090750415
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d0f489-5c15-424d-3e88-08d7f183cf3e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495DC11A50B6B9544C123E6C1A40@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uayORVFZLAdu2gH84TvjrxC8ea9A+x7m430RHciBMNpHw4wLcBJB/ZxMkIek5srfq9Nz/lSwKSzvmG1X/qEjdQlLwD1dAARcjuAwU1ycGAvvfKZXW5PrvkD6W2+9kS2Scu/JoWFK34uURSFbCNRT8vMtK3LH+QZ4ZE6z4AhGp3IR2XsfzFKQFy3o+bO8FR3R2HIOux9xsi3yb1L1eBeTPi02iegx22Dvcpx+iNhDvMRslREGekff245LlaG/4mrelOH/Gi6FABS4TkfF4W9RkP7io2av3NyfZCyz66NDKsSMZYSaHA0qdf5o9cP1wR5i/VyF5OGjpV8f2SFJExcNpNC8pAbWsZpdOhBEjbJHMkV42aRMjCXUOAsHfzpnJw2+q/fV7kZ3+06oXR0JXAtnQ0aUWdkAaLclIrA9cQEnX1AEDvAjxOjWLgNj9TUvWj8BEZSnLFJDAhFg0T5XRC8mxCuNkRJLI8E63IyDX3g038PniKisQCG2VvreFlG+Pr7kQjprDv2aT4a6dy46AP+kvCvNaHeUSS9MU3/sY4ptvq+IM13DMx5OK01dpSdG6xQuttKbq0AhWg5DDyg/zWXuE3sjWxeHmq9AISlHFVwGKJd+UgU7ha0VPkUhP4W8VEQK5iCmaP/V39CiRvUfWDXBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39830400003)(366004)(136003)(33430700001)(4326008)(66946007)(478600001)(66476007)(66556008)(5660300002)(966005)(2906002)(6486002)(31696002)(36756003)(8676002)(86362001)(33440700001)(956004)(2616005)(16576012)(31686004)(316002)(8936002)(16526019)(6916009)(52116002)(26005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jlWGYyPaT2hvWYnaOsq5o0Ch1H7gGmjDUtbX5secVRP3cQqX0AyiuwlPtN8hloeR0QVXR/g7W5xcvAdECP5VXTXRgxCZiRkePZtf+IEFxDZGYNKfwvNHoQyWolriPTDaVjjOjyEFyV6TsvXJsmZRat333buMq9c5Q8W7jq0l6wHSO1AAioZ6FzYEUDbbM7Dq6mL0fHGAkBgd+YOZB/y5zemgQVsFcYxlqiDS1mF8mgvyC3BHdDcAbxWucUKdq2qQ8GxZmdxzmotLO3okWwyQpC8Vew6bHVSeq5g8FoOBQcF0OleT29ZVxylytfYNO9kYP/IMvKTAn1zAYKpY4qfDEbmU5+H4sxCvHwxkrB2t9Tn4M52GAWBM2qE9KA3qwM83Wxezd1mziWOhihq7prZyih8R4ugH5WXTyK2UtvdPcK+DXIlh81tQvMV1OMYxblhOde9qAq62lWCPFb3pvsP1DE66aqtkFXdnawUahteeX3cFiPhWe0TnD46USR9Ey21vJGjvQvpmyYeDdpuzfB2Mw8mf7+tg6WPF8QBfUAbOcDNO5yORHfSxXkjmiuyBb7Qu0Mg4ISDYgp8KWeWoMRyTSr+IUpG+1BQTFB8TLNxS3doNmrL9ovaeuRyIDROyZbNAhcI4wdqDcng7WVYzxN26lZTqc7aw6rBZkzVBo5L6HLKshiSre2loyBVCMvhzfrHzntulwq7fyetTCDSwVhB5Ih6nNLRbCiGBETDFshBFkYZ3vAmrKYtYRNoDA37/EuK+ofqCrk1Xq+V6ZAruPwmq9FTniIWEFlzRt8Xnz756ugE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d0f489-5c15-424d-3e88-08d7f183cf3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:07:51.7232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fE2yd2MX4diP2FbTCtn1eodJ8B700N3hlchUD0S2H0QskpnPG/L2sRGG702xtWhqtktURDE8vssYmErt8YhNhYCGB+KTSKkisGRErgGmFbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.1.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:07:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.05.2020 13:03, Kevin Wolf wrote:
> Am 30.04.2020 um 20:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 30.04.2020 17:27, Kevin Wolf wrote:
>>> Since the introduction of a backup filter node in commit 00e30f05d, the
>>> backup block job crashes when the target image is smaller than the
>>> source image because it will try to write after the end of the target
>>> node without having BLK_PERM_RESIZE. (Previously, the BlockBackend layer
>>> would have caught this and errored out gracefully.)
>>>
>>> We can fix this and even do better than the old behaviour: Check that
>>> source and target have the same image size at the start of the block job
>>> and unshare BLK_PERM_RESIZE. (This permission was already unshared
>>> before the same commit 00e30f05d, but the BlockBackend that was used to
>>> make the restriction was removed without a replacement.) This will
>>> immediately error out when starting the job instead of only when writing
>>> to a block that doesn't exist in the target.
>>>
>>> Longer target than source would technically work because we would never
>>> write to blocks that don't exist, but semantically these are invalid,
>>> too, because a backup is supposed to create a copy, not just an image
>>> that starts with a copy.
>>>
>>> Fixes: 00e30f05de1d19586345ec373970ef4c192c6270
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1778593
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>> I'm OK with it as is, as it fixes bug:
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> still, some notes below
>>
>>
>>> ---
>>>    block/backup-top.c | 14 +++++++++-----
>>>    block/backup.c     | 14 +++++++++++++-
>>>    2 files changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block/backup-top.c b/block/backup-top.c
>>> index 3b50c06e2c..79b268e6dc 100644
>>> --- a/block/backup-top.c
>>> +++ b/block/backup-top.c
>>> @@ -148,8 +148,10 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>>>             *
>>>             * Share write to target (child_file), to not interfere
>>>             * with guest writes to its disk which may be in target backing chain.
>>> +         * Can't resize during a backup block job because we check the size
>>> +         * only upfront.
>>>             */
>>> -        *nshared = BLK_PERM_ALL;
>>> +        *nshared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
>>>            *nperm = BLK_PERM_WRITE;
>>>        } else {
>>>            /* Source child */
>>> @@ -159,7 +161,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>>>            if (perm & BLK_PERM_WRITE) {
>>>                *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
>>>            }
>>> -        *nshared &= ~BLK_PERM_WRITE;
>>> +        *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>>>        }
>>>    }
>>> @@ -192,11 +194,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>>>    {
>>>        Error *local_err = NULL;
>>>        BDRVBackupTopState *state;
>>> -    BlockDriverState *top = bdrv_new_open_driver(&bdrv_backup_top_filter,
>>> -                                                 filter_node_name,
>>> -                                                 BDRV_O_RDWR, errp);
>>> +    BlockDriverState *top;
>>>        bool appended = false;
>>> +    assert(source->total_sectors == target->total_sectors);
>>
>> May be better to error-out, just to keep backup-top independent. Still, now it's not
>> really needed, as we have only one caller. And this function have to be refactored
>> anyway, when publishing this filter (open() and close() should appear, so this code
>> will be rewritten anyway.)
> 
> Yes, the whole function only works because it's used in this restricted
> context today. For example, we only know that total_sectors is up to
> date because the caller has called bdrv_getlength() just a moment ago.
> 
> I think fixing this would be beyond the scope of this patch, but
> certainly a good idea anyway.
> 
>> And the other thought: the permissions we declared above, will be activated only after
>> successful bdrv_child_refresh_perms(). I think some kind of race is possible, so that
>> size is changed actual permission activation. So, may be good to double check sizes after
>> bdrv_child_refresh_perms().. But it's a kind of paranoia.
> 
> We're not in coroutine context, so we can't yield. I don't see who could
> change the size in parallel (apart from an external process, but an
> external process can mess up anything).
> 
> When we make backup-top an independent driver, instead of double
> checking (what would you do on error?), maybe we could move the size
> initialisation (then with bdrv_getlength()) to after
> bdrv_child_refresh_perms().
> 
>> Also, third thought: the restricted permissions doesn't save us from resizing
>> of the source through exactly this node, does it? Hmm, but your test works somehow. But
>> (I assume) it worked in a previous patch version without unsharing on source..
>>
>> Ha, but bdrv_co_truncate just can't work on backup-top, because it doesn't have file child.
>> But, if we fix bdrv_co_truncate to skip filters, we'll need to define .bdrv_co_truncate in
>> backup_top, which will return something like -EBUSY.. Or just -ENOTSUP, doesn't matter.
> 
> Maybe this is a sign that bdrv_co_truncate shouldn't automatically skip
> filters because filters might depend on a fixed size?
> 
> Or we could make the automatic skipping depend on having BLK_PERM_RESIZE
> for the child. If the filter doesn't have the permission, we must not
> call truncate for its child (it would crash). Then backup-top and
> similar filters must just be careful not to take RESIZE permissions.
> 

Hmm this should work.. Still it's a workaround, seems out of the concept of permission system..

I think, that the problem is that .bdrv_top_child_perm can't return an error.
The handler answers the question:

- Hi, we are your owners and we want the following cumulative permissions on you. Then, which permissions do you want on your child?

And the handler can't answer: "Hi, you guys want too much, I refuse to play by your rules"..


-- 
Best regards,
Vladimir

