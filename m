Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8332EECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB5320854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKXvw7nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB5320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3WC-00005H-NA
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qn-0005L5-Ck
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2ql-0008AR-4w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qk-0008A8-TP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id o18so20331654wrv.13
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Lk53KloC77qSylI6gMdQipnIz1hy/S7yTdQfSeYM+qk=;
 b=jKXvw7nkCG5ohTYDfJ/kDNTsLjwZFcMOrEW3vTfQ4cSBE+O40NdvxIRmCkmFJmRjSz
 fZHUEla3uwA5ZAzElSDv7KSApWz6M/X56MXM05uo24632V53uHK/iScfmQd6QmeXeCcM
 vaAEP6+TEh4TFQbmzXSEsD1FKZCw6SmXbyTGD+T9KOOW7QQ9X2eRe5PUkTVJsBKCFOZi
 b3r9NqCYNSXM6hME1zOHqV4T1TfO79+nSGPLQLMBFirCD79JfQ5X46JVSU7E9e0STobP
 caOG6JGnMuke6TuPI6RZCEXsxMpBy8vTFhC/lU2xx3ZlOXJ+ioyoHt7uJJctqSKvwXQ3
 YU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lk53KloC77qSylI6gMdQipnIz1hy/S7yTdQfSeYM+qk=;
 b=T/NErfNdDIsiWz2rcB8Xq/op/MAWDta6C1pXqWpPMVdTi2T/5TPaZp1T4gTM4tpEGm
 Dph8711HglxhYn0vytXPxR97wkPWhyJj9G/qSWQVGr9Xpwyav4oAq4gPtNFrsXDqxmXv
 lO9wO+QJusOzH3h4Ataf9n+cTuPpUV4TzFA4hZOkg+pwtHknfZN3fKAKa2BSxGib3faL
 kUitMFaNZ070DLXXcY8lBlg8mOtLu3TrXsvDSGPhl1msxvXS+fXPfA9UgWrHhd5N/Fyw
 tOEEhZw/r8d4dsl435QegRCOIEPkv8C4J9ktrYaF8j95vQYrVjTWlKDht9c5e1wltnwe
 kSEA==
X-Gm-Message-State: APjAAAUbKfhERq5XQc71+/cFa4eRjEJQfMzz5mfAiN21CGxB9XukgkrJ
 rhP0BQQ70XZz7I6I3mWtDcgtj0c5aU6Dhw==
X-Google-Smtp-Source: APXvYqzLe+837Dk0pkU6/lQOi+NcPTVEeefYjDVYpXjEOnmfyQKaCJnzt7cCxqPIh/jc9FIPBkaQQw==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr3656534wrf.221.1571069133378; 
 Mon, 14 Oct 2019 09:05:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/68] aspeed: Introduce an object class per SoC
Date: Mon, 14 Oct 2019 17:03:52 +0100
Message-Id: <20191014160404.19553-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

It prepares ground for the AST2600.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-18-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |   9 +--
 hw/arm/aspeed.c             |   4 +-
 hw/arm/aspeed_soc.c         | 148 +++++++++++++++++++-----------------
 3 files changed, 84 insertions(+), 77 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b427f2668a8..667dfec0f7b 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -57,7 +57,9 @@ typedef struct AspeedSoCState {
 #define TYPE_ASPEED_SOC "aspeed-soc"
 #define ASPEED_SOC(obj) OBJECT_CHECK(AspeedSoCState, (obj), TYPE_ASPEED_SOC)
 
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
 
 #define ASPEED_SOC_CLASS(klass)                                         \
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 30e28048426..52993f84b46 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -215,7 +215,7 @@ static void aspeed_board_init(MachineState *machine,
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size);
     memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SDRAM],
