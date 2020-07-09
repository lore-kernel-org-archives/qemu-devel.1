Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB4CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9407B20767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jB3nfcMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9407B20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXvA-0007St-Q2
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtXuN-00072P-A2; Thu, 09 Jul 2020 10:52:19 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:29816 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtXuJ-0005Ej-Sy; Thu, 09 Jul 2020 10:52:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+r/C3nsmloRB8IYoQGO4PxB5JzcAq7tp00bSlQbJlSl5h8iXV340c1MgLwuamy1TP5QOXytBxuN8AWOgoG5otlTUM0DhP2Q0Q0Zgxp/2pH2qIwi1Y4EuDAE+gomJ6VWhWpFX2dpeLI2bR6SmQxz/oFCkWZSNrmXN32R/1uy/Wb7NmmT3rZ8Lx/yZ2k+axAiQlG/05lgT+fXJrYPZzwbzmFZz28zs9N/YOvd/MearK3OzwPb5HuBGETcOVWqI4GpZ59kGhqbzs312+SNAV2nnZDyIj39AapIHMZ+Tv5nnVw76dpzPAJDJqlU7KxHNXa/+nzlNQj/S0zK6tAYa8J0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD6KuYUMTkO8oXG0LzycwZ6BbXbNtiy/1yfsBgXVCso=;
 b=SiLZc5oX/54WStB2wDY/ecZeHyB9v/TnmbbovyDaXrfJxbkV4hsC7XlVhp5HTIXb363SZMKD75Hqf+0M/s42MpNCNrGCkJWyv4UVUYZMdV/BQ1zmw3cCuEl+5svgWm4C18UfQJpzvpMmbvUs+XQWq1NMDrkhpsQa19bz7A6fAULN7nEAWPQGJ9wTCczUc8Z9lwz3ITFFloOVous2OpjyKwIsBKpOf1LoNEGOW/XEP/MoJ7I5bs361hy38bKSoLdA49jbeg/lCSit9EAbvCrnRa+MrW2Jifzo1x2eBlEMa83UI4iJZZm0IdUEjMu/cdnMNCys4cLKvVGtlJE7Qz3Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD6KuYUMTkO8oXG0LzycwZ6BbXbNtiy/1yfsBgXVCso=;
 b=jB3nfcMicQhiu91fG7Ri0DAuQLtq/zbRveTpKtCxXFwKyB0FehIaTmHa432djyVcdgnFanvKCbSi2tc/QWZR7kIDLVawd+LrzxuwscjQ9F81euFi4SpMzil5C1d/W/lfM2tqTVfjLoV/wk/75ZpX73CvtFGbQ4fcvwE0/P3qurw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM5PR0801MB1650.eurprd08.prod.outlook.com (2603:10a6:203:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Thu, 9 Jul
 2020 14:52:12 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 14:52:12 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
Date: Thu, 9 Jul 2020 17:52:09 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-15-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Thu, 9 Jul 2020 14:52:11 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 734b25a6-8edf-466c-e9d8-08d82417a98f
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1650:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16505ADB79B5538F99A01402F4640@AM5PR0801MB1650.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAmxxTGdZAfnkQUHudtV2gXrc8u3W9ZgEs7vT/ds7XZHg2lPICjed0p7Y67JeBEDRz6PFumqB2uYRIQxMMYtxAu82v3utL/aPwcQ0UpTKOpGAYKptVVSBuyC/+5TuV17qoKS+exoX/L7G72AHHV+o0I2i6qeXDFYGBTtM2tSQ417XcOFvoDBn2ITiwTUZMQI6QbiuS+kwJlbjsWhIFwU6cwlX2zloKWtgFI1CVkEaAuPC1i/mOmhHrSidAC3kgd+6c0skfXMdrTu8v7WIA/z5LSFpUHgv5dvOZLURvssQx25cccBJqPZ6p1XdICvdOfvB4igR24b8fBKBD9goxTvzik95MOTM1xC4wlqYqMugw1hWN2G0xNgPgArT0sWaoi7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39840400004)(136003)(6506007)(4326008)(6512007)(66476007)(52116002)(36756003)(66556008)(66946007)(54906003)(316002)(83380400001)(16526019)(6486002)(31686004)(53546011)(2906002)(2616005)(5660300002)(956004)(186003)(478600001)(8936002)(26005)(86362001)(44832011)(31696002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tVw1VezV+awdhM+lwiFnTWEwtSbV4MAGmGN8jwsuGJd2gu/KtIiyQLVc50T5MX9P3iglUaWy/BiRq/TYKUG6l8r3SS24qj9hI9LQREVWzUgBXzaxlUQRDSh9xVS63uypty/951YQihlOLPExNlLKEuFlMOycOjAqsWjQA1AFs1YvuzUk2ajytN0LAWgi3XJ9/omK/rBWZwT0Tmkn/tRC0/w4TPZl8faBwfdy83zJtquMCuvre6k4VJNCfQjfq4VOEPFYfqU5qhvqRh4WeDA2IWnwjkjwk1WlXwTuXbIb8Y3MfFMNSm38dflWGLM3CsnvpzijJToXXljajxeMRjWD74akQlKTdG5HzgtkZyM1mrNzplmwTI9ECX1wod3/FGHi2QeroawKbA7n0kvLFyqysMqBFLSyXiLcmW8fWLyFcauCkdaIn7gWmfJ9NiEfAJ9j5/CkRTpSlE9/V6lBC2g6r6LrIvPIEgmNQ5kWFn9IoddJwrXXKyRIZx9rivn8WmK0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734b25a6-8edf-466c-e9d8-08d82417a98f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 14:52:12.2732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOLOQAgoEl15LOqigoWcMhYhJAAS6eyBL4jJ9NCcP+aL+7tEPlnWo5QQQh+BdIIohJejc9q22QB/gIowQ236tBkLDnCpUx6kxclRCZac+so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1650
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:52:13
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

On 25.06.2020 18:21, Max Reitz wrote:
> Because of the (not so recent anymore) changes that make the stream job
> independent of the base node and instead track the node above it, we
> have to split that "bottom" node into two cases: The bottom COW node,
> and the node directly above the base node (which may be an R/W filter
> or the bottom COW node).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json |  4 +++
>   block/stream.c       | 63 ++++++++++++++++++++++++++++++++------------
>   blockdev.c           |  4 ++-
>   3 files changed, 53 insertions(+), 18 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b20332e592..df87855429 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2486,6 +2486,10 @@
>   # On successful completion the image file is updated to drop the backing file
>   # and the BLOCK_JOB_COMPLETED event is emitted.
>   #
> +# In case @device is a filter node, block-stream modifies the first non-filter
> +# overlay node below it to point to base's backing node (or NULL if @base was
> +# not specified) instead of modifying @device itself.
> +#
>   # @job-id: identifier for the newly-created block job. If
>   #          omitted, the device name will be used. (Since 2.7)
>   #
> diff --git a/block/stream.c b/block/stream.c
> index aa2e7af98e..b9c1141656 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -31,7 +31,8 @@ enum {
>   
>   typedef struct StreamBlockJob {
>       BlockJob common;
> -    BlockDriverState *bottom;
> +    BlockDriverState *base_overlay; /* COW overlay (stream from this) */
> +    BlockDriverState *above_base;   /* Node directly above the base */

Keeping the base_overlay is enough to complete the stream job.

The above_base may disappear during the job and we can't rely on it.

>       BlockdevOnError on_error;
>       char *backing_file_str;
>       bool bs_read_only;
> @@ -53,7 +54,7 @@ static void stream_abort(Job *job)
>   
>       if (s->chain_frozen) {
>           BlockJob *bjob = &s->common;
> -        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
> +        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->above_base);
>       }
>   }
>   
> @@ -62,14 +63,15 @@ static int stream_prepare(Job *job)
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockJob *bjob = &s->common;
>       BlockDriverState *bs = blk_bs(bjob->blk);
> -    BlockDriverState *base = backing_bs(s->bottom);
> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
> +    BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);

