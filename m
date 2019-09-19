Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8027DC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 05:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49AFB218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 05:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AFB218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iApN9-0002Xb-1V
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 01:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iApKq-0000Ve-5f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iApKo-0007af-4b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:50:32 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:49435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iApKn-0007ZC-TG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:50:30 -0400
Received: from player788.ha.ovh.net (unknown [10.109.143.72])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 4FB5D69D55
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:50:28 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 7C1199F172E4;
 Thu, 19 Sep 2019 05:50:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 07:49:43 +0200
Message-Id: <20190919055002.6729-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919055002.6729-1-clg@kaod.org>
References: <20190919055002.6729-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1667457765884791569
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.203
Subject: [Qemu-devel] [PATCH 02/21] hw/sd/aspeed_sdhci: New device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eddie James <eajames@linux.ibm.com>

The Aspeed SOCs have two SD/MMC controllers. Add a device that
encapsulates both of these controllers and models the Aspeed-specific
registers and behavior.

Tested by reading from mmcblk0 in Linux:
qemu-system-arm -machine romulus-bmc -nographic \
 -drive file=3Dflash-romulus,format=3Draw,if=3Dmtd \
 -device sd-card,drive=3Dsd0 -drive file=3D_tmp/kernel,format=3Draw,if=3D=
sd,id=3Dsd0

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
[clg: - changed the controller MMIO window size to 0x1000
      - moved the MMIO mapping of the SDHCI slots at the SoC level
      - merged code to add SD drives on the SD buses at the machine level=
 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h  |   3 +
 include/hw/sd/aspeed_sdhci.h |  34 ++++++
 hw/arm/aspeed.c              |  15 ++-
 hw/arm/aspeed_soc.c          |  23 ++++
 hw/sd/aspeed_sdhci.c         | 198 +++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs          |   1 +
 6 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/sd/aspeed_sdhci.h
 create mode 100644 hw/sd/aspeed_sdhci.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index ab5052b12cb5..ba5bbb53e1a1 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -24,6 +24,7 @@
 #include "hw/net/ftgmac100.h"
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/sd/aspeed_sdhci.h"
=20
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
@@ -50,6 +51,7 @@ typedef struct AspeedSoCState {
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
+    AspeedSDHCIState sdhci;
 } AspeedSoCState;
=20
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -93,6 +95,7 @@ enum {
     ASPEED_SCU,
     ASPEED_ADC,
     ASPEED_SRAM,
+    ASPEED_SDHCI,
     ASPEED_GPIO,
     ASPEED_RTC,
     ASPEED_TIMER1,
diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
new file mode 100644
index 000000000000..dfdab4379021
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
+#define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint32=
_t))
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
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index aa72be309da4..30e280484262 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -170,6 +170,7 @@ static void aspeed_board_init(MachineState *machine,
     AspeedSoCClass *sc;
     DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
     ram_addr_t max_ram_size;
+    int i;
=20
     bmc =3D g_new0(AspeedBoardState, 1);
=20
@@ -252,6 +253,19 @@ static void aspeed_board_init(MachineState *machine,
         cfg->i2c_init(bmc);
     }
=20
+    for (i =3D 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
+        SDHCIState *sdhci =3D &bmc->soc.sdhci.slots[i];
+        DriveInfo *dinfo =3D drive_get_next(IF_SD);
+        BlockBackend *blk;
+        DeviceState *card;
+
+        blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+        card =3D qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus")=
,
+                           TYPE_SD_CARD);
+        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(card), true, "realized", &error_=
fatal);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
=20
@@ -373,7 +387,6 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
     mc->desc =3D board->desc;
     mc->init =3D aspeed_machine_init;
     mc->max_cpus =3D ASPEED_CPUS_NUM;
-    mc->no_sdcard =3D 1;
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index cf1d0cf921ba..c3821a562733 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -36,6 +36,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
     [ASPEED_XDMA]   =3D 0x1E6E7000,
     [ASPEED_ADC]    =3D 0x1E6E9000,
     [ASPEED_SRAM]   =3D 0x1E720000,
+    [ASPEED_SDHCI]  =3D 0x1E740000,
     [ASPEED_GPIO]   =3D 0x1E780000,
     [ASPEED_RTC]    =3D 0x1E781000,
     [ASPEED_TIMER1] =3D 0x1E782000,
@@ -63,6 +64,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
     [ASPEED_XDMA]   =3D 0x1E6E7000,
     [ASPEED_ADC]    =3D 0x1E6E9000,
     [ASPEED_SRAM]   =3D 0x1E720000,
+    [ASPEED_SDHCI]  =3D 0x1E740000,
     [ASPEED_GPIO]   =3D 0x1E780000,
     [ASPEED_RTC]    =3D 0x1E781000,
     [ASPEED_TIMER1] =3D 0x1E782000,
@@ -108,6 +110,7 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
     [ASPEED_ETH1]   =3D 2,
     [ASPEED_ETH2]   =3D 3,
     [ASPEED_XDMA]   =3D 6,
+    [ASPEED_SDHCI]  =3D 26,
 };
