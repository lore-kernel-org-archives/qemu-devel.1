Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7206DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410392075E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f69LWHTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410392075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Y0U-0001ZT-Ho
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 14:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Xxq-0006PF-9G; Sat, 22 Aug 2020 14:10:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Xxo-0007bg-6X; Sat, 22 Aug 2020 14:10:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id o21so4684140wmc.0;
 Sat, 22 Aug 2020 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8sK4imuwnDEg9EWUUe6vAsAHrNHBEVzHJOZxgM7BTmw=;
 b=f69LWHTY1qtdmyV4frOoM3Vq10A9SSVr0QT8i0x6HDNCwpnE+RNslUePBzCmlXVQkL
 WJuxGp8I2mZPPGIs8gyl+aQqHNa6hTV9d1jpY/6BdDLySjHaKsmKUE7juYor9hdyJAtY
 JCYrz5Lhe8TUCG0fSzX9ttfpSmmN4EteSK++hHhZZ41k8PErXXLlXPx0ENK0t1yySM/0
 ChT+8YoonANxQduuWaOV57YotaVjZLEVhByAe7v844cw5pXiDS7urHWn8axjw7CNwrYn
 2vdWNthhyIFy4fHP8R4AbiFjwA07mXk8OJVBVzoO0DzQEWIpQatOo98m4ya3fwyKpOJx
 P+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8sK4imuwnDEg9EWUUe6vAsAHrNHBEVzHJOZxgM7BTmw=;
 b=iE3qecR84W80/z57Z0Xk/DFP2h6DavVxB86VBF7lW35XLgg7yJSf5AXqKsXkr+h/+B
 7NaSd/D6i/kgMiz6BNMsSHKdY7ym2GhiaoxDJNiOx9gfZXyrwdqPYw5kV0oI+vwq6DQw
 fcL9qsVHckcCUTb3ZhHQ18vLgD3M1UR+J+yTSSc+u2Dkae59BE9Y5MVI61qqNrSRLA9L
 cSkqZSYX82sCx5WDO094KQhbHExv3Sb1hrhp0E+V16cVQf+TSQP4QNCSwzR0ZbQvFBIZ
 AodvjlPTAIL3doyprJlZMa32P/FZ1oD6ScRAiArZXgeODmNWh80fNHzn3gT8sXicUt2b
 XjJQ==
X-Gm-Message-State: AOAM530Redwvqr/bXUTbtlBLaaAuMbvVdtB5dfqfPI4okK1dpk2q7Nik
 qMBz4U8e3EWGWVvFg+XclUFgiH6j0rE=
X-Google-Smtp-Source: ABdhPJwgF2+cBqYe2jSlu3NUifAvWEtahVVv/o4J6rY6T+25OiE2lV4b7lDFqSzxVXcmElsiVVbVCQ==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr8217984wma.62.1598119797002; 
 Sat, 22 Aug 2020 11:09:57 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 126sm13713876wme.42.2020.08.22.11.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 11:09:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] util/hexdump: Reorder qemu_hexdump() arguments
Date: Sat, 22 Aug 2020 20:09:50 +0200
Message-Id: <20200822180950.1343963-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200822180950.1343963-1-f4bug@amsat.org>
References: <20200822180950.1343963-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Chen <chen.zhang@intel.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_hexdump()'s pointer to the buffer and length of the
buffer are closely related arguments but are widely separated
in the argument list order (also, the format of <stdio.h>
function prototypes is usually to have the FILE* argument
coming first).

Reorder the arguments as "fp, prefix, buf, size" which is
more logical.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu-common.h    |  4 ++--
 hw/dma/xlnx_dpdma.c      |  2 +-
 hw/net/fsl_etsec/etsec.c |  2 +-
 hw/net/fsl_etsec/rings.c |  2 +-
 hw/sd/sd.c               |  2 +-
 hw/usb/redirect.c        |  2 +-
 net/colo-compare.c       | 24 ++++++++++++------------
 net/net.c                |  2 +-
 util/hexdump.c           |  4 ++--
 util/iov.c               |  2 +-
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 6834883822f..9cfd62669bf 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -138,8 +138,8 @@ int os_parse_cmd_args(int index, const char *optarg);
  * Hexdump a buffer to a file. An optional string prefix is added to every line
  */
 
