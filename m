Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E9AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F413F2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uDRD8yp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F413F2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIRe-00044o-78
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjIQw-0003NN-Km; Thu, 11 Jun 2020 04:19:34 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:38208 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjIQt-0006Gf-Ed; Thu, 11 Jun 2020 04:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb8bzwgn63jm/fhUJt1qbMy6DQ6Ye385Z/+s8y8rvlN/AXIpeNplyfMM/a7tRcNTCei9Nm2nIlvKibOEjSpqknRM0vVf9M6anOEQyqnCfn72G5eftkfY3m/LWul/pfDT/FrmUxeXgL/jbN2OZ1HqcxGedc/B29UqIARr+HpXSpdAmj5Wli53KbRZZwfONCGrpUAXxfOun0oHeFXsPL0xGU65vfmh8fNuuDq7+fgSsFMw3MSFY8RpAtYhsh+Q26W8N6+RTHATtsiGb8R/u+a2E3IZ4M0z8ORwQ+bjFmuoYTZCzzpFgueEAzmzelLJYIwN3850kJAltrdpnhNEEn/wYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MaQ9qCN3j8iaMTVGwziYgmZQ08WtzKt2ZR+QjzhTWo=;
 b=DXfoyShzZHCG8HMEnawUoGyWAdh0vhCDy5AM0KEDKX1dvICltZHHb1dBqiaqoNF+u+A/GkabSXQZKKI7Nrz24rHBYOmrro2pU8njpS8CcE9j/+GDykiW0BTDQVRAKFXl8/fMeULm5aWXyisjvrTWFYPrcBZsAhrPmm7aiGkcCYwM350zyOWXolxBc1l8FBJUhP3levRCST8OkfF2bJsmZMfG3QG9jgL8KwRjSebAjdek1iJy0wVWQO957zjfRWk1J7J0DVFoRPTCfqJNBxp2zEb1nx4XX3E/UWcrb1S3XCnYIxKHv/MzGs3Pp8JbN22sbdYZkAIkubuQMZ3+jVoOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MaQ9qCN3j8iaMTVGwziYgmZQ08WtzKt2ZR+QjzhTWo=;
 b=uDRD8yp9+NNVIWxXxTOk4x+/Fyj0ZQaEaDlCw8gQVUnHoWKMQvQecJCe8CvnDkZntTx/QIx7h6CIJjzhVl0DjlyZP0oF8T48cDAo2u6SiFKk8DuzOeYg+/XC3p2kO5A0JtJTuacxXaxVA2AFWLumDyNYvlsAlymHS6R7Hjaih2A=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 08:04:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 08:04:26 +0000
Subject: Re: [PATCH 2/2] qcow2: improve savevm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200610190058.10781-1-den@openvz.org>
 <20200610190058.10781-3-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b9f05b2f-f82c-95c6-aaea-27950169fcf3@virtuozzo.com>
