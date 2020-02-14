Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B40C47409
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962A72467B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqVXLRHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962A72467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fYi-0001lu-Jd
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVb-0004gX-B0
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVZ-0000J9-Ej
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:11 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVZ-0000IX-6u
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:09 -0500
Received: by mail-pf1-x442.google.com with SMTP id s1so5247084pfh.10
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3XMTldT5aciMedkzJMCvbzI5Oq2p1yxlgK/fC8SFtRE=;
 b=DqVXLRHk2AH0TOk9roOM71XK1ogP/3Ai25uA6tTNypXI41T+M+J6t/afMcMMWYNAFV
 vHCuUhb6oWtcvads4BwBg8CUiJLn3SdfcGAvfpwKW086+rMgpawqDdfzcg4j+1JGRjqq
 v3hSfOOnZc/T1k+g6ONKUIISblkvzsiApDj2HoSIcjR/ol9mHLMou9P+jz1bcl4lg3og
 jkj2JHfz/xPB0Po+AWvSp+pIBFNKVZMeo9D6sz+qTcf/LBS8Eq6ricOWESWdySNx6xDW
 rIdzHWw3+v9t62EZ8LaTb+vqWzBqgTWtvuFPhzVzigcLetR/Zi4+Fxi9ZJaJEyP6icvi
 yU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3XMTldT5aciMedkzJMCvbzI5Oq2p1yxlgK/fC8SFtRE=;
 b=LMC/Ahgq93SpcYPXo0ayD8THGND8SA65yRY5V+pl8fXiB2yXmfFBegNlZU4SqmGMdb
 DHhOUlddnimnTYU1MSnyoEhJGIQYTRSXc+zggVXkwOTAZCZZh7eLYoiWzLbC2ZJzWyqo
 X/oc3JJuo9AAI6JJY4QDOxbkqMQUwqbMZf46l0hxPGr1hMOHf+CILvstX14bv48Lmci2
 NAJRlJRR1sIo8i1vaXFoaYDB8x6iZOwjco5+dkAXvBNUCxZkzMW/IEOMk68NBb3BHvAg
 pt/KT07K3Y6TvwKCIYiUbIDC18GsX74uHsYfh1/36yCiRbg4JSwvm/t2uYRoFrVYx0hC
 lAjg==
X-Gm-Message-State: APjAAAWDMyZCnNnBGRnSp/o0Bin4Xdx1R+I2+yYch/hB+kBBHLM553C6
 kbOMAHFXwOydT//65ITLrmbaKOFUlq4=
X-Google-Smtp-Source: APXvYqyDDAOefOCF3M6oXuZnQJF/qDYLF7jsv+s0EzVE10xGYNmv6nQYq2/Xl0Kgxp4531rlMgYzBg==
X-Received: by 2002:a63:242:: with SMTP id 63mr4685514pgc.84.1581704167558;
 Fri, 14 Feb 2020 10:16:07 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/19] target/arm: Remove ARM_FEATURE_VFP*
Date: Fri, 14 Feb 2020 10:15:44 -0800
Message-Id: <20200214181547.21408-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have converted all tests against these features
to ISAR tests.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   |  3 ---
 target/arm/cpu.c   | 25 -------------------------
 target/arm/cpu64.c |  3 ---
 target/arm/kvm32.c |  5 -----
 target/arm/kvm64.c |  1 -
 5 files changed, 37 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f27b8e35df..571038d0de 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1858,7 +1858,6 @@ QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
  * mapping in linux-user/elfload.c:get_elf_hwcap().
  */
 enum arm_features {
-    ARM_FEATURE_VFP,
     ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
     ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
     ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
@@ -1867,7 +1866,6 @@ enum arm_features {
     ARM_FEATURE_V7,
     ARM_FEATURE_THUMB2,
     ARM_FEATURE_PMSA,   /* no MMU; may have Memory Protection Unit */
-    ARM_FEATURE_VFP3,
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
@@ -1878,7 +1876,6 @@ enum arm_features {
     ARM_FEATURE_V5,
     ARM_FEATURE_STRONGARM,
     ARM_FEATURE_VAPA, /* cp15 VA to PA lookups */
-    ARM_FEATURE_VFP4, /* VFPv4 (implies that NEON is v2) */
     ARM_FEATURE_GENERIC_TIMER,
     ARM_FEATURE_MVFR, /* Media and VFP Feature Registers 0 and 1 */
     ARM_FEATURE_DUMMY_C15_REGS, /* RAZ/WI all of cp15 crn=15 */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8d3eff8cb3..afb80d4636 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1208,13 +1208,6 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
         set_feature(&cpu->env, ARM_FEATURE_PMSA);
     }
-    /* Similarly for the VFP feature bits */
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP4)) {
-        set_feature(&cpu->env, ARM_FEATURE_VFP3);
-    }
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP3)) {
-        set_feature(&cpu->env, ARM_FEATURE_VFP);
-    }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
@@ -1440,10 +1433,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         uint64_t t;
         uint32_t u;
 
