Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4FAC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9926820757
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 13:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="jE/9KC7a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abLfsEQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9926820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUW1f-0002FT-Pl
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 09:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <patrick@stwcx.xyz>) id 1jUTzo-0003UM-MU
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <patrick@stwcx.xyz>) id 1jUTzk-0003Gy-1I
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:38:20 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1jUTyk-0001UQ-IE; Fri, 01 May 2020 07:37:15 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.west.internal (Postfix) with ESMTP id 76C2D6D6;
 Fri,  1 May 2020 07:37:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 01 May 2020 07:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=RlHubz0soz6mBe1C41cTHUPwnq
 sH7XDvs32vgUJG6/E=; b=jE/9KC7amNuAVDe0zk95Si4Ew9ZPQ2aLpGTrAOm32C
 USMk2+KIczYYQya7HXqViv7FypdTmHZbC3yX8mFYNIGe546+Wu1Yxm1syVtfpgj4
 6KUCN5x5oevmL/kD9Q/TzxbjsFbZXL5jvIXrI+ZRSzsFFWbhQYPHQDqBVNVziTx5
 ziL56LXngGPKmEk6UYENeyOxDzXQqiDo9eujzsSyytZbUc335bMwGKGSqqKBU0bd
 8dvKEGHXLVOV4wjVLMKbCIzuzEBk6aK1s/1LPzWKnWgy6vK3U411EeaHGoXA+YiY
 cpvKMjMUCkrcgS8JF1CJXw81UR+kh5HStGGqDLxTPfvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RlHubz0soz6mBe1C4
 1cTHUPwnqsH7XDvs32vgUJG6/E=; b=abLfsEQpabKPtSz4B54+Mx1zIu1G2wtY8
 SE2VZYirB7dScFuquErVXY9OTC2lxbzYJ+e6BXoMGmF4e0NJohd3UyGwq4gl4zAg
 67+t22BRLa+Bdl98/L9zwr4Wlfd4Qo4E976fmgb9YrRo01aOND28XPsFKGjKV6gN
 +Wnye5oS87Al1oT4z4bRx4tt1kcEOgjjbuPyV01OSh8/2OzkgUVGFskp/oEJY+/E
 i6KEUyEyXg9ohX0PslefiaDcYu+yOzKCop6U7oC/Hur+TYMeyFEzTpmItmvGhEoF
 5X9U9aqUQBR4/dLPsAa+f0JKWMr1Lf4LGmX9BonSawZN1kjTCqcJg==
X-ME-Sender: <xms:5QmsXsqDGL0dVn48sXAl_JAVmpG5uwb-rNFxo_IvIfBDWRrnDiz9Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieejgdegtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenmh
 hishhsihhnghcuvffquchfihgvlhguucdlfedtmdenfghrlhcuvffnffculdefhedmnego
 vehorghsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgggf
 estdekredtredttdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgr
 thhrihgtkhesshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnheptdeggeefteejje
 eltdefvedttdfhieffvedvteefvdeljedvheeufeeggfetleffnecuffhomhgrihhnpehg
 ihhthhhusgdrtghomhenucfkphepjeeirddvhedtrdekgedrvdefieenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthif
 tgigrdighiii
X-ME-Proxy: <xmx:5QmsXvyuhD5g_nJ8oi7mYk1jtgySUqgpfd0bKxu96-LxcAM5-nJoBg>
 <xmx:5QmsXhrRdUopnJnCZWETtgZpgOQvWpm1zkRcAdn0JtBu6bPDUCpe9g>
 <xmx:5QmsXk7l2Hn9XTXOr2FwWCmbgPASVLTGXBEQnBt9YxuXSCPPYtSDjg>
 <xmx:5gmsXoKKdDmOssFKeTaBTWJn42KMb8Nj-mXf0m-k4vyFsrQc5oAAeO1AO7o>
Received: from localhost (76-250-84-236.lightspeed.austtx.sbcglobal.net
 [76.250.84.236])
 by mail.messagingengine.com (Postfix) with ESMTPA id CA9003280060;
 Fri,  1 May 2020 07:37:08 -0400 (EDT)
From: Patrick Williams <patrick@stwcx.xyz>
To: 
Subject: [PATCH] aspeed: Add support for the sonorapass-bmc board
Date: Fri,  1 May 2020 06:37:04 -0500
Message-Id: <20200501113704.2240698-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.18; envelope-from=patrick@stwcx.xyz;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 07:37:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 64.147.123.18
X-Mailman-Approved-At: Fri, 01 May 2020 09:45:19 -0400
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
 Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Patrick Williams <patrick@stwcx.xyz>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sonora Pass is a 2 socket x86 motherboard designed by Facebook
and supported by OpenBMC.  Strapping configuration was obtained
from hardware and i2c configuration is based on dts found at:

https://github.com/facebook/openbmc-linux/blob/1633c87b8ba7c162095787c988979b748ba65dc8/arch/arm/boot/dts/aspeed-bmc-facebook-sonorapass.dts

Booted a test image of http://github.com/facebook/openbmc to login
prompt.

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 hw/arm/aspeed.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a6a2102a93..09b3277d56 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -84,6 +84,21 @@ struct AspeedBoardState {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+/* Sonorapass hardware value: 0xF100D216 */
+#define SONORAPASS_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
@@ -372,6 +387,48 @@ static void swift_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
 }
 
+static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    // bus 2 :
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x49);
+    // bus 2 : pca9546 @ 0x73
+
+    // bus 3 : pca9548 @ 0x70
+
+    // bus 4 :
+    uint8_t *eeprom4_54 = g_malloc0( 8 * 1024 );
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), 0x54,
+                          eeprom4_54);
+    /* PCA9539 @ 0x76, but PCA9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x76);
+    /* PCA9539 @ 0x77, but PCA9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x77);
+
+    // bus 6 :
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x49);
+    // bus 6 : pca9546 @ 0x73
+
+    // bus 8 :
+    uint8_t *eeprom8_56 = g_malloc0( 8 * 1024 );
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), 0x56,
+                          eeprom8_56);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x61);
+    // bus 8 : adc128d818 @ 0x1d
+    // bus 8 : adc128d818 @ 0x1f
+
+    // bus 13 : pca9548 @ 0x71
+    //      - channel 3:
+    //          - tmm421 @ 0x4c
+    //          - tmp421 @ 0x4e
+    //          - tmp421 @ 0x4f
+
+}
+
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
@@ -499,6 +556,21 @@ static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size       = 512 * MiB;
 };
 
+static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER SonoraPass BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+};
+
 static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -563,6 +635,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("swift-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_swift_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_sonorapass_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.26.2


