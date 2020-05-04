Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB76C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878F2206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqn5MD4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878F2206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXZV-0004Uh-Ka
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jVXXI-0003lI-Lh; Mon, 04 May 2020 05:37:16 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jVXXH-0005ra-53; Mon, 04 May 2020 05:37:16 -0400
Received: by mail-pl1-x643.google.com with SMTP id w3so6572551plz.5;
 Mon, 04 May 2020 02:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=06iusrkV5TpGH4DaJ9RUlK/fP47vySq6Tpk1tAQL5IE=;
 b=Bqn5MD4ThwgU3h3nSVM2+jHYDzpJ2lW8xr9LMn/KHnJIrcUYGlejkR5uOuXyjvc6tE
 8Ko0MdY5SfkOvm5TDf7sEnkxU9ZLb8rQyTXo9rC/Nxs3Iy3VJI94lP4MutacETQ4PgMz
 /wHiDhTf1C/FzHIBDblg4Ql59Ts5f6WqWxEpuPz1uMfN1yXEXzpcYplZuwUhN8tFZ8n9
 qGNKw188aA4wA4qjsqU418/66bgz4xRPbMj5E2cDKPiifDjHHcChQ2zntJQFu0RxGHqI
 J/Pl9aSs8wa0UzmWcCXOttzr9pCKMX7rCewEmcldVgYX0huC7OOH/bH6HropytYFU3L9
 9PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=06iusrkV5TpGH4DaJ9RUlK/fP47vySq6Tpk1tAQL5IE=;
 b=JCmsPIKWBmSPSdOUF89cn84h9BNuj3VYdWbZbGcxa9Ik9e0UJfgi+6tA5sjCs6y1QO
 smP/zZ0JiLJD67fHKAa4yoiDTvVCK7yZtLOIRYzgwFLvUdvVW8XYXoq8mmmQkmr10XSH
 ffEjDzgoswxoM7m6YxH8dQc0sUXzuR5ycP5at3LGPdtYj39J8lD/H1adgcHMZ1oC3jHo
 A10ZFHrYFwQw/V/zCmzOvzVWRLLqlob6I5RxteLv3hsH/QzRvAhIFxwP0bJkFlYYajaO
 jxty2dOekW8wMMk88+GgBmXGsKnRz7Fnlh8Jx3OUfwmWbRa96oBrQ1KQwMxd97Abnsv8
 AZ7Q==
X-Gm-Message-State: AGi0PuZkzo9njDdpFt//zw0xQcI4UVazCgPNd1sM/nmT6adzqut5ZsTA
 gTHZ6Dy721Tfo4OfOuXbyfI=
X-Google-Smtp-Source: APiQypJuFqN7+zWl4GZt764IoFvZpTdfxy7pUwTNz0E49V438HW6Mr1222aVoHHiu7tcLeX0RI3KZg==
X-Received: by 2002:a17:902:b18d:: with SMTP id
 s13mr16967427plr.240.1588585033017; 
 Mon, 04 May 2020 02:37:13 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id h13sm5767210pgm.69.2020.05.04.02.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:37:12 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] aspeed: Support AST2600A1 silicon revision
Date: Mon,  4 May 2020 19:07:03 +0930
Message-Id: <20200504093703.261135-1-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are minimal differences from Qemu's point of view between the A0
and A1 silicon revisions.

As the A1 exercises different code paths in u-boot it is desirable to
emulate that instead.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed.c              |  8 ++++----
 hw/arm/aspeed_ast2600.c      |  6 +++---
 hw/misc/aspeed_scu.c         | 11 +++++------
 include/hw/misc/aspeed_scu.h |  1 +
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 99a0f3fcf36e..91301efab32d 100644
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
index 1a869e09b96a..c6e0ab84ac86 100644
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
index 9d7482a9df19..ec4fef900e27 100644
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
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 1d7f7ffc1598..a6739bb846b6 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -41,6 +41,7 @@ typedef struct AspeedSCUState {
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
 #define AST2600_A0_SILICON_REV   0x05000303U
+#define AST2600_A1_SILICON_REV   0x05010303U
 
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
 
-- 
2.26.2


