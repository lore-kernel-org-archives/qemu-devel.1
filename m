Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A56C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B92207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZKmNMaOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B92207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRcj-0006Eq-1c
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXRbm-0005Ud-AI; Tue, 27 Oct 2020 12:14:02 -0400
Received: from mail-vi1eur05on2095.outbound.protection.outlook.com
 ([40.107.21.95]:37793 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXRbf-0007nQ-JU; Tue, 27 Oct 2020 12:14:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arkhktFYYBBFGjDzkmFilDBBVfs8FYci1pMBBUdmT0yF6dGQK+kcd6gXByDUeZH2NaDv3X2GpI7GW+Ug1ghMCtHfMT/Lmhv2EluT92xC7TYf7ZYNyWwQmPWMQBYzqbtXLRS5Ywozv/9UykaiJ9aC/InxrVWQsdas0WjCHi3U7w8ZQUWdlpFtIGLGdnXsuFzihD0c4QOzlC6d97NZYyMS/a+oJUQf0wyQmfb9c/lb9oKqmEuWVq1hQKiA0G7rSkjHWgyTuxEWvmhgu/ubBNarc6MOB4VpVMkFp3NSpgNJuCN30lL7CouFbE9ZT1rF56j3T30R8FNJcWCXmkWbfYE71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0SlqkaKuuzp8GYyaAsn2NcFiUxCn86e7ktXKsOT3j8=;
 b=XOXJ0lXzHj26aycjmIIPjPnbe5/uw5Apz5I/ckSGa57+KmBRkX/i27ATzC2VbuXyHvE30DbuMHeICL044fzjtNJlxSHPxsLOJzwq48TyYjQ/zh/W4ZOVscojJ5/7MDhz+DJen5j2sVJj5BhWjpw+/U+n8y+QWFWCszC2qK5rL2roJSfKtI7pL/uVy8NV1sQHvMXpczVtQWVPd0FGPhaNiTx/3OxDZFkJ/9wbXy7UAJmklbFtI15YxjOA+gRJA/aRBg/Tsl01yEO2udxboEfzzn+vC4ysjsj1tbu0aUgaChw7q293UNIbOdGHfVV6ZXA0Z/tTDkYT5psaWUkvINWoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0SlqkaKuuzp8GYyaAsn2NcFiUxCn86e7ktXKsOT3j8=;
 b=ZKmNMaOMrLquEnKtssxmju/oxKJeVwDXmqDiC/J1o0Vjdq+75mV9TV2EdjfVgmMx7jpk7twekGSnYjXV/zMzZQtTIGXF7Dapb4B3GjHt15Dtmt2ZIboQuolEAJejKDdj8BZuvE7MIAgNQYHFU285u6mHu8bNzZPd9Nk+9P3rDUU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2685.eurprd08.prod.outlook.com (2603:10a6:802:1d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 16:13:48 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 16:13:48 +0000
Subject: Re: [PATCH v12 14/14] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-15-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a8405ebc-8dc3-4520-1e35-2bae6a962f79@virtuozzo.com>
Date: Tue, 27 Oct 2020 19:13:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-15-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Tue, 27 Oct 2020 16:13:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b525af-5bb1-4cd0-b59d-08d87a934938
X-MS-TrafficTypeDiagnostic: VI1PR08MB2685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB26851ACAD70ED72BC9C6B464C1160@VI1PR08MB2685.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHyqB/iqgyXsiiXgznBkm1QCfNAI3r++L0fK5ktF+i85mNTYVDgUnzexKi6JxyXq3+cruDkcT35IlvbbwM5NhtqYDK8KI31Tp1cSv4Z6J2reilWXDXRjw/8L+B5+QQYhvJzJ6SBsPlVJwXrvWV3I8BjtJpIDQXHzuZFUjFmluV0iWCqIq/6nqgmuV7iiqwpWV80/NbkV2RMD8eztNJ8KyzfnmPgo+upmrSwwLQUQjqkjcKRu3UCTpklyVA6jyaL8OoCnFrrktMOPk48WnE7ef4rmq+PKlD4PtOP/nfwo6qSSBwOdw6R+gwuP2fg0CkRiBYg7dMk0azL+Y+ahOLR+5z2lwS+K+RMms/Jz34j7xwxuSBQadFBIH5rRlZR1EKa8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(396003)(346002)(366004)(136003)(956004)(16526019)(16576012)(2616005)(66946007)(186003)(83380400001)(66476007)(36756003)(66556008)(316002)(30864003)(5660300002)(4326008)(31696002)(2906002)(107886003)(86362001)(478600001)(31686004)(26005)(8676002)(52116002)(6486002)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vk0pUh36bJtzjzLxRAKix95T83FV9lHT9XUkRCN68adIywNDAFirxWxDtKhT9uU+Ap/fE8AiP22meHSqdZ1ur/yCKFTfW4JyCXKd/J4k+qIsMckXYo+/RLEcXsp3yg5IANzYG3+sqfhur1dUrp1fO22CnPBWIhx1DhhpVyU9M2FpIfJvZiVauWHRS9OvcGiqhvj+0BWlctqQKIIn1STTi6keyvR0t24fQgphfwuwdCDAp7k90FFD+lMP5jy79iZLCuHkwZ92C+Sfggs/dAisRqLPRNCA3BVEVjmlMuRt4lK3umOsD/67CIbOHBgB2i+uJYsliJlCJEEPY47uJUBJdaGt6tN1w8GaqpSLBsKgbpXEnLQMgRWP9NgDTo++l3VBQvUiNE6gBcT/zRB4Fw5WZsMzAwx4s8Sq8IfpikaZF5X7tI5YCtMVud80k6hbSnVLByY8i+QQArq70LUuJNMx61Cte4qnY35kGrF7CD+0BQxZq2LjiaTySkDe40iTt8SB5ilAHXlCHZNCJMNuNimnrc4GEigLA4gOjyZJx7VV25GHFx8IDINW6YCKWqlihBBjQAX/RlmZb5Qs3VtPO9NyFGisgKINA3O9pG6sVDOLGghsdTwDTtbSBPS8Iu7TW68WDdBRod9qSouVberLlBilCg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b525af-5bb1-4cd0-b59d-08d87a934938
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 16:13:48.2967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 463FORXbJe3ME8KyM+Z/sb9DbqVVz7986EIZLpZR7eMfRZAyuN0TK8CMq/hXod5fHwYDiZYq6W53heE/dkWLFMPrOd7H3pHaQTFkhZuFr0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2685
Received-SPF: pass client-ip=40.107.21.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:13:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> This patch completes the series with the COR-filter insertion for
> block-stream operations. Adding the filter makes it possible for copied
> regions to be discarded in backing files during the block-stream job,
> what will reduce the disk overuse.
> The COR-filter insertion incurs changes in the iotests case
> 245:test_block_stream_4 that reopens the backing chain during a
> block-stream job. There are changes in the iotests #030 as well.
> The iotests case 030:test_stream_parallel was deleted due to multiple
> conflicts between the concurrent job operations over the same backing
> chain. The base backing node for one job is the top node for another
> job. It may change due to the filter node inserted into the backing
> chain while both jobs are running. Another issue is that the parts of
> the backing chain are being frozen by the running job and may not be
> changed by the concurrent job when needed. The concept of the parallel
> jobs with common nodes is considered vital no more.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c             | 98 ++++++++++++++++++++++++++++++----------------
>   tests/qemu-iotests/030     | 51 +++---------------------
>   tests/qemu-iotests/030.out |  4 +-
>   tests/qemu-iotests/141.out |  2 +-
>   tests/qemu-iotests/245     | 22 +++++++----
>   5 files changed, 87 insertions(+), 90 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 1ba74ab..f6ed315 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -17,8 +17,10 @@
>   #include "block/blockjob_int.h"
>   #include "qapi/error.h"
>   #include "qapi/qmp/qerror.h"
> +#include "qapi/qmp/qdict.h"
>   #include "qemu/ratelimit.h"
>   #include "sysemu/block-backend.h"
> +#include "block/copy-on-read.h"
>   
>   enum {
>       /*
> @@ -33,6 +35,8 @@ typedef struct StreamBlockJob {
>       BlockJob common;
>       BlockDriverState *base_overlay; /* COW overlay (stream from this) */
>       BlockDriverState *above_base;   /* Node directly above the base */
> +    BlockDriverState *cor_filter_bs;
> +    BlockDriverState *target_bs;
>       BlockdevOnError on_error;
>       char *backing_file_str;
>       bool bs_read_only;
> @@ -44,8 +48,7 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
>   {
>       assert(bytes < SIZE_MAX);
>   
> -    return blk_co_preadv(blk, offset, bytes, NULL,
> -                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
> +    return blk_co_preadv(blk, offset, bytes, NULL, BDRV_REQ_PREFETCH);
>   }
>   
>   static void stream_abort(Job *job)
> @@ -53,23 +56,20 @@ static void stream_abort(Job *job)
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
> -    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>       BlockDriverState *base_unfiltered = NULL;
>       Error *local_err = NULL;
>       int ret = 0;
>   
> -    bdrv_unfreeze_backing_chain(bs, s->above_base);
> +    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>       s->chain_frozen = false;
>   
>       if (bdrv_cow_child(unfiltered_bs)) {
> @@ -105,15 +105,16 @@ static void stream_clean(Job *job)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockJob *bjob = &s->common;
> -    BlockDriverState *bs = blk_bs(bjob->blk);
>   
>       /* Reopen the image back in read-only mode if necessary */
>       if (s->bs_read_only) {
>           /* Give up write permissions before making it read-only */
>           blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
> -        bdrv_reopen_set_read_only(bs, true, NULL);
> +        bdrv_reopen_set_read_only(s->target_bs, true, NULL);
>       }
>   
> +    bdrv_cor_filter_drop(s->cor_filter_bs);
> +
>       g_free(s->backing_file_str);
>   }
>   
> @@ -121,9 +122,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockBackend *blk = s->common.blk;
> -    BlockDriverState *bs = blk_bs(blk);
> -    BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
> -    bool enable_cor = !bdrv_cow_child(s->base_overlay);
> +    BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
>       int64_t len;
>       int64_t offset = 0;
>       uint64_t delay_ns = 0;
> @@ -135,21 +134,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>           return 0;
>       }
>   
> -    len = bdrv_getlength(bs);
> +    len = bdrv_getlength(s->target_bs);
>       if (len < 0) {
>           return len;
>       }
>       job_progress_set_remaining(&s->common.job, len);
>   
> -    /* Turn on copy-on-read for the whole block device so that guest read
> -     * requests help us make progress.  Only do this when copying the entire
> -     * backing chain since the copy-on-read operation does not take base into
> -     * account.
> -     */
> -    if (enable_cor) {
> -        bdrv_enable_copy_on_read(bs);
> -    }
> -
>       for ( ; offset < len; offset += n) {
>           bool copy;
>           int ret;
> @@ -208,10 +198,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>           }
>       }
>   
> -    if (enable_cor) {
> -        bdrv_disable_copy_on_read(bs);
> -    }
> -
>       /* Do not remove the backing file if an error was there but ignored. */
>       return error;
>   }
> @@ -241,7 +227,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       bool bs_read_only;
>       int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
>       BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
> +    BlockDriverState *cor_filter_bs = NULL;
>       BlockDriverState *above_base;
> +    QDict *opts;
>   
>       if (!base_overlay) {
>           error_setg(errp, "'%s' is not in the backing chain of '%s'",
> @@ -275,17 +263,52 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>           }
>       }
>   
> -    /* Prevent concurrent jobs trying to modify the graph structure here, we
> -     * already have our own plans. Also don't allow resize as the image size is
> -     * queried only at the job start and then cached. */
> -    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
> -                         basic_flags | BLK_PERM_GRAPH_MOD,
> -                         basic_flags | BLK_PERM_WRITE,
> +    opts = qdict_new();
> +
> +    qdict_put_str(opts, "driver", "copy-on-read");
> +    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
> +    if (base) {
> +        /* Pass the base_overlay node name as 'bottom' to COR driver */
> +        qdict_put_str(opts, "bottom", base_overlay->node_name);
> +    }
> +    if (filter_node_name) {
> +        qdict_put_str(opts, "node-name", filter_node_name);
> +    }
> +
> +    cor_filter_bs = bdrv_insert_node(bs, opts, BDRV_O_RDWR, errp);
> +    if (cor_filter_bs == NULL) {
> +        goto fail;
> +    }
> +
> +    if (!filter_node_name) {
> +        cor_filter_bs->implicit = true;
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

I think that BLK_PERM_GRAPH_MOD is something outdated. We have chain-feeze, what BLK_PERM_GRAPH_MOD adds to it? I don't know, and doubt that somebody knows.

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

why not 0, like for other nodes? We don't use this BdrvChild at all, why to requre permissions?

> +                           basic_flags | BLK_PERM_WRITE, &error_abort)) {
> +        goto fail;
> +    }
> +
>       /* Block all intermediate nodes between bs and base, because they will
>        * disappear from the chain after this operation. The streaming job reads
>        * every block only once, assuming that it doesn't change, so forbid writes
> @@ -306,6 +329,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       s->base_overlay = base_overlay;
>       s->above_base = above_base;
>       s->backing_file_str = g_strdup(backing_file_str);
> +    s->cor_filter_bs = cor_filter_bs;
> +    s->target_bs = bs;
>       s->bs_read_only = bs_read_only;
>       s->chain_frozen = true;
>   
> @@ -318,5 +343,10 @@ fail:
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
> index dcb4b5d..0064590 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -227,61 +227,20 @@ class TestParallelOps(iotests.QMPTestCase):
>           for img in self.imgs:
>               os.remove(img)
>   
> -    # Test that it's possible to run several block-stream operations
> -    # in parallel in the same snapshot chain
> -    @unittest.skipIf(os.environ.get('QEMU_CHECK_BLOCK_AUTO'), 'disabled in CI')
> -    def test_stream_parallel(self):

Didn't we agree to add "bottom" paramter to qmp? Than this test-case can be rewritten using
node-names and new "bottom" stream argument.

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
> -            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=1024)
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
> @@ -294,7 +253,7 @@ class TestParallelOps(iotests.QMPTestCase):
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
> diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
> index 08e0aec..028a16f 100644
> --- a/tests/qemu-iotests/141.out
> +++ b/tests/qemu-iotests/141.out
> @@ -99,7 +99,7 @@ wrote 1048576/1048576 bytes at offset 0
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>   {'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
> -{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
> +{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: stream"}}
>   {'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
>   {"return": {}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index e60c832..af3273a 100755
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -899,17 +899,25 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>           # make hd1 read-only and block-stream requires it to be read-write
>           # (Which error message appears depends on whether the stream job is
>           # already done with copying at this point.)
> -        self.reopen(opts, {},
> -            ["Can't set node 'hd1' to r/o with copy-on-read enabled",
> -             "Cannot make block node read-only, there is a writer on it"])
> +        # As the COR-filter node is inserted into the backing chain with the
> +        # 'block-stream' operation, we move the options to their proper nodes.
> +        opts = hd_opts(1)
> +        opts['backing'] = hd_opts(2)
> +        opts['backing']['backing'] = None
> +        self.reopen(opts, {'read-only': True},
> +             ["Cannot make block node read-only, there is a writer on it"])
>   
>           # We can't remove hd2 while the stream job is ongoing
> -        opts['backing']['backing'] = None
> -        self.reopen(opts, {'backing.read-only': False}, "Cannot change 'backing' link from 'hd1' to 'hd2'")
> +        opts['backing'] = None
> +        self.reopen(opts, {'read-only': False},
> +                    "Cannot change 'backing' link from 'hd1' to 'hd2'")
>   
> -        # We can detach hd1 from hd0 because it doesn't affect the stream job
> +        # We can't detach hd1 from hd0 because there is the COR-filter implicit
> +        # node in between.
> +        opts = hd_opts(0)
>           opts['backing'] = None
> -        self.reopen(opts)
> +        self.reopen(opts, {},
> +                    "Cannot change backing link if 'hd0' has an implicit backing file")
>   
>           self.vm.run_job('stream0', auto_finalize = False, auto_dismiss = True)
>   
> 


-- 
Best regards,
Vladimir

