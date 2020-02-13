Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D294C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9162073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICJ+2iAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9162073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G4I-0001nJ-43
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgw-0004M5-VZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgs-0001oi-SE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:10 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgs-0001h5-KC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:06 -0500
Received: by mail-wr1-x436.google.com with SMTP id w12so6995783wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lbGXOA20K9t0DIIjWkWmEvtE0o6Vf2Fcr4UICkB8S84=;
 b=ICJ+2iAgNYGN58sxjjChpAW4z4XvDA6vK5ynKAjqvklXpgfZs4PM6ZkGKALXW/orcd
 mkgfZPz5bFa3lyXIl8b6or9EOzaVM5Hemz/oTBCLaNmMX1isPL9DWV1MW/qUpwgHOTu2
 TCP4poDgYa0SNzs6VpJ22/yoxU9WlLhJrALuS3IbSYXNx+lmOtkwvpZym1KLHvGoibuI
 41sZoi4wxt/k0FSy2CvfsgdEnOUqxXGbMP1sCgIa4nLg4jIIGx8JM8auUV5RB3y1r47U
 tWCPCvv2qg6vbclW88n0wHDIjVwKgPNz7xA1NHYOwV3razXKT5oDB1cs0JtepR7+7p1W
 4HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lbGXOA20K9t0DIIjWkWmEvtE0o6Vf2Fcr4UICkB8S84=;
 b=e1RktHWGaRsC5SZeQSh8BCSBBQFqiTVbucptDUEQPNzyAP3ogRQsx6nNpKbUhDqTxM
 9hzl/byuHE1EG93jahZFyuJzM8ddUrc58YTAUvlBtrCCfo4I7ciCkQHuIajx3pn7a9PW
 YKF+mMqdlI4G2AcQW3VMkNOUTDl1wfbox51IInvTSx4ZhSdbayE0PCU6n5gYvJo3KwXE
 5i0yo7iGlwJ4cdYL/w7c0AWMhsitTjgX9xpbia/QmJEZZHSWbDCf4TMOlCJSSm7VKPWI
 o4hPndyeDkLJPAUfoQ+dfD3POEBkp9OMzH0mPDIUFYJcW4XaRPEzMcqcXa0P2gIkCZgM
 ApdA==
X-Gm-Message-State: APjAAAXyrkBLK6g1alIjwL439qvyjffILwC/jOATopuUt86D1EVw/bO2
 cPM3ffV9yy0myY8Uq/zEKA1eXHOJIhI=
X-Google-Smtp-Source: APXvYqx1NGdFKGwXIqDyVv3uhLbFNpa+68lxrhP0UQPZg97dfq2y5vyeeZQY5ZOi+Rvp9g0ILZBVgg==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr23190114wrn.124.1581604921873; 
 Thu, 13 Feb 2020 06:42:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/46] target/arm: Add mmu_idx for EL1 and EL2 w/ PAN enabled
Date: Thu, 13 Feb 2020 14:41:10 +0000
Message-Id: <20200213144145.818-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

From: Richard Henderson <richard.henderson@linaro.org>

To implement PAN, we will want to swap, for short periods
of time, to a different privileged mmu_idx.  In addition,
we cannot do this with flushing alone, because the AT*
instructions have both PAN and PAN-less versions.

Add the ARMMMUIdx*_PAN constants where necessary next to
the corresponding ARMMMUIdx* constant.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-param.h     |  2 +-
 target/arm/cpu.h           | 33 ++++++++++++++-------
 target/arm/internals.h     |  9 ++++++
 target/arm/helper.c        | 60 +++++++++++++++++++++++++++++++-------
 target/arm/translate-a64.c |  3 ++
 target/arm/translate.c     |  2 ++
 6 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 18ac5623462..d593b60b28d 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,6 +29,6 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif
 
-#define NB_MMU_MODES 9
+#define NB_MMU_MODES 12
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0b3036c484f..c63bceaaa5f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2751,20 +2751,24 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  5. we want to be able to use the TLB for accesses done as part of a
  *     stage1 page table walk, rather than having to walk the stage2 page
  *     table over and over.
