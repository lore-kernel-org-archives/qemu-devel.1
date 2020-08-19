Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB188C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ADC206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wEbaL0o5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ADC206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Lcc-0003Xo-La
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Lbh-0002j3-La; Wed, 19 Aug 2020 06:46:13 -0400
Received: from mail-vi1eur05on2102.outbound.protection.outlook.com
 ([40.107.21.102]:38625 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Lbd-0003R4-KE; Wed, 19 Aug 2020 06:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfJYRDbIHxYYDZogoEs+TkamTK7F6yW5l3N6E7wBvuiltoIkPzinFMHoE9R9bCZQze6r2GReooloDWGxcDdgGwUe1o9Zv/kIk2mdTlBqh54sDpp1qHTnD2eeo0PeAp/A+15ftFcddfrhM/J5lm//xOCZGK+3/Bdqv1BGO4QXQZftiIsZs2crwB64YdVGFQV7/5eqjzOMs4OsHIxdjLPrK6X4iml7TDLajAjzmKUjITO+K1bOVythpYwvdSX+rzIIF51iDVbjr5/g1aWcsKWYxn957p/wLbyTjVBIiPOxYQZp2arpxav8r0uvZn8Vy1IvhJ3o2nMyjc40fhvG8NXEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrwvez523lQiWPhgB8z99iei9PKIy9Pood3/fX9zmuI=;
 b=fw+Ci0Bug4ROzNlcJBIJxKSg5Hk+L3oN3bYt9Kl8tjtylyxCQmMuJ2ZX0Mxpx60u8pWf1XsdSv1MgQiUf0BG+9VbAW2yTjf/EsEnqhIBp/rPipkTwch+JZ35lxjrZAu1A3EoHEXW9et+s1FPqwYTSg6tFY9c3Hh8IaojfTUYcgFbGoDeFNlUjLCwUw4JEj7SC0Qp6uh2NafOhSti/NUocmMrXJopg1CRZRX7R+TxFJ0c5YEfvJsZWzZ5+CNDAr6r2APf9fVZ+9HuIK3lCP4lDFUHsya/uOTvOhdXEskIRHfpNskYffQQXl1FBShZJARD/V684fb3uSoJBx/9CQsNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrwvez523lQiWPhgB8z99iei9PKIy9Pood3/fX9zmuI=;
 b=wEbaL0o5VPaWmtPrP7Hi6pGeM7BimAoPEHuh3K4bPtN1ITLANl+0SmEwxFJa3HBmzUU+vFOfQ9RlNh3WIX3UrSkZJrYd0liYQ180oj+k9/drK6Ew5ajI4+0Tsa+O/zdP9dyJP87/LWfNS3+87qiJ1zs7YZdapqpdHyrMger4h6w=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Wed, 19 Aug
 2020 10:46:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 10:46:06 +0000
Subject: Re: [PATCH v6 4/4] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6bb4c66e-fb52-c947-1ef2-64a060a92db3@virtuozzo.com>
Date: Wed, 19 Aug 2020 13:46:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1597785880-431103-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.13 via Frontend Transport; Wed, 19 Aug 2020 10:46:05 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8505e0c-fbf6-4f8c-b942-08d8442d132d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54930B7B8294524DB96D9B95C15D0@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgUbY4gSOolYgH4Bhkwm4ijRF+HzOKl5wJaTRPPrEDTA1nknOVQt1HQFHfUugTPta6+wWr/j/dZFDfEVf/v3y5/4Cz1ar2v31G+EooVxNinpBIawr6QeW09gOHucfVcWgPhmbmJPMvQr4ByyRP3oWNYAqOU1uxls9N0YChtw7/lJcUMegGVWHUdaeiPa9xyO/aA72Q16Uo33lyl18V6yS7GlHAFalqbYXgNmKVXaK9uJ23hPJnSDGH/I2QJ8RwNFvI3tKBzPPTmYpd3oB953hMSO9oJ/mus8TiY32mhDtUIwxYRqC7P2SopDKW5c8172a6KZTqBuh9W2SRiP7NCJOlc2WG/aoUqadbdiHWrGBHtfdz8H72sMpRdqAfKFWCek
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39840400004)(366004)(346002)(396003)(478600001)(83380400001)(2906002)(16576012)(30864003)(52116002)(31696002)(26005)(186003)(956004)(2616005)(36756003)(8936002)(31686004)(4326008)(316002)(6486002)(5660300002)(16526019)(86362001)(66556008)(107886003)(66946007)(8676002)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OW8Y9pQ4uw9YdZQ35X9nkM8MtXZf27tvH+icCQ0npq/jdFnNpwTYBGYJsaZaGmc3N6r+10VbrUrwF0jse+6vOXYXGukHXz4lWF8ySWY9mqXvQJt9tAJMqoduNaQHOi2nZAiBCbzsPG0Y1vWQzuiciQkF1YgBR/CltiXOcrtO3W4OdVVaAvPi6hHnmfPhFQNWAbjhn8ik4qNClohCb/zr3Nvf52QRwOd/zJRrZfbnjttQYRMKfgrnItYF2UfUo38pbQFCCiP1NUivY8uh3Fx2PXcnLl32UY+FccuvOYmfc2Rncin/gnat+OOwEPmOBO3SSuL2rsGO+BKSIKiSJ2XmS7EiQp6Vvp/juOBOyKh8sBHZ4lnOTr4iKHTGWdeLOFnaXv3qnfYVJoYIkJcaTVOR1wdiQhQck1SXqNm8eowe7/TNuDPqHUcbbDZjkeUTFNNMc63qcyktmbkgckDCXnmRQA1tJHv4xslSUEqRIY/6IX1OTVCSqgtyih0c/4xn6exGerVpywGSPL6IFgoxcclnAdHLZfaHXyAYQ4Qk6zBtDvqJZvzaWDEFXUtCI9BS+XNABzdbq43YcO0KkkIZHh+pZEyurfNrCznaWZhlMd35fADp4zwdVM9RuAC32697lRB+CLYyIVN2xBztcfTjUDmyCQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8505e0c-fbf6-4f8c-b942-08d8442d132d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 10:46:06.0190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIBZYtP9DpYZg3/PpyrlXZlYZlj07x69pul9jyOLiJv2TvV23y4ln2pRNBkC6B1WdgIht2OLXs/QdHhTXBGqTPl1EVgKTBU3B2sHUuB6vgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.21.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:46:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 00:24, Andrey Shinkevich wrote:
> The patch completes the series with the COR-filter insertion to any
> block-stream operation. It also makes changes to the iotests 030.
> The test case 'test_stream_parallel' was deleted due to multiple
> errors.