+                                sc->memmap[ASPEED_SDRAM],
                                 &bmc->ram_container);
 
     max_ram_size = object_property_get_uint(OBJECT(&bmc->soc), "max-ram-size",
@@ -246,7 +246,7 @@ static void aspeed_board_init(MachineState *machine,
     }
 
     aspeed_board_binfo.ram_size = ram_size;
-    aspeed_board_binfo.loader_start = sc->info->memmap[ASPEED_SDRAM];
+    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
     aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
 
     if (cfg->i2c_init) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e60f198d92c..a063be9fd79 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -115,35 +115,11 @@ static const int aspeed_soc_ast2400_irqmap[] = {
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
 
-static const AspeedSoCInfo aspeed_socs[] = {
-    {
-        .name         = "ast2400-a1",
-        .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
-        .silicon_rev  = AST2400_A1_SILICON_REV,
-        .sram_size    = 0x8000,
-        .spis_num     = 1,
-        .wdts_num     = 2,
-        .irqmap       = aspeed_soc_ast2400_irqmap,
-        .memmap       = aspeed_soc_ast2400_memmap,
-        .num_cpus     = 1,
-    }, {
-        .name         = "ast2500-a1",
-        .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
-        .silicon_rev  = AST2500_A1_SILICON_REV,
-        .sram_size    = 0x9000,
-        .spis_num     = 2,
-        .wdts_num     = 3,
-        .irqmap       = aspeed_soc_ast2500_irqmap,
-        .memmap       = aspeed_soc_ast2500_memmap,
-        .num_cpus     = 1,
-    },
-};
-
 static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
 {
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
-    return qdev_get_gpio_in(DEVICE(&s->vic), sc->info->irqmap[ctrl]);
+    return qdev_get_gpio_in(DEVICE(&s->vic), sc->irqmap[ctrl]);
 }
 
 static void aspeed_soc_init(Object *obj)
@@ -154,13 +130,13 @@ static void aspeed_soc_init(Object *obj)
     char socname[8];
     char typename[64];
 
-    if (sscanf(sc->info->name, "%7s", socname) != 1) {
+    if (sscanf(sc->name, "%7s", socname) != 1) {
         g_assert_not_reached();
     }
 
-    for (i = 0; i < sc->info->num_cpus; i++) {
+    for (i = 0; i < sc->num_cpus; i++) {
         object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
-                                sizeof(s->cpu[i]), sc->info->cpu_type,
+                                sizeof(s->cpu[i]), sc->cpu_type,
                                 &error_abort, NULL);
     }
 
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
 
-    for (i = 0; i < sc->info->spis_num; i++) {
+    for (i = 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, socname);
         sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
                               sizeof(s->spi[i]), typename);
@@ -214,7 +190,7 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
                               "max-ram-size", &error_abort);
 
-    for (i = 0; i < sc->info->wdts_num; i++) {
+    for (i = 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
         sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
                               sizeof(s->wdt[i]), typename);
@@ -252,13 +228,13 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     Error *err = NULL, *local_err = NULL;
 
     /* IO space */
-    create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED_IOMEM],
+    create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
 
-    if (s->num_cpus > sc->info->num_cpus) {
+    if (s->num_cpus > sc->num_cpus) {
         warn_report("%s: invalid number of CPUs %d, using default %d",
-                    sc->info->name, s->num_cpus, sc->info->num_cpus);
-        s->num_cpus = sc->info->num_cpus;
+                    sc->name, s->num_cpus, sc->num_cpus);
+        s->num_cpus = sc->num_cpus;
     }
 
     /* CPU */
@@ -272,13 +248,13 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
-                           sc->info->sram_size, &err);
+                           sc->sram_size, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SRAM], &s->sram);
+                                sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
     object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
@@ -286,7 +262,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->info->memmap[ASPEED_SCU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
@@ -294,7 +270,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->info->memmap[ASPEED_VIC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
@@ -306,7 +282,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->info->memmap[ASPEED_RTC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_RTC));
 
@@ -317,7 +293,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
-                    sc->info->memmap[ASPEED_TIMER1]);
+                    sc->memmap[ASPEED_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
@@ -326,7 +302,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hd(0)) {
         qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
-        serial_mm_init(get_system_memory(), sc->info->memmap[ASPEED_UART5], 2,
+        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_UART5], 2,
                        uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
     }
 
@@ -336,12 +312,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->info->memmap[ASPEED_I2C]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        aspeed_soc_get_irq(s, ASPEED_I2C));
 
     /* FMC, The number of CS is set at the board level */
-    object_property_set_int(OBJECT(&s->fmc), sc->info->memmap[ASPEED_SDRAM],
+    object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
                             "sdram-base", &err);
     if (err) {
         error_propagate(errp, err);
@@ -352,14 +328,14 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->info->memmap[ASPEED_FMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 1,
                     s->fmc.ctrl->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_FMC));
 
     /* SPI */
-    for (i = 0; i < sc->info->spis_num; i++) {
+    for (i = 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
                                  &local_err);
@@ -369,7 +345,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                        sc->info->memmap[ASPEED_SPI1 + i]);
+                        sc->memmap[ASPEED_SPI1 + i]);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 1,
                         s->spi[i].ctrl->flash_window_base);
     }
