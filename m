Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74076206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMxvKzpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74076206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoRv-00066T-2R
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFj-0007lZ-C8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFh-00087H-Dy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:27 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFh-00083A-65
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:25 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so6714323wrt.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2o7CDQS8pVXcqWWDWE4VR4sQFaFf+rJlwan49ZOJRHk=;
 b=LMxvKzpX2tcpgTuqcluk1e3C8ltGQ51Xvrvcp1FsSUFpagJTfEC8gRZAUt/Xj1p1mD
 QpeUDUTlI22hMrRXePfAPl/yUBz2FQZbDYM9l3MDBp5Xa8iD6PjdQ7jcMlEGvAMcL4oj
 WXIZvZP+ZS6jGz+7RHb12d7y+VRr9Vjlu2P1vaO+hph9aCrbXp8/WkZnsncmYytqhIPs
 FeHYriX0x4AJ30BSjuhBgZxhP2qgRqqEnxOk46HCJM8x53Pu6yH2LPbqDMrsLdR9xDsx
 z9edofKKbW4DCdY+QZsDi0mhDsuxCUsxRZ58xaF6jgAbup7oV4CVGHkZIs4pCHzw3dgE
 Pa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2o7CDQS8pVXcqWWDWE4VR4sQFaFf+rJlwan49ZOJRHk=;
 b=RYYF1WDrAK0PVUeptsEuCQxk8orTYirvUe79n41JVDeWcPVSeLyWB7UQZpJiCCgw3t
 /pDeAH4nphAgAJ2feRsiOYy0gKYzYIm8lPe50My/cLOoiSzLmIYfBWMjDLgXZHysB0Rq
 ZpXaSKxh91+eDe0YNoR5fhpUHIzgS//80ruC1ORmMHO1zftej4unAtPC8JQySIVUwmNX
 nZ4KcBtzdg68ymZN3HwiH8CptBk43urgjteOjLGMTtG8SWxkolrD2vG38ORzl90lyrfK
 kKdzQqntYIa96G5XL/yA3b5jEMVL1YN2KCChfz9X8r/EA4V6d6+djrRFb2rYflrSNLph
 lEAg==
X-Gm-Message-State: APjAAAWBl401UIyZ3L8LN4Z7eSL8D4Ia9fOTP0CfOjHeTccFcj6cCX9U
 icnfRyljN1crwDgv2iS0mbLwKBPmo3WE5w==
X-Google-Smtp-Source: APXvYqzEcTSECqS8xERDuZ4DYNQQEBPtYYjJA/1bydF6JoinbPqudo7oWi64fDUjmZooCJonVdqB1Q==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr30123514wrq.129.1576494563815; 
 Mon, 16 Dec 2019 03:09:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/34] aspeed: Remove AspeedBoardConfig array and use
 AspeedMachineClass
Date: Mon, 16 Dec 2019 11:08:45 +0000
Message-Id: <20191216110904.30815-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

AspeedBoardConfig is a redundant way to define class attributes and it
complexifies the machine definition and initialization.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-14-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed.h |  24 ++--
 hw/arm/aspeed.c         | 243 ++++++++++++++++++++++------------------
 2 files changed, 143 insertions(+), 124 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index f49bc7081e4..4423cd0cda7 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -13,19 +13,6 @@
 
 typedef struct AspeedBoardState AspeedBoardState;
 
-typedef struct AspeedBoardConfig {
-    const char *name;
-    const char *desc;
-    const char *soc_name;
-    uint32_t hw_strap1;
-    uint32_t hw_strap2;
-    const char *fmc_model;
-    const char *spi_model;
-    uint32_t num_cs;
-    void (*i2c_init)(AspeedBoardState *bmc);
-    uint32_t ram;
-} AspeedBoardConfig;
-
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
 #define ASPEED_MACHINE(obj) \
     OBJECT_CHECK(AspeedMachine, (obj), TYPE_ASPEED_MACHINE)
