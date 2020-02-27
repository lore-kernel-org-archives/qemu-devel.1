Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8FCC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1464524656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Afyka9jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1464524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ERI-0005Cl-9K
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7EQg-0004jC-U1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7EQe-0002sd-Rl
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:21:58 -0500
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:20290 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7EQZ-0002mB-8y; Thu, 27 Feb 2020 03:21:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbD4MNy2FGnIW1F3lRqF29yOzwadG3ureM7xKcFSO37r5sOeJVhI/r0iW3GWtGe+pdkaawBBfUfMBKkdxjJ9sMl0E84Km65YTjg0UttPVtKexOdyHqy4RW02WBluYb9LQI8sB9QIeEep8BLVKT/B4nSJ6rzvYriuu/KGLU8z3v/SYlDc7ebdHxIP3EWNZY3RLxlC8+L2tuP5rnXAhJGS7P3tWV3UoF1PgwmAMwk8rfesdcCo+39NwVwucdQlmiUmrodeEO/uF2JQ8Hn5+Uti5sObyIrfzewNWCb+w3v0zR+Oq5Su6tgChIFdug82raUQ/dpNU7pOd6G8xPg/+pKqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtUxkDtOMcriPfsY1YeEtRTSiLZs6lqAJbNYASNvCiI=;
 b=T+LNNgNRV8M8FdEs+zXQlA7V/NbnFH4/8PtwTg4ORA+ksrhLWBdsgJQYWPGd4zKCAnDrdR7pszIbKtkmNobgf2pvW1Qp23cviP/d4oPT4x7qfA7YrjE6KSg4Mbl9Tp44tN3KLJ3FSxlvnfih4lP/wQjUctg9eIBKDn99fOWaWQBf/iIo1wvxewhB77AA+5r908h8s5tUVvZJKJfoRk+SVcRuTD40ff+Ab9kam49iA0VUcZ9VhRNa1ufAx6+D8TsYwvqTlHGtrObJrctfLr7OdwbVZJeRjpMduryZP4l5+rT+RlSUaK/8q1oqeb8s0auSkGgOnHSM9D6Jg+B1swCf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtUxkDtOMcriPfsY1YeEtRTSiLZs6lqAJbNYASNvCiI=;
 b=Afyka9jTon7iG4TvUVgZcCfvtLlel5U3kr9KlUB+m14Y3M9acMCvsIMtHYJcgIYgt772tXgRy5fJrMmPZDFkUl/Rz1phx6wz+GLDCJdJZY+uqpkdCv6KhxlRJ5Kygu2vTls4n5vz6sfckYlWzmV39gPcQHOXCqj/BL8sXUeuJYo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5015.eurprd08.prod.outlook.com (10.255.121.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Thu, 27 Feb 2020 08:21:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 08:21:49 +0000
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227112146308
Message-ID: <4ead22d2-bf1e-e4cb-4b41-7e283bbeaa5b@virtuozzo.com>
Date: Thu, 27 Feb 2020 11:21:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-2-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::44)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 08:21:48 +0000
X-Tagtoolbar-Keys: D20200227112146308
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf420de4-213b-4074-6878-08d7bb5e173f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5015A79DC583393166748D29C1EB0@AM6PR08MB5015.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39840400004)(346002)(136003)(396003)(366004)(189003)(199004)(31696002)(86362001)(16576012)(316002)(186003)(19627235002)(2906002)(6486002)(478600001)(8936002)(66476007)(66556008)(66946007)(31686004)(4326008)(30864003)(81156014)(8676002)(81166006)(26005)(52116002)(36756003)(2616005)(5660300002)(16526019)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5015;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TeXr18sWneAotRXHlcahXcpeEfY48L38kHHxC02Yza+PBr/cqgXLkasBxV4/RewfjxfrPcu1nJh9KZbL/3P5z2T4AOrieCpb9S02OizCdGelTBm+Vv+2kRR4LlvhlHomGiRfAn/sXcOcwOIIq43gL63FF5eOa4wwwUaItqfmrPYZ427nnSv4Ni9V8IVpALohW1E8wVwKGYV71flKkcH73JbGbmeQPd6BYrEKK7lUp6VgntfKpbXyg840dvOgeHOw0/nA3MYzBzEAtygh1yo7EOju2T3sWdnPMDf5QahIxKchXuh9qm6PPkHqaVfvazgcOaXwsnAuoqDSb5AZjO5wySTaGnFWK2qTaRZ4xm4RDH+ZQNk21MaFtU0RJWl4Y58ko+guyCMSlRuorpID2zmWy0id049bmv0N1xEF48qIiO+mvrTx1eTLBCe3KJxFNkrQ88bBgvCJKmcHV8EUWDUZ+GotWQsoDcadOyzy6lkLDF2Mwhc/FZaN8ffi82ySwqheslNy6isDJ7Zm8buWyu1SQ==
X-MS-Exchange-AntiSpam-MessageData: X9vzpaPPtGQ4OK9wrjseNH87Uff1SrKfhJaT2qaqTRsu9wkRinlt16an4IrWRKCb3xm3MvkZliOW/EowqSeZHwffJMwd6e1nrtHWf4WJd1+hz2JI6qJoWFwL+4wWOYhrvgGZSfyjBxZyE9JOUtpQ+A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf420de4-213b-4074-6878-08d7bb5e173f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 08:21:48.9444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVbaQaiEPmtr/IeL9gyzfLhkpRsWimLJN4uUOTpHqcUg789buC57eYq9O8FfAQg2ULuNPzrzLW73Q+ZrCtNiEeCkos9ZOdW/PsgJVia6pHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5015
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.117
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 10:29, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to Qcow2 that indicates which allow to use different compression
> methods for image clusters (de)compressing.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
> 
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/qcow2.c             | 105 ++++++++++++++++++++++++++++++++++++++
>   block/qcow2.h             |  31 ++++++++---
>   include/block/block_int.h |   1 +
>   qapi/block-core.json      |  22 +++++++-
>   4 files changed, 150 insertions(+), 9 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3c754f616b..2ccb2cabd1 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

