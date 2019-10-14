Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831CC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20C320663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/6VbhgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20C320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Pi-0001cc-G6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qc-00053N-OA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qb-00084n-9G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qb-00084D-2V
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id y18so10928108wrn.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dxXU4mpzkxcQwcn/SZR487jhjpUk6sYg7UJhmpV7TT4=;
 b=y/6VbhgKZ+kBx3TdLojOW9FX/0guzq9J6n+8Fg6D7e5VxhV1/VFuRTETHfM9sDmPcr
 gortuSkRJCflkrZck3fI5P4aOMiCHm8CS0Ant3UMen/vSmeaH6e6Y169B3BCne2qJc+D
 AsAG9EDE6kquOGPYLxa1a1a0AmxZfQ+PP8ZVqWYlPytzOf8rPr2P5i3q66hl+mY/rRPJ
 /2dZRRJzvnKsvf2R1JHgTZuO3w40BIOALMDcp6RFLRWuwSIJPue8o5vdwrEU82rbfnA/
 yQ7hpkCWGC7uwBEXZlTbLx3c6khKKGgWjwlTOkTe2ZuDtm3fgk3liumqUAtNQUPjvQZ9
 m0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dxXU4mpzkxcQwcn/SZR487jhjpUk6sYg7UJhmpV7TT4=;
 b=ZnjClMT28UzSEKdxpDjscs1eqtnk13fnvP/SnkNs2/frPynU0K+cMPNBzOLL8GHK7c
 17GiW7VFNhh7D8d1j3IWDnPz6pU4w/cny8kxBSbgigHz9mCa82tLNCRGNUr1lizvlcuz
 Wl4f+R7cLiYE7t/NL9U2jnsVBIw6l/k49UnXPCrAmg0TRoA5bl46draI9htL+U7UyK7Y
 effMUsRu6tGg/Kn6NddyhHyYm/D5oDY0FWr6htHGsk8xH3OHjNXj7AjteDVn6F3xLUum
 kQrraccSkhny6ZRYGaxyUW5aSHhDRwPGvdMBPmGqvM/KcizDb5m57oT755j6m4n28F2K
 IFpA==
X-Gm-Message-State: APjAAAUp86/RkiVeJe3EBi91UKUJ8SPUIrl7KZbQ77leCzjf/4xfAJ0U
 89K3sMb5yZSkzuq1UwIbGtViV6F+onvJ0A==
X-Google-Smtp-Source: APXvYqyGeDJOSMc9iyVs1Sk3lnGG0oWTLW0nKnTLwHATtL0+uh5xgeXb9tI8Wa6U/98Pmu6/Df0ifw==
X-Received: by 2002:adf:f188:: with SMTP id h8mr26235574wro.38.1571069123766; 
 Mon, 14 Oct 2019 09:05:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/68] aspeed/sdmc: Add AST2600 support
Date: Mon, 14 Oct 2019 17:03:44 +0100
Message-Id: <20191014160404.19553-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

From: Joel Stanley <joel@jms.id.au>

