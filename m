Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E40C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702A2208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NNc27R02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702A2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRie-0002xy-NE
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRgu-0000ep-9l; Mon, 20 Jul 2020 05:02:32 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com
 ([40.107.20.98]:10869 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRgs-0007K9-3j; Mon, 20 Jul 2020 05:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2d+6sJ4oPfpZokuha/UFYrMMq8neKCvB+L6UbFrQkC0pvM3h16aTQp/Q6Ob9cI5moUF/qYLLLoXXhZjq6szBzFvP8Nt7YTasJpqA2bQOn3hv2DVxD2aW8XUcyUz509Tr1UhsjJkHh7CSODZcUgT61S+qBG10MhGaj+lrccN/70Fdx3MxMI3Wymp0SzbTKFs/UH9z/jJ4lUfkTB/Ka0r3GNFMVPRRSkVw1kt2b5T+0O9OsA1DPLjYdC3ZF8sC/ENZw1xF7ZdVR7y7N0PC3pxPil9oqYFvgr9Qj8oJ38+p6vNtUdM4MO4Xdt9FvWtM9a6qGgiOqpAte5TktFuEG8QMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY6rrz+rNO62ycAGdkogJZvK3B4yChCN3LipiGo7ASA=;
 b=nL+y6F+ggrKyQIfGS65es9k316cFncWzXN4n6E4LBq7jZqVxs17Ez+ishDA/l2q7Dfk1NCUbTi1ZgMFkNj+1iKLVohENXZ448NdkFuw35FxHR/5SzBMMnJ5SHH/GF2v0Q7qjFVu/olGA2gjhr1pmEHendJNnvi8BGXzejMbJzjlxvtzgR0p1mqoz64yzPHiflwlJu1wczl2uM1FBboGNyjca7PTTc89/ScSEM8QcLE3xJLbrRfB9Doi0ueGxVg5C2FpsBXLRmR3mKwHGt6X/bI4MkDXvH3MuAklVNDJZ3MTX5n6XbDiVooQyvTZQeE7EHCFybUyS4G+S3kEeCa9J1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY6rrz+rNO62ycAGdkogJZvK3B4yChCN3LipiGo7ASA=;
 b=NNc27R02efXjhboBr8nfe3w5KBwBjd9mBLCFlQaHyhsOEGC8qUX/+HPLdCGTT4xXdA8TcMk8SY6fenJZWkQ6Dlw68X25tm52K8AF5UGlf9me6hQ9HXfMCioqpbi8RjWVY2oY5Y5oriFZRTaBvih9nC+tDpMH2Jbmc7t7qsRvqls=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3157.eurprd08.prod.outlook.com (2603:10a6:209:48::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 09:02:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:02:26 +0000
Subject: Re: [PATCH 1/3] block/nbd: allow drain during reconnect attempt
To: qemu-block@nongnu.org
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
 <20200720090024.18186-2-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6da3c400-7156-e1fd-0e56-8b7fd8c55c31@virtuozzo.com>
Date: Mon, 20 Jul 2020 12:02:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200720090024.18186-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Mon, 20 Jul 2020 09:02:26 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89711c48-222e-46b0-9cfe-08d82c8b9fda
X-MS-TrafficTypeDiagnostic: AM6PR08MB3157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3157D472917D42394783855BC17B0@AM6PR08MB3157.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhlxohFVnOM7ys3X9JAogBQ1EOUkhudS2f8c1xwYmnfMGqDiFDyc+DGUoNUGqRNKW2DSSQkK+Pzguy+GA6a3dkuw89v6g4/fg6BPmK1GHNG+d9IveS/WFqOQqbuqdZQ9gUedVjAb3UB+A1gHBt4nWpChiD7EWHaVYJtKf+XxddGhW05G40vGdkdy2ymoTnJMeZ1zz5Hci7VEg8nVFR5gRRVN80vDgVimhHBc48PgisQQ2ntopcBlWTq/w1DPLvXF2a+JlykmeknCqJV+GTX90KBCfS1M1/M7lyKTagI2l1818OtUaEqIMdlHppMqrXLDjkWL76lANMbn2swLoxZrz+XI+IF6jTeb20VzEC9s9lLCdhJAUueXaVAaxFRdlMry
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39830400003)(396003)(86362001)(36756003)(5660300002)(2906002)(316002)(16576012)(6486002)(66556008)(16526019)(66476007)(26005)(478600001)(6916009)(186003)(8676002)(66946007)(52116002)(31686004)(2616005)(31696002)(956004)(83380400001)(107886003)(8936002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uwwFOLW+In9d3El09zwLoHyQBSIHsrftIMFg2ZJ2QWhUvv/UD/ocnMEquy47b4zn1hnNGXgKzpZuqAFVk5/n9DFmfo7vJIagfNunFcTG2bGVp85CSnGOE9SMATDpPrx6nDeYvqi2yXB80HVrQD9f+zRdXWpKP/omkX6ztRu2H5CgRDHk7te8RChv1BpY8e+O3aJuLVy/x5M4molQha1w0dMfYnIfiR8FE3+uSFhUsEWe4pN2YYZuwXW+VdXnJrvxn87pXfpgTZB9eJYAQERg9nkZxM0xgW6zOdPX1R1KHRmIYt1mIGT1Hc2/ABhejEl6qhFyGLxeRwyej8Jfo3fRt21MwHqReUJb89jBTOwD54NYv09UKBJ5pIG0YsRhp/r3O6KAmKYz9mSczTuRljq0YpORijkDE+xLGMaACeSwSrtQkubdvCIJvTL+iPPv++/OX/ct4/hLnP8Qw7ARFs5YKVHvkDwqGhf9yoOX8a9D/Su4Xpp1cHV/pLv2+Ulr1E33
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89711c48-222e-46b0-9cfe-08d82c8b9fda
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:02:26.7632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RhkGN965Z2e/cHWHZtvttSCRWy00vJrCIV42larquRttM7F7jqwv+r1OiExYnOQmdIxKTd18Q/rIqUc0+S8JDZ353VLvzqGgV9A4kSfU7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3157
Received-SPF: pass client-ip=40.107.20.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:02:27
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

should be safe I mean

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
> +
>       error_free(s->connect_err);
>       s->connect_err = NULL;
>       error_propagate(&s->connect_err, local_err);
> 


-- 
Best regards,
Vladimir

