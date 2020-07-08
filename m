Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6E3206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZH4wFCzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6E3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEzE-0004Ec-G1
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 14:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtEy9-0003Os-BI; Wed, 08 Jul 2020 14:38:57 -0400
Received: from mail-eopbgr150134.outbound.protection.outlook.com
 ([40.107.15.134]:45798 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtEy5-0005H2-JR; Wed, 08 Jul 2020 14:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R67BU3MGjVeZuFE+kduesZ2DSbyGceF8tOjahlYt3zF0rLsS1JBtpQv26L00oMmXcOv0G6Hc3eYnstlwBB5v3S3gi7axaFAFgRxB8o1Hwdu6mw113/KJnCSrb6cY9ULFwP2ySk0pZZRYJuZK7/zL5qHvRKjegQD/ulOVmutCYvrXbolp3FiEhcMFbl/92g3wZm/S6N0c5802bqGCeGnE18c5BMF83R4vE0++pHe9o+fQ7aRNzJu+EKkwZwcrPZXYrvEzxY9RVZn4x9vsMAU4IQO/JWHDtjWc5Yj5FOFFcg/6CzF+3q7hen+ZKnEkraVLYo74vyFqXmUL7a1Q/iiIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9rfAYADReJAHUJOCbHm+NoEoqFoCUqdmmpFOheZGy0=;
 b=dSH7PGF5PtpAKusMIDwVrlfxGjLva35X++Rc2VfOTCZwJuwOxUDXpbsDnImNJh/JAjVS24PiuZqTxoxDq0kWI47aIM7WYstBwM8DTAdJWDLdwZ8KkmmuHRII5hm/PheKW+IHHVe7RilS1Ghc/IVTNvLZz+suFftpGpxgfM/LOkhdRWNbunwYZnQnTdeMWKec+f5DwGIQYYCL8CfH8YUlUSpzPPGT+Jso7PntyNa/XXrIsU9jZKDgJ8FDYfIzz2jS56SkrbGMTO4RAQCvV+blAyDSaCrL52u5LFN3v+Bx/XMHRS+/7Sa22Ri1m3qnFlR1mGBOHF12GwRxjHIjjXiEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9rfAYADReJAHUJOCbHm+NoEoqFoCUqdmmpFOheZGy0=;
 b=ZH4wFCzf7siqccS+x4gCbS4QkkP2+GLZ0HyTtpYJIow1X8AazqoviQGMAgROwLjY+UMYtnMGfGA/9vZoM0XjQud2tZ3lgy+FCibKDC4rVPcKPW6uqp33I9qQEU9RhVLnHci0xt9X+kXDjhFiExagum2drS9gc5qkHcJwPMcEUvc=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 18:38:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 18:38:50 +0000
Subject: Re: [PATCH 7/7] block/io: improve loadvm performance
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200703173538.29296-1-den@openvz.org>
 <20200703173538.29296-8-den@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c5265d26-0f52-2c6b-673d-5add7d4b49be@virtuozzo.com>
Date: Wed, 8 Jul 2020 21:38:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200703173538.29296-8-den@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:207:5::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.17) by
 AM3PR03CA0068.eurprd03.prod.outlook.com (2603:10a6:207:5::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 18:38:49 +0000
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc0811e1-d1ba-4a2e-7443-08d8236e284d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4342567FBB1202D436D8E883C1670@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiSL1wkCTifxF5hVQqQ7Lvfej/HACyUTcRM+P+whDiMxPJjMNfM8eC8fsdFELd3087FKNGu6wlN89T7IRTQ1miWSZq33CiCYBF029o82LJ3WHqef8CHuCDgG6qkUadgYjQId7O0XP1OOeAdYwFpOPovfwVt/vEN3T6L1o4TK9pDVbtLg4swN7/aCYsxV32ieC++RHHJakrZ7qn2KJE5DhZyo0xe5Icf7m3iZoeAKwn9yw6X/txKOdaA1cwCbgbKfEOIzUuxXe3EccKq1bkHpcDWZAcPLrOmmCuxXCDNffhzR8MqrwCbq9/ZgjLqjmHN0PehcU5thNEmdVG03ZPU9RdzLDZa6P7ezq/nCIoYYv3mLkCjqUKcgpZ9fy7LBlpt3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39840400004)(136003)(31696002)(6486002)(86362001)(2616005)(26005)(5660300002)(83380400001)(478600001)(956004)(31686004)(36756003)(8936002)(8676002)(16576012)(54906003)(316002)(66946007)(186003)(66476007)(107886003)(52116002)(16526019)(4326008)(66556008)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vGGL57biQH9idpzLEXFXp2qEZANmcr1hgrYh9ahbytJvK7dZ4+r06mwQGywAXmIQHj4/Y3oTuR6Xm9UtALZMzSmbxwz+rA9B5D5Ip7IicfP609DTu8CA/Tf5TJnQBgP4zwpTjFKkHSauasS9oIiitRxnjXJS81wquRYKeuQ2Al32EcDqM+5ymL2KxXOOChyQKPB3t188qlo8kP59u/dl7sT0ix1ew1tllYEYcp2eQIMt/KKZObRk+fI1Zout1VBvkUr5B8gQIoHMeevWoEUlbVkUdzaHPM/jCgc2gvrhUM5V5KQ9DDpF+GFXGkTeu1/4snuSqalURqX4I89Y+euYjG6tF/Qrle7FTgcBubPVcyT1aiByOZuIu+451NpQU2xyQe1X9F3Qo+niR03cKn4RNqvjMqmQw+g0/6W1u4iM92I3p/tiNEFqmsThB9N6465zWQsz8uNWKW6hddECykVpaND7OknuYpLq0ugZqj02f8Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0811e1-d1ba-4a2e-7443-08d8236e284d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 18:38:50.3808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kihBjQX3CaJTpmPZyj01opNXY1ZWkAGaKAzHFA1k4aiPcndaK49+MI/dE1W/IHGjr/GnrE14jbSBj25a1xIFSDNhkSTEACgjXBTAjoUE43Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4342
Received-SPF: pass client-ip=40.107.15.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 14:38:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.07.2020 20:35, Denis V. Lunev wrote:
> This patch creates intermediate buffer for reading from block driver
> state and performs read-ahead to this buffer. Snapshot code performs
> reads sequentially and thus we know what offsets will be required
> and when they will become not needed.
> 
> Results are fantastic. Switch to snapshot times of 2GB Fedora 31 VM
> over NVME storage are the following:
>                  original     fixed
> cached:          1.84s       1.16s
> non-cached:     12.74s       1.27s
> 
> The difference over HDD would be more significant :)
> 

