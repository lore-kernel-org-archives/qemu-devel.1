Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20698C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE66206FB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AvUvs0qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE66206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5vs-0008R0-9r
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kL5vF-00080b-UL; Wed, 23 Sep 2020 10:39:05 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com
 ([40.107.8.119]:35373 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kL5vB-00062n-J3; Wed, 23 Sep 2020 10:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAK79s90rRjUD1G5sftVGNbXSDh8tp3y+dpdO0D/ArpUgNuHs0+Zw3KxbTS+sB1x07Caaj19MykGfYxsiyaBvosi8zkTsU2/fnwDXEQ9rGpwOZ9BifwZ4O8Q9u8WcQQx5aAHxy5prYYTu1BaFiHE6icLl+oC9pPOY2R6roxjhtpAFKRvwJ39Ab1xuC+jJUZSn89ZLw6Y+gEY5w1jG6TncuaqN9RT79gQPcceExGqkouhv1eiTF84iisIqR3qNWAic8VXLSVmzVLsHOf0o96sgNieI5Vl3DyxnnZhNAgvHHYcQ7/Ep6e6UFZ5fHiF072jbZQWkA+xPfOvF69XtqQXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIjITdUZ2h5t4zkeLkvUlnV+V8pQoKNNLz72ftbMzNc=;
 b=Df0J4zYjRb3BQuMTz792LOr9nLPQ4xfa5Ge+1RvHnaWXUTsVaPtccR9sBHt+YOT3eq0+3W+MlOkirWIL/Kv3wbw6AMFMIj5ZJPUcN8CZJpiSS2lVY9uv16MbP7Snt4Ya/3gqi7FfEYWvsZ0lUeV8hBLFQckgLte2ETt+wPpMCwnjczHd9sCeEo7H6OZVVZo6O/Pg242jpcLsHcRm3x5WVoXTKXXUIf9CtPOoDzR9rwEeyV6LauvV6PXebUkPPuRzn8H5iGgKiJ9Q/CGNRmTa2W71YUceoebfD/ZIDEA9fhHPGNJ9WwZVeUB2rypSHBNGfLsE+5QUuY7HknbCahAV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIjITdUZ2h5t4zkeLkvUlnV+V8pQoKNNLz72ftbMzNc=;
 b=AvUvs0qmod5RgYN5xzL9FoDNIVM76Ug44Iba7EBBMJdYVc8ecyJJCrnwq+TEC2YfbkYIOtFzf6LfN5PtZPDYplAC+k3zMPmxyC0ywvQwjYZ2fQo450mZd7CGGYryv7FVglFJWMvI2oLtgwrzA1znRxjfDScZ0hSYjtcK/T5SdNU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4692.eurprd08.prod.outlook.com (2603:10a6:20b:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17; Wed, 23 Sep
 2020 14:38:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 14:38:57 +0000
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
 <25a087d0-0306-574d-432b-0b5635ee7873@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1508198c-d52b-08b3-602f-97ff3e83eaef@virtuozzo.com>
Date: Wed, 23 Sep 2020 17:38:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <25a087d0-0306-574d-432b-0b5635ee7873@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 14:38:56 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ff5f1ac-70bb-48af-ce72-08d85fce674e
X-MS-TrafficTypeDiagnostic: AM6PR08MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4692458D7E53C562A063F7EAC1380@AM6PR08MB4692.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3swvSGTRIW2pS3cDT8qZKVvo8R1MO2HX3dBYxl12MyREuq2XdwiO/G3ZjZNX9k2Xueu1RFUfmxtZzCvwgh+B+KR8qTBOsHF03PnRmIZ5PfeWC6t0v8Rv92+IfZ9t0RjtWRKwGe5TJ184/9cRUX0aoyd20ZEOMiLc+rpvSQbYm6mlZP0+FOHxjrBq0vu+lSSm2TdO9/Pzs73+0AOtnMgBCqfAUyX5EAl/KTbN0BOaHArbWVC2cndlJM4zSoNuEe1UVQSm1jCDmc89codiEt1Y37PTICQfpScAEpUiXfGM657/8A+bNl6k9sCFZwtNnuuJ6dwSuA/KS3Dn+PzDwQulNbbvrCx4KwSYL8fg2wKLMuhiSo4LT0ZGT7wv8MZv3J3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(376002)(136003)(346002)(5660300002)(478600001)(8676002)(186003)(26005)(16526019)(83380400001)(107886003)(6486002)(53546011)(52116002)(316002)(16576012)(110136005)(31696002)(86362001)(8936002)(66946007)(66476007)(36756003)(2616005)(2906002)(956004)(31686004)(4326008)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: u/AECL834zF4SvoQyuEcbOoU1OWJZgpXh/+LrK3O9mzXSDPFNF5zi4YQXHy3oWWk4zYzZMzVL9vqaQYlTBmV9CAa+GwEwlzRRBKI9qbyayNMfvhC4tdmEF08rKz0LbDE/C7Z/AuhXW8AljjYwwzmPwDyIgKFnchWuMX73+PRLJsZE5RaJocnfpIQUK6srjkBGoXJnh9LQQT5TNNPyBImQHgic7F0ZVmHOuaLOqF/kZidqL2+MDu/rlR+wy5tK/Sp1Z8xHj5SevshVpu9s4jwxuWTphMKv8MSQPC+e86bXXy9lQEuPXWl+UlrCd+IBv3E6mzK8BRpkWSHl2zbWdDNLe5zxh0Pjdmh595s41fu0GBDGzOh9Nxv1eLoA/eHAKCf+VGfgT6ht3PTudm9mGkD/qdOLKtUFcsrasbklcUdtLjlgVygJ2SoMm1s2bWzGGFfjcEMBH6cq1AyKLXUb+ctVFQjWsTwv9mUmEjjTB3NCsNuYuTOuCFZvuWJTjEsCKWFanFd+tT0HukW6nRBXQVguCeGv2g9x4pCR9YdA50dEImRcDp2vgrF5w0Q7Ntdg6bEX1r/Qc/3Bhnjim16JRn5Y2JOofmJ7/qbuquH9X3zzq8lQ258XxswAIElwjVkKX63fycJHThpgq/Wqvc2uhC+/Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff5f1ac-70bb-48af-ce72-08d85fce674e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 14:38:57.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2B3W3avKmSEqYvJferOynWayodlepwPWa09IYHCGGy90CARlsukERcX7Ieo3DyKZWxqUIw/mKKEHa729sDZlTKwDNXYlit0cbPhJO2TVSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4692
Received-SPF: pass client-ip=40.107.8.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 10:38:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.09.2020 19:09, Andrey Shinkevich wrote:
> On 04.09.2020 14:22, Max Reitz wrote:
>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>> Provide API for the COR-filter insertion/removal.
> ...
>>> Also, drop the filter child permissions for an inactive state when the
>>> filter node is being removed.
>> Do we need .active for that?  Shouldn’t it be sufficient to just not
>> require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
>> node (i.e. perm == 0 in cor_child_perm())?
>>
>> Of course, using an .active field works, too.  But Vladimir wanted a
>> similar field in the preallocate filter, and there already is in
>> backup-top.  I feel like there shouldn’t be a need for this.
>>
>> .bdrv_child_perm() should generally be able to decide what permissions
>> it needs based on the information it gets.  If every driver needs to
>> keep track of whether it has any parents and feed that information into
>> .bdrv_child_perm() as external state, then something feels wrong.
>>
>> If perm == 0 is not sufficient to rule out any parents, we should just
>> explicitly add a boolean that tells .bdrv_child_perm() whether there are
>> any parents or not – shouldn’t be too difficult.
> 
> 
> The issue is that we fail in the bdrv_check_update_perm() with ""Conflicts with use by..." if the *nperm = 0 and the *nshared = BLK_PERM_ALL are not set before the call to the bdrv_replace_node(). The filter is still in the backing chain by that moment and has a parent with child->perm != 0.
> 
> The implementation of  the .bdrv_child_perm()in the given patch is similar to one in the block/mirror.c.
> 
> How could we resolve the issue at the generic layer?
> 
> 

The problem is that when we update permissions in bdrv_replace_node, we consider new placement for "to" node, but old placement for "from" node. So, during update, we may consider stricter permission requirements for "from" than needed and they conflict with new "to" permissions.

We should consider all graph changes for permission update simultaneously, in same transaction. For this, we need refactor permission update system to work on queue of nodes instead of simple DFS recursion. And in the queue all the nodes to update should  be toplogically sorted. In this way, when we update node N, all its parents are already updated. And of course, we should make no-perm graph update before permission update, and rollback no-perm movement if permission update failed.

And we need topological sort anyway. Consider the following example:

A -
|  \
|  v
|  B
|  |
v  /
C<-

A is parent for B and C, B is parent for C.

Obviously, to update permissions, we should go in order A B C, so, when we update C, all it's parents permission already updated. But with current approach (simple recursion) we can update in sequence A C B C (C is updated twice). On first update of C, we consider old B permissions, so doing wrong thing. If it succeed, all is OK, on second C update we will finish with correct graph. But if the wrong thing failed, we break the whole process for no reason (it's possible that updated B permission will be less strict, but we will never check it).

I'll work on a patch for it.

-- 
Best regards,
Vladimir

