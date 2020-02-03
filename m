Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE5C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 17:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3102087E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 17:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RkYrrKBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3102087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyfo1-00042R-0L
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 12:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyfml-0003Qn-5W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyfmj-0005eY-9j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 12:45:23 -0500
Received: from mail-db5eur01on072c.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::72c]:4487
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyfme-0005BQ-4o; Mon, 03 Feb 2020 12:45:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRZT8Dro8uejj1T6iLCFC7Ii7HbJkTREX3TmcMKLh8M44floV4kfUxlxRRyE4WXUe9SC21+CCUyOeW4D25AFhsM8LY825+sgpeMFAd1JLad1nwq1QWbJ5oam6R+mZ+qvwLAWqDJ/6c3dLLGz7fDS98iEbc9dFq8sHdsUgbiVu01UIcNQZ8O3MABYbQAOKC/4UzvTQ58S3nlf0P5GrJ/LIhxwpxtC8k1RlLoShP6lq52pggpmS9YBDxlfWeAY1EXTqYH3lh/z+jzFWF6W0OsRB8UkncGHKQD1HeRBZfbIKXjwLOvmtH/lUQ9bdjz/F9ESW4YI/jYVRGxLkcmi5u/A+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxiT+Zf0yO4E67uWhCmHT1vuwyLLGNFbU1AhzC1zUkM=;
 b=oRZt4pyjJBLTnvjicft2lX4V9cnW/HP1+XnC1qxoanQwA2EfSOiMlpSa5Av1jRgwKRfMBx0utiCO9pLzcyQDFURp9wLP7Dt+P4vHY3h7Q8bagA3ukkhkOAimNR8Qejzr3hkbEkU1iTU/d1w5oz+gkDKah66K3545RuQ0kAr2j6qDgT7yqlopZbHocpAOMPUhNiRuVpGfo5z/+sUwdb9lAV5qOEjeEkSUflnF8FN5JBgiWxqtzVgeLvGfk1ooep5v3kJt43afmcQ8fckEtKCe5EWVxZQvQfIRv/tc1eqfeLB2ik2pEoTmOFBh5o8k25nQRyasyUaFV8ZXWeK7jbJ5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxiT+Zf0yO4E67uWhCmHT1vuwyLLGNFbU1AhzC1zUkM=;
 b=RkYrrKBDYBbOCrDwnPx/QiP9nkjQoN5KVCbeFwtpvpyODRhetFfmDGWSuKqy85UeDXKIFgdLy797C92cKBXLOMCamhjbg+AaM0Iq4fQMdEcout6mULe6l3mzjTyhOJDNEbTTfkTcKZ5WW6W7/w8fqWlpMEl5nRg1rjjAop4kotI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3624.eurprd08.prod.outlook.com (20.177.116.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 17:45:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 17:45:12 +0000
Subject: Re: [PATCH 13/17] qcow2: Add new autoclear feature for all zero image
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-14-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200203204509968
Message-ID: <da530661-a976-35ca-d999-646074b72490@virtuozzo.com>
Date: Mon, 3 Feb 2020 20:45:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0024.eurprd03.prod.outlook.com
 (2603:10a6:3:76::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0024.eurprd03.prod.outlook.com (2603:10a6:3:76::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33 via Frontend Transport; Mon, 3 Feb 2020 17:45:11 +0000
X-Tagtoolbar-Keys: D20200203204509968
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bfa7ef6-ee8c-4a27-2ef1-08d7a8d0d197
X-MS-TrafficTypeDiagnostic: AM6PR08MB3624:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3624442D3F61F709A2A4817AC1000@AM6PR08MB3624.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(478600001)(36756003)(52116002)(31686004)(2906002)(66556008)(5660300002)(66476007)(31696002)(66946007)(86362001)(4326008)(6486002)(54906003)(186003)(316002)(16526019)(16576012)(26005)(81156014)(8676002)(8936002)(2616005)(81166006)(956004)(309714004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3624;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16hJw97qwgx9DExkw61tkPtB2RreE48C+m6+FGYbeJktg5W9qfK2DcJfYIu3Ktn91dhue573f8O8BqTrwhhatIJQa1/YKuJsYxXzcENdku+nNmD8fdAAaz4l7Y4kZt70fhzGl0Eqkw+gXmrQO4D+wYj5M6o/7JAw4W7PMUPnhdNKVUsjVdzcONxOk+VVnPHfiboHlHRSsiX5c7mBICiPUH6A/2guBntTLfKGIsq8VoQgCoPe2OurvDW/IUjtgn0WzYL/rdcT0pYKwpUMm67eu0stgAHUkMkZTDlol5WVbnXpCSsvmamQIs2g7du058DOJ8LHsy48ivE0N/Hwp20tYB0IWrhob00/o7/0M1yqTlV0LKxleO6A/zxkLkGATzujmBP/5xV4F+EIi4dMxDZmfaVml/Ok84av9pqrmyNnaq3vJFXLW+JUyilP5On+DVqF0qCG4mYeZZrlsDgQDIj6gt0PXt89Wcw4Tk7/a359+x4cDWJJB2bZdljT5hMeYfA8
X-MS-Exchange-AntiSpam-MessageData: +sr4nsuSNhua4mkmv94NYCI9rWltKzW6tXzmboU9P+eRHGw6RWfomooKm+21FxEQFqSYyrqEyfoxN9f/w6AMqAqcEosOYxaGfIfpfSwdy4rbLpWYKBSt2Mzrmaojaw6ZrXPkbaK5DF1Q8oMLZiJmNA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfa7ef6-ee8c-4a27-2ef1-08d7a8d0d197
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 17:45:12.1043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZWK+eCuGE4nYa57NZIdosKyfyow7spcxgQ3/dUt68JDcU3VWUzHawdRMJYCUEr/0ApNaQKgcVcF05E2HXFVu9RurnhXZeMzj72bndws3t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3624
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::72c
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> With the recent introduction of BDRV_ZERO_OPEN, we can optimize
> various qemu-img operations if we know the destination starts life
> with all zero content.  For an image with no cluster allocations and
> no backing file, this was already trivial with BDRV_ZERO_CREATE; but
> for a fully preallocated image, it does not scale to crawl through the
> entire L1/L2 tree to see if every cluster is currently marked as a
> zero cluster.  But it is quite easy to add an autoclear bit to the
> qcow2 file itself: the bit will be set after newly creating an image
> or after qcow2_make_empty, and cleared on any other modification
> (including by an older qemu that doesn't recognize the bit).
> 
> This patch documents the new bit, independently of implementing the
> places in code that should set it (which means that for bisection
> purposes, it is safer to still mask the bit out when opening an image
> with the bit set).
> 
> A few iotests have updated output due to the larger number of named
> header features.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> RFC: As defined in this patch, I defined the bit to be clear if any
> cluster defers to a backing file. But the block layer would handle
> things just fine if we instead allowed the bit to be set if all
> clusters allocated in this image are zero, even if there are other
> clusters not allocated.  Or maybe we want TWO bits: one if all
> clusters allocated here are known zero, and a second if we know that
> there are any clusters that defer to a backing image.
> ---
>   block/qcow2.c              |  9 +++++++++
>   block/qcow2.h              |  3 +++
>   docs/interop/qcow2.txt     | 12 +++++++++++-
>   qapi/block-core.json       |  4 ++++
>   tests/qemu-iotests/031.out |  8 ++++----
>   tests/qemu-iotests/036.out |  4 ++--
>   tests/qemu-iotests/061.out | 14 +++++++-------
>   7 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 9f2371925737..20cce9410c84 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2859,6 +2859,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                   .bit  = QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
>                   .name = "raw external data",
>               },
> +            {
> +                .type = QCOW2_FEAT_TYPE_AUTOCLEAR,
> +                .bit  = QCOW2_AUTOCLEAR_ALL_ZERO_BITNR,
> +                .name = "all zero",
> +            },
>           };
> 
>           ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> @@ -4874,6 +4879,10 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>               .corrupt            = s->incompatible_features &
>                                     QCOW2_INCOMPAT_CORRUPT,
>               .has_corrupt        = true,
> +            .all_zero           = s->autoclear_features &
> +                                  QCOW2_AUTOCLEAR_ALL_ZERO,
> +            .has_all_zero       = s->autoclear_features &
> +                                  QCOW2_AUTOCLEAR_ALL_ZERO,
>               .refcount_bits      = s->refcount_bits,
>               .has_bitmaps        = !!bitmaps,
>               .bitmaps            = bitmaps,
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 094212623257..6fc2d323d753 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -237,11 +237,14 @@ enum {
>   enum {
>       QCOW2_AUTOCLEAR_BITMAPS_BITNR       = 0,
>       QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR = 1,
> +    QCOW2_AUTOCLEAR_ALL_ZERO_BITNR      = 2,
>       QCOW2_AUTOCLEAR_BITMAPS             = 1 << QCOW2_AUTOCLEAR_BITMAPS_BITNR,
>       QCOW2_AUTOCLEAR_DATA_FILE_RAW       = 1 << QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
> +    QCOW2_AUTOCLEAR_ALL_ZERO            = 1 << QCOW2_AUTOCLEAR_ALL_ZERO_BITNR,
> 
>       QCOW2_AUTOCLEAR_MASK                = QCOW2_AUTOCLEAR_BITMAPS
>                                           | QCOW2_AUTOCLEAR_DATA_FILE_RAW,
> +    /* TODO: Add _ALL_ZERO to _MASK once it is handled correctly */
>   };
> 
>   enum qcow2_discard_type {
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 8510d74c8079..d435363a413c 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -153,7 +153,17 @@ in the description of a field.
>                                   File bit (incompatible feature bit 1) is also
>                                   set.
> 
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      All zero image bit
> +                                If this bit is set, the entire image reads
> +                                as all zeroes. This can be useful for
> +                                detecting just-created images even when
> +                                clusters are preallocated, which in turn
> +                                can be used to optimize image copying.
> +
> +                                This bit should not be set if any cluster
> +                                in the image defers to a backing file.

Hmm. The term "defers to a backing file" not defined in the spec. And, as I
understand, can't be defined by design. Backing file may be added/removed/changed
dynamically, and qcow2 driver will not know about it. So, the only way to
be sure that clusters are not defer to backing file is to make them
ZERO clusters (not UNALLOCATED). But this is inefficient, as we'll have to
allocated all L2 tables.

So, I think better to define this flag as "all allocated clusters are zero".

Hmm interesting, in qcow2 spec "allocated" means allocated on disk and has
offset. So, ZERO cluster is actually unallocated cluster, with bit 0 of
L2 entry set to 1. On the other hand, qemu block layer considers ZERO
clusters as "allocated" (in POV of backing-chain).

So, if we define it as "all allocated clusters are zero", we are done:
other clusters are either unallocated and MAY refer to backing, so we
can say nothing about their read-as-zero status at the level of qcow2
spec, or unallocated with zero-bit set, which are normal ZERO clusters.

So, on the level of qcow2 driver I think it's better consider only this
image. Still, we can implement generic bdrv_is_all_zeros, which will
check or layers (or at least, check that bs->backing is NULL).


> +
> +                    Bits 3-63:  Reserved (set to 0)
> 
>            96 -  99:  refcount_order
>                       Describes the width of a reference count block entry (width
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ef94a296868f..af837ed5af33 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -71,6 +71,9 @@
>   # @corrupt: true if the image has been marked corrupt; only valid for
>   #           compat >= 1.1 (since 2.2)
>   #
> +# @all-zero: present and true only if the image is known to read as all
> +#            zeroes (since 5.0)
> +#
>   # @refcount-bits: width of a refcount entry in bits (since 2.3)
>   #
>   # @encrypt: details about encryption parameters; only set if image
> @@ -87,6 +90,7 @@
>         '*data-file-raw': 'bool',
>         '*lazy-refcounts': 'bool',
>         '*corrupt': 'bool',
> +      '*all-zero': 'bool',
>         'refcount-bits': 'int',
>         '*encrypt': 'ImageInfoSpecificQCow2Encryption',
>         '*bitmaps': ['Qcow2BitmapInfo']
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 46f97c5a4ea4..bb1afa7b87f6 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -117,7 +117,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   Header extension:
> @@ -150,7 +150,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   Header extension:
> @@ -164,7 +164,7 @@ No errors were found on the image.
> 
>   magic                     0x514649fb
>   version                   3
> -backing_file_offset       0x1d8
> +backing_file_offset       0x208
>   backing_file_size         0x17
>   cluster_bits              16
>   size                      67108864
> @@ -188,7 +188,7 @@ data                      'host_device'
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   Header extension:
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index 23b699ce0622..e409acf60e2b 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -26,7 +26,7 @@ compatible_features       []
>   autoclear_features        [63]
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
> 
> @@ -38,7 +38,7 @@ compatible_features       []
>   autoclear_features        []
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   *** done
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 413cc4e0f4ab..d873f79bb606 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -26,7 +26,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   magic                     0x514649fb
> @@ -84,7 +84,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   magic                     0x514649fb
> @@ -140,7 +140,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   ERROR cluster 5 refcount=0 reference=1
> @@ -195,7 +195,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   magic                     0x514649fb
> @@ -264,7 +264,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   read 65536/65536 bytes at offset 44040192
> @@ -298,7 +298,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   ERROR cluster 5 refcount=0 reference=1
> @@ -327,7 +327,7 @@ header_length             104
> 
>   Header extension:
>   magic                     0x6803f857
> -length                    288
> +length                    336
>   data                      <binary>
> 
>   read 131072/131072 bytes at offset 0
> 


-- 
Best regards,
Vladimir

