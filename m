Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22084206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ch2RhSSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22084206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSav-0001iD-C7
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtSaF-0001FZ-00; Thu, 09 Jul 2020 05:11:11 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com
 ([40.107.13.113]:2128 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtSaC-0006ZA-24; Thu, 09 Jul 2020 05:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RILvqaFrwECVePMdKz1Th/gIU5IoKwk/GydSsi5ns4gwAFXwwgc5Q6++4bXBiCrFTbxGUR5+PJRD5jPChSuqdZvXaSTWRWzUXZ4SzRnQDbA88iZJYvCYe6dF9qTKXPjfqzX4FgruahxWp2dVb8F/xE6WQdGRWCzAo3Cwfj0EBX2gpcE9txJoC4hYJL18lH4AEk7bCEnwPaYDOaLJ0/sl+hNm+BnXboLXERHmQvzuQFZQg72FssDBYeMj5PnsR5AvkloF3wdcyTPAGejiywOG16nL4MXv8w5uIGqXEok9+mLP1X34PtXmZ3b3Whe+u1JkLqWbZSZBy7MOIfUCWI0eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=229RO4Uttj/T0q3is462ZP8beLIt/Ar7BXHV0bWKn44=;
 b=MpQ4GTng7E3Cf9MNK1GZTi6udTc5ZkNpX09mVjmLwnZUBjXZGXZrqz8DQOVQ9omGRltnDLPPH9Qr89lKZKOE8Kt8vhY1svlExmCQHwXbOcSbxcreXj63v1++1+gl8BfXf+F/+ujKNur9YqWH1JeYrXDmHSs/8gGvt+7NXUQCmQHCZTTfwa6vAfex376X2mQc7RiCQvJl8LBzfZiRMgQelM0n01asZx0fUWajknwM//yk59JeFEc5Ig2ND+F5xXjKBjqnwzcdCpAwprA16tJVP7ORVmD2aYFaUrB70cCbqFr3zXyiA7o3k2z87iLqjsIiUqulsqzVEJ30BJ5OAG8XJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=229RO4Uttj/T0q3is462ZP8beLIt/Ar7BXHV0bWKn44=;
 b=ch2RhSSq946e5Ro63WfyG9pws3+IP79K9QdAGhzH1Jy9/RYxwZYFdONT6mDzGgMUS30SNR8TP3D5LfzbX/52NVWiRcnx+O/zSFF4GXGEkxls4OSV+QcUIUqLqJ4WUyqfV00qwOfjUvk2KAMUzeaXuzmM4bKwiz3fZZ6O41/9ey4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB2034.eurprd08.prod.outlook.com (2603:10a6:203:4b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 09:11:04 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 09:11:04 +0000
Subject: Re: [PATCH v7 12/47] block: Use bdrv_filter_(bs|child) where obvious
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-13-mreitz@redhat.com>
 <82792291-86a1-34cc-98e8-6d585755c79b@virtuozzo.com>
 <898d0f61-8994-4750-98bd-d6870335d223@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <1f2987b2-14ea-41c6-8f5f-3922549f4ca7@virtuozzo.com>
Date: Thu, 9 Jul 2020 12:11:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <898d0f61-8994-4750-98bd-d6870335d223@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::34) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 09:11:03 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b4b3dab-5c45-4cb9-683c-08d823e8018f
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2034FC947B8D2E2CC98995EFF4640@AM5PR0801MB2034.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3Kao4+H+wWyxEkDp1gHBvTROeAuiOtHhReVtlQ2O72xfADsYVwsirFiDjB+K7YiNrmXvo4Mnp6VLL9OCQT3hqMoT7d5TMMZ+1PFZoI9/wqEqucU6ZNmCZQx0eYY/TxU+ZOdr1dNAqCrPsrPXcYStghGrn50qu0XqNr36jQyuVbDwQf+hp5Ip9gpUL3Bgqw0wHFJDZT5319fpuW0hsQjhzCntDyHymqx02VlMfJqJEqD9k1q1jx0JJpXPhfWqxS9S/2ZhDZDiOcaf12b72Ve6YWl3yCV6UAXfAIUIoWMQ8K1pvOrS174uG5JejL29J0lssg85h0JoJZBLXwsdiIrUAuRB2gA6MwFmfFldZ1Umkg7dX8L7zliuUdyFs+piG6g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(36756003)(44832011)(66476007)(2616005)(956004)(316002)(52116002)(53546011)(4326008)(6506007)(2906002)(8936002)(8676002)(31696002)(83380400001)(86362001)(26005)(16526019)(186003)(54906003)(66556008)(5660300002)(66946007)(31686004)(6512007)(478600001)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZxwnyR4zSxYgWp+oG9vdNNocaNz1MhVMx7IDFLZJGTBzs0QjWuxZtd9F3rNB5dUH9esVpKtT/dalo27183SXF3wp1MzfgbLH3O/Ws3LBdFSUN1IY1xij11ThFfuadVHan0WuZO9z9mcRHdDfCURNPIRouIt48XX8YvmIGyCPwSAWfCIf7B1C4s+Up+aQnM9ZJvUqGpMFhuc9DUsnXF5bjQ/etWv0KJGKso6KZ73HYckJ88lktRHrqbtoUzhqTDjIx7GCnIkvYdkvvCLUAynnXu7xufXbcUZXkTr2xF8x/nEIn3Fvq3JIv52bi2ajUR1euH8FxTUMT1tX3+sNKkhxurqEMH1Gx+5+g9j96EyIrXpf7im5ymFQ3XkyoZt2xBvE7C8/YoWh2DAHlGkJfBmbfqDUCQdp4lXU8Zt01JijZINRB6R/kEzTi8Z5QhVz+XffGc8GZylASjYvbvnpSjZkiGjdMY+3r5fHNOO2oBl7KX9V/r10rI/af6Nt0aOBPxTA
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4b3dab-5c45-4cb9-683c-08d823e8018f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 09:11:03.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7PTU/MdFIiOLSFgzUQrAjoiLPFkM8HlIkOPVB+HnRv9OOGtyixd3rQZoSvIQjyvwUOtT0ZkaZZ79q1tUMRcmnrPkcnIOTB5Co7OqpMQ+3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2034
Received-SPF: pass client-ip=40.107.13.113;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 05:11:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.07.2020 11:59, Max Reitz wrote:
> On 08.07.20 20:24, Andrey Shinkevich wrote:
>> On 25.06.2020 18:21, Max Reitz wrote:
>>> Places that use patterns like
>>>
>>>       if (bs->drv->is_filter && bs->file) {
>>>           ... something about bs->file->bs ...
>>>       }
>>>
>>> should be
>>>
>>>       BlockDriverState *filtered = bdrv_filter_bs(bs);
>>>       if (filtered) {
>>>           ... something about @filtered ...
>>>       }
>>>
>>> instead.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block.c                        | 31 ++++++++++++++++++++-----------
>>>    block/io.c                     |  7 +++++--
>>>    migration/block-dirty-bitmap.c |  8 +-------
>>>    3 files changed, 26 insertions(+), 20 deletions(-)
>>>
>> ...
>>> diff --git a/block/io.c b/block/io.c
>>> index df8f2a98d4..385176b331 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -3307,6 +3307,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild
>>> *child, int64_t offset, bool exact,
>>>                                      Error **errp)
>>>    {
>>>        BlockDriverState *bs = child->bs;
>>> +    BdrvChild *filtered;
>>>        BlockDriver *drv = bs->drv;
>>>        BdrvTrackedRequest req;
>>>        int64_t old_size, new_bytes;
>>> @@ -3358,6 +3359,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild
>>> *child, int64_t offset, bool exact,
>>>            goto out;
>>>        }
>>>    +    filtered = bdrv_filter_child(bs);
>>> +
>> Isn't better to have this initialization right before the relevant
>> if/else block?
> Hm, well, yes.  In this case, though, maybe not.  Patch 16 will add
> another BdrvChild to be initialized here (@backing), and we need to
> initialize that one here.  So I felt it made sense to group them together.
>
> They got split up when I decided to put @filtered into this patch and
> @backing into its own.  So now it may look a bit weird, but I feel like
> after patch 16 it makes sense.
>
> (I’m indifferent, basically.)
>
> Max

Yes, it makes a sence. I am on the way to reviewing further and have not 
reached the 16th yet.

It is a minor thing anyway )) Thank you for your response.

Andrey


