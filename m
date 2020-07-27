Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF70E2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y6V+S/dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF70E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08GW-00087S-3L
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Aq-0001hL-7v; Mon, 27 Jul 2020 14:48:32 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:59123 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08Ak-0005W3-97; Mon, 27 Jul 2020 14:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isB5WLyarAf3IzPTzCDxcgGm5nCBi0VLvVV49kIbWcOvP4GpM9XYyzjSkKUsmd1crczal0gp/y8nkvk5MgVZ6riKOhZYBZl/V4ZhoXj3tdkwxrGvFxmDHFQAJWKCGTSt9E1VubaDQ+d0ll2JtN4z7bSZXDC1HLNse6ODpKULQkLaLe6fFAhg6yT0SLW7x/ZmlzhTwvt6wfKy/SK7Zuxnro7fMPyMee2KgmdItrsrS8SwMJ43CvSHI0ZzGs80XLB0dp98qibE/8ZmzqNAzYw7dnqA/UIykNmNlHcULVxDELeO2eg5Bwa0VYv7COtzl01Knr5yofbDvh826Ja7J3gV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5IkK9HveHj3RWkUIlvFd/Qyy/1knHiHj19fTloz4G8=;
 b=V++6hD2TzkSK94U+Yl1EZmglIXeCJ8jAxlwN4IoRlbfI8Xo2dYxiTbnFLJOUWNNX28FeaX/53J0RGbQy37n/5G5nqxcms9lCYkMbdGoYybE2ErSEV3Y/fPRU4K2oajvzyIw3YLttLamT9JQXkCTzOeGi3GXr2gcmiBvA6I4RJeYyx6hNXc/C4S1ZZydgwYnGTT46teV1KJAQib+GpuH3vuUYCMBeGu6tHKjJWPUWOOVq3EAhHVgeaRAkuAM6VWkP/Pm+KIAcX4KdMY7N/T3L5PFAPZeZ1P97JTDFUDAOwI9mmF54pKRYy0j/LiT1mO7oygwQuFlaQZSs6Za7CSIHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5IkK9HveHj3RWkUIlvFd/Qyy/1knHiHj19fTloz4G8=;
 b=Y6V+S/dkYDVjGyDPsR3smUR8uYRgXu1Et6QznLDJX80+zTpwuRKhxEgjMU6mGvb01ixVjyqKYnPTYctQPNGgUQTfpSeDOyCL8DpYq9Se2qR9W1oyS6guHeNV7kleuM3mmqML2o0cXr1LkXRLRt298qR2d4Ge8H4TWf7Maidnm2o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 18:48:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:48:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/5] block/nbd: use non-blocking connect: fix vm hang on
 connect()
