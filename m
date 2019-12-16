Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51106C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC40C24672
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1VjRl/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC40C24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih00f-0007v7-IX
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuE-0006aJ-Si
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuC-0002e8-Oi
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igzuC-0002d1-HK; Mon, 16 Dec 2019 18:36:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id c14so9329572wrn.7;
 Mon, 16 Dec 2019 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8G82YqiK+hkOg91TDiubF2yJBVZeI/ZlRlQXSYUa4tw=;
 b=S1VjRl/FOVAXEJODULvdLYATGlfS0xLSX3zMTrtyDgo/Je4pNOmWLM5V48uyZaFiCF
 P6YMuAnakAW7PaKWaZpNOzzTPpj2bPlgzUwOo+7+Wa++TB5LhlhqKc7ATn0aI1o14mit
 1oHikv9l+AdfDhAM4ba7TvZFZM4xPcSz1yWbQ41/aFU9FKl5CFZp96/yWZ9416LcKw6U
 db2hbT+/XU+Sd3dj5L/oXeyNPsb8xpFCwHqe4LJ+gvFerynEiZFZZOvfyMSwLDIQazcL
 Pj65+0oRkq7JHB2KyKCIScBo/6aJBzz6Qxo5lZf4KPbmrdX4oVPW1y4gmVI8UNuV2keq
 VQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8G82YqiK+hkOg91TDiubF2yJBVZeI/ZlRlQXSYUa4tw=;
 b=h0CZCdVrGOXN46Z8QmZjsSbN5aZeEin7yUhip7oV640jeGdBNb+eZZB2klhcblNzmC
 ubczwsCqhGwQK5T3LzEkP5LnxgdIouB6klNclldhIlQbf5VSwOfLCNQOF3fSsMHEHWZX
 layL601dmQH1NVszOH5Xg5ouDI1dPXatIUbyOqOVEOqK9WCeEb7QDDnl2lJfd+66yU6X
 XUUOFg1NmMPZdlfMjPVdN5rcOUIAeknTYadp4mht0hRpNSRNHeplCfS/PuPstpEfj/Ko
 ky+HeY/ASk547905ngUS3Kd69D+JdZteKpECb29BzwdQAkvQ1aJ2bFeYUSfRCc93NJjh
 +0KQ==
X-Gm-Message-State: APjAAAUBY0LWPHNyTJTGksOkCFlDKvfM8mAHs9zO497iD5d39Sa2x73I
 YwIZ6gdV2nWukkgL2Bj0Ow6M0yhU
X-Google-Smtp-Source: APXvYqyWFFQSwvzfpOAFOa5hYuz4jltyXtSi8N1Ea6Q+IjimjuA2Qn0E8atreyLWu6EdfeCOjpB4Bg==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr33543549wrq.134.1576539359133; 
 Mon, 16 Dec 2019 15:35:59 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z83sm984501wmg.2.2019.12.16.15.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 15:35:58 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/10] arm: allwinner-h3: add Clock Control Unit
Date: Tue, 17 Dec 2019 00:35:12 +0100
Message-Id: <20191216233519.29030-4-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216233519.29030-1-nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Clock Control Unit is responsible for clock signal generation,
configuration and distribution in the Allwinner H3 System on Chip.
This commit adds support for the Clock Control Unit which emulates
a simple read/write register interface.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h      |   2 +
 include/hw/misc/allwinner-h3-clk.h |  40 +++++
 hw/arm/allwinner-h3.c              |   7 +
 hw/misc/allwinner-h3-clk.c         | 238 +++++++++++++++++++++++++++++
 hw/misc/Makefile.objs              |   1 +
 5 files changed, 288 insertions(+)
 create mode 100644 include/hw/misc/allwinner-h3-clk.h
 create mode 100644 hw/misc/allwinner-h3-clk.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index e50caeffaa..47d6f82cc4 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -26,6 +26,7 @@
 #include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
+#include "hw/misc/allwinner-h3-clk.h"
 #include "target/arm/cpu.h"
 
 enum {
@@ -71,6 +72,7 @@ typedef struct AwH3State {
     ARMCPU cpus[AW_H3_NUM_CPUS];
     const hwaddr *memmap;
     AwA10PITState timer;
+    AwH3ClockState ccu;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-clk.h b/include/hw/misc/allwinner-h3-clk.h
new file mode 100644
index 0000000000..ce058a900b
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-clk.h
@@ -0,0 +1,40 @@
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
+#ifndef HW_MISC_ALLWINNER_H3_CLK_H
+#define HW_MISC_ALLWINNER_H3_CLK_H
+
+#include "hw/sysbus.h"
+
+#define AW_H3_CLK_REGS_MAX_ADDR (0x304)
+#define AW_H3_CLK_REGS_NUM      (AW_H3_CLK_REGS_MAX_ADDR / sizeof(uint32_t))
+
+#define TYPE_AW_H3_CLK    "allwinner-h3-clk"
+#define AW_H3_CLK(obj)    OBJECT_CHECK(AwH3ClockState, (obj), TYPE_AW_H3_CLK)
+
+typedef struct AwH3ClockState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t regs[AW_H3_CLK_REGS_NUM];
+} AwH3ClockState;
+
+#endif
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 1a47de56f5..0da09188d1 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -186,6 +186,9 @@ static void aw_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
                           TYPE_AW_A10_PIT);
+
+    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
+                          TYPE_AW_H3_CLK);
 }
 
 static void aw_h3_realize(DeviceState *dev, Error **errp)
@@ -310,6 +313,10 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_C],
                                 &s->sram_c);
 
+    /* Clock Control Unit */
+    qdev_init_nofail(DEVICE(&s->ccu));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
+
     /* UART0 */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
diff --git a/hw/misc/allwinner-h3-clk.c b/hw/misc/allwinner-h3-clk.c
new file mode 100644
index 0000000000..4758cd4d7e
--- /dev/null
+++ b/hw/misc/allwinner-h3-clk.c
@@ -0,0 +1,238 @@
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
+#include "hw/misc/allwinner-h3-clk.h"
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
+    REG_PLL_ENABLE           = (1 << 31),
+    REG_PLL_LOCK             = (1 << 28),
+};
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
+static uint64_t allwinner_h3_clk_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const AwH3ClockState *s = (AwH3ClockState *)opaque;
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_CLK_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_h3_clk_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwH3ClockState *s = (AwH3ClockState *)opaque;
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_CLK_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
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
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_h3_clk_ops = {
+    .read = allwinner_h3_clk_read,
+    .write = allwinner_h3_clk_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_h3_clk_reset(DeviceState *dev)
+{
+    AwH3ClockState *s = AW_H3_CLK(dev);
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
+static void allwinner_h3_clk_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void allwinner_h3_clk_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3ClockState *s = AW_H3_CLK(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_clk_ops, s,
+                          TYPE_AW_H3_CLK, 1 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_clk_vmstate = {
+    .name = "allwinner-h3-clk",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwH3ClockState, AW_H3_CLK_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_clk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_clk_reset;
+    dc->realize = allwinner_h3_clk_realize;
+    dc->vmsd = &allwinner_h3_clk_vmstate;
+}
+
+static const TypeInfo allwinner_h3_clk_info = {
+    .name          = TYPE_AW_H3_CLK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_clk_init,
+    .instance_size = sizeof(AwH3ClockState),
+    .class_init    = allwinner_h3_clk_class_init,
+};
+
+static void allwinner_h3_clk_register(void)
+{
+    type_register_static(&allwinner_h3_clk_info);
+}
+
+type_init(allwinner_h3_clk_register)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ba898a5781..200ed44ce1 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-- 
2.17.1


