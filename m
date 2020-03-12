Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544B3206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Te5E1Dij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544B3206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRBC-00014U-E6
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxW-000064-Ju
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxU-00059H-5p
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxT-00058x-T5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f7so7116571wml.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AfEANmrZh3rQuv+KadPMXy1ojk0z5UKDxWmP2dD77K8=;
 b=Te5E1DijDnQXqpCISirS7wIDAo1WikNfJOOC8im4qj/5PKuhhaIBTgTbYSzFlffp25
 iycfKFX6PsVxTKf7HRAdsKhhpanzV9tvDhoxKzSGIcmMSf5GFKmx8DjxNCzu1z//MPxr
 owKaFWNY70R7UNCHw/Kw98VsP0MHTpBHGP7/96cU9Q2AfphuV5kCDtZqglRIqlefLPLs
 P4RGlQHMb3vXSHJNCZs+rxW9XFuxRr3MHfJWLmoenb7vnd7R7wMO2t+Ux55CO/uw8Qpk
 plJ3/fuBCRZX90hynKqrhAEtCDcz5q41lo9aZx71yrIYeb4lerEXEjJUgnp8seHElBID
 Z7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AfEANmrZh3rQuv+KadPMXy1ojk0z5UKDxWmP2dD77K8=;
 b=s3UDC4IL8Gsuu15RFIcJJep2142Q0VgfT9bvGz6SJb2dpmpwjVehtny7Pg4JwfM3Th
 n26GmnDxBLROCm26Mb8P9dFhtgmDyv9j4uxoSqtFqfRJFKA463Z6dYJQCfD1ug5d1s3l
 TL+pt8+ODoSp8wjRFDVJRxawnVsJJWJ4ycbAZvephvi6cCNN/1R3s+3OZCXSYZZ1xJz6
 wWqndRAEUK6NGcqLHFg6z3jPduf0bJuqJ+JkpVGr8fUZ0ML5Rls7KJeM2GDJIdgDNvq4
 hMPpGdhyHhZeye9tryN+o9nsxri3TqWG2aJHeIpGCR3eepXn1atyPO4DONX3BaU4OCjy
 JiFg==
X-Gm-Message-State: ANhLgQ35//6SRHGt8XNT/gIy/hfjFaiDyCbOkj8ZOLlwOJ8Di3Afxab5
 sY2udnr+jC8aFN/XwbY1wb817cg23hwv+g==
X-Google-Smtp-Source: ADFU+vttEpJZCAz4hZTRcy21L8uga2OjkPHsQs67VUjoSq4HKJDvFytKRrSJIwNFvO3EhP7VFpXlrg==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr5743739wmc.145.1584031518159; 
 Thu, 12 Mar 2020 09:45:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] hw/arm/allwinner-h3: add Clock Control Unit
Date: Thu, 12 Mar 2020 16:44:37 +0000
Message-Id: <20200312164459.25924-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Clock Control Unit is responsible for clock signal generation,
configuration and distribution in the Allwinner H3 System on Chip.
This commit adds support for the Clock Control Unit which emulates
a simple read/write register interface.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200311221854.30370-4-nieklinnenbank@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs              |   1 +
 include/hw/arm/allwinner-h3.h      |   3 +
 include/hw/misc/allwinner-h3-ccu.h |  66 ++++++++
 hw/arm/allwinner-h3.c              |   9 +-
 hw/misc/allwinner-h3-ccu.c         | 242 +++++++++++++++++++++++++++++
 5 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/allwinner-h3-ccu.h
 create mode 100644 hw/misc/allwinner-h3-ccu.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f45b74..5e635b74d5a 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 2aac9b78ecf..abdc20871a6 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -39,6 +39,7 @@
 #include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
+#include "hw/misc/allwinner-h3-ccu.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -55,6 +56,7 @@ enum {
     AW_H3_SRAM_A1,
     AW_H3_SRAM_A2,
     AW_H3_SRAM_C,
+    AW_H3_CCU,
     AW_H3_PIT,
     AW_H3_UART0,
     AW_H3_UART1,
