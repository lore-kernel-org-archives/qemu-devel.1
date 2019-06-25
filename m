Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D0C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553AC2133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553AC2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmS2-0002l6-KJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfmQH-0001O6-2S
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfmQD-0005ny-ER
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:27:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58897 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hfmQD-0005jj-4n
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:27:45 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 6CEE31A23A3;
 Tue, 25 Jun 2019 16:27:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 46DE81A1CCA;
 Tue, 25 Jun 2019 16:27:40 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 16:27:18 +0200
Message-Id: <1561472838-32272-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 2/2] dma/rc4030: Minor code style cleanup
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
Cc: arikalo@wavecomp.com, hpoussin@reactos.org, f4bug@amsat.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix some simple checkpatch.pl warnings in rc4030.c.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/dma/rc4030.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 88ff271..155af9b 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -58,8 +58,8 @@ typedef struct dma_pagetable_entry {
 
 #define TYPE_RC4030_IOMMU_MEMORY_REGION "rc4030-iommu-memory-region"
 
-typedef struct rc4030State
-{
+typedef struct rc4030State {
+
     SysBusDevice parent;
 
     uint32_t config; /* 0x0000: RC4030 config register */
@@ -152,8 +152,9 @@ static uint64_t rc4030_read(void *opaque, hwaddr addr, unsigned int size)
     case 0x0058:
         val = s->cache_bmask;
         /* HACK */
-        if (s->cache_bmask == (uint32_t)-1)
+        if (s->cache_bmask == (uint32_t)-1) {
             s->cache_bmask = 0;
+        }
         break;
     /* Remote Speed Registers */
     case 0x0070:
@@ -538,8 +539,9 @@ static void rc4030_reset(DeviceState *dev)
 
     s->memory_refresh_rate = 0x18186;
     s->nvram_protect = 7;
-    for (i = 0; i < 15; i++)
+    for (i = 0; i < 15; i++) {
         s->rem_speed[i] = 7;
+    }
     s->imr_jazz = 0x10; /* XXX: required by firmware, but why? */
     s->isr_jazz = 0;
 
@@ -551,7 +553,7 @@ static void rc4030_reset(DeviceState *dev)
 
 static int rc4030_post_load(void *opaque, int version_id)
 {
-    rc4030State* s = opaque;
+    rc4030State *s = opaque;
 
     set_next_tick(s);
     update_jazz_irq(s);
@@ -591,7 +593,8 @@ static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int is_wri
     hwaddr dma_addr;
     int dev_to_mem;
 
-    s->dma_regs[n][DMA_REG_ENABLE] &= ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
+    s->dma_regs[n][DMA_REG_ENABLE] &=
+           ~(DMA_FLAG_TC_INTR | DMA_FLAG_MEM_INTR | DMA_FLAG_ADDR_INTR);
 
     /* Check DMA channel consistency */
     dev_to_mem = (s->dma_regs[n][DMA_REG_ENABLE] & DMA_FLAG_MEM_TO_DEV) ? 0 : 1;
@@ -603,8 +606,9 @@ static void rc4030_do_dma(void *opaque, int n, uint8_t *buf, int len, int is_wri
     }
 
     /* Get start address and len */
-    if (len > s->dma_regs[n][DMA_REG_COUNT])
+    if (len > s->dma_regs[n][DMA_REG_COUNT]) {
         len = s->dma_regs[n][DMA_REG_COUNT];
+    }
     dma_addr = s->dma_regs[n][DMA_REG_ADDRESS];
 
     /* Read/write data at right place */
-- 
2.7.4


