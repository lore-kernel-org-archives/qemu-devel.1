Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93694C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C8421848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C8421848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iApc1-0002Jh-8n
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iApML-0002Td-9R
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iApMJ-0000Dr-1G
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:52:05 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:33408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iApMI-0000Cp-Pd
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:52:02 -0400
Received: from player788.ha.ovh.net (unknown [10.108.35.128])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id C312019023F
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:52:00 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 1451F9F1760E;
 Thu, 19 Sep 2019 05:51:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 07:49:57 +0200
Message-Id: <20190919055002.6729-17-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919055002.6729-1-clg@kaod.org>
References: <20190919055002.6729-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1693353461538458385
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.110.239
Subject: [Qemu-devel] [PATCH 16/21] aspeed: Introduce an object class per SoC
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

It prepares ground for the AST2600.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |   9 +--
 hw/arm/aspeed.c             |   4 +-
 hw/arm/aspeed_soc.c         | 148 +++++++++++++++++++-----------------
 3 files changed, 84 insertions(+), 77 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b427f2668a8a..667dfec0f7b6 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -57,7 +57,9 @@ typedef struct AspeedSoCState {
 #define TYPE_ASPEED_SOC "aspeed-soc"
 #define ASPEED_SOC(obj) OBJECT_CHECK(AspeedSoCState, (obj), TYPE_ASPEED_=
SOC)
=20
-typedef struct AspeedSoCInfo {
+typedef struct AspeedSoCClass {
+    DeviceClass parent_class;
+
     const char *name;
     const char *cpu_type;
     uint32_t silicon_rev;
@@ -67,11 +69,6 @@ typedef struct AspeedSoCInfo {
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
-} AspeedSoCInfo;
-
-typedef struct AspeedSoCClass {
-    DeviceClass parent_class;
-    AspeedSoCInfo *info;
 } AspeedSoCClass;
=20
 #define ASPEED_SOC_CLASS(klass)                                         =
\
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 30e280484262..52993f84b461 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -215,7 +215,7 @@ static void aspeed_board_init(MachineState *machine,
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
     memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SDRAM],
+                                sc->memmap[ASPEED_SDRAM],
                                 &bmc->ram_container);
=20
     max_ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "max-ra=
m-size",
@@ -246,7 +246,7 @@ static void aspeed_board_init(MachineState *machine,
     }
=20
     aspeed_board_binfo.ram_size =3D ram_size;
-    aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM];
+    aspeed_board_binfo.loader_start =3D sc->memmap[ASPEED_SDRAM];
     aspeed_board_binfo.nb_cpus =3D bmc->soc.num_cpus;
=20
     if (cfg->i2c_init) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e60f198d92c1..a063be9fd795 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -115,35 +115,11 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
=20
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
=20
-static const AspeedSoCInfo aspeed_socs[] =3D {
-    {
-        .name         =3D "ast2400-a1",
-        .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
-        .silicon_rev  =3D AST2400_A1_SILICON_REV,
-        .sram_size    =3D 0x8000,
-        .spis_num     =3D 1,
-        .wdts_num     =3D 2,
-        .irqmap       =3D aspeed_soc_ast2400_irqmap,
-        .memmap       =3D aspeed_soc_ast2400_memmap,
-        .num_cpus     =3D 1,
-    }, {
-        .name         =3D "ast2500-a1",
-        .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
-        .silicon_rev  =3D AST2500_A1_SILICON_REV,
-        .sram_size    =3D 0x9000,
-        .spis_num     =3D 2,
-        .wdts_num     =3D 3,
-        .irqmap       =3D aspeed_soc_ast2500_irqmap,
-        .memmap       =3D aspeed_soc_ast2500_memmap,
-        .num_cpus     =3D 1,
-    },
-};
-
 static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
 {
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
=20
-    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
+    return qdev_get_gpio_in(DEVICE(&s->vic), sc->irqmap[ctrl]);
 }
=20
 static void aspeed_soc_init(Object *obj)
@@ -154,13 +130,13 @@ static void aspeed_soc_init(Object *obj)
     char socname[8];
     char typename[64];