The initial base node may be a top node for a concurrent commit job and

may disappear. It is true for the above_base as well.

base = bdrv_filter_or_cow_bs(s->base_overlay) is more reliable.

>       Error *local_err = NULL;
>       int ret = 0;
>   
> -    bdrv_unfreeze_backing_chain(bs, s->bottom);
> +    bdrv_unfreeze_backing_chain(bs, s->above_base);
>       s->chain_frozen = false;
>   
> -    if (bs->backing) {
> +    if (bdrv_cow_child(unfiltered_bs)) {
>           const char *base_id = NULL, *base_fmt = NULL;
>           if (base) {
>               base_id = s->backing_file_str;
> @@ -77,8 +79,8 @@ static int stream_prepare(Job *job)
>                   base_fmt = base->drv->format_name;
>               }
>           }
> -        bdrv_set_backing_hd(bs, base, &local_err);
> -        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
> +        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
> +        ret = bdrv_change_backing_file(unfiltered_bs, base_id, base_fmt);
>           if (local_err) {
>               error_report_err(local_err);
>               return -EPERM;
> @@ -109,14 +111,15 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockBackend *blk = s->common.blk;
>       BlockDriverState *bs = blk_bs(blk);
> -    bool enable_cor = !backing_bs(s->bottom);
> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
> +    bool enable_cor = !bdrv_cow_child(s->base_overlay);
>       int64_t len;
>       int64_t offset = 0;
>       uint64_t delay_ns = 0;
>       int error = 0;
>       int64_t n = 0; /* bytes */
>   
> -    if (bs == s->bottom) {
> +    if (unfiltered_bs == s->base_overlay) {
>           /* Nothing to stream */
>           return 0;
>       }
> @@ -150,13 +153,14 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>   
>           copy = false;
>   
> -        ret = bdrv_is_allocated(bs, offset, STREAM_CHUNK, &n);
> +        ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
>           if (ret == 1) {
>               /* Allocated in the top, no need to copy.  */
>           } else if (ret >= 0) {
>               /* Copy if allocated in the intermediate images.  Limit to the
>                * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
> -            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
> +            ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
> +                                          s->base_overlay, true,
>                                             offset, n, &n);
>               /* Finish early if end of backing file has been reached */
>               if (ret == 0 && n == 0) {
> @@ -223,9 +227,29 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       BlockDriverState *iter;
>       bool bs_read_only;
>       int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
> -    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
> +    BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
> +    BlockDriverState *above_base;
>   
> -    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
> +    if (!base_overlay) {
> +        error_setg(errp, "'%s' is not in the backing chain of '%s'",
> +                   base->node_name, bs->node_name);

Sorry, I am not clear with the error message.

In this case, there is no an intermediate COW node but the base, if not 
NULL, is

in the backing chain of bs, isn't it?

> +        return;
> +    }
> +
> +    /*
> +     * Find the node directly above @base.  @base_overlay is a COW overlay, so
> +     * it must have a bdrv_cow_child(), but it is the immediate overlay of
> +     * @base, so between the two there can only be filters.
> +     */
> +    above_base = base_overlay;
> +    if (bdrv_cow_bs(above_base) != base) {
> +        above_base = bdrv_cow_bs(above_base);
> +        while (bdrv_filter_bs(above_base) != base) {
> +            above_base = bdrv_filter_bs(above_base);
> +        }
> +    }
> +
> +    if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {

When a concurrent stream job tries to freeze or remove the above_base node,

we will encounter the frozen node error. The above_base node is a part 
of the

concurrent job frozen chain.

>           return;
>       }
>   
> @@ -255,14 +279,19 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>        * and resizes. Reassign the base node pointer because the backing BS of the
>        * bottom node might change after the call to bdrv_reopen_set_read_only()
>        * due to parallel block jobs running.
> +     * above_base node might change after the call to
Yes, if not frozen.
> +     * bdrv_reopen_set_read_only() due to parallel block jobs running.
>        */
> -    base = backing_bs(bottom);
> -    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
> +    base = bdrv_filter_or_cow_bs(above_base);
> +    for (iter = bdrv_filter_or_cow_bs(bs); iter != base;
> +         iter = bdrv_filter_or_cow_bs(iter))
> +    {
>           block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
>                              basic_flags, &error_abort);
>       }
>   
> -    s->bottom = bottom;
> +    s->base_overlay = base_overlay;
> +    s->above_base = above_base;

Generally, being the filter for a concurrent job, the above_base node 
may be deleted any time

and we will keep the dangling pointer. It may happen even earlier if 
above_base is not frozen.

If it is, as it here, we may get the frozen link error then.


Andrey

>       s->backing_file_str = g_strdup(backing_file_str);
>       s->bs_read_only = bs_read_only;
>       s->chain_frozen = true;
> @@ -276,5 +305,5 @@ fail:
>       if (bs_read_only) {
>           bdrv_reopen_set_read_only(bs, true, NULL);
>       }
> -    bdrv_unfreeze_backing_chain(bs, bottom);
> +    bdrv_unfreeze_backing_chain(bs, above_base);
>   }
> diff --git a/blockdev.c b/blockdev.c
> index 72df193ca7..1eb0fcdea2 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2515,7 +2515,9 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>       }
>   
>       /* Check for op blockers in the whole chain between bs and base */
> -    for (iter = bs; iter && iter != base_bs; iter = backing_bs(iter)) {
> +    for (iter = bs; iter && iter != base_bs;
> +         iter = bdrv_filter_or_cow_bs(iter))
> +    {
>           if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
>               goto out;
>           }

