Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CCC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0194A20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0194A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCvb-0007gU-6g
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eajames@linux.ibm.com>) id 1hgCtQ-00060E-QD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.ibm.com>) id 1hgCtO-0005Dh-Iw
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:43:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9860
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
 id 1hgCtO-00058I-C0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:43:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5QIfr2r045635
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 14:43:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tcddrt9c8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 14:43:32 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <eajames@linux.ibm.com>;
 Wed, 26 Jun 2019 19:43:31 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Jun 2019 19:43:28 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5QIhSln13173406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 18:43:28 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E449F28058;
 Wed, 26 Jun 2019 18:43:27 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3843C2805A;
 Wed, 26 Jun 2019 18:43:27 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2019 18:43:27 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: qemu-arm@nongnu.org
Date: Wed, 26 Jun 2019 13:43:24 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19062618-2213-0000-0000-000003A56092
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011336; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223650; UDB=6.00643968; IPR=6.01004829; 
 MB=3.00027479; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-26 18:43:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062618-2214-0000-0000-00005F01B89F
Message-Id: <1561574604-1204-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-26_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260216
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] hw/sd/aspeed_sdhci: New device
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
 Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org,
 philmd@redhat.com, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Aspeed SOCs have two SD/MMC controllers. Add a device that
encapsulates both of these controllers and models the Aspeed-specific
registers and behavior.

Both controllers use a single HW interrupt. In order to trigger that
interrupt, a function pointer was added to the generic SDHCI structure.
This function (if the pointer is set) is called when the SDHCI model
changes it's interrupt status, allowing the user (the Aspeed SDHCI
model in this case) to set it's own interrupt.

This goes on top of Cedric's set of Aspeed changes.

Tested, booted, and read from /dev/mmcblk0 and /dev/mmcblk1:
./arm-softmmu/qemu-system-arm -M ast2500-evb -nographic \
 -drive file=flash-romulus,format=raw,if=mtd \
 -drive file=<some file>,format=raw,if=sd \
 -drive file=<some file>,format=raw,if=sd \
 -kernel zImage \
 -dtb aspeed-ast2500-evb.dtb \
 -initrd romulus.cpio.lzma \
 -d trace:sdhci* -no-reboot

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 hw/arm/aspeed.c              |   1 -
 hw/arm/aspeed_soc.c          |  67 ++++++++++++++++++
 hw/sd/Makefile.objs          |   1 +
 hw/sd/aspeed_sdhci.c         | 163 +++++++++++++++++++++++++++++++++++++++++++
 hw/sd/sdhci.c                |   8 ++-
 include/hw/arm/aspeed_soc.h  |   3 +
 include/hw/sd/aspeed_sdhci.h |  39 +++++++++++
 include/hw/sd/sdhci.h        |   1 +
 8 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 hw/sd/aspeed_sdhci.c
 create mode 100644 include/hw/sd/aspeed_sdhci.h

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 5fee2f5..fbec946 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -422,7 +422,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = board->desc;
     mc->init = aspeed_machine_init;
     mc->max_cpus = ASPEED_CPUS_NUM;
-    mc->no_sdcard = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 1bbbdae..1378498 100644
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
@@ -142,6 +144,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_ETH1]   = 2,
     [ASPEED_ETH2]   = 3,
     [ASPEED_XDMA]   = 6,
+    [ASPEED_SDHCI]  = 26,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -378,6 +381,16 @@ static void aspeed_soc_init(Object *obj)
         sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
                               sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
     }
+
+    sysbus_init_child_obj(obj, "sdhci", OBJECT(&s->sdhci), sizeof(s->sdhci),
+                          TYPE_ASPEED_SDHCI);
+
+    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        sysbus_init_child_obj(obj, "sdhci_slot[*]",
+                              OBJECT(&s->sdhci.slots[i].sdhci),
+                              sizeof(s->sdhci.slots[i].sdhci),
+                              TYPE_SYSBUS_SDHCI);
+    }
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -699,6 +712,60 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
                            aspeed_soc_get_irq(s, ASPEED_FSI1));
     }
