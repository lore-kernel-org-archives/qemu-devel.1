Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1720FC2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B76204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cnZX/KNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B76204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYs2o-00054p-0L
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYs24-0004D2-Ma; Wed, 13 May 2020 10:06:48 -0400
Received: from mail-eopbgr140109.outbound.protection.outlook.com
 ([40.107.14.109]:19374 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYs22-0004P8-KV; Wed, 13 May 2020 10:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C53H1f51lxjJDl23ubutflKKgAQ+FzPeFt8vVNfaNMic+xQn4wMV6556aGXxQoloXjTdiDlHxKP0XDP4A2ivL7tKGqqixyGhXqQwuj6Ihv9Uwtx+j0e/U3/VP2SqCY/ShSucyIA2KNFBIiRID50/6YgFBH4byCwa659DzaepT1nCWXbiC0FAOnEEca/QAJFIAMnMypKSgYJIFVqff0hEtKXeR6Baa8kgZoGA+/VnjygA0TfcYAltqQ9Ye/d2S+1hvPFv48VVeaHFsUREXEnz5y4PpFxFGZM6tszOlS4tW0UBUXvMsWNFj03Sh7Z1zlI2XkBT5zaFHl0buvYnmNbuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Fg6me6POE8y2OIOtS392ztnSB4eMyyx8cJlZ8WAxQ=;
 b=M14ZchpDc8GaigAAxElU+NgDUJ0WxYuxWozr65fpCj5A/CqU7r7R7U7Vk7Cm4JR7HTRRFpOwr3QDlIb0vt0j5gTR/rZtcijJ7TaINVBEP1umMMCEAyE+kU5ceFZrIdUutEz/qJibcbhPvwG+ZCnk7BkTR+PpAt7ESTAH16ZrrGu+U2fuqneobtucTVRAkCDHSNXO3Ehq3vtNLIyBg2mJee6OVTiqQJW7H6hbszofZlMje/230SzCekK96WL0ye/5NDAMcNSyw9uZQBv8VVM3J9koYJZTgF8TmiHr9gOvXZsH9kvy2xOg++jwBc4WpGAWSk86DdLvh6Vt1ejJCmwABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Fg6me6POE8y2OIOtS392ztnSB4eMyyx8cJlZ8WAxQ=;
 b=cnZX/KNsTZF8guEGSGGN9RBH/02+AnlN3vW3VMaIVCPUGi3t5ZZY178NoX/neRtkZPf1+Ve2vyk+QYZ1DYu52NWhvLs0JuMAutUiQ7DgBcJwXEuwBn6At5vB/rbEBty3KW2L0aNrNlroThKCv0y+zdqIXCIjlsFArHZWjBDjN+M=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 14:06:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 14:06:43 +0000
Subject: Re: [PATCH v4 00/15] Apply COR-filter to the block-stream permanently
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <25e15785-97d9-ae94-a7c4-88a4e699af75@virtuozzo.com>
Message-ID: <5125a69e-9ed9-3f93-d468-1a13061b0504@virtuozzo.com>
Date: Wed, 13 May 2020 17:06:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <25e15785-97d9-ae94-a7c4-88a4e699af75@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 14:06:42 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360c86f4-c72a-4552-9a11-08d7f746dd75
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536646D82B000FF911A92484C1BF0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aT92MvJhuSc7NzYTEpILcPTs6OLxEj33n4bEENeu0g2uMiR5ZJcO0/3zbJPLWEsSEA6si1SL749+gNGZlr9WnntoQPqSWCr0fc2UMswNiNp4xmIgiPlZcTGVRe+yEoNJ2/uO0qT8UD0G5+7ShBFTpktqjPQDFCajBG0qTAjqlejrxydMY0ioBA/bzPX69OE8GC4coNVKenoSMV78YY68V6JsQnx8GuH85m6C3XBzL6ZQDfW29lT9aWNN5ZfqLG8gSPDd39UO/JwKRJ7W6/9YuJKR31ceOeWjAnofFIIq2HU3S1wp1TO6WCJxZF+/m2sWaatcE5ATwSvoIOC5QiHdIomEHLbMOm87diRtDkjw4NNDzWoHnT8g5mEFGZs9MKDnIitJU+xHT4PSVaGdWP72qdiN7rloVJSX05l30Z4IZgqStIFw0HyYElxRoaP59sR/9jOro6xddJK8MfFHr0xCdHV6sC2LgyU/GBnbf4blO1dEMgbKbjH5v+TErT8LrWqVViJbLqk4ayOEL3huzBK6DMgyalRdRE46iJpW05lIgDVThaBakT7qSqThE+MBurT3zxkfJySvwS7buYJmXkKVNNv7JCtfA1w9P4Msn/hWdf+4qzVnlUzpRinjdKoz2mVY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39840400004)(33430700001)(52116002)(2616005)(186003)(956004)(31696002)(966005)(86362001)(26005)(33440700001)(2906002)(5660300002)(478600001)(316002)(16576012)(8936002)(16526019)(8676002)(107886003)(4326008)(36756003)(66556008)(6486002)(66476007)(31686004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kPazQcDKa+6/B5G/dSSi7aY5Bd9JCS4GPA+Y3j84u9DKFrH7cHeJzr7aaZSvYINEoRUrxI+8zLFGWGtsgthEK1PAButE9b7nVE0JPHTcCCJ8KljEJDtzdUmMIYcwx599JiQY05QUeNiBlWfKRbd/qNNjWHtn+ecQfFGdZCBOozBgz0XmX1s69dIShOHOWgnVaOPT1BqgS6EKaCsYYSLpqrhZfPOxhDdQBMP4r+tW8hd1yWrMYwQB5yemvDqN9rw25NDkMmjoc2Wo6ap4zIJ9nV/TfFAflokLB9FMvgutI1g2OLhMBBedajC/vpoyO7yJPnLFUW8+hjg5UbBNUxBfY9fB5k9ziRB/THjjcfhwJ+t12WPw7Y6ceOqIIoaDOjP3ib5iAjx4XrSl+OHm3fzAqWk63QUJOdm02gzrQzjyIyPlmrpb7kOPfN05vIeSZGg26Q1fyJGt6lorbSDSP1oQ44/fJw9bKQP93181vD7+/L8nTCvXA0bS01eqpC3noTmH
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c86f4-c72a-4552-9a11-08d7f746dd75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 14:06:43.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36leqR+LVjaMGwBS21CWJ9ArvBNatwLpn+AwpN6nwn/yywhRdCpF6SV85xG6JiU2H6bMNfWq4OULPhSJoO+RLQxKwey79CXmhliYhchobbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.14.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 10:06:44
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
Cc: kwolf@redhat.com, fam@euphon.net, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.05.2020 20:56, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2020 19:50, Andrey Shinkevich wrote:
>> With this series, all the block-stream COR operations pass through
>> the COR-filter. The patches 01-08/15 are taken from the series
>> "block: Deal with filters" by Max Reitz, the full version of that
>> can be found in the branches:
>>
>>        https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
>>        https://github.com/XanClic/qemu child-access-functions-v6
>>
>>        When running iotests, apply "char-socket: Fix race condition"
>>        to avoid sporadic segmentation faults.
>> v4:
>>    01: Initialization of the COR-filter BDRVStateCOR member.
> 
> Hmm... but 01 doesn't touch COR-filter
> 
>>
>> v3:
>>    01: The COR filter insert/remove functions moved to block/copy-on-read.c
>>        to be a part of API.
>>    02: block/stream.c code refactoring.
>>    03: The separate call to block_job_add_bdrv() is used to block operations
>>        on the active node after the filter inserted and the job created.
>>    04: The iotests case 030::test_overlapping_4 was modified to unbound
>>        the block-stream job from the base node.
>>    05: The COR driver functions preadv/pwritev replaced with their analogous
>>        preadv/pwritev_part.
> 
> I assume, these changes are about your patches, which are 09-15, and Max's patches
> are unchanged, right?
> 
>>
>> v2:
>>    01: No more skipping filters while checking for operation blockers.
>>        However, we exclude filters between the bottom node and base
>>        because we do not set the operation blockers for filters anymore.
>>    02: As stated above, we do not set the operation blockers for filters
>>        anymore. So, skip filters when we block operations for the target
>>        node.
>>    03: The comment added for the patch 4/7.
>>    04: The QAPI target version changed to 5.1.
>>    05: The 'filter-node-name' now excluded from using in the test #030.
>>        If we need it no more in a final version of the series, the patch
>>        5/7 may be removed.
>>    06: The COR-filter included into the frozen chain of a block-stream job.
>>        The 'above_base' node pointer is left because it is essential for
>>        finding the base node in case of filters above.
>>
>>
>> Andrey Shinkevich (7):
>>    block: prepare block-stream for using COR-filter
>>    copy-on-read: Support change filename functions
>>    copy-on-read: Support preadv/pwritev_part functions
>>    copy-on-read: add filter append/drop functions
>>    qapi: add filter-node-name to block-stream
>>    iotests: prepare 245 for using filter in block-stream
>>    block: apply COR-filter to block-stream jobs
>>
>> Max Reitz (8):
>>    block: Mark commit and mirror as filter drivers
> 
> this is for commit
> 
>>    copy-on-read: Support compressed writes
> 
> for stream
> 
>>    block: Add child access functions
> 
> I do think, that for these series we need only filtered child and nothing more
> 
>>    block: Add chain helper functions
>>    block: Include filters when freezing backing chain
>>    block: Use CAFs in block status functions
>>    commit: Deal with filters when blocking intermediate nodes
>>    block: Use CAFs when working with backing chains
> 
> So, fix stream, commit and some thing used in it.
> 
> 
> Hi Max! Could you take a brief look and say, could we proceed in this way, taking part of your old series? How much it conflicts with your plans?
> 
> Let me clarify. This all is needed, as we have old proposed feature (and patches): discarding blocks from intermediate images during block-stream. It helps to save disk space during stream process. And the correct way to get access to intermediate nodes (to be able to discard from them) is to append a filter. Firstly we proposed our own filter, but that was proposed on list to use existing COR filter for stream and it seemed a correct way. So we are trying to insert this COR filter.
> 
> And the problem with it that without your series it breaks iotest 30, which does different magic with parallel stream and commit on the same backing chain.
> 
> So, it was my proposal to extract something from your series, to make this test work. And the result is here. I thought that the necessary part of your series for stream/commit is smaller.. But still, 8 patches is not too much. The feature for stream is being postponed already for more than a year due to this trouble. We need to proceed somehow. And the feature is useful.
> 
> 

Just ping, to make it above v5. Sorry for accidentally sent v5, Andrey didn't receive my reply on v4 for some email issue. We firstly want to approve general design of the series, let's do it here.

-- 
Best regards,
Vladimir

