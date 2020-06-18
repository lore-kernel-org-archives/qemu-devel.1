Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CCC2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="fCvEXmlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CCC2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsPW-0000r2-LT
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jlsOf-00007V-3O; Thu, 18 Jun 2020 07:07:53 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com
 ([40.107.20.99]:54297 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jlsOb-0005jw-H3; Thu, 18 Jun 2020 07:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHidp0nY73Ifq+RQ6sdxKjBS3eOmjODcskQ9Njnk7XQjFi3Iqs7MKxf2/mkL9gf1/p3jDOEnNGx0/a+P3xTZPln060741rA/0IzQiLYkHZIoRi1id57+NITm9aRr5/3PZCNw3pYkwFWsa6LJxjvcT4gHrhiR+xDxmkkGMn0huSroMnIP1A/7kN76P7rV8FxRmHqP1pghbhI/TZDDQVJA2/m78Gr78QqzTjSeq8AlOAXBICGWodag/UceUP6bNnwtXkoZ14q9yXWKLLS+MjXevtm9IH2r8VBq4Gzybf0/+zWtZy1Wj8TTGyu2wiCVmzXzqSoGbxKbZUcuQaTYiYIHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Z/4Lrm75siFxpaDVzQkbQUU4q6zjmbyZHqp54KOWI=;
 b=M6T9PbI/B2LZmhIUc/buq2gW6c9iIzCFJLxwl7kAT5NMT/pc6bvVMNFTN5TuW07wMwN7LMX2zl0bGctIfzXKyhiO4i0QrpZ6T5M7XH5IXYsOkhIdi8WZtsai+4WYAz11tj8CwobRzDQwW+i/uTDiK763g7H5IkzNftX0lx33uYflYHkBKZoAMd4ye7Sm84fjih+OzatK4kelQ1Kn7TpsDSUVOz7/wE69R4UdV0t3khLzaPKhL34HS5WeK+03tQWKs5nwKq0FhwRQCqYy4Tx+W+hsF1POdCtCie5dNY6ZMEehotwu29RuxelXAbXSAFn4hqgis+b+j7rrVn1v/pEKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7Z/4Lrm75siFxpaDVzQkbQUU4q6zjmbyZHqp54KOWI=;
 b=fCvEXmlMoXS8tUVjnWGklwHyz7MLYudVt/G5cTlBacRKfKoLPADZKb4S8v+q8xlCs0BTpV1qs1PUaV55YoDba6C0y5zILTT3f58Sof2V8u4+kzYDZcITLmfhcWMWZ/q0NAoNMUiGboMsG7J7d/buyzTzW3X3+ybV5y0Hy58ZQ7o=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4119.eurprd08.prod.outlook.com (2603:10a6:20b:ad::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 11:07:45 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 11:07:45 +0000
Subject: Re: [PATCH 5/5] block/io: improve savevm performance
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200616162035.29857-1-den@openvz.org>
 <20200616162035.29857-6-den@openvz.org>
 <c8c283d1-43ac-58f5-4bdd-a365e3bdc5f6@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <1e3c913c-fc38-3940-8290-a9cdc8bcaa3c@openvz.org>
Date: Thu, 18 Jun 2020 14:07:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <c8c283d1-43ac-58f5-4bdd-a365e3bdc5f6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1P192CA0016.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::26)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1P192CA0016.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 11:07:44 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82b987b0-6732-4f73-56b3-08d81377d3f0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4119366DA6CC5CCDEAFDBA46B69B0@AM6PR08MB4119.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmwnG4aBIMxUH+O+8NDYl6ZKRbycJ81mTsTCdB5vTIyL2GuSGK4xrPHyeji+EeC+Ywn8ZaJkUlyPX+Kkw43FhT5Tewbil0Sz8JW6o12wSsjDydwBPjJDWixeb4UWJABdDIzqb5QBSr+Y9TGV0i6mqznjvD7hFzkwCfYVXJQhTuzu4hKkFs83Gg/oSifxsC8+hOzHXrFOR95ri5c4aIPdh996VQ5cW0KRQHrgBH5J30ftNtbX0l9eFlghXURRv27FPsC59Vb5nXhtlOMm8OKZru1AI/CN5Wt42xVyyJIDO1uTc+2iJWqwMPDqoKaBaCFIXs8R+ju5Xg/yHrnTUjAUgymvoANrIskLYytrQLhrq3PV8Jk+n77X1YEgFdaRZKxs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39850400004)(396003)(136003)(26005)(2906002)(16526019)(66946007)(316002)(54906003)(5660300002)(16576012)(52116002)(186003)(66476007)(107886003)(66556008)(4326008)(83380400001)(478600001)(36756003)(42882007)(6486002)(956004)(2616005)(8936002)(31686004)(8676002)(31696002)(83170400001)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v2XMpF3EFHgq9TwNoP14nCxvBkZIf++VMVsNcGx1IeltaWZH4bEuDqgW/W2xNVrgvNlj6jwwKMcjABz7C8JFdQazeIfvLeajPQ2jm7O6ibTPCEpWkYIVljLTM7RlMhLRpwi/NMH39wntmzz8/VwW8LhC6ELm7YVNlyeaA2Qtu6gmFKK4I1VE/sVEfksS+hicoH571vt5QW/2/kjnNz3aZSQo7F02P4i184n/l5It155RG60JZFtqcBDURkGcx/ZSNdsHYErZSz2iU0BWykEWG7nM6joL7mFXX4GmJjO7hvtHVdmWnQBgTQWRYZBSFroGVJ0t1abtdBdoLSCyfR2s3NOSPPxYEHNn1rMlmnoZ+AOvogL3mrtsfv3MnacWsrKBH4nGrOdOor0mT80VUd95Kq/J+pHSPlmpM2M3lhv5xUnng3b8rZG7eTNoD7HW+IGI16IuQs1B1ausw27xmcANvpWRPbZs4qh/ePweKBnoQNJv2VDoV9Y1o9pVhZmMv9MC
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b987b0-6732-4f73-56b3-08d81377d3f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 11:07:45.1833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0UEDyKpPHqMT+fTcTO5HVHXtN4fmimc1dYAZebevSnTWbikrw+6tgHxs3M+aWA2Etl+h0//w5z0uuYl0jIAzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4119
Received-SPF: pass client-ip=40.107.20.99; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 07:07:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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

