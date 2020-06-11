Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A7B2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rhdgo5lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A7B2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIYl-0006Xt-3f
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jjIWw-0003D7-79; Thu, 11 Jun 2020 04:25:46 -0400
Received: from mail-eopbgr150097.outbound.protection.outlook.com
 ([40.107.15.97]:3810 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jjIWr-0007Tc-Hg; Thu, 11 Jun 2020 04:25:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H57H0bBDcqapE+K09ILCzqp91u7acOoEwTIqVFQS4oD55zIGsUbVOxlBmv+NvovBcL5NsBrwzsp8Gpu0xZ5fsIK9Sfm9c5Dg+Gk4Ubrd9/TIEbTQEtCBcg6Sju4T26SQaRSEKakreq1TjYyZdyyN10omL+m7r2IbnxXUHpJorY32M5mmTbW9tj8O8/j7lqRyiOlM8ihuBtDSSQMqrJz+XeO/ZnnHmui3ZfCzFDR8/zuRRXsgU6jANAk6aOW1Fhcn9xW3zNuShyPDuoc7BHSVzpy2XG++1wd75x0URJLXRYUFUnQd6eeO16nlNr5bXiw1H1P3CSHr5PrT9IDwyiwpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WsTheoeBSLAl40Hgfa2IGvCOLS7eim/MN41PHc6aFo=;
 b=N4Dh1+OW0zuzbojXybzAKymIL8cZAEgsMwezRqso57CobtSqlcj1s3JdMV01oE9qlK4DDXsCwZWCON9zX9x6q3ABXsaEzXBP6BRB9tadEmUSstF0tsSCVjVVp1KPB3/CVZ1T0G8xQBUr86YQud9x8Na6OomZPYlNNmTmdW1kU2AoiAg3GnzY97jOamnRCIv12gyFjRNEK13ClknY1hC8rfm9N3ucvc0X8DiLdGWet6OQr3FWlGmOHpRHruK8WVMquQYy7ZzM4vtliv1Ay4gBOrNJQBxpiK514kmDHLelSJG8bLwVxLgerb11R4wT9iM9gxSVJhS1PLiBFuIGw5eBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WsTheoeBSLAl40Hgfa2IGvCOLS7eim/MN41PHc6aFo=;
 b=rhdgo5lpWuV8Hk0Itli4J0gURuptxzN/CJyBBVRT7H9gfRYXDNtWHxoh2Uu9nxU27br5ALZ3B3V6FqjSxK7g5B8a1OufUPyNv82H+BXm5APoIMI5pb4VwCUf3de8/2a8c65WZWCVEE9LB5hnRn+NH2uPNqbW1TBcGXB3jTJ29C0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3141.eurprd08.prod.outlook.com (2603:10a6:209:4a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 08:25:38 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 08:25:38 +0000
Subject: Re: [PATCH 2/2] qcow2: improve savevm performance
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200610190058.10781-1-den@openvz.org>
 <20200610190058.10781-3-den@openvz.org>
 <b9f05b2f-f82c-95c6-aaea-27950169fcf3@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <bda806a8-7363-d41c-e86b-c2f8736d5a1d@openvz.org>
Date: Thu, 11 Jun 2020 11:25:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <b9f05b2f-f82c-95c6-aaea-27950169fcf3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::28) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0102CA0015.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Thu, 11 Jun 2020 08:25:37 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0882133-8eab-4700-b3a2-08d80de10537
X-MS-TrafficTypeDiagnostic: AM6PR08MB3141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3141A2940DA4614A6511374EB6800@AM6PR08MB3141.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyJRfvqi8oAAdiNUT+2si8ZrL0pHD3f32aoFtk/VcvJYEG1A8vJJVoS+/mIGHmU2jAj3T4XCK2n04n4/TLPJo2zpMKPYl2G8kvitl1mqJzCmVcTssn6fo9ZzNzMeq6CUpfISTL4uydH9nSfw9U6JCJUSjY/YnrDgBiU9L9lUIWf6NcmSlJEy54tULrepTWtIudxUKvCegyMcuyUmq2E5mQmL+4tpr8/deS/+KfKsjI1bWrJ9vTVEjvLkfTNW95rhgGl6da5opCS60Hp92Nxz7SV6NJOlGokXqpyTdjIMYLTnn/nXRt87tHA/COpCR3tiAIbJIw/qVSjp9HhvkzKVmNL9zvM77e75AqvvFedyalnlAugXw8Fa/zr8IIMp8+Ba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(52116002)(66946007)(42882007)(2616005)(4326008)(66476007)(186003)(66556008)(956004)(5660300002)(2906002)(6486002)(36756003)(19627235002)(478600001)(53546011)(83380400001)(107886003)(8936002)(83170400001)(316002)(31696002)(31686004)(54906003)(26005)(16526019)(16576012)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: phI+BvCZGp6V63SzvOj1OALnfvwCLRKfWzKMfVsI64ENPxVTbYFfWxvNWkz9vI/5mcLEMYkKAVPXKqb4mQ8xfrMtKn/fjuRB62HGD2GxyGqIXLoosHiidyoAxLsyBMqdr7IDks+zIuEgioeCjjA9sgqrmF1J8vgKZ132bfSMrsGaVwr/9l4jk0tc7ArldGFHirUO5TP2L+OZMdQUQaDZT6Yuw72kgaaIyqViagEzRcfHM69Xl6r5njmg/zmLkby+ET659daez48YBOmenpW6EoSP73aGTj3EblqZBMDsTndHGF8Nzy9ec68o/aaAGr0x5BZn7zvDUHjH70u7yGa9ysIGz4lI9e7Qk6fAca42Bh6GbRKYVdvnh2BKKwTfiCxWuN1U2wx0bU+gEEPcT1wijn4I9Ap7mw5aX51EYJ3fM0q5t5kwvMD6GSqQC5s2E0CC5OcIlS/eP5wsJ00sNAWOCSwHV++QZM5DEgjt2YUTr/Qec4OUBHSrpJN6mwd3a/H6
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: a0882133-8eab-4700-b3a2-08d80de10537
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 08:25:38.1153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC500Qr5jKNxETKCG7tzBda0zGcIkdu9OMrqHpV6kkqWLpDmwCYqUm+8tiaHW6vLe0r7ophGlGkr27rvIyuqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3141
Received-SPF: pass client-ip=40.107.15.97; envelope-from=den@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 04:25:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.06.2020 22:00, Denis V. Lunev wrote:
>> This patch does 2 standard basic things:
>> - it creates intermediate buffer for all writes from QEMU migration code
>>    to QCOW2 image,
>> - this buffer is sent to disk asynchronously, allowing several writes to
>>    run in parallel.
>>
>> In general, migration code is fantastically inefficent (by observation),
>> buffers are not aligned and sent with arbitrary pieces, a lot of time
>> less than 100 bytes at a chunk, which results in read-modify-write
>> operations with non-cached operations. It should also be noted that all
>> operations are performed into unallocated image blocks, which also
>> suffer
>> due to partial writes to such new clusters.
>>
>> Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
>>                  original     fixed
>> cached:          1.79s       1.27s
>> non-cached:      3.29s       0.81s
>>
>> The difference over HDD would be more significant :)
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>
> If I follow correctly, you make qcow2_save_vmstate implicitly
> asynchronous:
> it may return immediately after creating a task, and task is executing in
> parallel.
>
> I think, block-layer is unprepared for such behavior, it rely on the
> fact that
> .bdrv_save_vmstate is synchronous.
>
> For example, look at bdrv_co_rw_vmstate(). It calls
> drv->bdrv_save_vmstate
> inside pair of bdrv_inc_in_flight()/bdrv_dec_in_flight(). It means
> that with
> this patch, we may break drained section.
>
Drained sections are not involved into the equation - the guest
is stopped at the moment.

