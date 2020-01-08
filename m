Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D920C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3934C20720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeWR/4gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3934C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHbd-0000AK-5g
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVT-0001ID-SO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVR-0002Vo-A0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:43 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVQ-0002UX-C2; Wed, 08 Jan 2020 15:00:41 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z3so4781548wru.3;
 Wed, 08 Jan 2020 12:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4QLUuZ5WNgTIhPfyiIRv9tkqJpb6erRNsu9ro78s09c=;
 b=CeWR/4gOcekq4bedSHE7wQCatKmgHJaxaD6LnG5WsXcuhWT5nSIA8XZs+XmQccsRWL
 dae+UykRZWTlbwuoRnXA/7Gl+YdJ7N/I17chYmUYRUh3UMzJssmNO+DGJuZ7BpoKVyN7
 6vQ1YnOHWncDb77sG0NdOYn+ZUZfDYDz77oqFtpPMDcxI7b0A+MMrcDPWC66YRi7mwEe
 JotikuwtK74021gpg3HJTg2bMQlCYnlmRKYwdzSL3qYUc3CeRG9l7vzd768tunyZ02gm
 IT4UTbKGcZ5tTva5IL1NfkblO6nZa+r3/vgpuNEUiiQ6ZbZu22ZGIJ2kGal+epvt0/pa
 YR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4QLUuZ5WNgTIhPfyiIRv9tkqJpb6erRNsu9ro78s09c=;
 b=Bd3OEf5q9Wv0yw/t8qaxn1vqBTYIqyN9snGqhwuqo3JayfbVJARBb28PHP7tcUwc+M
 2MxaNeGtz2sJgJOjTrUrWMm1q9EEBj+Kg7jm9xlpbTgllxFPzESQO9lA7WZja4u7tOGt
 rXA7kecwz0GuR02pg51xlpNX14BuNE0Te/Moip9Rcle3jwOnnYp+1Mt+2XFKTsdwAAlc
 GKqQvQVrSy09eTSLn+Co9HOpDkSyJ0Ba3wuY04PLGrD1GiZGWsjL48Ofm2CVQSeEbWzS
 XJruUL40dHqqq59ObME/7zXIKtGzYvP+OT2jWUANzbKOFnp/qvVLE+1hYhFElZbFEqw9
 pLcQ==
X-Gm-Message-State: APjAAAVc1SQl49kcFcKUn5CX7imuFWw+crS6TzyxVCo7kCf4vM+bh7fw
 cRVcptmRYz1oUKIp6eEPAf478X67
X-Google-Smtp-Source: APXvYqzWSdOoAanZh7sHWenHOpJBosa8tx1fWHN8J9ksCaEmgtSnFZV3QvIfNgsV/Sh1IIBJADDXDg==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr6377344wrr.158.1578513638926; 
 Wed, 08 Jan 2020 12:00:38 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:38 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/17] hw/arm/allwinner-h3: add Clock Control Unit
Date: Wed,  8 Jan 2020 21:00:06 +0100
Message-Id: <20200108200020.4745-4-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 include/hw/arm/allwinner-h3.h      |   3 +
 include/hw/misc/allwinner-h3-ccu.h |  67 ++++++++
 hw/arm/allwinner-h3.c              |   9 +-
 hw/misc/allwinner-h3-ccu.c         | 243 +++++++++++++++++++++++++++++
 hw/misc/Makefile.objs              |   1 +
 5 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/allwinner-h3-ccu.h
 create mode 100644 hw/misc/allwinner-h3-ccu.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 4e2e6202a9..0dc18b927a 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -43,6 +43,7 @@
 #include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
+#include "hw/misc/allwinner-h3-ccu.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -59,6 +60,7 @@ enum {
     AW_H3_SRAM_A1,
     AW_H3_SRAM_A2,
     AW_H3_SRAM_C,
+    AW_H3_CCU,
     AW_H3_PIT,
     AW_H3_UART0,
     AW_H3_UART1,
@@ -98,6 +100,7 @@ typedef struct AwH3State {
     ARMCPU cpus[AW_H3_NUM_CPUS];
     const hwaddr *memmap;
     AwA10PITState timer;
+    AwH3ClockCtlState ccu;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-ccu.h b/include/hw/misc/allwinner-h3-ccu.h
new file mode 100644
index 0000000000..0dcb08ecd1
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-ccu.h
@@ -0,0 +1,67 @@
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
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Highest register address used by CCU device */
+#define AW_H3_CCU_REGS_MAXADDR  (0x304)
+
+/** Total number of known registers */
+#define AW_H3_CCU_REGS_NUM      (AW_H3_CCU_REGS_MAXADDR / sizeof(uint32_t))
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
index c1ef31e875..b85edaea85 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -34,6 +34,7 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_SRAM_A1]    = 0x00000000,
     [AW_H3_SRAM_A2]    = 0x00044000,
     [AW_H3_SRAM_C]     = 0x00010000,
+    [AW_H3_CCU]        = 0x01c20000,
     [AW_H3_PIT]        = 0x01c20c00,
     [AW_H3_UART0]      = 0x01c28000,
     [AW_H3_UART1]      = 0x01c28400,
@@ -75,7 +76,6 @@ struct AwH3Unimplemented {
     { "usb2",      0x01c1c000, 4 * KiB },
     { "usb3",      0x01c1d000, 4 * KiB },
     { "smc",       0x01c1e000, 4 * KiB },
-    { "ccu",       0x01c20000, 1 * KiB },
     { "pio",       0x01c20800, 1 * KiB },
     { "owa",       0x01c21000, 1 * KiB },
     { "pwm",       0x01c21400, 1 * KiB },
@@ -170,6 +170,9 @@ static void allwinner_h3_init(Object *obj)
                               "clk0-freq", &error_abort);
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq", &error_abort);
+
+    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
+                          TYPE_AW_H3_CCU);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -278,6 +281,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), s->memmap[AW_H3_SRAM_C],
                                 &s->sram_c);
 
+    /* Clock Control Unit */
+    qdev_init_nofail(DEVICE(&s->ccu));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
+
     /* UART0 */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
new file mode 100644
index 0000000000..ccf58ccdf2
--- /dev/null
+++ b/hw/misc/allwinner-h3-ccu.c
@@ -0,0 +1,243 @@
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
+    if (idx >= AW_H3_CCU_REGS_NUM) {
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
+    if (idx >= AW_H3_CCU_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
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
+                          TYPE_AW_H3_CCU, 1 * KiB);
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
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ba898a5781..4abd92dcee 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-- 
2.17.1