@@ -97,6 +99,7 @@ typedef struct AwH3State {
     ARMCPU cpus[AW_H3_NUM_CPUS];
     const hwaddr *memmap;
     AwA10PITState timer;
+    AwH3ClockCtlState ccu;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-ccu.h b/include/hw/misc/allwinner-h3-ccu.h
new file mode 100644
index 00000000000..eec59649f31
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-ccu.h
@@ -0,0 +1,66 @@
+/*
+ * Allwinner H3 Clock Control Unit emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_MISC_ALLWINNER_H3_CCU_H
+#define HW_MISC_ALLWINNER_H3_CCU_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by CCU device */
+#define AW_H3_CCU_IOSIZE        (0x400)
+
+/** Total number of known registers */
+#define AW_H3_CCU_REGS_NUM      (AW_H3_CCU_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_H3_CCU    "allwinner-h3-ccu"
+#define AW_H3_CCU(obj) \
+    OBJECT_CHECK(AwH3ClockCtlState, (obj), TYPE_AW_H3_CCU)
+
+/** @} */
+
+/**
+ * Allwinner H3 CCU object instance state.
+ */
+typedef struct AwH3ClockCtlState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_H3_CCU_REGS_NUM];
+
+} AwH3ClockCtlState;
+
+#endif /* HW_MISC_ALLWINNER_H3_CCU_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 7958f376852..1fff3c317b4 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -36,6 +36,7 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_SRAM_A1]    = 0x00000000,
     [AW_H3_SRAM_A2]    = 0x00044000,
     [AW_H3_SRAM_C]     = 0x00010000,
+    [AW_H3_CCU]        = 0x01c20000,
     [AW_H3_PIT]        = 0x01c20c00,
     [AW_H3_UART0]      = 0x01c28000,
     [AW_H3_UART1]      = 0x01c28400,
@@ -77,7 +78,6 @@ struct AwH3Unimplemented {
     { "usb2-phy",  0x01c1c000, 4 * KiB },
     { "usb3-phy",  0x01c1d000, 4 * KiB },
     { "smc",       0x01c1e000, 4 * KiB },
-    { "ccu",       0x01c20000, 1 * KiB },
     { "pio",       0x01c20800, 1 * KiB },
     { "owa",       0x01c21000, 1 * KiB },
     { "pwm",       0x01c21400, 1 * KiB },
@@ -172,6 +172,9 @@ static void allwinner_h3_init(Object *obj)
                               "clk0-freq", &error_abort);
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq", &error_abort);
+
+    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
+                          TYPE_AW_H3_CCU);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -277,6 +280,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_C],
                                 &s->sram_c);
 
+    /* Clock Control Unit */
+    qdev_init_nofail(DEVICE(&s->ccu));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
+
     /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
