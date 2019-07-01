Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28798C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E8A206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrC9IS53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E8A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7pk-0006PF-E7
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55574)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Md-00053I-9r
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Mb-0000HU-Li
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:01:31 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4Mb-0000HI-EW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:01:29 -0400
Received: by mail-wr1-f52.google.com with SMTP id p13so15406507wru.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1E06iM3g2rGIpvDkSZRxcV4cH98QgZLgZ77VISOvPlc=;
 b=rrC9IS53HJ9tl6cCe3/PhPlonva0bhClgGXrn4M88ljUCJkYgfpUmgKOFbYAFP1UO3
 JtwowsCbRmFCnU4TOU4QsFLVVm1QZdj5YKRVhc8v3x/6yb87zABKu3FecdoV/gLiFRUI
 /oQAeRbDI0CzITZuZnC+FVrl4+iCuhZ9shzBj/6NSBcVWntiXq9mtdcOHamZZlaZm1MF
 FodNHQEirXGsDtdNibMeYVWvUvspMZ5xYXsEsUbe8oZCgAl9bCbI6FFS+1BQ1TJ8/l/t
 Z4QDl1bn+jLWFcm6PSXdOuDSygXo4RND5+iZe8CuxjFrnGFQS2b6d4ZYqyzqIy8/xnft
 wJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1E06iM3g2rGIpvDkSZRxcV4cH98QgZLgZ77VISOvPlc=;
 b=JHNQ2yMt6EwaW2umRQXxu48mczVA63MfdYy49rzN5/5ZbE9x/sCcwWRzax6+T5TZpm
 8fIt5Zz8G6Nhp/M4PyPBi+7oALE/Pje55JGpL2TvhftKpSQnFokToVu6kvLLlBanA5cD
 0Ch4gZXGUuck/1pKj94cAMxBdPMq2qPuRRLR2i2mGbM5SLu+s94mOlyhqO5RLoZtX29D
 kHPsCfKDEMsOLnn/PzNKGmwrjcZIbsMwXyiTswWfWxiiaJPXuzmvfogixuDNub0t2ZcD
 +4BhHAjdiM17/55ZG7oI2dTYuADsiYCKLdHSgZJtQfRzdoPVETsAp4GPtNod4M5KzdcG
 9kWw==
X-Gm-Message-State: APjAAAU7/qkpR/ioVCYBqBqxhCI+sUrcq8JhBr8eUGmG0DZeBCUiioDW
 SJVz//3SHsz0zTSqJdvLyZG/AErzHXi9ng==
X-Google-Smtp-Source: APXvYqw5SRtS0ySqCxCgThkkGdeBtzB/0lcnmjHJLS6wniI76wAY2PLjxDFWdU/5nGnJkOxSNjiP+A==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr15984958wrn.88.1561999199485; 
 Mon, 01 Jul 2019 09:39:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:10 +0100
Message-Id: <20190701163943.22313-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.52
Subject: [Qemu-devel] [PULL 13/46] aspeed: introduce a configurable number
 of CPU per machine
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

The current models of the Aspeed SoCs only have one CPU but future
ones will support SMP. Introduce a new num_cpus field at the SoC class
level to define the number of available CPUs per SoC and also
introduce a 'num-cpus' property to activate the CPUs configured for
the machine.

The max_cpus limit of the machine should depend on the SoC definition
but, unfortunately, these values are not available when the machine
class is initialized. This is the reason why we add a check on
num_cpus in the AspeedSoC realize handler.

SMP support will be activated when models for such SoCs are implemented.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-6-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  5 ++++-
 hw/arm/aspeed.c             |  7 +++++--
 hw/arm/aspeed_soc.c         | 33 +++++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index fa0ba957a61..b613b00600f 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -24,13 +24,15 @@
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
+#define ASPEED_CPUS_NUM  2
 
 typedef struct AspeedSoCState {
     /*< private >*/
     DeviceState parent;
 
     /*< public >*/
-    ARMCPU cpu;
+    ARMCPU cpu[ASPEED_CPUS_NUM];
+    uint32_t num_cpus;
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedRtcState rtc;
@@ -58,6 +60,7 @@ typedef struct AspeedSoCInfo {
     int wdts_num;
     const int *irqmap;
     const hwaddr *memmap;
+    uint32_t num_cpus;
 } AspeedSoCInfo;
 
 typedef struct AspeedSoCClass {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c692ca1dba9..96de4f5c2a8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -22,13 +22,13 @@
 #include "hw/misc/tmp105.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
-    .nb_cpus = 1,
 };
 
 struct AspeedBoardState {
@@ -171,6 +171,8 @@ static void aspeed_board_init(MachineState *machine,
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
                             &error_abort);
+    object_property_set_int(OBJECT(&bmc->soc), smp_cpus, "num-cpus",
+                            &error_abort);
     if (machine->kernel_filename) {
         /*
          * When booting with a -kernel command line there is no u-boot
@@ -230,6 +232,7 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->info->memmap[ASPEED_SDRAM];
+    aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
 
     if (cfg->i2c_init) {
         cfg->i2c_init(bmc);
@@ -326,7 +329,7 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = board->desc;
     mc->init = aspeed_machine_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = ASPEED_CPUS_NUM;
     mc->no_sdcard = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5faa78d81fd..d38fb0aaa0f 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -19,6 +19,7 @@
 #include "hw/char/serial.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
 
@@ -123,6 +124,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
+        .num_cpus     = 1,
     }, {
         .name         = "ast2400-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
@@ -134,6 +136,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
+        .num_cpus     = 1,
     }, {
         .name         = "ast2400",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
@@ -145,6 +148,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
+        .num_cpus     = 1,
     }, {
         .name         = "ast2500-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
@@ -156,6 +160,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .wdts_num     = 3,
         .irqmap       = aspeed_soc_ast2500_irqmap,
         .memmap       = aspeed_soc_ast2500_memmap,
+        .num_cpus     = 1,
     },
 };
 
@@ -172,8 +177,11 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int i;
 
-    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cpu),
-                            sc->info->cpu_type, &error_abort, NULL);
+    for (i = 0; i < sc->info->num_cpus; i++) {
+        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
+                                sizeof(s->cpu[i]), sc->info->cpu_type,
+                                &error_abort, NULL);
+    }
 
     sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
                           TYPE_ASPEED_SCU);
@@ -241,11 +249,19 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
 
+    if (s->num_cpus > sc->info->num_cpus) {
+        warn_report("%s: invalid number of CPUs %d, using default %d",
+                    sc->info->name, s->num_cpus, sc->info->num_cpus);
+        s->num_cpus = sc->info->num_cpus;
+    }
+
     /* CPU */
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    for (i = 0; i < s->num_cpus; i++) {
+        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
 
     /* SRAM */
@@ -380,6 +396,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
                        aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
+static Property aspeed_soc_properties[] = {
+    DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
 
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
@@ -390,6 +410,7 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
     dc->realize = aspeed_soc_realize;
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable = false;
+    dc->props = aspeed_soc_properties;
 }
 
 static const TypeInfo aspeed_soc_type_info = {
-- 
2.20.1