@@ -41,7 +28,16 @@ typedef struct AspeedMachine {
 
 typedef struct AspeedMachineClass {
     MachineClass parent_obj;
-    const AspeedBoardConfig *board;
+
+    const char *name;
+    const char *desc;
+    const char *soc_name;
+    uint32_t hw_strap1;
+    uint32_t hw_strap2;
+    const char *fmc_model;
+    const char *spi_model;
+    uint32_t num_cs;
+    void (*i2c_init)(AspeedBoardState *bmc);
 } AspeedMachineClass;
 
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 028191ff36f..e34e6787430 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -167,10 +167,10 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
     }
 }
 
-static void aspeed_board_init(MachineState *machine,
-                              const AspeedBoardConfig *cfg)
+static void aspeed_machine_init(MachineState *machine)
 {
     AspeedBoardState *bmc;
+    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
     AspeedSoCClass *sc;
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
     ram_addr_t max_ram_size;
@@ -182,18 +182,18 @@ static void aspeed_board_init(MachineState *machine,
                        UINT32_MAX);
 
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
-                            (sizeof(bmc->soc)), cfg->soc_name, &error_abort,
+                            (sizeof(bmc->soc)), amc->soc_name, &error_abort,
                             NULL);
 
     sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
 
     object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
                              &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap1, "hw-strap1",
+    object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-strap1",
                             &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap2, "hw-strap2",
+    object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-strap2",
                             &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
+    object_property_set_int(OBJECT(&bmc->soc), amc->num_cs, "num-cs",
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), machine->smp.cpus, "num-cpus",
                             &error_abort);
@@ -230,8 +230,8 @@ static void aspeed_board_init(MachineState *machine,
                           "max_ram", max_ram_size  - ram_size);
     memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max_ram);
 
-    aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
-    aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_abort);
+    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model, &error_abort);
+    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model, &error_abort);
 
     /* Install first FMC flash content as a boot rom. */
     if (drive0) {
@@ -255,8 +255,8 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
     aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
 
-    if (cfg->i2c_init) {
-        cfg->i2c_init(bmc);
+    if (amc->i2c_init) {
+        amc->i2c_init(bmc);
     }
 
     for (i = 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
@@ -383,118 +383,141 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
                      0x60);
 }
 
-static void aspeed_machine_init(MachineState *machine)
-{
-    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
-
-    aspeed_board_init(machine, amc->board);
-}
-
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-    const AspeedBoardConfig *board = data;
 
-    mc->desc = board->desc;
     mc->init = aspeed_machine_init;
     mc->max_cpus = ASPEED_CPUS_NUM;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    if (board->ram) {
-        mc->default_ram_size = board->ram;
-    }
-    amc->board = board;
 }
 
