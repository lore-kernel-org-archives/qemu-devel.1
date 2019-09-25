Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB40C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5ECF21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ECF21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8n2-0007kd-ND
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD8Nt-00054Q-Hz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD8Np-0001aZ-Ll
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:13 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:54552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD8Np-0001Yc-BA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:35:09 -0400
Received: from player786.ha.ovh.net (unknown [10.108.57.178])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id A3A9B10B8F6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:35:07 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 18FA9A4D41C9;
 Wed, 25 Sep 2019 14:35:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 18/23] aspeed/soc: Add AST2600 support
Date: Wed, 25 Sep 2019 16:32:43 +0200
Message-Id: <20190925143248.10000-19-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
References: <20190925143248.10000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8870683891158780689
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.149
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initial definitions for a simple machine using an AST2600 SoC (Cortex
CPU).

The Cortex CPU and its interrupt controller are too complex to handle
in the common Aspeed SoC framework. We introduce a new Aspeed SoC
class with instance_init and realize handlers to handle the differences
with the AST2400 and the AST2500 SoCs. This will add extra work to
keep in sync both models with future extensions but it makes the code
clearer.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/arm/aspeed_soc.h |   4 +
 hw/arm/aspeed_ast2600.c     | 492 ++++++++++++++++++++++++++++++++++++
 hw/arm/Makefile.objs        |   2 +-
 3 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/aspeed_ast2600.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 667dfec0f7b6..67c59956f835 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -12,6 +12,7 @@
 #ifndef ASPEED_SOC_H
 #define ASPEED_SOC_H
=20
+#include "hw/cpu/a15mpcore.h"
 #include "hw/intc/aspeed_vic.h"
 #include "hw/misc/aspeed_scu.h"
 #include "hw/misc/aspeed_sdmc.h"
