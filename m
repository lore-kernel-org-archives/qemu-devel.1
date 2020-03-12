Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4ADC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D55920637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4FT5zQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D55920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTyc-0007Ui-OO
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjI-0005c4-62
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjF-00028y-Ne
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:52 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjF-000284-GY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:49 -0400
Received: by mail-pl1-x643.google.com with SMTP id d9so3055668plo.11
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YjtJPrBKwGIvW5n3TsllLnWEtrw5AerlDizUV5C1Mio=;
 b=m4FT5zQa3+2PDG4aTJr/jboc8d20BX16tFdynHRW64k3e+NcDanVhWydFLIHECq4r3
 6zL55z1NS+6MDbP0DC4Epz6NJn9poq8ZFF2JsKNq5PcVR3jimQPVtm+0tHGOlvHzEMYN
 gbGSJacz4VvS4f+9oXIIu5N4O/tjqyAf/Wh0ouYFhp43o28itwkUMJcWx6GhCe4A3iDe
 +0yZJ919GGm6N8WnrgYg5ubcM0osfsvG4AtXLLT5Z23xPoJwvUOuSxzfsiCZNmSPAQid
 eEjzq+ev9H5iZZZ49DHt+TbJDkqoYqXY3KmYm9vbRl+3Wsz6ZWbi5rVbttRPkJT8Lbjg
 lwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YjtJPrBKwGIvW5n3TsllLnWEtrw5AerlDizUV5C1Mio=;
 b=HJhnazvGgslXhEg5VCnTYtMDzWIdTkY5THNgZBzmh9GuEMbNkXT6SS93yjCJP+9sg4
 bhnrMEnpkXFWpwuuJXaKJ1ccfrUCBqjgMO8g+5KJSz0qjgAbmk8ri82ciYxacVhpSv/3
 +noHvybxPCVty/rI6Fkcgec9y8t7IMd9kXpuoo45oYNgYDgceT+goC+eIiku0RmzF77o
 /ApG3cmsC2pVKC1kqltX/xYXArktxWH9oYu1bM7vqAObA0s3wfgmSjdcza2NXc2Wsvow
 4ciWF56GsXLas6irRy1VFqbAHqpkXLPJMrrbTHMulqwruKNPeVmUYRLkE9pG9hbRfBpD
 ns7A==
X-Gm-Message-State: ANhLgQ303QsmaLNte1aRvZpiwhV3F7c6YHlIAVcz0sN+4VLlEAGmuNNN
 n1KS7nYPS9GmlBJossAx+7XaeLbArI4=
X-Google-Smtp-Source: ADFU+vvi+YFkyWTEp07dU9Wrw07CRP+KH+fQFpTxhNofPmPZMFVaipfPsihnsLBqHZlagtau/52AJQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id
 v6mr9797215plp.304.1584042168194; 
 Thu, 12 Mar 2020 12:42:48 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 20/42] target/arm: Implement the access tag cache flushes
Date: Thu, 12 Mar 2020 12:41:57 -0700
Message-Id: <20200312194219.24406-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like the regular data cache flushes, these are nops within qemu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Split out and handle el0 cache ops properly.
---
 target/arm/helper.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 01d2fcf2e3..f9daeec1f4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6914,6 +6914,32 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
       .type = ARM_CP_NO_RAW,
       .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
+    { .name = "DC_IGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_IGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_IGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_IGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CIGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CIGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     REGINFO_SENTINEL
 };
 
@@ -6923,6 +6949,43 @@ static const ARMCPRegInfo mte_tco_ro_reginfo[] = {
       .type = ARM_CP_CONST, .access = PL0_RW, },
     REGINFO_SENTINEL
 };
+
+static const ARMCPRegInfo mte_el0_cacheop_reginfo[] = {
+    { .name = "DC_CGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGDVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGDVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CIGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CIGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    REGINFO_SENTINEL
+};
+
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8048,8 +8111,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
      */
     if (cpu_isar_feature(aa64_mte, cpu)) {
         define_arm_cp_regs(cpu, mte_reginfo);
+        define_arm_cp_regs(cpu, mte_el0_cacheop_reginfo);
     } else if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
         define_arm_cp_regs(cpu, mte_tco_ro_reginfo);
+        define_arm_cp_regs(cpu, mte_el0_cacheop_reginfo);
     }
 #endif
 
-- 
2.20.1