new file mode 100644
index 00000000000..18d10745458
--- /dev/null
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -0,0 +1,242 @@
+/*
+ * Allwinner H3 Clock Control Unit emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/allwinner-h3-ccu.h"
+
+/* CCU register offsets */
+enum {
+    REG_PLL_CPUX             = 0x0000, /* PLL CPUX Control */
+    REG_PLL_AUDIO            = 0x0008, /* PLL Audio Control */
+    REG_PLL_VIDEO            = 0x0010, /* PLL Video Control */
+    REG_PLL_VE               = 0x0018, /* PLL VE Control */
+    REG_PLL_DDR              = 0x0020, /* PLL DDR Control */
+    REG_PLL_PERIPH0          = 0x0028, /* PLL Peripherals 0 Control */
+    REG_PLL_GPU              = 0x0038, /* PLL GPU Control */
+    REG_PLL_PERIPH1          = 0x0044, /* PLL Peripherals 1 Control */
+    REG_PLL_DE               = 0x0048, /* PLL Display Engine Control */
+    REG_CPUX_AXI             = 0x0050, /* CPUX/AXI Configuration */
+    REG_APB1                 = 0x0054, /* ARM Peripheral Bus 1 Config */
+    REG_APB2                 = 0x0058, /* ARM Peripheral Bus 2 Config */
+    REG_DRAM_CFG             = 0x00F4, /* DRAM Configuration */
+    REG_MBUS                 = 0x00FC, /* MBUS Reset */
+    REG_PLL_TIME0            = 0x0200, /* PLL Stable Time 0 */
+    REG_PLL_TIME1            = 0x0204, /* PLL Stable Time 1 */
+    REG_PLL_CPUX_BIAS        = 0x0220, /* PLL CPUX Bias */
+    REG_PLL_AUDIO_BIAS       = 0x0224, /* PLL Audio Bias */
+    REG_PLL_VIDEO_BIAS       = 0x0228, /* PLL Video Bias */
+    REG_PLL_VE_BIAS          = 0x022C, /* PLL VE Bias */
+    REG_PLL_DDR_BIAS         = 0x0230, /* PLL DDR Bias */
+    REG_PLL_PERIPH0_BIAS     = 0x0234, /* PLL Peripherals 0 Bias */
+    REG_PLL_GPU_BIAS         = 0x023C, /* PLL GPU Bias */
+    REG_PLL_PERIPH1_BIAS     = 0x0244, /* PLL Peripherals 1 Bias */
+    REG_PLL_DE_BIAS          = 0x0248, /* PLL Display Engine Bias */
+    REG_PLL_CPUX_TUNING      = 0x0250, /* PLL CPUX Tuning */
+    REG_PLL_DDR_TUNING       = 0x0260, /* PLL DDR Tuning */
+};
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+/* CCU register flags */
+enum {
+    REG_DRAM_CFG_UPDATE      = (1 << 16),
+};
+
+enum {
+    REG_PLL_ENABLE           = (1 << 31),
+    REG_PLL_LOCK             = (1 << 28),
+};
+
+
+/* CCU register reset values */
+enum {
+    REG_PLL_CPUX_RST         = 0x00001000,
+    REG_PLL_AUDIO_RST        = 0x00035514,
+    REG_PLL_VIDEO_RST        = 0x03006207,
+    REG_PLL_VE_RST           = 0x03006207,
+    REG_PLL_DDR_RST          = 0x00001000,
+    REG_PLL_PERIPH0_RST      = 0x00041811,
+    REG_PLL_GPU_RST          = 0x03006207,
+    REG_PLL_PERIPH1_RST      = 0x00041811,
+    REG_PLL_DE_RST           = 0x03006207,
+    REG_CPUX_AXI_RST         = 0x00010000,
+    REG_APB1_RST             = 0x00001010,
+    REG_APB2_RST             = 0x01000000,
+    REG_DRAM_CFG_RST         = 0x00000000,
+    REG_MBUS_RST             = 0x80000000,
+    REG_PLL_TIME0_RST        = 0x000000FF,
+    REG_PLL_TIME1_RST        = 0x000000FF,
+    REG_PLL_CPUX_BIAS_RST    = 0x08100200,
+    REG_PLL_AUDIO_BIAS_RST   = 0x10100000,
+    REG_PLL_VIDEO_BIAS_RST   = 0x10100000,
+    REG_PLL_VE_BIAS_RST      = 0x10100000,
+    REG_PLL_DDR_BIAS_RST     = 0x81104000,
+    REG_PLL_PERIPH0_BIAS_RST = 0x10100010,
+    REG_PLL_GPU_BIAS_RST     = 0x10100000,
+    REG_PLL_PERIPH1_BIAS_RST = 0x10100010,
+    REG_PLL_DE_BIAS_RST      = 0x10100000,
+    REG_PLL_CPUX_TUNING_RST  = 0x0A101000,
+    REG_PLL_DDR_TUNING_RST   = 0x14880000,
+};
+
+static uint64_t allwinner_h3_ccu_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const AwH3ClockCtlState *s = AW_H3_CCU(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case 0x308 ... AW_H3_CCU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwH3ClockCtlState *s = AW_H3_CCU(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case REG_DRAM_CFG:    /* DRAM Configuration */
+        val &= ~REG_DRAM_CFG_UPDATE;
+        break;
+    case REG_PLL_CPUX:    /* PLL CPUX Control */
+    case REG_PLL_AUDIO:   /* PLL Audio Control */
+    case REG_PLL_VIDEO:   /* PLL Video Control */
+    case REG_PLL_VE:      /* PLL VE Control */
+    case REG_PLL_DDR:     /* PLL DDR Control */
+    case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */
+    case REG_PLL_GPU:     /* PLL GPU Control */
+    case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */
+    case REG_PLL_DE:      /* PLL Display Engine Control */
+        if (val & REG_PLL_ENABLE) {
+            val |= REG_PLL_LOCK;
+        }
+        break;
+    case 0x308 ... AW_H3_CCU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_h3_ccu_ops = {
+    .read = allwinner_h3_ccu_read,
+    .write = allwinner_h3_ccu_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_h3_ccu_reset(DeviceState *dev)
+{
+    AwH3ClockCtlState *s = AW_H3_CCU(dev);
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_PLL_CPUX)] = REG_PLL_CPUX_RST;
+    s->regs[REG_INDEX(REG_PLL_AUDIO)] = REG_PLL_AUDIO_RST;
+    s->regs[REG_INDEX(REG_PLL_VIDEO)] = REG_PLL_VIDEO_RST;
+    s->regs[REG_INDEX(REG_PLL_VE)] = REG_PLL_VE_RST;
+    s->regs[REG_INDEX(REG_PLL_DDR)] = REG_PLL_DDR_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH0)] = REG_PLL_PERIPH0_RST;
+    s->regs[REG_INDEX(REG_PLL_GPU)] = REG_PLL_GPU_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH1)] = REG_PLL_PERIPH1_RST;
+    s->regs[REG_INDEX(REG_PLL_DE)] = REG_PLL_DE_RST;
+    s->regs[REG_INDEX(REG_CPUX_AXI)] = REG_CPUX_AXI_RST;
+    s->regs[REG_INDEX(REG_APB1)] = REG_APB1_RST;
+    s->regs[REG_INDEX(REG_APB2)] = REG_APB2_RST;
+    s->regs[REG_INDEX(REG_DRAM_CFG)] = REG_DRAM_CFG_RST;
+    s->regs[REG_INDEX(REG_MBUS)] = REG_MBUS_RST;
+    s->regs[REG_INDEX(REG_PLL_TIME0)] = REG_PLL_TIME0_RST;
+    s->regs[REG_INDEX(REG_PLL_TIME1)] = REG_PLL_TIME1_RST;
+    s->regs[REG_INDEX(REG_PLL_CPUX_BIAS)] = REG_PLL_CPUX_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] = REG_PLL_AUDIO_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] = REG_PLL_VIDEO_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_VE_BIAS)] = REG_PLL_VE_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_DDR_BIAS)] = REG_PLL_DDR_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] = REG_PLL_PERIPH0_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_GPU_BIAS)] = REG_PLL_GPU_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] = REG_PLL_PERIPH1_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_DE_BIAS)] = REG_PLL_DE_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_CPUX_TUNING)] = REG_PLL_CPUX_TUNING_RST;
+    s->regs[REG_INDEX(REG_PLL_DDR_TUNING)] = REG_PLL_DDR_TUNING_RST;
+}
+
+static void allwinner_h3_ccu_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3ClockCtlState *s = AW_H3_CCU(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_ccu_ops, s,
+                          TYPE_AW_H3_CCU, AW_H3_CCU_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_ccu_vmstate = {
+    .name = "allwinner-h3-ccu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlState, AW_H3_CCU_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_ccu_reset;
+    dc->vmsd = &allwinner_h3_ccu_vmstate;
+}
+
+static const TypeInfo allwinner_h3_ccu_info = {
+    .name          = TYPE_AW_H3_CCU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_ccu_init,
+    .instance_size = sizeof(AwH3ClockCtlState),
+    .class_init    = allwinner_h3_ccu_class_init,
+};
+
+static void allwinner_h3_ccu_register(void)
+{
+    type_register_static(&allwinner_h3_ccu_info);
+}
+
+type_init(allwinner_h3_ccu_register)
-- 
2.20.1


