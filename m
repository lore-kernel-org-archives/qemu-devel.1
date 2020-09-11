Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E0C2D0E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2760F2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2760F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGp0c-0007ME-6G
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo9-0003IX-1J; Fri, 11 Sep 2020 15:34:05 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo6-0000rh-Sg; Fri, 11 Sep 2020 15:34:04 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiMIY-1km1ED0BIE-00fVfI; Fri, 11 Sep 2020 21:33:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] util/hexdump: Reorder qemu_hexdump() arguments
Date: Fri, 11 Sep 2020 21:33:29 +0200
Message-Id: <20200911193330.1148942-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7mqDzwgsmLLPPyw9uaJ+ecbo50m2eAJRP/y/FQCycJpbWqsZOKs
 cnZWlcPMdWzzZcEgUuyWPvPbC705zuKbYuVoyNUNYNVSW4htEk8abjokmtaZDlQ4JfFuPP4
 QKtNrVf7GTwLCbyYUWYVTCWgspB1FnLFncecLf5FCF1IdTTM3BKzgndPAgHxfYlnU9FEL9T
 +bJcrrlLWy1w/IVwmVmVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:747k9uIFmNE=:rG8wZ3UPmitlo+yGgRNodm
 1rUSJWMGwWbHpnLWGjb0h/Oo2zsJUuZOxEUIXAAcah1j8rs5pEDgBAMZp4oI9L+0E7aShq6Vc
 t0YDpz1InIn6Wvg8WW9dbkLUfTpbSAWhOkzwTzDNeqnn+gF3cy/rj2KrKf3Ey6M/4OQRp9I8e
 viEyVtrfm/WUiCjMPoxd7Ppnw32nugW2M8L41hs2glZh4N/ySOrfABJHngxTloj/dhbl7vlf8
 Ozkl66XGc9VRM7VZuMh8VXYyGDKTfp0XGxPgfVed8h16uGn1aDaKtI8QMhhNDTL57dOOIv3Mu
 R6ykE6jgV65H9s7L1sckA6Dj1CAgj9BQN7KpzV4ewnSZLDaJROUMJ5w8O91/chpj5n2zzwT7S
 6zsus/Klt1iNbdJwzJ7I0BXvvZNJ9g4oCFl/vAfzVplPS2HUodQkNKu3gLim9c1Anp4bSmHr/
 +v3/fkyWFuzDNllx7FtXfxBAJEIuf3ji04PrPbGiEJulzGM9vcvAznRUoqRsFWRqpZo/EqMcB
 rvRXMdKUt9/QbOfeTfwvcwaaM7X56IfXnQ1rA2q8epduUro1W4MWJC9SQuQiUk3099hLNy0tK
 uEwa+UDhx2vwdPejuPdBdLJZyRsMthCO+svKL2lSfWnT9tnIfAFk5qT5j8n1/ep3jFt1ku5o+
 xdLx+5nsCzrnKJ/yFb2JMeaiLVbEJ2c1xQy5H35lwTDANGvK+6LO53hmto/6ex8QFoh0LyZLs
 zt+ZIstEZiwhgkm39FUaTFut/zQEA15POBI5mfDrZH+SEJDzqQxlTNrGjXo6TEObuRLPH7ZIP
 Toe9GDqmlpHgZMrD7AuaEDQrzzPrXXPJ9yxc+7hgnuyAqBoeUZpUDK0UiPin/1Of2M3MLeF
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:34
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

qemu_hexdump()'s pointer to the buffer and length of the
buffer are closely related arguments but are widely separated
in the argument list order (also, the format of <stdio.h>
function prototypes is usually to have the FILE* argument
coming first).

Reorder the arguments as "fp, prefix, buf, size" which is
more logical.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200822180950.1343963-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/dma/xlnx_dpdma.c      |  2 +-
 hw/net/fsl_etsec/etsec.c |  2 +-
 hw/net/fsl_etsec/rings.c |  2 +-
 hw/sd/sd.c               |  2 +-
 hw/usb/redirect.c        |  2 +-
 include/qemu-common.h    |  4 ++--
 net/colo-compare.c       | 24 ++++++++++++------------
 net/net.c                |  2 +-
 util/hexdump.c           |  4 ++--
 util/iov.c               |  2 +-
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index d75a8069426f..967548abd315 100644
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
index 5c40303f93c1..93886bba60fc 100644
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
index 337a55fc957c..628648a9c37f 100644
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
index 1c8f8529ea88..00128822224d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1785,7 +1785,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    qemu_hexdump(response, stderr, "Response", rsplen);
+    qemu_hexdump(stderr, "Response", response, rsplen);
 #endif
 
     return rsplen;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 09edb0d81c07..48f38d339124 100644
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
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 6834883822f1..9cfd62669bf8 100644
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
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 550272b3baa6..4a5ed642e9a5 100644
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
index f3e5d533fd74..7a2a0fb5ac67 100644
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
index 053f05d41603..0b4662e701d8 100644
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
index 45ef3043eec6..ae61d696aae2 100644
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


