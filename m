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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A43C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688C620720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjo7uzPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688C620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHhI-0000Cu-4G
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVd-0001Rx-2h
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVY-0002dn-Rr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:52 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVY-0002cs-IB; Wed, 08 Jan 2020 15:00:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id p9so247087wmc.2;
 Wed, 08 Jan 2020 12:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7ysuc6VyY6fGehBi+b6fDK7alQsuZfqgE2IQoYg8KuQ=;
 b=Hjo7uzPc+J4oLgiqLFJyfAtHbhah+PP7cBKmhpcLge447VSZ3Z69JdpJzgukjZtKB6
 tr9WIKqwTFWBjebKPLl88PXQni5q0RVPquP8FjHZi857LPcOs0lsdnyc1wzA3Z01n92I
 +OSGYmjmdnaTwuKqi9OE88o+4g6coCo06tU0BCSqrKc1ugsz/Ztt5aBF7xAUY1B5ZDJW
 sI9qAOIRkr8GvfqIqVJUebHJcFKCVy35D1js3jHeGF3o+Qei3E3pt8HSovke/U5gD26A
 MRWvzpOCfmC8wi33K+Lk/cna2Zw2npM9qwQp1ln+jr043hOZpjke1qfleDbSkrt+I37X
 TEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7ysuc6VyY6fGehBi+b6fDK7alQsuZfqgE2IQoYg8KuQ=;
 b=EsnpOt6dhzx0lErouKA7oLiD4NyMdxisMkrtdcNTGZv3jo5ncng2phVli5oM2W8TKo
 u3H6bP/9Luawz4TDrR2I3lDmTPHWgDreTKXhm0Zsqj/Pjui+lqBPIKk7BSEFZQI4z7OS
 C9ioxj3Rm0G3IwYzaNf5gCCbYBae1//O/en/9hwCRMzIu/8DF/YyERCPWJAG7AZGmMk6
 7s1qpa80EkK6Kec/qsUpJJ1k0qTyRKoycUYiHLfirlYhUA+RcbMb7WN2+yylK+qD2N09
 YxYzvS0Hx2eFEDjiLNLsGsxS9CWovMTqLweROvxd2edo+a3StsAJy00V9H/+RbnFWyY0
 HYwg==
X-Gm-Message-State: APjAAAXChLDWOKjWH00Hc+ojNZ2+PtxKQ3IHirsc9UDU9eaWuNFixHIP
 ewPyxVNVGPkj4lhQDIQbZXaYNGQ+
X-Google-Smtp-Source: APXvYqz7PYRKkZbkCdKpwC3NUg8xHofV1Sku7gZzPizV+F5/K6dc2bYl9An9xTk0CdaDJ9RtGrsdgg==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr303661wmb.99.1578513646980;
 Wed, 08 Jan 2020 12:00:46 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:46 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/17] hw/arm/allwinner-h3: add SDRAM controller device
Date: Wed,  8 Jan 2020 21:00:14 +0100
Message-Id: <20200108200020.4745-12-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

In the Allwinner H3 SoC the SDRAM controller is responsible
for interfacing with the external Synchronous Dynamic Random
Access Memory (SDRAM). Types of memory that the SDRAM controller
supports are DDR2/DDR3 and capacities of up to 2GiB. This commit
adds emulation support of the Allwinner H3 SDRAM controller.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h        |   5 +
 include/hw/misc/allwinner-h3-dramc.h | 107 ++++++++
 hw/arm/allwinner-h3.c                |  19 +-
 hw/arm/orangepi.c                    |   6 +
 hw/misc/allwinner-h3-dramc.c         | 358 +++++++++++++++++++++++++++
 hw/misc/Makefile.objs                |   1 +
 hw/misc/trace-events                 |  10 +
 7 files changed, 503 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/misc/allwinner-h3-dramc.h
 create mode 100644 hw/misc/allwinner-h3-dramc.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 4b66227ac4..d1b3d7ca67 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -45,6 +45,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-h3-ccu.h"
 #include "hw/misc/allwinner-cpucfg.h"
+#include "hw/misc/allwinner-h3-dramc.h"
 #include "hw/misc/allwinner-h3-sysctrl.h"
 #include "hw/misc/allwinner-sid.h"
 #include "hw/sd/allwinner-sdhost.h"
