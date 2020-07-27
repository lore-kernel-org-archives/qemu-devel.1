Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78837C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4734B2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CYuXb8Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4734B2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08DR-0004Th-Gy
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Ad-0001Z2-2o; Mon, 27 Jul 2020 14:48:19 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:59123 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08AW-0005W3-VC; Mon, 27 Jul 2020 14:48:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inRLCZ1Lig2EDFDOFisnfZ9NLmiu0QwbCQm4Hr9w9xcTsBtnq6/YWv3sXGYzKLk3jRrwo1FTQAGjxqHn8co2fzq3sD4Gj6/K3GXIhFM5z/JzaddbBqHWnQoDWZ4Tda19VJmbhMtsQWqtXfQk2O5gTjwZzDpLs3Z0SPjMxby8y+gnQHygJ8PxmaTe4UtZhetpK4O0OOCHQu4ZqjjpVfshnFESBIn1+A7jNZFfKTGEgsIPwmdZOnwtk8m23GGotfMo27z2U4lP9ASuddZ2YmHz/xwT1vPGGRkE7pSIOMxX1/LVYAMqzIWOqJOGHr8UFh0eBvhR+Q4AdzxB7lWcbp0kKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VtchdZ3A4OZE4WTgk3bmfkFqQwSsrPvDgXVVXzZ8Fk=;
 b=IWOrCQYbMn0DuDWfN0HdKcMnms0AvDHkXnVcUqKCvKWZbbZGDSty+5s3ZFg/bid84fZNtHF30ROwZNv5DCSyGcI0upe/TpPCpVnX90x4Yo/vTfK+o5HgaDQwTbIMt8Epm44r62xQF0NNbMzh+73n2j6lPwsFWMHH1Ws96xegf2WQlFS6OAtInClGCnFW2w9Qmytb6h2naX7pKf5Exfr0EWatANdITyVIjrTsLwqAsO5cNgQAfroA6h8DFN/7FkFRQzS92axmIEnKND5CP4f1i4KQt1C3HTuO1jtb4YnxWDPT3vmRIUd/z6iAjI603ETn7vqBIkexHnz86dIzX9VNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VtchdZ3A4OZE4WTgk3bmfkFqQwSsrPvDgXVVXzZ8Fk=;
 b=CYuXb8Mss9FZAEGCdKKemDZcv9ehlBu3gvw840iZV3cIu5lQXHROqsObPqA2HZnl5TP7vyNQRoNpU5DFGUeJSDdEWYpucQgBdULh2mNZND9K2jX3cz9Gzco4n+aq+hzOD6khi4to2idm9gjBqLceXe9SSKx6fQS+0fTrsPiOGcc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 18:48:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:48:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/5] block/nbd: allow drain during reconnect attempt
Date: Mon, 27 Jul 2020 21:47:48 +0300
Message-Id: <20200727184751.15704-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727184751.15704-1-vsementsov@virtuozzo.com>
References: <20200727184751.15704-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0701CA0033.eurprd07.prod.outlook.com
 (2603:10a6:200:42::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM4PR0701CA0033.eurprd07.prod.outlook.com (2603:10a6:200:42::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend
 Transport; Mon, 27 Jul 2020 18:48:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc3f78e3-5a18-4fa7-b389-08d8325d9954
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB507983CA475D187574885C88C1720@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pl666ie3PJbnsku9exaZ0BJMDSEL2OFMdOWCEEFNIIY3oHhMyG9GEZlw6uoGSanrIxFcwiyjvlgLaa44Re8IqD9xKSZN9dvYo1z3aev+Glo8dbQ8RAYxT6uBkaDtZoszau2eFraxGkRs8lW5QlpWDKPQnrFpiK89LBynJsWH7uPDzvaotgEx4cNgmbOK47SYKcrTOz7r15mOs1WvAHVaXgjyPGi9tINT4XBT5tgRk8O9ptCe7SMLJaaFM2EmFRFnatcM4ksiDT4Bwu2cpfGIhaoTdJzQLTT+U4/t2tKJbvBHBmCxTbmyEs72CyB2Ki1i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(52116002)(478600001)(4326008)(6916009)(6486002)(956004)(16526019)(107886003)(8936002)(2616005)(186003)(8676002)(316002)(83380400001)(6506007)(6512007)(66556008)(66476007)(26005)(86362001)(1076003)(5660300002)(66946007)(36756003)(2906002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8W8Q155jwX+Pu65KTR+QigfJZNENzJ9PnK92Pk/N8lITFKFFSNpdpKenHbm2rkAXRgiFpnFJdEVE3CJWjIoGidqCbnnFHfWoVufX2Wax8KqapzVHwE1A+HmGg4JM1Gw/dZd4ppw5Qvtg35bVljp5NK9dL6M3dcQXb5UaCWPNyl3u464OtDLAckM7asgpMiXtIZWaIBWUVIAKiNIapiWhTDiixE53yGVRTrVZJwn6oGj3EwNQmLkNVq0il6EuUwmN/uABOlnY7xsdmZFrqWLnhOhRzmHfHvg1+vtgK0MXU8nFyrfbceL/wWyo1WKC4gfmLLvDllOIY1YRWYbldxW1j0VFb9c0/vH/dF39/J4kHlpdHL1Pp02Dm06Q9cd4z50LUB8+T+0CR1Ndg1L4YD1wlTfzZ687J5DM17Q3eKPr6Q2DpIPFk9oelii60u7l/qwMVzd4Z5Kq0wqHsOXaoQxzWAfwa1UsU+DCf0mGnKpdhPE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3f78e3-5a18-4fa7-b389-08d8325d9954
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:48:06.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYLv2NwE7usXhBLTXOVuk26dutxEiYvE4oeSNLqiDHQZSojHZlPWJV42pKAZMG1sIFtxBCbD6kYwIPDNvJUDamnOp8ZIL0/KFeDTsM+XmVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5079
Received-SPF: pass client-ip=40.107.2.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 14:48:05
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
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
    ./qemu-io -c 'read 0 512' nbd://127.0.0.1:10000;
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
 block/nbd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 2ec6623c18..6d19f3c660 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -291,8 +291,22 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         goto out;
     }
 
+    bdrv_dec_in_flight(s->bs);
+
     ret = nbd_client_handshake(s->bs, sioc, &local_err);
 
+    if (s->drained) {
+        s->wait_drained_end = true;
+        while (s->drained) {
+            /*
+             * We may be entered once from nbd_client_attach_aio_context_bh
+             * and then from nbd_client_co_drain_end. So here is a loop.
+             */
+            qemu_coroutine_yield();
+        }
+    }
+    bdrv_inc_in_flight(s->bs);
+
 out:
     s->connect_status = ret;
     error_free(s->connect_err);
-- 
2.21.0


