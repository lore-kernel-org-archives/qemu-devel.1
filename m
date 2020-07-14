Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E46C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC912064B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG4vUJ/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC912064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRfw-0004cB-1K
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jvRet-0003dO-P4; Tue, 14 Jul 2020 16:36:11 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jvRes-0000l2-3U; Tue, 14 Jul 2020 16:36:11 -0400
Received: by mail-ej1-x641.google.com with SMTP id rk21so24369340ejb.2;
 Tue, 14 Jul 2020 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ng3RgguGDWVhvWuBBD4e16/bRgrWRGoknea1tRRkQhI=;
 b=IG4vUJ/f5d/d+9rQDMRSLa3aYjn7VUTntTxLfub32Qjg/9h6KkNHKnonetUI0LAGVY
 O3hDDJl3zA9zKw/lRSGtzegZnfBkXHvJbGH1AbDbJNh/OoblWkbKfCTVVDaDzCcAx5oq
 cHrLRy/0ceq2bRmz3763utTYfhpENy1o/5ZbONU3GaKG372lfzOBC5WtE/Ez5hGwVA55
 Rb6bDkuTrjcZLWmuEDePRNgKbP+3cj4cqgkh1yV73g2Q/529i69yVufrDoIHFrN/wEGp
 kn/uUPP4SbWtfsxzC/gyM+oVP2D5Kfd5X786tf5iQlHwkFtOuZV3EGzHDE+zjS7vybJg
 R1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ng3RgguGDWVhvWuBBD4e16/bRgrWRGoknea1tRRkQhI=;
 b=dXvaVl02QRU/6+zsUDx8Qc55Ahb0r/j7i5QJliqTHCQ9bKZmUtWsWS9o3i1u91q3MH
 fybkDmJ0rV/oN4A89QA4DwaFtTf2RdTFREN/rZbgaetkTfMRZlgjrzQy+M7/Um3PnIeG
 ovb4BB5LG06OIEpl2veAS9LMfbAwOOsFwWSQ1PfAGk1j44f4Kc2TBgbbRIKttLchMDJr
 Vot/qMxOgJ9JJgGdvkSlK2QgFabG1v/4cPp4xZLiSITB1825MlAnx2MK8MNqdLmDyHOq
 YuML4+ciIvq8E9H935rw+F5iE1car+EpPJhxEhCyCWpBMpg59vxbUar8T1ftlXhvRlfg
 nBRg==
X-Gm-Message-State: AOAM5333xr20hQ3n8XPqLsKs2gizYBY4lg0aiC/YLMtAgUnpByyK+ZdQ
 kBnJcBUFck59RVZg33namNc=
X-Google-Smtp-Source: ABdhPJw2GUOCc0AuULh4O0s8K2vsoM6+3cLPWZoaTZFCzUGPXHd+5laAIX4ZHoBoEdWKNljn+22eog==
X-Received: by 2002:a17:906:c1c3:: with SMTP id
 bw3mr6569151ejb.8.1594758967519; 
 Tue, 14 Jul 2020 13:36:07 -0700 (PDT)
Received: from Tank.localdomain (82-73-161-131.cable.dynamic.v4.ziggo.nl.
 [82.73.161.131])
 by smtp.gmail.com with ESMTPSA id a2sm15270169edt.48.2020.07.14.13.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 13:36:06 -0700 (PDT)
From: erik-smit <erik.lucas.smit@gmail.com>
To: 
Subject: [PATCH] hw/arm/aspeed: Add board model for Supermicro X11 BMC
Date: Tue, 14 Jul 2020 22:36:04 +0200
Message-Id: <20200714203604.5676-1-erik.lucas.smit@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 erik-smit <erik.lucas.smit@gmail.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
-- 
checkpatch was complaining about the length of
aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc, void *data)

so I renamed it to aspeed_machine_smx11_bmc_class_init. Not sure if
that's the right way to go, since then it's out of sync with the machine
name "supermicrox11-bmc". But renaming the machine name to "smx11-bmc"
makes it less descriptive...

---
 hw/arm/aspeed.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 379f9672a5..e74a89f427 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -57,6 +57,20 @@ struct AspeedMachineState {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
+/* TODO: Find the actual hardware value */
+#define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
+        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
+        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2) |                           \
+        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
+        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
+        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
+        SCU_HW_STRAP_SPI_WIDTH |                                        \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
+
 /* AST2500 evb hardware value: 0xF100C2E6 */
 #define AST2500_EVB_HW_STRAP1 ((                                        \
         AST2500_HW_STRAP1_DEFAULTS |                                    \
@@ -600,6 +614,22 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
 
+static void aspeed_machine_smx11_bmc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Supermicro X11 BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = SUPERMICROX11_BMC_HW_STRAP1;
+    amc->fmc_model = "mx25l25635e";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->default_ram_size = 256 * MiB;
+}
+
 static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -728,6 +758,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_smx11_bmc_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.25.1