[..]

> +static coroutine_fn int bdrv_co_vmstate_load_task_entry(AioTask *task)
> +{
> +    int err = 0;
> +    BdrvLoadVMStateTask *t = container_of(task, BdrvLoadVMStateTask, task);
> +    BdrvLoadVMChunk *c = t->chunk;
> +    BdrvLoadVMState *state = t->bs->loadvm_state;
> +    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, c->buf, c->bytes);
> +
> +    bdrv_inc_in_flight(t->bs);
> +    err = t->bs->drv->bdrv_load_vmstate(t->bs, &qiov, c->offset);
> +    bdrv_dec_in_flight(t->bs);
> +
> +    qemu_co_mutex_lock(&state->lock);

In my understanding, we don't need this mutex. We need coroutine mutex, when there
is a critical section with an yield inside, like accessing metadata in qcow2 code.

If all the critical sections doesn't have an yield inside they should not intersect
anyway, as all these functions should be executed in coroutines in the aio context
of this bs, i.e. not in parallel iothreads simultaneously.

> +    QLIST_REMOVE(c, list);
> +    if (err == 0) {
> +        QLIST_INSERT_HEAD(&state->chunks, c, list);
> +    } else {
> +        bdrv_free_loadvm_chunk(c);
> +    }
> +    qemu_co_mutex_unlock(&state->lock);
> +    qemu_co_queue_restart_all(&state->waiters);
> +
> +    return err;
> +}

[..]

