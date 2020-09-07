Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706BDC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D80205CB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z/MekvNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D80205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFELf-0005y5-Bz
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKT-0004nt-3A; Mon, 07 Sep 2020 06:24:53 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com
 ([40.107.4.97]:49945 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKR-0002LE-76; Mon, 07 Sep 2020 06:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSP77MuJgGaH/PKZUnDMtEkDipHAt1PbGWP+be+ky5bIC6ZCS7rdwloJ1yOrBSD0ueAkGjDIH/lBOILVzIUTQorW7+htmACNjYa+c1wnhfJaef52beDQGoW9M74Yo/iPBTvnRz083PhW6s6j0whkNzVo5iyABxij7zM2ZXcFVfzA9CfsXRabxDXSNFrsOfgG2Ns19l9az44K4pQy2Yd/DtanTDx32O3gDUxBM+vHZGf2glcgHNFn7psppyfFQCbEeuwa7CZIOOJOv8u/1sFjSdmCenhAkG2Ke5Lx7/D4QEB06Xdf6W0lU3oKdeO3qTlnoJFjxsDDio2yi2/xMnA8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TKbFVer4TurpEd5qveeLYaHbgbytE+KlVSwHoHGWYg=;
 b=VOUyvbXMm1z3eHLEGJp5oMyI21dfJ7dZ+KhEJhme6QVPe0xRx+PeFvVEXAq25vUApGNiNV2RmcsumLLQpKxFrqeKLjS9/KCzNgyx64z7oU/hL1f0f90K9L2rnQLTAPtcyLeeDk/tk1+6DQf+B3cASiyJ+HDE45hxoSfNwF8cqpY/3rf6x458nBLrwzD0/rO+JD3WoX1XQ33XnLQ5X7hy0uD8BNPCWoAi3v/DTOIAF71ALjX4MF3YsV6Wt1JX8umhwDVssQ3kS0370UOsd+yElrwppizWZzF+gH1ISmXrRCr1JwXPenodNkCOPH1v6JEX9gvQ3DuY7qhBIX9HZETtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TKbFVer4TurpEd5qveeLYaHbgbytE+KlVSwHoHGWYg=;
 b=Z/MekvNYnjOhz0eNFkSIRifjRh3LuQ53WT+XGJEffWuBA4L9uvNb8MqnKhVI1h5bgzwJ4da7fZ3o5xT4Mqa4Xm2h40BHLAj7bFUrSokDZwRMoGEVkGBQSvYQXY60LJcgG18j+IUdThZwkajdAlpYIc0BW5d1MxuJzOEYc7UjPuw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4722.eurprd08.prod.outlook.com (2603:10a6:20b:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 10:24:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:24:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 2/3] nbd: allow reconnect on open,
 with corresponding new options
Date: Mon,  7 Sep 2020 13:24:25 +0300
Message-Id: <20200907102426.24766-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200907102426.24766-1-vsementsov@virtuozzo.com>
References: <20200907102426.24766-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.137) by
 AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 10:24:41 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.137]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96873242-ecd7-4441-9c7e-08d853183b6b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB472258B912E736D1D10DD111C1280@AM6PR08MB4722.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuaBfGFFY1yktXosoqHq039fHkIl5MTMQFpw7/AK6VoglgsEYpX1sZQAQQ92tlrE4WxRJreeO3Tt50Jomt8VzQ9ib19mbz4NE0EWHhXBjUCzxzoK2uwjg9QLVeBlFGt9AsfJTU3m6sc41l6hOAE6gwh4CTGXrcoK3nLVzKi02IxTVEBUNbmJaAAqAOh7kCmBsVFmxiX2OgIz7myuB5fqrM34IAjsCtrhAUgOVDFkiujnY3pDBLNJpyTlXf4T3Xs8nhTEPtSs9srcjB0oEUEzkamAUt3MBKPLeHIIfkLVSrxWi5c85bDk89htEbiR773IlgtIcGQmLqJQIW6B8VZANw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(4326008)(86362001)(83380400001)(36756003)(956004)(2616005)(2906002)(6916009)(16526019)(186003)(107886003)(8676002)(8936002)(66556008)(66476007)(66946007)(5660300002)(478600001)(6486002)(1076003)(6506007)(6666004)(316002)(52116002)(26005)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LU4cw2tCb5iyKaodbZ+ptKzbB71uAtsfp99elnYIb8F8yA2HeqxtRtqCYH04mea0hWs2yJdicgqCTQAQsyvT+Dxe71EpiwVZTP5vl14kEGPAz4pYjVkzRQcNFaGpzdURDWPcicj+lB21m3RWo+jPXZMReQD1c6SWKUU+DaVcW1/K0hNAVM4wk8Q6KHuX/65y/8VLxek0Mt1MSF4cHUA6P3406rdkq3jdSsvhJGb7lkp32Zknl1XSmG9x9bjRkVmEugoUI+m8rJQXAgLcsLRNcumsa5Ru9PIdZqxuNoFyv3nq8sFk5mj//Jek2bIA7QNFTCz9fJ//r9XppTqSCSPANSMyVH8/td6gQcvjvX9tZCratBmqC2NmlMNHvBwE4AQn6c8H0S76ivd/nfKTnhmKsDjPxJL39p6G98CJjoCgKBR/9I5AK7BpLfmxRszBKy3WMvtTkG96vvisPHr+xo9Z4Sxmfk2cObgSdT9dadRx1Jlv/2cbBbVEny/OihssC1w607Vz/vNR1N4V/FaGEH3U16CuO3vO1HiP+d3fvIkvgtKdWGLYi47PcuuvgX/hkhd5fqQuOXH7jz4V08F/6TXqHDmkC5UO0TPcDvPtb/U25Tdtg1UUppraWYbpWWm6Xf2Jm/CVvokuEjfsdNSrPxY+nA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96873242-ecd7-4441-9c7e-08d853183b6b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 10:24:41.5766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSfbTTjAwriRInBut3ANCz4O2fhkEeN8qcq0Gmb9sXqGaaDciO7zhUMLC9/w0EjidIdYw4ngjFus04/EvVrHKyppiEsBDIDVjFTLuIPgbm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4722
