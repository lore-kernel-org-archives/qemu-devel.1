Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFACC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF7D2085B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fyrf6cIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF7D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsER-0000ZB-B0
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlsDZ-00005a-16; Thu, 18 Jun 2020 06:56:25 -0400
Received: from mail-eopbgr30134.outbound.protection.outlook.com
 ([40.107.3.134]:13734 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jlsDV-00038T-Rc; Thu, 18 Jun 2020 06:56:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJpO0IbI4r0fkIBr084gW3uwGCGT9307PBxZJ/k9ZcO3/pRPDjpu8ln/ie5sjAyx/tXw4SZkzkoQ3k3eH3rWn5DiKEfcxQ9WFgNWqYMLmWxsKR7tfAbvmQbueOO8dc5D2IUKlRaGAehcKoSm0jbNqAgXk7uHbDtq1yiQifHvT9/5E2OC3Rv1qFILPdQ2HPXL9MBng836CWTRY5hefimC4k7N7lXKLXQSsAlZtm7B9woilWArToj5Z/385VHajyIW6YCW+6CcfjF1OCiMOmYsN9ojcTWwxoegDrsN++7lR2GJKzaJO7lOG9870Vb9woy5RrN1oKAj/hbWpieYPF/wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gaJQCYUrnIcbllTktFCEiutzg+C1WRswzf2FY0ovP4=;
 b=IbgkzJa3r78h02TszHrWs/3c1XghknK+TOtGeQV/vDWE+ht18uUYqVnjb7C6mxpB1kTcwnGBqwPUwek2NY3uC9hoccblUTV8UjgcC4fuZv+KA9bXy+u57DlwmWHNrOylsaScQ490bQSHDHkD0pWMrJaMJRBfv1SStRpOQQSxre+5cJiIPlGYL4TU5dyqWTVqiZeZfvrJVwwwJWeSmewlUsEeJUked2Whx0lM3FkED/ozMRBQjscK2gVcy9sHQUpXkg2F5IcI/UdwoP3saG4fr49jT9WL+gSoDqbZWEHVYXhXRQtpXoAxEUWRYtqJ/x5foEZsLigALomysmmzs9Fk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gaJQCYUrnIcbllTktFCEiutzg+C1WRswzf2FY0ovP4=;
 b=fyrf6cIuv6Qc8LTKynmM7t7OA0KAw1dTfsc3Kr5tyBuFBd/Uwh2cCEbWPtvFjHtC8+CvYt02wzmpxM1miHxZsAUkzYkCcbZgHxxBx8IVH7GRSxKpnrIEA+TOnAG9+ib1toC175WKReecaVgN5xdtTO7sfLxkzq9w6seje+a3LRs=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5477.eurprd08.prod.outlook.com (2603:10a6:20b:10f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 10:56:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:56:18 +0000
Subject: Re: [PATCH 5/5] block/io: improve savevm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-6-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c8c283d1-43ac-58f5-4bdd-a365e3bdc5f6@virtuozzo.com>
Date: Thu, 18 Jun 2020 13:56:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200616162035.29857-6-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:208:14::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:208:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 10:56:17 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 101a7ac1-675e-4481-abdb-08d813763a68
X-MS-TrafficTypeDiagnostic: AM7PR08MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5477FC136C2DCD0A2689A978C19B0@AM7PR08MB5477.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puc3UkE/4iLI/qfm1qM27UnuVgNhO2TWYbkIH/xEdfHStAYf8i2e6/V7tQEr4Joi2BQxsRJ0LsA0vQ3u+2cqLkFeIJ4edUy2/nlMgoaZB/BzNnuM/rzjReod/uG1FL0BtsSx1xLsJ5kKWXhbPuVI/yBww8Qo9IHaaDch3IQayeMbBE50ppNnTnvF2jm813qiZOB8Y+OGp66/gdGtYmfGkNpp1t9kXPj3bGnRmnZyElTTNagLfFfgZCzSDOFwadHzYXtv+fAmZf3aDlnpQyINyreCoo4hgXxPYiSOsHcHYjpvce3pG2WCdwx3xQL5cof1ErYL9RpFB8W6Z8a0Xs2UgLk+eqmVx7HuEoBdo2eXykv0sRgBnhWTS2ZTR4sC1oI0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(66476007)(66946007)(5660300002)(31696002)(31686004)(66556008)(86362001)(2616005)(956004)(52116002)(6486002)(186003)(8676002)(16526019)(2906002)(36756003)(4326008)(107886003)(26005)(83380400001)(54906003)(16576012)(316002)(8936002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T82vBNtG5eOzRY2nnW6G1eYOcqpPskMJPsrv7BUhjz84Yhj3ALqenn/v/0Uf/FVkPdB1JnI2PYtDyko55PzFybQNy1ttWEsTNJwdm1yTxI/yTODXmyCBlhuI+QfWR+MH44QsxjqYo0HTRQ2XIRa8O0IXtmQOtgmLa8NMD21QDyx/52BdwWFLe42818KCOYfIcXc1SUhtMyX7IkNox6vJaCq12mo9JV68tap9rDjLpUCmaPIcoFkYO+480bPXdkOsYc26n4am4ZZ+oWzZpgD0sRT66ipeiea1adtDNg53zs3aELah68hik3RR/82IBpq/cIila5pcjl4/sHS6XlNXMmnYDHNk/6ikannNT75zDBUblA58I2WxyV5LWlv0SIGF3b4iiL5T1J7Yht6UZF8aBumnrh//b0MjVWUW88DnbX1qxl+wNJbkHZhXfCwnx3zc/dnFMD7jDBVtELydYr7ZFnPgDsgUrJJVKEFqInYemYH+U3ZVxvPNo3Vzx61RehAw
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101a7ac1-675e-4481-abdb-08d813763a68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 10:56:18.0868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGew7+2DRPbktTdLEGvIRDjYGeik/XTCRm8jDwOfcsRoUL+dB9g83Yvi2ceRJn/6lYxoz+J7RtEO2xZscuvX0hfpGYD2e8Qcu2Z+lavbsLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5477
Received-SPF: pass client-ip=40.107.3.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 06:56:18
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.06.2020 19:20, Denis V. Lunev wrote:
> This patch does 2 standard basic things:
> - it creates intermediate buffer for all writes from QEMU migration code
>    to block driver,
> - this buffer is sent to disk asynchronously, allowing several writes to
>    run in parallel.
> 
> Thus bdrv_vmstate_write() is becoming asynchronous. All pending operations
> completion are performed in newly invented bdrv_flush_vmstate().
> 
> In general, migration code is fantastically inefficent (by observation),
> buffers are not aligned and sent with arbitrary pieces, a lot of time
> less than 100 bytes at a chunk, which results in read-modify-write
> operations if target file descriptor is opened with O_DIRECT. It should
> also be noted that all operations are performed into unallocated image
> blocks, which also suffer due to partial writes to such new clusters
> even on cached file descriptors.
> 
> Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
>                  original     fixed
> cached:          1.79s       1.27s
> non-cached:      3.29s       0.81s
> 
> The difference over HDD would be more significant :)
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   block/io.c                | 123 +++++++++++++++++++++++++++++++++++++-
>   include/block/block_int.h |   8 +++
>   2 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 8718df4ea8..1979098c02 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -26,6 +26,7 @@
>   #include "trace.h"
>   #include "sysemu/block-backend.h"
>   #include "block/aio-wait.h"
> +#include "block/aio_task.h"
>   #include "block/blockjob.h"
>   #include "block/blockjob_int.h"
>   #include "block/block_int.h"
> @@ -33,6 +34,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/units.h"
>   #include "sysemu/replay.h"
>   
>   /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
> @@ -2640,6 +2642,100 @@ typedef struct BdrvVmstateCo {
>       bool                is_read;
>   } BdrvVmstateCo;
>   
> +typedef struct BdrvVMStateTask {
> +    AioTask task;
> +
> +    BlockDriverState *bs;
> +    int64_t offset;
> +    void *buf;
> +    size_t bytes;
> +} BdrvVMStateTask;
> +
> +typedef struct BdrvSaveVMState {
> +    AioTaskPool *pool;
> +    BdrvVMStateTask *t;
> +} BdrvSaveVMState;
> +
> +
> +static coroutine_fn int bdrv_co_vmstate_save_task_entry(AioTask *task)
> +{
> +    int err = 0;
> +    BdrvVMStateTask *t = container_of(task, BdrvVMStateTask, task);
> +
> +    if (t->bytes != 0) {
> +        QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, t->buf, t->bytes);
> +
> +        bdrv_inc_in_flight(t->bs);
> +        err = t->bs->drv->bdrv_save_vmstate(t->bs, &qiov, t->offset);
> +        bdrv_dec_in_flight(t->bs);
> +    }
> +
> +    qemu_vfree(t->buf);
> +    return err;
> +}
> +
> +static BdrvVMStateTask *bdrv_vmstate_task_create(BlockDriverState *bs,
> +                                                 int64_t pos, size_t size)
> +{
> +    BdrvVMStateTask *t = g_new(BdrvVMStateTask, 1);
> +
> +    *t = (BdrvVMStateTask) {
> +        .task.func = bdrv_co_vmstate_save_task_entry,
> +        .buf = qemu_blockalign(bs, size),
> +        .offset = pos,
> +        .bs = bs,
> +    };
> +
> +    return t;
> +}
> +
> +static int bdrv_co_do_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
> +                                   int64_t pos)
> +{
> +    BdrvSaveVMState *state = bs->savevm_state;
> +    BdrvVMStateTask *t;
> +    size_t buf_size = MAX(bdrv_get_cluster_size(bs), 1 * MiB);
> +    size_t to_copy, off;
> +
> +    if (state == NULL) {
> +        state = g_new(BdrvSaveVMState, 1);
> +        *state = (BdrvSaveVMState) {
> +            .pool = aio_task_pool_new(BDRV_VMSTATE_WORKERS_MAX),
> +            .t = bdrv_vmstate_task_create(bs, pos, buf_size),
> +        };
> +
> +        bs->savevm_state = state;
> +    }
> +
> +    if (aio_task_pool_status(state->pool) < 0) {
> +        /* Caller is responsible for cleanup. We should block all further
> +         * save operations for this exact state */
> +        return aio_task_pool_status(state->pool);
> +    }
> +
> +    t = state->t;
> +    if (t->offset + t->bytes != pos) {
> +        /* Normally this branch is not reachable from migration */
> +        return bs->drv->bdrv_save_vmstate(bs, qiov, pos);
> +    }
> +
> +    off = 0;
> +    while (1) {

"while (aio_task_pool_status(state->pool) == 0)" + "return aio_task_pool_status(state->pool)" after loop will improve interactivity on failure path, but shouldn't be necessary.

> +        to_copy = MIN(qiov->size - off, buf_size - t->bytes);
> +        qemu_iovec_to_buf(qiov, off, t->buf + t->bytes, to_copy);
> +        t->bytes += to_copy;
> +        if (t->bytes < buf_size) {
> +            return qiov->size;

Intersting: we are substituting .bdrv_save_vmstate by this function. There are two existing now:

qcow2_save_vmstate, which doesn't care to return qiov->size and sd_save_vmstate which does it.

So, it seems safe to return qiov->size now, but I'm sure that it's actually unused and should be
refactored to return 0 on success everywhere.

> +        }
> +
> +        aio_task_pool_start_task(state->pool, &t->task);
> +
> +        pos += to_copy;
> +        off += to_copy;
> +        state->t = t = bdrv_vmstate_task_create(bs, pos, buf_size);
> +    }
> +}
> +
>   static int coroutine_fn
>   bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>                      bool is_read)
> @@ -2655,7 +2751,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>           if (is_read) {
>               ret = drv->bdrv_load_vmstate(bs, qiov, pos);
>           } else {
> -            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
> +            ret = bdrv_co_do_save_vmstate(bs, qiov, pos);
>           }
>       } else if (bs->file) {
>           ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
> @@ -2726,7 +2822,30 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>   
>   static int coroutine_fn bdrv_co_flush_vmstate(BlockDriverState *bs)
>   {
> -    return 0;
> +    int err;

nitpicking: you use "err" to store return codes, but everywhere in this file (and mostly in block/*) "ret" is used for it.

> +    BdrvSaveVMState *state = bs->savevm_state;
> +
> +    if (bs->drv->bdrv_save_vmstate == NULL && bs->file != NULL) {
> +        return bdrv_co_flush_vmstate(bs->file->bs);
> +    }
> +    if (state == NULL) {
> +        return 0;
> +    }
> +
> +    if (aio_task_pool_status(state->pool) >= 0) {
> +        /* We are on success path, commit last chunk if possible */
> +        aio_task_pool_start_task(state->pool, &state->t->task);
> +    }
> +
> +    aio_task_pool_wait_all(state->pool);
> +    err = aio_task_pool_status(state->pool);
> +
> +    aio_task_pool_free(state->pool);
> +    g_free(state);
> +
> +    bs->savevm_state = NULL;
> +
> +    return err;
>   }
>   
>   static int coroutine_fn bdrv_flush_vmstate_co_entry(void *opaque)
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 791de6a59c..f90f0e8b6a 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -61,6 +61,8 @@
>   
>   #define BLOCK_PROBE_BUF_SIZE        512
>   
> +#define BDRV_VMSTATE_WORKERS_MAX    8
> +
>   enum BdrvTrackedRequestType {
>       BDRV_TRACKED_READ,
>       BDRV_TRACKED_WRITE,
> @@ -784,6 +786,9 @@ struct BdrvChild {
>       QLIST_ENTRY(BdrvChild) next_parent;
>   };
>   
> +
> +typedef struct BdrvSaveVMState BdrvSaveVMState;
> +
>   /*
>    * Note: the function bdrv_append() copies and swaps contents of
>    * BlockDriverStates, so if you add new fields to this struct, please
> @@ -947,6 +952,9 @@ struct BlockDriverState {
>   
>       /* BdrvChild links to this node may never be frozen */
>       bool never_freeze;
> +
> +    /* Intermediate buffer for VM state saving from snapshot creation code */
> +    BdrvSaveVMState *savevm_state;
>   };
>   
>   struct BlockBackendRootState {
> 

Minor improvements and further refactoring may be done in separate, I'm OK with it as is:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