> +static int bdrv_co_do_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
> +                                   int64_t pos)
> +{
> +    BdrvLoadVMState *state = bs->loadvm_state;
> +    BdrvLoadVMChunk *c;
> +    size_t off;
> +    int64_t start_pos = pos;
> +
> +    if (state == NULL) {
> +        if (pos != 0) {
> +            goto slow_path;
> +        }
> +
> +        state = g_new(BdrvLoadVMState, 1);
> +        *state = (BdrvLoadVMState) {
> +            .pool = aio_task_pool_new(BDRV_VMSTATE_WORKERS_MAX),
> +            .chunks = QLIST_HEAD_INITIALIZER(state->chunks),
> +            .loading = QLIST_HEAD_INITIALIZER(state->loading),
> +        };
> +        qemu_co_mutex_init(&state->lock);
> +        qemu_co_queue_init(&state->waiters);
> +
> +        bs->loadvm_state = state;
> +
> +        bdrv_co_loadvmstate_start(bs);
> +    }
> +
> +    if (state->offset != pos) {
> +        goto slow_path;
> +    }
> +
> +    off = 0;
> +
> +    qemu_co_mutex_lock(&state->lock);
> +    while (off < qiov->size && aio_task_pool_status(state->pool) == 0) {
> +        c = bdrv_co_find_loadvmstate_chunk(pos, QLIST_FIRST(&state->chunks));
> +        if (c != NULL) {
> +            ssize_t chunk_off = pos - c->offset;
> +            ssize_t to_copy = MIN(qiov->size - off, c->bytes - chunk_off);
> +
> +            qemu_iovec_from_buf(qiov, off, c->buf + chunk_off, to_copy);
> +
> +            off += to_copy;
> +            pos += to_copy;
> +
> +            if (pos == c->offset + c->bytes) {
> +                state->chunk_count--;
> +                /* End of buffer, discard it from the list */
> +                QLIST_REMOVE(c, list);
> +
> +                /*
> +                 * Start loading next chunk. The slot in the pool should
> +                 * always be free for this purpose at the moment.
> +                 *
> +                 * There is a problem with the end of the stream. This code
> +                 * starts to read the data beyond the end of the saved state.
> +                 * The code in low level should be ready to such behavior but
> +                 * we will have unnecessary BDRV_VMSTATE_WORKERS_MAX chunks
> +                 * fully zeroed. This is not good, but acceptable.

As I understand, we don't know where is the end of state, yes? So, we can't avoid it anyway. Should not be a problem.

> +                 */
> +                bdrv_co_loadvmstate_next(bs, c);
> +            }
> +
> +            state->offset += to_copy;
> +            continue;
> +        }
> +
> +        c = bdrv_co_find_loadvmstate_chunk(pos, QLIST_FIRST(&state->loading));
> +        if (c != NULL) {
> +            qemu_co_queue_wait(&state->waiters, &state->lock);
> +            continue;
> +        }
> +
> +        /*
> +         * This should not happen normally. This point could be reached only
> +         * if we have had some parallel requests. Fallback to slow load.
> +         */
> +        qemu_co_mutex_unlock(&state->lock);
> +
> +slow_path:

A kind of taste, but I'd prefer to keep it in the end of the function, avoiding gotos leading to loop body.

> +        return bs->drv->bdrv_load_vmstate(bs, qiov, start_pos);
> +    }
> +    qemu_co_mutex_unlock(&state->lock);
> +
> +    return aio_task_pool_status(state->pool);
> +}
> +
>   static int coroutine_fn
>   bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>                      bool is_read)
> @@ -2752,7 +2955,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>           ret = -ENOMEDIUM;
>       } else if (drv->bdrv_load_vmstate) {
>           if (is_read) {
> -            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
> +            ret = bdrv_co_do_load_vmstate(bs, qiov, pos);
>           } else {
>               ret = bdrv_co_do_save_vmstate(bs, qiov, pos);
>           }
> @@ -2823,13 +3026,13 @@ int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>       return bdrv_rw_vmstate(bs, qiov, pos, true);
>   }
>   
> -static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
> +static int coroutine_fn bdrv_co_finalize_save_vmstate(BlockDriverState *bs)
>   {
>       int err;
>       BdrvSaveVMState *state = bs->savevm_state;
>   
>       if (bs->drv->bdrv_save_vmstate == NULL && bs->file != NULL) {
> -        return bdrv_co_finalize_vmstate(bs->file->bs);
> +        return bdrv_co_finalize_save_vmstate(bs->file->bs);
>       }
>       if (state == NULL) {
>           return 0;
> @@ -2851,6 +3054,51 @@ static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
>       return err;
>   }
>   
> +static int coroutine_fn bdrv_co_finalize_load_vmstate(BlockDriverState *bs)
> +{
> +    int err;
> +    BdrvLoadVMState *state = bs->loadvm_state;
> +    BdrvLoadVMChunk *c, *tmp;
> +
> +    if (bs->drv->bdrv_load_vmstate == NULL && bs->file != NULL) {
> +        return bdrv_co_finalize_load_vmstate(bs->file->bs);
> +    }
> +    if (state == NULL) {
> +        return 0;
> +    }
> +
> +    aio_task_pool_wait_all(state->pool);
> +    err = aio_task_pool_status(state->pool);
> +    aio_task_pool_free(state->pool);
> +
> +    QLIST_FOREACH(c, &state->loading, list) {
> +        assert(1);  /* this list must be empty as all tasks are committed */
> +    }

assert(QLIST_EMPTY(&state->loading));

> +    QLIST_FOREACH_SAFE(c, &state->chunks, list, tmp) {
> +        QLIST_REMOVE(c, list);
> +        bdrv_free_loadvm_chunk(c);
> +    }
> +
> +    g_free(state);
> +
> +    bs->loadvm_state = NULL;
> +
> +    return err;
> +}
> +
> +static int coroutine_fn bdrv_co_finalize_vmstate(BlockDriverState *bs)
> +{
> +    int err1 = bdrv_co_finalize_save_vmstate(bs);
> +    int err2 = bdrv_co_finalize_load_vmstate(bs);
> +    if (err1 < 0) {
> +        return err1;
> +    }
> +    if (err2 < 0) {
> +        return err2;
> +    }
> +    return 0;
> +}
> +
>   static int coroutine_fn bdrv_finalize_vmstate_co_entry(void *opaque)
>   {
>       return bdrv_co_finalize_vmstate(opaque);
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index f90f0e8b6a..0942578a74 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -788,6 +788,7 @@ struct BdrvChild {
>   
>   
>   typedef struct BdrvSaveVMState BdrvSaveVMState;
> +typedef struct BdrvLoadVMState BdrvLoadVMState;
>   
>   /*
>    * Note: the function bdrv_append() copies and swaps contents of
> @@ -955,6 +956,8 @@ struct BlockDriverState {
>   
>       /* Intermediate buffer for VM state saving from snapshot creation code */
>       BdrvSaveVMState *savevm_state;
> +    /* Intermediate buffer for VM state loading */
> +    BdrvLoadVMState *loadvm_state;
>   };
>   
>   struct BlockBackendRootState {
> 


-- 
Best regards,
Vladimir

