Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D0C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1051A2339D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1051A2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i09a4-000675-Ln
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 15:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eajames@linux.ibm.com>) id 1i09Qi-0003Cj-6f
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.ibm.com>) id 1i09QX-0005BV-5w
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:04:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39276
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
 id 1i09QE-0004gE-08; Tue, 20 Aug 2019 15:04:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7KJ2FWN045506; Tue, 20 Aug 2019 15:02:53 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ugnukjatj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2019 15:02:52 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7KIn9XS012051;
 Tue, 20 Aug 2019 19:02:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04wdc.us.ibm.com with ESMTP id 2ufye068sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Aug 2019 19:02:52 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7KJ2pit64291082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2019 19:02:51 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A7F978064;
 Tue, 20 Aug 2019 19:02:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAC6278063;
 Tue, 20 Aug 2019 19:02:50 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 20 Aug 2019 19:02:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:02:45 -0500
Message-Id: <1566327765-2003-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=980 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200168
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [RFC v3] hw/sd/aspeed_sdhci: New device
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au,
 Eddie James <eajames@linux.ibm.com>, qemu-arm@nongnu.org, joel@jms.id.au,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Aspeed SOCs have two SD/MMC controllers. Add a device that
encapsulates both of these controllers and models the Aspeed-specific
registers and behavior.

Tested by reading from mmcblk0 in Linux:
qemu-system-arm -machine romulus-bmc -nographic \
 -drive file=flash-romulus,format=raw,if=mtd \
 -device sd-card,drive=sd0 -drive file=_tmp/kernel,format=raw,if=sd

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
This patch applies on top of Cedric's set of recent Aspeed changes.
Therefore, I'm sending as an RFC rather than a patch for review.

Changes since v2:
 - Do the memory mapping at the SOC level
 - Add guest errors for out-of-bounds access to the SDHCI regs
 - Remove unnecessary blockdev include in aspeed_soc.c
 - Better naming for SDHCI objects.

Changes since v1:
 - Move slot realize code into the Aspeed SDHCI realize function
 - Fix interrupt handling by creating input irqs and connecting them to the
   slot irqs.
 - Removed card device creation code
 hw/arm/aspeed.c              |   1 -
 hw/arm/aspeed_soc.c          |  28 +++++++
 hw/sd/Makefile.objs          |   1 +
 hw/sd/aspeed_sdhci.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/aspeed_soc.h  |   3 +
 include/hw/sd/aspeed_sdhci.h |  34 ++++++++
 6 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 hw/sd/aspeed_sdhci.c
 create mode 100644 include/hw/sd/aspeed_sdhci.h

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2574425..aeed5b6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -480,7 +480,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = board->desc;
     mc->init = aspeed_machine_init;
     mc->max_cpus = ASPEED_CPUS_NUM;
-    mc->no_sdcard = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index c9f6e01..292751e 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -62,6 +62,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
+    [ASPEED_SDHCI]  = 0x1E740000,
     [ASPEED_GPIO]   = 0x1E780000,
     [ASPEED_RTC]    = 0x1E781000,
     [ASPEED_TIMER1] = 0x1E782000,
@@ -102,6 +103,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_XDMA]      = 0x1E6E7000,
     [ASPEED_ADC]       = 0x1E6E9000,
     [ASPEED_VIDEO]     = 0x1E700000,
+    [ASPEED_SDHCI]     = 0x1E740000,
     [ASPEED_GPIO]      = 0x1E780000,
     [ASPEED_GPIO_1_8V] = 0x1E780800,
     [ASPEED_RTC]       = 0x1E781000,
@@ -147,6 +149,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_ETH1]   = 2,
     [ASPEED_ETH2]   = 3,
     [ASPEED_XDMA]   = 6,
+    [ASPEED_SDHCI]  = 26,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -185,6 +188,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_ETH2]      = 3,
     [ASPEED_FSI1]      = 100,
     [ASPEED_FSI2]      = 101,
+    [ASPEED_SDHCI]     = 43,
 };
 
 static const AspeedSoCInfo aspeed_socs[] = {
@@ -357,6 +361,15 @@ static void aspeed_soc_init(Object *obj)
         sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
                               sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
     }