+
+    /* SD/SDIO */
+    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; i++) {
+        hwaddr hci_addr = sc->info->memmap[ASPEED_SDHCI] + (0x100 * (i + 1));
+        DriveInfo *di;
+        BlockBackend *blk;
+        DeviceState *card;
+
+        /*
+         * Compatible with:
+         * - SD Host Controller Specification Version 2.0
+         * - SDIO Specification Version 2.0
+         * - MMC Specification Version 4.3
+         */
+        object_property_set_int(OBJECT(&s->sdhci.slots[i].sdhci), 2,
+                                "sd-spec-version", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_uint(OBJECT(&s->sdhci.slots[i].sdhci),
+                                 ASPEED_SDHCI_CAPABILITIES, "capareg", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_bool(OBJECT(&s->sdhci.slots[i].sdhci), true,
+                                 "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci.slots[i].sdhci), 0, hci_addr);
+
+        di = drive_get_next(IF_SD);
+        blk = di ? blk_by_legacy_dinfo(di) : NULL;
+        card = qdev_create(qdev_get_child_bus(DEVICE(&s->sdhci.slots[i].sdhci),
+                                              "sd-bus"), TYPE_SD_CARD);
+        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+    }
+
+    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
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
index 0000000..f684b12
--- /dev/null
+++ b/hw/sd/aspeed_sdhci.c
@@ -0,0 +1,163 @@
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
+        val = (uint32_t)sdhci->slots[0].sdhci.capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        val = (uint32_t)sdhci->slots[0].sdhci.maxcurr;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        val = (uint32_t)sdhci->slots[1].sdhci.capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        val = (uint32_t)sdhci->slots[1].sdhci.maxcurr;
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
+        sdhci->slots[0].sdhci.capareg = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        sdhci->slots[0].sdhci.maxcurr = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        sdhci->slots[1].sdhci.capareg = (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        sdhci->slots[1].sdhci.maxcurr = (uint64_t)(uint32_t)val;
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
+static void aspeed_sdhci_irq_notify(SDHCIState *s, int level)
+{
+    AspeedSDHCISlotState *as = container_of(s, AspeedSDHCISlotState, sdhci);
+    AspeedSDHCIState *sdhci = container_of(as, AspeedSDHCIState,
+                                           slots[as->slot]);
+
+    if (level) {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] |= BIT(as->slot);
+
+        qemu_irq_raise(sdhci->irq);
+    } else {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] &= ~BIT(as->slot);
+
+        qemu_irq_lower(sdhci->irq);
+    }
+}
+
+static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
+
+    sysbus_init_irq(sbd, &sdhci->irq);
+    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
+                          sdhci, TYPE_ASPEED_SDHCI, ASPEED_SDHCI_REG_SIZE);
+    sysbus_init_mmio(sbd, &sdhci->iomem);
+
+    sdhci->slots[0].slot = 0;
+    sdhci->slots[0].sdhci.irq_notify = aspeed_sdhci_irq_notify;
+
+    sdhci->slots[1].slot = 1;
+    sdhci->slots[1].sdhci.irq_notify = aspeed_sdhci_irq_notify;
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
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 7b80b1d..51a733b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -213,7 +213,13 @@ static uint8_t sdhci_slotint(SDHCIState *s)
 
 static inline void sdhci_update_irq(SDHCIState *s)
 {
-    qemu_set_irq(s->irq, sdhci_slotint(s));
+    int level = sdhci_slotint(s);
+
+    qemu_set_irq(s->irq, level);
+
+    if (s->irq_notify) {
+        s->irq_notify(s, level);
+    }
 }
 
 static void sdhci_raise_insertion_irq(void *opaque)
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 7abb394..ba0f72f 100644
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
@@ -108,6 +110,7 @@ enum {
     ASPEED_SCU,
     ASPEED_ADC,
     ASPEED_SRAM,
+    ASPEED_SDHCI,
     ASPEED_GPIO,
     ASPEED_RTC,
     ASPEED_TIMER1,
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
new file mode 100644
index 0000000..67fb7ef
--- /dev/null
+++ b/include/hw/sd/aspeed_sdhci.h
@@ -0,0 +1,39 @@
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
+typedef struct AspeedSDHCISlotState {
+    SDHCIState sdhci;
+    int slot;
+} AspeedSDHCISlotState;
+
+typedef struct AspeedSDHCIState {
+    SysBusDevice parent;
+
+    AspeedSDHCISlotState slots[ASPEED_SDHCI_NUM_SLOTS];
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[ASPEED_SDHCI_NUM_REGS];
+} AspeedSDHCIState;
+
+#endif /* ASPEED_SDHCI_H */
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index cbf415e..90dbf7b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -48,6 +48,7 @@ typedef struct SDHCIState {
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
     qemu_irq irq;
+    void (*irq_notify)(struct SDHCIState *s, int level);
 
     /* Registers cleared on reset */
     uint32_t sdmasysad;    /* SDMA System Address register */
-- 
1.8.3.1