+ *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
+ *     Never (PAN) bit within PSTATE.
  *
  * This gives us the following list of cases:
  *
  * NS EL0 EL1&0 stage 1+2 (aka NS PL0)
  * NS EL1 EL1&0 stage 1+2 (aka NS PL1)
+ * NS EL1 EL1&0 stage 1+2 +PAN
  * NS EL0 EL2&0
- * NS EL2 EL2&0
+ * NS EL2 EL2&0 +PAN
  * NS EL2 (aka NS PL2)
  * S EL0 EL1&0 (aka S PL0)
  * S EL1 EL1&0 (not used if EL3 is 32 bit)
+ * S EL1 EL1&0 +PAN
  * S EL3 (aka S PL1)
  * NS EL1&0 stage 2
  *
- * for a total of 9 different mmu_idx.
+ * for a total of 12 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
@@ -2819,19 +2823,22 @@ typedef enum ARMMMUIdx {
     /*
      * A-profile.
      */
-    ARMMMUIdx_E10_0 =  0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_0 =  1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_0      =  0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_0      =  1 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_E10_1 =  2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1      =  2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1_PAN  =  3 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_E2 =     3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2 =  4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2         =  4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2      =  5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2_PAN  =  6 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_SE10_0 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE10_1 = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE3 =    7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_0     = 7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1     = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1_PAN = 9 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3        = 10 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_Stage2 = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2     = 11 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -2839,6 +2846,7 @@ typedef enum ARMMMUIdx {
      */
     ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
 
     /*
      * M-profile.
@@ -2864,10 +2872,13 @@ typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(E10_0),
     TO_CORE_BIT(E20_0),
     TO_CORE_BIT(E10_1),
+    TO_CORE_BIT(E10_1_PAN),
     TO_CORE_BIT(E2),
     TO_CORE_BIT(E20_2),
+    TO_CORE_BIT(E20_2_PAN),
     TO_CORE_BIT(SE10_0),
     TO_CORE_BIT(SE10_1),
+    TO_CORE_BIT(SE10_1_PAN),
     TO_CORE_BIT(SE3),
     TO_CORE_BIT(Stage2),
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f8ee5f573e..6be8b2d1a9b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -843,12 +843,16 @@ static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         return true;
     default:
         return false;
@@ -861,10 +865,13 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
@@ -875,6 +882,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
@@ -1046,6 +1054,7 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
         return true;
     default:
         return false;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 57dc7a307c0..bfd6c0d04bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -671,6 +671,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_E10_1 |
+                        ARMMMUIdxBit_E10_1_PAN |
                         ARMMMUIdxBit_E10_0 |
                         ARMMMUIdxBit_Stage2);
 }
@@ -682,6 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_E10_1 |
+                                        ARMMMUIdxBit_E10_1_PAN |
                                         ARMMMUIdxBit_E10_0 |
                                         ARMMMUIdxBit_Stage2);
 }
@@ -2700,6 +2702,7 @@ static int gt_phys_redir_timeridx(CPUARMState *env)
     switch (arm_mmu_idx(env)) {
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         return GTIMER_HYP;
     default:
         return GTIMER_PHYS;
@@ -2711,6 +2714,7 @@ static int gt_virt_redir_timeridx(CPUARMState *env)
     switch (arm_mmu_idx(env)) {
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         return GTIMER_HYPVIRT;
     default:
         return GTIMER_VIRT;
@@ -3337,7 +3341,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
+            if (mmu_idx == ARMMMUIdx_E10_0 ||
+                mmu_idx == ARMMMUIdx_E10_1 ||
+                mmu_idx == ARMMMUIdx_E10_1_PAN) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3797,7 +3803,9 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
         (arm_hcr_el2_eff(env) & HCR_E2H)) {
         tlb_flush_by_mmuidx(env_cpu(env),
-                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
+                            ARMMMUIdxBit_E20_2 |
+                            ARMMMUIdxBit_E20_2_PAN |
+                            ARMMMUIdxBit_E20_0);
     }
     raw_write(env, ri, value);
 }
@@ -3815,6 +3823,7 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
                             ARMMMUIdxBit_E10_1 |
+                            ARMMMUIdxBit_E10_1_PAN |
                             ARMMMUIdxBit_E10_0 |
                             ARMMMUIdxBit_Stage2);
         raw_write(env, ri, value);
@@ -4175,12 +4184,18 @@ static int vae1_tlbmask(CPUARMState *env)
 {
     /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
+        return ARMMMUIdxBit_SE10_1 |
+               ARMMMUIdxBit_SE10_1_PAN |
+               ARMMMUIdxBit_SE10_0;
     } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
                == (HCR_E2H | HCR_TGE)) {
-        return ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0;
+        return ARMMMUIdxBit_E20_2 |
+               ARMMMUIdxBit_E20_2_PAN |
+               ARMMMUIdxBit_E20_0;
     } else {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
+        return ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0;
     }
 }
 
@@ -4214,18 +4229,28 @@ static int alle1_tlbmask(CPUARMState *env)
      * stage 1 translations.
      */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
+        return ARMMMUIdxBit_SE10_1 |
+               ARMMMUIdxBit_SE10_1_PAN |
+               ARMMMUIdxBit_SE10_0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_Stage2;
+        return ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0 |
+               ARMMMUIdxBit_Stage2;
     } else {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
+        return ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0;
     }
 }
 
 static int e2_tlbmask(CPUARMState *env)
 {
     /* TODO: ARMv8.4-SecEL2 */
-    return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E2;
+    return ARMMMUIdxBit_E20_0 |
+           ARMMMUIdxBit_E20_2 |
+           ARMMMUIdxBit_E20_2_PAN |
+           ARMMMUIdxBit_E2;
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -9206,6 +9231,7 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_E2:
         return 2;
@@ -9214,10 +9240,13 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE10_0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -9333,6 +9362,8 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
         return ARMMMUIdx_Stage1_E0;
     case ARMMMUIdx_E10_1:
         return ARMMMUIdx_Stage1_E1;
+    case ARMMMUIdx_E10_1_PAN:
+        return ARMMMUIdx_Stage1_E1_PAN;
     default:
         return mmu_idx;
     }
