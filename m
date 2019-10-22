Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72FECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F9720700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hT31gfl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F9720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuzB-0007sG-KQ
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHq-0003Zs-DD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHo-0001hp-AC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHo-0001f4-3e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n15so7303500wrw.13
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=35JGdkX+Qbs+3j0Y2Ds4qNx/4PsRHF6QNmtmflqtCQ0=;
 b=hT31gfl90dmpUk4jbJJ54inUhmDZn0UyovEp/TFIhF20BPiQGYATjaAoI+Dx3sEZ7T
 rNs82uCPbpuD+NK2JuMhT5Em50N4b80Wggx4zXr0LlYYvGgngieZ2hvzWpEvNAjzaWHw
 7JO+FBOgs5skcyehvzdXxwnun2HVHowtnbPbUmK1tM+tgb8RYqvwmeDcH7DktERf4puR
 gZ5l6N809MDG5gigXwNIK1go3hIUYgioYaN7TaEYt9I1ZBTVZu+3HGgOJBIwrhwrYoz2
 3GkluQjLUrrJeb32tojhKFruqzmiyB0BKJTYmonjZ5L55kxcTkAOetGyjQDjhuZG+CK6
 DpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=35JGdkX+Qbs+3j0Y2Ds4qNx/4PsRHF6QNmtmflqtCQ0=;
 b=B+Y4BT4+AxIWPx/QG+my7/Sj+/Gm2phjSTUZ8DYOMJlrZrc5jN6+U9BbwL983O/EVj
 wDRGSmIXq1A1dwdI7nUJ/NVyJs82TN+33xXD/9ZmESatKFvCdiiOWPuojg7TAueSUhBL
 QwIwK4wYz9wiPmL8o2nbFAsMi2GQsjBB0TsC7ent+Ky1rEtzqWaCP/EtlVeylEctG93l
 WPnR4HuBzWNkBmYKZ8kx76GrlAEPT7PaTyCla9UG8CBVaz3ewaiywBR28j/YgVm9Kc0n
 qGTZuqSFVZCixIck52nyNz+UkdobG1fDiz2XU4ToFqc7yDRYSSuvpOatYr/KMeWHI7ri
 DLMg==
X-Gm-Message-State: APjAAAUMN2mF7ybqUfzKja8qgwf3tecyiPvctWp9uWVxw/zBKoOCHLBx
 /Ku2d8YcbGu+HX1EV+IiCNYGyYsDKWA=
X-Google-Smtp-Source: APXvYqzValH3fzpPKicGwfeWlUa8gQ2KZYOl1f5JKHtlJ5lt6TgFb6ArjcklTdr9PaiqatSieehEeQ==
X-Received: by 2002:a5d:5392:: with SMTP id d18mr3859854wrv.382.1571751188590; 
 Tue, 22 Oct 2019 06:33:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.33.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:33:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] hw/arm/omap1: Create the RAM in the board
Date: Tue, 22 Oct 2019 14:31:33 +0100
Message-Id: <20191022133134.14487-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

The SDRAM is incorrectly created in the OMAP310 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191021190653.9511-6-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  6 ++----
 hw/arm/omap1.c        | 12 +++++-------
 hw/arm/omap_sx1.c     |  8 ++++++--
 hw/arm/palm.c         |  8 ++++++--
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 763d8eab4fa..f3aa6700361 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -823,7 +823,6 @@ struct omap_mpu_state_s {
     MemoryRegion mpui_io_iomem;
     MemoryRegion tap_iomem;
     MemoryRegion imif_ram;
-    MemoryRegion emiff_ram;
     MemoryRegion sram;
 
     struct omap_dma_port_if_s {
@@ -835,7 +834,7 @@ struct omap_mpu_state_s {
                         hwaddr addr);
     } port[__omap_dma_port_last];
 
-    unsigned long sdram_size;
+    uint64_t sdram_size;
     unsigned long sram_size;
 
     /* MPUI-TIPB peripherals */
@@ -932,8 +931,7 @@ struct omap_mpu_state_s {
 };
 
 /* omap1.c */
-struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
                 const char *core);
 
 /* omap2.c */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 0400593805e..6ce038a4535 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -3858,8 +3859,7 @@ static int omap_validate_tipb_mpui_addr(struct omap_mpu_state_s *s,
     return range_covers_byte(0xe1010000, 0xe1020004 - 0xe1010000, addr);
 }
 
-struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
-                unsigned long sdram_size,
+struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                 const char *cpu_type)
 {
     int i;
@@ -3867,11 +3867,12 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
     qemu_irq dma_irqs[6];
     DriveInfo *dinfo;
     SysBusDevice *busdev;
+    MemoryRegion *system_memory = get_system_memory();
 
     /* Core */
     s->mpu_model = omap310;
     s->cpu = ARM_CPU(cpu_create(cpu_type));
-    s->sdram_size = sdram_size;
+    s->sdram_size = memory_region_size(dram);
     s->sram_size = OMAP15XX_SRAM_SIZE;
 
     s->wakeup = qemu_allocate_irq(omap_mpu_wakeup, s, 0);
@@ -3880,9 +3881,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
     omap_clk_init(s);
 
     /* Memory-mapped stuff */
-    memory_region_allocate_system_memory(&s->emiff_ram, NULL, "omap1.dram",
-                                         s->sdram_size);
-    memory_region_add_subregion(system_memory, OMAP_EMIFF_BASE, &s->emiff_ram);
     memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, OMAP_IMIF_BASE, &s->imif_ram);
@@ -3925,7 +3923,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
     s->port[tipb_mpui].addr_valid = omap_validate_tipb_mpui_addr;
 
     /* Register SDRAM and SRAM DMA ports for fast transfers.  */
-    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->emiff_ram),
+    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(dram),
                          OMAP_EMIFF_BASE, s->sdram_size);
     soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->imif_ram),
                          OMAP_IMIF_BASE, s->sram_size);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index c071197be7f..be245714dbb 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -103,6 +103,7 @@ static void sx1_init(MachineState *machine, const int version)
 {
     struct omap_mpu_state_s *mpu;
     MemoryRegion *address_space = get_system_memory();
+    MemoryRegion *dram = g_new(MemoryRegion, 1);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *cs = g_new(MemoryRegion, 4);
     static uint32_t cs0val = 0x00213090;
@@ -118,8 +119,11 @@ static void sx1_init(MachineState *machine, const int version)
         flash_size = flash2_size;
     }
 
-    mpu = omap310_mpu_init(address_space, sx1_binfo.ram_size,
-                           machine->cpu_type);
+    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
+                                         sx1_binfo.ram_size);
+    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, dram);
+
+    mpu = omap310_mpu_init(dram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 02a3a82b9b5..72eca8cc556 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -190,16 +190,20 @@ static void palmte_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     struct omap_mpu_state_s *mpu;
     int flash_size = 0x00800000;
-    int sdram_size = palmte_binfo.ram_size;
     static uint32_t cs0val = 0xffffffff;
     static uint32_t cs1val = 0x0000e1a0;
     static uint32_t cs2val = 0x0000e1a0;
     static uint32_t cs3val = 0xe1a0e1a0;
     int rom_size, rom_loaded = 0;
+    MemoryRegion *dram = g_new(MemoryRegion, 1);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *cs = g_new(MemoryRegion, 4);
 
-    mpu = omap310_mpu_init(address_space_mem, sdram_size, machine->cpu_type);
+    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
+                                         palmte_binfo.ram_size);
+    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dram);
+
+    mpu = omap310_mpu_init(dram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
     memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
-- 
2.20.1