+
+    sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci),
+                          TYPE_ASPEED_SDHCI);
+
+    /* Init sd card slot class here so that they're under the correct parent */
+    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
+                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
+    }
 }
 
 /*
@@ -698,6 +711,21 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
                            aspeed_soc_get_irq(s, ASPEED_FSI1));
     }
+
+    /* SDHCI */
+    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci.slots[i]), 0,
+                        sc->info->memmap[ASPEED_SDHCI] + ((i + 1) * 0x100));
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
+                    sc->info->memmap[ASPEED_SDHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
+                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index 0665727..a884c23 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -8,3 +8,4 @@ obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
 obj-$(CONFIG_OMAP) += omap_mmc.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
 obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
+obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
new file mode 100644
index 0000000..6e99a9d
--- /dev/null
+++ b/hw/sd/aspeed_sdhci.c
@@ -0,0 +1,194 @@
+/*
+ * Aspeed SD Host Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/sd/aspeed_sdhci.h"
+#include "qapi/error.h"
+
+#define ASPEED_SDHCI_INFO            0x00
+#define  ASPEED_SDHCI_INFO_RESET     0x00030000
+#define ASPEED_SDHCI_DEBOUNCE        0x04
+#define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
+#define ASPEED_SDHCI_BUS             0x08
+#define ASPEED_SDHCI_SDIO_140        0x10
+#define ASPEED_SDHCI_SDIO_148        0x18
+#define ASPEED_SDHCI_SDIO_240        0x20
+#define ASPEED_SDHCI_SDIO_248        0x28
+#define ASPEED_SDHCI_WP_POL          0xec
+#define ASPEED_SDHCI_CARD_DET        0xf0
+#define ASPEED_SDHCI_IRQ_STAT        0xfc
+
+#define TO_REG(addr) ((addr) / sizeof(uint32_t))
+
+static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint32_t val = 0;
+    AspeedSDHCIState *sdhci = opaque;
+
+    switch (addr) {
+    case ASPEED_SDHCI_SDIO_140:
+        val = (uint32_t)sdhci->slots[0].capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        val = (uint32_t)sdhci->slots[0].maxcurr;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        val = (uint32_t)sdhci->slots[1].capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        val = (uint32_t)sdhci->slots[1].maxcurr;
+        break;
+    default:
+        if (addr < ASPEED_SDHCI_REG_SIZE) {
+            val = sdhci->regs[TO_REG(addr)];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    }
+
+    return (uint64_t)val;
+}
+
+static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned int size)
+{
+    AspeedSDHCIState *sdhci = opaque;
+
+    switch (addr) {
+    case ASPEED_SDHCI_SDIO_140:
+        sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        sdhci->slots[0].maxcurr = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        sdhci->slots[1].capareg = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        sdhci->slots[1].maxcurr = (uint64_t)(uint32_t)val;
+        break;
+    default:
+        if (addr < ASPEED_SDHCI_REG_SIZE) {
+            sdhci->regs[TO_REG(addr)] = (uint32_t)val;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    }
+}
+
+static const MemoryRegionOps aspeed_sdhci_ops = {
+    .read = aspeed_sdhci_read,
+    .write = aspeed_sdhci_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
+{
+    AspeedSDHCIState *sdhci = opaque;
+
+    if (level) {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] |= BIT(n);
+
+        qemu_irq_raise(sdhci->irq);
+    } else {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] &= ~BIT(n);
+
+        qemu_irq_lower(sdhci->irq);
+    }
+}
+
+static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    Error *err = NULL;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
+
+    /* Create input irqs for the slots */
+    qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_irq,
+                                        sdhci, NULL, ASPEED_SDHCI_NUM_SLOTS);
+
+    for (int i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
+        SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
+
+        object_property_set_int(sdhci_slot, 2, "sd-spec-version", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_uint(sdhci_slot, ASPEED_SDHCI_CAPABILITIES,
+                                 "capareg", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_bool(sdhci_slot, true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_connect_irq(sbd_slot, 0, qdev_get_gpio_in(DEVICE(sbd), i));
+    }
+
+    sysbus_init_irq(sbd, &sdhci->irq);
+    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
+                          sdhci, TYPE_ASPEED_SDHCI, ASPEED_SDHCI_REG_SIZE);
+    sysbus_init_mmio(sbd, &sdhci->iomem);
+}
+
+static void aspeed_sdhci_reset(DeviceState *dev)
+{
+    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
+
+    memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
+    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_RESET;
+    sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] = ASPEED_SDHCI_DEBOUNCE_RESET;
+}
+
+static const VMStateDescription vmstate_aspeed_sdhci = {
+    .name = TYPE_ASPEED_SDHCI,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedSDHCIState, ASPEED_SDHCI_NUM_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(classp);
+
+    dc->realize = aspeed_sdhci_realize;
+    dc->reset = aspeed_sdhci_reset;
+    dc->vmsd = &vmstate_aspeed_sdhci;
+}
+
+static TypeInfo aspeed_sdhci_info = {
+    .name          = TYPE_ASPEED_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedSDHCIState),
+    .class_init    = aspeed_sdhci_class_init,
+};
+
+static void aspeed_sdhci_register_types(void)
+{
+    type_register_static(&aspeed_sdhci_info);
+}
+
+type_init(aspeed_sdhci_register_types)
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 3f6c6c5..60e0fb2 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -29,6 +29,7 @@
 #include "hw/misc/aspeed_pwm.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/aspeed_fsi.h"
+#include "hw/sd/aspeed_sdhci.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  4
@@ -63,6 +64,7 @@ typedef struct AspeedSoCState {
     AspeedPWMState pwm;
     AspeedLPCState lpc;
     AspeedFsiState fsi[2];
+    AspeedSDHCIState sdhci;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -108,6 +110,7 @@ enum {
     ASPEED_ADC,
     ASPEED_VIDEO,
     ASPEED_SRAM,
+    ASPEED_SDHCI,
     ASPEED_GPIO,
     ASPEED_GPIO_1_8V,
     ASPEED_RTC,
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
new file mode 100644
index 0000000..dfdab43
--- /dev/null
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -0,0 +1,34 @@
+/*
+ * Aspeed SD Host Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_SDHCI_H
+#define ASPEED_SDHCI_H
+
+#include "hw/sd/sdhci.h"
+
+#define TYPE_ASPEED_SDHCI "aspeed.sdhci"
+#define ASPEED_SDHCI(obj) OBJECT_CHECK(AspeedSDHCIState, (obj), \
+                                       TYPE_ASPEED_SDHCI)
+
+#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
+#define ASPEED_SDHCI_NUM_SLOTS    2
+#define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint32_t))
+#define ASPEED_SDHCI_REG_SIZE     0x100
+
+typedef struct AspeedSDHCIState {
+    SysBusDevice parent;
+
+    SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[ASPEED_SDHCI_NUM_REGS];
+} AspeedSDHCIState;
+
+#endif /* ASPEED_SDHCI_H */
-- 
1.8.3.1


