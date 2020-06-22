Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C69DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAFD20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="fXTcmJW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAFD20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQ58-00054g-SD
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jnQ4G-0004Yx-69; Mon, 22 Jun 2020 13:17:12 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com
 ([40.107.6.105]:49536 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jnQ4B-0004qp-Uu; Mon, 22 Jun 2020 13:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkrA15iQBc+2a0UyHQ/vNv9e7BtiUG1qzFFfWkf+myNDEBhg5XX5oRiv5KqndsrRXEG/6QaIQ2tngcut0RXa4Tm8OFDz2CpHxMJ4zt8alS/C66LG4G+iwW6oNSOX2hEeBE37nO72dnAibWsSU0vLYNM/Bslx7mgQKMAFU8Dcj5P1C/VfWlogCWDjRiN/5I5M7+NP/+fxOuETbBboVDUT2ya8r2VTeMimfof4C6UsjnSaz/DGv5bKqqHLY/AilWCC/YWPCsEVGiZSKdgHqiScc3H5WmHRac46lGVmHeOhujfAAfkjMpbYGCcYajuI48a+KxFoRWyZT+yum35U0ArHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsB7XqbAKWarhcie57E9PfJJrcuRf9C0W/zHXFb6fAA=;
 b=WN7C5/RTaNgCtAWCTEEfKIpoDGrVWf88a9GAI1xTyv7Vo312q2SBvomRIlI9wxdUTnnr3ckZu6lbQcSkf1C2VZmk2b+WHz0KcqJRSpa3RIy8B1krNZN3EAGtutPWmfOw7nwJQrijc69K39oH6CKqftWSJGfomjpXRsdH/2FwL0nQEMgKvJ//FtN4r/8LzDV3Ji+RlOBqOwrGl8pBwS23x2+xQ+l+1rVO7HP7K1BC12dkufsO3XrQy574q0acvvcOyheWwX5NDTcG5NXc67niA7E1eyZ9uecVlPuSZ7qbVKO2GlmaYX5qg/MOhVCo9hgiTyxassiBnHJ8sDXgC/VB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsB7XqbAKWarhcie57E9PfJJrcuRf9C0W/zHXFb6fAA=;
 b=fXTcmJW0HL6wHMobnYKoPDpbawfUEVaqpJ+Y3HE0q7KckNPjjX7WaxnUwXCavXD0trel2Rb3LHNlWwBhhUcctH/lN+1B1ECII3gCDONiumGKGbRoSfN+7upQSroTAEO1IXRTYFiTnjQCaniRHeYN0EhnMIwu+DwI5hcsscpb9yo=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3048.eurprd08.prod.outlook.com (2603:10a6:209:46::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 17:17:04 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:17:04 +0000
Subject: Re: [PATCH 7/6] block/io: improve loadvm performance
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200619100708.30440-1-den@openvz.org>
 <20200622083303.18665-1-den@openvz.org>
 <f1afc4ce-14ac-443d-4c7a-de045d7fe01b@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <551fc511-da47-5003-3b1d-a64392e30b2d@openvz.org>
Date: Mon, 22 Jun 2020 20:17:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <f1afc4ce-14ac-443d-4c7a-de045d7fe01b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0227.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::27) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0227.eurprd05.prod.outlook.com (2603:10a6:3:fa::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:17:03 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47d2ddc2-a73b-4dbd-9385-08d816d01568
X-MS-TrafficTypeDiagnostic: AM6PR08MB3048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30480D4891DA30FD1123A8AAB6970@AM6PR08MB3048.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZ3XzT8+ww/WR6ZRxxT1tLLsSUccTmVI5A20ygts+c/b9mgIZdn61aAJyOC1dGpGTBYsqeceSElgTRUBM8iLDIwRl2KjUSgJGc3RtAta1jjc8xjNTsXZDwYLBZoCe3+gsf/TIHQtHj82H7a3gyFuO2oOR6rZmmPKAfMTddzQu6Y6xA3ty/qAW7u/5eNiRprzdLSwwQcKSgkkED1UX7JM5bwQA2MNQiTq2IwJHb1ezbxXxLPHQdxNB1qhGB4uWnXutypw8gB3WHmYBAZfYEBz8srdU4x8ZbXuRYli0DNWrsmFy1N0t8ra755bM+bOVPon444HRxT8NEpfkTYfPKNYYcoF1kfJUfOr0Ng8o8RmkTrE0SBPXTqtYvdiv4SlESCv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39840400004)(346002)(16576012)(316002)(83170400001)(54906003)(83380400001)(478600001)(2616005)(6486002)(956004)(42882007)(26005)(66946007)(8936002)(186003)(66556008)(30864003)(53546011)(5660300002)(107886003)(66476007)(16526019)(8676002)(31696002)(4326008)(31686004)(2906002)(52116002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +OWauJPNxBVyv4rM1GXL8BSWKurRbT4mBYR0sdrFOoWEFA8yGpNtCEX2qyU2HIoCfYGpviJmtews3D9io9VrSc36C67/A8h6VQVbbOu4JIDHc8MnUPai1BBBQbHcA5xV1N6xjM+m/0x6GzY8efUALl2rCz2cqvPN0Mad/DatG18WGW9cVgQYPHt6ry8WU0hDmhPRRHg4v0Gwrrs9ERqLuGWsq9BOiopgBe4+gqi436sywnqXQj3dGuNfKjBEFCLCsXNOLUmsDvZ0Yk2b8zFo8ZwGXVoIt8ThDfVLrxEPUSUsr1WGO5gDlAReuf8T4gnuiJI8ob4wSc9KNAmwKfcneLkXvNrijYRwVWdFsqg5Ud3nrgnukYpunA/bxtj9FEpjc6L3d+tD9DadseEICkp1RkTf/ILPVCJ4C5V7jNQTJQmYi5MDVQBDcszwy9MlyOQPiOHAA+esUhYGtMYT6TS3ITOs7EZZSfQy1wiKXk48dSqHrfuNLuaaInhh61vxmkaG
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d2ddc2-a73b-4dbd-9385-08d816d01568
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:17:04.2967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nk0AN5jRZJn9Dve0eMibtHi3SjOCIZUWNDA/I9QxDpV7blLelC41RPd76FLml2e+gK7FntDppWb2IYATXcsACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3048
Received-SPF: pass client-ip=40.107.6.105; envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 13:17:05
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

On 6/22/20 8:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> 22.06.2020 11:33, Denis V. Lunev wrote:
>> This patch creates intermediate buffer for reading from block driver
>> state and performs read-ahead to this buffer. Snapshot code performs
>> reads sequentially and thus we know what offsets will be required
>> and when they will become not needed.
>>
>> Results are fantastic. Switch to snapshot times of 2GB Fedora 31 VM
>> over NVME storage are the following:
>>                  original     fixed
>> cached:          1.84s       1.16s
>> non-cached:     12.74s       1.27s
>>
>> The difference over HDD would be more significant :)
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Fam Zheng <fam@euphon.net>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>
>>   block/io.c                | 225 +++++++++++++++++++++++++++++++++++++-
>>   include/block/block_int.h |   3 +
>>   2 files changed, 225 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 71a696deb7..bb06f750d8 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2739,6 +2739,180 @@ static int
>> bdrv_co_do_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>>       }
>>   }
>>   +
>> +typedef struct BdrvLoadVMChunk {
>> +    void *buf;
>> +    uint64_t offset;
>> +    ssize_t bytes;
>> +
>> +    QLIST_ENTRY(BdrvLoadVMChunk) list;
>> +} BdrvLoadVMChunk;
>> +
>> +typedef struct BdrvLoadVMState {
>> +    AioTaskPool *pool;
>> +
>> +    int64_t offset;
>> +    int64_t last_loaded;
>> +
>> +    int chunk_count;
>> +    QLIST_HEAD(, BdrvLoadVMChunk) chunks;
>> +    QLIST_HEAD(, BdrvLoadVMChunk) loading;
>> +    CoMutex lock;
>> +    CoQueue waiters;
>> +} BdrvLoadVMState;
>> +
>> +typedef struct BdrvLoadVMStateTask {
>> +    AioTask task;
>> +
>> +    BlockDriverState *bs;
>> +    BdrvLoadVMChunk *chunk;
>> +} BdrvLoadVMStateTask;
>> +
>> +static BdrvLoadVMChunk *bdrv_co_find_loadvmstate_chunk(int64_t pos,
>> +                                                      
>> BdrvLoadVMChunk *c)
>> +{
>> +    for (; c != NULL; c = QLIST_NEXT(c, list)) {
>> +        if (c->offset <= pos && c->offset + c->bytes > pos) {
>> +            return c;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static void bdrv_free_loadvm_chunk(BdrvLoadVMChunk *c)
>> +{
>> +    qemu_vfree(c->buf);
>> +    g_free(c);
>> +}
>> +
>> +static coroutine_fn int bdrv_co_vmstate_load_task_entry(AioTask *task)
>> +{
>> +    int err = 0;
>> +    BdrvLoadVMStateTask *t = container_of(task, BdrvLoadVMStateTask,
>> task);
>> +    BdrvLoadVMChunk *c = t->chunk;
>> +    BdrvLoadVMState *state = t->bs->loadvm_state;
>> +    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, c->buf, c->bytes);
>> +
>> +    bdrv_inc_in_flight(t->bs);
>> +    err = t->bs->drv->bdrv_load_vmstate(t->bs, &qiov, c->offset);
>> +    bdrv_dec_in_flight(t->bs);
>> +
>> +    qemu_co_mutex_lock(&state->lock);
>> +    QLIST_REMOVE(c, list);
>> +    if (err == 0) {
>> +        QLIST_INSERT_HEAD(&state->chunks, c, list);
>> +    } else {
>> +        bdrv_free_loadvm_chunk(c);
>> +    }
>> +    qemu_co_mutex_unlock(&state->lock);
>> +    qemu_co_queue_restart_all(&state->waiters);
>> +
>> +    return err;
>> +}
>> +
>> +static void bdrv_co_start_loadvmstate(BlockDriverState *bs,
>> +                                      BdrvLoadVMState *state)
>> +{
>> +    int i;
>> +    size_t buf_size = MAX(bdrv_get_cluster_size(bs), 1 * MiB);
>> +
>> +    qemu_co_mutex_assert_locked(&state->lock);
>> +    for (i = state->chunk_count; i < BDRV_VMSTATE_WORKERS_MAX; i++) {
>> +        BdrvLoadVMStateTask *t = g_new(BdrvLoadVMStateTask, 1);
>> +
>> +        *t = (BdrvLoadVMStateTask) {
>> +            .task.func = bdrv_co_vmstate_load_task_entry,
>> +            .bs = bs,
>> +            .chunk = g_new(BdrvLoadVMChunk, 1),
>> +        };
>> +
>> +        *t->chunk = (BdrvLoadVMChunk) {
>> +            .buf = qemu_blockalign(bs, buf_size),
>> +            .offset = state->last_loaded,
>> +            .bytes = buf_size,
>> +        };
>> +        /* FIXME: tail of stream */
>> +
>> +        QLIST_INSERT_HEAD(&state->loading, t->chunk, list);
>> +        state->chunk_count++;
>> +        state->last_loaded += buf_size;
>> +
>> +        qemu_co_mutex_unlock(&state->lock);
>> +        aio_task_pool_start_task(state->pool, &t->task);
>
> Hmm, so, we unlock the mutex here. Am I missing something, or if there
> are
> two parallel load-state requests in parallel (yes, this shouldn't happen
> with current migration code, but if don't care at all the mutex is not
> needed),
>
> we may have two such loops in parallel, which will create more than
> BDRV_VMSTATE_WORKERS_MAX chunks, as each has own local "i" variable?

I could stall on waiting free slot in the pool (technically)
while pool completion will need the lock. This should
NOT happen with the current arch, but would be better
to do things correctly, i.e. drop the lock.

>
>> +        qemu_co_mutex_lock(&state->lock);
>> +    }
>> +}
>> +
>> +static int bdrv_co_do_load_vmstate(BlockDriverState *bs,
>> QEMUIOVector *qiov,
>> +                                   int64_t pos)
>> +{
>> +    BdrvLoadVMState *state = bs->loadvm_state;
>> +    BdrvLoadVMChunk *c;
>> +    size_t off;
>> +
>> +    if (state == NULL) {
>> +        if (pos != 0) {
>> +            /* Normally this branch is not reachable from migration */
>> +            return bs->drv->bdrv_load_vmstate(bs, qiov, pos);
>> +        }
>> +
>> +        state = g_new(BdrvLoadVMState, 1);
>> +        *state = (BdrvLoadVMState) {
>> +            .pool = aio_task_pool_new(BDRV_VMSTATE_WORKERS_MAX),
>> +            .chunks = QLIST_HEAD_INITIALIZER(state->chunks),
>> +            .loading = QLIST_HEAD_INITIALIZER(state->loading),
>> +        };
>> +        qemu_co_mutex_init(&state->lock);
>> +        qemu_co_queue_init(&state->waiters);
>> +
>> +        bs->loadvm_state = state;
>> +    }
>> +
>> +    if (state->offset != pos) {
>> +        /* Normally this branch is not reachable from migration */
>> +        return bs->drv->bdrv_load_vmstate(bs, qiov, pos);
>> +    }
>> +
>> +    off = 0;
>> +    qemu_co_mutex_lock(&state->lock);
>> +    bdrv_co_start_loadvmstate(bs, state);
>> +
>> +    while (off < qiov->size && aio_task_pool_status(state->pool) ==
>> 0) {
>> +        c = bdrv_co_find_loadvmstate_chunk(pos,
>> QLIST_FIRST(&state->chunks));
>> +        if (c != NULL) {
>> +            ssize_t chunk_off = pos - c->offset;
>> +            ssize_t to_copy = MIN(qiov->size - off, c->bytes -
>> chunk_off);
>> +
>> +            qemu_iovec_from_buf(qiov, off, c->buf + chunk_off,
>> to_copy);
>> +
>> +            off += to_copy;
>> +            pos += to_copy;
>> +
>> +            if (pos == c->offset + c->bytes) {
>> +                state->chunk_count--;
>> +                /* End of buffer, discard it from the list */
>> +                QLIST_REMOVE(c, list);
>> +                bdrv_free_loadvm_chunk(c);
>> +            }
>> +
>> +            state->offset += to_copy;
>> +            continue;
>> +        }
>> +
>> +        c = bdrv_co_find_loadvmstate_chunk(pos,
>> QLIST_FIRST(&state->loading));
>> +        if (c != NULL) {
>> +            qemu_co_queue_wait(&state->waiters, &state->lock);
>> +            continue;
>> +        }
>> +
>> +        bdrv_co_start_loadvmstate(bs, state);
>
> Hmm, so, you assume that if we are in a loop, we'll definitely find
> our chunk at some moment.
> It should work with normal migration stream, sequentially reading
> chunk by chunk. But if not,
> it may hang:
>
> Consider two reads at same position, running in parallel: they both
> pass "state->offset != pos"
> check and wait on mutex. Then the first one will go into critical
> section, find and remove
> corresponding chunk. Then the second will go into critical section and
> loop forever, because
> corresponding chunk will never be generated again.
>
> So, seems, we should check (state->offset == pos) on each iteration,
> or something like this.
>
we can. But the reader is synchronous and could not
issue 2 requests. Not a problem.


> ====
>
> Another idea came into my mind is that you create new requests when we
> can't find our chunk.
> It may be a bit more optimal to create new requests as soon as we get
> a free slot after
> QLIST_REMOVE(..)
>
> And, if we do so, we don't need "loading" list: if there is no
> corresponding chunk in chunks,
> we will just wait in "waiters" queue.
>
no. I would prefer to keep all requests in some lists.
This would save a ton of time if something will
go wrong.

But the idea of refilling near REMOVE is fine to
work with.

>
>
>> +    }
>> +    qemu_co_mutex_unlock(&state->lock);
>> +
>> +    return aio_task_pool_status(state->pool);
>> +}
>> +
>>   static int coroutine_fn
>>   bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>> int64_t pos,
>>                      bool is_read)
>> @@ -2752,7 +2926,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs,
>> QEMUIOVector *qiov, int64_t pos,
>>           ret = -ENOMEDIUM;
>>       } else if (drv->bdrv_load_vmstate) {
>>           if (is_read) {
>> -            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
>> +            ret = bdrv_co_do_load_vmstate(bs, qiov, pos);
>>           } else {
>>               ret = bdrv_co_do_save_vmstate(bs, qiov, pos);
>>           }
>> @@ -2823,13 +2997,13 @@ int bdrv_readv_vmstate(BlockDriverState *bs,
>> QEMUIOVector *qiov, int64_t pos)
>>       return bdrv_rw_vmstate(bs, qiov, pos, true);
>>   }
>>   -static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState
>> *bs)
>> +static int coroutine_fn
>> bdrv_co_finalize_save_vmstate(BlockDriverState *bs)
>>   {
>>       int err;
>>       BdrvSaveVMState *state = bs->savevm_state;
>>         if (bs->drv->bdrv_save_vmstate == NULL && bs->file != NULL) {
>> -        return bdrv_co_finalize_vmstate(bs->file->bs);
>> +        return bdrv_co_finalize_save_vmstate(bs->file->bs);
>>       }
>>       if (state == NULL) {
>>           return 0;
>> @@ -2851,6 +3025,51 @@ static int coroutine_fn
>> bdrv_co_finalize_vmstate(BlockDriverState *bs)
>>       return err;
>>   }
>>   +static int coroutine_fn
>> bdrv_co_finalize_load_vmstate(BlockDriverState *bs)
>> +{
>> +    int err;
>> +    BdrvLoadVMState *state = bs->loadvm_state;
>> +    BdrvLoadVMChunk *c, *tmp;
>> +
>> +    if (bs->drv->bdrv_load_vmstate == NULL && bs->file != NULL) {
>> +        return bdrv_co_finalize_load_vmstate(bs->file->bs);
>> +    }
>> +    if (state == NULL) {
>> +        return 0;
>> +    }
>> +
>> +    aio_task_pool_wait_all(state->pool);
>> +    err = aio_task_pool_status(state->pool);
>> +    aio_task_pool_free(state->pool);
>> +
>> +    QLIST_FOREACH(c, &state->loading, list) {
>> +        assert(1);  /* this list must be empty as all tasks are
>> committed */
>
> assert(1) never fail, abort() you mean..
>
> or better assert(QLIST_EMPTY(&state->loading))
>
yep!

>> +    }
>> +    QLIST_FOREACH_SAFE(c, &state->chunks, list, tmp) {
>> +        QLIST_REMOVE(c, list);
>> +        bdrv_free_loadvm_chunk(c);
>> +    }
>> +
>> +    g_free(state);
>> +
>> +    bs->loadvm_state = NULL;
>> +
>> +    return err;
>> +}
>> +
>> +static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
>> +{
>> +    int err1 = bdrv_co_finalize_save_vmstate(bs);
>> +    int err2 = bdrv_co_finalize_load_vmstate(bs);
>> +    if (err1 < 0) {
>> +        return err1;
>> +    }
>> +    if (err2 < 0) {
>> +        return err2;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int coroutine_fn bdrv_finalize_vmstate_co_entry(void *opaque)
>>   {
>>       return bdrv_co_finalize_vmstate(opaque);
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index f90f0e8b6a..0942578a74 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -788,6 +788,7 @@ struct BdrvChild {
>>       typedef struct BdrvSaveVMState BdrvSaveVMState;
>> +typedef struct BdrvLoadVMState BdrvLoadVMState;
>>     /*
>>    * Note: the function bdrv_append() copies and swaps contents of
>> @@ -955,6 +956,8 @@ struct BlockDriverState {
>>         /* Intermediate buffer for VM state saving from snapshot
>> creation code */
>>       BdrvSaveVMState *savevm_state;
>> +    /* Intermediate buffer for VM state loading */
>> +    BdrvLoadVMState *loadvm_state;
>>   };
>>     struct BlockBackendRootState {
>>
>
> Also, need call finalize from blk_load_vmstate(), like it's done for
> blk_save_vmstate().
>
good catch!