@@ -9379,6 +9410,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return false;
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
         g_assert_not_reached();
     }
 }
@@ -11271,7 +11303,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
+    if (mmu_idx == ARMMMUIdx_E10_0 ||
+        mmu_idx == ARMMMUIdx_E10_1 ||
+        mmu_idx == ARMMMUIdx_E10_1_PAN) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11798,10 +11832,13 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE10_0:
         return 0;
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         return 1;
     case ARMMMUIdx_E2:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         return 2;
     case ARMMMUIdx_SE3:
         return 3;
@@ -12018,11 +12055,14 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     /* TODO: ARMv8.2-UAO */
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         /* TODO: ARMv8.3-NV */
         flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
         break;
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         /* TODO: ARMv8.4-SecEL2 */
         /*
          * Note that E20_2 is gated by HCR_EL2.E2H == 1, but E20_0 is
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6e82486884b..49631c23404 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -124,12 +124,15 @@ static int get_a64_user_mem_index(DisasContext *s)
          */
         switch (useridx) {
         case ARMMMUIdx_E10_1:
+        case ARMMMUIdx_E10_1_PAN:
             useridx = ARMMMUIdx_E10_0;
             break;
         case ARMMMUIdx_E20_2:
+        case ARMMMUIdx_E20_2_PAN:
             useridx = ARMMMUIdx_E20_0;
             break;
         case ARMMMUIdx_SE10_1:
+        case ARMMMUIdx_SE10_1_PAN:
             useridx = ARMMMUIdx_SE10_0;
             break;
         default:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e11a5871d02..d58c328e08e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -155,10 +155,12 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
         return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
     case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         return arm_to_core_mmu_idx(ARMMMUIdx_SE10_0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
-- 
2.20.1