@@ -38,6 +39,7 @@ typedef struct AspeedSoCState {
     /*< public >*/
     ARMCPU cpu[ASPEED_CPUS_NUM];
     uint32_t num_cpus;
+    A15MPPrivState     a7mpcore;
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedRtcState rtc;
@@ -51,6 +53,7 @@ typedef struct AspeedSoCState {
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
     AspeedGPIOState gpio;
+    AspeedGPIOState gpio_1_8v;
     AspeedSDHCIState sdhci;
 } AspeedSoCState;
=20
@@ -94,6 +97,7 @@ enum {
     ASPEED_SRAM,
     ASPEED_SDHCI,
     ASPEED_GPIO,
+    ASPEED_GPIO_1_8V,
     ASPEED_RTC,
     ASPEED_TIMER1,
     ASPEED_TIMER2,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
new file mode 100644
index 000000000000..a4f0fafab7cb
--- /dev/null
+++ b/hw/arm/aspeed_ast2600.c
@@ -0,0 +1,492 @@
+/*
+ * ASPEED SoC 2600 family
+ *
+ * Copyright (c) 2016-2019, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/char/serial.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/i2c/aspeed_i2c.h"
+#include "net/net.h"
+#include "sysemu/sysemu.h"
+
+#define ASPEED_SOC_IOMEM_SIZE       0x00200000
+
+static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
+    [ASPEED_SRAM]      =3D 0x10000000,
+    /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */
+    [ASPEED_IOMEM]     =3D 0x1E600000,
+    [ASPEED_PWM]       =3D 0x1E610000,
+    [ASPEED_FMC]       =3D 0x1E620000,
+    [ASPEED_SPI1]      =3D 0x1E630000,
+    [ASPEED_SPI2]      =3D 0x1E641000,
+    [ASPEED_ETH1]      =3D 0x1E660000,
+    [ASPEED_ETH2]      =3D 0x1E680000,
+    [ASPEED_VIC]       =3D 0x1E6C0000,
+    [ASPEED_SDMC]      =3D 0x1E6E0000,
+    [ASPEED_SCU]       =3D 0x1E6E2000,
+    [ASPEED_XDMA]      =3D 0x1E6E7000,
+    [ASPEED_ADC]       =3D 0x1E6E9000,
+    [ASPEED_SDHCI]     =3D 0x1E740000,
+    [ASPEED_GPIO]      =3D 0x1E780000,
+    [ASPEED_GPIO_1_8V] =3D 0x1E780800,
+    [ASPEED_RTC]       =3D 0x1E781000,
+    [ASPEED_TIMER1]    =3D 0x1E782000,
+    [ASPEED_WDT]       =3D 0x1E785000,
+    [ASPEED_LPC]       =3D 0x1E789000,
+    [ASPEED_IBT]       =3D 0x1E789140,
+    [ASPEED_I2C]       =3D 0x1E78A000,
+    [ASPEED_UART1]     =3D 0x1E783000,
+    [ASPEED_UART5]     =3D 0x1E784000,
+    [ASPEED_VUART]     =3D 0x1E787000,
+    [ASPEED_SDRAM]     =3D 0x80000000,
+};
+
+#define ASPEED_A7MPCORE_ADDR 0x40460000
+
+#define ASPEED_SOC_AST2600_MAX_IRQ 128
+
+static const int aspeed_soc_ast2600_irqmap[] =3D {
+    [ASPEED_UART1]     =3D 47,
+    [ASPEED_UART2]     =3D 48,
+    [ASPEED_UART3]     =3D 49,
+    [ASPEED_UART4]     =3D 50,
+    [ASPEED_UART5]     =3D 8,
+    [ASPEED_VUART]     =3D 8,
+    [ASPEED_FMC]       =3D 39,
+    [ASPEED_SDMC]      =3D 0,
+    [ASPEED_SCU]       =3D 12,
+    [ASPEED_ADC]       =3D 78,
+    [ASPEED_XDMA]      =3D 6,
+    [ASPEED_SDHCI]     =3D 43,
+    [ASPEED_GPIO]      =3D 40,
+    [ASPEED_GPIO_1_8V] =3D 11,
+    [ASPEED_RTC]       =3D 13,
+    [ASPEED_TIMER1]    =3D 16,
+    [ASPEED_TIMER2]    =3D 17,
+    [ASPEED_TIMER3]    =3D 18,
+    [ASPEED_TIMER4]    =3D 19,
+    [ASPEED_TIMER5]    =3D 20,
+    [ASPEED_TIMER6]    =3D 21,
+    [ASPEED_TIMER7]    =3D 22,
+    [ASPEED_TIMER8]    =3D 23,
+    [ASPEED_WDT]       =3D 24,
+    [ASPEED_PWM]       =3D 44,
+    [ASPEED_LPC]       =3D 35,
+    [ASPEED_IBT]       =3D 35,    /* LPC */
+    [ASPEED_I2C]       =3D 110,   /* 110 -> 125 */
+    [ASPEED_ETH1]      =3D 2,
+    [ASPEED_ETH2]      =3D 3,
+};
+
+static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
+{
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
+
+    return qdev_get_gpio_in(DEVICE(&s->a7mpcore), sc->irqmap[ctrl]);
+}
+
+static void aspeed_soc_ast2600_init(Object *obj)
+{
+    AspeedSoCState *s =3D ASPEED_SOC(obj);
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
+    int i;
+    char socname[8];
+    char typename[64];
+
+    if (sscanf(sc->name, "%7s", socname) !=3D 1) {
+        g_assert_not_reached();
+    }
+
+    for (i =3D 0; i < sc->num_cpus; i++) {
+        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
+                                sizeof(s->cpu[i]), sc->cpu_type,
+                                &error_abort, NULL);
+    }
+
+    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
+    sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
+                          typename);
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
+                         sc->silicon_rev);
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
+                              "hw-strap1", &error_abort);
+    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
+                              "hw-strap2", &error_abort);
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
+                              "hw-prot-key", &error_abort);
+
+    sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore,
+                          sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
+
+    sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
+                          TYPE_ASPEED_RTC);
+
+    snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
+    sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
+                          sizeof(s->timerctrl), typename);
+    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
+                                   OBJECT(&s->scu), &error_abort);
+
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
+    sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
+                          typename);
+
+    snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
+    sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
+                          typename);
+    object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
+                              &error_abort);
+    object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
+                              &error_abort);
+
+    for (i =3D 0; i < sc->spis_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, s=
ocname);
+        sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
+                              sizeof(s->spi[i]), typename);
+    }
+
+    snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
+    sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc)=
,
+                          typename);
+    object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
+                              "ram-size", &error_abort);
+    object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
+                              "max-ram-size", &error_abort);
+
+    for (i =3D 0; i < sc->wdts_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
+        sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
+                              sizeof(s->wdt[i]), typename);
+        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
+                                       OBJECT(&s->scu), &error_abort);
+    }
+
+    for (i =3D 0; i < ASPEED_MACS_NUM; i++) {
+        sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[=
i]),
+                              sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
+    }
+
+    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma)=
,
+                          TYPE_ASPEED_XDMA);
+
+    snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
+    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio)=
,
+                          typename);
+
+    snprintf(typename, sizeof(typename), "aspeed.gpio-%s-1_8v", socname)=
;
+    sysbus_init_child_obj(obj, "gpio_1_8v", OBJECT(&s->gpio_1_8v),
+                          sizeof(s->gpio_1_8v), typename);
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
+}
+
+/*
+ * ASPEED ast2600 has 0xf as cluster ID
+ *
+ * http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.ddi0388=
e/CIHEBGFG.html
+ */
+static uint64_t aspeed_calc_affinity(int cpu)
+{
+    return (0xf << ARM_AFF1_SHIFT) | cpu;
+}
+
+static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
+{
+    int i;
+    AspeedSoCState *s =3D ASPEED_SOC(dev);
+    AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
+    Error *err =3D NULL, *local_err =3D NULL;
+    qemu_irq irq;
+
+    /* IO space */
+    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM=
],
+                                ASPEED_SOC_IOMEM_SIZE);
+
+    if (s->num_cpus > sc->num_cpus) {
+        warn_report("%s: invalid number of CPUs %d, using default %d",
+                    sc->name, s->num_cpus, sc->num_cpus);
+        s->num_cpus =3D sc->num_cpus;
+    }
+
+    /* CPU */
+    for (i =3D 0; i < s->num_cpus; i++) {
+        object_property_set_int(OBJECT(&s->cpu[i]), QEMU_PSCI_CONDUIT_SM=
C,
+                                "psci-conduit", &error_abort);
+        if (s->num_cpus > 1) {
+            object_property_set_int(OBJECT(&s->cpu[i]),
+                                    ASPEED_A7MPCORE_ADDR,
+                                    "reset-cbar", &error_abort);
+        }
+        object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinity=
(i),
+                                "mp-affinity", &error_abort);
+
+        /*
+         * TODO: the secondary CPUs are started and a boot helper
+         * is needed when using -kernel
+         */
+
+        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &=
err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    /* A7MPCORE */
+    object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu"=
,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore),
+                            ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
+                            "num-irq", &error_abort);
+
+    object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
+                             &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADD=
R);
+
+    for (i =3D 0; i < s->num_cpus; i++) {
+        SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->a7mpcore);
+        DeviceState  *d   =3D DEVICE(qemu_get_cpu(i));
+
+        irq =3D qdev_get_gpio_in(d, ARM_CPU_IRQ);
+        sysbus_connect_irq(sbd, i, irq);
+        irq =3D qdev_get_gpio_in(d, ARM_CPU_FIQ);
+        sysbus_connect_irq(sbd, i + s->num_cpus, irq);
+        irq =3D qdev_get_gpio_in(d, ARM_CPU_VIRQ);
+        sysbus_connect_irq(sbd, i + 2 * s->num_cpus, irq);
+        irq =3D qdev_get_gpio_in(d, ARM_CPU_VFIQ);
+        sysbus_connect_irq(sbd, i + 3 * s->num_cpus, irq);
+    }
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
+                           sc->sram_size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                sc->memmap[ASPEED_SRAM], &s->sram);
+
+    /* SCU */
+    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
+
+    /* RTC */
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+                       aspeed_soc_get_irq(s, ASPEED_RTC));
+
+    /* Timer */
+    object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &e=
rr);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
+                    sc->memmap[ASPEED_TIMER1]);
+    for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
+        qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
+    }
+
+    /* UART - attach an 8250 to the IO space as our UART5 */
+    if (serial_hd(0)) {
+        qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
+        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_UART5], 2,
+                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN)=
;
+    }
+
+    /* I2C */
+    object_property_set_bool(OBJECT(&s->i2c), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
+    for (i =3D 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
+        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                        sc->irqmap[ASPEED_I2C] + i);
+        /*
+         * The AST2600 SoC has one IRQ per I2C bus. Skip the common
+         * IRQ (AST2400 and AST2500) and connect all bussses.
+         */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), i + 1, irq);
+    }
+
+    /* FMC, The number of CS is set at the board level */
+    object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
+                            "sdram-base", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
+                    s->fmc.ctrl->flash_window_base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
+                       aspeed_soc_get_irq(s, ASPEED_FMC));
+
+    /* SPI */
+    for (i =3D 0; i < sc->spis_num; i++) {
+        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
+                                 &local_err);
+        error_propagate(&err, local_err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                        sc->memmap[ASPEED_SPI1 + i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
+                        s->spi[i].ctrl->flash_window_base);
+    }
+
+    /* SDMC - SDRAM Memory Controller */
+    object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]=
);
+
+    /* Watch dog */
+    for (i =3D 0; i < sc->wdts_num; i++) {
+        AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
+
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &=
err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                        sc->memmap[ASPEED_WDT] + i * awc->offset);
+    }
+
+    /* Net */
+    for (i =3D 0; i < nb_nics; i++) {
+        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed=
",
+                                 &err);
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realiz=
ed",
+                                 &local_err);
+        error_propagate(&err, local_err);
+        if (err) {
+            error_propagate(errp, err);
+           return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+                        sc->memmap[ASPEED_ETH1 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+                           aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
+    }
+
+    /* XDMA */
+    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
+                    sc->memmap[ASPEED_XDMA]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
+                       aspeed_soc_get_irq(s, ASPEED_XDMA));
+
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]=
);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
+                       aspeed_soc_get_irq(s, ASPEED_GPIO));
+
+    object_property_set_bool(OBJECT(&s->gpio_1_8v), true, "realized", &e=
rr);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
+                    sc->memmap[ASPEED_GPIO_1_8V]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
+                       aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
+
+    /* SDHCI */
+    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
+                    sc->memmap[ASPEED_SDHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
+                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
+}
+
+static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);
+
+    dc->realize      =3D aspeed_soc_ast2600_realize;
+
+    sc->name         =3D "ast2600-a0";
+    sc->cpu_type     =3D ARM_CPU_TYPE_NAME("cortex-a7");
+    sc->silicon_rev  =3D AST2600_A0_SILICON_REV;
+    sc->sram_size    =3D 0x10000;
+    sc->spis_num     =3D 2;
+    sc->wdts_num     =3D 4;
+    sc->irqmap       =3D aspeed_soc_ast2600_irqmap;
+    sc->memmap       =3D aspeed_soc_ast2600_memmap;
+    sc->num_cpus     =3D 2;
+}
+
+static const TypeInfo aspeed_soc_ast2600_type_info =3D {
+    .name           =3D "ast2600-a0",
+    .parent         =3D TYPE_ASPEED_SOC,
+    .instance_size  =3D sizeof(AspeedSoCState),
+    .instance_init  =3D aspeed_soc_ast2600_init,
+    .class_init     =3D aspeed_soc_ast2600_class_init,
+    .class_size     =3D sizeof(AspeedSoCClass),
+};
+
+static void aspeed_soc_register_types(void)
+{
+    type_register_static(&aspeed_soc_ast2600_type_info);
+};
+
+type_init(aspeed_soc_register_types)
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 43ce8d5b19f8..fe749f65fd7d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -41,7 +41,7 @@ obj-$(CONFIG_XLNX_VERSAL) +=3D xlnx-versal.o xlnx-versa=
l-virt.o
 obj-$(CONFIG_FSL_IMX25) +=3D fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o
-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
+obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o aspeed_ast2600.o
 obj-$(CONFIG_MPS2) +=3D mps2.o
 obj-$(CONFIG_MPS2) +=3D mps2-tz.o
 obj-$(CONFIG_MSF2) +=3D msf2-soc.o
--=20
2.21.0


