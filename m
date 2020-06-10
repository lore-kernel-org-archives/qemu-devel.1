Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DED206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TWkpzh2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DED206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj63n-0003bl-TE
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jj5yz-00071d-6w; Wed, 10 Jun 2020 15:01:53 -0400
Received: from mail-db8eur05on2119.outbound.protection.outlook.com
 ([40.107.20.119]:22675 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jj5yx-0005a3-SY; Wed, 10 Jun 2020 15:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7/CqYnk/DrvHCNReqqamKdi+4L84JOs8XJKN7hIPlAAEmJ4q+D07O1bkP//t+8SkTC1QxzYD4lJT+8PVuwz1mZk/VsN45qgYvFclOtgAuxhfpVuwq58f1WAOPWBfAZX9vmEwoqXhVgTxEfS+0c2qq/mdJ+xKSExsTmcOHz21zCY80YfN1z2zKeRPzTcH8iFfCXsn9UwHdzffJ48J+iJguQvf+JGt2LjHnVs9AWhjyxTY48fcAfO4ZCW4UfUm1/YZk0ScEk7Q32qBceYhrYxyNWeeMFNPX2IuJwqZS08ynKX4SB4v45zVaZqamgoZqTIQu0c2SwnB7RtS7KudQYsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LgXssEWVoYIjhe5OlZ7SI+3q2Jvn/d0hgCkSXoVxwg=;
 b=ZvTPUepoPKt8cfHuqspVTpW8iyHtMOkHjU75LhOaXbJqw7Bj8BUxCgXCAErzz6L4npcjvUMbsBxNr6aIlZiX0cSi/xsQfZPXynx2CcizAz1DJfy2I58mtXBTFUtUuHn5V4cqRL1MOV1+gvENSSaJivR9IAECewI+VxElXmhVXEal9Un12eU6/kKl0EDBP+Vq9jP+4bJogW0WzueTqB14CqU8tx2/cJZ9d9japIJfuD5peD8YWAjlKzWbRZjdg1wIZ/Nm/jKiva2yYmoXvgsJVKktr8rtfFF+Bvdo6e/yJQSbiettJYvthE/38xSJeDsGQufV+9E58OtEe//eEZxrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LgXssEWVoYIjhe5OlZ7SI+3q2Jvn/d0hgCkSXoVxwg=;
 b=TWkpzh2CQ6Q5oV3JQRAsdMMVqQmh3BD56YZD8qm3ERb/8Jf5U2/s2BlgrOBytmvhJeumtMy7IjG5/qlJojdkHA4aAwdDIoRMIePFbEEcD1GPq7veI1uTl6zyhuxu0GURTSRzxdDzzhgcKOzTD8SvbQP6v3YSjxKHhcloMAKXdFA=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4581.eurprd08.prod.outlook.com (2603:10a6:20b:83::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 19:01:49 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 19:01:49 +0000
Subject: Re: [PATCH 2/2] qcow2: improve savevm performance - please ignore
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200610185833.10665-1-den@openvz.org>
 <20200610185833.10665-2-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <ab98d948-7fac-b30e-aed4-943caa14afeb@openvz.org>
Date: Wed, 10 Jun 2020 22:01:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200610185833.10665-2-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0381.eurprd05.prod.outlook.com
 (2603:10a6:7:94::40) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0381.eurprd05.prod.outlook.com (2603:10a6:7:94::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 19:01:48 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59874d01-d4e5-4c22-8bb5-08d80d70ba7b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45815DC2316DC05A60E8792CB6830@AM6PR08MB4581.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSrY2V+aBq672Jb3/Vn0sRCdK184kJhb67+JAKK/kqwwiJ2yYWp/fYGWwjnd0kgg/RvEVBzM3Cq5g0voLMvnP8qY/8nezxa2GeMr5sYtLpkcuPYt/62CgK+BSYHTq0JI8WySnBiACftIRVo6tAQ7+1nIeUoWCqMqzkaLcSITVlxsrfJlcnnNEEXUMzSedg4yXujmbBNTUyi53D4ju4qprGb3ZDOQgoWF+5AnxAPWbBB9d7QTwtE6eu7L5FDrPxSLtKrC3tntkdlDj6CJXtybglo3yum2Xy+0zYkgKViaxdhKBdXCgrWDVWe80DU+NJ8A00XgRqGzZ52YK2hzJ7rlFlkuD8NQxjPoz16Iv6gvTK7UTG+M+hvOdghDHw4a/WGA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39850400004)(136003)(396003)(376002)(346002)(52116002)(66476007)(66946007)(42882007)(66556008)(53546011)(6486002)(2616005)(956004)(4326008)(2906002)(5660300002)(36756003)(19627235002)(478600001)(186003)(8676002)(107886003)(8936002)(83170400001)(316002)(54906003)(31686004)(16526019)(26005)(83380400001)(16576012)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r8TeSrPDGmzG3DYsip6dDaKjS4ckxTGFkVcu7At4k72KazczFYKy+gDev1sjx9mKRx8ESbDp2k7JlvqvkVv/FScccBXLyo7Fwl8Qeu/2+q7fFe2cV9EbozOCKZDlpCsxg7MyBID7PFOlQ+KXJQyfwN3DJ37DVMDnG/eojH5VxOg16VrExdQJI5JoET+Y+rdP21Q1rU6AaFeZemtb6yEuYeWohKL6PNWNS9Bcnt0ohdDY3zTsPvH0+uH47u+84g7lPabRsnKKEwOucrTib5TBnTYM/R4SJEiwMlnIsOJ+w7oB8502HwJZBwhdAZeRk0hBy/XjbYFshns7lM9kYR8DLo6NKZpGdxPKVWusdIBDBfZt6P56VFIvQuWOsHsb1UIAov3rN4tmJIm3xzOW5i7ozw8AyuI2YHjV1hy0Lf0sBCEd3b9ATVDloLiaGhl9640D1MWS2ugAM9XN4iVF6LOK+tzO1X0mWuanKVuWZa4TT7zmU4h6yZ4azrCr5FAPppLy
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 59874d01-d4e5-4c22-8bb5-08d80d70ba7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 19:01:49.0441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKDEtbJQ1frvtvauHKXjQAna4+IKDwsLaXV/zZGcRs++sgu/v15nuwWF31BsBenNaDzQPYnrASUcfPNzs+N7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4581
Received-SPF: pass client-ip=40.107.20.119; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:01:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 9:58 PM, Denis V. Lunev wrote:
> This patch does 2 standard basic things:
> - it creates intermediate buffer for all writes from QEMU migration code
>   to QCOW2 image,
> - this buffer is sent to disk asynchronously, allowing several writes to
>   run in parallel.
>
> In general, migration code is fantastically inefficent (by observation),
> buffers are not aligned and sent with arbitrary pieces, a lot of time
> less than 100 bytes at a chunk, which results in read-modify-write
> operations with non-cached operations. It should also be noted that all
> operations are performed into unallocated image blocks, which also suffer
> due to partial writes to such new clusters.
>
> Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
>                 original     fixed
> cached:          1.79s       1.27s
> non-cached:      3.29s       0.81s
>
> The difference over HDD would be more significant :)
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  block/qcow2.h |   4 ++
>  2 files changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 0cd2e6757e..e6232f32e2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4797,11 +4797,43 @@ static int qcow2_make_empty(BlockDriverState *bs)
>      return ret;
>  }
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
>  static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
>  {
>      BDRVQcow2State *s = bs->opaque;
> +    Qcow2SaveVMState *state = s->savevm_state;
>      int ret;
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
>      qemu_co_mutex_lock(&s->lock);
>      ret = qcow2_write_caches(bs);
>      qemu_co_mutex_unlock(&s->lock);
> @@ -5098,14 +5130,89 @@ static int qcow2_has_zero_init(BlockDriverState *bs)
>      }
>  }
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
>  static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>                                int64_t pos)
>  {
>      BDRVQcow2State *s = bs->opaque;
> +    Qcow2SaveVMState *state = s->savevm_state;
> +    Qcow2VMStateTask *t;
> +    size_t buf_size = MAX(s->cluster_size, 1 * MiB);
> +    size_t to_copy;
> +    size_t off;
>  
>      BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
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
>  }
>  
>  static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 7ce2c23bdb..146cfed739 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -291,6 +291,8 @@ typedef struct Qcow2BitmapHeaderExt {
>  
>  #define QCOW2_MAX_THREADS 4
>  
> +typedef struct Qcow2SaveVMState Qcow2SaveVMState;
> +
>  typedef struct BDRVQcow2State {
>      int cluster_bits;
>      int cluster_size;
> @@ -384,6 +386,8 @@ typedef struct BDRVQcow2State {
>       * is to convert the image with the desired compression type set.
>       */
>      Qcow2CompressionType compression_type;
> +
> +    Qcow2SaveVMState *savevm_state;
>  } BDRVQcow2State;
>  
>  typedef struct Qcow2COWRegion {
- please ignore

