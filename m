Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47289C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2C22083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2C22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy02I-0003Cw-86
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eajames@linux.ibm.com>) id 1hxzs7-0000qL-3v
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.ibm.com>) id 1hxzs4-0007FX-L4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:27:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
 id 1hxzs4-0007EC-29
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:27:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7EKRC9C037566
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 16:27:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ucp1hyaqy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 16:27:44 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <eajames@linux.ibm.com>;
 Wed, 14 Aug 2019 21:27:44 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 14 Aug 2019 21:27:39 +0100
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7EKRd2n41287950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2019 20:27:39 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDED76A04F;
 Wed, 14 Aug 2019 20:27:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 666AA6A047;
 Wed, 14 Aug 2019 20:27:38 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 14 Aug 2019 20:27:38 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 15:27:36 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19081420-0036-0000-0000-00000AE4EA4E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011590; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246845; UDB=6.00658004; IPR=6.01028352; 
 MB=3.00028175; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-14 20:27:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081420-0037-0000-0000-00004D02F95A
Message-Id: <1565814456-1264-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-14_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140186
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [RFC v2] hw/sd/aspeed_sdhci: New device
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
qemu-system-arm -machine romulus-bmc -nographic -serial mon:stdio \
 -drive file=_tmp/flash-romulus,format=raw,if=mtd \
 -device sd-card,drive=sd0 -drive file=_tmp/kernel,format=raw,if=sd

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
This patch applies on top of Cedric's set of recent Aspeed changes. Therefore,
I'm sending as an RFC rather than a patch.

Changes since v1:
 - Move slot realize code into the Aspeed SDHCI realize function
 - Fix interrupt handling by creating input irqs and connecting them to the
   slot irqs.
 - Removed card device creation code

 hw/arm/aspeed.c              |   1 -
 hw/arm/aspeed_soc.c          |  24 ++++++
 hw/sd/Makefile.objs          |   1 +
 hw/sd/aspeed_sdhci.c         | 190 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/aspeed_soc.h  |   3 +
 include/hw/sd/aspeed_sdhci.h |  35 ++++++++
 6 files changed, 253 insertions(+), 1 deletion(-)
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
index 8df96f2..a12f14a 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
+#include "sysemu/blockdev.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 
@@ -62,6 +63,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
+    [ASPEED_SDHCI]  = 0x1E740000,
     [ASPEED_GPIO]   = 0x1E780000,
     [ASPEED_RTC]    = 0x1E781000,
     [ASPEED_TIMER1] = 0x1E782000,
@@ -100,6 +102,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_VIDEO]  = 0x1E700000,
+    [ASPEED_SDHCI]  = 0x1E740000,
     [ASPEED_GPIO]   = 0x1E780000,
     [ASPEED_RTC]    = 0x1E781000,
     [ASPEED_TIMER1] = 0x1E782000,
@@ -146,6 +149,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_ETH1]   = 2,
     [ASPEED_ETH2]   = 3,
     [ASPEED_XDMA]   = 6,
+    [ASPEED_SDHCI]  = 26,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -163,6 +167,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_SDMC]   = 0,
     [ASPEED_SCU]    = 12,
     [ASPEED_XDMA]   = 6,
+    [ASPEED_SDHCI]  = 43,
     [ASPEED_ADC]    = 46,
     [ASPEED_GPIO]   = 40,
     [ASPEED_RTC]    = 13,
@@ -350,6 +355,15 @@ static void aspeed_soc_init(Object *obj)
         sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
                               sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
     }
+
+    sysbus_init_child_obj(obj, "sdhci", OBJECT(&s->sdhci), sizeof(s->sdhci),
+                          TYPE_ASPEED_SDHCI);
+
+    /* Init sd card slot class here so that they're under the correct parent */
+    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        sysbus_init_child_obj(obj, "sdhci_slot[*]", OBJECT(&s->sdhci.slots[i]),
+                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
+    }
 }
 
 /*
@@ -680,6 +694,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
                            aspeed_soc_get_irq(s, ASPEED_FSI1));
     }
+
+    /* SD/SDIO - set the reg address so slot memory mapping can be set up */
+    s->sdhci.ioaddr = sc->info->memmap[ASPEED_SDHCI];
+    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
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
index 0000000..d1a05e9
--- /dev/null
+++ b/hw/sd/aspeed_sdhci.c
@@ -0,0 +1,190 @@
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
+        hwaddr slot_addr = sdhci->ioaddr + (0x100 * (i + 1));
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
+        sysbus_mmio_map(sbd_slot, 0, slot_addr);
+
+        sysbus_connect_irq(sbd_slot, 0, qdev_get_gpio_in(DEVICE(sbd), i));
+    }
+
+    sysbus_init_irq(sbd, &sdhci->irq);
+    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
+                          sdhci, TYPE_ASPEED_SDHCI, ASPEED_SDHCI_REG_SIZE);
+    sysbus_init_mmio(sbd, &sdhci->iomem);
+    sysbus_mmio_map(sbd, 0, sdhci->ioaddr);
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
index 429d7e7..3ddba3a 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -29,6 +29,7 @@
 #include "hw/misc/aspeed_pwm.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/aspeed_fsi.h"
+#include "hw/sd/aspeed_sdhci.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  4
@@ -62,6 +63,7 @@ typedef struct AspeedSoCState {
     AspeedPWMState pwm;
     AspeedLPCState lpc;
     AspeedFsiState fsi[2];
+    AspeedSDHCIState sdhci;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -107,6 +109,7 @@ enum {
     ASPEED_ADC,
     ASPEED_VIDEO,
     ASPEED_SRAM,
+    ASPEED_SDHCI,
     ASPEED_GPIO,
     ASPEED_RTC,
     ASPEED_TIMER1,
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
new file mode 100644
index 0000000..ac5482f
--- /dev/null
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -0,0 +1,35 @@
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
+    hwaddr ioaddr;
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[ASPEED_SDHCI_NUM_REGS];
+} AspeedSDHCIState;
+
+#endif /* ASPEED_SDHCI_H */
-- 
1.8.3.1


