Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBCA2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlbodbLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBCA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndGc-0001pI-4S
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFU-0007ao-Hk; Tue, 23 Jun 2020 03:21:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndFT-0003En-0G; Tue, 23 Jun 2020 03:21:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id o11so11634922wrv.9;
 Tue, 23 Jun 2020 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dd/Qy10e7uzdwPtNIyee34OCbZGBAytVsTY9nRrII0k=;
 b=nlbodbLnP0O6rZ1E7sjQ0qNOyOHkjOCfihgu7mKNTIJVKymgaPIwIpBqqX5fw1ZLTb
 04B4jNwsbSYdqlD1iEvZU+yaCZtHQpHGC6UGH2bXO9KMOAfc+WgCtl9SOJct2hl6dnOA
 nsoUKE0f+akX5N5aTStNqcX45WsFYhBmoawq3w2YyBwwQfAYcTieuB7oC8g19atiyBuc
 pNWT1FD81QzrJA0onU6qIMEBkQF+pqiDFT98RmS1s1Ktj7tj+A6+u1RRHLKqh9gzPzDH
 Xb+ZfMIj3yojD7tceC3nmKg+hYYiuoQQttCFgZDnXuLWKW6XJvua/qCPBC3Rut2+545t
 W9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dd/Qy10e7uzdwPtNIyee34OCbZGBAytVsTY9nRrII0k=;
 b=unydSbgt7br++zXtx1+dSR+y95mfjVdb0YmBjpf1ud2NGa8asfHCi2Sr+/OeUUnXag
 2M9pm67jyD7ziDN+oSYM/A5gVB1l71G77ouB+tlftu3Q74RmYLTBBLy2Nz7DPEhYafq3
 a9CYGCdDa6D6wl8p1cv8OSSMnHfIeP9zA2vgMnr0e6/1CxY7yN1HiOrLr1uYgYuFj4Fy
 nbRmq3QC9V9NjYmVkC1n17EOe3Axoh8D+eU407yWAB6UZJWu5YvGwn7CM8HXwfiAhtf3
 d5BN5YHUv296uBa3cbhgZsQcNjOt0ctpm2B49y/FPmGmAfxu53a4U7PcF2ncOvUmTa3S
 O1Yw==
X-Gm-Message-State: AOAM533o6y7LC6raLGOHq5hX5Tq/kCVqlwoQhBTkliAp9G2ibNTu1JXm
 QxAiF6nzscgu5I1aTCQXw9mZFVbi
X-Google-Smtp-Source: ABdhPJyYo2DW714pagJWSomnKpw8bW/3/JYs+yLN+mJYXuygctJe8jMKhdpDDEBh+d5Rp/mAMdVsuw==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr11854640wrq.263.1592896897105; 
 Tue, 23 Jun 2020 00:21:37 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x13sm21877236wre.83.2020.06.23.00.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:21:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/arm/aspeed: Rename AspeedBoardState as
 AspeedMachineState
Date: Tue, 23 Jun 2020 09:21:31 +0200
Message-Id: <20200623072132.2868-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072132.2868-1-f4bug@amsat.org>
References: <20200623072132.2868-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To have a more consistent naming, rename AspeedBoardState
as AspeedMachineState.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/aspeed.h |  4 ++--
 hw/arm/aspeed.c         | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 95b4daece8..5114ba0bd4 100644
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
index 31765792a2..680345beca 100644
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
2.21.3