@@ -84,6 +85,9 @@ enum {
     AW_H3_UART2,
     AW_H3_UART3,
     AW_H3_EMAC,
+    AW_H3_DRAMCOM,
+    AW_H3_DRAMCTL,
+    AW_H3_DRAMPHY,
     AW_H3_GIC_DIST,
     AW_H3_GIC_CPU,
     AW_H3_GIC_HYP,
@@ -121,6 +125,7 @@ typedef struct AwH3State {
     AwA10PITState timer;
     AwH3ClockCtlState ccu;
     AwCpuCfgState cpucfg;
+    AwH3DramCtlState dramc;
     AwH3SysCtrlState sysctrl;
     AwSidState sid;
     AwSdHostState mmc0;
diff --git a/include/hw/misc/allwinner-h3-dramc.h b/include/hw/misc/allwinner-h3-dramc.h
new file mode 100644
index 0000000000..70ab331081
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-dramc.h
@@ -0,0 +1,107 @@
+/*
+ * Allwinner H3 SDRAM Controller emulation
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
+#ifndef HW_MISC_ALLWINNER_H3_DRAMC_H
+#define HW_MISC_ALLWINNER_H3_DRAMC_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "exec/hwaddr.h"
+
+/**
+ * Constants
+ * @{
+ */
+
+/** Highest register address used by DRAMCOM module */
+#define AW_H3_DRAMCOM_REGS_MAXADDR  (0x804)
+
+/** Total number of known DRAMCOM registers */
+#define AW_H3_DRAMCOM_REGS_NUM      (AW_H3_DRAMCOM_REGS_MAXADDR / \
+                                     sizeof(uint32_t))
+
+/** Highest register address used by DRAMCTL module */
+#define AW_H3_DRAMCTL_REGS_MAXADDR  (0x88c)
+
+/** Total number of known DRAMCTL registers */
+#define AW_H3_DRAMCTL_REGS_NUM      (AW_H3_DRAMCTL_REGS_MAXADDR / \
+                                     sizeof(uint32_t))
+
+/** Highest register address used by DRAMPHY module */
+#define AW_H3_DRAMPHY_REGS_MAXADDR  (0x4)
+
+/** Total number of known DRAMPHY registers */
+#define AW_H3_DRAMPHY_REGS_NUM      (AW_H3_DRAMPHY_REGS_MAXADDR / \
+                                     sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * Object model
+ * @{
+ */
+
+#define TYPE_AW_H3_DRAMC "allwinner-h3-dramc"
+#define AW_H3_DRAMC(obj) \
+    OBJECT_CHECK(AwH3DramCtlState, (obj), TYPE_AW_H3_DRAMC)
+
+/** @} */
+
+/**
+ * Allwinner H3 SDRAM Controller object instance state.
+ */
+typedef struct AwH3DramCtlState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Physical base address for start of RAM */
+    hwaddr ram_addr;
+
+    /** Total RAM size in megabytes */
+    uint32_t ram_size;
+
+    /**
+     * @name Memory Regions
+     * @{
+     */
+
+    MemoryRegion row_mirror;       /**< Simulates rows for RAM size detection */
+    MemoryRegion row_mirror_alias; /**< Alias of the row which is mirrored */
+    MemoryRegion dramcom_iomem;    /**< DRAMCOM module I/O registers */
+    MemoryRegion dramctl_iomem;    /**< DRAMCTL module I/O registers */
+    MemoryRegion dramphy_iomem;    /**< DRAMPHY module I/O registers */
+
+    /** @} */
+
+    /**
+     * @name Hardware Registers
+     * @{
+     */
+
+    uint32_t dramcom[AW_H3_DRAMCOM_REGS_NUM]; /**< Array of DRAMCOM registers */
+    uint32_t dramctl[AW_H3_DRAMCTL_REGS_NUM]; /**< Array of DRAMCTL registers */
+    uint32_t dramphy[AW_H3_DRAMPHY_REGS_NUM] ;/**< Array of DRAMPHY registers */
+
+    /** @} */
+
+} AwH3DramCtlState;
+
+#endif /* HW_MISC_ALLWINNER_H3_DRAMC_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index e7b768ad5b..77b823e7d8 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -54,6 +54,9 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_UART2]      = 0x01c28800,
     [AW_H3_UART3]      = 0x01c28c00,
     [AW_H3_EMAC]       = 0x01c30000,
+    [AW_H3_DRAMCOM]    = 0x01c62000,
+    [AW_H3_DRAMCTL]    = 0x01c63000,
+    [AW_H3_DRAMPHY]    = 0x01c65000,
     [AW_H3_GIC_DIST]   = 0x01c81000,
     [AW_H3_GIC_CPU]    = 0x01c82000,
     [AW_H3_GIC_HYP]    = 0x01c84000,
