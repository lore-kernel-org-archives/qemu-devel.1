Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCAC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6232C208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ja3D7sb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6232C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRh5-0000ar-Lq
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfG-0007K7-Nc; Mon, 20 Jul 2020 05:00:50 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:22905 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfE-00076G-SE; Mon, 20 Jul 2020 05:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjfdLBWMW9I5mMXR7gAL0vzL0aS5S8CiTJ+bH8PsAGihaksDJbRFR/QCpxYd0He88VuSk4n9Mus7C81A6FeOFGQbiJH/lxMWAVDUkAOuLPFgeLdzYjLPZK4TRZKAkSIj08hpI/0gwQnnAERGhrRvmxm39pYVUsCF8vrhehQwt3AvCQV/RKUDowUqltsO+zXqq5+aigpdw4qEQ5ErPCrjDAyaxXaYPG9/OtHDXrf+gosmboDs1cmhvfNkPxxfUquoUiK+G6pd3snuuBLOmDeB+YUwE1XDIlXS14h2Xd09eFdglsFUcriQl0bJgPEc87y2FfcOf5hBfaJmbXmWxQKE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biV/oDpnBp6C3oTD6Neeubd07SsjUE/FVtiSksJaL+0=;
 b=be+n88xAYjc7E+d4Hf0w5U4ZoGTBghHoPLOgx3fB8V20e3CpyETw6VBoYgnofUUhe32+LD0d4S06GbTFAY7a33K+r37RnjRUuRnOZcJqWveY0YVDQOPoUqMKwJ43Clic68HDmN5t2jennDJTb76/1stSkswRb3vsczzpjPfGuZnA3KXJkkQo5BvYr6BEfaSn9jvx5hEXkofBFtehg9RYh1hGv+r0ovPOeuOx1AlJ5Yl8P3NruHrEiRZJjMesV5Mha1HzpAsrSfEmI/SLGwinfKdwSnsP1yWyEYOrd0rUSB2m4ZGVp7JkYy/YV7+5DmnqyzHTTb3mzsn6cmvkMswwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biV/oDpnBp6C3oTD6Neeubd07SsjUE/FVtiSksJaL+0=;
 b=ja3D7sb+Df2+ZEhqUm0EejlhyGQ42pl7xqGcOApTwdz1vsCrIaSwKNyDbJxvedbbUVfoB6Ur/vpYg849rgesqqsNWfTTkp4J2eX2eGrAFDm68Ktt3zwTDw8EU+sni3WC50eBtoKGEJQ/8XATpEBg8YK5XNZkyKdq0eR2z0e4zS8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 09:00:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:00:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] block/nbd: allow drain during reconnect attempt
