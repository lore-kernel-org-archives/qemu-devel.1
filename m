Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9780EC38C00
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4488A2176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcnxit0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4488A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MEL-00008H-CE
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7t-0004jt-9t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7r-0005xV-Cy
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:57 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7r-0005x6-5e
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:55 -0500
Received: by mail-pl1-x641.google.com with SMTP id q4so491752pls.4
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ic31+5+7BISn+IpIxJxTLFKxAz0Jem6L/fKBKMDWBDA=;
 b=gcnxit0i8C2xmL/KuIbp4zzhY4HYBK8VuEwDghoHNUe0dzly8T3kbpPLrk/LlUiesK
 AqXabWKVEzIofCEpmhqNLbb1OoPDt54zsKF2nK0PbMc9a4S9kwLfnkrFCP7tW6A8I1hx
 kBMzE8MXWh+mPB/KwUDgItGrS4LHhsuiQX3Qr7iD6cewilGFC0M4GgyqQOrtjU/8lm6U
 SIvRktjx2isE3QVcOMn7syT8KAoAhBGv3Sm5RRBu0UYOKDYd8HstjyEndghnsymI5TVg
 HIlsQHXR0ljhmYo/0sZ1ahIqkkzShOJq1nshNc2XHmXlvpmRSm1NO9gNMp8LRRjHweL5
 Cq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ic31+5+7BISn+IpIxJxTLFKxAz0Jem6L/fKBKMDWBDA=;
 b=o4u3Zc7C6R8BtL9uVEnheH7RhXDhV2+GBGoi/tnrmN6SFqAKNYoSIHdOsdcPziT1/Z
 FnL/hI91B4WQ81VTOozunZMLCTujNGyZl2rfVF8tC4+2FeJUdWi/U8Zb3RzSfIat7tdL
 QvOXS/0mHaFyuWfS3I9hSFW5Td0D8k3KbhD5y1lCfNSjbf2lC39+fJJrxOAFGsAjvalT
 bw5Ze+V8FbSHk8ppNn6pzXamF2b752fpJNSCezWHdkvLjT/snjhJgB0NpxKuMyqyZ/dg
 Wcfuo0lPeRfhN1cHj2LfoF21O+sWAob/brHOl/fK+lkUn2PF+Wi/iZ/dKLG9oMc7ZLC+
 q1dw==
X-Gm-Message-State: APjAAAVWxsUYdmweD576cggKQ95izqzKXIwkgKNA7kkNnqhNk7ay9PJA
 XnIev0nIVVmtj4CDXnswfl702gagU7U=
X-Google-Smtp-Source: APXvYqzxiOpK63Znt1RdOuYK8EPbkmdoKQMmUdxu57V7BWwFHTKAnAyzMXQarUHOZqSPAn5BD24uTw==
X-Received: by 2002:a17:90a:654a:: with SMTP id
 f10mr1473976pjs.50.1582582972978; 
 Mon, 24 Feb 2020 14:22:52 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] target/arm: Remove ARM_FEATURE_VFP*
Date: Mon, 24 Feb 2020 14:22:29 -0800
Message-Id: <20200224222232.13807-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have converted all tests against these features
to ISAR tests.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   |  3 ---
 target/arm/cpu.c   | 25 -------------------------
 target/arm/cpu64.c |  3 ---
 target/arm/kvm32.c |  5 -----
 target/arm/kvm64.c |  1 -
 5 files changed, 37 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b29b0eddfc..05aa9711cd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1880,7 +1880,6 @@ QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
  * mapping in linux-user/elfload.c:get_elf_hwcap().
  */
 enum arm_features {
-    ARM_FEATURE_VFP,
     ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
     ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
     ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
@@ -1889,7 +1888,6 @@ enum arm_features {
     ARM_FEATURE_V7,
     ARM_FEATURE_THUMB2,
     ARM_FEATURE_PMSA,   /* no MMU; may have Memory Protection Unit */
-    ARM_FEATURE_VFP3,
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
@@ -1900,7 +1898,6 @@ enum arm_features {
     ARM_FEATURE_V5,
     ARM_FEATURE_STRONGARM,
     ARM_FEATURE_VAPA, /* cp15 VA to PA lookups */
-    ARM_FEATURE_VFP4, /* VFPv4 (implies that NEON is v2) */
     ARM_FEATURE_GENERIC_TIMER,
     ARM_FEATURE_MVFR, /* Media and VFP Feature Registers 0 and 1 */
     ARM_FEATURE_DUMMY_C15_REGS, /* RAZ/WI all of cp15 crn=15 */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bdcaa46b8a..ebff98cb36 100644
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
@@ -1431,10 +1424,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         uint64_t t;
         uint32_t u;
 
-        unset_feature(env, ARM_FEATURE_VFP);
-        unset_feature(env, ARM_FEATURE_VFP3);
-        unset_feature(env, ARM_FEATURE_VFP4);
-
         t = cpu->isar.id_aa64isar1;
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
         cpu->isar.id_aa64isar1 = t;
@@ -1866,7 +1855,6 @@ static void arm926_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm926";
     set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
     cpu->midr = 0x41069265;
@@ -1907,7 +1895,6 @@ static void arm1026_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1026";
     set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
@@ -1955,7 +1942,6 @@ static void arm1136_r2_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
@@ -1987,7 +1973,6 @@ static void arm1136_initfn(Object *obj)
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
     set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
@@ -2018,7 +2003,6 @@ static void arm1176_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1176";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
@@ -2051,7 +2035,6 @@ static void arm11mpcore_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm11mpcore";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_MPIDR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
@@ -2117,7 +2100,6 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
     cpu->isar.mvfr0 = 0x10110021;
@@ -2148,7 +2130,6 @@ static void cortex_m7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x411fc272; /* r1p2 */
     cpu->pmsav7_dregion = 8;
     cpu->isar.mvfr0 = 0x10110221;
@@ -2180,7 +2161,6 @@ static void cortex_m33_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
@@ -2264,7 +2244,6 @@ static void cortex_r5f_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     cortex_r5_initfn(obj);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     cpu->isar.mvfr0 = 0x10110221;
     cpu->isar.mvfr1 = 0x00000011;
 }
@@ -2283,7 +2262,6 @@ static void cortex_a8_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a8";
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
@@ -2351,7 +2329,6 @@ static void cortex_a9_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a9";
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -2416,7 +2393,6 @@ static void cortex_a7_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a7";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -2462,7 +2438,6 @@ static void cortex_a15_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a15";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0929401a4d..5cda580231 100644
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
index 7981ae3bc4..f703c4fcad 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -147,7 +147,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * bits, but a few must be tested.
      */
     set_feature(&features, ARM_FEATURE_V7VE);
-    set_feature(&features, ARM_FEATURE_VFP3);
     set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
     if (extract32(id_pfr0, 12, 4) == 1) {
@@ -156,10 +155,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_NEON);
     }
-    if (extract32(ahcf->isar.mvfr1, 28, 4) == 1) {
-        /* FMAC support implies VFPv4 */
-        set_feature(&features, ARM_FEATURE_VFP4);
-    }
 
     ahcf->features = features;
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0ad96c3500..93ba1448da 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -649,7 +649,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * feature bits.
      */
     set_feature(&features, ARM_FEATURE_V8);
-    set_feature(&features, ARM_FEATURE_VFP4);
     set_feature(&features, ARM_FEATURE_NEON);
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
-- 
2.20.1


