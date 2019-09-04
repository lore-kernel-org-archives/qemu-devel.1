Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25399C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABF420828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABF420828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dEg-0005s9-9w
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cCm-0001Ak-3j
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cCj-0001xW-8E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:39 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:42806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cCi-0001wA-NO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:36 -0400
Received: from player691.ha.ovh.net (unknown [10.109.160.226])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id DFE3818D83A
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:48:34 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 4955A98B2950;
 Wed,  4 Sep 2019 20:48:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:56 +0200
Message-Id: <20190904204659.13878-13-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2531585941748615953
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.110.239
Subject: [Qemu-devel] [RFC PATCH 12/15] aspeed: add support for the AST2600
 eval board
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

Differences with the AST2400 and the AST2500 SoCs are handled using
the ASPEED_IS_AST2600() macro. This is not optimal but it is not too
invasive either. We could modify the model to add custom instance_init
and realize handlers in the future.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h  |   4 +
 include/hw/misc/aspeed_scu.h |   1 +
 hw/arm/aspeed.c              |  18 ++++
 hw/arm/aspeed_soc.c          | 189 ++++++++++++++++++++++++++++++++---
 4 files changed, 197 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b427f2668a8a..74db48374531 100644
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
@@ -97,6 +100,7 @@ enum {
     ASPEED_SRAM,
     ASPEED_SDHCI,
     ASPEED_GPIO,
+    ASPEED_GPIO_1_8V,
     ASPEED_RTC,
     ASPEED_TIMER1,
     ASPEED_TIMER2,
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 1d7f7ffc1598..670804e85f28 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -43,6 +43,7 @@ typedef struct AspeedSCUState {
 #define AST2600_A0_SILICON_REV   0x05000303U
=20
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D =
0x04)
+#define ASPEED_IS_AST2600(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D =
0x05)
=20
 extern bool is_supported_silicon_rev(uint32_t silicon_rev);
=20
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 03cc0952e8f3..f4f1dd29b011 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -88,6 +88,9 @@ struct AspeedBoardState {
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
=20
+/* AST2600 evb hardware value: (QEMU prototype) */
+#define AST2600_EVB_HW_STRAP1 AST2500_EVB_HW_STRAP1
+
 /*
  * The max ram region is for firmwares that scan the address space
  * with load/store to guess how much RAM the SoC has.
@@ -294,6 +297,12 @@ static void ast2500_evb_i2c_init(AspeedBoardState *b=
mc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
 }
=20
+static void ast2600_evb_i2c_init(AspeedBoardState *bmc)
+{
+    /* Start with some devices on our I2C busses */
+    ast2500_evb_i2c_init(bmc);
+}
+
 static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
@@ -441,6 +450,15 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .num_cs    =3D 2,
         .i2c_init  =3D witherspoon_bmc_i2c_init,
         .ram       =3D 512 * MiB,
+    }, {
+        .name      =3D MACHINE_TYPE_NAME("ast2600-evb"),
+        .desc      =3D "Aspeed AST2600 EVB (Cortex A7)",
+        .soc_name  =3D "ast2600-a0",
+        .hw_strap1 =3D AST2600_EVB_HW_STRAP1,
+        .fmc_model =3D "mx25l25635e",
+        .spi_model =3D "mx25l25635e",
+        .num_cs    =3D 1,
+        .i2c_init  =3D ast2600_evb_i2c_init,
     },
 };
=20
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5c5fcb810944..80d7f206004c 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -81,6 +81,38 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
     [ASPEED_SDRAM]  =3D 0x80000000,
 };
=20
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
 static const int aspeed_soc_ast2400_irqmap[] =3D {
     [ASPEED_UART1]  =3D 9,
     [ASPEED_UART2]  =3D 32,
@@ -115,6 +147,41 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
=20
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
=20
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
+    [ASPEED_XDMA]      =3D 6,
+    [ASPEED_ADC]       =3D 46,
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
 static const AspeedSoCInfo aspeed_socs[] =3D {
     {
         .name         =3D "ast2400-a1",
@@ -136,14 +203,26 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .irqmap       =3D aspeed_soc_ast2500_irqmap,
         .memmap       =3D aspeed_soc_ast2500_memmap,
         .num_cpus     =3D 1,
+    }, {
+        .name         =3D "ast2600-a0",
+        .cpu_type     =3D ARM_CPU_TYPE_NAME("cortex-a7"),
+        .silicon_rev  =3D AST2600_A0_SILICON_REV,
+        .sram_size    =3D 0x10000,
+        .spis_num     =3D 2,
+        .wdts_num     =3D 4,
+        .irqmap       =3D aspeed_soc_ast2600_irqmap,
+        .memmap       =3D aspeed_soc_ast2600_memmap,
+        .num_cpus     =3D 2,
     },
 };
=20
 static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
 {
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
+    DeviceState *intc =3D ASPEED_IS_AST2600(sc->info->silicon_rev) ?
+        DEVICE(&s->a7mpcore) : DEVICE(&s->vic);
=20
-    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
+    return qdev_get_gpio_in(intc, sc->info->irqmap[ctrl]);
 }
=20
 static void aspeed_soc_init(Object *obj)
@@ -176,8 +255,13 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key", &error_abort);
=20
-    sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
-                          TYPE_ASPEED_VIC);
+    if (ASPEED_IS_AST2600(sc->info->silicon_rev)) {
+        sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore,
+                              sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
+    } else {
+        sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic=
),
+                              TYPE_ASPEED_VIC);
+    }
=20
     sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
                           TYPE_ASPEED_RTC);