Date: Mon, 27 Jul 2020 21:47:51 +0300
Message-Id: <20200727184751.15704-6-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 18:48:07 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3723c8-2dd9-414d-3e66-08d8325d9a9c
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5079D0A0091573E8DBCEA0DFC1720@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sN+bO52o1jyiZOEuWAVFjFNx/IXsl9KxkmeTWkxf6omzwLiqzcOvyCVfqBExWi69Tm791gsDXZAYVngAVZWEZa5Q81yFWXaUa7u6ut6gnHVUgm98L0Z+X829YPK/2f8xds5uHZdxX60MidTL6xxhsxEMl8tox5oW4hIM5pp7AZkbc8VkPanMgAZfslIJf1kwT1xjWXDxTy7t4swzAMWKwaoLjANfpZj5ME0SYMD8mxLaLRopEhbwEMULt9ZuAcXu3901gA9xjcf3fPzVuYksd7Jp/PDTFpDN26YvLMEJ+5AI7TLBZS3xV5t5FKyUkECKmSxbSqwKfGvsrWv5gYudWkSXEoVOwSWV4M7Ot8D/LhcZavyVHFlpUTZb9wTdWCIs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(52116002)(478600001)(4326008)(6916009)(6486002)(956004)(16526019)(107886003)(8936002)(2616005)(186003)(8676002)(316002)(83380400001)(6506007)(6512007)(66556008)(66476007)(26005)(86362001)(1076003)(5660300002)(30864003)(66946007)(36756003)(2906002)(6666004)(50194002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ri2oKte7JYMdS/eS+cGxWnvhu5hNweJJO1BSHm30NBdcIHS1/dst0dsCuXx+xTtygzrqmHgzu1fpbXJjdAnfOXW40wnvxwA5B/qRy3gebL1e09W3ArnzGqTjKRqgCx90yzyOrAROTN8yHBRJLD7OMTgvfIP627MmMm84yEcLaXHWkeGNdfzofRiyvFxbLypOIQ8orO33zHmHnUalWmy0/+TqjaUhNao8MX0MwX5csDumavw3qV8/C0ayOiHOGeODN9kJuSL3u2UX1jCReH3zZzz78xdev4x2fHEIuxeaPR9qe9yQ7Uu1OpxO+Uhwtpoa3L6WUluZaP40I+gKOdQh9wwlSvDgBuCL3jESw62OPPkhEkRdJqZQHA930hm1FDUd49NNCk/8TaGdI/qeALqVt01fOFErQKHbplQuShvy1RDQKMzGa+IsfL29gv7Jb225Uv5fMmPKTnokq6PxGqDRm5enmKs46v68B1E5y9okRZ8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3723c8-2dd9-414d-3e66-08d8325d9a9c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:48:08.1945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whMZmENAn0S49TwyeqPyAnrk2WSxXwYDM00CFhReg4esz/V3OZmfZ0EgjESgIcFBEFSVAwXFY60BzwwcP0qJoL81eW2d8VqGkLUR7GQzJcA=
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

This make nbd connection_co to yield during reconnects, so that
reconnect doesn't hang up the main thread. This is very important in
case of unavailable nbd server host: connect() call may take a long
time, blocking the main thread (and due to reconnect, it will hang
again and again with small gaps of working time during pauses between
connection attempts).

Realization notes:

 - We don't want to implement non-blocking connect() over non-blocking
 socket, because getaddrinfo() doesn't have portable non-blocking
 realization anyway, so let's just use a thread for both getaddrinfo()
 and connect().

 - We can't use qio_channel_socket_connect_async (which behave
 similarly and start a thread to execute connect() call), as it's rely
 on someone iterating main loop (g_main_loop_run() or something like
 this), which is not always the case.

 - We can't use thread_pool_submit_co API, as thread pool waits for all
 threads to finish (but we don't want to wait for blocking reconnect
 attempt on shutdown.

 So, we just create the thread by hand. Some additional difficulties
 are:

 - We want our connect don't block drained sections and aio context
 switches. To achieve this, we make it possible to "cancel" synchronous
 wait for the connect (which is an coroutine yield actually), still,
 the thread continues in background, and it successful result may be
 reused on next reconnect attempt.

 - We don't want to wait for reconnect on shutdown, so there is
 CONNECT_THREAD_RUNNING_DETACHED thread state, which means that block
 layer not more interested in a result, and thread should close new
 connected socket on finish and free the state.

How to reproduce the bug, fixed with this commit:

1. Create an image on node1:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server on node1:
   qemu-nbd xx

3. Start vm with second nbd disk on node2, like this:

  ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
    file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
    -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std

4. Access the vm through vnc (or some other way?), and check that NBD
   drive works:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

   - the command should succeed.

5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:

5.1 Kill NBD server on node1

5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
    again. The command should fail and a lot of error messages about
    failing disk may appear as well.

    Now NBD client driver in Qemu tries to reconnect.
    Still, VM works well.

6. Make node1 unavailable on NBD port, so connect() from node2 will
   last for a long time:

   On node1 (Note, that 10809 is just a default NBD port):

   sudo iptables -A INPUT -p tcp --dport 10809 -j DROP

   After some time the guest hangs, and you may check in gdb that Qemu
   hangs in connect() call, issued from the main thread. This is the
   BUG.

7. Don't forget to drop iptables rule from your node1:

   sudo iptables -D INPUT -p tcp --dport 10809 -j DROP

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 8c5df68856..75352adf89 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -38,6 +38,7 @@
 
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/clone-visitor.h"
 
 #include "block/qdict.h"
 #include "block/nbd.h"
@@ -62,6 +63,47 @@ typedef enum NBDClientState {
     NBD_CLIENT_QUIT
 } NBDClientState;
 
+typedef enum NBDConnectThreadState {
+/* No thread, no pending results */
+    CONNECT_THREAD_NONE,
+
+/* Thread is running, no results for now */
+    CONNECT_THREAD_RUNNING,
+
+/*
+ * Thread is running, but requestor exited. Thread should close the new socket
+ * and free the connect state on exit.
+ */
+    CONNECT_THREAD_RUNNING_DETACHED,
+
+/* Thread finished, results are stored in a state */
+    CONNECT_THREAD_FAIL,
+    CONNECT_THREAD_SUCCESS
+} NBDConnectThreadState;
+
+typedef struct NBDConnectThread {
+    /* Initialization constants */
+    SocketAddress *saddr; /* address to connect to */
+    /*
+     * Bottom half to schedule on completion. Scheduled only if bh_ctx is not
+     * NULL
+     */
+    QEMUBHFunc *bh_func;
+    void *bh_opaque;
+
+    /*
+     * Result of last attempt. Valid in FAIL and SUCCESS states.
+     * If you want to steal error, don't forget to set pointer to NULL.
+     */
+    QIOChannelSocket *sioc;
+    Error *err;
+
+    /* state and bh_ctx are protected by mutex */
+    QemuMutex mutex;
+    NBDConnectThreadState state; /* current state of the thread */
+    AioContext *bh_ctx; /* where to schedule bh (NULL means don't schedule) */
+} NBDConnectThread;
+
 typedef struct BDRVNBDState {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
@@ -91,10 +133,17 @@ typedef struct BDRVNBDState {
     QCryptoTLSCreds *tlscreds;
     const char *hostname;
     char *x_dirty_bitmap;
+
+    bool wait_connect;
+    NBDConnectThread *connect_thread;
 } BDRVNBDState;
 
 static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp);
+static QIOChannelSocket *nbd_co_establish_connection(BlockDriverState *bs,
+                                                     Error **errp);
+static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
+                                               bool detach);
 static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
                                 Error **errp);
 
