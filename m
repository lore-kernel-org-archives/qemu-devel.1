Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4DC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E07F20751
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOI8dmal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E07F20751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC9kr-0002zw-DL
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC9h9-0003vG-QO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC9h3-0004tS-Jr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:19:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC9h3-0004qX-7K; Wed, 11 Mar 2020 18:19:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id a141so4017381wme.2;
 Wed, 11 Mar 2020 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZtJerofM48xU4f3yj29UKF6ueDys0ymKNT+2JZH5Evk=;
 b=NOI8dmal7PeU4wSOiY6x+JB9KNz3wEdqftHnjJvXlVFcCL78tdCapHtln7F5/BmIbq
 R52ogXXW+uca1MVpqW1o4SDcbhXIP6QXOT5Nh0UoihAHFiXz5sQYmK43pECOlFbWlaB6
 mm7kJ3mpaAx2KxDCWF/v2fvHpEsMA6s9jIQ9pjE5PjKvaHwvY9bNN7cMfqxA5Kk7gmyE
 k9kuG/l2tH3K/ZI52onIpCeolGuB0ACHfe+85afvakEtCLhvdkJrCTw0WRrItpKJng0B
 gYP8X/FpbVg3l3xnhMVUzFtT7/XIf0UEPpe4LMyCGA8QGSvxt7BEqsdInp696GDuOH+7
 /34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZtJerofM48xU4f3yj29UKF6ueDys0ymKNT+2JZH5Evk=;
 b=dLn66Rd9Kx8SV9+cjH0T/FWLM513YgUAScj/OTv8eWGheYiYsnz2UoQTNdOMkSf4BJ
 vnSjwIlganFT4tKciojRwRpf0TZNhU8FBFY4vModcZMfBiC4B0knbj0UUkSY7tB8m8/i
 ACbthREKRQRyhaI/4egR46WziIQ70IeMp+Ub+cMr9mpDhARQs0Sdk0c6eV5NrDekfF/m
 vjVDqezRNIMpogQzg9m+p3PHHUa6P0A4Z0QoMdoCJTXQOWaI+LgMqrXRYX1UPM4fnnZv
 eQhLVgYwXdi0bH819jLGZPgIskTIso0GjrUNZjDrYwi684YOosQ7PP5BlZWFWboMvhmi
 uPPg==
X-Gm-Message-State: ANhLgQ1jU/1I+sxHRItDD8S1MPl6foZybv34baFkhI3gRA0Ivcqnxm79
 2x86HVjTkFq7LO5WyDPmE1S/gwX/
X-Google-Smtp-Source: ADFU+vvGVpAfVJSBXPHUrv/256YdQNE0/SV6lqA6W/ZdL0fnqUG+PKsfiIxEGO/qLyI3EO7+I9w5FA==
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr867250wmi.80.1583965150788;
 Wed, 11 Mar 2020 15:19:10 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id q7sm19346796wrd.54.2020.03.11.15.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 15:19:10 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/18] hw/arm/allwinner: add SD/MMC host controller
Date: Wed, 11 Mar 2020 23:18:44 +0100
Message-Id: <20200311221854.30370-9-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311221854.30370-1-nieklinnenbank@gmail.com>
References: <20200311221854.30370-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Allwinner System on Chip families sun4i and above contain
an integrated storage controller for Secure Digital (SD) and
Multi Media Card (MMC) interfaces. This commit adds support
for the Allwinner SD/MMC storage controller with the following
emulated features:

 * DMA transfers
 * Direct FIFO I/O
 * Short/Long format command responses
 * Auto-Stop command (CMD12)
 * Insert & remove card detection

The following boards are extended with the SD host controller:

 * Cubieboard (hw/arm/cubieboard.c)
 * Orange Pi PC (hw/arm/orangepi.c)

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/arm/allwinner-a10.h   |   2 +
 include/hw/arm/allwinner-h3.h    |   3 +
 include/hw/sd/allwinner-sdhost.h | 135 +++++
 hw/arm/allwinner-a10.c           |  11 +
 hw/arm/allwinner-h3.c            |  15 +-
 hw/arm/cubieboard.c              |  15 +
 hw/arm/orangepi.c                |  16 +
 hw/sd/allwinner-sdhost.c         | 854 +++++++++++++++++++++++++++++++
 hw/arm/Kconfig                   |   1 +
 hw/sd/Makefile.objs              |   1 +
 hw/sd/trace-events               |   7 +
 11 files changed, 1059 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/sd/allwinner-sdhost.h
 create mode 100644 hw/sd/allwinner-sdhost.c

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 8af724548f..ae33a84b18 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -7,6 +7,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
+#include "hw/sd/allwinner-sdhost.h"
 #include "hw/ide/ahci.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
