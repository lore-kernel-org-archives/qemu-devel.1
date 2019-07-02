Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743DC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA342173E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA342173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAFB-0004Nt-HP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50592)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aZ-0005OH-5O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aX-0003pa-Up
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aX-0003pQ-M0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1467C09AD18;
 Tue,  2 Jul 2019 02:32:08 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59FFD18953;
 Tue,  2 Jul 2019 02:32:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:28 +0800
Message-Id: <1562034689-6539-17-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 02:32:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/17] COLO-compare: Add colo-compare remote
 notify support
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This patch make colo-compare can send message to remote COLO frame(Xen) when occur checkpoint.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ee03c25..909dd6c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -120,11 +120,6 @@ enum {
     SECONDARY_IN,
 };
 
-static void colo_compare_inconsistency_notify(void)
-{
-    notifier_list_notify(&colo_compare_notifiers,
-                migrate_get_current());
-}
 
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
@@ -132,6 +127,27 @@ static int compare_chr_send(CompareState *s,
                             uint32_t vnet_hdr_len,
                             bool notify_remote_frame);
 
+static void notify_remote_frame(CompareState *s)
+{
+    char msg[] = "DO_CHECKPOINT";
+    int ret = 0;
+
+    ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+    if (ret < 0) {
+        error_report("Notify Xen COLO-frame failed");
+    }
+}
+
+static void colo_compare_inconsistency_notify(CompareState *s)
+{
+    if (s->notify_dev) {
+        notify_remote_frame(s);
+    } else {
+        notifier_list_notify(&colo_compare_notifiers,
+                             migrate_get_current());
+    }
+}
+
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
     struct tcp_hdr *atcp, *btcp;
@@ -435,7 +451,7 @@ sec:
         qemu_hexdump((char *)spkt->data, stderr,
                      "colo-compare spkt", spkt->size);
 
-        colo_compare_inconsistency_notify();
+        colo_compare_inconsistency_notify(s);
     }
 }
 
@@ -577,7 +593,7 @@ void colo_compare_unregister_notifier(Notifier *notify)
 }
 
 static int colo_old_packet_check_one_conn(Connection *conn,
-                                           void *user_data)
+                                          CompareState *s)
 {
     GList *result = NULL;
     int64_t check_time = REGULAR_PACKET_CHECK_MS;
@@ -588,7 +604,7 @@ static int colo_old_packet_check_one_conn(Connection *conn,
 
     if (result) {
         /* Do checkpoint will flush old packet */
-        colo_compare_inconsistency_notify();
+        colo_compare_inconsistency_notify(s);
         return 0;
     }
 
@@ -608,7 +624,7 @@ static void colo_old_packet_check(void *opaque)
      * If we find one old packet, stop finding job and notify
      * COLO frame do checkpoint.
      */
-    g_queue_find_custom(&s->conn_list, NULL,
+    g_queue_find_custom(&s->conn_list, s,
                         (GCompareFunc)colo_old_packet_check_one_conn);
 }
 
@@ -637,7 +653,8 @@ static void colo_compare_packet(CompareState *s, Connection *conn,
              */
             trace_colo_compare_main("packet different");
             g_queue_push_head(&conn->primary_list, pkt);
-            colo_compare_inconsistency_notify();
+
+            colo_compare_inconsistency_notify(s);
             break;
         }
     }
@@ -989,7 +1006,24 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 
 static void compare_notify_rs_finalize(SocketReadState *notify_rs)
 {
+    CompareState *s = container_of(notify_rs, CompareState, notify_rs);
+
     /* Get Xen colo-frame's notify and handle the message */
+    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
+    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
+    int ret;
+
+    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
+        ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
+        if (ret < 0) {
+            error_report("Notify Xen COLO-frame INIT failed");
+        }
+    }
+
+    if (!strcmp(data, "COLO_CHECKPOINT")) {
+        /* colo-compare do checkpoint, flush pri packet and remove sec packet */
+        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    }
 }
 
 /*
-- 
2.5.0