Please, add to .git/config:

[diff]
     orderFile = /path/to/qemu/scripts/git.orderfile

This will force git format-patch to sort files in more comfortable order (header changes first, etc).

> @@ -1242,6 +1242,50 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
>       return ret;
>   }
>   
> +static int validate_compression_type(BDRVQcow2State *s, Error **errp)
> +{
> +    /*
> +     * Sanity check
> +     * according to qcow2 spec, the compression type is 1-byte field
> +     * but in BDRVQcow2State the compression_type is enum sizeof(int)
> +     * so, the max compression_type value is 255.
> +     */
> +    if (s->compression_type > 0xff) {
> +        error_setg(errp, "qcow2: compression type value is too big");
> +        return -EINVAL;
> +    }
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        break;
> +
> +    default:
> +        error_setg(errp, "qcow2: unknown compression type: %u",
> +                   s->compression_type);
> +        return -ENOTSUP;
> +    }


honestly, I think that just

if (s->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
   error out
}

is enough, and don't see why to check > 0xff in separate..

But it works as is.

> +
> +    /*
> +     * if the compression type differs from QCOW2_COMPRESSION_TYPE_ZLIB
> +     * the incompatible feature flag must be set
> +     */
> +    if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
> +        if (s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE) {
> +            error_setg(errp, "qcow2: Compression type incompatible feature "
> +                             "bit must not be set");
> +            return -EINVAL;
> +        }
> +    } else {


This is unreachable now.. But it's OK as preparation for further patches I think.

> +        if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
> +            error_setg(errp, "qcow2: Compression type incompatible feature "
> +                             "bit must be set");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   /* Called with s->lock held.  */
>   static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>                                         int flags, Error **errp)
> @@ -1357,6 +1401,26 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>       s->compatible_features      = header.compatible_features;
>       s->autoclear_features       = header.autoclear_features;
>   
> +    /*
> +     * Handle compression type
> +     * Older qcow2 images don't contain the compression type header.
> +     * Distinguish them by the header length and use
> +     * the only valid (default) compression type in that case
> +     */
> +    if (header.header_length > offsetof(QCowHeader, compression_type)) {
> +        /*
> +         * don't deal with endians since compression_type is 1 byte long
> +         */


this comment would be more appropriate above, where be-to-cpu transformation is done,
as actually previous "s->autoclear_features       = header.autoclear_features" doesn't
deal with endians too.

> +        s->compression_type = header.compression_type;
> +    } else {
> +        s->compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
> +    }
> +
> +    ret = validate_compression_type(s, errp);
> +    if (ret) {
> +        goto fail;
> +    }
> +
>       if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
>           void *feature_table = NULL;
>           qcow2_read_extensions(bs, header.header_length, ext_end,
> @@ -2720,6 +2784,12 @@ int qcow2_update_header(BlockDriverState *bs)
>       total_size = bs->total_sectors * BDRV_SECTOR_SIZE;
>       refcount_table_clusters = s->refcount_table_size >> (s->cluster_bits - 3);
>   
> +    ret = validate_compression_type(s, NULL);
> +
> +    if (ret) {
> +        goto fail;
> +    }
> +
>       *header = (QCowHeader) {
>           /* Version 2 fields */
>           .magic                  = cpu_to_be32(QCOW_MAGIC),
> @@ -2742,6 +2812,7 @@ int qcow2_update_header(BlockDriverState *bs)
>           .autoclear_features     = cpu_to_be64(s->autoclear_features),
>           .refcount_order         = cpu_to_be32(s->refcount_order),
>           .header_length          = cpu_to_be32(header_length),
> +        .compression_type       = (uint8_t) s->compression_type,
>       };
>   
>       /* For older versions, write a shorter header */
> @@ -2839,6 +2910,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                   .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
>                   .name = "lazy refcounts",
>               },
> +            {
> +                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
> +                .bit  = QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
> +                .name = "compression type",
> +            },
>           };
>   
>           ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> @@ -3401,6 +3477,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           .refcount_table_offset      = cpu_to_be64(cluster_size),
>           .refcount_table_clusters    = cpu_to_be32(1),
>           .refcount_order             = cpu_to_be32(refcount_order),
> +        .compression_type           = (uint8_t) QCOW2_COMPRESSION_TYPE_ZLIB,