Date: Mon, 20 Jul 2020 12:00:22 +0300
Message-Id: <20200720090024.18186-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200720090024.18186-1-vsementsov@virtuozzo.com>
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.179) by
 AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 09:00:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733cf195-b166-420f-1c9e-08d82c8b61be
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB37678C2B6207DC67EBA915BAC17B0@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAzeg5IltM68gnD/+tuQk7zJZ8efRSXHVzIN1Ef8fiI7o/GWX+VGCOiWjL6rygfUFTYW6q2CEp6dFGYzCA5RZfrM+ShAg0r6oPJm4t4QjiXG2bXCkp7WXsCMynnb4c79ci2UkM98zSsuHiPag8gY8KsjpvocYjwbwwqH7F+xfO1MxaNQ6qdwsQ7lCejIji1kf6MkQMcccBAJcQanvh8/yVnMWTwnJB7BlyyVT0ftfTl/s83zc1ApJgaH8SzoC/vzz5xZYKdGctpvO/8xLhfSUYwGORuo9F8O5KdwiafTf3A/nYVOURm2O+auiaJU7oDZ65ZUx8NIaFdDVAs1aYiXHggGeRRqePiTcZUkdPtqVHR76T51CqI+MmzIbo//aFze
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(366004)(376002)(346002)(396003)(136003)(316002)(52116002)(107886003)(83380400001)(186003)(16526019)(4326008)(956004)(2616005)(1076003)(69590400007)(8676002)(66946007)(66476007)(66556008)(6486002)(26005)(6916009)(36756003)(478600001)(2906002)(8936002)(6666004)(6512007)(86362001)(6506007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nwWs80rAwrV19njEDJYb9KhJvlUm0KIR6AAZOSyscdRtULeNevoilnC8q+gRVnNca2jwYicfkpJhNNH1ksST3JJP6QfFz+X2NW7yViJEOKCjfO+KRWmCxW+U2gZ6R2kHh3OoMV5tG44UEKBbzm8/f9yXLrQcq/m+1RoZFUh0BAKF/pDrkCy4SgnUBxZINZdtjAxTIkwHQ2am2AKCOqWRqe6qN6XwxU2bASufGKe56ch9ukH5k+lxfcAoVRm4CsuKYc1/9rW51LNgAr2o1ToLqOuDXUlzI3VVB9q3g3v7waa06sUL5tT25QB4pAOjLYFLruoEA1q8RqHXEJaKw3B9fnKCXgEZ6ZRyxQeGkfk7so/yDgHHF7KjqwweBHS67FQuunjJYZnMU0TxCK0Y8zUR2XokyzpmgUgrGe/ed3KTw59jtmImjDxiBK1RSdQpkHLY6bpmWTI01HQKktmxjRlQdETtCdQk8P8z1U/EbMapSANs7YZpmY4dco23Dbe9/48h
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733cf195-b166-420f-1c9e-08d82c8b61be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:00:42.6055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ApHhie87qyizkMg1vhdomq/ntn6nhWxvUiVGUEi4yj2BiH/WRFr2U/AFPG5NnD5Kma/CMKSzgZF6VcxziCbs7bprrh+oEqwFO8pffEYL4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.8.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:00:42
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It should be to reenter qio_channel_yield() on io/channel read/write
path, so it's safe to reduce in_flight and allow attaching new aio
context. And no problem to allow drain itself: connection attempt is
not a guest request. Moreover, if remote server is down, we can hang
in negotiation, blocking drain section and provoking a dead lock.

How to reproduce the dead lock:

1. Create nbd-fault-injector.conf with the following contents:

[inject-error "mega1"]
event=data
io=readwrite
when=before

2. In one terminal run nbd-fault-injector in a loop, like this:

n=1; while true; do
    echo $n; ((n++));
    ./nbd-fault-injector.py 127.0.0.1:10000 nbd-fault-injector.conf;
done

3. In another terminal run qemu-io in a loop, like this:

n=1; while true; do
    echo $n; ((n++));
    ./qemu-io -c 'read 0 512' nbd+tcp://127.0.0.1:10000;
done

After some time, qemu-io will hang trying to drain, for example, like
this:

 #3 aio_poll (ctx=0x55f006bdd890, blocking=true) at
    util/aio-posix.c:600
 #4 bdrv_do_drained_begin (bs=0x55f006bea710, recursive=false,
    parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:427
 #5 bdrv_drained_begin (bs=0x55f006bea710) at block/io.c:433
 #6 blk_drain (blk=0x55f006befc80) at block/block-backend.c:1710
 #7 blk_unref (blk=0x55f006befc80) at block/block-backend.c:498
 #8 bdrv_open_inherit (filename=0x7fffba1563bc
    "nbd+tcp://127.0.0.1:10000", reference=0x0, options=0x55f006be86d0,
    flags=24578, parent=0x0, child_class=0x0, child_role=0,
    errp=0x7fffba154620) at block.c:3491
 #9 bdrv_open (filename=0x7fffba1563bc "nbd+tcp://127.0.0.1:10000",
    reference=0x0, options=0x0, flags=16386, errp=0x7fffba154620) at
    block.c:3513
 #10 blk_new_open (filename=0x7fffba1563bc "nbd+tcp://127.0.0.1:10000",
    reference=0x0, options=0x0, flags=16386, errp=0x7fffba154620) at
    block/block-backend.c:421

