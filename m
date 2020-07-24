Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89132065C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M3QZW0+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89132065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuqg-0000cY-5v
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyuq4-0000BI-Jh; Fri, 24 Jul 2020 06:22:04 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com
 ([40.107.0.137]:42800 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyuq0-0008C0-IC; Fri, 24 Jul 2020 06:22:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf8paoB7aFZvw/1pFCMd1VrYLpGxl2+VTB9Q0PkEknxj4hHu3feoXdqSPNYol+/ohp5xcfbhCvaPyfbF0ffXrI5PwZR5HxHzg/arTeNqbckA23qfCFQ+8QLnoZk6fXrGTMoDSvgEnTed5Bv5A6vE/eYkEEAd2uIsPG4rXURMu4jTAcNQxTmZYRcSqPSeSfg4SmkrxOw8jb4ZvG9EUWefh7XKgB8IfjskWc4QvOL3l+1wEJ7QvblruM7VxEuElLfxDH7mNVG4T1iJiX9kAVGwywBj6yocdsnoe4prGJ5/p5ztJpGPcgXBLTGRrDqNc6Jadze+yGA0ZSCWnW0sKvYM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw9SOp0cGsRcA+cfJnr/XcR9GqLZP+6kHtqLSFBSIFU=;
 b=g2cT8w7yfVd8Bz1XsDyslvTSGTf4BnNcYDRf2L7NgnXMpQm8idSJr8N/S2m34IqOEzUzIjz8e2SC0QrXLaf4phwawhVinor2dsd671V8r2wXiyZKTS3gSktehzdwnIVetVSvOzvFpXvU1YuLGo1FCpSCSk897N9d6wdezxgDHCQPju+ekFVgMDc5rxm85ZdzoJo4ga+maeEMK48CCz2o36uGJquMJ2kFcQKoIo1Vr2IxbdCey5RxUAuuJoh01COySiDQlW/0M3u2CNFMs5Kpy5Ot6KI64fOCysYy2hxAGjxC0aNoASbVKTskFpV0AOfs7v4QcIBfhl//WPv6IqxoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw9SOp0cGsRcA+cfJnr/XcR9GqLZP+6kHtqLSFBSIFU=;
 b=M3QZW0+pHo4LGdXYr511BOwTkSDHgQUrQ6C0/jONyaiHrtOOpGdYis8W46+gTgKUSKfqoOVHuwDX8z5b3HBxMhRhxEPDN/GkVU+Y5xkqTAKftmy+kiEOsKQWD0vGDBYm46192UzVUN++aJdCdyc/q5EFBMH5PjV+rnPmAzkL8Ww=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3895.eurprd08.prod.outlook.com (2603:10a6:20b:81::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:21:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 10:21:54 +0000
Subject: Re: [PATCH 1/3] block/nbd: allow drain during reconnect attempt
To: qemu-block@nongnu.org
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
 <20200720090024.18186-2-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2992ec89-25b2-fcad-9a68-02b9e05cbf5c@virtuozzo.com>
Date: Fri, 24 Jul 2020 13:21:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200720090024.18186-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0138.eurprd04.prod.outlook.com (2603:10a6:207::22)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM3PR04CA0138.eurprd04.prod.outlook.com (2603:10a6:207::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 10:21:54 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4145d41-3edd-47cb-54a1-08d82fbb6361
X-MS-TrafficTypeDiagnostic: AM6PR08MB3895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB38954B7AE5FFD74171D5930DC1770@AM6PR08MB3895.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHBiTvbyuphFU4mWLJ1L5k++GjBhUBn3Xy/ftLku2D2FVYKLgH2YzR+eKkown3Hq9I5iUf+BPE61eGdzM0WA/RxoLnYRrD6Jv2yGGgKfTQ4mpziLl3dBGbkXxWozT44Pq1ldxiFkZrlNYUUM+2x8kg9gTS6JkQQTSdNkCXfBapk3zyrJBnmQm7ZST91InxBcichEKMa9KxacF3n1GanzJhQqnJMWTV8Gnm1CM2fi1y4k3BLX8BBCjZnggH5NsQc0M3a5X5Lm7DgHjcjpUiQz7e4OCDxvPWZplBeLT0S61wPpzHB6MJyDsGjYuyCeUmRsvquUwmxZ9+9tVj1AqHwZT6tXe3Iu9McoR4CtZQwE4YlptX4sqqXFkXhpfgek8gQ7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39840400004)(136003)(376002)(366004)(8936002)(6486002)(4326008)(66476007)(66556008)(186003)(6916009)(86362001)(66946007)(26005)(36756003)(956004)(2616005)(31696002)(8676002)(16576012)(316002)(16526019)(31686004)(107886003)(2906002)(5660300002)(52116002)(83380400001)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Di4V8QAsCz55jiDxjqsv2hjGqIHbxSTBJw0G7Najcco5NA+ZCNSHyTtq2I6BQJeq4MvgGkW0wxFSkAGEq01HR/YhEqs3Ba4o6VUz9tmTuutPWQldrXonUly28KiQnBv3bmPqSaTUnxVkPFstvneS8AgGUrFQ6rt4iHq3TEoLVSlrdE+j3NxKftpuQkK8Kjw6+Nl00q9DffYKdTeZdgx9x9rdqCpR7Ms5chWSkC3t+tjLZheU2dm4mLgVxGjBVAN13p0LJiPrSdQ8ew1g4+pLtcoTUTnWyHAKCEpnNGtlPHwx2kWeGOatB0hwWSQdCj9n91yN/VQYczGZ8Z5aKygdv2MiAWN4fy8vtDWM1FXAwfS8oc1Jbo4SRQp5opx54ghUylD5VA78K213uUjZ36M5ZAm0dqk+cHenwj7U3d9kl2O/VBOF6K8PW291sDuHjVcwXMgiLgZapfArLzfpuuPo8t4t36mdeQ/rvE/5ed78kJdxdW2aHPcWj9XH21dGh+/j
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4145d41-3edd-47cb-54a1-08d82fbb6361
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:21:54.8276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X+lcPAApI0gSnojX3qlcnsNcor9LgudnCRqWSu4AFnFgSxBWyNIhe4D2pFcfC/omxt770LGbrQznsGJCXMhX6+cKV3kjJv3pwgTT+kjCuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3895
Received-SPF: pass client-ip=40.107.0.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:21:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.07.2020 12:00, Vladimir Sementsov-Ogievskiy wrote:
> It should be to reenter qio_channel_yield() on io/channel read/write
> path, so it's safe to reduce in_flight and allow attaching new aio
> context. And no problem to allow drain itself: connection attempt is
> not a guest request. Moreover, if remote server is down, we can hang
> in negotiation, blocking drain section and provoking a dead lock.
> 
> How to reproduce the dead lock:
> 
> 1. Create nbd-fault-injector.conf with the following contents:
> 
> [inject-error "mega1"]
> event=data
> io=readwrite
> when=before
> 
> 2. In one terminal run nbd-fault-injector in a loop, like this:
> 
> n=1; while true; do
>      echo $n; ((n++));
>      ./nbd-fault-injector.py 127.0.0.1:10000 nbd-fault-injector.conf;
> done
> 
> 3. In another terminal run qemu-io in a loop, like this:
> 
> n=1; while true; do
>      echo $n; ((n++));
>      ./qemu-io -c 'read 0 512' nbd+tcp://127.0.0.1:10000;
> done
> 
> After some time, qemu-io will hang trying to drain, for example, like
> this:
> 
>   #3 aio_poll (ctx=0x55f006bdd890, blocking=true) at
>      util/aio-posix.c:600
>   #4 bdrv_do_drained_begin (bs=0x55f006bea710, recursive=false,
>      parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:427
>   #5 bdrv_drained_begin (bs=0x55f006bea710) at block/io.c:433
>   #6 blk_drain (blk=0x55f006befc80) at block/block-backend.c:1710
>   #7 blk_unref (blk=0x55f006befc80) at block/block-backend.c:498
>   #8 bdrv_open_inherit (filename=0x7fffba1563bc
>      "nbd+tcp://127.0.0.1:10000", reference=0x0, options=0x55f006be86d0,
>      flags=24578, parent=0x0, child_class=0x0, child_role=0,
>      errp=0x7fffba154620) at block.c:3491
>   #9 bdrv_open (filename=0x7fffba1563bc "nbd+tcp://127.0.0.1:10000",
>      reference=0x0, options=0x0, flags=16386, errp=0x7fffba154620) at
>      block.c:3513
>   #10 blk_new_open (filename=0x7fffba1563bc "nbd+tcp://127.0.0.1:10000",
>      reference=0x0, options=0x0, flags=16386, errp=0x7fffba154620) at
>      block/block-backend.c:421
> 
> And connection_co stack like this:
> 
>   #0 qemu_coroutine_switch (from_=0x55f006bf2650, to_=0x7fe96e07d918,
>      action=COROUTINE_YIELD) at util/coroutine-ucontext.c:302
>   #1 qemu_coroutine_yield () at util/qemu-coroutine.c:193
>   #2 qio_channel_yield (ioc=0x55f006bb3c20, condition=G_IO_IN) at
>      io/channel.c:472
>   #3 qio_channel_readv_all_eof (ioc=0x55f006bb3c20, iov=0x7fe96d729bf0,
>      niov=1, errp=0x7fe96d729eb0) at io/channel.c:110
>   #4 qio_channel_readv_all (ioc=0x55f006bb3c20, iov=0x7fe96d729bf0,
>      niov=1, errp=0x7fe96d729eb0) at io/channel.c:143
>   #5 qio_channel_read_all (ioc=0x55f006bb3c20, buf=0x7fe96d729d28
>      "\300.\366\004\360U", buflen=8, errp=0x7fe96d729eb0) at
>      io/channel.c:247
>   #6 nbd_read (ioc=0x55f006bb3c20, buffer=0x7fe96d729d28, size=8,
>      desc=0x55f004f69644 "initial magic", errp=0x7fe96d729eb0) at
>      /work/src/qemu/master/include/block/nbd.h:365
>   #7 nbd_read64 (ioc=0x55f006bb3c20, val=0x7fe96d729d28,
>      desc=0x55f004f69644 "initial magic", errp=0x7fe96d729eb0) at
>      /work/src/qemu/master/include/block/nbd.h:391
>   #8 nbd_start_negotiate (aio_context=0x55f006bdd890,
>      ioc=0x55f006bb3c20, tlscreds=0x0, hostname=0x0,
>      outioc=0x55f006bf19f8, structured_reply=true,
>      zeroes=0x7fe96d729dca, errp=0x7fe96d729eb0) at nbd/client.c:904
>   #9 nbd_receive_negotiate (aio_context=0x55f006bdd890,
>      ioc=0x55f006bb3c20, tlscreds=0x0, hostname=0x0,
>      outioc=0x55f006bf19f8, info=0x55f006bf1a00, errp=0x7fe96d729eb0) at
>      nbd/client.c:1032
>   #10 nbd_client_connect (bs=0x55f006bea710, errp=0x7fe96d729eb0) at
>      block/nbd.c:1460
>   #11 nbd_reconnect_attempt (s=0x55f006bf19f0) at block/nbd.c:287
>   #12 nbd_co_reconnect_loop (s=0x55f006bf19f0) at block/nbd.c:309
>   #13 nbd_connection_entry (opaque=0x55f006bf19f0) at block/nbd.c:360
>   #14 coroutine_trampoline (i0=113190480, i1=22000) at
>      util/coroutine-ucontext.c:173
> 
> Note, that the hang may be
> triggered by another bug, so the whole case is fixed only together with
> commit "block/nbd: on shutdown terminate connection attempt".
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 65a4f56924..49254f1c3c 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -280,7 +280,18 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>           s->ioc = NULL;
>       }
>   
> +    bdrv_dec_in_flight(s->bs);
>       s->connect_status = nbd_client_connect(s->bs, &local_err);
> +    s->wait_drained_end = true;
> +    while (s->drained) {
> +        /*
> +         * We may be entered once from nbd_client_attach_aio_context_bh
> +         * and then from nbd_client_co_drain_end. So here is a loop.
> +         */
> +        qemu_coroutine_yield();
> +    }
> +    bdrv_inc_in_flight(s->bs);

My next version of non-blocking connect will need nbd_establish_connection() to be above bdrv_dec_in_flight(). So, I want to resend this anyway.

> +
>       error_free(s->connect_err);
>       s->connect_err = NULL;
>       error_propagate(&s->connect_err, local_err);
> 


-- 
Best regards,
Vladimir