On 6/18/20 1:56 PM, Vladimir Sementsov-Ogievskiy wrote:
> 16.06.2020 19:20, Denis V. Lunev wrote:
>> This patch does 2 standard basic things:
>> - it creates intermediate buffer for all writes from QEMU migration code
>>    to block driver,
>> - this buffer is sent to disk asynchronously, allowing several writes to
>>    run in parallel.
>>
>> Thus bdrv_vmstate_write() is becoming asynchronous. All pending
>> operations
>> completion are performed in newly invented bdrv_flush_vmstate().
>>
>> In general, migration code is fantastically inefficent (by observation),
>> buffers are not aligned and sent with arbitrary pieces, a lot of time
>> less than 100 bytes at a chunk, which results in read-modify-write
>> operations if target file descriptor is opened with O_DIRECT. It should
>> also be noted that all operations are performed into unallocated image
>> blocks, which also suffer due to partial writes to such new clusters
>> even on cached file descriptors.
>>
>> Snapshot creation time (2 GB Fedora-31 VM running over NVME storage):
>>                  original     fixed
>> cached:          1.79s       1.27s
>> non-cached:      3.29s       0.81s
>>
>> The difference over HDD would be more significant :)
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Fam Zheng <fam@euphon.net>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   block/io.c                | 123 +++++++++++++++++++++++++++++++++++++-
>>   include/block/block_int.h |   8 +++
>>   2 files changed, 129 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 8718df4ea8..1979098c02 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -26,6 +26,7 @@
>>   #include "trace.h"
>>   #include "sysemu/block-backend.h"
>>   #include "block/aio-wait.h"
>> +#include "block/aio_task.h"
>>   #include "block/blockjob.h"
>>   #include "block/blockjob_int.h"
>>   #include "block/block_int.h"
>> @@ -33,6 +34,7 @@
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/main-loop.h"
>> +#include "qemu/units.h"
>>   #include "sysemu/replay.h"
>>     /* Maximum bounce buffer for copy-on-read and write zeroes, in
>> bytes */
>> @@ -2640,6 +2642,100 @@ typedef struct BdrvVmstateCo {
>>       bool                is_read;
>>   } BdrvVmstateCo;
>>   +typedef struct BdrvVMStateTask {
>> +    AioTask task;
>> +
>> +    BlockDriverState *bs;
>> +    int64_t offset;
>> +    void *buf;
>> +    size_t bytes;
>> +} BdrvVMStateTask;
>> +
>> +typedef struct BdrvSaveVMState {
>> +    AioTaskPool *pool;
>> +    BdrvVMStateTask *t;
>> +} BdrvSaveVMState;
>> +
>> +
>> +static coroutine_fn int bdrv_co_vmstate_save_task_entry(AioTask *task)
>> +{
>> +    int err = 0;
>> +    BdrvVMStateTask *t = container_of(task, BdrvVMStateTask, task);
>> +
>> +    if (t->bytes != 0) {
>> +        QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, t->buf,
>> t->bytes);
>> +
>> +        bdrv_inc_in_flight(t->bs);
>> +        err = t->bs->drv->bdrv_save_vmstate(t->bs, &qiov, t->offset);
>> +        bdrv_dec_in_flight(t->bs);
>> +    }
>> +
>> +    qemu_vfree(t->buf);
>> +    return err;
>> +}
>> +
>> +static BdrvVMStateTask *bdrv_vmstate_task_create(BlockDriverState *bs,
>> +                                                 int64_t pos, size_t
>> size)
>> +{
>> +    BdrvVMStateTask *t = g_new(BdrvVMStateTask, 1);
>> +
>> +    *t = (BdrvVMStateTask) {
>> +        .task.func = bdrv_co_vmstate_save_task_entry,
>> +        .buf = qemu_blockalign(bs, size),
>> +        .offset = pos,
>> +        .bs = bs,
>> +    };
>> +
>> +    return t;
>> +}
>> +
>> +static int bdrv_co_do_save_vmstate(BlockDriverState *bs,
>> QEMUIOVector *qiov,
>> +                                   int64_t pos)
>> +{
>> +    BdrvSaveVMState *state = bs->savevm_state;
>> +    BdrvVMStateTask *t;
>> +    size_t buf_size = MAX(bdrv_get_cluster_size(bs), 1 * MiB);
>> +    size_t to_copy, off;
>> +
>> +    if (state == NULL) {
>> +        state = g_new(BdrvSaveVMState, 1);
>> +        *state = (BdrvSaveVMState) {
>> +            .pool = aio_task_pool_new(BDRV_VMSTATE_WORKERS_MAX),
>> +            .t = bdrv_vmstate_task_create(bs, pos, buf_size),
>> +        };
>> +
>> +        bs->savevm_state = state;
>> +    }
>> +
>> +    if (aio_task_pool_status(state->pool) < 0) {
>> +        /* Caller is responsible for cleanup. We should block all
>> further
>> +         * save operations for this exact state */
>> +        return aio_task_pool_status(state->pool);
>> +    }
>> +
>> +    t = state->t;
>> +    if (t->offset + t->bytes != pos) {
>> +        /* Normally this branch is not reachable from migration */
>> +        return bs->drv->bdrv_save_vmstate(bs, qiov, pos);
>> +    }
>> +
>> +    off = 0;
>> +    while (1) {
>
> "while (aio_task_pool_status(state->pool) == 0)" + "return
> aio_task_pool_status(state->pool)" after loop will improve
> interactivity on failure path, but shouldn't be necessary.
>
>> +        to_copy = MIN(qiov->size - off, buf_size - t->bytes);
>> +        qemu_iovec_to_buf(qiov, off, t->buf + t->bytes, to_copy);
>> +        t->bytes += to_copy;
>> +        if (t->bytes < buf_size) {
>> +            return qiov->size;
>
> Intersting: we are substituting .bdrv_save_vmstate by this function.
> There are two existing now:
>
> qcow2_save_vmstate, which doesn't care to return qiov->size and
> sd_save_vmstate which does it.
>
> So, it seems safe to return qiov->size now, but I'm sure that it's
> actually unused and should be
> refactored to return 0 on success everywhere.

This looks like my mistake now. I have spent some time
with error codes working with Eric's suggestions and
believe that 0 should be returned now.

Will fix in next revision.

Den