@@ -191,6 +240,8 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
     if (s->connection_co_sleep_ns_state) {
         qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
     }
+
+    nbd_co_establish_connection_cancel(bs, false);
 }
 
 static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
@@ -223,6 +274,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
         if (s->connection_co_sleep_ns_state) {
             qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
         }
+        nbd_co_establish_connection_cancel(bs, true);
     }
     if (qemu_in_coroutine()) {
         s->teardown_co = qemu_coroutine_self();
@@ -246,6 +298,216 @@ static bool nbd_client_connecting_wait(BDRVNBDState *s)
     return s->state == NBD_CLIENT_CONNECTING_WAIT;
 }
 
+static void connect_bh(void *opaque)
+{
+    BDRVNBDState *state = opaque;
+
+    assert(state->wait_connect);
+    state->wait_connect = false;
+    aio_co_wake(state->connection_co);
+}
+
+static void nbd_init_connect_thread(BDRVNBDState *s)
+{
+    s->connect_thread = g_new(NBDConnectThread, 1);
+
+    *s->connect_thread = (NBDConnectThread) {
+        .saddr = QAPI_CLONE(SocketAddress, s->saddr),
+        .state = CONNECT_THREAD_NONE,
+        .bh_func = connect_bh,
+        .bh_opaque = s
+    };
+
+    qemu_mutex_init(&s->connect_thread->mutex);
+}
+
+static void nbd_free_connect_thread(NBDConnectThread *thr)
+{
+    if (thr->sioc) {
+        qio_channel_close(QIO_CHANNEL(thr->sioc), NULL);
+    }
+    error_free(thr->err);
+    qapi_free_SocketAddress(thr->saddr);
+    g_free(thr);
+}
+
+static void *connect_thread_func(void *opaque)
+{
+    NBDConnectThread *thr = opaque;
+    int ret;
+    bool do_free = false;
+
+    thr->sioc = qio_channel_socket_new();
+
+    error_free(thr->err);
+    thr->err = NULL;
+    ret = qio_channel_socket_connect_sync(thr->sioc, thr->saddr, &thr->err);
+    if (ret < 0) {
+        object_unref(OBJECT(thr->sioc));
+        thr->sioc = NULL;
+    }
+
+    qemu_mutex_lock(&thr->mutex);
+
+    switch (thr->state) {
+    case CONNECT_THREAD_RUNNING:
+        thr->state = ret < 0 ? CONNECT_THREAD_FAIL : CONNECT_THREAD_SUCCESS;
+        if (thr->bh_ctx) {
+            aio_bh_schedule_oneshot(thr->bh_ctx, thr->bh_func, thr->bh_opaque);
+
+            /* play safe, don't reuse bh_ctx on further connection attempts */
+            thr->bh_ctx = NULL;
+        }
+        break;
+    case CONNECT_THREAD_RUNNING_DETACHED:
+        do_free = true;
+        break;
+    default:
+        abort();
+    }
+
+    qemu_mutex_unlock(&thr->mutex);
+
+    if (do_free) {
+        nbd_free_connect_thread(thr);
+    }
+
+    return NULL;
+}
+
+static QIOChannelSocket *coroutine_fn
+nbd_co_establish_connection(BlockDriverState *bs, Error **errp)
+{
+    QemuThread thread;
+    BDRVNBDState *s = bs->opaque;
+    QIOChannelSocket *res;
+    NBDConnectThread *thr = s->connect_thread;
+
+    qemu_mutex_lock(&thr->mutex);
+
+    switch (thr->state) {
+    case CONNECT_THREAD_FAIL:
+    case CONNECT_THREAD_NONE:
+        error_free(thr->err);
+        thr->err = NULL;
+        thr->state = CONNECT_THREAD_RUNNING;
+        qemu_thread_create(&thread, "nbd-connect",
+                           connect_thread_func, thr, QEMU_THREAD_DETACHED);
+        break;
+    case CONNECT_THREAD_SUCCESS:
+        /* Previous attempt finally succeeded in background */
+        thr->state = CONNECT_THREAD_NONE;
+        res = thr->sioc;
+        thr->sioc = NULL;
+        qemu_mutex_unlock(&thr->mutex);
+        return res;
+    case CONNECT_THREAD_RUNNING:
+        /* Already running, will wait */
+        break;
+    default:
+        abort();
+    }
+
+    thr->bh_ctx = qemu_get_current_aio_context();
+
+    qemu_mutex_unlock(&thr->mutex);
+
+
+    /*
+     * We are going to wait for connect-thread finish, but
+     * nbd_client_co_drain_begin() can interrupt.
+     *
+     * Note that wait_connect variable is not visible for connect-thread. It
+     * doesn't need mutex protection, it used only inside home aio context of
+     * bs.
+     */
+    s->wait_connect = true;
+    qemu_coroutine_yield();
+
+    qemu_mutex_lock(&thr->mutex);
+
+    switch (thr->state) {
+    case CONNECT_THREAD_SUCCESS:
+    case CONNECT_THREAD_FAIL:
+        thr->state = CONNECT_THREAD_NONE;
+        error_propagate(errp, thr->err);
+        thr->err = NULL;
+        res = thr->sioc;
+        thr->sioc = NULL;
+        break;
+    case CONNECT_THREAD_RUNNING:
+    case CONNECT_THREAD_RUNNING_DETACHED:
+        /*
+         * Obviously, drained section wants to start. Report the attempt as
+         * failed. Still connect thread is executing in background, and its
+         * result may be used for next connection attempt.
+         */
+        res = NULL;
+        error_setg(errp, "Connection attempt cancelled by other operation");
+        break;
+
+    case CONNECT_THREAD_NONE:
+        /*
+         * Impossible. We've seen this thread running. So it should be
+         * running or at least give some results.
+         */
+        abort();
+
+    default:
+        abort();
+    }
+
+    qemu_mutex_unlock(&thr->mutex);
+
+    return res;
+}
+
+/*
+ * nbd_co_establish_connection_cancel
+ * Cancel nbd_co_establish_connection asynchronously: it will finish soon, to
+ * allow drained section to begin.
+ *
+ * If detach is true, also cleanup the state (or if thread is running, move it
+ * to CONNECT_THREAD_RUNNING_DETACHED state). s->connect_thread becomes NULL if
+ * detach is true.
+ */
+static void nbd_co_establish_connection_cancel(BlockDriverState *bs,
+                                               bool detach)
+{
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    NBDConnectThread *thr = s->connect_thread;
+    bool wake = false;
+    bool do_free = false;
+
+    qemu_mutex_lock(&thr->mutex);
+
+    if (thr->state == CONNECT_THREAD_RUNNING) {
+        /* We can cancel only in running state, when bh is not yet scheduled */
+        thr->bh_ctx = NULL;
+        if (s->wait_connect) {
+            s->wait_connect = false;
+            wake = true;
+        }
+        if (detach) {
+            thr->state = CONNECT_THREAD_RUNNING_DETACHED;
+            s->connect_thread = NULL;
+        }
+    } else if (detach) {
+        do_free = true;
+    }
+
+    qemu_mutex_unlock(&thr->mutex);
+
+    if (do_free) {
+        nbd_free_connect_thread(thr);
+        s->connect_thread = NULL;
+    }
+
+    if (wake) {
+        aio_co_wake(s->connection_co);
+    }
+}
+
 static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
 {
     int ret;
@@ -289,7 +551,7 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         s->ioc = NULL;
     }
 
-    sioc = nbd_establish_connection(s->saddr, &local_err);
+    sioc = nbd_co_establish_connection(s->bs, &local_err);
     if (!sioc) {
         ret = -ECONNREFUSED;
         goto out;
@@ -1946,6 +2208,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     /* successfully connected */
     s->state = NBD_CLIENT_CONNECTED;
 
+    nbd_init_connect_thread(s);
+
     s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
     bdrv_inc_in_flight(bs);
     aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
-- 
2.21.0