=20
-    if (sscanf(sc->info->name, "%7s", socname) !=3D 1) {
+    if (sscanf(sc->name, "%7s", socname) !=3D 1) {
         g_assert_not_reached();
     }
=20
-    for (i =3D 0; i < sc->info->num_cpus; i++) {
+    for (i =3D 0; i < sc->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
-                                sizeof(s->cpu[i]), sc->info->cpu_type,
+                                sizeof(s->cpu[i]), sc->cpu_type,
                                 &error_abort, NULL);
     }
=20
@@ -168,7 +144,7 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
                           typename);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
-                         sc->info->silicon_rev);
+                         sc->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
                               "hw-strap1", &error_abort);
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
@@ -200,7 +176,7 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "dram", OBJECT(&s->fmc), "dram",
                               &error_abort);
=20
-    for (i =3D 0; i < sc->info->spis_num; i++) {
+    for (i =3D 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, s=
ocname);
         sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
                               sizeof(s->spi[i]), typename);
@@ -214,7 +190,7 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
                               "max-ram-size", &error_abort);
=20
-    for (i =3D 0; i < sc->info->wdts_num; i++) {
+    for (i =3D 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
         sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
                               sizeof(s->wdt[i]), typename);
@@ -252,13 +228,13 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
     Error *err =3D NULL, *local_err =3D NULL;
=20
     /* IO space */
-    create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED=
_IOMEM],
+    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM=
],
                                 ASPEED_SOC_IOMEM_SIZE);
=20
-    if (s->num_cpus > sc->info->num_cpus) {
+    if (s->num_cpus > sc->num_cpus) {
         warn_report("%s: invalid number of CPUs %d, using default %d",
-                    sc->info->name, s->num_cpus, sc->info->num_cpus);
-        s->num_cpus =3D sc->info->num_cpus;
+                    sc->name, s->num_cpus, sc->num_cpus);
+        s->num_cpus =3D sc->num_cpus;
     }
=20
     /* CPU */
@@ -272,13 +248,13 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
=20
     /* SRAM */
     memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
-                           sc->info->sram_size, &err);
+                           sc->sram_size, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SRAM], &s->sram)=
;
+                                sc->memmap[ASPEED_SRAM], &s->sram);
=20
     /* SCU */
     object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
@@ -286,7 +262,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->info->memmap[ASPEED_=
SCU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
=20
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
@@ -294,7 +270,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->info->memmap[ASPEED_=
VIC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
@@ -306,7 +282,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->info->memmap[ASPEED_=
RTC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_RTC));
=20
@@ -317,7 +293,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
-                    sc->info->memmap[ASPEED_TIMER1]);
+                    sc->memmap[ASPEED_TIMER1]);
     for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
@@ -326,7 +302,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
         qemu_irq uart5 =3D aspeed_soc_get_irq(s, ASPEED_UART5);
-        serial_mm_init(get_system_memory(), sc->info->memmap[ASPEED_UART=
5], 2,
+        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_UART5], 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN)=
;
     }
=20
@@ -336,12 +312,12 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->info->memmap[ASPEED_=
I2C]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        aspeed_soc_get_irq(s, ASPEED_I2C));
=20
     /* FMC, The number of CS is set at the board level */
-    object_property_set_int(OBJECT(&s->fmc), sc->info->memmap[ASPEED_SDR=
AM],
+    object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
         error_propagate(errp, err);
@@ -352,14 +328,14 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->info->memmap[ASPEED_=
FMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_FMC));
=20
     /* SPI */
-    for (i =3D 0; i < sc->info->spis_num; i++) {
+    for (i =3D 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
                                  &local_err);
@@ -369,7 +345,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                        sc->info->memmap[ASPEED_SPI1 + i]);
+                        sc->memmap[ASPEED_SPI1 + i]);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
                         s->spi[i].ctrl->flash_window_base);
     }
@@ -380,10 +356,10 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->info->memmap[ASPEED=
_SDMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]=
);
=20
     /* Watch dog */
-    for (i =3D 0; i < sc->info->wdts_num; i++) {
+    for (i =3D 0; i < sc->wdts_num; i++) {
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
=20
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &=
err);
@@ -392,7 +368,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        sc->info->memmap[ASPEED_WDT] + i * awc->offset);
+                        sc->memmap[ASPEED_WDT] + i * awc->offset);
     }
