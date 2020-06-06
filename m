Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0356C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 06:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944FF2073E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 06:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cVHdpRQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944FF2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhSkd-00068y-RG
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 02:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSjh-0005SX-Fm; Sat, 06 Jun 2020 02:55:21 -0400
Received: from mail-eopbgr40099.outbound.protection.outlook.com
 ([40.107.4.99]:54661 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSjf-0004aQ-7u; Sat, 06 Jun 2020 02:55:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfGj03emX9RPKjQhckbg8InZAu1HOQPMnLK9gRJRefR/I1Wn+pe9D52/5Jf9Q3KcyqrSRB++rSEiWgvHIRM6EAc899nVYoZ5vJiLQ8Wwuy5a0YoVj4Rnw9r8nUCx3H2WDACzVlghy8F4u9w3szGGF5mjoHSCiWO32w0RCrWseSRYJSUkkFong2zZUNY1uYtfhLDfo3uysFuwlpgGgbluJX2QKZaeINVndICu9nQnsvzqYrX8Hw625g2Lwer46MWD96HqeBDueygRO6wSfqiyLGXyCB/IPE+lhVdZv7T7QuFQg6JSUHaKD4EpfgD9rQ162AdXdkxqyWRECrnWWjJ7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOw+kfO1cbH050cIELK3k6rdgWkdn1Nd/sWC4nMw63c=;
 b=iHpk07chCp3KYloNb5sb9u7ylO5gAYk/4UTrjnO13LMyqvXwJnxF7KpOkGcswVuWsSGizxHs6K1iY6/uFKTPQI5/OlJz1LchCpP8zf7/PDENQKtPIJDBv8STlCIj1bMe+3L1d1Jez6LrqH7JeBqusolVdWauWVMj+9oOQWX3cuCSs5EsSDusvmr4uBuZDG/EnnZJeCtHr/Ejj8dIEO/LdZlMDZxV96Y1uyvsgYJy4XRKQFAp/RH6l/eniRkjHsa7rhhl/o03zp5DQN/IEJIfiBlq/Z5wm4e5w6bTfuPBgC67ZiLwIlRozjvLqYFjSZYBk1LUlhilrmVioy8TESXrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOw+kfO1cbH050cIELK3k6rdgWkdn1Nd/sWC4nMw63c=;
 b=cVHdpRQx8j4EpgJKM+WQWSn+JtWuBgt1pRPQM4iONZyWpkJtwhw6t+lFc5BNNe/aUOCWNJdBLzKEL0AR939HVE+IjTZ8PT8dI2OO5+1/ONlP8RUiDgCICSFmtHUcJgkiRKW6nrZ7KJtoEI7zoBguJz+NsADEcfAe4SSFHNAU3YU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 06:55:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 06:55:16 +0000
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
To: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
 <20200604091231.GC4512@linux.fritz.box>
 <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
Date: Sat, 6 Jun 2020 09:55:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200605105902.GD22354@angien.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.130) by
 AM0PR10CA0021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Sat, 6 Jun 2020 06:55:15 +0000
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53afbdd9-7e6c-4ba2-2736-08d809e69146
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55268AE8CBC256C3DE28ACE5C1870@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc+tiUfFoyvxwZJQQVac77n1EN46D6MBDFVUoGjgXW3rpkfd321hLpKZgBMG61C0fPvBdoGN2kzZAnucsDyUj0WVmpgJi7++FTGCkUO1U0x0rxXyFM6PjHM1o3idQwmayBDLY4JhPHvaMek8vVhDLqehJIrZqE5Tu33ibQeeLeLbIl4/v7LFA2OLwvj/DwZL0tebaaN/P4FCk9NEOpxNZkFAiBSKl8dh1UVsjgoMonlp7h2Wry+pKstvFveo30sWIrqPa+8kZZ49FJuXLrfypW+83w7J157U/m2ce5n1j0eiWxRRW6ySlg5sGY+chtA90cavHahEr2Bgx4GBH9EXdAciUJZVtUwMYLgoapM+Ha1oz69ZK2dXydahiVQzSsXJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(396003)(346002)(376002)(136003)(366004)(316002)(86362001)(2616005)(956004)(16576012)(26005)(83380400001)(5660300002)(478600001)(110136005)(16526019)(8936002)(186003)(8676002)(52116002)(54906003)(53546011)(7416002)(31686004)(66946007)(66556008)(66476007)(6486002)(36756003)(4326008)(31696002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bgKtjZWt3w+qdcrLGNl4kqiiNV8hbC3/GDureq5yQMsd3OgH+YeIlQxxqDEO8hEgutmQ95eQxUCVG61MBcT+68yeq1GTBgI/0lmAScShB7sTxpsfv5+xHk68ASwOb0SIzB9Szwu269x9MTGXYCT1b3d3qCGNULP64QHCtSM6C8WPgusBAWGf8eYF9ml7sPKBP5KR3hPferO5R7TBPzP2EsBJkzIK3V62UvqogTUB02Cx5O/jLnHSxVCAxk0+vPoRuHyU+CMmSeaPh0u2KcV53hxEgx5J6oHfJ+xEPhdCXm0O2hXG3GPPx4srElh561ISjykQyxdjcIRQP49w4aK53pPHwkvBSr4oNjfcepGuh/UDkadb/P8ntmW58tgFUmgFF366GimT2DNOlsU2KTrUHxgMflv2Z5I6NPqA/NR1rWVTvPM8M7d98duunVG2Cbs8+yt/eXiSKZifOEQ7ag/uQK5bdUr+RVQhqYoL7xOimYszTUiKcqbjtjYgPY5jl0/Q
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53afbdd9-7e6c-4ba2-2736-08d809e69146
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 06:55:15.8452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdNYLo4Y9w+T9k/X+ZiOuaOtWj4FBlRmN3+Nbw0g9n686Mgugo6bhqqt14G+sUVCxaz/8vHCt+F9SdsWM9cgQmtoOTY7fXJj0EmNbg9DR64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.4.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 02:55:17
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.06.2020 13:59, Peter Krempa wrote:
> On Fri, Jun 05, 2020 at 12:07:47 +0200, Kevin Wolf wrote:
>> Am 05.06.2020 um 11:58 hat Peter Krempa geschrieben:
>>> On Fri, Jun 05, 2020 at 11:44:07 +0200, Kevin Wolf wrote:
> 
> [...]
> 
>>> The above was actually inspired by a very recent problem I have in my
>>> attempt to use the dirty bitmap populate job to refactor how libvirt
>>> handles bitmaps. I've just figured out that I need to shuffle around
>>> some stuff as I can't run the dirty-bitmap-populate job while an active
>>> layer commit is in synchronised phase and I wanted to do the merging at
>>> that point. That reminded me of a possible gotcha in having to sequence
>>> the blockjobs which certainly would be more painful.
>>
>> It would probably be good to have not only an iotests case that tests
>> the low-level functionality of the block job, but also one that
>> resembles the way libvirt would actually use it in combination with
>> other jobs.
> 

Hi! Sorry me missing the discussion for a long time.

About new job semantics: if you create temporary bitmaps anyway, I do think that we should allow to populate into target bitmap directly, without creating any internal temporary bitmaps. I suggested it when reviewing v1, John argued for more transaction-like semantics to look like other jobs. Still, we can support both modes if we want.

Allowing to use one target for several populating job is an interesting idea. Current series does "bdrv_dirty_bitmap_set_busy(target_bitmap, true);", which forbids it.. Hmm. If we just drop it, nothing prevents user just remove target bitmap during the job. So, we'll need something like collective-busy bitmap..

> I certainly can document the way we'll use it but that in turn depends
> on how the job behaves.
> 
> With the current state of the job I plan to use it in two scenarios:
> 
> Preface: I'm currently changing libvirt to use one active bitmap per
> checkpoint (checkpoint is name for the point in time we want to take
> backup from). This means that a layer of the backing chain can have
> multiple active bitmaps depending on how many checkpoints were created
> in the current top layer. (previously we've tried to optimize things by
> having just one bitmap active, but the semantics were getting too crazy
> to be maintainable long-term)

Hmm. I had a plan of creating "lazy" disabled bitmaps, to optimize scenario with one active bitmap, so that disabled bitmaps are not loaded into RAM on start, but only on demand. But how to do it with "many active bitmaps" scenario? I don't think that's a good idea.. Possibly, we can implement laziness by internally make only one active bitmap and merge it here and there when you request some active bitmap which we actually didn't load yet..

Could you describe, what is the exact problem with "several disabled - one active" scheme, and how is it solved by "several active"?

> 
> Bitmaps are no longer propagated over to upper layers when creating
> snapshots as we can use block-dirty-bitmap-populate instead.

Unexpected turn. When all this topic only started, it was reasoned more like "if user forget to create bitmap at start, let's help him".. But now it becomes the common scenario. Hmm.

What do you think of granularity? We in Virtuozzo use 1M cluster as a default for qcow2 images. But we use 64k granularity (default) for bitmaps, to have smaller incremental backups. So, this is advantage of creating bitmap over relaying on block-status capturing by block-dirty-bitmap-populate: you don't control dirtiness granularity. So, I think that bitmap propagation, or just creating new dirty bitmap to track dirtiness from start of new snapshot is better.


> 
> 1) backup
> 
> Prior to doing the backup I'm figuring out the final backup bitmap, this
> involves creating a temporary bitmap populated by the job for every
> layer of the backing chain above of the one which contains the bitmap we
> want to take a backup from and then merge all of them together as a base
> for the backup.