Hmm. Following qcow2_co_create existing code, you'd better
1. do check compression_type correctnes before header initialization, may be add local  variable
compression_type, don't forget to check version < 3, and here you'll have only
.compression_type = compression_type


>           .header_length              = cpu_to_be32(sizeof(*header)),
>       };
>   
> @@ -3420,6 +3497,26 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>               cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
>       }
>   

2. Here you'll need only set incompatible_features if needed.

> +    if (qcow2_opts->has_compression_type &&
> +        qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
> +
> +        if (qcow2_opts->compression_type > 0xff) {
> +            error_setg_errno(errp, -EINVAL, "Too big compression type value");

I still doubt that we need seperate check for this thing. Moreover, here we can get
only element of enum, so we can do assertion, not if.

> +            goto out;

going out here, you leak header

> +        }
> +
> +        switch (qcow2_opts->compression_type) {
> +        default:
> +            error_setg_errno(errp, -EINVAL, "Unknown compression type");
> +            goto out;
> +        }
> +
> +        header->compression_type = (uint8_t) qcow2_opts->compression_type;
> +
> +        header->incompatible_features |=
> +            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION_TYPE);
> +    }
> +
>       ret = blk_pwrite(blk, 0, header, cluster_size, 0);
>       g_free(header);
>       if (ret < 0) {
> @@ -3602,6 +3699,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
>           { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
>           { BLOCK_OPT_COMPAT_LEVEL,       "version" },
>           { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
> +        { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
>           { NULL, NULL },
>       };
>   
> @@ -4859,6 +4957,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>               .data_file          = g_strdup(s->image_data_file),
>               .has_data_file_raw  = has_data_file(bs),
>               .data_file_raw      = data_file_is_raw(bs),
> +            .compression_type   = s->compression_type,
>           };
>       } else {
>           /* if this assertion fails, this probably means a new version was
> @@ -5516,6 +5615,12 @@ static QemuOptsList qcow2_create_opts = {
>               .help = "Width of a reference count entry in bits",
>               .def_value_str = "16"
>           },
> +        {
> +            .name = BLOCK_OPT_COMPRESSION_TYPE,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Compression method used for image clusters compression",
> +            .def_value_str = "zlib"
> +        },
>           { /* end of list */ }
>       }
>   };
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0942126232..f92412ed5e 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -146,6 +146,12 @@ typedef struct QCowHeader {
>   
>       uint32_t refcount_order;
>       uint32_t header_length;
> +
> +    /* Additional fields */
> +    uint8_t  compression_type;
> +
> +    /* header must be a multiple of 8 */
> +    uint8_t  padding[7];
>   } QEMU_PACKED QCowHeader;
>   
>   typedef struct QEMU_PACKED QCowSnapshotHeader {
> @@ -213,16 +219,20 @@ enum {
>   
>   /* Incompatible feature bits */
>   enum {
> -    QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
> -    QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
> -    QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
> -    QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> -    QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> -    QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
> +    QCOW2_INCOMPAT_DIRTY_BITNR            = 0,
> +    QCOW2_INCOMPAT_CORRUPT_BITNR          = 1,
> +    QCOW2_INCOMPAT_DATA_FILE_BITNR        = 2,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR = 3,
> +    QCOW2_INCOMPAT_DIRTY                  = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> +    QCOW2_INCOMPAT_CORRUPT                = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> +    QCOW2_INCOMPAT_DATA_FILE              = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE       =
> +        1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
>   
>       QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
>                                       | QCOW2_INCOMPAT_CORRUPT
> -                                    | QCOW2_INCOMPAT_DATA_FILE,
> +                                    | QCOW2_INCOMPAT_DATA_FILE
> +                                    | QCOW2_INCOMPAT_COMPRESSION_TYPE,
>   };
>   
>   /* Compatible feature bits */
> @@ -369,6 +379,13 @@ typedef struct BDRVQcow2State {
>   
>       bool metadata_preallocation_checked;
>       bool metadata_preallocation;
> +    /*
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the image
> +     * with the desired compression type set
> +     */
> +    Qcow2CompressionType compression_type;
>   } BDRVQcow2State;
>   
>   typedef struct Qcow2COWRegion {
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6f9fd5e20e..2c6bb9dc99 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -57,6 +57,7 @@
>   #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
>   #define BLOCK_OPT_DATA_FILE         "data_file"
>   #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
> +#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>   
>   #define BLOCK_PROBE_BUF_SIZE        512
>   
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 85e27bb61f..873fbef3b5 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -78,6 +78,8 @@
>   #
>   # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>   #
> +# @compression-type: the image cluster compression method (since 5.0)
> +#
>   # Since: 1.7
>   ##
>   { 'struct': 'ImageInfoSpecificQCow2',
> @@ -89,7 +91,8 @@
>         '*corrupt': 'bool',
>         'refcount-bits': 'int',
>         '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> -      '*bitmaps': ['Qcow2BitmapInfo']
> +      '*bitmaps': ['Qcow2BitmapInfo'],
> +      'compression-type': 'Qcow2CompressionType'
>     } }
>   
>   ##
> @@ -4392,6 +4395,18 @@
>     'data': [ 'v2', 'v3' ] }
>   
>   
> +##
> +# @Qcow2CompressionType:
> +#
> +# Compression type used in qcow2 image file
> +#
> +# @zlib:  zlib compression, see <http://zlib.net/>
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'Qcow2CompressionType',
> +  'data': [ 'zlib' ] }
> +
>   ##
>   # @BlockdevCreateOptionsQcow2:
>   #
> @@ -4415,6 +4430,8 @@
>   #                 allowed values: off, falloc, full, metadata)
>   # @lazy-refcounts: True if refcounts may be updated lazily (default: off)
>   # @refcount-bits: Width of reference counts in bits (default: 16)
> +# @compression-type: The image cluster compression method
> +#                    (default: zlib, since 5.0)
>   #
>   # Since: 2.12
>   ##
> @@ -4430,7 +4447,8 @@
>               '*cluster-size':    'size',
>               '*preallocation':   'PreallocMode',
>               '*lazy-refcounts':  'bool',
> -            '*refcount-bits':   'int' } }
> +            '*refcount-bits':   'int',
> +            '*compression-type': 'Qcow2CompressionType' } }
>   
>   ##
>   # @BlockdevCreateOptionsQed:
> 


-- 
Best regards,
Vladimir