@@ -31,6 +32,7 @@ typedef struct AwA10State {
     AwA10PICState intc;
     AwEmacState emac;
     AllwinnerAHCIState sata;
+    AwSdHostState mmc0;
     MemoryRegion sram_a;
     EHCISysBusState ehci[AW_A10_NUM_USB];
     OHCISysBusState ohci[AW_A10_NUM_USB];
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 85416d9d64..d71a4917ab 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -43,6 +43,7 @@
 #include "hw/misc/allwinner-cpucfg.h"
 #include "hw/misc/allwinner-h3-sysctrl.h"
 #include "hw/misc/allwinner-sid.h"
+#include "hw/sd/allwinner-sdhost.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -60,6 +61,7 @@ enum {
     AW_H3_SRAM_A2,
     AW_H3_SRAM_C,
     AW_H3_SYSCTRL,
+    AW_H3_MMC0,
     AW_H3_SID,
     AW_H3_EHCI0,
     AW_H3_OHCI0,
@@ -117,6 +119,7 @@ typedef struct AwH3State {
     AwCpuCfgState cpucfg;
     AwH3SysCtrlState sysctrl;
     AwSidState sid;
+    AwSdHostState mmc0;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdhost.h
new file mode 100644
index 0000000000..d94606a853
--- /dev/null
+++ b/include/hw/sd/allwinner-sdhost.h
@@ -0,0 +1,135 @@
+/*
+ * Allwinner (sun4i and above) SD Host Controller emulation
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
+#ifndef HW_SD_ALLWINNER_SDHOST_H
+#define HW_SD_ALLWINNER_SDHOST_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/sd/sd.h"
+
+/**
+ * Object model types
+ * @{
+ */
+
+/** Generic Allwinner SD Host Controller (abstract) */
+#define TYPE_AW_SDHOST "allwinner-sdhost"
+
+/** Allwinner sun4i family (A10, A12) */
+#define TYPE_AW_SDHOST_SUN4I TYPE_AW_SDHOST "-sun4i"
+
+/** Allwinner sun5i family and newer (A13, H2+, H3, etc) */
+#define TYPE_AW_SDHOST_SUN5I TYPE_AW_SDHOST "-sun5i"
+
+/** @} */
+
+/**
+ * Object model macros
+ * @{
+ */
+
+#define AW_SDHOST(obj) \
+    OBJECT_CHECK(AwSdHostState, (obj), TYPE_AW_SDHOST)
+#define AW_SDHOST_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AwSdHostClass, (klass), TYPE_AW_SDHOST)
+#define AW_SDHOST_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AwSdHostClass, (obj), TYPE_AW_SDHOST)
+
+/** @} */
+
+/**
+ * Allwinner SD Host Controller object instance state.
+ */
+typedef struct AwSdHostState {
+    /*< private >*/
+    SysBusDevice busdev;
+    /*< public >*/
+
+    /** Secure Digital (SD) bus, which connects to SD card (if present) */
+    SDBus sdbus;
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Interrupt output signal to notify CPU */
+    qemu_irq irq;
+
+    /** Number of bytes left in current DMA transfer */
+    uint32_t transfer_cnt;
+
+    /**
+     * @name Hardware Registers
+     * @{
+     */
+
+    uint32_t global_ctl;        /**< Global Control */
+    uint32_t clock_ctl;         /**< Clock Control */
+    uint32_t timeout;           /**< Timeout */
+    uint32_t bus_width;         /**< Bus Width */
+    uint32_t block_size;        /**< Block Size */
+    uint32_t byte_count;        /**< Byte Count */
+
+    uint32_t command;           /**< Command */
+    uint32_t command_arg;       /**< Command Argument */
+    uint32_t response[4];       /**< Command Response */
+
+    uint32_t irq_mask;          /**< Interrupt Mask */
+    uint32_t irq_status;        /**< Raw Interrupt Status */
+    uint32_t status;            /**< Status */
+
+    uint32_t fifo_wlevel;       /**< FIFO Water Level */
+    uint32_t fifo_func_sel;     /**< FIFO Function Select */
+    uint32_t debug_enable;      /**< Debug Enable */
+    uint32_t auto12_arg;        /**< Auto Command 12 Argument */
+    uint32_t newtiming_set;     /**< SD New Timing Set */
+    uint32_t newtiming_debug;   /**< SD New Timing Debug */
+    uint32_t hardware_rst;      /**< Hardware Reset */
+    uint32_t dmac;              /**< Internal DMA Controller Control */
+    uint32_t desc_base;         /**< Descriptor List Base Address */
+    uint32_t dmac_status;       /**< Internal DMA Controller Status */
+    uint32_t dmac_irq;          /**< Internal DMA Controller IRQ Enable */
+    uint32_t card_threshold;    /**< Card Threshold Control */
+    uint32_t startbit_detect;   /**< eMMC DDR Start Bit Detection Control */
+    uint32_t response_crc;      /**< Response CRC */
+    uint32_t data_crc[8];       /**< Data CRC */
+    uint32_t status_crc;        /**< Status CRC */
+
+    /** @} */
+
+} AwSdHostState;
+
+/**
+ * Allwinner SD Host Controller class-level struct.
+ *
+ * This struct is filled by each sunxi device specific code
+ * such that the generic code can use this struct to support
+ * all devices.
+ */
+typedef struct AwSdHostClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+
+    /** Maximum buffer size in bytes per DMA descriptor */
+    size_t max_desc_size;
+
+} AwSdHostClass;
+
+#endif /* HW_SD_ALLWINNER_SDHOST_H */
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 2ae9c15311..dc62c76416 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -27,6 +27,7 @@
 #include "hw/boards.h"
 #include "hw/usb/hcd-ohci.h"
 
+#define AW_A10_MMC0_BASE        0x01c0f000
 #define AW_A10_PIC_REG_BASE     0x01c20400
 #define AW_A10_PIT_REG_BASE     0x01c20c00
 #define AW_A10_UART0_REG_BASE   0x01c28000
@@ -64,6 +65,9 @@ static void aw_a10_init(Object *obj)
                                   sizeof(s->ohci[i]), TYPE_SYSBUS_OHCI);
         }
     }
+
+    sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
+                          TYPE_AW_SDHOST_SUN4I);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -164,6 +168,13 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                                qdev_get_gpio_in(dev, 64 + i));
         }
     }
+
+    /* SD/MMC */
+    qdev_init_nofail(DEVICE(&s->mmc0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev, 32));
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
+                              "sd-bus", &error_abort);
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index deeea63f5f..8c7ac61517 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_SRAM_A2]    = 0x00044000,
     [AW_H3_SRAM_C]     = 0x00010000,
     [AW_H3_SYSCTRL]    = 0x01c00000,
+    [AW_H3_MMC0]       = 0x01c0f000,
     [AW_H3_SID]        = 0x01c14000,
     [AW_H3_EHCI0]      = 0x01c1a000,
     [AW_H3_OHCI0]      = 0x01c1a400,
@@ -76,7 +77,6 @@ struct AwH3Unimplemented {
     { "lcd0",      0x01c0c000, 4 * KiB },
     { "lcd1",      0x01c0d000, 4 * KiB },
     { "ve",        0x01c0e000, 4 * KiB },
-    { "mmc0",      0x01c0f000, 4 * KiB },
     { "mmc1",      0x01c10000, 4 * KiB },
     { "mmc2",      0x01c11000, 4 * KiB },
     { "crypto",    0x01c15000, 4 * KiB },
@@ -153,6 +153,7 @@ enum {
     AW_H3_GIC_SPI_UART3     =  3,
     AW_H3_GIC_SPI_TIMER0    = 18,
     AW_H3_GIC_SPI_TIMER1    = 19,
+    AW_H3_GIC_SPI_MMC0      = 60,
     AW_H3_GIC_SPI_EHCI0     = 72,
     AW_H3_GIC_SPI_OHCI0     = 73,
     AW_H3_GIC_SPI_EHCI1     = 74,
@@ -203,6 +204,9 @@ static void allwinner_h3_init(Object *obj)
                           TYPE_AW_SID);
     object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
                               "identifier", &error_abort);
