Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513432080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEqhd9bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513432080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnoyn-0008Nm-Gg
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojc-00045K-CP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnoja-0005kC-La
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id e9so10832pgo.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HSjBCHwavjNr37NIxaEpavJpEI8ou/nda9kEqEE9VlM=;
 b=HEqhd9bmGtMldVUa0JQn7/9DY2gz5OhgH9UvqeVRYPgmX+BE0q3bzOu+cYSbWGHrSo
 EgnAW9nmMBAtMZ5RgHeR5BBXP+tqZ71YgtmDXVIn/H+WSfHxNI6DPUg8Q8bQ+Ry0mKoS
 Ub/SWE/7fDyVJZ3JD1YEPOjzN3nYKcVJGpcSmsf0AU19estMucFqKX4Keo0/8k/ab6lZ
 NBIINbZQVbdejfmOOs4nKDMXSbtFUL9k+yUxp7HAeELQl2BtEShZ2M5xZ6P4CDFCIWg6
 PiHC07YjLmZchn1ioBp6tE5+GKV7ZlswhJBpGi3ZfP+ui4PqwgDwuPRGPg3zmph3IVmA
 eTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HSjBCHwavjNr37NIxaEpavJpEI8ou/nda9kEqEE9VlM=;
 b=GJsOHPaciTZIWs9yevKF2Coj15Y8JQ31xdhk6Skb+vMpYGM9D+qc0FonkI6BD5VP/9
 tarocgq23r7ryRUPl4wrMWKvmh95/wjLqNxQ2hTwgqB+JC/XWoLokYb4kk4K8yEXoKtQ
 zYniA5Q29rMoOh2rSozZBSqoN220G0wBGJm91u8B56QdS9DZkbTqbphJ8etEOEgHb4SW
 7UBEZLk0UKu45R/3Zzu6GbKeghO6j28IZVLX7rf0QgsAOHhOEJSMma5UQYfweTtSZqhm
 5qzylkOfV7vBCpyJM3/2n0PPda5WXq9XDtlh8zchVVDZSz2DiwHIQMYzge4sICy7mvI6
 c0NA==
X-Gm-Message-State: AOAM533g5Bn7Fn7FcKKwamunhz/9eC+UvXyIb1SNZfPG/uova4sUH3hT
 osERrVSjyLIKwrNwp15yOKTfryUZXbY=
X-Google-Smtp-Source: ABdhPJzkLxnCCNjsDzcNL0Z0H1VELHAnnLbe0zf3i3MDOG+6eqlSfr00Hd2R7548Czaw94YqMSxHSg==
X-Received: by 2002:aa7:84cf:: with SMTP id x15mr26135847pfn.214.1592941048926; 
 Tue, 23 Jun 2020 12:37:28 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 20/45] target/arm: Implement the access tag cache flushes
Date: Tue, 23 Jun 2020 12:36:33 -0700
Message-Id: <20200623193658.623279-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like the regular data cache flushes, these are nops within qemu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Split out and handle el0 cache ops properly.
---
 target/arm/helper.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2c6ec244af..d8c31d03da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6929,6 +6929,32 @@ static const ARMCPRegInfo mte_reginfo[] = {
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
 
@@ -6938,6 +6964,43 @@ static const ARMCPRegInfo mte_tco_ro_reginfo[] = {
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
@@ -8071,8 +8134,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
2.25.1