-        unset_feature(env, ARM_FEATURE_VFP);
-        unset_feature(env, ARM_FEATURE_VFP3);
-        unset_feature(env, ARM_FEATURE_VFP4);
-
         t = cpu->isar.id_aa64isar1;
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
         cpu->isar.id_aa64isar1 = t;
@@ -1855,7 +1844,6 @@ static void arm926_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm926";
     set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
     cpu->midr = 0x41069265;
@@ -1896,7 +1884,6 @@ static void arm1026_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1026";
     set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
@@ -1944,7 +1931,6 @@ static void arm1136_r2_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
@@ -1976,7 +1962,6 @@ static void arm1136_initfn(Object *obj)
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
     set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
@@ -2007,7 +1992,6 @@ static void arm1176_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1176";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
@@ -2040,7 +2024,6 @@ static void arm11mpcore_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm11mpcore";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_MPIDR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
@@ -2106,7 +2089,6 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
     cpu->isar.mvfr0 = 0x10110021;
@@ -2137,7 +2119,6 @@ static void cortex_m7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x411fc272; /* r1p2 */
     cpu->pmsav7_dregion = 8;
     cpu->isar.mvfr0 = 0x10110221;
@@ -2169,7 +2150,6 @@ static void cortex_m33_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
@@ -2253,7 +2233,6 @@ static void cortex_r5f_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     cortex_r5_initfn(obj);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     cpu->isar.mvfr0 = 0x10110221;
     cpu->isar.mvfr1 = 0x00000011;
 }
@@ -2272,7 +2251,6 @@ static void cortex_a8_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a8";
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
@@ -2340,7 +2318,6 @@ static void cortex_a9_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a9";
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -2405,7 +2382,6 @@ static void cortex_a7_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a7";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -2451,7 +2427,6 @@ static void cortex_a15_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a15";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f0d98bc79d..e4e8499e71 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -102,7 +102,6 @@ static void aarch64_a57_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -156,7 +155,6 @@ static void aarch64_a53_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a53";
     set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -210,7 +208,6 @@ static void aarch64_a72_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a72";
     set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 3a8b437eef..2e7d7a1e02 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -122,7 +122,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * bits, but a few must be tested.
      */
     set_feature(&features, ARM_FEATURE_V7VE);
-    set_feature(&features, ARM_FEATURE_VFP3);
     set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
     if (extract32(id_pfr0, 12, 4) == 1) {
@@ -131,10 +130,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_NEON);
     }
-    if (extract32(ahcf->isar.mvfr1, 28, 4) == 1) {
-        /* FMAC support implies VFPv4 */
-        set_feature(&features, ARM_FEATURE_VFP4);
-    }
 
     ahcf->features = features;
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3bae9e4a66..e555e8dbc0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -603,7 +603,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * feature bits.
      */
     set_feature(&features, ARM_FEATURE_V8);
-    set_feature(&features, ARM_FEATURE_VFP4);
     set_feature(&features, ARM_FEATURE_NEON);
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
-- 
2.20.1


