Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3659C206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ijh1z3sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3659C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8gJ-0007gH-Cj
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZR-0001hJ-VS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZQ-0006zq-Qj
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id i15so10961203wrx.10
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GYv16+FW+jpblC87r0KGO4QFt+WFmyf8MHKvbTVEmDg=;
 b=Ijh1z3sq+D9151+Mz/NXmu+8kCHeXct6/EgVqRkGgZ/fmpCXXYku1MlUsHHvbVVt3t
 tPA9MngWoWOhZvfsj9reDTUoiaZ8mpHzsCM8z0ob3YFZm0rdndFPP9je6u34QNw0y7dD
 5e6vHum9aGupxMwaBzkdjKg9ylRZl4WXOKaotgyq2ZawyEmJM3rzf8b4x9D9CR6sSC46
 3unlJI2kY9U8eCwy0spjbjxNwD4cDXqwddZoZycRiCutKj5uO/+7xJHBlqbvz5FZziJc
 wijsqEGP0GN3fWEJeskc/5Uoo9dQVtzqaIjOGy2jTiiJfzat9JUuQGoGFhTkPPv9tmWT
 TLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GYv16+FW+jpblC87r0KGO4QFt+WFmyf8MHKvbTVEmDg=;
 b=MnE7MN+Tvvsez9OOxmOCnTHkVXA9dpvEQTvI23kyu02Tj+AOET5fU2vqCWPmxfi6w6
 41ph/axKrtawWRgbmqnztS2m3LYakY0Jr8X4GLU74Iqr7rDlQ5VX3K+5NGYn/WSk/YDm
 TDfgML9y2oL710DRbLK7wTpU7TjrkRtz7OL3yGIi7iZgbJ4a8WshO1c747zWCLCJOO3Z
 KuwYbpKap60YTt+xyCn071J6GSBRFGQxCqOjl/C+hDCZIeK7uimBiG0YgeL19ZsPy4t9
 mZ+iB0pBtGIgjUKHL6Qc5hKwm/cyCoFcPjb01EJd89CDR79KnhTNr+SUQDwDFDunGclD
 ekAw==
X-Gm-Message-State: AGi0PuZuABgj1K8F4VD2EO26SsxujlP+Q0d3Ld0KWDsjIlHvYBHnQHrY
 20GMg1Q0f0ZBnd1li3Q8RBtLy2Oh/+09dQ==
X-Google-Smtp-Source: APiQypJPyDRoHgQ5AArs04lp8lTbeNzu9P4rsc45/kc2elUWQ8BjrO596bIQWS0WSkd6pLPqt3ITkQ==
X-Received: by 2002:adf:a118:: with SMTP id o24mr18414516wro.330.1589204051041; 
 Mon, 11 May 2020 06:34:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/34] aspeed: Support AST2600A1 silicon revision
Date: Mon, 11 May 2020 14:33:34 +0100
Message-Id: <20200511133405.5275-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Joel Stanley <joel@jms.id.au>

There are minimal differences from Qemu's point of view between the A0
and A1 silicon revisions.

As the A1 exercises different code paths in u-boot it is desirable to
emulate that instead.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200504093703.261135-1-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h |  1 +
 hw/arm/aspeed.c              |  8 ++++----
 hw/arm/aspeed_ast2600.c      |  6 +++---
 hw/misc/aspeed_scu.c         | 11 +++++------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 1d7f7ffc159..a6739bb846b 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -41,6 +41,7 @@ typedef struct AspeedSCUState {
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
 #define AST2600_A0_SILICON_REV   0x05000303U
+#define AST2600_A1_SILICON_REV   0x05010303U
 
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a3a8cd0a58a..1eacb2fc172 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -93,7 +93,7 @@ struct AspeedBoardState {
 
 /* Tacoma hardware value */
 #define TACOMA_BMC_HW_STRAP1  0x00000000
-#define TACOMA_BMC_HW_STRAP2  0x00000000
+#define TACOMA_BMC_HW_STRAP2  0x00000040
 
 /*
  * The max ram region is for firmwares that scan the address space
@@ -585,7 +585,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
-    amc->soc_name  = "ast2600-a0";
+    amc->soc_name  = "ast2600-a1";
     amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
     amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
     amc->fmc_model = "w25q512jv";
@@ -600,8 +600,8 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
-    mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
-    amc->soc_name  = "ast2600-a0";
+    mc->desc       = "OpenPOWER Tacoma BMC (Cortex A7)";
+    amc->soc_name  = "ast2600-a1";
     amc->hw_strap1 = TACOMA_BMC_HW_STRAP1;
     amc->hw_strap2 = TACOMA_BMC_HW_STRAP2;
     amc->fmc_model = "mx66l1g45g";
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1a869e09b96..c6e0ab84ac8 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -557,9 +557,9 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
 
     dc->realize      = aspeed_soc_ast2600_realize;
 
-    sc->name         = "ast2600-a0";
+    sc->name         = "ast2600-a1";
     sc->cpu_type     = ARM_CPU_TYPE_NAME("cortex-a7");
-    sc->silicon_rev  = AST2600_A0_SILICON_REV;
+    sc->silicon_rev  = AST2600_A1_SILICON_REV;
     sc->sram_size    = 0x10000;
     sc->spis_num     = 2;
     sc->ehcis_num    = 2;
@@ -571,7 +571,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo aspeed_soc_ast2600_type_info = {
-    .name           = "ast2600-a0",
+    .name           = "ast2600-a1",
     .parent         = TYPE_ASPEED_SOC,
     .instance_size  = sizeof(AspeedSoCState),
     .instance_init  = aspeed_soc_ast2600_init,
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 9d7482a9df1..ec4fef900e2 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -431,6 +431,7 @@ static uint32_t aspeed_silicon_revs[] = {
     AST2500_A0_SILICON_REV,
     AST2500_A1_SILICON_REV,
     AST2600_A0_SILICON_REV,
+    AST2600_A1_SILICON_REV,
 };
 
 bool is_supported_silicon_rev(uint32_t silicon_rev)
@@ -649,12 +650,10 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
     .valid.unaligned = false,
 };
 
-static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
-    [AST2600_SILICON_REV]       = AST2600_SILICON_REV,
-    [AST2600_SILICON_REV2]      = AST2600_SILICON_REV,
-    [AST2600_SYS_RST_CTRL]      = 0xF7CFFEDC | 0x100,
+static const uint32_t ast2600_a1_resets[ASPEED_AST2600_SCU_NR_REGS] = {
+    [AST2600_SYS_RST_CTRL]      = 0xF7C3FED8,
     [AST2600_SYS_RST_CTRL2]     = 0xFFFFFFFC,
-    [AST2600_CLK_STOP_CTRL]     = 0xEFF43E8B,
+    [AST2600_CLK_STOP_CTRL]     = 0xFFFF7F8A,
     [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
     [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
     [AST2600_HPLL_PARAM]        = 0x1000405F,
@@ -684,7 +683,7 @@ static void aspeed_2600_scu_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED 2600 System Control Unit";
     dc->reset = aspeed_ast2600_scu_reset;
-    asc->resets = ast2600_a0_resets;
+    asc->resets = ast2600_a1_resets;
     asc->calc_hpll = aspeed_2500_scu_calc_hpll; /* No change since AST2500 */
     asc->apb_divider = 4;
     asc->nr_regs = ASPEED_AST2600_SCU_NR_REGS;
-- 
2.20.1


