Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F86C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E9F23428
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cBJs+d0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E9F23428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmUw8-0008Ax-0k
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 00:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmUvK-0007gz-TI; Sat, 20 Jun 2020 00:16:11 -0400
Received: from mail-eopbgr10125.outbound.protection.outlook.com
 ([40.107.1.125]:1466 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmUvH-0004BQ-3P; Sat, 20 Jun 2020 00:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c08MNUJneaxb9A7l9eJ5spueg4WtM+RuaBnyAhKpMavnlxte6zIJI1zQQUvgW88jcUnvvfYPgeMD62dUxxgLn1lc4Ton/BbqavlughqyQuinrEQJlyjJEY1UNg/QeY8lqIV5ml5qoutdS+nykYTipovE/6Ix6MuXaPuFEJ/C5WU2bHw3mULB0DfHHFd/ZvfXKTwRaLxzvqKl3vzNPOBOM66JdyYwMXTxGswXuQXsRYFQD8RrCVmkyvuJAhs3Zdz7swtj814+ydVTJ0YlzujBQvAaAC3qBlDCnrdtScrh3oEgPZI/UZHBRHBB8wkZC2JEE9dUw1bceZfPH7inRoT6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwW502saWj1Uu5fviL9M8McOqp2+HffuIEGkJHI8fa4=;
 b=kgG6v9bxTOIKYOSHpcjnaJxTTjl0EyugOoPlYsF2Alelq3msdlSXxroTD5YuZmYOnkth8O43OyDRvNjqL3zSEA76HaUqqBoAKmm0ao+Nh79J6qJe+K0YEfzhvK268Lugh/I+HZ9G1IBy2lygVEC38SwGC/tddhplOWVnqYBwqdWoEvbxSHe7zDza0oeTH5JDrltG963hvzbLLIXaGoPX0BwjRUFK4w7OMzXo03h1EYwBrLNZp+mUb0yl9BKINhaLH2ySf8L1lleI1yF2whwnYKCGFtf3Ou2UiULwmf8qzppJ8/m9kfCVjvQyIh7vTBNfXeWlReqnBUDWf3gTWHdNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwW502saWj1Uu5fviL9M8McOqp2+HffuIEGkJHI8fa4=;
 b=cBJs+d0zUyOVg/wc+CVqYtAcFXQbvMr9DV/gqUMKsuKKNPk9gQ+FJp5NwcCH0WqHwjbIiyEBUYKL+QpJrPIG3SEGYExP3kUMxRN6zBocrjko7Mu9YQCCkGfR95K9vNwZ+sd8F02BSwWXbgCmOThQNJo3fG3tlF9LfZdBtV1H3HQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 04:16:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 04:16:03 +0000
Subject: Re: [PATCH v3 1/6] block: add bitmap-populate job
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <074b3859-a6e1-1388-2142-5a7af8ee3fdb@virtuozzo.com>
Date: Sat, 20 Jun 2020 07:16:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200619195621.58740-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:207:1::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.122) by
 AM3PR05CA0095.eurprd05.prod.outlook.com (2603:10a6:207:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 04:16:02 +0000
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daa37c12-1b2f-4dd9-478c-08d814d0a533
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54471371D126FB27554FDCFCC1990@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWOIA4Bulp5DCiKrUYUTGfKIvdmezg+2sn1S8M7tM/cvikJEX4tZXZLx1htXni7fdNmR0iZ+jF4bAvtJnompk0NoU+FCqJAxB6EJR4++n5vsPCSca+qpjrVGJFa9E4O/k6y0W8slzxDJOXoqdYTwF9Okavn+V0oEI0Tyn8Az5eSt1TFiOyMGHRRq/9dtB5O7Nk3B4QY/ji6GsZelVdjLpT4eoUg1ZcDEQU3wNb0toqbGB1BNxp7m7OfxfPAT/4FUKTvkQGa3xkCFvk3saombWXOUc/EJWu12K7yGUan7pNBM00e6YXDKaJSlc8FgxTccntp5h4LFO6JC9Q0mUvERXVjBUeTLyjZY+jCO8p4KIS6JqE2Fx2l0kbDZZs59qP+6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(36756003)(956004)(16526019)(186003)(26005)(31696002)(86362001)(52116002)(83380400001)(2616005)(4326008)(2906002)(31686004)(316002)(16576012)(478600001)(5660300002)(8936002)(8676002)(66476007)(66946007)(6486002)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ngXQzAalMSTlBvAwy5rOtWWXmjYZXQIk34A/XYS8V1Xc5wEGvpIycEqdjo0An3PDVSUhRaWEyYkAY2p/R0Kq470ch8/hVc3S+lIfAMMEI8orv6+hwbA0dIFgOnorQavwz5V9Wc5++khduHg7+nmfZaG6JhZCMTItyh+5HxP27XhPASd3Qo6YtzEzuRaWEwnpy3jJ0slFPpggSAR4TVAA/bhKAkANgGTLTnZuYA9JjyNSXJ0TUXLP9MnCWnUvFVZ8ueOuh94P619ZWD3DdiZ5ld+nJ/Lrs2oRS7JPgf4LH5Qv/xAOusB5qljVkLufGJo6MR0daoSpcZ/0fVU2wLTzJOOrRbwQ/pkKx7ERLwKRwzAGeAYmSZUmLPhnd6sjiqpDJHRXkRUN7DQu/ZPkgwtKLkeNtkZ7HXOp2bDqwestaFyhSTjLHbqBIReY4o58dRBM9WHy1uhJEhBp1gPUxUzHmbCqbRPUFKZsJO8bixKfWTNn0mKnfHCmA44CVDWYzovh
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa37c12-1b2f-4dd9-478c-08d814d0a533
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 04:16:03.2131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah8p+qcXn7kZNfaaY4rU6HwUDHaziDSTw+mZswodS5rQtEB/wp2eliOdntMT9JobNMUPNMdnIU9XBUC4t36sXu4KiCJOvG1YdZtcM4DZj8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.1.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 00:16:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.06.2020 22:56, Eric Blake wrote:
> From: John Snow <jsnow@redhat.com>
> 
> This job copies the allocation map into a bitmap. It's a job because
> there's no guarantee that allocation interrogation will be quick (or
> won't hang), so it cannot be retrofitted into block-dirty-bitmap-merge.
> 
> It was designed with different possible population patterns in mind,
> but only top layer allocation was implemented for now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qapi/block-core.json      |  48 +++++++++
>   qapi/job.json             |   6 +-
>   include/block/block_int.h |  21 ++++
>   block/bitmap-populate.c   | 207 ++++++++++++++++++++++++++++++++++++++
>   blockjob.c                |   3 +-
>   MAINTAINERS               |   1 +
>   block/Makefile.objs       |   1 +
>   7 files changed, 285 insertions(+), 2 deletions(-)
>   create mode 100644 block/bitmap-populate.c
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0e1c6a59f228..a1bcdba04423 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2211,6 +2211,54 @@
>         { 'command': 'block-dirty-bitmap-merge',
>           'data': 'BlockDirtyBitmapMerge' }
> 
> +##
> +# @BitmapPattern:
> +#
> +# An enumeration of possible patterns that can be written into a bitmap.
> +#
> +# @allocation-top: The allocation status of the top layer
> +#                  of the attached storage node.
> +#
> +# Since: 5.1
> +##
> +{ 'enum': 'BitmapPattern',
> +  'data': ['allocation-top'] }
> +
> +##
> +# @BlockDirtyBitmapPopulate:
> +#
> +# @job-id: identifier for the newly-created block job.
> +#
> +# @pattern: What pattern should be written into the bitmap?
> +#
> +# @on-error: the action to take if an error is encountered on a bitmap's
> +#            attached node, default 'report'.
> +#            'stop' and 'enospc' can only be used if the block device supports
> +#            io-status (see BlockInfo).
> +#
> +# @auto-finalize: When false, this job will wait in a PENDING state after it has
> +#                 finished its work, waiting for @block-job-finalize before
> +#                 making any block graph changes.
> +#                 When true, this job will automatically
> +#                 perform its abort or commit actions.
> +#                 Defaults to true.
> +#
> +# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
> +#                has completely ceased all work, and awaits @block-job-dismiss.
> +#                When true, this job will automatically disappear from the query
> +#                list without user intervention.
> +#                Defaults to true.
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'BlockDirtyBitmapPopulate',
> +  'base': 'BlockDirtyBitmap',
> +  'data': { 'job-id': 'str',
> +            'pattern': 'BitmapPattern',
> +            '*on-error': 'BlockdevOnError',
> +            '*auto-finalize': 'bool',
> +            '*auto-dismiss': 'bool' } }
> +

Peter said about a possibility of populating several target bitmaps simultaneously.

What about such a generalized semantics:

Merge all sources to each target

@targets: list of bitmaps to be populated by the job
{ 'struct': 'BlockDirtyBitmapPopulate',
   'data': { <common job fields>,
             'targets': ['BlockDirtyBitmap'],
             'sources': ['BitmapPopulateSource'] } }


@bitmap: specify dirty bitmap to be merged to target bitamp(s)
@node: specify a node name, which allocation-map is to be merged to target bitmap(s)
{ 'alternate': 'BitmapPopulateSource',
   'data': { 'bitmap': 'BlockDirtyBitmap',
             'node': 'str' } }


- so, we can merge several bitmaps together with several allocation maps into several target bitmaps.
(I remember, we also said about a possibility of starting several populating jobs, populating into
  same bitmap, I think it may be substituted by one job with several sources. Still, it's not hard to
  allow to use target bitmaps in a several jobs simultaneously and this is not about the QAPI interface)

Will this simplify things in libvirt?

-- 
Best regards,
Vladimir