=20
     /* Net */
@@ -408,7 +384,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
            return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                        sc->info->memmap[ASPEED_ETH1 + i]);
+                        sc->memmap[ASPEED_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
     }
@@ -420,7 +396,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
-                    sc->info->memmap[ASPEED_XDMA]);
+                    sc->memmap[ASPEED_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
=20
@@ -430,7 +406,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info->memmap[ASPEED=
_GPIO]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]=
);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
=20
@@ -441,7 +417,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
-                    sc->info->memmap[ASPEED_SDHCI]);
+                    sc->memmap[ASPEED_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
@@ -453,9 +429,7 @@ static Property aspeed_soc_properties[] =3D {
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
-    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);
=20
-    sc->info =3D (AspeedSoCInfo *) data;
     dc->realize =3D aspeed_soc_realize;
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable =3D false;
@@ -465,26 +439,62 @@ static void aspeed_soc_class_init(ObjectClass *oc, =
void *data)
 static const TypeInfo aspeed_soc_type_info =3D {
     .name           =3D TYPE_ASPEED_SOC,
     .parent         =3D TYPE_DEVICE,
-    .instance_init  =3D aspeed_soc_init,
     .instance_size  =3D sizeof(AspeedSoCState),
     .class_size     =3D sizeof(AspeedSoCClass),
+    .class_init     =3D aspeed_soc_class_init,
     .abstract       =3D true,
 };
=20
-static void aspeed_soc_register_types(void)
+static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 {
-    int i;
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);
=20
-    type_register_static(&aspeed_soc_type_info);
-    for (i =3D 0; i < ARRAY_SIZE(aspeed_socs); ++i) {
-        TypeInfo ti =3D {
-            .name       =3D aspeed_socs[i].name,
-            .parent     =3D TYPE_ASPEED_SOC,
-            .class_init =3D aspeed_soc_class_init,
-            .class_data =3D (void *) &aspeed_socs[i],
-        };
-        type_register(&ti);
-    }
+    sc->name         =3D "ast2400-a1";
+    sc->cpu_type     =3D ARM_CPU_TYPE_NAME("arm926");
+    sc->silicon_rev  =3D AST2400_A1_SILICON_REV;
+    sc->sram_size    =3D 0x8000;
+    sc->spis_num     =3D 1;
+    sc->wdts_num     =3D 2;
+    sc->irqmap       =3D aspeed_soc_ast2400_irqmap;
+    sc->memmap       =3D aspeed_soc_ast2400_memmap;
+    sc->num_cpus     =3D 1;
+}
+
+static const TypeInfo aspeed_soc_ast2400_type_info =3D {
+    .name           =3D "ast2400-a1",
+    .parent         =3D TYPE_ASPEED_SOC,
+    .instance_init  =3D aspeed_soc_init,
+    .instance_size  =3D sizeof(AspeedSoCState),
+    .class_init     =3D aspeed_soc_ast2400_class_init,
+};
+
+static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
+{
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);
+
+    sc->name         =3D "ast2500-a1";
+    sc->cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176");
+    sc->silicon_rev  =3D AST2500_A1_SILICON_REV;
+    sc->sram_size    =3D 0x9000;
+    sc->spis_num     =3D 2;
+    sc->wdts_num     =3D 3;
+    sc->irqmap       =3D aspeed_soc_ast2500_irqmap;
+    sc->memmap       =3D aspeed_soc_ast2500_memmap;
+    sc->num_cpus     =3D 1;
 }
=20
+static const TypeInfo aspeed_soc_ast2500_type_info =3D {
+    .name           =3D "ast2500-a1",
+    .parent         =3D TYPE_ASPEED_SOC,
+    .instance_init  =3D aspeed_soc_init,
+    .instance_size  =3D sizeof(AspeedSoCState),
+    .class_init     =3D aspeed_soc_ast2500_class_init,
+};
+static void aspeed_soc_register_types(void)
+{
+    type_register_static(&aspeed_soc_type_info);
+    type_register_static(&aspeed_soc_ast2400_type_info);
+    type_register_static(&aspeed_soc_ast2500_type_info);
+};
+
 type_init(aspeed_soc_register_types)
--=20
2.21.0