If we are talking about in_flight count, it should not be a problem
even if the guest is running. We could just put inc/dec into
qcow2_co_vmstate_task_entry().

> Next, it's a kind of cache for vmstate-write operation. It seems for
> me that
> it's not directly related to qcow2. So, we can implement it in generic
> block
> layer, where we can handle in_fligth requests. Can we keep
> .bdrv_save_vmstate
> handlers of format drivers as is, keep them synchronous, but instead
> change
> generic interface to be (optionally?) cached?

This has been discussed already in the previous thread. .bdrv_save_vmstate
is implemented in QCOW2 and sheepdog only. Thus other formats are
mostly non-interested.

>
>> ---
>>   block/qcow2.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   block/qcow2.h |   4 ++
>>   2 files changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 0cd2e6757e..e6232f32e2 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -4797,11 +4797,43 @@ static int qcow2_make_empty(BlockDriverState
>> *bs)
>>       return ret;
>>   }
>>   +
>> +typedef struct Qcow2VMStateTask {
>> +    AioTask task;
>> +
>> +    BlockDriverState *bs;
>> +    int64_t offset;
>> +    void *buf;
>> +    size_t bytes;
>> +} Qcow2VMStateTask;
>> +
>> +typedef struct Qcow2SaveVMState {
>> +    AioTaskPool *pool;
>> +    Qcow2VMStateTask *t;
>> +} Qcow2SaveVMState;
>> +
>>   static coroutine_fn int qcow2_co_flush_to_os(BlockDriverState *bs)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>> +    Qcow2SaveVMState *state = s->savevm_state;
>>       int ret;
>>   +    if (state != NULL) {
>> +        aio_task_pool_start_task(state->pool, &state->t->task);
>> +
>> +        aio_task_pool_wait_all(state->pool);
>> +        ret = aio_task_pool_status(state->pool);
>> +
>> +        aio_task_pool_free(state->pool);
>> +        g_free(state);
>> +
>> +        s->savevm_state = NULL;
>> +
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
>>       qemu_co_mutex_lock(&s->lock);
>>       ret = qcow2_write_caches(bs);
>>       qemu_co_mutex_unlock(&s->lock);
>> @@ -5098,14 +5130,89 @@ static int
>> qcow2_has_zero_init(BlockDriverState *bs)
>>       }
>>   }
>>   +
>> +static coroutine_fn int qcow2_co_vmstate_task_entry(AioTask *task)
>> +{
>> +    int err = 0;
>> +    Qcow2VMStateTask *t = container_of(task, Qcow2VMStateTask, task);
>> +
>> +    if (t->bytes != 0) {
>> +        QEMUIOVector local_qiov;
>> +        qemu_iovec_init_buf(&local_qiov, t->buf, t->bytes);
>> +        err = t->bs->drv->bdrv_co_pwritev_part(t->bs, t->offset,
>> t->bytes,
>> +                                               &local_qiov, 0, 0);
>> +    }
>> +
>> +    qemu_vfree(t->buf);
>> +    return err;
>> +}
>> +
>> +static Qcow2VMStateTask *qcow2_vmstate_task_create(BlockDriverState
>> *bs,
>> +                                                    int64_t pos,
>> size_t size)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    Qcow2VMStateTask *t = g_new(Qcow2VMStateTask, 1);
>> +
>> +    *t = (Qcow2VMStateTask) {
>> +        .task.func = qcow2_co_vmstate_task_entry,
>> +        .buf = qemu_blockalign(bs, size),
>> +        .offset = qcow2_vm_state_offset(s) + pos,
>> +        .bs = bs,
>> +    };
>> +
>> +    return t;
>> +}
>> +
>>   static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector
>> *qiov,
>>                                 int64_t pos)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>> +    Qcow2SaveVMState *state = s->savevm_state;
>> +    Qcow2VMStateTask *t;
>> +    size_t buf_size = MAX(s->cluster_size, 1 * MiB);
>> +    size_t to_copy;
>> +    size_t off;
>>         BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
>> -    return bs->drv->bdrv_co_pwritev_part(bs,
>> qcow2_vm_state_offset(s) + pos,
>> -                                         qiov->size, qiov, 0, 0);
>> +
>> +    if (state == NULL) {
>> +        state = g_new(Qcow2SaveVMState, 1);
>> +        *state = (Qcow2SaveVMState) {
>> +            .pool = aio_task_pool_new(QCOW2_MAX_WORKERS),
>> +            .t = qcow2_vmstate_task_create(bs, pos, buf_size),
>> +        };
>> +
>> +        s->savevm_state = state;
>> +    }
>> +
>> +    if (aio_task_pool_status(state->pool) != 0) {
>> +        return aio_task_pool_status(state->pool);
>> +    }
>> +
>> +    t = state->t;
>> +    if (t->offset + t->bytes != qcow2_vm_state_offset(s) + pos) {
>> +        /* Normally this branch is not reachable from migration */
>> +        return bs->drv->bdrv_co_pwritev_part(bs,
>> +                qcow2_vm_state_offset(s) + pos, qiov->size, qiov, 0,
>> 0);
>> +    }
>> +
>> +    off = 0;
>> +    while (1) {
>> +        to_copy = MIN(qiov->size - off, buf_size - t->bytes);
>> +        qemu_iovec_to_buf(qiov, off, t->buf + t->bytes, to_copy);
>> +        t->bytes += to_copy;
>> +        if (t->bytes < buf_size) {
>> +            return 0;
>> +        }
>> +
>> +        aio_task_pool_start_task(state->pool, &t->task);
>> +
>> +        pos += to_copy;
>> +        off += to_copy;
>> +        state->t = t = qcow2_vmstate_task_create(bs, pos, buf_size);
>> +    }
>> +
>> +    return 0;
>>   }
>>     static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector
>> *qiov,
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 7ce2c23bdb..146cfed739 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -291,6 +291,8 @@ typedef struct Qcow2BitmapHeaderExt {
>>     #define QCOW2_MAX_THREADS 4
>>   +typedef struct Qcow2SaveVMState Qcow2SaveVMState;
>> +
>>   typedef struct BDRVQcow2State {
>>       int cluster_bits;
>>       int cluster_size;
>> @@ -384,6 +386,8 @@ typedef struct BDRVQcow2State {
>>        * is to convert the image with the desired compression type set.
>>        */
>>       Qcow2CompressionType compression_type;
>> +
>> +    Qcow2SaveVMState *savevm_state;
>>   } BDRVQcow2State;
>>     typedef struct Qcow2COWRegion {
>>
>
>