Date: Thu, 11 Jun 2020 11:04:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200610190058.10781-3-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.22 via Frontend Transport; Thu, 11 Jun 2020 08:04:25 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73cc2033-2258-4ae6-c33f-08d80dde0f24
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53835AF69F5B9B10EB0EA499C1800@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4W9B2ewKV5+wxW+otFGnMc4OoQWPziDLoekewMULenXs+Iuv2+5wzATIP2I1ASxomo1RmcVRWMCOVEBqYWcoJ9fBp9Mj8QINHOv6fTDcfP3ebn0qnnuBnc2FpQBWIqU2s8TuKv6kgsurCO1yBPGsk/HKzX0LTLkX7sJuDylyXRRfc+xztQHYcjOQL72VptAU3z4SGLm2/lhM/sKpTACeeAwTGHD3ZdJHDjOPrIkaHU/O/I4GsKfNPBhhM7HqLp3bYkFN32FgQW0ehaEMo1juWmbwFq/STW/TLDnIqPna0ZqJAV+K42WmKxMDi4tGOyElnwqHDEk5y0wypDecJ/3fyAdUCjDlzcpyDF4gLim/gFbAIEMDOOKEYnycfuvhxM1O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(52116002)(16576012)(54906003)(316002)(16526019)(8676002)(8936002)(6486002)(956004)(4326008)(107886003)(186003)(2906002)(478600001)(2616005)(31686004)(66556008)(36756003)(86362001)(26005)(5660300002)(31696002)(83380400001)(66946007)(66476007)(19627235002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 23f8M5O6Qo7IxNpPNDwHZiT1aANc3NeFub0a+VeEJFwz1WUGeVy4cujH+wSFVN7+2FVl93zm2TztNOq7eKxfUDg7h2iP8g8MItrKV1XXK3lHTmgzNf3I7HKlVN5LYUXLgiqcP5BbN3KfCeUx6b5LI6FMUsYsJnRi8qgB98Xjfq+SLYaVqm+wMgLMrkH885sPtZiJMZ/U4Gu1qRwaxo6pFJwP+Ul3LF0O3rirl6+V0okJCrm5QljKbPXueX4y7ZZOgt+iGs06NNsUMB9AyQcW0Uxsbw//gk8rWD3nEWw1n5HIrY7DUFCGjZ4Do5LjtN7VtZ2cMkN/LkmbWobB1p8VWq/sgJhyTdpbjCn3Wp2l7+1cGdCw+x0fKscMFUzmnEbEQ1t027LWllgVMm4IN8JMtOksORAevqIlBWl4akboL/y4OzfwZEKiZlo+9bH45uZmew0Iu/S0Oe6lpyD7jkyDYfFngc++I6HKMfMuyChxT7qVSUxFM/mV+gzxusO3w+Nk
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cc2033-2258-4ae6-c33f-08d80dde0f24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 08:04:26.2322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKjacWQjVQtCCRVJT9yz5788duYXPsTfHsD2KS2Ty1QIR4W2uW8oxPuwcddsPNOLPgYDHwb+TdwsTdrSuUHNWek6977evVBKDw9o65Ji8UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.8.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 04:19:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 22:00, Denis V. Lunev wrote:
> This patch does 2 standard basic things:
> - it creates intermediate buffer for all writes from QEMU migration code
>    to QCOW2 image,
> - this buffer is sent to disk asynchronously, allowing several writes to
>    run in parallel.
> 
> In general, migration code is fantastically inefficent (by observation),
> buffers are not aligned and sent with arbitrary pieces, a lot of time
> less than 100 bytes at a chunk, which results in read-modify-write
> operations with non-cached operations. It should also be noted that all
> operations are performed into unallocated image blocks, which also suffer
> due to partial writes to such new clusters.
> 
> Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
>                  original     fixed
> cached:          1.79s       1.27s
> non-cached:      3.29s       0.81s
> 
> The difference over HDD would be more significant :)
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>

If I follow correctly, you make qcow2_save_vmstate implicitly asynchronous:
it may return immediately after creating a task, and task is executing in
parallel.

I think, block-layer is unprepared for such behavior, it rely on the fact that
.bdrv_save_vmstate is synchronous.

For example, look at bdrv_co_rw_vmstate(). It calls drv->bdrv_save_vmstate
inside pair of bdrv_inc_in_flight()/bdrv_dec_in_flight(). It means that with
this patch, we may break drained section.

Next, it's a kind of cache for vmstate-write operation. It seems for me that
it's not directly related to qcow2. So, we can implement it in generic block
layer, where we can handle in_fligth requests. Can we keep .bdrv_save_vmstate
handlers of format drivers as is, keep them synchronous, but instead change
generic interface to be (optionally?) cached?

