Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DEF2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T/1sIdnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DEF2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAAge-0003Te-Fw
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAAfy-0002zp-Qf; Mon, 24 Aug 2020 07:30:11 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:52888 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAAfu-000142-Kv; Mon, 24 Aug 2020 07:30:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PW4edfJX3l8ONcKgCLUffZ5IqDr0o8A329B3WsRy7eJshcrq6QpiO2ErJLmfpjEKE1GYfOMVh5mr7OgqPqn0qGXPXpgOZZtOQDpeDIuHWC6o6W6BmBsYFodFhhegi2Dvchh+j7niqlGBWNNMPst+BrVQtIegkgnyDUXzkHDktbYzbYMUIzuEr5uXsvj6sqq7kXrr6wquXUiw41KW9OiOKGKHfuTQS8ZJ44Mg3+FyFdHCOhA8r62QJmS+XwNOyQRQlnHz2UoYrcy+otA0xQf3hPMZ0MvtgihmQ0fOwFlEwKvKS/vKbbTiEVQDOOZtWcKILFW4ymQ3RHWjT10X1rQE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4463lkOPspJItYKXl4UG51CN8DZKL60XfcF/rH4Rjoc=;
 b=csyRe/CtRhyX/kUNpqiMZIPn2A29LHZtKrFR2qWZssbL+xxdFcPbe70pi7zIdFTrGnzU1jF0+V0duB2+7QUxCFo9kBhCSrqXVz5fWkHdzD3YZuY50vGuoaVjrsx4a+qGM4NGabrS6VVUKrZdPyB32nGv1NJm87DRK/Mvsu00VLZRu2b1qULgKcSZjJIndoY/uL3I/w81D6nDi9fNPvUcu3diCJ0bF8LSJJ3EfrXSyNIPoFdGsU9GkKRWuvp2kdPUfObKL9B1vkr9BDw5thzd7PWq2GfJPM6taZg7m+IblS9sC3hx73ZR/aJkZPYWeEfiVcpX/k5S1oUR5hHxvC1Osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4463lkOPspJItYKXl4UG51CN8DZKL60XfcF/rH4Rjoc=;
 b=T/1sIdnGzT4ooa/JPfF7Ek3ShRXwslAbPqEtniO6VPNL9W/ZPKCQXB4W1ESdKoGadmQagqFOXjrqrGwN9Taselj92h5/CZ06FbYqkLwfhUGrfi+nEZ0B63itvmti6k5apC2QWIWYZlyRgwegkchSosq4YzY1GNZhrlx08VSYRe0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3447.eurprd08.prod.outlook.com (2603:10a6:20b:44::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 11:30:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 11:30:02 +0000
Subject: Re: [PATCH v7 4/4] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598257914-887267-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598257914-887267-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2eef369e-a79d-57c9-f8c8-40be9c3aaa2c@virtuozzo.com>
Date: Mon, 24 Aug 2020 14:30:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1598257914-887267-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0001.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:208:d2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 11:30:01 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dca3dbe-9070-4ac2-6622-08d848210a53
X-MS-TrafficTypeDiagnostic: AM6PR08MB3447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34470EDE1FBA08DD60119906C1560@AM6PR08MB3447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7S+tHKe7HvjCn7G6pC041FPYad6iMwAfK50iaI81Jn8DySVoVLnyXVxBBG8afwWSN8ZOzlWaypAqU64zS13VB/VkwbZrVGmEfbOKRWS5fNpEvnja3VzHcHXwWgStCH6f7NPAMIjjpjnClLnnJ4jlXH6xwzs8Tzjg3XtLMrrY4FywmvUwsWS45p6CY7sQjFNKi/chGJ9b61DdoTsbUivM/fzF3vNbUyiOVQl3vDvK5d2MMbIoPuWftxOY0Maf9Kzk4xyhP3zel59eiStTg5XCRfiEUN1rYbf/szgqeTQAf5+OGArJrCxAnzCSxff6qvbMn1R8L2LVNUmthlageJBUc/h4PD+4wOxTAc2F0XrolDuspQRKJ+LfNSnvvnhUn5u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(396003)(346002)(16576012)(86362001)(52116002)(31696002)(2616005)(16526019)(6486002)(186003)(26005)(31686004)(107886003)(956004)(316002)(8936002)(478600001)(2906002)(4326008)(5660300002)(83380400001)(66556008)(66476007)(66946007)(30864003)(8676002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QPe0EnfKkEVgj9j6mpe1a0OOWGx8zWm/UPYs7rAZXzTFjgrF7VgvUu777M53BdGicHUVbtY4EGiEls22BOC/6IXdKmyGfsghRV8CWvO0/kBMxeCPr6dyOjmIPQf6NEpqwPWrwhEMCX8A95nmsMoMJaOdKB1kzFGdBAecdZ9NMM9itakWT8tbM2bhc9p8ozUg6sgkZBkKl39AjFEU6BK7pFFJ29YHnYkr/3ISBvXlHZWL2DfP5Cqeu8BhLgM1jzt8nRtgeGHoG3hB340nnLJZculauMza7qLwQ8BZJgKFtfx2vKpLo0eAWoURjFElDKBjf/IKBM1VAuddArOfMyEJGx4vniyDkvUaNCFiAbjQGb/rqCnkriI3jfvaUbcEMfrrceNIB0Xa2KKhcM5zZayDDsqAzVnKImQd52WekaZ+n1O9WRa+9pYyc3mrE2L4xi3gcd87cfiABARVos0llFdEbDw4Tog8TIJH4WoZCeFBqUWanKbosJwu3enJuWjPmp5dmhDccNShZSy8xctlhqGdKOKfByC1ElDfplv3dhjeYwPhvORpJtOQsbazo9XCI2+70xTFnhWy/9Fp7Tp9IJQ3rIeCApC5XriqNcjo8f5DHENSWwjTYqRP57JBv3L9bJD74t6xxCd+69t/14acET+B9A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dca3dbe-9070-4ac2-6622-08d848210a53
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 11:30:01.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpMNWFgE+BVs96k2UP1xXNeQ3Fc54cJvsKHjvSYh8nXaTrZpPIbpx+Un9pTftLRO438+6u8YCnAKIM4uTUJVmvtr8JAR+0grzRyE4XDiPgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3447
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 07:30:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.08.2020 11:31, Andrey Shinkevich wrote:
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
>   block/stream.c             | 58 +++++++++++++++++++++++++++++++++++-----------
>   tests/qemu-iotests/030     | 50 ++++-----------------------------------
>   tests/qemu-iotests/030.out |  4 ++--
>   tests/qemu-iotests/245     | 19 +++++++++++----
>   4 files changed, 65 insertions(+), 66 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 8bf6b6d..e927fed 100644
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
> @@ -33,6 +34,8 @@ typedef struct StreamBlockJob {
>       BlockJob common;
>       BlockDriverState *base_overlay; /* COW overlay (stream from this) */
>       BlockDriverState *above_base;   /* Node directly above the base */
> +    BlockDriverState *cor_filter_bs;
> +    BlockDriverState *target_bs;
>       BlockdevOnError on_error;
>       char *backing_file_str;
>       bool bs_read_only;
> @@ -53,22 +56,20 @@ static void stream_abort(Job *job)
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

variable bs is used only here, we can directly use s->target_bs instead

>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>       Error *local_err = NULL;
>       int ret = 0;
>   
> -    bdrv_unfreeze_backing_chain(bs, s->above_base);
> +    bdrv_unfreeze_backing_chain(s->cor_filter_bs, s->above_base);
>       s->chain_frozen = false;
>   
>       if (bdrv_cow_child(unfiltered_bs)) {
> @@ -94,7 +95,9 @@ static void stream_clean(Job *job)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockJob *bjob = &s->common;
> -    BlockDriverState *bs = blk_bs(bjob->blk);
> +    BlockDriverState *bs = s->target_bs;

Here as well, I'd drop extra local bs variable

> +
> +    bdrv_cor_filter_drop(s->cor_filter_bs);
>   
>       /* Reopen the image back in read-only mode if necessary */
>       if (s->bs_read_only) {
> @@ -110,7 +113,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>   {
>       StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>       BlockBackend *blk = s->common.blk;
> -    BlockDriverState *bs = blk_bs(blk);
> +    BlockDriverState *bs = s->target_bs;

Now we have both bdrv_enable_copy_on_read(bs) and cor-filter, which doesn't seem correct. Also, we'll need "base" parameter for cor filter to not copy-on-read extra chunks.

>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>       bool enable_cor = !bdrv_cow_child(s->base_overlay);
>       int64_t len;
> @@ -231,6 +234,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
>       BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>       BlockDriverState *above_base;
> +    BlockDriverState *cor_filter_bs = NULL;
>   
>       if (!base_overlay) {
>           error_setg(errp, "'%s' is not in the backing chain of '%s'",
> @@ -264,17 +268,36 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
> @@ -294,6 +317,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>   
>       s->base_overlay = base_overlay;
>       s->above_base = above_base;
> +    s->cor_filter_bs = cor_filter_bs;
> +    s->target_bs = bs;
>       s->backing_file_str = g_strdup(backing_file_str);
>       s->bs_read_only = bs_read_only;
>       s->chain_frozen = true;
> @@ -307,5 +332,10 @@ fail:
>       if (bs_read_only) {
>           bdrv_reopen_set_read_only(bs, true, NULL);
>       }
> -    bdrv_unfreeze_backing_chain(bs, above_base);
> +    if (cor_filter_bs) {
> +        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
> +        bdrv_cor_filter_drop(cor_filter_bs);
> +    } else {
> +        bdrv_unfreeze_backing_chain(bs, above_base);

as I see, in this case chain is not yet frozen

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
> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index 5035763..6c262a0 100755
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -898,17 +898,26 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>           # make hd1 read-only and block-stream requires it to be read-write
>           # (Which error message appears depends on whether the stream job is
>           # already done with copying at this point.)
> -        self.reopen(opts, {},
> +        # As the COR-filter node is inserted into the backing chain with the
> +        # 'block-stream' operation, we move the options to their proper nodes.
> +        opts = hd_opts(1)
> +        opts['backing'] = hd_opts(2)
> +        opts['backing']['backing'] = None
> +        self.reopen(opts, {'read-only': True},
>               ["Can't set node 'hd1' to r/o with copy-on-read enabled",
>                "Cannot make block node read-only, there is a writer on it"])
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

