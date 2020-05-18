Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67512C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC14207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S25DPDRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC14207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajx8-0000rH-9P
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jajwQ-0008UC-MT; Mon, 18 May 2020 13:52:42 -0400
Received: from mail-eopbgr140110.outbound.protection.outlook.com
 ([40.107.14.110]:27374 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jajwN-000183-KP; Mon, 18 May 2020 13:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzOm5X8MYOvDDwKr0yNFJQnsC0yXJB6nvmMIBDKXNPm57pftABljYuER6WNcMsgD/V5ou6hja+4BpspfianKctQo4Z2LQJThi9mRVnIrl7V9nrABFf+lt5NH9+7Gyi6QmdrFGRl7kJY5pgR4HXfi8d9/MhAG3eNjgOK9PxhFW2w+wt5AOx4mnx0ZuG75iVr3ho7ZB1guJyzQT3Vxbs2VCjIlJucXaPeI+cSxbykAnROGK8Ul+fzFnn//SDmByzeErCfoCfPEySKGFc9gcVQvdwLb92svtESFCJDMXHRU6FbAQ8iYsj/oIHC/4wrxiecv0aJ6fWTS2PDtyeCcmrImaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utkw/6aTWvmMWDRZ7wIKLoNiQrQGD3lRXoQ9q0diK+U=;
 b=OJl2lR6C3LXxwHlBKpTs464XFTcDEvq1HI7ZdHguWwif9L/hcpdJ9jAn690X9II5Ox8Pv1VMRGfbP80Phy3+TZTqV0DsImTTruwIFnwhjt/akBKso3v84Jw+++3/OiV3S9gH9AU9xFgHVxcPy1uUTB0BK+OVHl/KeqnnJrbP6dn95kwzztnje7bVclO7+675GjSyRPWqM4aLFdu2L0nVdjcif4PEFZ9Fyo/ysYzBNMjgvc71dTzx++WtoObTWthz7n7ZupSKCRwR7rTQ821LBmKkZIVaeQ85iemknHX2A346sWR2tP45xXQ1DrpEetq9B9p39guHudecFKhMV1jDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utkw/6aTWvmMWDRZ7wIKLoNiQrQGD3lRXoQ9q0diK+U=;
 b=S25DPDRG4QVxQy2It2CGBKXyiVmBVZZ3OmvB7+hpqaZIjhXCh4bFP7JecSUX+iuztHjtIpsVKE22QHOWEsJwtBe/nnqDxUQhar/1k0c2pRYXYgctXqsCUPBBDtrJmU/8WR5O++NNV3RuPUIY1L/WlvIuR122Lu+rALAqljlwTfo=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3663.eurprd08.prod.outlook.com (2603:10a6:803:85::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Mon, 18 May
 2020 17:52:35 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 17:52:34 +0000
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Peter Krempa <pkrempa@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200518162648.GC2995787@angien.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <de0ee410-d5bd-f59a-6e20-0c10ccd54ccb@virtuozzo.com>
Date: Mon, 18 May 2020 20:52:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200518162648.GC2995787@angien.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0070.eurprd07.prod.outlook.com
 (2603:10a6:207:4::28) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM3PR07CA0070.eurprd07.prod.outlook.com (2603:10a6:207:4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.10 via Frontend Transport; Mon, 18 May 2020 17:52:33 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ecf9bd-b781-4808-6087-08d7fb543ec9
X-MS-TrafficTypeDiagnostic: VI1PR08MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3663D179774DCED58A6B1C98C1B80@VI1PR08MB3663.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpZh5VIDgD2uCMNxRdgNidWT4rV6lXSKvQjFfUv98UX+DY8Uy2KUwntPftHuOWPzihRyzVZO4Lnyr2VRhcBCjPSyvwK45HO56Prth7dwhY4GPDT0/Nzgeeqt0OpyEooF7NtplUvXJu1e3oTpyWFT3JyK7OMw+/U/vDoDAN7Yuz7R/hB+7fSlFmhy2OZREMgi001/Wx6mYZpDZc0wPrVRZ5F7FtLgDd6sje3vb9Gd6dUe3DtrKv9XngGXJHRGf0v07EZ9ntd63ngTq7MWmfp6O4sTnsDnZe5JoTjJyoyWbHimVIg+woWMXsB5dH3gPIymGddIRsGGHETEOrr1XINWjXpSL/YC51gnMyCM6Du2SVdE3J/iKqW6nuBm0VnywvdgZi5LKaN90LeAbBy9k6TzxuwjRzqfail9TFDVCWMDeHtrVzjbtW61rXQ4OIzJN0MQ5tfTEbX3vFlHmN3Ky+F/HPPghuj93T3xRiSS7VzKRN8zWIMrx+sxlpHFaSu+lIng
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39840400004)(136003)(396003)(6486002)(2906002)(107886003)(52116002)(53546011)(5660300002)(31686004)(86362001)(66946007)(66476007)(8936002)(31696002)(66556008)(8676002)(186003)(54906003)(110136005)(16576012)(36756003)(478600001)(26005)(16526019)(2616005)(316002)(4326008)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aoulqLxh9ztjLa/AUpYgyaxSbdKe3bwlswLZkvFZqrGe7d2S04ARkZb82N3ddG4Gx/9HWAOvVgNaVg4wSs2QaB1ILEP/jO/VKFAYKCt9vfXVZxHn4QdMvPfZ6Q46Ew0g+hPxXiKhpro+g+HktyAFpUw2DG6/kCu4iHJN9m3QHjl7huog6ypRzgtHAki3pIrhhdzXgOMpoCg/IwEXcFK93/gHv/Vfm9fIGDHcEGheUYXxQvB/mawCyVCSpow2IbAyKokvejxHxaIqgrFdUjgCnptolbyVI0Y5jLoKza1EUr8ki1SlKHRhvHZ8wOZekFTfkJScuwHMmWHqWwwPLT/1M7+8VcEeTEvxxfo7eLjtm/hWm0uKnjwA+ftVzGFBgkN4T/0UirlMj1ww1fqwvONiC/3LSWWQqXmeimoRewQ5WNjk+qGUqubg+DSs8GLRBBtKe0WRQ1v5Jx534wrekanWFI5WwXgRua4M4YF5q2J4DeKnrVQRsFr0hl9hMfRj40U7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ecf9bd-b781-4808-6087-08d7fb543ec9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 17:52:34.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jUzWdAORYg0rqUUnjCYK70U4IcH47ASv6ryikiGXfPn1UZJdU8SwHC8RLOg0h0Qi/3d4/IU7he/c3ai08y2siO1qpJUXCDgJU06/7zt27I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3663
Received-SPF: pass client-ip=40.107.14.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 13:52:36
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
Cc: qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[add Nikolay]

18.05.2020 19:26, Peter Krempa wrote:
> On Wed, May 13, 2020 at 16:56:10 +0200, Max Reitz wrote:
>> This command allows mapping block node names to aliases for the purpose
>> of block dirty bitmap migration.
>>
>> This way, management tools can use different node names on the source
>> and destination and pass the mapping of how bitmaps are to be
>> transferred to qemu (on the source, the destination, or even both with
>> arbitrary aliases in the migration stream).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
> 
> [...]
> 
>> ---
>>   qapi/migration.json            | 36 ++++++++++++++++++++
>>   migration/block-dirty-bitmap.c | 60 ++++++++++++++++++++++++++++++++--
>>   2 files changed, 94 insertions(+), 2 deletions(-)
> 
> I just started to write some quick and dirty hacks to test use of this
> infrastructure in libvirt. I have 2 quick observations for now:
> 
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..97037ea635 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1621,3 +1621,39 @@
>>   ##
>>   { 'event': 'UNPLUG_PRIMARY',
>>     'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @MigrationBlockNodeMapping:
>> +#
>> +# Maps a block node name to an alias for migration.
>> +#
>> +# @node-name: A block node name.
>> +#
>> +# @alias: An alias name for migration (for example the node name on
>> +#         the opposite site).
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'MigrationBlockNodeMapping',
>> +  'data': {
>> +      'node-name': 'str',
>> +      'alias': 'str'
>> +  } }
> 
> We'd probably like a
> 'nodename:bitmapname' -> 'alias' mapping so that we can select which

If we need bitmap mapping, than it should be nodename:bitmapname -> nodealias:bitmapalias mapping, for backward-compatibility with current qemu.

> bitmaps to migrate and where to migrate them to. The specific use case
> is following:
> 
> Libvirt supports migration without shared storage (NFS/etc) where we
> copy the disk images prior to the memory migration using qemu's NBD
> server and the blockdev-mirror job. By default and the most simple way
> which doesn't require users fudging with the disk images and copying
> backing images themselves is that we flatten all the backing chain
> during the copy ("sync":"full"). In this mode we'll need to do some
> merging of the bitmaps prior to finalizing the copy.
> 
> It's not a problem to do it ourselves, but in the end we'll need to copy
> only certain bitmaps which will be created temporarily on the source to
> the destination where they'll be persisted.
> 
> For now (until I implement the use of the dirty-bitmap-populate blockjob
> which I'm also doing in parallel with this kind of) when creating a
> snapshot we create a new active bitmap in the overlay for every active
> bitmap in the snapshotted image.
> 
> When flattening we'll then need to merge the appropriate ones. As said
> it's not a problem to prepare all the bitmaps before but we then don't
> need to migrate all of them.
> 
> By the way, that brings me to another question:
> 
> Is there any difference of handling of persistent and non-persistent
> bitmaps? Specifically I'm curious what's the correct approach to do the
> shared storage migration case when the source and destination image is
> the same one. Should we also instruct to migrate the active ones? or are
> they migrated by writing them to the image and reloading them?

About migration of persistent bitmaps with shared storage: both variants are possible:

1. if you do nothing (i.e. not enable bitmaps migration capability), persistent bitmaps are stored on inactivation of source Qemu and loaded on activation of target Qemu

2. if you enable bitmap migration capability, then bitmaps are _NOT_ stored, they migrate through migration channel

The difference is in downtime: if we have a lot of bitmap data (big disks, small bitmap granularity, a lot of bitmaps) and/or slow shared storage, then with [1] downtime will increase, as we'll have to store all bitmaps to the disk and load them during migration downtime. With [2] bitmaps migrate in postcopy time, when target is already running, so downtime is not increased.

So, in general [2] is better, and I think we should always use it, not making extra difference between shared and non-shared migration.

==

And in this way, no difference between persistent and non-persistent bitmaps migration, let's always migrate them by postcopy [and we go this way (I hope ;) in Virtuozzo]

> 
>> +##
>> +# @migrate-set-bitmap-node-mapping:
> 
> qemu-5.0 deprecated a bunch of migrate-set- specific commands in favor
> of migrate-set-parameters. Is it worth/necessary to add a new command
> here?

Hmm probably, we should include mapping into MigrateSetParameters structure?

> 
>> +#
>> +# Maps block node names to arbitrary aliases for the purpose of dirty
>> +# bitmap migration.  Such aliases may for example be the corresponding
>> +# node names on the opposite site.
>> +#
>> +# By default, every node name is mapped to itself.
>> +#
>> +# @mapping: The mapping; must be one-to-one, but not necessarily
>> +#           complete.  Any mapping not given will be reset to the
>> +#           default (i.e. the identity mapping).
>> +#
>> +# Since: 5.1
>> +##
> 
> 


-- 
Best regards,
Vladimir

