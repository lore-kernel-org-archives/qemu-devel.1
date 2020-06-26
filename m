Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B4320702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdBPql90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B4320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq58-0003qd-AO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3l-0001pI-1W
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3j-0006BR-51
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id r12so9802804wrj.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wHkNxYOciTE2oOBZnE2EDvVEW4h7Fv9ILw3mBQCiruk=;
 b=sdBPql90cqhGYGENmHlUwo5QO5juetB+MJX9MhPVMD+Bd+fMnFm765MOi2BT05pUQV
 ywSjgexzturKX7COf3C/Qdk+T52GKzAYwqVnjNCe89ToPJfBXtaEn9NGqcu/Np5Nk48/
 nPXRP5t4fuY5tiAoqGveMN2OxgKv0YPhGiACTApDc4KCHVK2QM0lkRt6QTwgppDcSZf8
 HvHBZ/3e3Y83CapsW4ekzlKaAoQQE2tB14wy2wAUyfNhcE/8XU47qZB77UKjGTu7xxQo
 CEsP+osCjpQASS28/8vCbOC9PPH4N7ZGxlbOatzRTSzB7lkuaHMkyWEIR/E2AcdA09bV
 ojUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wHkNxYOciTE2oOBZnE2EDvVEW4h7Fv9ILw3mBQCiruk=;
 b=n6jLMHu62Nzw/WV0HXXKa+RBv6Y86pLlOCm4j3vObrwLsAqfyd83MrbMLUSwrweLpc
 DzsxfiTRO2pDEoYhnY6Hjvy1eVyPDcq3I6w0ArzXfh1hHPe58q8u85pk+IhkotsRwU0p
 8HTpb9hLpZJxGGHuCmKLmDjIfdrDPlaltlzx0HkR0/surqiQVSDGEmjm3eCnMxTri5D6
 gqiXSZtNhM/z8DT03TbUcmD18gt3hAGomRkVqO/AoE+e1fhWFGu5inYvfR2VboIHT1lI
 I5ZNR8vbQJs/A7G3cybOPctZrcyshj0yHdW/l8hCNIZVYaEeW53rEAmdm5mxAq1lacZj
 4HIw==
X-Gm-Message-State: AOAM530SMUNGNotlP0hqCvwZPeQ+DxrAM9Li7ZqVoqFjILv62rW3yB2j
 aBoBLXSIgZ8hjDUJ9AAPFTvF2oQ/0GU2Ng==
X-Google-Smtp-Source: ABdhPJyJ0vc48zedWYxR1Yu3dcPNurfI9wkJ4j5EMND/0MfIH08cQsaAGoukmQ+RwGDWcPZ4eaV7Uw==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr4274396wrq.250.1593184469311; 
 Fri, 26 Jun 2020 08:14:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/57] hw/arm/aspeed: Rename AspeedBoardState as
 AspeedMachineState
Date: Fri, 26 Jun 2020 16:13:29 +0100
Message-Id: <20200626151424.30117-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

To have a more consistent naming, rename AspeedBoardState
as AspeedMachineState.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072132.2868-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed.h |  4 ++--
 hw/arm/aspeed.c         | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 95b4daece86..5114ba0bd4f 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -11,7 +11,7 @@
 
 #include "hw/boards.h"
 
-typedef struct AspeedBoardState AspeedBoardState;
+typedef struct AspeedMachineState AspeedMachineState;
 
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
 #define ASPEED_MACHINE(obj) \
@@ -45,7 +45,7 @@ typedef struct AspeedMachineClass {
     const char *spi_model;
     uint32_t num_cs;
     uint32_t macs_mask;
-    void (*i2c_init)(AspeedBoardState *bmc);
+    void (*i2c_init)(AspeedMachineState *bmc);
 } AspeedMachineClass;
 
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 167fd5ed1c7..a167b736970 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -32,7 +32,7 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-struct AspeedBoardState {
+struct AspeedMachineState {
     AspeedSoCState soc;
     MemoryRegion ram_container;
     MemoryRegion max_ram;
@@ -253,7 +253,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
 
 static void aspeed_machine_init(MachineState *machine)
 {
-    AspeedBoardState *bmc;
+    AspeedMachineState *bmc;
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
     AspeedSoCClass *sc;
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
@@ -261,7 +261,7 @@ static void aspeed_machine_init(MachineState *machine)
     int i;
     NICInfo *nd = &nd_table[0];
 
-    bmc = g_new0(AspeedBoardState, 1);
+    bmc = g_new0(AspeedMachineState, 1);
 
     memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container",
                        4 * GiB);
@@ -374,7 +374,7 @@ static void aspeed_machine_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
-static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
+static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
     DeviceState *dev;
@@ -396,7 +396,7 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
     object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_abort);
 }
 
-static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
+static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
@@ -413,13 +413,13 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
 }
 
-static void ast2600_evb_i2c_init(AspeedBoardState *bmc)
+static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
     /* Start with some devices on our I2C busses */
     ast2500_evb_i2c_init(bmc);
 }
 
-static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
+static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
@@ -428,7 +428,7 @@ static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
 }
 
-static void swift_bmc_i2c_init(AspeedBoardState *bmc)
+static void swift_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
@@ -457,7 +457,7 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
 }
 
-static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
+static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
@@ -501,7 +501,7 @@ static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
 
 }
 
-static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
+static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
-- 
2.20.1


