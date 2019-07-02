Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6432C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E44220836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E44220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9rC-0004e7-KQ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aW-0005Ja-Ta
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aV-0003p7-Pk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aV-0003or-HO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2196C00735B;
 Tue,  2 Jul 2019 02:32:06 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FF9160C43;
 Tue,  2 Jul 2019 02:32:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:27 +0800
Message-Id: <1562034689-6539-16-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 02:32:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/17] COLO-compare: Make the compare_chr_send()
 can send notification message.
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

We need use this function to send notification message for remote colo-frame(Xen).
So we add new parameter for this job.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index fda55d5..ee03c25 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -129,7 +129,8 @@ static void colo_compare_inconsistency_notify(void)
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
-                            uint32_t vnet_hdr_len);
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame);
 
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
@@ -241,7 +242,8 @@ static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
     ret = compare_chr_send(s,
                            pkt->data,
                            pkt->size,
-                           pkt->vnet_hdr_len);
+                           pkt->vnet_hdr_len,
+                           false);
     if (ret < 0) {
         error_report("colo send primary packet failed");
     }
@@ -671,7 +673,8 @@ static void colo_compare_connection(void *opaque, void *user_data)
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
-                            uint32_t vnet_hdr_len)
+                            uint32_t vnet_hdr_len,
+                            bool notify_remote_frame)
 {
     int ret = 0;
     uint32_t len = htonl(size);
@@ -680,7 +683,14 @@ static int compare_chr_send(CompareState *s,
         return 0;
     }
 
-    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+    if (notify_remote_frame) {
+        ret = qemu_chr_fe_write_all(&s->chr_notify_dev,
+                                    (uint8_t *)&len,
+                                    sizeof(len));
+    } else {
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+    }
+
     if (ret != sizeof(len)) {
         goto err;
     }
@@ -691,13 +701,26 @@ static int compare_chr_send(CompareState *s,
          * know how to parse net packet correctly.
          */
         len = htonl(vnet_hdr_len);
-        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(len));
+
+        if (!notify_remote_frame) {
+            ret = qemu_chr_fe_write_all(&s->chr_out,
+                                        (uint8_t *)&len,
+                                        sizeof(len));
+        }
+
         if (ret != sizeof(len)) {
             goto err;
         }
     }
 
-    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+    if (notify_remote_frame) {
+        ret = qemu_chr_fe_write_all(&s->chr_notify_dev,
+                                    (uint8_t *)buf,
+                                    size);
+    } else {
+        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
+    }
+
     if (ret != size) {
         goto err;
     }
@@ -943,7 +966,8 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
         compare_chr_send(s,
                          pri_rs->buf,
                          pri_rs->packet_len,
-                         pri_rs->vnet_hdr_len);
+                         pri_rs->vnet_hdr_len,
+                         false);
     } else {
         /* compare packet in the specified connection */
         colo_compare_connection(conn, s);
@@ -1075,7 +1099,8 @@ static void colo_flush_packets(void *opaque, void *user_data)
         compare_chr_send(s,
                          pkt->data,
                          pkt->size,
-                         pkt->vnet_hdr_len);
+                         pkt->vnet_hdr_len,
+                         false);
         packet_destroy(pkt, NULL);
     }
     while (!g_queue_is_empty(&conn->secondary_list)) {
-- 
2.5.0


