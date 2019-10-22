Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB77CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680EC2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tb8zhrNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680EC2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuek-00064X-Gb
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHo-0003Yr-2n
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHk-0001gG-3G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHc-0001eC-Kp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 3so16201096wmi.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fMt1yXYtkl6zou9KhMTTPZc3Shey7XPrKQCkblw9TjE=;
 b=Tb8zhrNKre8VAtq1yNL+5h+vGFzBdfJmbIDmMKRI9jOcYvFBwvbPNv8sn9GwnfpPMd
 M8c64/b7ALFRgO2pMKzn87Z3zSbGsDKIB6/OTPuhoQghcVWtOzSItOgAp9Kg7wsqc7+c
 AfMJLPD6kZositvV5wAJisOAkCnzygJEUNX6tliLrr3owYJxScHtmf5XT5RjPR2/y7tx
 mFLj7S9bhRREhisXNETN+7nY5v9Gre4mCQ2PLfsUrWq+PdXkzYDPdSYhq4v5Dmv00HEv
 0G3rdCxkIHcKjP4XX25A7tZn25nsbdjTNAyuDa4CQGH3yjGIYsxvupfNgg5SrH0v8iwR
 mdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fMt1yXYtkl6zou9KhMTTPZc3Shey7XPrKQCkblw9TjE=;
 b=BtFFXrOgnkQBuLmCckRhC8+PY9DZHCP3sWqTksPinPXfOgNRgTTmo0qFzCYx6oQuGn
 2Qot6bHx41PTkW7/R4TaYUYmalFJkOo4fVptiC6bskGcgqKqUEn2JgyeaujBXwXnFRus
 y+aXvrKXK8Y6cdx5ERzdKS+h0J+8PCkUQfmDIYIAiG3y809m8PL09a/l5DQ0FtBVLTi1
 +75VvBNS8JUzHbql73hmpdARKBhZWDvrbbw2IatSnK4ym0gpKi7PZ2/cVgm5pMK0Fz7/
 XxvHFIOFBaYE1yXD5CDfoJKjwP4ZgbKfanb5Rvjcv5ACTlT+D1HEYSWiV0thvQ47cBkq
 fNEg==
X-Gm-Message-State: APjAAAXINXUvor4iWOIHYpJ0Y7OH5jB9LSPDPz81qW8Il4cvfwCS+EDE
 nNhBHRKm/zALUzDAabvu5HrphNvUv+8=
X-Google-Smtp-Source: APXvYqxwucb4BW0dcCa8o1q7wcuwaKApPqGNAtOKVf4BNe6xqeX4lVjy3RTBkdwnrsMWQl1LolDz9A==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr2751581wmd.10.1571751186680; 
 Tue, 22 Oct 2019 06:33:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.33.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:33:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] hw/arm/omap2: Create the RAM in the board
Date: Tue, 22 Oct 2019 14:31:32 +0100
Message-Id: <20191022133134.14487-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The SDRAM is incorrectly created in the OMAP2420 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191021190653.9511-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  4 +---
 hw/arm/nseries.c      | 10 +++++++---
 hw/arm/omap2.c        | 13 +++++--------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 2fda9966484..763d8eab4fa 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -824,7 +824,6 @@ struct omap_mpu_state_s {
     MemoryRegion tap_iomem;
     MemoryRegion imif_ram;
     MemoryRegion emiff_ram;
-    MemoryRegion sdram;
     MemoryRegion sram;
 
     struct omap_dma_port_if_s {
@@ -938,8 +937,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
                 const char *core);
 
 /* omap2.c */
-struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
                 const char *core);
 
 uint32_t omap_badwidth_read8(void *opaque, hwaddr addr);
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index a36971d39aa..7e361936a9d 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -47,6 +47,7 @@
 
 /* Nokia N8x0 support */
 struct n800_s {
+    MemoryRegion sdram;
     struct omap_mpu_state_s *mpu;
 
     struct rfbi_chip_s blizzard;
@@ -1311,11 +1312,14 @@ static int n810_atag_setup(const struct arm_boot_info *info, void *p)
 static void n8x0_init(MachineState *machine,
                       struct arm_boot_info *binfo, int model)
 {
-    MemoryRegion *sysmem = get_system_memory();
     struct n800_s *s = (struct n800_s *) g_malloc0(sizeof(*s));
-    int sdram_size = binfo->ram_size;
+    uint64_t sdram_size = binfo->ram_size;
 
-    s->mpu = omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
+    memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
+                                         sdram_size);
+    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, &s->sdram);
+
+    s->mpu = omap2420_mpu_init(&s->sdram, machine->cpu_type);
 
     /* Setup peripherals
      *
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index bd7ddff9831..457f152baca 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
@@ -2276,8 +2277,7 @@ static const struct dma_irq_map omap2_dma_irq_map[] = {
     { 0, OMAP_INT_24XX_SDMA_IRQ3 },
 };
 
-struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sdram,
                 const char *cpu_type)
 {
     struct omap_mpu_state_s *s = g_new0(struct omap_mpu_state_s, 1);
@@ -2286,11 +2286,11 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     int i;
     SysBusDevice *busdev;
     struct omap_target_agent_s *ta;
+    MemoryRegion *sysmem = get_system_memory();
 
     /* Core */
     s->mpu_model = omap2420;
     s->cpu = ARM_CPU(cpu_create(cpu_type));
-    s->sdram_size = sdram_size;
     s->sram_size = OMAP242X_SRAM_SIZE;
 
     s->wakeup = qemu_allocate_irq(omap_mpu_wakeup, s, 0);
@@ -2299,9 +2299,6 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     omap_clk_init(s);
 
     /* Memory-mapped stuff */
-    memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
-                                         s->sdram_size);
-    memory_region_add_subregion(sysmem, OMAP2_Q2_BASE, &s->sdram);
     memory_region_init_ram(&s->sram, NULL, "omap2.sram", s->sram_size,
                            &error_fatal);
     memory_region_add_subregion(sysmem, OMAP2_SRAM_BASE, &s->sram);
@@ -2338,8 +2335,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     s->port->addr_valid = omap2_validate_addr;
 
     /* Register SDRAM and SRAM ports for fast DMA transfers.  */
-    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->sdram),
-                         OMAP2_Q2_BASE, s->sdram_size);
+    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(sdram),
+                         OMAP2_Q2_BASE, memory_region_size(sdram));
     soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->sram),
                          OMAP2_SRAM_BASE, s->sram_size);
 
-- 
2.20.1


