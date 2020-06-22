Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA43DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9726720738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kV0IwuUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9726720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQxZ-0005Qm-So
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jnQwf-0004eY-J7; Mon, 22 Jun 2020 14:13:26 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com
 ([40.107.21.107]:40641 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jnQwc-00059S-EH; Mon, 22 Jun 2020 14:13:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gczjOm2IHK7e7gFg7taXJqAoQvc/ee4NTfYnQDuL+KnW/75dsJnT1noQ+OCViCLtpuhlsthTGQJ4Y1/xJyk+6OL/Ubtudek/pJqMpQLGVfRFJXyfNPko86k1+VY1ZnIcVirB+sWLrkmbxnSnJngXG/l7C5+rJev/wXgpd7eJxocvql7FIZk9M8NJTKTt06RZJEsCM8ujfyXk/T5zrp2lntU9wz7A2LRrkboG/EfuFQ9LdRSszTqS9JtFxkFztpTZMdeGNOU/l/EBJ1IVf0CflWGqdfu819yXxCFSPvIbwoGzf62fetL3qFD5Nxsn2rxk+pIi39qdw6+JqZnk+dxIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL0CsJcsSJy/1UkRp8DLtnsZaihVdWR7ecuEXq1zn/U=;
 b=gA/ldX8ULv10EN0j7DcVe/SxKtWdU+g+F0rlb0O2vVbqTFNzxSbxtQpR0i5zlrdCiVGZeOq1Rk2V0kvYyk3d2Ers9+cE0NAtByuylmQz7AmjUgl4DEEOmf25xqo6Xmfq+Agbc+4C+DXP347/XRlpNVDmVKzC4fSQ096jVQ/guKrrNa5HBJtNA7lX+DibvUAg1956n31rF1CZRyAgr/P4NcasHn1gh1p9wkMI+yzquuodIjB9+vFXC94ltxyOVK/YW3bNAkSBEIEcnZhoig5or4lOdD+Hd7+0tikkFOS/XSqq+QecYrVWjFfxKKWTMXqt7ueWbwro0EQ86cJRGkL1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL0CsJcsSJy/1UkRp8DLtnsZaihVdWR7ecuEXq1zn/U=;
 b=kV0IwuUstD5DyUncjKd0JN1ZEgEmAcDBeQ1G24hzqQU22PNJYUXdtiv+6kqHQGoDltuYheuxeXy/+TMxXJuVfN+dQMcn0o7a4rdcb7SvhdT0ux02K+CpCEkUk8HvBbDF40f8JzmhEZEcIcCfg06Bn/YDkmq6DM/ktS2TuJxG1u8=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 18:13:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 18:13:18 +0000
Subject: Re: [PATCH 7/6] block/io: improve loadvm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200619100708.30440-1-den@openvz.org>
 <20200622083303.18665-1-den@openvz.org>
 <f1afc4ce-14ac-443d-4c7a-de045d7fe01b@virtuozzo.com>
 <551fc511-da47-5003-3b1d-a64392e30b2d@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fdce0836-12aa-53d3-cc75-f8ac192d247e@virtuozzo.com>
Date: Mon, 22 Jun 2020 21:13:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <551fc511-da47-5003-3b1d-a64392e30b2d@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0023.eurprd07.prod.outlook.com
 (2603:10a6:200:42::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.72) by
 AM4PR0701CA0023.eurprd07.prod.outlook.com (2603:10a6:200:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12 via Frontend
 Transport; Mon, 22 Jun 2020 18:13:18 +0000
X-Originating-IP: [185.215.60.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde761ce-dfff-436f-cf6f-08d816d7f0c0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54942E93ABC6E3D8BA682A80C1970@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2k0lYfXmQVGvC4/TyIex1EqU188C9hLHZJdF0j9/WUMWJ1bQVwo71F6p6Ms9ArPGiakxJGJjKO921PMX4U99sjioNKcm9YC6FkGQ+Ua6pe81OE9y4wQl+p+611Y3s87vUTF2PrJEvTDGa6JruED6yS0IMxMd9a4KAnqy0C8/2iXPlfuA7aZUcBLMqpdIKdtd2vnyi3XPtfO5ha07vJW6ew6Jdv1RhgPvmfuscJUrjhHEmWwZPj2ZTeiIjtAKLIvI9jzAzAibP4pTYzhqS9LqFAQjhYPBHYBaJnkhO1IDxyGE5R8TnFBZA+Gi//XlCKrT1z47SHinXy57dZyY5GeEYJpe5hD+TjO0lYR5Wjcq+RqY4ftC+ScqG5u+zrkompB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(39840400004)(396003)(376002)(54906003)(2906002)(66556008)(5660300002)(66946007)(66476007)(107886003)(31696002)(83380400001)(4326008)(86362001)(8676002)(956004)(6486002)(36756003)(478600001)(316002)(16576012)(16526019)(26005)(186003)(53546011)(52116002)(31686004)(8936002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ve6bVJG9UE28hhNi9A9f0e2e2mXQirp1VctNhYmwT5c0q1R0uMhUEtnwvT8TUWICb9OD0tgfj49z7HNhClGWAEzBzRvQJoXNTz2R7rREUmmIvpd4H8qkSigOPKsJjJuG3hRfuPAHcUk/hAwXBE5lUZUY/wWoVXvt+JRXHHoLJh43qUk6lmF0JnmPjj+5/WdDxPM4ezNYab2CTU+glIeDZNYMtPhitQ/pIfb/qWxABhYugk/Ya5AEJk+0/IFtl5EjkIvZ51BG+Yxk5WPicutQpyfAdsDb0MFMMogOUoX6K71YxQQtPtP6jdfC69xSjIf1f9knqPZ0Avfg+D0QMLiuDpZcqy8FJTVwNJLbVrj2DJ5+Jh5R2D/N9gO7wLoVSWnYqiJWuaaZ1IE/1iftmjKRuJE6zuvlYx6J2COLcjCbT5cEhiiNewwUPwzMw8lkJ69+2ecBSzbiKoKzafqjpm/NSR3K2tjM5GrCkuOhewA0Uh8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde761ce-dfff-436f-cf6f-08d816d7f0c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 18:13:18.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kb71WTLA8CKPyvFUqDp48xldgyVMUtowc2egv/ocL488kUQjQ3uvpjUyfxzQ7Qme0kH5v+Skj7463HqvBoxCY6zeDsGEJd6FMqmJKnWW8tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.21.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 14:13:19
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

22.06.2020 20:17, Denis V. Lunev wrote:
> On 6/22/20 8:02 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 22.06.2020 11:33, Denis V. Lunev wrote:
>>> This patch creates intermediate buffer for reading from block driver
>>> state and performs read-ahead to this buffer. Snapshot code performs
>>> reads sequentially and thus we know what offsets will be required
>>> and when they will become not needed.
>>>
>>> Results are fantastic. Switch to snapshot times of 2GB Fedora 31 VM
>>> over NVME storage are the following:
>>>                   original     fixed
>>> cached:          1.84s       1.16s
>>> non-cached:     12.74s       1.27s
>>>
>>> The difference over HDD would be more significant :)
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Fam Zheng <fam@euphon.net>
>>> CC: Juan Quintela <quintela@redhat.com>
>>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>>
>>>    block/io.c                | 225 +++++++++++++++++++++++++++++++++++++-
>>>    include/block/block_int.h |   3 +
>>>    2 files changed, 225 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/io.c b/block/io.c
>>> index 71a696deb7..bb06f750d8 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -2739,6 +2739,180 @@ static int
>>> bdrv_co_do_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>>>        }
>>>    }
>>>    +
>>> +typedef struct BdrvLoadVMChunk {
>>> +    void *buf;
>>> +    uint64_t offset;
>>> +    ssize_t bytes;
>>> +
>>> +    QLIST_ENTRY(BdrvLoadVMChunk) list;
>>> +} BdrvLoadVMChunk;
>>> +
>>> +typedef struct BdrvLoadVMState {
>>> +    AioTaskPool *pool;
>>> +
>>> +    int64_t offset;
>>> +    int64_t last_loaded;
>>> +
>>> +    int chunk_count;
>>> +    QLIST_HEAD(, BdrvLoadVMChunk) chunks;
>>> +    QLIST_HEAD(, BdrvLoadVMChunk) loading;
>>> +    CoMutex lock;
>>> +    CoQueue waiters;
>>> +} BdrvLoadVMState;
>>> +
>>> +typedef struct BdrvLoadVMStateTask {
>>> +    AioTask task;
>>> +
>>> +    BlockDriverState *bs;
>>> +    BdrvLoadVMChunk *chunk;
>>> +} BdrvLoadVMStateTask;
>>> +
>>> +static BdrvLoadVMChunk *bdrv_co_find_loadvmstate_chunk(int64_t pos,
>>> +
>>> BdrvLoadVMChunk *c)
>>> +{
>>> +    for (; c != NULL; c = QLIST_NEXT(c, list)) {
>>> +        if (c->offset <= pos && c->offset + c->bytes > pos) {
>>> +            return c;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static void bdrv_free_loadvm_chunk(BdrvLoadVMChunk *c)
>>> +{
>>> +    qemu_vfree(c->buf);
>>> +    g_free(c);
>>> +}
>>> +
>>> +static coroutine_fn int bdrv_co_vmstate_load_task_entry(AioTask *task)
>>> +{
>>> +    int err = 0;
>>> +    BdrvLoadVMStateTask *t = container_of(task, BdrvLoadVMStateTask,
>>> task);
>>> +    BdrvLoadVMChunk *c = t->chunk;
>>> +    BdrvLoadVMState *state = t->bs->loadvm_state;
>>> +    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, c->buf, c->bytes);
>>> +
>>> +    bdrv_inc_in_flight(t->bs);
>>> +    err = t->bs->drv->bdrv_load_vmstate(t->bs, &qiov, c->offset);
>>> +    bdrv_dec_in_flight(t->bs);
>>> +
>>> +    qemu_co_mutex_lock(&state->lock);
>>> +    QLIST_REMOVE(c, list);
>>> +    if (err == 0) {
>>> +        QLIST_INSERT_HEAD(&state->chunks, c, list);
>>> +    } else {
>>> +        bdrv_free_loadvm_chunk(c);
>>> +    }
>>> +    qemu_co_mutex_unlock(&state->lock);
>>> +    qemu_co_queue_restart_all(&state->waiters);
>>> +
>>> +    return err;
>>> +}
>>> +
>>> +static void bdrv_co_start_loadvmstate(BlockDriverState *bs,
>>> +                                      BdrvLoadVMState *state)
>>> +{
>>> +    int i;
>>> +    size_t buf_size = MAX(bdrv_get_cluster_size(bs), 1 * MiB);
>>> +
>>> +    qemu_co_mutex_assert_locked(&state->lock);
>>> +    for (i = state->chunk_count; i < BDRV_VMSTATE_WORKERS_MAX; i++) {
>>> +        BdrvLoadVMStateTask *t = g_new(BdrvLoadVMStateTask, 1);
>>> +
>>> +        *t = (BdrvLoadVMStateTask) {
>>> +            .task.func = bdrv_co_vmstate_load_task_entry,
>>> +            .bs = bs,
>>> +            .chunk = g_new(BdrvLoadVMChunk, 1),
>>> +        };
>>> +
>>> +        *t->chunk = (BdrvLoadVMChunk) {
>>> +            .buf = qemu_blockalign(bs, buf_size),
>>> +            .offset = state->last_loaded,
>>> +            .bytes = buf_size,
>>> +        };
>>> +        /* FIXME: tail of stream */
>>> +
>>> +        QLIST_INSERT_HEAD(&state->loading, t->chunk, list);
>>> +        state->chunk_count++;
>>> +        state->last_loaded += buf_size;
>>> +
>>> +        qemu_co_mutex_unlock(&state->lock);
>>> +        aio_task_pool_start_task(state->pool, &t->task);
>>
>> Hmm, so, we unlock the mutex here. Am I missing something, or if there
>> are
>> two parallel load-state requests in parallel (yes, this shouldn't happen
>> with current migration code, but if don't care at all the mutex is not
>> needed),
>>
>> we may have two such loops in parallel, which will create more than
>> BDRV_VMSTATE_WORKERS_MAX chunks, as each has own local "i" variable?
> 
> I could stall on waiting free slot in the pool (technically)
> while pool completion will need the lock. This should
> NOT happen with the current arch, but would be better
> to do things correctly, i.e. drop the lock.
> 
>>
>>> +        qemu_co_mutex_lock(&state->lock);
>>> +    }
>>> +}
>>> +
>>> +static int bdrv_co_do_load_vmstate(BlockDriverState *bs,
>>> QEMUIOVector *qiov,
>>> +                                   int64_t pos)
>>> +{
>>> +    BdrvLoadVMState *state = bs->loadvm_state;
>>> +    BdrvLoadVMChunk *c;
>>> +    size_t off;
>>> +
>>> +    if (state == NULL) {
>>> +        if (pos != 0) {
>>> +            /* Normally this branch is not reachable from migration */
>>> +            return bs->drv->bdrv_load_vmstate(bs, qiov, pos);
>>> +        }
>>> +
>>> +        state = g_new(BdrvLoadVMState, 1);
>>> +        *state = (BdrvLoadVMState) {
>>> +            .pool = aio_task_pool_new(BDRV_VMSTATE_WORKERS_MAX),
>>> +            .chunks = QLIST_HEAD_INITIALIZER(state->chunks),
>>> +            .loading = QLIST_HEAD_INITIALIZER(state->loading),
>>> +        };
>>> +        qemu_co_mutex_init(&state->lock);
>>> +        qemu_co_queue_init(&state->waiters);
>>> +
>>> +        bs->loadvm_state = state;
>>> +    }
>>> +
>>> +    if (state->offset != pos) {
>>> +        /* Normally this branch is not reachable from migration */
>>> +        return bs->drv->bdrv_load_vmstate(bs, qiov, pos);
>>> +    }
>>> +
>>> +    off = 0;
>>> +    qemu_co_mutex_lock(&state->lock);
>>> +    bdrv_co_start_loadvmstate(bs, state);
>>> +
>>> +    while (off < qiov->size && aio_task_pool_status(state->pool) ==
>>> 0) {
>>> +        c = bdrv_co_find_loadvmstate_chunk(pos,
>>> QLIST_FIRST(&state->chunks));
>>> +        if (c != NULL) {
>>> +            ssize_t chunk_off = pos - c->offset;
>>> +            ssize_t to_copy = MIN(qiov->size - off, c->bytes -
>>> chunk_off);
>>> +
>>> +            qemu_iovec_from_buf(qiov, off, c->buf + chunk_off,
>>> to_copy);
>>> +
>>> +            off += to_copy;
>>> +            pos += to_copy;
>>> +
>>> +            if (pos == c->offset + c->bytes) {
>>> +                state->chunk_count--;
>>> +                /* End of buffer, discard it from the list */
>>> +                QLIST_REMOVE(c, list);
>>> +                bdrv_free_loadvm_chunk(c);
>>> +            }
>>> +
>>> +            state->offset += to_copy;
>>> +            continue;
>>> +        }
>>> +
>>> +        c = bdrv_co_find_loadvmstate_chunk(pos,
>>> QLIST_FIRST(&state->loading));
>>> +        if (c != NULL) {
>>> +            qemu_co_queue_wait(&state->waiters, &state->lock);
>>> +            continue;
>>> +        }
>>> +
>>> +        bdrv_co_start_loadvmstate(bs, state);
>>
>> Hmm, so, you assume that if we are in a loop, we'll definitely find
>> our chunk at some moment.
>> It should work with normal migration stream, sequentially reading
>> chunk by chunk. But if not,
>> it may hang:
>>
>> Consider two reads at same position, running in parallel: they both
>> pass "state->offset != pos"
>> check and wait on mutex. Then the first one will go into critical
>> section, find and remove
>> corresponding chunk. Then the second will go into critical section and
>> loop forever, because
>> corresponding chunk will never be generated again.
>>
>> So, seems, we should check (state->offset == pos) on each iteration,
>> or something like this.
>>
> we can. But the reader is synchronous and could not
> issue 2 requests. Not a problem.
> 

I think, it's OK to rely on current one-synchronous-reader arch, but some
relating comments/assertions won't hurt.


-- 
Best regards,
Vladimir