@@ -380,10 +356,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->info->memmap[ASPEED_SDMC]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
 
     /* Watch dog */
-    for (i = 0; i < sc->info->wdts_num; i++) {
+    for (i = 0; i < sc->wdts_num; i++) {
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
@@ -392,7 +368,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        sc->info->memmap[ASPEED_WDT] + i * awc->offset);
+                        sc->memmap[ASPEED_WDT] + i * awc->offset);
     }
 
     /* Net */
@@ -408,7 +384,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
            return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                        sc->info->memmap[ASPEED_ETH1 + i]);
+                        sc->memmap[ASPEED_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
     }
@@ -420,7 +396,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
-                    sc->info->memmap[ASPEED_XDMA]);
+                    sc->memmap[ASPEED_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
@@ -430,7 +406,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info->memmap[ASPEED_GPIO]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
@@ -441,7 +417,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
-                    sc->info->memmap[ASPEED_SDHCI]);
+                    sc->memmap[ASPEED_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
@@ -453,9 +429,7 @@ static Property aspeed_soc_properties[] = {
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
 
-    sc->info = (AspeedSoCInfo *) data;
     dc->realize = aspeed_soc_realize;
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable = false;
@@ -465,26 +439,62 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 static const TypeInfo aspeed_soc_type_info = {
     .name           = TYPE_ASPEED_SOC,
     .parent         = TYPE_DEVICE,
-    .instance_init  = aspeed_soc_init,
     .instance_size  = sizeof(AspeedSoCState),
     .class_size     = sizeof(AspeedSoCClass),
+    .class_init     = aspeed_soc_class_init,
     .abstract       = true,
 };
 
-static void aspeed_soc_register_types(void)
+static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 {
-    int i;
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
 
-    type_register_static(&aspeed_soc_type_info);
-    for (i = 0; i < ARRAY_SIZE(aspeed_socs); ++i) {
-        TypeInfo ti = {
-            .name       = aspeed_socs[i].name,
-            .parent     = TYPE_ASPEED_SOC,
-            .class_init = aspeed_soc_class_init,
-            .class_data = (void *) &aspeed_socs[i],
-        };
-        type_register(&ti);
-    }
+    sc->name         = "ast2400-a1";
+    sc->cpu_type     = ARM_CPU_TYPE_NAME("arm926");
+    sc->silicon_rev  = AST2400_A1_SILICON_REV;
+    sc->sram_size    = 0x8000;
+    sc->spis_num     = 1;
+    sc->wdts_num     = 2;
+    sc->irqmap       = aspeed_soc_ast2400_irqmap;
+    sc->memmap       = aspeed_soc_ast2400_memmap;
+    sc->num_cpus     = 1;
 }
 
+static const TypeInfo aspeed_soc_ast2400_type_info = {
+    .name           = "ast2400-a1",
+    .parent         = TYPE_ASPEED_SOC,
+    .instance_init  = aspeed_soc_init,
+    .instance_size  = sizeof(AspeedSoCState),
+    .class_init     = aspeed_soc_ast2400_class_init,
+};
+
+static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
+
+    sc->name         = "ast2500-a1";
+    sc->cpu_type     = ARM_CPU_TYPE_NAME("arm1176");
+    sc->silicon_rev  = AST2500_A1_SILICON_REV;
+    sc->sram_size    = 0x9000;
+    sc->spis_num     = 2;
+    sc->wdts_num     = 3;
+    sc->irqmap       = aspeed_soc_ast2500_irqmap;
+    sc->memmap       = aspeed_soc_ast2500_memmap;
+    sc->num_cpus     = 1;
+}
+
+static const TypeInfo aspeed_soc_ast2500_type_info = {
+    .name           = "ast2500-a1",
+    .parent         = TYPE_ASPEED_SOC,
+    .instance_init  = aspeed_soc_init,
+    .instance_size  = sizeof(AspeedSoCState),
+    .class_init     = aspeed_soc_ast2500_class_init,
+};
+static void aspeed_soc_register_types(void)
+{
+    type_register_static(&aspeed_soc_type_info);
+    type_register_static(&aspeed_soc_ast2400_type_info);
+    type_register_static(&aspeed_soc_ast2500_type_info);
+};
+
 type_init(aspeed_soc_register_types)
-- 
2.20.1


