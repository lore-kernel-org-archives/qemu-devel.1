Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F54C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204D9206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffnshPO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204D9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4KY-0002Y5-CB
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:59:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Jo-0006RE-TW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Jl-00043u-PS
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:30 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Jl-00041L-Bn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:29 -0400
Received: by mail-wm1-f47.google.com with SMTP id 207so838509wma.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0fHjbhgF7m8C4s1QBD+xWxolDP9qtqhdoa9wWejRTJA=;
 b=ffnshPO8F/gurxfmTl1kJFxAqyRnRzz3GJazOnwDBI3AmryIGS9I9yENWcLuF0nJc1
 no0AhXfjbx5JPDoVxUYm2BaBnQOkO9NEcD8HFn0u0IlUT4WlTfcQwhxjzj/trL55l20v
 wov3NW7eavYFMQH2GxvNUxvwP2UVTHZu5j+Zp+wQDDI9AukQ22ZwKWPXn0DiuWNmo1e3
 6XrzAUMWBEFtuEjThWUOTR8u94djcRLwcDIJ80k2svEHLMX662QjH3tJKy49uyVryZ1a
 23WnB2+xYDiqgr99H0JwvRsClJjNCTrf8ih37Vi9Mc7h2iUhwR1/DK1fG+iIP1+im+SE
 hxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0fHjbhgF7m8C4s1QBD+xWxolDP9qtqhdoa9wWejRTJA=;
 b=C+c1jz5/a3jfGkj/K5xpr+akiWLD9LZ+j7IkT6aruuI1FHEtqhAniZTz3NExbiKsKB
 +RO9gYcyQz95fDNyB31NkOIpdtgZFn/BXw6jguCNsxKChseglS6CZ0G9RxmxoIlqVcLF
 8+bt5vRsVgMAH0N4BJmdaLtYyxGA5Wr8hQ6jdxRyrXAK1FZjXL/3TXB6HEuLS9+prdAB
 7S3osVUk04zpFHVqeTmB2grGUmtHYecpU2AL7A07cp+x27Uo7aHoz8abRcDx3a+cQJ8G
 qVe/kWdrQckpUYhyMwiTdcjgjuEsZ3fmraL5Nr6PQVKPxVHvzp6ksRvEWUkb0DoJm8Vv
 kwPw==
X-Gm-Message-State: APjAAAUv8q6lNiHU5Zy19l0RiXCLFK/pTuerDNq+wb2rdy9G6MgYvAav
 pxuOxQhaGA14J/sm3DesWpe0XFGHawgRQw==
X-Google-Smtp-Source: APXvYqzhSNB/XZzcsmHGl/Rjv0Gce7PDiOczjrTi/qq/3XA4KW3S2DX40+lV9DSp5XEAOoH5S6fE3g==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr119087wme.29.1561999208877; 
 Mon, 01 Jul 2019 09:40:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:19 +0100
Message-Id: <20190701163943.22313-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.47
Subject: [Qemu-devel] [PULL 22/46] aspeed: Add support for the swift-bmc
 board
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

From: Adriana Kobylak <anoo@us.ibm.com>

The Swift board is an OpenPOWER system hosting POWER processors.
Add support for their BMC including the I2C devices as found on HW.

Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-20-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7f01df1b61d..8b6d304247c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -73,6 +73,17 @@ struct AspeedBoardState {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
+/* Swift hardware value: 0xF11AD206 */
+#define SWIFT_BMC_HW_STRAP1 (                                           \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_H_PLL_BYPASS_EN |                                           \
+        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
+
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
@@ -292,6 +303,35 @@ static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
 }
 
+static void swift_bmc_i2c_init(AspeedBoardState *bmc)
+{
+    AspeedSoCState *soc = &bmc->soc;
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552", 0x60);
+
+    /* The swift board expects a TMP275 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x48);
+    /* The swift board expects a pca9551 but a pca9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "pca9552", 0x60);
+
+    /* The swift board expects an Epson RX8900 RTC but a ds1338 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "ds1338", 0x32);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp423", 0x4c);
+    /* The swift board expects a pca9539 but a pca9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "pca9552", 0x74);
+
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "tmp423", 0x4c);
+    /* The swift board expects a pca9539 but a pca9552 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "pca9552",
+                     0x74);
+
+    /* The swift board expects a TMP275 but a TMP105 is compatible */
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
+}
+
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
@@ -382,6 +422,16 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .num_cs    = 2,
         .i2c_init  = romulus_bmc_i2c_init,
         .ram       = 512 * MiB,
+    }, {
+        .name      = MACHINE_TYPE_NAME("swift-bmc"),
+        .desc      = "OpenPOWER Swift BMC (ARM1176)",
+        .soc_name  = "ast2500-a1",
+        .hw_strap1 = SWIFT_BMC_HW_STRAP1,
+        .fmc_model = "mx66l1g45g",
+        .spi_model = "mx66l1g45g",
+        .num_cs    = 2,
+        .i2c_init  = swift_bmc_i2c_init,
+        .ram       = 512 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
-- 
2.20.1