"case deleted due to errors" is a bad reasoning.

If you remove the case, you should give detailed explanation, why it is
removed, what is the problem with it, what are the consequences, what is
not supported anymore.

Also, good to note here, that adding a filter here makes possible to
implement discarding already copied regions from backing files during
the job, to reduce disk over-usage.

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c             | 76 ++++++++++++++++++++++++++++++++--------------
>   tests/qemu-iotests/030     | 50 +++---------------------------
>   tests/qemu-iotests/030.out |  4 +--
>   3 files changed, 61 insertions(+), 69 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 8bf6b6d..0b11979 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -19,6 +19,7 @@
>   #include "qapi/qmp/qerror.h"
>   #include "qemu/ratelimit.h"
>   #include "sysemu/block-backend.h"
> +#include "block/copy-on-read.h"
>   
>   enum {
>       /*
> @@ -33,8 +34,11 @@ typedef struct StreamBlockJob {
>       BlockJob common;
>       BlockDriverState *base_overlay; /* COW overlay (stream from this) */
>       BlockDriverState *above_base;   /* Node directly above the base */
> +    BlockDriverState *cor_filter_bs;
> +    BlockDriverState *target_bs;
>       BlockdevOnError on_error;
>       char *backing_file_str;
> +    char *base_fmt;
>       bool bs_read_only;
>       bool chain_frozen;
>   } StreamBlockJob;
> @@ -53,34 +57,26 @@ static void stream_abort(Job *job)
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>   
>       if (s->chain_frozen) {
> -        BlockJob *bjob = &s->common;
> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
> +        bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>       }
>   }
>   
>   static int stream_prepare(Job *job)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
> -    BlockJob *bjob = &s->common;
> -    BlockDriverState *bs = blk_bs(bjob->blk);
> +    BlockDriverState *bs = s->target_bs;
>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>       Error *local_err = NULL;
>       int ret = 0;
>   
> -    bdrv_unfreeze_backing_chain(bs, s->above_base);
> +    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>       s->chain_frozen = false;
>   
>       if (bdrv_cow_child(unfiltered_bs)) {
> -        const char *base_id = NULL, *base_fmt = NULL;
> -        if (base) {
> -            base_id = s->backing_file_str;
> -            if (base->drv) {
> -                base_fmt = base->drv->format_name;
> -            }
> -        }
>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
> -        ret = bdrv_change_backing_file(unfiltered_bs, base_id, base_fmt);
> +        ret = bdrv_change_backing_file(unfiltered_bs, s->backing_file_str,
> +                                       s->base_fmt);
>           if (local_err) {
>               error_report_err(local_err);
>               return -EPERM;
> @@ -94,7 +90,9 @@ static void stream_clean(Job *job)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockJob *bjob = &s->common;
> -    BlockDriverState *bs = blk_bs(bjob->blk);
> +    BlockDriverState *bs = s->target_bs;
> +
> +    bdrv_cor_filter_drop(s->cor_filter_bs);
>   
>       /* Reopen the image back in read-only mode if necessary */
>       if (s->bs_read_only) {
> @@ -104,13 +102,14 @@ static void stream_clean(Job *job)
>       }
>   
>       g_free(s->backing_file_str);
> +    g_free(s->base_fmt);
>   }
>   
>   static int coroutine_fn stream_run(Job *job, Error **errp)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockBackend *blk = s->common.blk;
> -    BlockDriverState *bs = blk_bs(blk);
> +    BlockDriverState *bs = s->target_bs;
>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>       bool enable_cor = !bdrv_cow_child(s->base_overlay);
>       int64_t len;
> @@ -231,6 +230,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
>       BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>       BlockDriverState *above_base;
> +    BlockDriverState *cor_filter_bs = NULL;
> +    char *base_fmt = NULL;
> +
> +    if (base && base->drv) {
> +        base_fmt = g_strdup(base->drv->format_name);
> +    }
>   
>       if (!base_overlay) {
>           error_setg(errp, "'%s' is not in the backing chain of '%s'",
> @@ -264,17 +269,36 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>           }
>       }
>   
> -    /* Prevent concurrent jobs trying to modify the graph structure here, we
> -     * already have our own plans. Also don't allow resize as the image size is
> -     * queried only at the job start and then cached. */
> -    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
> -                         basic_flags | BLK_PERM_GRAPH_MOD,
> -                         basic_flags | BLK_PERM_WRITE,
> +    cor_filter_bs = bdrv_cor_filter_append(bs, filter_node_name, errp);
> +    if (cor_filter_bs == NULL) {
> +        goto fail;
> +    }
> +
> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {
> +        bdrv_cor_filter_drop(cor_filter_bs);
> +        cor_filter_bs = NULL;
> +        goto fail;
> +    }
> +
> +    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
> +                         BLK_PERM_CONSISTENT_READ,
> +                         basic_flags | BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD,
>                            speed, creation_flags, NULL, NULL, errp);
>       if (!s) {
>           goto fail;
>       }
>   
> +    /*
> +     * Prevent concurrent jobs trying to modify the graph structure here, we
> +     * already have our own plans. Also don't allow resize as the image size is
> +     * queried only at the job start and then cached.
> +     */
> +    if (block_job_add_bdrv(&s->common, "active node", bs,
> +                           basic_flags | BLK_PERM_GRAPH_MOD,
> +                           basic_flags | BLK_PERM_WRITE, &error_abort)) {
> +        goto fail;
> +    }
> +
>       /* Block all intermediate nodes between bs and base, because they will
>        * disappear from the chain after this operation. The streaming job reads
>        * every block only once, assuming that it doesn't change, so forbid writes
> @@ -294,6 +318,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>   
>       s->base_overlay = base_overlay;
>       s->above_base = above_base;
> +    s->cor_filter_bs = cor_filter_bs;
> +    s->target_bs = bs;
> +    s->base_fmt = base_fmt;

it's wrong to keep base_fmt during the job, as base may change

>       s->backing_file_str = g_strdup(backing_file_str);
>       s->bs_read_only = bs_read_only;
>       s->chain_frozen = true;
> @@ -307,5 +334,10 @@ fail:
>       if (bs_read_only) {
>           bdrv_reopen_set_read_only(bs, true, NULL);
>       }
> -    bdrv_unfreeze_backing_chain(bs, above_base);
> +    if (cor_filter_bs) {
> +        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
> +        bdrv_cor_filter_drop(cor_filter_bs);
> +    } else {
> +        bdrv_unfreeze_backing_chain(bs, above_base);
> +    }
>   }
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 1cdd7e2..fec9d89 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -221,60 +221,20 @@ class TestParallelOps(iotests.QMPTestCase):
>           for img in self.imgs:
>               os.remove(img)
>   
> -    # Test that it's possible to run several block-stream operations
> -    # in parallel in the same snapshot chain
> -    def test_stream_parallel(self):
> -        self.assert_no_active_block_jobs()
> -
> -        # Check that the maps don't match before the streaming operations
> -        for i in range(2, self.num_imgs, 2):
> -            self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i]),
> -                                qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', self.imgs[i-1]),
> -                                'image file map matches backing file before streaming')
> -
> -        # Create all streaming jobs
> -        pending_jobs = []
> -        for i in range(2, self.num_imgs, 2):
> -            node_name = 'node%d' % i
> -            job_id = 'stream-%s' % node_name
> -            pending_jobs.append(job_id)
> -            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=512*1024)
> -            self.assert_qmp(result, 'return', {})
> -
> -        for job in pending_jobs:
> -            result = self.vm.qmp('block-job-set-speed', device=job, speed=0)
> -            self.assert_qmp(result, 'return', {})
> -
> -        # Wait for all jobs to be finished.
> -        while len(pending_jobs) > 0:
> -            for event in self.vm.get_qmp_events(wait=True):
> -                if event['event'] == 'BLOCK_JOB_COMPLETED':
> -                    job_id = self.dictpath(event, 'data/device')
> -                    self.assertTrue(job_id in pending_jobs)
> -                    self.assert_qmp_absent(event, 'data/error')
> -                    pending_jobs.remove(job_id)
> -
> -        self.assert_no_active_block_jobs()
> -        self.vm.shutdown()
> -
> -        # Check that all maps match now
> -        for i in range(2, self.num_imgs, 2):
> -            self.assertEqual(qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i]),
> -                             qemu_io('-f', iotests.imgfmt, '-c', 'map', self.imgs[i-1]),
> -                             'image file map does not match backing file after streaming')
> -
>       # Test that it's not possible to perform two block-stream
>       # operations if there are nodes involved in both.
>       def test_overlapping_1(self):
>           self.assert_no_active_block_jobs()
>   
>           # Set a speed limit to make sure that this job blocks the rest
> -        result = self.vm.qmp('block-stream', device='node4', job_id='stream-node4', base=self.imgs[1], speed=1024*1024)
> +        result = self.vm.qmp('block-stream', device='node4',
> +                             job_id='stream-node4', base=self.imgs[1],
> +                             filter_node_name='stream-filter', speed=1024*1024)
>           self.assert_qmp(result, 'return', {})
>   
>           result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
>           self.assert_qmp(result, 'error/desc',
> -            "Node 'node4' is busy: block device is in use by block job: stream")
> +            "Node 'stream-filter' is busy: block device is in use by block job: stream")
>   
>           result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3', base=self.imgs[2])
>           self.assert_qmp(result, 'error/desc',
> @@ -287,7 +247,7 @@ class TestParallelOps(iotests.QMPTestCase):
>           # block-commit should also fail if it touches nodes used by the stream job
>           result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[4], job_id='commit-node4')
>           self.assert_qmp(result, 'error/desc',
> -            "Node 'node4' is busy: block device is in use by block job: stream")
> +            "Node 'stream-filter' is busy: block device is in use by block job: stream")
>   
>           result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[1], top=self.imgs[3], job_id='commit-node1')
>           self.assert_qmp(result, 'error/desc',
> diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
> index 6d9bee1..5eb508d 100644
> --- a/tests/qemu-iotests/030.out
> +++ b/tests/qemu-iotests/030.out
> @@ -1,5 +1,5 @@
> -...........................
> +..........................
>   ----------------------------------------------------------------------
> -Ran 27 tests
> +Ran 26 tests
>   
>   OK
> 

If we are going to drop this case.. Maybe, we should revert c624b015bf14f "block/stream: introduce a bottom node"? I see now, that it was bad idea..


-- 
Best regards,
Vladimir