The AST2600 SDMC controller is slightly different from its predecessor
(DRAM training). Max memory is now 2G on the AST2600.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-10-clg@kaod.org
[clg: - improved commit log
      - reworked model integration into new object class ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_sdmc.h |  1 +
 hw/misc/aspeed_scu.c          |  2 +
 hw/misc/aspeed_sdmc.c         | 82 +++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 81156320c49..5dbde59fe77 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -15,6 +15,7 @@
 #define ASPEED_SDMC(obj) OBJECT_CHECK(AspeedSDMCState, (obj), TYPE_ASPEED_SDMC)
 #define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
 #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
+#define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
 
 #define ASPEED_SDMC_NR_REGS (0x174 >> 2)
 
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 84699b78d4c..717509bc546 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -99,6 +99,7 @@
 #define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
 #define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
 #define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
+#define AST2600_SDRAM_HANDSHAKE   TO_REG(0x100)
 #define AST2600_HPLL_PARAM        TO_REG(0x200)
 #define AST2600_HPLL_EXT          TO_REG(0x204)
 #define AST2600_MPLL_EXT          TO_REG(0x224)
@@ -602,6 +603,7 @@ static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_SYS_RST_CTRL2]     = 0xFFFFFFFC,
     [AST2600_CLK_STOP_CTRL]     = 0xEFF43E8B,
     [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
+    [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
     [AST2600_HPLL_PARAM]        = 0x1000405F,
 };
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 60c99e77348..f3a63a2e01d 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -28,6 +28,7 @@
 /* Control/Status Register #1 (ast2500) */
 #define R_STATUS1         (0x60 / 4)
 #define   PHY_BUSY_STATE      BIT(0)
+#define   PHY_PLL_LOCK_STATUS BIT(4)
 
 #define R_ECC_TEST_CTRL   (0x70 / 4)
 #define   ECC_TEST_FINISHED   BIT(12)
@@ -85,6 +86,11 @@
 #define     ASPEED_SDMC_AST2500_512MB       0x2
 #define     ASPEED_SDMC_AST2500_1024MB      0x3
 
+#define     ASPEED_SDMC_AST2600_256MB       0x0
+#define     ASPEED_SDMC_AST2600_512MB       0x1
+#define     ASPEED_SDMC_AST2600_1024MB      0x2
+#define     ASPEED_SDMC_AST2600_2048MB      0x3
+
 #define ASPEED_SDMC_AST2500_READONLY_MASK                               \
     (ASPEED_SDMC_HW_VERSION(0xf) | ASPEED_SDMC_CACHE_INITIAL_DONE |     \
      ASPEED_SDMC_AST2500_RESERVED | ASPEED_SDMC_VGA_COMPAT |            \
@@ -186,6 +192,28 @@ static int ast2500_rambits(AspeedSDMCState *s)
     return ASPEED_SDMC_AST2500_512MB;
 }
 
+static int ast2600_rambits(AspeedSDMCState *s)
+{
+    switch (s->ram_size >> 20) {
+    case 256:
+        return ASPEED_SDMC_AST2600_256MB;
+    case 512:
+        return ASPEED_SDMC_AST2600_512MB;
+    case 1024:
+        return ASPEED_SDMC_AST2600_1024MB;
+    case 2048:
+        return ASPEED_SDMC_AST2600_2048MB;
+    default:
+        break;
+    }
+
+    /* use a common default */
+    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
+                s->ram_size);
+    s->ram_size = 512 << 20;
+    return ASPEED_SDMC_AST2600_512MB;
+}
+
 static void aspeed_sdmc_reset(DeviceState *dev)
 {
     AspeedSDMCState *s = ASPEED_SDMC(dev);
@@ -340,11 +368,65 @@ static const TypeInfo aspeed_2500_sdmc_info = {
     .class_init = aspeed_2500_sdmc_class_init,
 };
 
+static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
+{
+    uint32_t fixed_conf = ASPEED_SDMC_HW_VERSION(3) |
+        ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
+        ASPEED_SDMC_DRAM_SIZE(ast2600_rambits(s));
+
+    /* Make sure readonly bits are kept (use ast2500 mask) */
+    data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
+
+    return data | fixed_conf;
+}
+
+static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
+                                   uint32_t data)
+{
+    switch (reg) {
+    case R_CONF:
+        data = aspeed_2600_sdmc_compute_conf(s, data);
+        break;
+    case R_STATUS1:
+        /* Will never return 'busy'. 'lock status' is always set */
+        data &= ~PHY_BUSY_STATE;
+        data |= PHY_PLL_LOCK_STATUS;
+        break;
+    case R_ECC_TEST_CTRL:
+        /* Always done, always happy */
+        data |= ECC_TEST_FINISHED;
+        data &= ~ECC_TEST_FAIL;
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] = data;
+}
+
+static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
+
+    dc->desc = "ASPEED 2600 SDRAM Memory Controller";
+    asc->max_ram_size = 2048 << 20;
+    asc->compute_conf = aspeed_2600_sdmc_compute_conf;
+    asc->write = aspeed_2600_sdmc_write;
+}
+
+static const TypeInfo aspeed_2600_sdmc_info = {
+    .name = TYPE_ASPEED_2600_SDMC,
+    .parent = TYPE_ASPEED_SDMC,
+    .class_init = aspeed_2600_sdmc_class_init,
+};
+
 static void aspeed_sdmc_register_types(void)
 {
     type_register_static(&aspeed_sdmc_info);
     type_register_static(&aspeed_2400_sdmc_info);
     type_register_static(&aspeed_2500_sdmc_info);
+    type_register_static(&aspeed_2600_sdmc_info);
 }
 
 type_init(aspeed_sdmc_register_types);
-- 
2.20.1


