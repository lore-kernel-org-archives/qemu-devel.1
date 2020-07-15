Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463F520656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3G9WBFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463F520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlJo-0004CO-JQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 13:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jvlIk-0003Mf-Ar; Wed, 15 Jul 2020 13:34:38 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jvlIi-0001Rx-P8; Wed, 15 Jul 2020 13:34:38 -0400
Received: by mail-ej1-x642.google.com with SMTP id y10so3028915eje.1;
 Wed, 15 Jul 2020 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mDwbCN9yjsk1F2HEUNwJjOblG385ZeYj6mp/MWdq+VM=;
 b=T3G9WBFi/XMpxJdYEdOm8wSdxTn2LFGFgNP/i3nK+EMwaJY0VGg9GYEwFhziWixN/5
 gso0AP4cErFk6jvkD+V4x8I4rWtSGMdYJJARNUfdtGYNqjFEa8dzrl6IY4MgaEcBEMkx
 IyIO4tYQz92cuGJRhKDsnHXxjtwVWBym6cHIz4ERtE5kOq8RUgssgAS/nlKlcDm7ItMX
 O58TtQvRwFKjr5RNjm9AexpnxmJVKenygi1RE7HymZ+2e7hKrimJg7OB4DgaLng2E1So
 BNXPtCqn8o/0TLegz41bBZAcYZizjcUufr2KlTv9nDpEjJS8juQedvYJCRZE2TXk7o0l
 8U8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mDwbCN9yjsk1F2HEUNwJjOblG385ZeYj6mp/MWdq+VM=;
 b=tNpV1UK5JjB/5ME/eVGQ8VGkxF83O/xUgUnGcRBLzcEbqrfr6TbxDBO3r8dn0obT8l
 1qd9UmkjqDAulUwnds/PaVxlkcAAehfsoZ3hc0/xCoNZRpR3T9AZ+Xnsp8iKqi4MAqHU
 ULg/slrPeVHTz5hz3eVnDMmjsKbpmB3Mv0zeUjTCjv682siOvDaEthuWtf410B7IDTD3
 P7kKMkizWJOPMqPXqKD34z5HZxpmDHhZjqRI26xmK5puimx5xmfHKB5fX5DYZyZ0NLV6
 tw1urFzPUvYF+bjdibRhbNAuDALNHqsOLV8O5395eAvJ0sYQr0NjxHWzWmLy1aIF23E+
 hg+w==
X-Gm-Message-State: AOAM531gLLDnxatYffVmVBo+V+tnd4q+eaM1v8QRnk5oJusjLXjWgKQw
 o5HZgq6oRiJF9wtaOIMUTd4=
X-Google-Smtp-Source: ABdhPJxV0XFXjyRaEhUnSJVXibhZEPGdrHymsRSbGd5GH0POlR3CFr3V/lVWnAzcXyfxFnE6OoqvQA==
X-Received: by 2002:a17:906:ce32:: with SMTP id
 sd18mr85051ejb.228.1594834474780; 
 Wed, 15 Jul 2020 10:34:34 -0700 (PDT)
Received: from Tank.localdomain (82-73-161-131.cable.dynamic.v4.ziggo.nl.
 [82.73.161.131])
 by smtp.gmail.com with ESMTPSA id s1sm2736667edy.1.2020.07.15.10.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:34:34 -0700 (PDT)
From: erik-smit <erik.lucas.smit@gmail.com>
To: 
Subject: [PATCH v2] hw/arm/aspeed: Add board model for Supermicro X11 BMC
Date: Wed, 15 Jul 2020 19:34:18 +0200
Message-Id: <20200715173418.186-1-erik.lucas.smit@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ej1-x642.google.com
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
---
Changed in v2:
 - matched aspeed_machine_supermicrox11_bmc_class_init function name to
   machine name

 hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 379f9672a5..ef042471be 100644
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
@@ -600,6 +614,23 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
 
+static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
+                                                        void *data)
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
@@ -728,6 +759,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.25.1