And connection_co stack like this:

 #0 qemu_coroutine_switch (from_=0x55f006bf2650, to_=0x7fe96e07d918,
    action=COROUTINE_YIELD) at util/coroutine-ucontext.c:302
 #1 qemu_coroutine_yield () at util/qemu-coroutine.c:193
 #2 qio_channel_yield (ioc=0x55f006bb3c20, condition=G_IO_IN) at
    io/channel.c:472
 #3 qio_channel_readv_all_eof (ioc=0x55f006bb3c20, iov=0x7fe96d729bf0,
    niov=1, errp=0x7fe96d729eb0) at io/channel.c:110
 #4 qio_channel_readv_all (ioc=0x55f006bb3c20, iov=0x7fe96d729bf0,
    niov=1, errp=0x7fe96d729eb0) at io/channel.c:143
 #5 qio_channel_read_all (ioc=0x55f006bb3c20, buf=0x7fe96d729d28
    "\300.\366\004\360U", buflen=8, errp=0x7fe96d729eb0) at
    io/channel.c:247
 #6 nbd_read (ioc=0x55f006bb3c20, buffer=0x7fe96d729d28, size=8,
    desc=0x55f004f69644 "initial magic", errp=0x7fe96d729eb0) at
    /work/src/qemu/master/include/block/nbd.h:365
 #7 nbd_read64 (ioc=0x55f006bb3c20, val=0x7fe96d729d28,
    desc=0x55f004f69644 "initial magic", errp=0x7fe96d729eb0) at
    /work/src/qemu/master/include/block/nbd.h:391
 #8 nbd_start_negotiate (aio_context=0x55f006bdd890,
    ioc=0x55f006bb3c20, tlscreds=0x0, hostname=0x0,
    outioc=0x55f006bf19f8, structured_reply=true,
    zeroes=0x7fe96d729dca, errp=0x7fe96d729eb0) at nbd/client.c:904
 #9 nbd_receive_negotiate (aio_context=0x55f006bdd890,
    ioc=0x55f006bb3c20, tlscreds=0x0, hostname=0x0,
    outioc=0x55f006bf19f8, info=0x55f006bf1a00, errp=0x7fe96d729eb0) at
    nbd/client.c:1032
 #10 nbd_client_connect (bs=0x55f006bea710, errp=0x7fe96d729eb0) at
    block/nbd.c:1460
 #11 nbd_reconnect_attempt (s=0x55f006bf19f0) at block/nbd.c:287
 #12 nbd_co_reconnect_loop (s=0x55f006bf19f0) at block/nbd.c:309
 #13 nbd_connection_entry (opaque=0x55f006bf19f0) at block/nbd.c:360
 #14 coroutine_trampoline (i0=113190480, i1=22000) at
    util/coroutine-ucontext.c:173

Note, that the hang may be
triggered by another bug, so the whole case is fixed only together with
commit "block/nbd: on shutdown terminate connection attempt".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 65a4f56924..49254f1c3c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -280,7 +280,18 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         s->ioc = NULL;
     }
 
+    bdrv_dec_in_flight(s->bs);
     s->connect_status = nbd_client_connect(s->bs, &local_err);
+    s->wait_drained_end = true;
+    while (s->drained) {
+        /*
+         * We may be entered once from nbd_client_attach_aio_context_bh
+         * and then from nbd_client_co_drain_end. So here is a loop.
+         */
+        qemu_coroutine_yield();
+    }
+    bdrv_inc_in_flight(s->bs);
+
     error_free(s->connect_err);
     s->connect_err = NULL;
     error_propagate(&s->connect_err, local_err);
-- 
2.21.0


