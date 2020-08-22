Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4BBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 15:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEF02072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 15:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiddmmhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEF02072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9V5u-0005rj-IY
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 11:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9V4r-0004ju-Mo; Sat, 22 Aug 2020 11:05:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9V4p-0007aF-Tc; Sat, 22 Aug 2020 11:05:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id p14so4440770wmg.1;
 Sat, 22 Aug 2020 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=va12qEWE1uizpmZs5eu7pHxQLaxV4eDLRUG5PqTqbec=;
 b=DiddmmhTXgUJa4obHpspyx0uLLCx6JQP7rE0RZgOc6tvhTFo96MFSwlEmr/Q+aOWJe
 7eUyZ4bFIVMX0zIxOecZpKH2T4EWevnW6vbaRCeUe2AIaVNogtPOOOLLB0c3HMMzqefu
 b5rMEswk37U7DtwK6mF138tvi7WcIjUQS8/dVZxWmi3Aa2pixHgbTa9z/zYBTf10qjvw
 vY9tYHE3IUsSph8K7H07D2rSNZ7p2pqIiqmid4hej0hMGcmAMLGJW69yHfc8i3C9b3fI
 Lh7xi7I8b0dTOlFvXyNwJEMTIqStEZ7iAcRSjQ5ku9Sf61e4PkFtUABJ/d+Ef/m6D+LA
 18QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=va12qEWE1uizpmZs5eu7pHxQLaxV4eDLRUG5PqTqbec=;
 b=pqytgZXa7CnVmTqfSy/5Jq3YHH4YpondkCXolselN5na40gUY03uZn7Y8p1cMJqTbl
 UEp81y+t34R3RYqLOhWUFFpFtB+4RpPMhg8d25AddAb3rPAeHfDY5ezPEYCitsklnVnM
 TzycCSuhTw1fEUhxbjaQ6ZCn3SfG3iEi8BRO+JK4ZFGkRAedwkh+7X6UZSKm99G5ITsI
 K65dPDoAhiViZ3E1bxWQly8fwIl7RY6WAw7c102Bj2mde++xKAPUzyEDpLhqmTRSxQEl
 BqlJXbiPMszCDiHyc47WbO7TbquTFXDuTV9SS4d7A8YoCwTWtXoZ01oAgtXmFx+XjjRN
 Ihlg==
X-Gm-Message-State: AOAM53320UyH1mFiFUYnBTg3jpgB8a1kmpYfeBkQVJLFPJUqbI+E2Y06
 2mXgz3ryLUMGm8IJjE+/aOb9gZf+IpI=
X-Google-Smtp-Source: ABdhPJzMuMvVg0ZumBkMiXwj+F4oXvvATJuSFYVQFXhzvaQcVnKF4H66LW0025iW97UUkGnNmGj0hQ==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr8477888wmb.63.1598108700490; 
 Sat, 22 Aug 2020 08:05:00 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t12sm3866637wrm.61.2020.08.22.08.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 08:04:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] util/hexdump: Convert to take a void pointer argument
Date: Sat, 22 Aug 2020 17:04:57 +0200
Message-Id: <20200822150457.1322519-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

Most uses of qemu_hexdump() do not take an array of char
as input, forcing use of cast. Since we can use this
helper to dump any kind of buffer, use a pointer to void
argument instead.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu-common.h    |  2 +-
 hw/dma/xlnx_dpdma.c      |  2 +-
 hw/net/fsl_etsec/etsec.c |  2 +-
 hw/sd/sd.c               |  2 +-
 hw/usb/redirect.c        |  2 +-
 net/colo-compare.c       | 12 ++++++------
 net/net.c                |  2 +-
 util/hexdump.c           |  3 ++-
 8 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index bb9496bd80f..de82a619abd 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -138,7 +138,7 @@ int os_parse_cmd_args(int index, const char *optarg);
  * Hexdump a buffer to a file. An optional string prefix is added to every line
  */
 
-void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
+void qemu_hexdump(const void *ptr, FILE *fp, const char *prefix, size_t size);
 
 /*
  * helper to parse debug environment variables
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index b40c897de2c..d75a8069426 100644
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
index 7035cf4eb97..c817a28decd 100644
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
index fad9cf1ee7a..190e4cf1232 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1781,7 +1781,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
+    qemu_hexdump(response, stderr, "Response", rsplen);
 #endif
 
     return rsplen;
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 417a60a2e68..09edb0d81c0 100644
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
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2c20de1537d..550272b3baa 100644
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
index bbaedb3c7a6..f3e5d533fd7 100644
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
index f879ff0ad6b..faff78970a4 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,8 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size)
+void qemu_hexdump(const void *ptr, FILE *fp, const char *prefix, size_t size)
 {
+    const char *buf = ptr;
     unsigned int b, len, i, c;
 
     for (b = 0; b < size; b += 16) {
-- 
2.26.2