-static const TypeInfo aspeed_machine_type = {
-    .name = TYPE_ASPEED_MACHINE,
-    .parent = TYPE_MACHINE,
-    .instance_size = sizeof(AspeedMachine),
-    .class_size = sizeof(AspeedMachineClass),
-    .abstract = true,
-};
-
-static const AspeedBoardConfig aspeed_boards[] = {
-    {
-        .name      = MACHINE_TYPE_NAME("palmetto-bmc"),
-        .desc      = "OpenPOWER Palmetto BMC (ARM926EJ-S)",
-        .soc_name  = "ast2400-a1",
-        .hw_strap1 = PALMETTO_BMC_HW_STRAP1,
-        .fmc_model = "n25q256a",
-        .spi_model = "mx25l25635e",
-        .num_cs    = 1,
-        .i2c_init  = palmetto_bmc_i2c_init,
-        .ram       = 256 * MiB,
-    }, {
-        .name      = MACHINE_TYPE_NAME("ast2500-evb"),
-        .desc      = "Aspeed AST2500 EVB (ARM1176)",
-        .soc_name  = "ast2500-a1",
-        .hw_strap1 = AST2500_EVB_HW_STRAP1,
-        .fmc_model = "w25q256",
-        .spi_model = "mx25l25635e",
-        .num_cs    = 1,
-        .i2c_init  = ast2500_evb_i2c_init,
-        .ram       = 512 * MiB,
-    }, {
-        .name      = MACHINE_TYPE_NAME("romulus-bmc"),
-        .desc      = "OpenPOWER Romulus BMC (ARM1176)",
-        .soc_name  = "ast2500-a1",
-        .hw_strap1 = ROMULUS_BMC_HW_STRAP1,
-        .fmc_model = "n25q256a",
-        .spi_model = "mx66l1g45g",
-        .num_cs    = 2,
-        .i2c_init  = romulus_bmc_i2c_init,
-        .ram       = 512 * MiB,
-    }, {
-        .name      = MACHINE_TYPE_NAME("swift-bmc"),
-        .desc      = "OpenPOWER Swift BMC (ARM1176)",
-        .soc_name  = "ast2500-a1",
-        .hw_strap1 = SWIFT_BMC_HW_STRAP1,
-        .fmc_model = "mx66l1g45g",
-        .spi_model = "mx66l1g45g",
-        .num_cs    = 2,
-        .i2c_init  = swift_bmc_i2c_init,
-        .ram       = 512 * MiB,
-    }, {
-        .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
-        .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
-        .soc_name  = "ast2500-a1",
-        .hw_strap1 = WITHERSPOON_BMC_HW_STRAP1,
-        .fmc_model = "mx25l25635e",
-        .spi_model = "mx66l1g45g",
-        .num_cs    = 2,
-        .i2c_init  = witherspoon_bmc_i2c_init,
-        .ram       = 512 * MiB,
-    }, {
-        .name      = MACHINE_TYPE_NAME("ast2600-evb"),
-        .desc      = "Aspeed AST2600 EVB (Cortex A7)",
-        .soc_name  = "ast2600-a0",
-        .hw_strap1 = AST2600_EVB_HW_STRAP1,
-        .hw_strap2 = AST2600_EVB_HW_STRAP2,
-        .fmc_model = "w25q512jv",
-        .spi_model = "mx66u51235f",
-        .num_cs    = 1,
-        .i2c_init  = ast2600_evb_i2c_init,
-        .ram       = 1 * GiB,
-    },
-};
-
-static void aspeed_machine_types(void)
+static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
 {
-    int i;
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
-    type_register_static(&aspeed_machine_type);
-    for (i = 0; i < ARRAY_SIZE(aspeed_boards); ++i) {
-        TypeInfo ti = {
-            .name       = aspeed_boards[i].name,
-            .parent     = TYPE_ASPEED_MACHINE,
-            .class_init = aspeed_machine_class_init,
-            .class_data = (void *)&aspeed_boards[i],
-        };
-        type_register(&ti);
+    mc->desc       = "OpenPOWER Palmetto BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = PALMETTO_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->default_ram_size       = 256 * MiB;
+};
+
+static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Aspeed AST2500 EVB (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = AST2500_EVB_HW_STRAP1;
+    amc->fmc_model = "w25q256";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->i2c_init  = ast2500_evb_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
+static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Romulus BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = ROMULUS_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = romulus_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
+static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Swift BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = SWIFT_BMC_HW_STRAP1;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = swift_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
+static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Witherspoon BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = WITHERSPOON_BMC_HW_STRAP1;
+    amc->fmc_model = "mx25l25635e";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = witherspoon_bmc_i2c_init;
+    mc->default_ram_size = 512 * MiB;
+};
+
+static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
+    amc->soc_name  = "ast2600-a0";
+    amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
+    amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
+    amc->fmc_model = "w25q512jv";
+    amc->spi_model = "mx66u51235f";
+    amc->num_cs    = 1;
+    amc->i2c_init  = ast2600_evb_i2c_init;
+    mc->default_ram_size = 1 * GiB;
+};
+
+static const TypeInfo aspeed_machine_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_palmetto_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("ast2500-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2500_evb_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("romulus-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_romulus_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("swift-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_swift_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_witherspoon_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("ast2600-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2600_evb_class_init,
+    }, {
+        .name          = TYPE_ASPEED_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(AspeedMachine),
+        .class_size    = sizeof(AspeedMachineClass),
+        .class_init    = aspeed_machine_class_init,
+        .abstract      = true,
     }
-}
+};
 
-type_init(aspeed_machine_types)
+DEFINE_TYPES(aspeed_machine_types)
-- 
2.20.1


