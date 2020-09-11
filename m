Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFA2C2BC11
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1359C21D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1359C21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGowj-0002I4-VK
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGooA-0003Mf-LL; Fri, 11 Sep 2020 15:34:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo8-0000s7-J8; Fri, 11 Sep 2020 15:34:06 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1M4p-1ke1ww243n-012lZJ; Fri, 11 Sep 2020 21:33:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] util/hexdump: Convert to take a void pointer argument
Date: Fri, 11 Sep 2020 21:33:28 +0200
Message-Id: <20200911193330.1148942-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LgDisrBd2a6S85cURV3ENjDb4ynPv/i9bIfXEUiOSFIG7uqoj3f
 YHAxw2wmNatnSV15rK4wa7yusxWnpzphSEiXEjP3JwlrBXk8bbR4R0PSypt/wIjBapH9gJ4
 f1IjmsfnsKcbw6dv1RzXkt3loTHM9MqF38wH5kJXRSIOF9jggLAw20No4VFAwrZN/+wDUHd
 I6sZOmZiw+jRnlC7lXnZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8hZosjGszXM=:58gNja+dINjBHZkXF4XMHj
 9qcbonJpyIhphejV/lsX9TMlLpj6g5PmiQsws++PrTIUG7Vw5h0as1/vf8971HGOpeiz/Udos
 97pjJVe8CbA1zIb8En+SmqPLomoc62e5nLL71x5iFLtrfXg1Ynkwr9mNgmaymro/isVYJvbIR
 A+1t6OpF36R9rY4w/dDHSMhkJnE+GAPgPfiY/UAaeeTLY/TSgqG/oVpSDxuo4DfO5jRgyJQfq
 eXCyfKK/bQ9cOzVM77CBsDlxtNSO7CE1F25hlxH0t3yLRBHFWMzLVVlEsq3IKcP6QePcYpmXH
 gZAXtB+nKHk7tZtlkqVwV9QBLFIn6UtTaBuZzKa4pNNnp5bp31FeESp9Dy1dZoV9vor1UPf6v
 rwDrcqJFjcoafhUateZC5lgPuqpFnlnLTbO5szLx1HwU3YfnFLN+LBQBdOTM54pJNy2rmbsS/
 l903ekSetk0vn+zXT0dYxMKhXYqXj+zt2Q/95fMXIykTngsOKpK/UBX90zw7ouoNAejjhRkSa
 v6lDBHI3PQglFES6ShdTkC6XaeCl5R4mc1uqh2H+MRBE9DjnDuMzui8Hu3esw3p+n2kvN3tZT
 PraZ2+boRuTgRugiHqf0y0FHafiLSWjLuB+gOzEJvrzAQa1S8KF8Iqyrh3ta1p4RDXlTnToTD
 GH069qyta5QlQYNPYeKnd79Zc5fSaqYzwdp9rgb9MP5H0Dz6I74NHPlqOwY/byUVn9EC5dHjv
 qXh11I5k/NJ3eFmbzLBb8P2FlByxdFWtgltjgIZFfX5CiJbDIQdzW6pEfEhmCSypGAyyRiqIR
 EgbpI3/dssY3Oz8z6Luag8+T/3XmuA3MhvRpxBuSwzed06bC/u9HbmMt5++ShxPnYB+Y+1v
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Most uses of qemu_hexdump() do not take an array of char
as input, forcing use of cast. Since we can use this
helper to dump any kind of buffer, use a pointer to void
argument instead.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200822180950.1343963-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/dma/xlnx_dpdma.c      |  2 +-
 hw/net/fsl_etsec/etsec.c |  2 +-
 hw/sd/sd.c               |  2 +-
 hw/usb/redirect.c        |  2 +-
 include/qemu-common.h    |  3 ++-
 net/colo-compare.c       | 12 ++++++------
 net/net.c                |  2 +-
 util/hexdump.c           |  4 +++-
 8 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index b40c897de2c7..d75a8069426f 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -388,7 +388,7 @@ static void xlnx_dpdma_dump_descriptor(DPDMADescriptor *desc)
 {
     if (DEBUG_DPDMA) {
         qemu_log("DUMP DESCRIPTOR:\n");
-        qemu_hexdump((char *)desc, stdout, "", sizeof(DPDMADescriptor));
+        qemu_hexdump(desc, stdout, "", sizeof(DPDMADescriptor));
     }
 }
 
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index ad20b22cdd26..5c40303f93c1 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -357,7 +357,7 @@ static ssize_t etsec_receive(NetClientState *nc,
 
 #if defined(HEX_DUMP)
     fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
-    qemu_hexdump((void *)buf, stderr, "", size);
+    qemu_hexdump(buf, stderr, "", size);
 #endif
     /* Flush is unnecessary as are already in receiving path */
     etsec->need_flush = false;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 483c4f172045..1c8f8529ea88 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1785,7 +1785,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
+    qemu_hexdump(response, stderr, "Response", rsplen);
 #endif
 
     return rsplen;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 417a60a2e680..09edb0d81c07 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -240,7 +240,7 @@ static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
     if (dev->debug < usbredirparser_debug_data) {
         return;
     }
-    qemu_hexdump((char *)data, stderr, desc, len);
+    qemu_hexdump(data, stderr, desc, len);
 }
 
 /*
diff --git a/include/qemu-common.h b/include/qemu-common.h
index bb9496bd80fe..6834883822f1 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -138,7 +138,8 @@ int os_parse_cmd_args(int index, const char *optarg);
  * Hexdump a buffer to a file. An optional string prefix is added to every line
  */
 
-void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
+void qemu_hexdump(const void *bufptr, FILE *fp,
+                  const char *prefix, size_t size);
 
 /*
  * helper to parse debug environment variables
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2c20de1537d4..550272b3baa6 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -494,9 +494,9 @@ sec:
         g_queue_push_head(&conn->secondary_list, spkt);
 
         if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            qemu_hexdump((char *)ppkt->data, stderr,
+            qemu_hexdump(ppkt->data, stderr,
                         "colo-compare ppkt", ppkt->size);
-            qemu_hexdump((char *)spkt->data, stderr,
+            qemu_hexdump(spkt->data, stderr,
                         "colo-compare spkt", spkt->size);
         }
 
@@ -535,9 +535,9 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
         trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
         if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
+            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
                          ppkt->size);
-            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
+            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
                          spkt->size);
         }
         return -1;
@@ -578,9 +578,9 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
         trace_colo_compare_icmp_miscompare("Secondary pkt size",
                                            spkt->size);
         if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
-            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
+            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
                          ppkt->size);
-            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
+            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
                          spkt->size);
         }
         return -1;
diff --git a/net/net.c b/net/net.c
index bbaedb3c7a6d..f3e5d533fd74 100644
--- a/net/net.c
+++ b/net/net.c
@@ -636,7 +636,7 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
 
 #ifdef DEBUG_NET
     printf("qemu_send_packet_async:\n");
-    qemu_hexdump((const char *)buf, stdout, "net", size);
+    qemu_hexdump(buf, stdout, "net", size);
 #endif
 
     if (sender->link_down || !sender->peer) {
diff --git a/util/hexdump.c b/util/hexdump.c
index f879ff0ad6b6..053f05d41603 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,8 +16,10 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size)
+void qemu_hexdump(const void *bufptr, FILE *fp,
+                  const char *prefix, size_t size)
 {
+    const char *buf = bufptr;
     unsigned int b, len, i, c;
 
     for (b = 0; b < size; b += 16) {
-- 
2.26.2


