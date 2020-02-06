Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1FAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D84620659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roABYMCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D84620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izesa-0003Z3-9m
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoH-0002x8-7f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoE-0006al-KR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:01 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoE-0006UW-BE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so6598115wrt.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KxsVe3erqBPLeKfFRz0xsgQ2wGajMqvk9mIcrB8gDiE=;
 b=roABYMCrsofQDHf264YQXI4qRnl5Y8nRtL0VkACe0dp0UKkPRVZ91WHub23377RQtj
 pRaVPuhxr3NDKTa/8Z9MIpmJ90a2srevuN3NCxcFep+MYmpJRZl8TX8HMXfwykpwGrUM
 qcchpyAhteYqH8Uv2glPT2VgOgF5/8Z7sTaI6ja83mmz2sUs0019y42KIEXQM/IECdHw
 DELL+haNmpBDC3HZxsRNm4Lp265+XNVoG1MsVIuzB+CExm/L76tUI+zcmbKkQwDWm4XE
 iooz86av0jEr9VMLA02DQkTuUjt9LsDhefvxz9qRIA2JvXumSJBlxjP4kKiaqvlvP5vn
 jMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KxsVe3erqBPLeKfFRz0xsgQ2wGajMqvk9mIcrB8gDiE=;
 b=GcsQTLvputYHm/ZxUJ/l2DdOZsN9y3TmZhaKdBLMfqiNYTMoHoUfP7A2rZVhjjQLyg
 XQ/HvLs8R4JVP17MnQXeukpU5lgXfEyFs4zSaOfH27tHL1GnM5VqY62SHGE1gRUzVCPW
 wYOOK/NpKhMqK7L1NNh+iBROW3uosmQ1Wz0T/+Li0PwJ8kTGcRh/xK6cWHGK9qk0ZVm/
 Zf16OviHxPfcxWgcr6BcXTeEulH3xDBUqMIV1/q8tKzqXQ8eVKNdtyUukpD+/Qo3wHa/
 kgom1CnAn1wQ6lBIGROBRxiOFCXX2fU+ZV6iwQGzu4KNSbW4so6NVZNNKU4y0+hzZ83N
 F3vA==
X-Gm-Message-State: APjAAAUe9E9PPNhudRwyhRwfVoRRzva0DohdqeDQYesaPtPMuUEpbnDu
 mmiI95T9WTUbQE51z9mB6lgnV8D1oJ2I5g==
X-Google-Smtp-Source: APXvYqyNnuj16ELSV0MxccvntwGcTFFqunS8AlcGhqatCv043Bodb4fyADiakp6ViJwquHGOGi6PWQ==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr3366656wru.296.1580986497051; 
 Thu, 06 Feb 2020 02:54:57 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/41] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
Date: Thu,  6 Feb 2020 10:54:16 +0000
Message-Id: <20200206105448.4726-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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


