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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9197C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919BD20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FK+Spamw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919BD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuLF-0002lw-Qd
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyuKL-0001sC-NK; Fri, 24 Jul 2020 05:49:18 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:30606 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyuKH-0002D6-GI; Fri, 24 Jul 2020 05:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8YXhtcVcA4FALNLIyu+E1cgcdVRswsS/e+T40BBEaLKxPKf2OlNf9PgpCj5eSjWPsRDZwNN9/rZg+O/kXNofGBoHnMMOOm5VtDX3tM8fr6n6lsA9mvc3oC/w5fVSdwCPvirpjlXAe3t2lFqcareFCoQZAGKX0wrMazS5kSnsKCerVSVuBlcOeZXocokOK4qDzbIHZVB2Vm79nadX3NbFyeOo67ysOnXhQ9uX+1izlvG6xsno9HQbjCPmZ6bqG7ZJHAMhPp6u4pNnOitNKdQW1wjN7tyt98zzJR4OlxVKrlCXtZJ5j1jvjZjtl2kzMHdulatCF1cvuw4O5RcKzhiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Zbfhp1JE04atgTX7Y6iIQUC3AvuTNnWTzwJoImT+I=;
 b=FJAIlUFY17EC2b2tO26fFU//DihrstHc0Lc9BeykrpBDnF02KByvRoDyuXVJbzc2/OVIem33fEIN+CwNkB66tJwSMfgKlaLRPpxv503KciOTGFOFiw4axyTLffCzOXSUCj0q3mvHbEUEO5zphPZ0ZdYjpB4Od3qw8skJU4jDATcAle529pOBcZL/6KXbLKrlrXyssl/oWYcAs6iPg6KQWFgA9t9XZ0Kt5LNQmKoEz+/9hC4kPJn4S0+y1H9jZbw+n4JLOgqBHkIjyuCgN7Xbdpq8wqc0pTX0gH46XuvxovmvkxUqDpmkNCdFY0Omz5gdScOkIj1ijFdWj01UZusd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Zbfhp1JE04atgTX7Y6iIQUC3AvuTNnWTzwJoImT+I=;
 b=FK+SpamwDLvOH2QgS9us+5Zr2J3+3xDSBSxW9oXLoYfKITPLFc1lLVGUAXc9DqSsJ7LdP4NTxAIuRemsa69oCqd0ZtXwlZlpcju+wuX6GBNdb9Fr9IalECIlVYwh0+j+PGs20ezNfoMHyPCVOl8CB2rqfdqHlKHBNlQE2FMfZOk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2531.eurprd08.prod.outlook.com (2603:10a6:203:a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 09:49:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 09:49:08 +0000
Subject: Re: [PATCH 1/3] block/nbd: allow drain during reconnect attempt
To: qemu-block@nongnu.org
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
 <20200720090024.18186-2-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8ad68b21-38a2-8fd1-59e5-e1713075c95b@virtuozzo.com>
Date: Fri, 24 Jul 2020 12:49:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200720090024.18186-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:208:55::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 09:49:08 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40f84dd-e802-4e00-689b-08d82fb6cf98
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2531F5165DC403DDE2D3E4C9C1770@AM5PR0802MB2531.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeXglUUvjHmo+PxLROneBIW0Lo/hU/msH0/GQwxzleLhcmMqLsPyMLSJnO3X9NYIkWkw511R9z5seThxd7dTt+LDOkux4wVWdv6z7RaRfUI2UX0k96sfhD69l3QGeXy5X0rWatspoTz6FtKUZGXUVLc/YPFUkHpG7nqaERtkNJ0H73MFp6V/P06LangCf0vkB0ooCGbgI0tP/200xQsh+ZJAX0rksCVP2fL6tOl4i5iEfLW71ewDATtyswptwDxRByfui4gOPWrV/pI+/MepXsHsvvQguOS32TS7a44crET4h/7uZ0Km8Cut5xGlXkLyqzRUWMVPnXynTtvALNAJfuWIkBA9aXGHofcjpk4GnmUsgvta7Td+yZF/4rPJwmko
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(31696002)(66476007)(66556008)(52116002)(2616005)(86362001)(956004)(66946007)(36756003)(4326008)(6916009)(8676002)(5660300002)(31686004)(478600001)(8936002)(316002)(16576012)(107886003)(2906002)(83380400001)(6486002)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cf68NkhGotkiNLb3epNHbtLco9tgTA1hfuh4fE1EejCsFQ2RJ2Km9s+M/m5AkdrfvJajG2QMQYRmyTBCh8JYUZw0vm6QIuMK0nCnDdG/cBkuPeKXVsS184k7dVftTKZYCBz4ky+mlIuVQsKuFJY2qL3nv5mKVdpY/TSUCsE3+aFUjCTnp0okzBWqwXCYQrQXj33lHSqda0a6RMFrQ91Y4CQo/vW8dqdC/ljIb4pPInaX0+NBHMS9mJPopwscp/mRT/buyogJ/gdr/Vi4at5It2QK5cnZgtmscoxQth1+ZKH5kYHqEt2hcyk/5IOz//lmp9mCG1NhM2y4/ptKz/c4hQy9TTGnqjNWq5eebhawHlNvTcSgy5zX203/PchrnRODQU+BBG88ay43OkGZO0kJK/2FBLlwG6DRrLHBg5680sNfF47RdmXfpvTW8s7XwgKqCH5zVxr2up4iiFlkca40OcUzrLnEpW/OD3sp8p7REhKlQV6gRwFB0kE7igmyOeCe
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f84dd-e802-4e00-689b-08d82fb6cf98
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 09:49:08.7853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZgJq/mOFtyrmyd6VDtmRA3qmgc7bgYx7CDKEcjHnwGT8tpvRJrKMX3s6MtDMQQLR6B4u9gv/v4Mh1yhYi4WrbW6YvO+S2tww3HoOSocv/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2531
Received-SPF: pass client-ip=40.107.15.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 05:49:09
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

Hmm. This inserts yield between setting connect_status and connect_err. Don't know,
can it be a problem, but at least looks like bad design. Better to use local ret here
and set connect_status together with connect_err after the yield.

> +    s->wait_drained_end = true;
> +    while (s->drained) {
> +        /*
> +         * We may be entered once from nbd_client_attach_aio_context_bh
> +         * and then from nbd_client_co_drain_end. So here is a loop.
> +         */
> +        qemu_coroutine_yield();
> +    }
> +    bdrv_inc_in_flight(s->bs);
> +
>       error_free(s->connect_err);
>       s->connect_err = NULL;
>       error_propagate(&s->connect_err, local_err);
> 


-- 
Best regards,
Vladimir