(just thinking out loud)

So, assume the sequence top -> middle -> base

If we have a backup, which was done when we were in base, than bitmap is stored in base. And  is loaded, and is active, but don't changes really, as base is opened read-only.]
We merge block-status information of top and middle together with this bitmap, and aggregate difference between last backup and current state.

> 
> 2) blockjobs
> 
> Note: This is currently an outline how the things should be as I've hit
> the snag with attempting to run the population jobs during 'ready' state
> of a active-layer block-commit/blockdev-mirror job only an hour ago and
> I need to change a few things.
> 
> 2.1) active layer block-commit/blockdev-mirror
> 
> When the job reaches 'ready' state I'll create bitmaps in the
> destination/base image of the job for every bitmap in the images
> dropped/merged (we use blockdev-mirror in full-sync mode) by the
> blockjob. This will capture the writes that happen after 'job-complete'.
> 
> The job will then be completed and the 2.2. will be executed as well.

So, the aim is not to miss any new writes after switching to new bs, but do not capture into bitmaps writes which are copying the whole disk during mirror.

> 
> 2.2) non-active commit and also continuation of active layer block-commit/blockdev-mirror
> 
> After the job is completed succesfully I'll create temporary
> non-persistent bitmaps for/in the images removed by the blockjob and
> merge them into the destination image's bitmaps depending on their
> original location in the backing chain so that the bitmap state still
> properly describes which blocks have changed.

I don't follow. How do you populate these new temporary bitmaps? They are empty after creation..

> 
> After that the original images willbe blockdev-del-eted. The above is
> partialy in use today and since the job is already completed also
> requires blockdev-reopen to successfuly write to the bitmaps.
> 
> ----
> 
> While writing the above down I've actually realized that controling the
> destination of the bitmap might not be as useful as I've thought
> originally as in 2.2. step I might need the allocation bitmap merged
> into multiple bitmaps, so I'd either need a temporary bitmap anyways or
> would have to re-run the job multiple times which seems wasteful. I'm no
> longer fully persuaded that adding the 'merge' step to the dirty
> populate blockjob will be the best thing since sliced bread.
> 

What is 'merge' step? Do you mean that populating directly into target bitmap is not really needed?

-- 
Best regards,
Vladimir

