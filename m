Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C4C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD86205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ab2ObkZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD86205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyaF-00026G-9d
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySR-0007Dj-MR
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySQ-0006Xt-0b
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:31 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySP-0006VS-Oz
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:29 -0500
Received: by mail-pg1-x543.google.com with SMTP id s64so5454175pgb.9
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cmYB5V5YPztxH/SIIbnRuYH/94mVqTzVwTSBflgE5dM=;
 b=Ab2ObkZjV3NS979IgZVNKuKLFjmLZXlwWP/fWjLk4B6LDmPoUidWEq8OYhDL9lPEvZ
 9Q/nSOJdB+yMVR7910PIoz7xVXIwZ/SWpFvQYMb7vS9GebLG8AzqgKbu0ofKVicwowSE
 N92zXYsKj3kh95Bj87EpcZiN3H7T7YJLDG2TgyHP8AKLmREgLOsWeWjNDzbfUp35E6N0
 MYlSq3KX3Ctbx8yzH+Pk1BAqKOUsh4ym6YGzkEl4EaFpHMU3bgDQ5R63qYhN3s2feNHl
 dwKH58mmVkUzGfw3xeCj/H4U9TpLlIGiPDzbZjCRLWkwZtStKUCUd5r1zzX0LdqDobOU
 SmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cmYB5V5YPztxH/SIIbnRuYH/94mVqTzVwTSBflgE5dM=;
 b=Dl25K7fACiqIpXZ4HbfNO8mLRjncYG/kede315VuFPfWJUiLT6wo81Zp4bs33SW2pv
 GdXqoY1MkA/Jt3qw4frflK2kDeJRBv0NalDe03cABUkrrHnv0JDKUmFGHtjLvZ5AxNkn
 l2efrJQIWBLYD/pK2QIQ8y7Ig/GRzqPpb5mx8Up9DstdVo5FpFILHfL79cW21weM0pHB
 WcCehyGDlZI0nblZ9LRv/5nJ0cZgFhCT3hrBmVqWVNY8o0CweHZUbxAAuAd6U2+kaFrA
 cVilFnASV2pzeT4Yo8OnWTuzqqHL2GGTFN2S3ew9iX40PuUuEARqKR7krGKcZijXVrIS
 0XOg==
X-Gm-Message-State: APjAAAXqbsBJv0qH88n4RcpilNZDznE0TtONykw6ZaP3xM0iYl+0Jy3j
 dprMhYPDw/yslfHMMDD+Wk4UEVTWgGk=
X-Google-Smtp-Source: APXvYqy4FVtKaCriS2ZapeLCk2Qh/gzTP3V8Cgc6R8C/iijJ8FRV85EIeePyhq/m+Uv8B+TxyVAPWw==
X-Received: by 2002:a63:3e8f:: with SMTP id l137mr2492547pga.360.1580585368462; 
 Sat, 01 Feb 2020 11:29:28 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/41] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
Date: Sat,  1 Feb 2020 11:28:44 -0800
Message-Id: <20200201192916.31796-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a reorganization to the set of mmu_idx.
This emphasizes that they apply to the EL1&0 regime.

The ultimate goal is

 -- Non-secure regimes:
    ARMMMUIdx_E10_0,
    ARMMMUIdx_E20_0,
    ARMMMUIdx_E10_1,
    ARMMMUIdx_E2,
    ARMMMUIdx_E20_2,

 -- Secure regimes:
    ARMMMUIdx_SE10_0,
    ARMMMUIdx_SE10_1,
    ARMMMUIdx_SE3,

 -- Helper mmu_idx for non-secure EL1&0 stage1 and stage2
    ARMMMUIdx_Stage2,
    ARMMMUIdx_Stage1_E0,
    ARMMMUIdx_Stage1_E1,

The 'S' prefix is reserved for "Secure".  Unless otherwise specified,
each mmu_idx represents all stages of translation.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  8 ++++----
 target/arm/internals.h     |  4 ++--
 target/arm/helper.c        | 40 +++++++++++++++++++-------------------
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  6 +++---
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0e68704a90..272104afbb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2905,8 +2905,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 #define ARM_MMU_IDX_COREIDX_MASK 0x7
 
 typedef enum ARMMMUIdx {
-    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S12NSE1 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_0 = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
@@ -2931,8 +2931,8 @@ typedef enum ARMMMUIdx {
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_S12NSE0 = 1 << 0,
-    ARMMMUIdxBit_S12NSE1 = 1 << 1,
+    ARMMMUIdxBit_E10_0 = 1 << 0,
+    ARMMMUIdxBit_E10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5313dd3d4..d4ea6cfe9d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -808,8 +808,8 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bf69935550..95b67ba6c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -670,8 +670,8 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs,
-                        ARMMMUIdxBit_S12NSE1 |
-                        ARMMMUIdxBit_S12NSE0 |
+                        ARMMMUIdxBit_E10_1 |
+                        ARMMMUIdxBit_E10_0 |
                         ARMMMUIdxBit_S2NS);
 }
 
@@ -681,8 +681,8 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                        ARMMMUIdxBit_S12NSE1 |
-                                        ARMMMUIdxBit_S12NSE0 |
+                                        ARMMMUIdxBit_E10_1 |
+                                        ARMMMUIdxBit_E10_0 |
                                         ARMMMUIdxBit_S2NS);
 }
 
@@ -3117,7 +3117,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+            if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3216,11 +3216,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         break;
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
-        mmu_idx = ARMMMUIdx_S12NSE1;
+        mmu_idx = ARMMMUIdx_E10_1;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
-        mmu_idx = ARMMMUIdx_S12NSE0;
+        mmu_idx = ARMMMUIdx_E10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3278,10 +3278,10 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
+        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_E10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
+        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_E10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3581,8 +3581,8 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0 |
+                            ARMMMUIdxBit_E10_1 |
+                            ARMMMUIdxBit_E10_0 |
                             ARMMMUIdxBit_S2NS);
         raw_write(env, ri, value);
     }
@@ -3943,7 +3943,7 @@ static int vae1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
 }
 
@@ -3979,9 +3979,9 @@ static int alle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_S2NS;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
 }
 
@@ -8817,8 +8817,8 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
  */
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
+    if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
+        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_E10_0);
     }
     return mmu_idx;
 }
@@ -8861,8 +8861,8 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
         g_assert_not_reached();
     }
 }
@@ -10766,7 +10766,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11294,7 +11294,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
-        return ARMMMUIdx_S12NSE0 + el;
+        return ARMMMUIdx_E10_0 + el;
     }
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 766a03335b..cb539b1eff 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -113,8 +113,8 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     ARMMMUIdx useridx;
 
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S12NSE1:
-        useridx = ARMMMUIdx_S12NSE0;
+    case ARMMMUIdx_E10_1:
+        useridx = ARMMMUIdx_E10_0;
         break;
     case ARMMMUIdx_S1SE1:
         useridx = ARMMMUIdx_S1SE0;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2f4aea927f..f90f22ef90 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -153,9 +153,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      */
     switch (s->mmu_idx) {
     case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
+        return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
-- 
2.20.1