Received-SPF: pass client-ip=40.107.4.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 06:24:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note: currently, using new option with long timeout in qmp command
blockdev-add is not good idea, as qmp interface is blocking, so,
don't add it now, let's add it later after
"monitor: Optionally run handlers in coroutines" series merged.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 115 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 23 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 16f039b7dc..8fea5ededb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -125,12 +125,14 @@ typedef struct BDRVNBDState {
     bool wait_in_flight;
 
     QEMUTimer *reconnect_delay_timer;
+    QEMUTimer *open_timer;
 
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
 
     /* Connection parameters */
+    uint64_t open_timeout;
     uint32_t reconnect_delay;
     SocketAddress *saddr;
     char *export, *tlscredsid;
@@ -304,7 +306,7 @@ static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
 }
 
 
-static void nbd_teardown_connection(BlockDriverState *bs)
+static void nbd_teardown_connection_async(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
@@ -324,6 +326,14 @@ static void nbd_teardown_connection(BlockDriverState *bs)
         }
         nbd_co_establish_connection_cancel(bs, true);
     }
+}
+
+static void nbd_teardown_connection(BlockDriverState *bs)
+{
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+
+    nbd_teardown_connection_async(bs);
+
     if (qemu_in_coroutine()) {
         s->teardown_co = qemu_coroutine_self();
         /* connection_co resumes us when it terminates */
@@ -473,6 +483,11 @@ nbd_co_establish_connection(BlockDriverState *bs, Error **errp)
     s->wait_connect = true;
     qemu_coroutine_yield();
 
+    if (!s->connect_thread) {
+        error_setg(errp, "Connection attempt cancelled by other operation");
+        return NULL;
+    }
+
     qemu_mutex_lock(&thr->mutex);
 
     switch (thr->state) {
@@ -528,6 +543,12 @@ static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
     bool wake = false;
     bool do_free = false;
 
+    if (!thr) {
+        /* already detached or finished */
+        assert(!s->wait_connect);
+        return;
+    }
+
     qemu_mutex_lock(&thr->mutex);
 
     if (thr->state == CONNECT_THREAD_RUNNING) {
@@ -623,10 +644,15 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
     bdrv_inc_in_flight(s->bs);
 
 out:
-    s->connect_status = ret;
-    error_free(s->connect_err);
-    s->connect_err = NULL;
-    error_propagate(&s->connect_err, local_err);
+    if (s->connect_status == -ETIMEDOUT) {
+        /* Don't rewrite timeout error by following cancel-provoked error */
+        error_free(local_err);
+    } else {
+        s->connect_status = ret;
+        error_free(s->connect_err);
+        s->connect_err = NULL;
+        error_propagate(&s->connect_err, local_err);
+    }
 
     if (ret >= 0) {
         /* successfully connected */
@@ -635,11 +661,44 @@ out:
     }
 }
 
+static void open_timer_del(BDRVNBDState *s)
+{
+    if (s->open_timer) {
+        timer_del(s->open_timer);
+        timer_free(s->open_timer);
+        s->open_timer = NULL;
+    }
+}
+
+static void open_timer_cb(void *opaque)
+{
+    BDRVNBDState *s = opaque;
+
+    if (!s->connect_status) {
+        /* First attempt was not finished. We should set an error */
+        s->connect_status = -ETIMEDOUT;
+        error_setg(&s->connect_err, "First connection attempt is cancelled by "
+                   "timeout");
+    }
+
+    nbd_teardown_connection_async(s->bs);
+    open_timer_del(s);
+}
+
+static void open_timer_init(BDRVNBDState *s, uint64_t expire_time_ns)
+{
+    assert(!s->open_timer && s->state == NBD_CLIENT_OPENING);
+    s->open_timer = aio_timer_new(bdrv_get_aio_context(s->bs),
+                                  QEMU_CLOCK_REALTIME,
+                                  SCALE_NS,
+                                  open_timer_cb, s);
+    timer_mod(s->open_timer, expire_time_ns);
+}
+
 static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 {
     uint64_t timeout = 1 * NANOSECONDS_PER_SECOND;
     uint64_t max_timeout = 16 * NANOSECONDS_PER_SECOND;
-    bool initial_connect = s->state == NBD_CLIENT_OPENING;
 
     if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
         reconnect_delay_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
@@ -648,23 +707,9 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 
     nbd_reconnect_attempt(s);
 
-    if (initial_connect) {
-        if (s->state == NBD_CLIENT_CONNECTED) {
-            /* All good. Just kick nbd_open() to successfully return */
-            if (s->open_co) {
-                aio_co_wake(s->open_co);
-                s->open_co = NULL;
-            }
-            aio_wait_kick();
-            return;
-        } else {
-            /*
-             * Failed. Currently, reconnect on open is not allowed, so quit.
-             * nbd_open() will be kicked in the end of nbd_connection_entry()
-             */
-            s->state = NBD_CLIENT_QUIT;
-            return;
-        }
+    if (s->state == NBD_CLIENT_OPENING && !s->open_timeout) {
+        s->state = NBD_CLIENT_QUIT;
+        return;
     }
 
     while (nbd_client_connecting(s)) {
@@ -694,6 +739,16 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
     }
 
     reconnect_delay_timer_del(s);
+    open_timer_del(s);
+
+    if (s->state == NBD_CLIENT_CONNECTED) {
+        /* All good. Just kick nbd_open() to successfully return */
+        if (s->open_co) {
+            aio_co_wake(s->open_co);
+            s->open_co = NULL;
+        }
+        aio_wait_kick();
+    }
 }
 
 static coroutine_fn void nbd_connection_entry(void *opaque)
@@ -2164,6 +2219,14 @@ static QemuOptsList nbd_runtime_opts = {
                     "future requests before a successful reconnect will "
                     "immediately fail. Default 0",
         },
+        {
+            .name = "open-timeout",
+            .type = QEMU_OPT_NUMBER,
+            .help = "In seconds. If zero, nbd driver tries to establish "
+                    "connection only once, on fail open fails. If non-zero, "
+                    "nbd driver may do several attempts until success or "
+                    "@open-timeout seconds passed. Default 0",
+        },
         { /* end of list */ }
     },
 };
@@ -2219,6 +2282,7 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
     }
 
     s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
+    s->open_timeout = qemu_opt_get_number(opts, "open-timeout", 0);
 
     ret = 0;
 
@@ -2252,6 +2316,11 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     bdrv_inc_in_flight(bs);
     aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
 
+    if (s->open_timeout) {
+        open_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+                        s->open_timeout * NANOSECONDS_PER_SECOND);
+    }
+
     if (qemu_in_coroutine()) {
         s->open_co = qemu_coroutine_self();
         qemu_coroutine_yield();
-- 
2.21.3