> ---
>   block/qcow2.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   block/qcow2.h |   4 ++
>   2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 0cd2e6757e..e6232f32e2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4797,11 +4797,43 @@ static int qcow2_make_empty(BlockDriverState *bs)
>       return ret;
>   }
>   
> +
> +typedef struct Qcow2VMStateTask {
> +    AioTask task;
> +
> +    BlockDriverState *bs;
> +    int64_t offset;
> +    void *buf;
> +    size_t bytes;
> +} Qcow2VMStateTask;
> +
> +typedef struct Qcow2SaveVMState {
> +    AioTaskPool *pool;
> +    Qcow2VMStateTask *t;
> +} Qcow2SaveVMState;
> +
>   static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
>   {
>       BDRVQcow2State *s = bs->opaque;
> +    Qcow2SaveVMState *state = s->savevm_state;
>       int ret;
>   
> +    if (state != NULL) {
> +        aio_task_pool_start_task(state->pool, &state->t->task);
> +
> +        aio_task_pool_wait_all(state->pool);
> +        ret = aio_task_pool_status(state->pool);
> +
> +        aio_task_pool_free(state->pool);
> +        g_free(state);
> +
> +        s->savevm_state = NULL;
> +
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
>       qemu_co_mutex_lock(&s->lock);
>       ret = qcow2_write_caches(bs);
>       qemu_co_mutex_unlock(&s->lock);
> @@ -5098,14 +5130,89 @@ static int qcow2_has_zero_init(BlockDriverState *bs)
>       }
>   }
>   
> +
> +static coroutine_fn int qcow2_co_vmstate_task_entry(AioTask *task)
> +{
> +    int err = 0;
> +    Qcow2VMStateTask *t = container_of(task, Qcow2VMStateTask, task);
> +
> +    if (t->bytes != 0) {
> +        QEMUIOVector local_qiov;
> +        qemu_iovec_init_buf(&local_qiov, t->buf, t->bytes);
> +        err = t->bs->drv->bdrv_co_pwritev_part(t->bs, t->offset, t->bytes,
> +                                               &local_qiov, 0, 0);
> +    }
> +
> +    qemu_vfree(t->buf);
> +    return err;
> +}
> +
> +static Qcow2VMStateTask *qcow2_vmstate_task_create(BlockDriverState *bs,
> +                                                    int64_t pos, size_t size)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2VMStateTask *t = g_new(Qcow2VMStateTask, 1);
> +
> +    *t = (Qcow2VMStateTask) {
> +        .task.func = qcow2_co_vmstate_task_entry,
> +        .buf = qemu_blockalign(bs, size),
> +        .offset = qcow2_vm_state_offset(s) + pos,
> +        .bs = bs,
> +    };
> +
> +    return t;
> +}
> +
>   static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>                                 int64_t pos)
>   {
>       BDRVQcow2State *s = bs->opaque;
> +    Qcow2SaveVMState *state = s->savevm_state;
> +    Qcow2VMStateTask *t;
> +    size_t buf_size = MAX(s->cluster_size, 1 * MiB);
> +    size_t to_copy;
> +    size_t off;
>   
>       BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
> -    return bs->drv->bdrv_co_pwritev_part(bs, qcow2_vm_state_offset(s) + pos,
> -                                         qiov->size, qiov, 0, 0);
> +
> +    if (state == NULL) {
> +        state = g_new(Qcow2SaveVMState, 1);
> +        *state = (Qcow2SaveVMState) {
> +            .pool = aio_task_pool_new(QCOW2_MAX_WORKERS),
> +            .t = qcow2_vmstate_task_create(bs, pos, buf_size),
> +        };
> +
> +        s->savevm_state = state;
> +    }
> +
> +    if (aio_task_pool_status(state->pool) != 0) {
> +        return aio_task_pool_status(state->pool);
> +    }
> +
> +    t = state->t;
> +    if (t->offset + t->bytes != qcow2_vm_state_offset(s) + pos) {
> +        /* Normally this branch is not reachable from migration */
> +        return bs->drv->bdrv_co_pwritev_part(bs,
> +                qcow2_vm_state_offset(s) + pos, qiov->size, qiov, 0, 0);
> +    }
> +
> +    off = 0;
> +    while (1) {
> +        to_copy = MIN(qiov->size - off, buf_size - t->bytes);
> +        qemu_iovec_to_buf(qiov, off, t->buf + t->bytes, to_copy);
> +        t->bytes += to_copy;
> +        if (t->bytes < buf_size) {
> +            return 0;
> +        }
> +
> +        aio_task_pool_start_task(state->pool, &t->task);
> +
> +        pos += to_copy;
> +        off += to_copy;
> +        state->t = t = qcow2_vmstate_task_create(bs, pos, buf_size);
> +    }
> +
> +    return 0;
>   }
>   
>   static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 7ce2c23bdb..146cfed739 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -291,6 +291,8 @@ typedef struct Qcow2BitmapHeaderExt {
>   
>   #define QCOW2_MAX_THREADS 4
>   
> +typedef struct Qcow2SaveVMState Qcow2SaveVMState;
> +
>   typedef struct BDRVQcow2State {
>       int cluster_bits;
>       int cluster_size;
> @@ -384,6 +386,8 @@ typedef struct BDRVQcow2State {
>        * is to convert the image with the desired compression type set.
>        */
>       Qcow2CompressionType compression_type;
> +
> +    Qcow2SaveVMState *savevm_state;
>   } BDRVQcow2State;
>   
>   typedef struct Qcow2COWRegion {
> 


-- 
Best regards,
Vladimir