=20
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -230,6 +233,15 @@ static void aspeed_soc_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio)=
,
                           typename);
+
+    sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci=
),
+                          TYPE_ASPEED_SDHCI);
+
+    /* Init sd card slot class here so that they're under the correct pa=
rent */
+    for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]=
),
+                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDH=
CI);
+    }
 }
=20
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -419,6 +431,17 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info->memmap[ASPEED=
_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
+
+    /* SDHCI */
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
 static Property aspeed_soc_properties[] =3D {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
new file mode 100644
index 000000000000..cff3eb7dd21e
--- /dev/null
+++ b/hw/sd/aspeed_sdhci.c
@@ -0,0 +1,198 @@
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
+#include "hw/irq.h"
+#include "migration/vmstate.h"
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
+static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned in=
t size)
+{
+    uint32_t val =3D 0;
+    AspeedSDHCIState *sdhci =3D opaque;
+
+    switch (addr) {
+    case ASPEED_SDHCI_SDIO_140:
+        val =3D (uint32_t)sdhci->slots[0].capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        val =3D (uint32_t)sdhci->slots[0].maxcurr;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        val =3D (uint32_t)sdhci->slots[1].capareg;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        val =3D (uint32_t)sdhci->slots[1].maxcurr;
+        break;
+    default:
+        if (addr < ASPEED_SDHCI_REG_SIZE) {
+            val =3D sdhci->regs[TO_REG(addr)];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\=
n",
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
+    AspeedSDHCIState *sdhci =3D opaque;
+
+    switch (addr) {
+    case ASPEED_SDHCI_SDIO_140:
+        sdhci->slots[0].capareg =3D (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_148:
+        sdhci->slots[0].maxcurr =3D (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_240:
+        sdhci->slots[1].capareg =3D (uint64_t)(uint32_t)val;
+        break;
+    case ASPEED_SDHCI_SDIO_248:
+        sdhci->slots[1].maxcurr =3D (uint64_t)(uint32_t)val;
+        break;
+    default:
+        if (addr < ASPEED_SDHCI_REG_SIZE) {
+            sdhci->regs[TO_REG(addr)] =3D (uint32_t)val;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "=
\n",
+                          __func__, addr);
+        }
+    }
+}
+
+static const MemoryRegionOps aspeed_sdhci_ops =3D {
+    .read =3D aspeed_sdhci_read,
+    .write =3D aspeed_sdhci_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+};
+
+static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
+{
+    AspeedSDHCIState *sdhci =3D opaque;
+
+    if (level) {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] |=3D BIT(n);
+
+        qemu_irq_raise(sdhci->irq);
+    } else {
+        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] &=3D ~BIT(n);
+
+        qemu_irq_lower(sdhci->irq);
+    }
+}
+
+static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    Error *err =3D NULL;
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
+
+    /* Create input irqs for the slots */
+    qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_ir=
q,
+                                        sdhci, NULL, ASPEED_SDHCI_NUM_SL=
OTS);
+
+    sysbus_init_irq(sbd, &sdhci->irq);
+    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_op=
s,
+                          sdhci, TYPE_ASPEED_SDHCI, 0x1000);
+    sysbus_init_mmio(sbd, &sdhci->iomem);
+
+    for (int i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
+        Object *sdhci_slot =3D OBJECT(&sdhci->slots[i]);
+        SysBusDevice *sbd_slot =3D SYS_BUS_DEVICE(&sdhci->slots[i]);
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
+        sysbus_connect_irq(sbd_slot, 0, qdev_get_gpio_in(DEVICE(sbd), i)=
);
+        memory_region_add_subregion(&sdhci->iomem, (i + 1) * 0x100,
+                                    &sdhci->slots[i].iomem);
+    }
+}
+
+static void aspeed_sdhci_reset(DeviceState *dev)
+{
+    AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
+
+    memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
+    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED_SDHCI_INFO_RESET;
+    sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] =3D ASPEED_SDHCI_DEBOUNCE=
_RESET;
+}
+
+static const VMStateDescription vmstate_aspeed_sdhci =3D {
+    .name =3D TYPE_ASPEED_SDHCI,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedSDHCIState, ASPEED_SDHCI_NUM_RE=
GS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(classp);
+
+    dc->realize =3D aspeed_sdhci_realize;
+    dc->reset =3D aspeed_sdhci_reset;
+    dc->vmsd =3D &vmstate_aspeed_sdhci;
+}
+
+static TypeInfo aspeed_sdhci_info =3D {
+    .name          =3D TYPE_ASPEED_SDHCI,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(AspeedSDHCIState),
+    .class_init    =3D aspeed_sdhci_class_init,
+};
+
+static void aspeed_sdhci_register_types(void)
+{
+    type_register_static(&aspeed_sdhci_info);
+}
+
+type_init(aspeed_sdhci_register_types)
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index 06657279d183..a884c238dfb3 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -8,3 +8,4 @@ obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
 obj-$(CONFIG_OMAP) +=3D omap_mmc.o
 obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
 obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o
+obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_sdhci.o
--=20
2.21.0


