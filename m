Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1465C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4442076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ToZ92xQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4442076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5s8Z-0005Bv-L5
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k5s7i-0004W4-0H; Wed, 12 Aug 2020 10:53:02 -0400
Received: from mail-he1eur02on0715.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::715]:53735
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k5s7e-00077T-SX; Wed, 12 Aug 2020 10:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L79seDyj6IzlvqNBphiVExH9OqdGYLfaiKgT8tsX9nyKdnFdAfG5ikJfelm5OdxiapNJJZ2V6zokUWVwwfQn6RRiHfJINO78W/bMWe9hk0tvX2vvjeGsZFVufR+jhcAFadvMrzGrgV4WWPt10HWnCrF/yROz1WX/4bROwjrmJgAc1BuGS51+C7zG1RJ/ycqsJ7wAPjGhGS+7bOUPbp+Jc3l/vfVHF3H2VUkZWbQjNxVR+4igzO5RXBZM7bVDkyD5dh4UO5w+VBINDktd1S0j4ltHcn6Fn5olrEsFrTx2w1+582Q5+8iNfXm6Q9T0a+eTbIaSvuVnQNG0ephlaZ0Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEgGcNlabMbi0/l50dAoLs9X6Kx9dEzdlDBhUgELzio=;
 b=ZYoKIUUWz3TZWHW+sG5MG8LJK3Ioaz8mbsqUw9gX1kWvYIpgBhErqT9/nBlfZ6fR3Le32urIeodtX3ZkIOPs779LlL85G/2EOm80T35d7knV/xMquU8vPQjnxbkKTMVXZdMbibF9TF/mQPHlYjFVZH//305Ss1c0NFxyZgA1reoPqOoaMXSpVq38b8M3j/Py/V+fysM6vfIv9eo0wBiJLr/6T2HYzcsV73Eta1Xp3IQCJOhAMx3D3ksQ9QaJpt7SOjOdZzlvNH+6CWXAhI4Q4/WX4Mr6Zj+RxYLyhcQnAjYlXU/2bmdXVJyPYugHVPQFgcgFe7kChj7DVhcq4zNjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEgGcNlabMbi0/l50dAoLs9X6Kx9dEzdlDBhUgELzio=;
 b=ToZ92xQYF9cx8PcmhP3hnJLioLDWfOFhMN5FCRM3zVFTw354PKt19sYe95KzquCycIFAeF7Lw4RM65VHEvTxJpVULbx9HH+AgLagDucUKDDA8Qn3LXsBun5zK+ychHbKTXxJowIIAxU89wcKJaPX7CW0ahRuBfo1KM5S/tVV5AY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4951.eurprd08.prod.outlook.com (2603:10a6:20b:eb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 14:52:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 14:52:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3] block/nbd: use non-blocking connect: fix vm hang on
 connect()
Date: Wed, 12 Aug 2020 17:52:37 +0300
Message-Id: <20200812145237.4396-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0089.eurprd07.prod.outlook.com
 (2603:10a6:207:6::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.146) by
 AM3PR07CA0089.eurprd07.prod.outlook.com (2603:10a6:207:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Wed, 12 Aug 2020 14:52:49 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.146]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3470bf3-641d-4f73-2c59-08d83ecf6203
X-MS-TrafficTypeDiagnostic: AM6PR08MB4951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4951CB2A1A8AB4D59D8174D3C1420@AM6PR08MB4951.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhSvVSmaFxNgqNbFGrS8vzSjUg+WA1qFvLjG3dEDBdF5J+rRO1E3Yw1yZWE/9CtsAkeRGdW+sW9JsCLwgGih09VGy8njGq7HnOUmc7jZ4YJeoEHqjxOI4VZt5ngHWHQr0NujVi7Gao84Gc46YoPaLtHHUJVGTh1LIlfg1cNvHVYvS1g+Sb9nHMiTu04umKLlztgTt0+M2FYAnnPMi2O5Ib6d3TEiOkpzUL48nyO36ZtDcxsHZ/zG5bfIvvPiL176+Gk4dWL2FGoGH3goRJpt63qZ91H61mFmJPt1SaRycSFB9kccUtqTJs6Jp8aVKDu8WlGdvA3MBJE47vi13I3PJx2n/pGuHtovqzjfw9BGnlC4iQu9HX8Cz3YZxHudAJAkL/+efnaWbH2BmQyjaq9wi0VpuS5d5gmypnRBY/A3eno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(136003)(376002)(366004)(396003)(6666004)(52116002)(26005)(316002)(478600001)(6506007)(956004)(36756003)(5660300002)(8936002)(30864003)(6486002)(2616005)(66476007)(86362001)(16526019)(4326008)(2906002)(1076003)(186003)(66946007)(83380400001)(6916009)(8676002)(107886003)(6512007)(69590400007)(66556008)(50194002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7boC0mASsUkmM5iX+jK1buF9ltXc+l1irL/5o9biw+uczb22V9LcgLnQXs79aHtAOUYQVOHu9NoqC4j4o/mQ0J0xKJJgcRSIaa5uUUnND8VM+g/ifUw1rL67iVnQwApn1BXUs6wUPjIt5Jv6lCGKivz+lv5VrZy+7Q87ErnSDLf+dq3ACqg9niPsfTmpeLB2vTHONUlS5enD96fNlH+W/OUSApglUJtFQidASzhtZxJ3hBdmkCVFbim+g99a+XwzyMjNBtZBVB9UyAAH/qSGifb7+AFihJwIBTIv0D82JVtnRJK+uuIhHsez+WSoWW9L1L4Eqtn7tunHzP/WfHVSr4JKvoZPL/4z1fkT+6jTS2RzlK+zZsYJS3RvSQAU1ZYeDHzesgcInEgls9Hdl4k/K60lcwI4E8HC0CrXDQVhWvoI5Svny/qJlqnUpE0OhFTz++I9uSXFZbO4WVyiLdZ+EFJKXh+cP2b60TL9iHrf0jVxPI77wZ65h/L+UC8QE892U7LI5ekk0602UYUIbQKAgJZa55TXALK78Oj0KYT1lpo+ixZ0Uot2lKv7WEfQNZhFndoSCWxmZZmD2ixd4nBfvni/BZ6PG0NhldNO00V6TtON7WpXG14YfyCtQrvGeA/a1hNSeEeKbFa7Mruz4G8P2w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3470bf3-641d-4f73-2c59-08d83ecf6203
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 14:52:49.8304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsbPxHMYndbypCghVXtOtZDhpWfI6El0Mrv9oIE2k+xaTa0t5Us9uOdh08fn9cTBuK4v1fL+wmN14hC9uaFRgDFZ46YWHVtoDSpJKgMSUbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4951
Received-SPF: pass client-ip=2a01:111:f400:fe05::715;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Hi!

This a continuation of "[PATCH v2 for-5.1? 0/5] Fix nbd reconnect dead-locks",
which was mostly merged to 5.1. The only last patch was not merged, and
here is a no-change resend for convenience.


 block/nbd.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 7bb881fef4..919ec5e573 100644
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
2.21.3