+
+    sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
+                          TYPE_AW_SDHOST_SUN5I);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -324,6 +328,15 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(&s->sid));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
 
+    /* SD/MMC */
+    qdev_init_nofail(DEVICE(&s->mmc0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_MMC0));
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
+                              "sd-bus", &error_abort);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 871b1beef4..cabc3d94dc 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,6 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 
 static struct arm_boot_info cubieboard_binfo = {
@@ -33,6 +34,10 @@ static void cubieboard_init(MachineState *machine)
 {
     AwA10State *a10;
     Error *err = NULL;
+    DriveInfo *di;
+    BlockBackend *blk;
+    BusState *bus;
+    DeviceState *carddev;
 
     /* BIOS is not supported by this board */
     if (bios_name) {
@@ -79,6 +84,16 @@ static void cubieboard_init(MachineState *machine)
         exit(1);
     }
 
+    /* Retrieve SD bus */
+    di = drive_get_next(IF_SD);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    bus = qdev_get_child_bus(DEVICE(a10), "sd-bus");
+
+    /* Plug in SD card */
+    carddev = qdev_create(bus, TYPE_SD_CARD);
+    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+
     memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
                                 machine->ram);
 
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 4047c4c386..e7ac7b1d14 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -35,6 +35,10 @@ static struct arm_boot_info orangepi_binfo = {
 static void orangepi_init(MachineState *machine)
 {
     AwH3State *h3;
+    DriveInfo *di;
+    BlockBackend *blk;
+    BusState *bus;
+    DeviceState *carddev;
 
     /* BIOS is not supported by this board */
     if (bios_name) {
@@ -76,6 +80,16 @@ static void orangepi_init(MachineState *machine)
     /* Mark H3 object realized */
     object_property_set_bool(OBJECT(h3), true, "realized", &error_abort);
 
+    /* Retrieve SD bus */
+    di = drive_get_next(IF_SD);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    bus = qdev_get_child_bus(DEVICE(h3), "sd-bus");
+
+    /* Plug in SD card */
+    carddev = qdev_create(bus, TYPE_SD_CARD);
+    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+
     /* SDRAM */
     memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SDRAM],
                                 machine->ram);
@@ -89,6 +103,8 @@ static void orangepi_machine_init(MachineClass *mc)
 {
     mc->desc = "Orange Pi PC";
     mc->init = orangepi_init;
+    mc->block_default_type = IF_SD;
+    mc->units_per_default_bus = 1;
     mc->min_cpus = AW_H3_NUM_CPUS;
     mc->max_cpus = AW_H3_NUM_CPUS;
     mc->default_cpus = AW_H3_NUM_CPUS;
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
new file mode 100644
index 0000000000..f404e1fdb4
--- /dev/null
+++ b/hw/sd/allwinner-sdhost.c
@@ -0,0 +1,854 @@
+/*
+ * Allwinner (sun4i and above) SD Host Controller emulation
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
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "sysemu/blockdev.h"
+#include "hw/irq.h"
+#include "hw/sd/allwinner-sdhost.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define TYPE_AW_SDHOST_BUS "allwinner-sdhost-bus"
+#define AW_SDHOST_BUS(obj) \
+    OBJECT_CHECK(SDBus, (obj), TYPE_AW_SDHOST_BUS)
+
+/* SD Host register offsets */
+enum {
+    REG_SD_GCTL       = 0x00,  /* Global Control */
+    REG_SD_CKCR       = 0x04,  /* Clock Control */
+    REG_SD_TMOR       = 0x08,  /* Timeout */
+    REG_SD_BWDR       = 0x0C,  /* Bus Width */
+    REG_SD_BKSR       = 0x10,  /* Block Size */
+    REG_SD_BYCR       = 0x14,  /* Byte Count */
+    REG_SD_CMDR       = 0x18,  /* Command */
+    REG_SD_CAGR       = 0x1C,  /* Command Argument */
+    REG_SD_RESP0      = 0x20,  /* Response Zero */
+    REG_SD_RESP1      = 0x24,  /* Response One */
+    REG_SD_RESP2      = 0x28,  /* Response Two */
+    REG_SD_RESP3      = 0x2C,  /* Response Three */
+    REG_SD_IMKR       = 0x30,  /* Interrupt Mask */
+    REG_SD_MISR       = 0x34,  /* Masked Interrupt Status */
+    REG_SD_RISR       = 0x38,  /* Raw Interrupt Status */
+    REG_SD_STAR       = 0x3C,  /* Status */
+    REG_SD_FWLR       = 0x40,  /* FIFO Water Level */
+    REG_SD_FUNS       = 0x44,  /* FIFO Function Select */
+    REG_SD_DBGC       = 0x50,  /* Debug Enable */
+    REG_SD_A12A       = 0x58,  /* Auto command 12 argument */
+    REG_SD_NTSR       = 0x5C,  /* SD NewTiming Set */
+    REG_SD_SDBG       = 0x60,  /* SD newTiming Set Debug */
+    REG_SD_HWRST      = 0x78,  /* Hardware Reset Register */
+    REG_SD_DMAC       = 0x80,  /* Internal DMA Controller Control */
+    REG_SD_DLBA       = 0x84,  /* Descriptor List Base Address */
+    REG_SD_IDST       = 0x88,  /* Internal DMA Controller Status */
+    REG_SD_IDIE       = 0x8C,  /* Internal DMA Controller IRQ Enable */
+    REG_SD_THLDC      = 0x100, /* Card Threshold Control */
+    REG_SD_DSBD       = 0x10C, /* eMMC DDR Start Bit Detection Control */
+    REG_SD_RES_CRC    = 0x110, /* Response CRC from card/eMMC */
+    REG_SD_DATA7_CRC  = 0x114, /* CRC Data 7 from card/eMMC */
+    REG_SD_DATA6_CRC  = 0x118, /* CRC Data 6 from card/eMMC */
+    REG_SD_DATA5_CRC  = 0x11C, /* CRC Data 5 from card/eMMC */
+    REG_SD_DATA4_CRC  = 0x120, /* CRC Data 4 from card/eMMC */
+    REG_SD_DATA3_CRC  = 0x124, /* CRC Data 3 from card/eMMC */
+    REG_SD_DATA2_CRC  = 0x128, /* CRC Data 2 from card/eMMC */
+    REG_SD_DATA1_CRC  = 0x12C, /* CRC Data 1 from card/eMMC */
+    REG_SD_DATA0_CRC  = 0x130, /* CRC Data 0 from card/eMMC */
+    REG_SD_CRC_STA    = 0x134, /* CRC status from card/eMMC during write */
+    REG_SD_FIFO       = 0x200, /* Read/Write FIFO */
+};
+
+/* SD Host register flags */
+enum {
+    SD_GCTL_FIFO_AC_MOD     = (1 << 31),
+    SD_GCTL_DDR_MOD_SEL     = (1 << 10),
+    SD_GCTL_CD_DBC_ENB      = (1 << 8),
+    SD_GCTL_DMA_ENB         = (1 << 5),
+    SD_GCTL_INT_ENB         = (1 << 4),
+    SD_GCTL_DMA_RST         = (1 << 2),
+    SD_GCTL_FIFO_RST        = (1 << 1),
+    SD_GCTL_SOFT_RST        = (1 << 0),
+};
+
+enum {
+    SD_CMDR_LOAD            = (1 << 31),
+    SD_CMDR_CLKCHANGE       = (1 << 21),
+    SD_CMDR_WRITE           = (1 << 10),
+    SD_CMDR_AUTOSTOP        = (1 << 12),
+    SD_CMDR_DATA            = (1 << 9),
+    SD_CMDR_RESPONSE_LONG   = (1 << 7),
+    SD_CMDR_RESPONSE        = (1 << 6),
+    SD_CMDR_CMDID_MASK      = (0x3f),
+};
+
+enum {
+    SD_RISR_CARD_REMOVE     = (1 << 31),
+    SD_RISR_CARD_INSERT     = (1 << 30),
+    SD_RISR_SDIO_INTR       = (1 << 16),
+    SD_RISR_AUTOCMD_DONE    = (1 << 14),
+    SD_RISR_DATA_COMPLETE   = (1 << 3),
+    SD_RISR_CMD_COMPLETE    = (1 << 2),
+    SD_RISR_NO_RESPONSE     = (1 << 1),
+};
+
+enum {
+    SD_STAR_CARD_PRESENT    = (1 << 8),
+};
+
+enum {
+    SD_IDST_INT_SUMMARY     = (1 << 8),
+    SD_IDST_RECEIVE_IRQ     = (1 << 1),
+    SD_IDST_TRANSMIT_IRQ    = (1 << 0),
+    SD_IDST_IRQ_MASK        = (1 << 1) | (1 << 0) | (1 << 8),
+    SD_IDST_WR_MASK         = (0x3ff),
+};
+
+/* SD Host register reset values */
+enum {
+    REG_SD_GCTL_RST         = 0x00000300,
+    REG_SD_CKCR_RST         = 0x0,
+    REG_SD_TMOR_RST         = 0xFFFFFF40,
+    REG_SD_BWDR_RST         = 0x0,
+    REG_SD_BKSR_RST         = 0x00000200,
+    REG_SD_BYCR_RST         = 0x00000200,
+    REG_SD_CMDR_RST         = 0x0,
+    REG_SD_CAGR_RST         = 0x0,
+    REG_SD_RESP_RST         = 0x0,
+    REG_SD_IMKR_RST         = 0x0,
+    REG_SD_MISR_RST         = 0x0,
+    REG_SD_RISR_RST         = 0x0,
+    REG_SD_STAR_RST         = 0x00000100,
+    REG_SD_FWLR_RST         = 0x000F0000,
+    REG_SD_FUNS_RST         = 0x0,
+    REG_SD_DBGC_RST         = 0x0,
+    REG_SD_A12A_RST         = 0x0000FFFF,
+    REG_SD_NTSR_RST         = 0x00000001,
+    REG_SD_SDBG_RST         = 0x0,
+    REG_SD_HWRST_RST        = 0x00000001,
+    REG_SD_DMAC_RST         = 0x0,
+    REG_SD_DLBA_RST         = 0x0,
+    REG_SD_IDST_RST         = 0x0,
+    REG_SD_IDIE_RST         = 0x0,
+    REG_SD_THLDC_RST        = 0x0,
+    REG_SD_DSBD_RST         = 0x0,
+    REG_SD_RES_CRC_RST      = 0x0,
+    REG_SD_DATA_CRC_RST     = 0x0,
+    REG_SD_CRC_STA_RST      = 0x0,
+    REG_SD_FIFO_RST         = 0x0,
+};
+
+/* Data transfer descriptor for DMA */
+typedef struct TransferDescriptor {
+    uint32_t status; /* Status flags */
+    uint32_t size;   /* Data buffer size */
+    uint32_t addr;   /* Data buffer address */
+    uint32_t next;   /* Physical address of next descriptor */
+} TransferDescriptor;
+
+/* Data transfer descriptor flags */
+enum {
+    DESC_STATUS_HOLD   = (1 << 31), /* Set when descriptor is in use by DMA */
+    DESC_STATUS_ERROR  = (1 << 30), /* Set when DMA transfer error occurred */
+    DESC_STATUS_CHAIN  = (1 << 4),  /* Indicates chained descriptor. */
+    DESC_STATUS_FIRST  = (1 << 3),  /* Set on the first descriptor */
+    DESC_STATUS_LAST   = (1 << 2),  /* Set on the last descriptor */
+    DESC_STATUS_NOIRQ  = (1 << 1),  /* Skip raising interrupt after transfer */
+    DESC_SIZE_MASK     = (0xfffffffc)
+};
+
+static void allwinner_sdhost_update_irq(AwSdHostState *s)
+{
+    uint32_t irq;
+
+    if (s->global_ctl & SD_GCTL_INT_ENB) {
+        irq = s->irq_status & s->irq_mask;
+    } else {
+        irq = 0;
+    }
+
+    trace_allwinner_sdhost_update_irq(irq);
+    qemu_set_irq(s->irq, irq);
+}
+
+static void allwinner_sdhost_update_transfer_cnt(AwSdHostState *s,
+                                                 uint32_t bytes)
+{
+    if (s->transfer_cnt > bytes) {
+        s->transfer_cnt -= bytes;
+    } else {
+        s->transfer_cnt = 0;
+    }
+
+    if (!s->transfer_cnt) {
+        s->irq_status |= SD_RISR_DATA_COMPLETE;
+    }
+}
+
+static void allwinner_sdhost_set_inserted(DeviceState *dev, bool inserted)
+{
+    AwSdHostState *s = AW_SDHOST(dev);
+
+    trace_allwinner_sdhost_set_inserted(inserted);
+
+    if (inserted) {
+        s->irq_status |= SD_RISR_CARD_INSERT;
+        s->irq_status &= ~SD_RISR_CARD_REMOVE;
+        s->status |= SD_STAR_CARD_PRESENT;
+    } else {
+        s->irq_status &= ~SD_RISR_CARD_INSERT;
+        s->irq_status |= SD_RISR_CARD_REMOVE;
+        s->status &= ~SD_STAR_CARD_PRESENT;
+    }
+
+    allwinner_sdhost_update_irq(s);
+}
+
+static void allwinner_sdhost_send_command(AwSdHostState *s)
+{
+    SDRequest request;
+    uint8_t resp[16];
+    int rlen;
+
+    /* Auto clear load flag */
+    s->command &= ~SD_CMDR_LOAD;
+
+    /* Clock change does not actually interact with the SD bus */
+    if (!(s->command & SD_CMDR_CLKCHANGE)) {
+
+        /* Prepare request */
+        request.cmd = s->command & SD_CMDR_CMDID_MASK;
+        request.arg = s->command_arg;
+
+        /* Send request to SD bus */
+        rlen = sdbus_do_command(&s->sdbus, &request, resp);
+        if (rlen < 0) {
+            goto error;
+        }
+
+        /* If the command has a response, store it in the response registers */
+        if ((s->command & SD_CMDR_RESPONSE)) {
+            if (rlen == 4 && !(s->command & SD_CMDR_RESPONSE_LONG)) {
+                s->response[0] = ldl_be_p(&resp[0]);
+                s->response[1] = s->response[2] = s->response[3] = 0;
+
+            } else if (rlen == 16 && (s->command & SD_CMDR_RESPONSE_LONG)) {
+                s->response[0] = ldl_be_p(&resp[12]);
+                s->response[1] = ldl_be_p(&resp[8]);
+                s->response[2] = ldl_be_p(&resp[4]);
+                s->response[3] = ldl_be_p(&resp[0]);
+            } else {
+                goto error;
+            }
+        }
+    }
+
+    /* Set interrupt status bits */
+    s->irq_status |= SD_RISR_CMD_COMPLETE;
+    return;
+
+error:
+    s->irq_status |= SD_RISR_NO_RESPONSE;
+}
+
+static void allwinner_sdhost_auto_stop(AwSdHostState *s)
+{
+    /*
+     * The stop command (CMD12) ensures the SD bus
+     * returns to the transfer state.
+     */
+    if ((s->command & SD_CMDR_AUTOSTOP) && (s->transfer_cnt == 0)) {
+        /* First save current command registers */
+        uint32_t saved_cmd = s->command;
+        uint32_t saved_arg = s->command_arg;
+
+        /* Prepare stop command (CMD12) */
+        s->command &= ~SD_CMDR_CMDID_MASK;
+        s->command |= 12; /* CMD12 */
+        s->command_arg = 0;
+
+        /* Put the command on SD bus */
+        allwinner_sdhost_send_command(s);
+
+        /* Restore command values */
+        s->command = saved_cmd;
+        s->command_arg = saved_arg;
+
+        /* Set IRQ status bit for automatic stop done */
+        s->irq_status |= SD_RISR_AUTOCMD_DONE;
+    }
+}
+
+static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
+                                              hwaddr desc_addr,
+                                              TransferDescriptor *desc,
+                                              bool is_write, uint32_t max_bytes)
+{
+    AwSdHostClass *klass = AW_SDHOST_GET_CLASS(s);
+    uint32_t num_done = 0;
+    uint32_t num_bytes = max_bytes;
+    uint8_t buf[1024];
+
+    /* Read descriptor */
+    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
+    if (desc->size == 0) {
+        desc->size = klass->max_desc_size;
+    } else if (desc->size > klass->max_desc_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA descriptor buffer size "
+                      " is out-of-bounds: %" PRIu32 " > %zu",
+                      __func__, desc->size, klass->max_desc_size);
+        desc->size = klass->max_desc_size;
+    }
+    if (desc->size < num_bytes) {
+        num_bytes = desc->size;
+    }
+
+    trace_allwinner_sdhost_process_desc(desc_addr, desc->size,
+                                        is_write, max_bytes);
+
+    while (num_done < num_bytes) {
+        /* Try to completely fill the local buffer */
+        uint32_t buf_bytes = num_bytes - num_done;
+        if (buf_bytes > sizeof(buf)) {
+            buf_bytes = sizeof(buf);
+        }
+
+        /* Write to SD bus */
+        if (is_write) {
+            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) + num_done,
+                                      buf, buf_bytes);
+
+            for (uint32_t i = 0; i < buf_bytes; i++) {
+                sdbus_write_data(&s->sdbus, buf[i]);
+            }
+
+        /* Read from SD bus */
+        } else {
+            for (uint32_t i = 0; i < buf_bytes; i++) {
+                buf[i] = sdbus_read_data(&s->sdbus);
+            }
+            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) + num_done,
+                                       buf, buf_bytes);
+        }
+        num_done += buf_bytes;
+    }
+
+    /* Clear hold flag and flush descriptor */
+    desc->status &= ~DESC_STATUS_HOLD;
+    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
+
+    return num_done;
+}
+
+static void allwinner_sdhost_dma(AwSdHostState *s)
+{
+    TransferDescriptor desc;
+    hwaddr desc_addr = s->desc_base;
+    bool is_write = (s->command & SD_CMDR_WRITE);
+    uint32_t bytes_done = 0;
+
+    /* Check if DMA can be performed */
+    if (s->byte_count == 0 || s->block_size == 0 ||
+      !(s->global_ctl & SD_GCTL_DMA_ENB)) {
+        return;
+    }
+
+    /*
+     * For read operations, data must be available on the SD bus
+     * If not, it is an error and we should not act at all
+     */
+    if (!is_write && !sdbus_data_ready(&s->sdbus)) {
+        return;
+    }
+
+    /* Process the DMA descriptors until all data is copied */
+    while (s->byte_count > 0) {
+        bytes_done = allwinner_sdhost_process_desc(s, desc_addr, &desc,
+                                                   is_write, s->byte_count);
+        allwinner_sdhost_update_transfer_cnt(s, bytes_done);
+
+        if (bytes_done <= s->byte_count) {
+            s->byte_count -= bytes_done;
+        } else {
+            s->byte_count = 0;
+        }
+
+        if (desc.status & DESC_STATUS_LAST) {
+            break;
+        } else {
+            desc_addr = desc.next;
+        }
+    }
+
+    /* Raise IRQ to signal DMA is completed */
+    s->irq_status |= SD_RISR_DATA_COMPLETE | SD_RISR_SDIO_INTR;
+
+    /* Update DMAC bits */
+    s->dmac_status |= SD_IDST_INT_SUMMARY;
+
+    if (is_write) {
+        s->dmac_status |= SD_IDST_TRANSMIT_IRQ;
+    } else {
+        s->dmac_status |= SD_IDST_RECEIVE_IRQ;
+    }
+}
+
+static uint64_t allwinner_sdhost_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    AwSdHostState *s = AW_SDHOST(opaque);
+    uint32_t res = 0;
+
+    switch (offset) {
+    case REG_SD_GCTL:      /* Global Control */
+        res = s->global_ctl;
+        break;
+    case REG_SD_CKCR:      /* Clock Control */
+        res = s->clock_ctl;
+        break;
+    case REG_SD_TMOR:      /* Timeout */
+        res = s->timeout;
+        break;
+    case REG_SD_BWDR:      /* Bus Width */
+        res = s->bus_width;
+        break;
+    case REG_SD_BKSR:      /* Block Size */
+        res = s->block_size;
+        break;
+    case REG_SD_BYCR:      /* Byte Count */
+        res = s->byte_count;
+        break;
+    case REG_SD_CMDR:      /* Command */
+        res = s->command;
+        break;
+    case REG_SD_CAGR:      /* Command Argument */
+        res = s->command_arg;
+        break;
+    case REG_SD_RESP0:     /* Response Zero */
+        res = s->response[0];
+        break;
+    case REG_SD_RESP1:     /* Response One */
+        res = s->response[1];
+        break;
+    case REG_SD_RESP2:     /* Response Two */
+        res = s->response[2];
+        break;
+    case REG_SD_RESP3:     /* Response Three */
+        res = s->response[3];
+        break;
+    case REG_SD_IMKR:      /* Interrupt Mask */
+        res = s->irq_mask;
+        break;
+    case REG_SD_MISR:      /* Masked Interrupt Status */
+        res = s->irq_status & s->irq_mask;
+        break;
+    case REG_SD_RISR:      /* Raw Interrupt Status */
+        res = s->irq_status;
+        break;
+    case REG_SD_STAR:      /* Status */
+        res = s->status;
+        break;
+    case REG_SD_FWLR:      /* FIFO Water Level */
+        res = s->fifo_wlevel;
+        break;
+    case REG_SD_FUNS:      /* FIFO Function Select */
+        res = s->fifo_func_sel;
+        break;
+    case REG_SD_DBGC:      /* Debug Enable */
+        res = s->debug_enable;
+        break;
+    case REG_SD_A12A:      /* Auto command 12 argument */
+        res = s->auto12_arg;
+        break;
+    case REG_SD_NTSR:      /* SD NewTiming Set */
+        res = s->newtiming_set;
+        break;
+    case REG_SD_SDBG:      /* SD newTiming Set Debug */
+        res = s->newtiming_debug;
+        break;
+    case REG_SD_HWRST:     /* Hardware Reset Register */
+        res = s->hardware_rst;
+        break;
+    case REG_SD_DMAC:      /* Internal DMA Controller Control */
+        res = s->dmac;
+        break;
+    case REG_SD_DLBA:      /* Descriptor List Base Address */
+        res = s->desc_base;
+        break;
+    case REG_SD_IDST:      /* Internal DMA Controller Status */
+        res = s->dmac_status;
+        break;
+    case REG_SD_IDIE:      /* Internal DMA Controller Interrupt Enable */
+        res = s->dmac_irq;
+        break;
+    case REG_SD_THLDC:     /* Card Threshold Control */
+        res = s->card_threshold;
+        break;
+    case REG_SD_DSBD:      /* eMMC DDR Start Bit Detection Control */
+        res = s->startbit_detect;
+        break;
+    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
+        res = s->response_crc;
+        break;
+    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
+    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
+    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
+    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
+    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
+    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
+    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
+    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
+        res = s->data_crc[((offset - REG_SD_DATA7_CRC) / sizeof(uint32_t))];
+        break;
+    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write operation */
+        res = s->status_crc;
+        break;
+    case REG_SD_FIFO:      /* Read/Write FIFO */
+        if (sdbus_data_ready(&s->sdbus)) {
+            res = sdbus_read_data(&s->sdbus);
+            res |= sdbus_read_data(&s->sdbus) << 8;
+            res |= sdbus_read_data(&s->sdbus) << 16;
+            res |= sdbus_read_data(&s->sdbus) << 24;
+            allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
+            allwinner_sdhost_auto_stop(s);
+            allwinner_sdhost_update_irq(s);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: no data ready on SD bus\n",
+                          __func__);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
+                      HWADDR_PRIx"\n", __func__, offset);
+        res = 0;
+        break;
+    }
+
+    trace_allwinner_sdhost_read(offset, res, size);
+    return res;
+}
+
+static void allwinner_sdhost_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    AwSdHostState *s = AW_SDHOST(opaque);
+
+    trace_allwinner_sdhost_write(offset, value, size);
+
+    switch (offset) {
+    case REG_SD_GCTL:      /* Global Control */
+        s->global_ctl = value;
+        s->global_ctl &= ~(SD_GCTL_DMA_RST | SD_GCTL_FIFO_RST |
+                           SD_GCTL_SOFT_RST);
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_CKCR:      /* Clock Control */
+        s->clock_ctl = value;
+        break;
+    case REG_SD_TMOR:      /* Timeout */
+        s->timeout = value;
+        break;
+    case REG_SD_BWDR:      /* Bus Width */
+        s->bus_width = value;
+        break;
+    case REG_SD_BKSR:      /* Block Size */
+        s->block_size = value;
+        break;
+    case REG_SD_BYCR:      /* Byte Count */
+        s->byte_count = value;
+        s->transfer_cnt = value;
+        break;
+    case REG_SD_CMDR:      /* Command */
+        s->command = value;
+        if (value & SD_CMDR_LOAD) {
+            allwinner_sdhost_send_command(s);
+            allwinner_sdhost_dma(s);
+            allwinner_sdhost_auto_stop(s);
+        }
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_CAGR:      /* Command Argument */
+        s->command_arg = value;
+        break;
+    case REG_SD_RESP0:     /* Response Zero */
+        s->response[0] = value;
+        break;
+    case REG_SD_RESP1:     /* Response One */
+        s->response[1] = value;
+        break;
+    case REG_SD_RESP2:     /* Response Two */
+        s->response[2] = value;
+        break;
+    case REG_SD_RESP3:     /* Response Three */
+        s->response[3] = value;
+        break;
+    case REG_SD_IMKR:      /* Interrupt Mask */
+        s->irq_mask = value;
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_MISR:      /* Masked Interrupt Status */
+    case REG_SD_RISR:      /* Raw Interrupt Status */
+        s->irq_status &= ~value;
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_STAR:      /* Status */
+        s->status &= ~value;
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_FWLR:      /* FIFO Water Level */
+        s->fifo_wlevel = value;
+        break;
+    case REG_SD_FUNS:      /* FIFO Function Select */
+        s->fifo_func_sel = value;
+        break;
+    case REG_SD_DBGC:      /* Debug Enable */
+        s->debug_enable = value;
+        break;
+    case REG_SD_A12A:      /* Auto command 12 argument */
+        s->auto12_arg = value;
+        break;
+    case REG_SD_NTSR:      /* SD NewTiming Set */
+        s->newtiming_set = value;
+        break;
+    case REG_SD_SDBG:      /* SD newTiming Set Debug */
+        s->newtiming_debug = value;
+        break;
+    case REG_SD_HWRST:     /* Hardware Reset Register */
+        s->hardware_rst = value;
+        break;
+    case REG_SD_DMAC:      /* Internal DMA Controller Control */
+        s->dmac = value;
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_DLBA:      /* Descriptor List Base Address */
+        s->desc_base = value;
+        break;
+    case REG_SD_IDST:      /* Internal DMA Controller Status */
+        s->dmac_status &= (~SD_IDST_WR_MASK) | (~value & SD_IDST_WR_MASK);
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_IDIE:      /* Internal DMA Controller Interrupt Enable */
+        s->dmac_irq = value;
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_THLDC:     /* Card Threshold Control */
+        s->card_threshold = value;
+        break;
+    case REG_SD_DSBD:      /* eMMC DDR Start Bit Detection Control */
+        s->startbit_detect = value;
+        break;
+    case REG_SD_FIFO:      /* Read/Write FIFO */
+        sdbus_write_data(&s->sdbus, value & 0xff);
+        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
+        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
+        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
+        allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
+        allwinner_sdhost_auto_stop(s);
+        allwinner_sdhost_update_irq(s);
+        break;
+    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
+    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
+    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
+    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
+    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
+    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
+    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
+    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
+    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
+    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write operation */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
+                      HWADDR_PRIx"\n", __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_sdhost_ops = {
+    .read = allwinner_sdhost_read,
+    .write = allwinner_sdhost_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const VMStateDescription vmstate_allwinner_sdhost = {
+    .name = "allwinner-sdhost",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(global_ctl, AwSdHostState),
+        VMSTATE_UINT32(clock_ctl, AwSdHostState),
+        VMSTATE_UINT32(timeout, AwSdHostState),
+        VMSTATE_UINT32(bus_width, AwSdHostState),
+        VMSTATE_UINT32(block_size, AwSdHostState),
+        VMSTATE_UINT32(byte_count, AwSdHostState),
+        VMSTATE_UINT32(transfer_cnt, AwSdHostState),
+        VMSTATE_UINT32(command, AwSdHostState),
+        VMSTATE_UINT32(command_arg, AwSdHostState),
+        VMSTATE_UINT32_ARRAY(response, AwSdHostState, 4),
+        VMSTATE_UINT32(irq_mask, AwSdHostState),
+        VMSTATE_UINT32(irq_status, AwSdHostState),
+        VMSTATE_UINT32(status, AwSdHostState),
+        VMSTATE_UINT32(fifo_wlevel, AwSdHostState),
+        VMSTATE_UINT32(fifo_func_sel, AwSdHostState),
+        VMSTATE_UINT32(debug_enable, AwSdHostState),
+        VMSTATE_UINT32(auto12_arg, AwSdHostState),
+        VMSTATE_UINT32(newtiming_set, AwSdHostState),
+        VMSTATE_UINT32(newtiming_debug, AwSdHostState),
+        VMSTATE_UINT32(hardware_rst, AwSdHostState),
+        VMSTATE_UINT32(dmac, AwSdHostState),
+        VMSTATE_UINT32(desc_base, AwSdHostState),
+        VMSTATE_UINT32(dmac_status, AwSdHostState),
+        VMSTATE_UINT32(dmac_irq, AwSdHostState),
+        VMSTATE_UINT32(card_threshold, AwSdHostState),
+        VMSTATE_UINT32(startbit_detect, AwSdHostState),
+        VMSTATE_UINT32(response_crc, AwSdHostState),
+        VMSTATE_UINT32_ARRAY(data_crc, AwSdHostState, 8),
+        VMSTATE_UINT32(status_crc, AwSdHostState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_sdhost_init(Object *obj)
+{
+    AwSdHostState *s = AW_SDHOST(obj);
+
+    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
+                         TYPE_AW_SDHOST_BUS, DEVICE(s), "sd-bus");
+
+    memory_region_init_io(&s->iomem, obj, &allwinner_sdhost_ops, s,
+                           TYPE_AW_SDHOST, 4 * KiB);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+}
+
+static void allwinner_sdhost_reset(DeviceState *dev)
+{
+    AwSdHostState *s = AW_SDHOST(dev);
+
+    s->global_ctl = REG_SD_GCTL_RST;
+    s->clock_ctl = REG_SD_CKCR_RST;
+    s->timeout = REG_SD_TMOR_RST;
+    s->bus_width = REG_SD_BWDR_RST;
+    s->block_size = REG_SD_BKSR_RST;
+    s->byte_count = REG_SD_BYCR_RST;
+    s->transfer_cnt = 0;
+
+    s->command = REG_SD_CMDR_RST;
+    s->command_arg = REG_SD_CAGR_RST;
+
+    for (int i = 0; i < ARRAY_SIZE(s->response); i++) {
+        s->response[i] = REG_SD_RESP_RST;
+    }
+
+    s->irq_mask = REG_SD_IMKR_RST;
+    s->irq_status = REG_SD_RISR_RST;
+    s->status = REG_SD_STAR_RST;
+
+    s->fifo_wlevel = REG_SD_FWLR_RST;
+    s->fifo_func_sel = REG_SD_FUNS_RST;
+    s->debug_enable = REG_SD_DBGC_RST;
+    s->auto12_arg = REG_SD_A12A_RST;
+    s->newtiming_set = REG_SD_NTSR_RST;
+    s->newtiming_debug = REG_SD_SDBG_RST;
+    s->hardware_rst = REG_SD_HWRST_RST;
+    s->dmac = REG_SD_DMAC_RST;
+    s->desc_base = REG_SD_DLBA_RST;
+    s->dmac_status = REG_SD_IDST_RST;
+    s->dmac_irq = REG_SD_IDIE_RST;
+    s->card_threshold = REG_SD_THLDC_RST;
+    s->startbit_detect = REG_SD_DSBD_RST;
+    s->response_crc = REG_SD_RES_CRC_RST;
+
+    for (int i = 0; i < ARRAY_SIZE(s->data_crc); i++) {
+        s->data_crc[i] = REG_SD_DATA_CRC_RST;
+    }
+
+    s->status_crc = REG_SD_CRC_STA_RST;
+}
+
+static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void *data)
+{
+    SDBusClass *sbc = SD_BUS_CLASS(klass);
+
+    sbc->set_inserted = allwinner_sdhost_set_inserted;
+}
+
+static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_sdhost_reset;
+    dc->vmsd = &vmstate_allwinner_sdhost;
+}
+
+static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, void *data)
+{
+    AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
+    sc->max_desc_size = 8 * KiB;
+}
+
+static void allwinner_sdhost_sun5i_class_init(ObjectClass *klass, void *data)
+{
+    AwSdHostClass *sc = AW_SDHOST_CLASS(klass);
+    sc->max_desc_size = 64 * KiB;
+}
+
+static TypeInfo allwinner_sdhost_info = {
+    .name          = TYPE_AW_SDHOST,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_sdhost_init,
+    .instance_size = sizeof(AwSdHostState),
+    .class_init    = allwinner_sdhost_class_init,
+    .class_size    = sizeof(AwSdHostClass),
+    .abstract      = true,
+};
+
+static const TypeInfo allwinner_sdhost_sun4i_info = {
+    .name          = TYPE_AW_SDHOST_SUN4I,
+    .parent        = TYPE_AW_SDHOST,
+    .class_init    = allwinner_sdhost_sun4i_class_init,
+};
+
+static const TypeInfo allwinner_sdhost_sun5i_info = {
+    .name          = TYPE_AW_SDHOST_SUN5I,
+    .parent        = TYPE_AW_SDHOST,
+    .class_init    = allwinner_sdhost_sun5i_class_init,
+};
+
+static const TypeInfo allwinner_sdhost_bus_info = {
+    .name = TYPE_AW_SDHOST_BUS,
+    .parent = TYPE_SD_BUS,
+    .instance_size = sizeof(SDBus),
+    .class_init = allwinner_sdhost_bus_class_init,
+};
+
+static void allwinner_sdhost_register_types(void)
+{
+    type_register_static(&allwinner_sdhost_info);
+    type_register_static(&allwinner_sdhost_sun4i_info);
+    type_register_static(&allwinner_sdhost_sun5i_info);
+    type_register_static(&allwinner_sdhost_bus_info);
+}
+
+type_init(allwinner_sdhost_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f6422d5466..dd22fffdb0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -306,6 +306,7 @@ config ALLWINNER_H3
     select UNIMP
     select USB_OHCI
     select USB_EHCI_SYSBUS
+    select SD
 
 config RASPI
     bool
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index e371281ac4..0d1df1721c 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
 common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
 
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sdhost.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
 common-obj-$(CONFIG_OMAP) += omap_mmc.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index efcff666a2..5f09d32eb2 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,12 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# allwinner-sdhost.c
+allwinner_sdhost_set_inserted(bool inserted) "inserted %u"
+allwinner_sdhost_process_desc(uint64_t desc_addr, uint32_t desc_size, bool is_write, uint32_t max_bytes) "desc_addr 0x%" PRIx64 " desc_size %" PRIu32 " is_write %u max_bytes %" PRIu32
+allwinner_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%" PRIx32
+
 # bcm2835_sdhost.c
 bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.17.1


