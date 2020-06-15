Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BBAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44211206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HLWoILTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44211206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklNR-0007pI-J3
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklMi-0007DW-AM; Mon, 15 Jun 2020 05:25:16 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com
 ([40.107.6.94]:8334 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklMe-00039A-NQ; Mon, 15 Jun 2020 05:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSF/HK8fufbaJcmY2BswXI17AdQmHTHoJF5QeS4Tr/4WnJtBmIWWQWeZlBg/FoJJ+60FrjtUsrvXUswkImGIVR8/iol1AaT9YxaRYrcUiKf2r7zU/TgwcV678m4ihdBFcAmYRi/7tfIsbvZClH7qMVVOSk0Hqu8JjG1HmOpYl1SeXHZv5dnRbpV6a6dMRg3pO+PmAVMslZCLb8J9FoitzgQ121wVyAvkz1YQHX1yqPGxSDIQxuzYduingXEUqFS8Y4eNLsT7SAwDqAP3fKjE8PJDEdHiMH1dLLwBWOO6S+w/J+tNMgu4qaWL2gSdxD5RYTJT7nxaZ6fT10N2wFVukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WADLzO86tbWzeYGn7MIVgdQCDRa5SUTSd9n+vB90vk=;
 b=mZUkWDv0TqySKXNlTY6MfGrsx9YRJGva9/FKXEQQthqMh9A7BR9oWNY47KiXGu/QYlZHdggBGQENcdY3yzjqHhYckJaOb+CZoEhW5cZ+EPez20z7J1LH/6v9g9w5d1k6RLC16PBLd+EH3SqZmh6sJrPaoRMKP0CrX9/PkBUWJNQNgHTmQmj4190ybBIj8t1ecShl29L1Dd/S2a2RLIUNQHhFmPPm7oUg5MVwgGN/VFT3rJV9MHO0Enja/h8KdLX/q/CrKc4fpnpdXcCpIZu/p8pXEoBKDibPtuqsLbuTuKNAcTsl7hObBYHp0ZwND6HHwvVMieVWw/1XM+Og8CIq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WADLzO86tbWzeYGn7MIVgdQCDRa5SUTSd9n+vB90vk=;
 b=HLWoILTgRmURccVtZshE5iHI9C/XsQZLbIH18uWJQkyJ43SJz+/PzsMNHohbE6pKPlryZI2GbC/ejZ7FCVTOfvsoahw232dPHQSV/7rpulLiXT+e65mWuVrOT9cnu54+cIMf5D0DKGSwCOV/gi7++TQAXQMnzVMdnXlFWNSVsAs=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5400.eurprd08.prod.outlook.com (2603:10a6:20b:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 09:25:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 09:25:08 +0000
Subject: Re: [PATCH 4/4] block/io: improve savevm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-5-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2b9eb13e-3b86-7558-2417-556909ee3408@virtuozzo.com>
Date: Mon, 15 Jun 2020 12:25:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200611171143.21589-5-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 09:25:07 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53feb353-31f7-4698-d8ab-08d8110dff13
X-MS-TrafficTypeDiagnostic: AM7PR08MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54004579516BA2BF841EE37EC19C0@AM7PR08MB5400.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtEF6bo9H481XvJrlOc/Cc5msBerXSWVTSXENfHcakU+bZs2dkE2HpAyqNdJFNrvL3VmCGIOB64NyROX7f0ZjlZvrxXJ1+/LC9oljAn7G2TMnptmP9l0pccO9218U/su83OIbMO9I4c8U4/Udb6WJVoDpPfLWhfGFTfhU+dpgdg+ho4tbvSGb4huY8TZAu54KrjDxbeQyJV/IEN8ZYPG0Bo9jJ6Y5Hf7E9TrGxetVS0rXIC8Fe17qm8HPFVgoFDP2pmVjI16ngOsU7+qOgMl6ZNxhu4iSctvPeWjiEGSR5TN9r6lVnQ7lDWGaUEIJFjrdDlEr0hNMcJrzY+D94wiJih+eV9clZX3P5h+7ACTZY5WDAfrIrcMPAaRNvpmAYvU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(376002)(346002)(136003)(5660300002)(8676002)(186003)(31686004)(478600001)(26005)(956004)(2906002)(2616005)(16526019)(107886003)(83380400001)(4326008)(8936002)(16576012)(52116002)(36756003)(66946007)(54906003)(31696002)(66476007)(6486002)(86362001)(316002)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RsVyRQcnaRWnyzx/Ptm344rA1PUfXGkJCOxo0krGrgxRF5IrGQ37AQGVitx9oCDjc+9H2vT6eGuYy1NalFU3x8jJ+aXvilHRWhBhlbZJiqVe+7Enh4QqqUghA48yJYkkqPO/zcrdOQWcwjWr/K1+UXcfvuSn/t8WQfkCdH6LK8dq/fS37hlX4xny/d61b3TSZgUD9bdh7s5CmwNaPubLiutxIZrBKDUvgl1tMfEVSDQp6oYnKLPplAVTewq+2J8rDfcIQsuDbzhNmZvtSeNvSLvfoIoVKrTcqeqcH9O+zo/XC7HrmnxnlHaOE5V/Z4rdASKV/o0j78bHM6HICDyEaTk5N8Lwcrmt9/efcN6anTp6jhVofRhgcy+qtXEkpGKWjdTJOKH4iG+OncG/RssDhqDpSm22CS4wGsnwMudrawRa4rp+QZC8VGwJ3pZERVZHQuPq0oHI8fD0Kx9QJnFv4+9Z7mHqDFP/TBYD512uGVLq2IzSrEIRdO8iK0Fo7k5o
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53feb353-31f7-4698-d8ab-08d8110dff13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:25:08.6619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTBcqCZNUyuO7J2AvL6PsNgYsBTXWwDEGTB+zhrTnkHdVgdvLh9MqMM3UpaiwUXrwivr9/kKQT1am4WcpQxf933esPO3+LvMnnhkQIBRQZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5400
Received-SPF: pass client-ip=40.107.6.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:25:09
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

11.06.2020 20:11, Denis V. Lunev wrote:
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
>   block/io.c                | 121 +++++++++++++++++++++++++++++++++++++-
>   include/block/block_int.h |   8 +++
>   2 files changed, 127 insertions(+), 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index fbf352f39d..698f1eef76 100644
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
> @@ -2633,6 +2634,102 @@ typedef struct BdrvVmstateCo {
>       int                 ret;
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
> +        QEMUIOVector local_qiov;
> +        qemu_iovec_init_buf(&local_qiov, t->buf, t->bytes);

Consider special oneliner for this case:

QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, t->buf, t->bytes);

> +
> +        bdrv_inc_in_flight(t->bs);
> +        err = t->bs->drv->bdrv_save_vmstate(t->bs, &local_qiov, t->offset);
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
> +    size_t to_copy;
> +    size_t off;
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
> +        return aio_task_pool_status(state->pool);

So, on failure, we still need flush, to cleanup the state. I think better is to cleanup it
immediately here (goto fail, etc.).

Aha, actually in blk_save_vmstate(), you don't do bdrv_flush_vmstate() if bdrv_save_vmstate()
failed.

> +    }
> +
> +    t = state->t;
> +    if (t->offset + t->bytes != pos) {
> +        /* Normally this branch is not reachable from migration */

Aha, like a cache-miss. OK

> +        return bs->drv->bdrv_save_vmstate(bs, qiov, pos);
> +    }
> +
> +    off = 0;
> +    while (1) {
> +        to_copy = MIN(qiov->size - off, buf_size - t->bytes);
> +        qemu_iovec_to_buf(qiov, off, t->buf + t->bytes, to_copy);
> +        t->bytes += to_copy;
> +        if (t->bytes < buf_size) {
> +            return qiov->size;
> +        }
> +
> +        aio_task_pool_start_task(state->pool, &t->task);
> +
> +        pos += to_copy;
> +        off += to_copy;
> +        state->t = t = bdrv_vmstate_task_create(bs, pos, buf_size);
> +    }
> +
> +    return qiov->size;

this is unreachable actually. So, I'd drop it or do "break" in a loop instead of return.

> +}
> +
>   static int coroutine_fn
>   bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>                      bool is_read)
> @@ -2648,7 +2745,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>           if (is_read) {
>               ret = drv->bdrv_load_vmstate(bs, qiov, pos);
>           } else {
> -            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
> +            ret = bdrv_co_do_save_vmstate(bs, qiov, pos);
>           }
>       } else if (bs->file) {
>           ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
> @@ -2733,7 +2830,27 @@ typedef struct FlushVMStateCo {
>   
>   static int coroutine_fn bdrv_co_flush_vmstate(BlockDriverState *bs)
>   {
> -    return 0;
> +    int err;
> +    BdrvSaveVMState *state = bs->savevm_state;
> +
> +    if (bs->drv->bdrv_save_vmstate == NULL && bs->file != NULL) {
> +        return bdrv_co_flush_vmstate(bs->file->bs);
> +    }
> +    if (state == NULL) {
> +        return 0;
> +    }
> +
> +    aio_task_pool_start_task(state->pool, &state->t->task);

We probably shouldn't do it, if pool_status is already bad. But it shouldn't hurt as is.

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
>   static void coroutine_fn bdrv_flush_vmstate_co_entry(void *opaque)
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


-- 
Best regards,
Vladimir