-void qemu_hexdump(const void *bufptr, FILE *fp,
-                  const char *prefix, size_t size);
+void qemu_hexdump(FILE *fp, const char *prefix,
+                  const void *bufptr, size_t size);
 
 /*
  * helper to parse debug environment variables
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index d75a8069426..967548abd31 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -388,7 +388,7 @@ static void xlnx_dpdma_dump_descriptor(DPDMADescriptor *desc)
 {
     if (DEBUG_DPDMA) {
         qemu_log("DUMP DESCRIPTOR:\n");
-        qemu_hexdump(desc, stdout, "", sizeof(DPDMADescriptor));
+        qemu_hexdump(stdout, "", desc, sizeof(DPDMADescriptor));
     }
 }
 
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index c817a28decd..c5edb25dc9f 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -357,7 +357,7 @@ static ssize_t etsec_receive(NetClientState *nc,
 
 #if defined(HEX_DUMP)
     fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
-    qemu_hexdump(buf, stderr, "", size);
+    qemu_hexdump(stderr, "", buf, size);
 #endif
     /* Flush is unnecessary as are already in receiving path */
     etsec->need_flush = false;
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 337a55fc957..628648a9c37 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -269,7 +269,7 @@ static void process_tx_bd(eTSEC         *etsec,
 
 #if defined(HEX_DUMP)
             qemu_log("eTSEC Send packet size:%d\n", etsec->tx_buffer_len);
-            qemu_hexdump(etsec->tx_buffer, stderr, "", etsec->tx_buffer_len);
+            qemu_hexdump(stderr, "", etsec->tx_buffer, etsec->tx_buffer_len);
 #endif  /* ETSEC_RING_DEBUG */
 
             if (etsec->first_bd.flags & BD_TX_TOEUN) {
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 190e4cf1232..6508939b1f4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1781,7 +1781,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    qemu_hexdump(response, stderr, "Response", rsplen);
+    qemu_hexdump(stderr, "Response", response, rsplen);
 #endif
 
     return rsplen;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 09edb0d81c0..48f38d33912 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -240,7 +240,7 @@ static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
     if (dev->debug < usbredirparser_debug_data) {
         return;
     }
-    qemu_hexdump(data, stderr, desc, len);
+    qemu_hexdump(stderr, desc, data, len);
 }
 
 /*
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 550272b3baa..4a5ed642e9a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -494,10 +494,10 @@ sec:
         g_queue_push_head(&conn->secondary_list, spkt);
 
         if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            qemu_hexdump(ppkt->data, stderr,
-                        "colo-compare ppkt", ppkt->size);
-            qemu_hexdump(spkt->data, stderr,
-                        "colo-compare spkt", spkt->size);
+            qemu_hexdump(stderr, "colo-compare ppkt",
+                         ppkt->data, ppkt->size);
+            qemu_hexdump(stderr, "colo-compare spkt",
+                         spkt->data, spkt->size);
         }
 
         colo_compare_inconsistency_notify(s);
@@ -535,10 +535,10 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
         trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
         if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
-                         ppkt->size);
-            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
-                         spkt->size);
+            qemu_hexdump(stderr, "colo-compare pri pkt",
+                         ppkt->data, ppkt->size);
+            qemu_hexdump(stderr, "colo-compare sec pkt",
+                         spkt->data, spkt->size);
         }
         return -1;
     } else {
@@ -578,10 +578,10 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
         trace_colo_compare_icmp_miscompare("Secondary pkt size",
                                            spkt->size);
         if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
-                         ppkt->size);
-            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
-                         spkt->size);
+            qemu_hexdump(stderr, "colo-compare pri pkt",
+                         ppkt->data, ppkt->size);
+            qemu_hexdump(stderr, "colo-compare sec pkt",
+                         spkt->data, spkt->size);
         }
         return -1;
     } else {
diff --git a/net/net.c b/net/net.c
index f3e5d533fd7..7a2a0fb5ac6 100644
--- a/net/net.c
+++ b/net/net.c
@@ -636,7 +636,7 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
 
 #ifdef DEBUG_NET
     printf("qemu_send_packet_async:\n");
-    qemu_hexdump(buf, stdout, "net", size);
+    qemu_hexdump(stdout, "net", buf, size);
 #endif
 
     if (sender->link_down || !sender->peer) {
diff --git a/util/hexdump.c b/util/hexdump.c
index 053f05d4160..0b4662e701d 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,8 +16,8 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-void qemu_hexdump(const void *bufptr, FILE *fp,
-                  const char *prefix, size_t size)
+void qemu_hexdump(FILE *fp, const char *prefix,
+                  const void *bufptr, size_t size)
 {
     const char *buf = bufptr;
     unsigned int b, len, i, c;
diff --git a/util/iov.c b/util/iov.c
index 45ef3043eec..ae61d696aae 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -237,7 +237,7 @@ void iov_hexdump(const struct iovec *iov, const unsigned int iov_cnt,
     size = size > limit ? limit : size;
     buf = g_malloc(size);
     iov_to_buf(iov, iov_cnt, 0, buf, size);
-    qemu_hexdump(buf, fp, prefix, size);
+    qemu_hexdump(fp, prefix, buf, size);
     g_free(buf);
 }
 
-- 
2.26.2


