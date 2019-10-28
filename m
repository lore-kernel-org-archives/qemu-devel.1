Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB7CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F71B21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F71B21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPAcL-00067B-SD
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 15:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zj-0002ah-L5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zi-0003yM-GA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iP9Zi-0003vl-6y; Mon, 28 Oct 2019 14:17:06 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzQTm-1i3LMJ2Sxc-00vPK3; Mon, 28 Oct 2019 19:16:51 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] esp: move handle_ti_cmd() cleanup code to esp_do_dma().
Date: Mon, 28 Oct 2019 19:16:33 +0100
Message-Id: <20191028181643.5143-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
References: <20191028181643.5143-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f0f3VsU7pIFM9a0tTGFuUNiJCy/m45d8E/qz8yT6lnKpRSFjbRG
 90MtUWzuSSGx0K+fzbLNikmDGZMvhLyIeHOanKpj10uBM6a4KWfbcqhNce/+zXD8yinoSOd
 K+m7Bse0uBhoYxj0BtO6JvcbTzEUN6RyWBORMqB0yRsZbZwsYZJ4aQtTaGL579KBGQrUlux
 hrhHXvSwmsc2U2nxzHqzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdhUQeu37QY=:0vykORaRaQJSnqCl/48wEg
 j5RVfxPZKnbPIVyUYI7sJOlgsW5iDbHHJ1bfrv6FUZOwEyjN76RL2DCuKCFSTcch7P7mw/Ngw
 iTnVFMcv5gG+2mB0W62l6SX/k7WAoUIzjd1fYpWs538XxvvY7v8GlfwgubpQhYpxne5a5Z76W
 XckECgTiirf26FnyNtKBsuc8cicyY1JKmnJutrRMarACo4ti638fBxmsU9Ue6HGx8mgLHsU5r
 g2otDC3RgIgZ1Qv2NB5c9rfKs80vdnyRza8KZJDGe+vPyaDob8/8n2Ht5C/5wqbzBmZ+pjdmt
 lGSweUB+8NhL3wc3WBIJWuI1EtvEGu12ualAziCYAl1bdE/78efwKrlfrGfe14y0OIib4iIwZ
 qDiBU8ICuJgKPcUoGfIyBfDwsD/VV+Ka8j/CdJ8vj0OI1ABLuEAzq4JJVUeeFS1LCIAu7OVqq
 cwrj1Hrj57ovsi2yWQS1lEiH7GM12o1gLafwN9xBnFVhDtJBQjWi96511+40LXQH+Hk5Ibu2Q
 /uYVCzATOnbc2A4vrWZ6z8fErf6GBiCZ/PUHUJL0re/WkQr9ADzXOtddmKJ0I+4RAqmMMn+Z7
 rndsKYHnMeLgKgZu8SkYB7T2DX+yWRyHCiv1uXTv/jXWCg1HWF92FCQPC2baQOvITVLC0rBgg
 gJbcDy1R7l+3vsZH+Oe+RMo3LTArYA4O9lALxAQwReQql8ff5rC0V0lDsKX8OpOORAtTAF+SE
 KnvFHwi474oWh4bvkmorkSRqhSFbtdGGCgqk05Hc23X6eGepc+RrytH8CvYPY5p/rCGlC+DFz
 dHJf+PgOeHPVo17eZP52RUFbPpPw/ZIzIyD+OOQBWTuuNhx8ejtew8hXrp3YTC6aQ8wS4NqT8
 5YWZLQaz8QYaDedeNZZg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To prepare following patches move do_cmd and DMA special case
from handle_ti() to esp_do_dma().

This part of the code must be only executed with real DMA, not with
pseudo-DMA. And PDMA is detected in esp_do_dma(), so move this part
of the code in esp_do_dma(). We keep the code in handle_ti_cmd()
in the case no DMA is done.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20191026164546.30020-2-laurent@vivier.eu>
---
 hw/scsi/esp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 841d79b60e..09b28cba17 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -249,10 +249,19 @@ static void esp_do_dma(ESPState *s)
 
     len = s->dma_left;
     if (s->do_cmd) {
+        /*
+         * handle_ti_cmd() case: esp_do_dma() is called only from
+         * handle_ti_cmd() with do_cmd != NULL (see the assert())
+         */
         trace_esp_do_dma(s->cmdlen, len);
         assert (s->cmdlen <= sizeof(s->cmdbuf) &&
                 len <= sizeof(s->cmdbuf) - s->cmdlen);
         s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        trace_esp_handle_ti_cmd(s->cmdlen);
+        s->ti_size = 0;
+        s->cmdlen = 0;
+        s->do_cmd = 0;
+        do_cmd(s, s->cmdbuf);
         return;
     }
     if (s->async_len == 0) {
@@ -373,8 +382,7 @@ static void handle_ti(ESPState *s)
         s->dma_left = minlen;
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         esp_do_dma(s);
-    }
-    if (s->do_cmd) {
+    } else if (s->do_cmd) {
         trace_esp_handle_ti_cmd(s->cmdlen);
         s->ti_size = 0;
         s->cmdlen = 0;
-- 
2.21.0