@@ -108,9 +111,6 @@ struct AwH3Unimplemented {
     { "scr",       0x01c2c400, 1 * KiB },
     { "gpu",       0x01c40000, 64 * KiB },
     { "hstmr",     0x01c60000, 4 * KiB },
-    { "dramcom",   0x01c62000, 4 * KiB },
-    { "dramctl0",  0x01c63000, 4 * KiB },
-    { "dramphy0",  0x01c65000, 4 * KiB },
     { "spi0",      0x01c68000, 4 * KiB },
     { "spi1",      0x01c69000, 4 * KiB },
     { "csi",       0x01cb0000, 320 * KiB },
@@ -237,6 +237,13 @@ static void allwinner_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
                           TYPE_AW_SUN8I_EMAC);
+
+    sysbus_init_child_obj(obj, "dramc", &s->dramc, sizeof(s->dramc),
+                          TYPE_AW_H3_DRAMC);
+    object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
+                             "ram-addr", &error_abort);
+    object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
+                              "ram-size", &error_abort);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -424,6 +431,12 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3),
                    115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
 
+    /* DRAMC */
+    qdev_init_nofail(DEVICE(&s->dramc));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0, s->memmap[AW_H3_DRAMCOM]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1, s->memmap[AW_H3_DRAMCTL]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2, s->memmap[AW_H3_DRAMPHY]);
+
     /* Unimplemented devices */
     for (int i = 0; i < ARRAY_SIZE(unimplemented); i++) {
         create_unimplemented_device(unimplemented[i].device_name,
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index b722f49485..6eee40b461 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -65,6 +65,12 @@ static void orangepi_init(MachineState *machine)
     /* Setup EMAC properties */
     object_property_set_int(OBJECT(&s->h3->emac), 1, "phy-addr", &error_abort);
 
+    /* DRAMC */
+    object_property_set_uint(OBJECT(s->h3), s->h3->memmap[AW_H3_SDRAM],
+                             "ram-addr", &error_abort);
+    object_property_set_int(OBJECT(s->h3), machine->ram_size / MiB, "ram-size",
+                            &error_abort);
+
     /* Mark H3 object realized */
     object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abort);
 
diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
new file mode 100644
index 0000000000..06ce1d92f5
--- /dev/null
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -0,0 +1,358 @@
+/*
+ * Allwinner H3 SDRAM Controller emulation
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
+#include "qemu/error-report.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "hw/misc/allwinner-h3-dramc.h"
+#include "trace.h"
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+/* DRAMCOM register offsets */
+enum {
+    REG_DRAMCOM_CR    = 0x0000, /* Control Register */
+};
+
+/* DRAMCTL register offsets */
+enum {
+    REG_DRAMCTL_PIR   = 0x0000, /* PHY Initialization Register */
+    REG_DRAMCTL_PGSR  = 0x0010, /* PHY General Status Register */
+    REG_DRAMCTL_STATR = 0x0018, /* Status Register */
+};
+
+/* DRAMCTL register flags */
+enum {
+    REG_DRAMCTL_PGSR_INITDONE = (1 << 0),
+};
+
+enum {
+    REG_DRAMCTL_STATR_ACTIVE  = (1 << 0),
+};
+
+static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
+                                        uint8_t bank_bits, uint16_t page_size)
+{
+    /*
+     * This function simulates row addressing behavior when bootloader
+     * software attempts to detect the amount of available SDRAM. In U-Boot
+     * the controller is configured with the widest row addressing available.
+     * Then a pattern is written to RAM at an offset on the row boundary size.
+     * If the value read back equals the value read back from the
+     * start of RAM, the bootloader knows the amount of row bits.
+     *
+     * This function inserts a mirrored memory region when the configured row
+     * bits are not matching the actual emulated memory, to simulate the
+     * same behavior on hardware as expected by the bootloader.
+     */
+    uint8_t row_bits_actual = 0;
+
+    /* Calculate the actual row bits using the ram_size property */
+    for (uint8_t i = 8; i < 12; i++) {
+        if (1 << i == s->ram_size) {
+            row_bits_actual = i + 3;
+            break;
+        }
+    }
+
+    if (s->ram_size == (1 << (row_bits - 3))) {
+        /* When row bits is the expected value, remove the mirror */
+        memory_region_set_enabled(&s->row_mirror_alias, false);
+        trace_allwinner_h3_dramc_rowmirror_disable();
+
+    } else if (row_bits_actual) {
+        /* Row bits not matching ram_size, install the rows mirror */
+        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
+                                                  bank_bits)) * page_size);
+
+        memory_region_set_enabled(&s->row_mirror_alias, true);
+        memory_region_set_address(&s->row_mirror_alias, row_mirror);
+
+        trace_allwinner_h3_dramc_rowmirror_enable(row_mirror);
+    }
+}
+
+static uint64_t allwinner_h3_dramcom_read(void *opaque, hwaddr offset,
+                                          unsigned size)
+{
+    const AwH3DramCtlState *s = AW_H3_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_DRAMCOM_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_h3_dramcom_read(offset, s->dramcom[idx], size);
+
+    return s->dramcom[idx];
+}
+
+static void allwinner_h3_dramcom_write(void *opaque, hwaddr offset,
+                                       uint64_t val, unsigned size)
+{
+    AwH3DramCtlState *s = AW_H3_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_h3_dramcom_write(offset, val, size);
+
+    if (idx >= AW_H3_DRAMCOM_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_DRAMCOM_CR:   /* Control Register */
+        allwinner_h3_dramc_map_rows(s, ((val >> 4) & 0xf) + 1,
+                                       ((val >> 2) & 0x1) + 2,
+                                       1 << (((val >> 8) & 0xf) + 3));
+        break;
+    default:
+        break;
+    };
+
+    s->dramcom[idx] = (uint32_t) val;
+}
+
+static uint64_t allwinner_h3_dramctl_read(void *opaque, hwaddr offset,
+                                          unsigned size)
+{
+    const AwH3DramCtlState *s = AW_H3_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_DRAMCTL_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_h3_dramctl_read(offset, s->dramctl[idx], size);
+
+    return s->dramctl[idx];
+}
+
+static void allwinner_h3_dramctl_write(void *opaque, hwaddr offset,
+                                       uint64_t val, unsigned size)
+{
+    AwH3DramCtlState *s = AW_H3_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_h3_dramctl_write(offset, val, size);
+
+    if (idx >= AW_H3_DRAMCTL_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_DRAMCTL_PIR:    /* PHY Initialization Register */
+        s->dramctl[REG_INDEX(REG_DRAMCTL_PGSR)] |= REG_DRAMCTL_PGSR_INITDONE;
+        s->dramctl[REG_INDEX(REG_DRAMCTL_STATR)] |= REG_DRAMCTL_STATR_ACTIVE;
+        break;
+    default:
+        break;
+    }
+
+    s->dramctl[idx] = (uint32_t) val;
+}
+
+static uint64_t allwinner_h3_dramphy_read(void *opaque, hwaddr offset,
+                                          unsigned size)
+{
+    const AwH3DramCtlState *s = AW_H3_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_DRAMPHY_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_h3_dramphy_read(offset, s->dramphy[idx], size);
+
+    return s->dramphy[idx];
+}
+
+static void allwinner_h3_dramphy_write(void *opaque, hwaddr offset,
+                                       uint64_t val, unsigned size)
+{
+    AwH3DramCtlState *s = AW_H3_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_h3_dramphy_write(offset, val, size);
+
+    if (idx >= AW_H3_DRAMPHY_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    s->dramphy[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_h3_dramcom_ops = {
+    .read = allwinner_h3_dramcom_read,
+    .write = allwinner_h3_dramcom_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const MemoryRegionOps allwinner_h3_dramctl_ops = {
+    .read = allwinner_h3_dramctl_read,
+    .write = allwinner_h3_dramctl_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const MemoryRegionOps allwinner_h3_dramphy_ops = {
+    .read = allwinner_h3_dramphy_read,
+    .write = allwinner_h3_dramphy_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_h3_dramc_reset(DeviceState *dev)
+{
+    AwH3DramCtlState *s = AW_H3_DRAMC(dev);
+
+    /* Set default values for registers */
+    memset(&s->dramcom, 0, sizeof(s->dramcom));
+    memset(&s->dramctl, 0, sizeof(s->dramctl));
+    memset(&s->dramphy, 0, sizeof(s->dramphy));
+}
+
+static void allwinner_h3_dramc_realize(DeviceState *dev, Error **errp)
+{
+    AwH3DramCtlState *s = AW_H3_DRAMC(dev);
+
+    /* Only power of 2 RAM sizes from 256MiB up to 2048MiB are supported */
+    for (uint8_t i = 8; i < 13; i++) {
+        if (1 << i == s->ram_size) {
+            break;
+        } else if (i == 12) {
+            error_report("%s: ram-size %u MiB is not supported",
+                          __func__, s->ram_size);
+            exit(1);
+        }
+    }
+
+    /* Setup row mirror mappings */
+    memory_region_init_ram(&s->row_mirror, OBJECT(s),
+                           "allwinner-h3-dramc.row-mirror",
+                            4 * KiB, &error_abort);
+    memory_region_add_subregion_overlap(get_system_memory(), s->ram_addr,
+                                       &s->row_mirror, 10);
+
+    memory_region_init_alias(&s->row_mirror_alias, OBJECT(s),
+                            "allwinner-h3-dramc.row-mirror-alias",
+                            &s->row_mirror, 0, 4 * KiB);
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        s->ram_addr + 1 * MiB,
+                                       &s->row_mirror_alias, 10);
+    memory_region_set_enabled(&s->row_mirror_alias, false);
+}
+
+static void allwinner_h3_dramc_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3DramCtlState *s = AW_H3_DRAMC(obj);
+
+    /* DRAMCOM registers */
+    memory_region_init_io(&s->dramcom_iomem, OBJECT(s),
+                          &allwinner_h3_dramcom_ops, s,
+                           TYPE_AW_H3_DRAMC, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->dramcom_iomem);
+
+    /* DRAMCTL registers */
+    memory_region_init_io(&s->dramctl_iomem, OBJECT(s),
+                          &allwinner_h3_dramctl_ops, s,
+                           TYPE_AW_H3_DRAMC, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->dramctl_iomem);
+
+    /* DRAMPHY registers */
+    memory_region_init_io(&s->dramphy_iomem, OBJECT(s),
+                          &allwinner_h3_dramphy_ops, s,
+                          TYPE_AW_H3_DRAMC, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->dramphy_iomem);
+}
+
+static Property allwinner_h3_dramc_properties[] = {
+    DEFINE_PROP_UINT64("ram-addr", AwH3DramCtlState, ram_addr, 0x0),
+    DEFINE_PROP_UINT32("ram-size", AwH3DramCtlState, ram_size, 256 * MiB),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static const VMStateDescription allwinner_h3_dramc_vmstate = {
+    .name = "allwinner-h3-dramc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(dramcom, AwH3DramCtlState, AW_H3_DRAMCOM_REGS_NUM),
+        VMSTATE_UINT32_ARRAY(dramctl, AwH3DramCtlState, AW_H3_DRAMCTL_REGS_NUM),
+        VMSTATE_UINT32_ARRAY(dramphy, AwH3DramCtlState, AW_H3_DRAMPHY_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_dramc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_dramc_reset;
+    dc->vmsd = &allwinner_h3_dramc_vmstate;
+    dc->props = allwinner_h3_dramc_properties;
+    dc->realize = allwinner_h3_dramc_realize;
+}
+
+static const TypeInfo allwinner_h3_dramc_info = {
+    .name          = TYPE_AW_H3_DRAMC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_dramc_init,
+    .instance_size = sizeof(AwH3DramCtlState),
+    .class_init    = allwinner_h3_dramc_class_init,
+};
+
+static void allwinner_h3_dramc_register(void)
+{
+    type_register_static(&allwinner_h3_dramc_info);
+}
+
+type_init(allwinner_h3_dramc_register)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 59500d5681..b95b9e5296 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -30,6 +30,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
 obj-$(CONFIG_ALLWINNER_H3) += allwinner-cpucfg.o
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-dramc.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sysctrl.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sid.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 67d8bf493c..c231b4c194 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -5,6 +5,16 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "id %u, reset_ad
 allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# allwinner-h3-dramc.c
+allwinner_h3_dramc_rowmirror_disable(void) "Disable row mirror"
+allwinner_h3_dramc_rowmirror_enable(uint64_t addr) "Enable row mirror: addr 0x%" PRIx64
+allwinner_h3_dramcom_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_h3_dramcom_write(uint64_t offset, uint64_t data, unsigned size) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_h3_dramctl_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_h3_dramctl_write(uint64_t offset, uint64_t data, unsigned size) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_h3_dramphy_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_h3_dramphy_write(uint64_t offset, uint64_t data, unsigned size) "write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+
 # allwinner-sid.c
 allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
-- 
2.17.1