@@ -233,6 +317,12 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio)=
,
                           typename);
=20
+    if (ASPEED_IS_AST2600(sc->info->silicon_rev)) {
+        snprintf(typename, sizeof(typename), "aspeed.gpio-%s-1_8v", socn=
ame);
+        sysbus_init_child_obj(obj, "gpio_1_8v", OBJECT(&s->gpio_1_8v),
+                              sizeof(s->gpio_1_8v), typename);
+    }
+
     sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhci=
),
                           TYPE_ASPEED_SDHCI);
=20
@@ -243,6 +333,16 @@ static void aspeed_soc_init(Object *obj)
     }
 }
=20
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
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -262,6 +362,23 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
=20
     /* CPU */
     for (i =3D 0; i < s->num_cpus; i++) {
+        if (ASPEED_IS_AST2600(sc->info->silicon_rev)) {
+            object_property_set_int(OBJECT(&s->cpu[i]), QEMU_PSCI_CONDUI=
T_SMC,
+                                    "psci-conduit", &error_abort);
+            if (s->num_cpus > 1) {
+                object_property_set_int(OBJECT(&s->cpu[i]),
+                                        ASPEED_A7MPCORE_ADDR,
+                                        "reset-cbar", &error_abort);
+            }
+            object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affi=
nity(i),
+                                    "mp-affinity", &error_abort);
+
+            /*
+             * TODO: the secondary CPUs are started and a boot helper
+             * is needed when using -kernel
+             */
+        }
+
         object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &=
err);
         if (err) {
             error_propagate(errp, err);
@@ -269,6 +386,48 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
         }
     }
=20
+    /* A7MPCORE */
+    if (ASPEED_IS_AST2600(sc->info->silicon_rev)) {
+        qemu_irq irq;
+
+        object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-=
cpu",
+                                &error_abort);
+        object_property_set_int(OBJECT(&s->a7mpcore),
+                                ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNA=
L,
+                                "num-irq", &error_abort);
+
+        object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE=
_ADDR);
+
+        for (i =3D 0; i < s->num_cpus; i++) {
+            SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->a7mpcore);
+            DeviceState  *d   =3D DEVICE(qemu_get_cpu(i));
+
+            irq =3D qdev_get_gpio_in(d, ARM_CPU_IRQ);
+            sysbus_connect_irq(sbd, i, irq);
+            irq =3D qdev_get_gpio_in(d, ARM_CPU_FIQ);
+            sysbus_connect_irq(sbd, i + s->num_cpus, irq);
+            irq =3D qdev_get_gpio_in(d, ARM_CPU_VIRQ);
+            sysbus_connect_irq(sbd, i + 2 * s->num_cpus, irq);
+            irq =3D qdev_get_gpio_in(d, ARM_CPU_VFIQ);
+            sysbus_connect_irq(sbd, i + 3 * s->num_cpus, irq);
+        }
+    } else {
+        /* VIC */
+        object_property_set_bool(OBJECT(&s->vic), true, "realized", &err=
);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0,
+                        sc->info->memmap[ASPEED_VIC]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
+                           qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ=
));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
+                           qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ=
));
+    }
+
     /* SRAM */
     memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
                            sc->info->sram_size, &err);
@@ -287,18 +446,6 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->info->memmap[ASPEED_=
SCU]);
=20
-    /* VIC */
-    object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->info->memmap[ASPEED_=
VIC]);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
-                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
-                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
-
     /* RTC */
     object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
     if (err) {
@@ -433,6 +580,18 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
=20
+    if (ASPEED_IS_AST2600(sc->info->silicon_rev)) {
+        object_property_set_bool(OBJECT(&s->gpio_1_8v), true, "realized"=
, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
+                        sc->info->memmap[ASPEED_GPIO_1_8V]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
+                           aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
+    }
+
     /* SDHCI */
     object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
     if (err) {
--=20
2.21.0


