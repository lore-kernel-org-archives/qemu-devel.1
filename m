Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2CCC35246
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9B620679
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kK65Esrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9B620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixybp-0005Uu-Bz
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySU-0007Jf-70
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySS-0006gn-NW
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:34 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySS-0006ef-Gt
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:32 -0500
Received: by mail-pg1-x543.google.com with SMTP id a33so5482460pgm.5
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y5by4nRmhNXf+xlMKpQf9OWkKPnfJWjLjLomV+oSrFM=;
 b=kK65EsrhjciXvmN7+4UrnhiLHhNmzssa2UibMLRcMNncn55X2Q9f0/RxCgNqVzg0AA
 y5LgSBy+xgmjR8eQ7382up4PycqP3uRakmbAxe1Exvw/F3i5LP1Ml32+lQMTmtBuJ61E
 eewf77S5rTBUmnMbdoeyDTw+KPPAmICE8JRochvuuhhVr4oqiBu3Ui565Uwd5WpD6NQW
 I0Yp9xSgvc4cCp/0be/ro4XT2pvMhVDGBV666LZYsvlFF00WLNu+wmvP6N/VgKjfM9dd
 LF0Hifdrg5DIXJ2Y8vYzXXmDoZp1va5haJ6vTCQ3Rj+KiF8fKA8SIlok+5xgeCjk+22d
 y4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y5by4nRmhNXf+xlMKpQf9OWkKPnfJWjLjLomV+oSrFM=;
 b=BFdWn3n2kuv0v2KitF4UBB58eWJWG84nduylJ/x51mDCvgfM6KMFJmqd7p47o4mLUJ
 S0/AyEISQ7kJ6/c4/wD1CnCmFsoaGeTSnHd1170hrIh4s7M2xkhIAYp3LXHJknyJcf+5
 69i8RtHEBqW4CKNaJfe/9g+SqzLqB6b6vfuE3B5MGNyGetsUUi6MIYREfF7ynwrM9lSS
 Eyex/1LVZ7iEF1cXCIp5aDsVRG0e4b2smSKl2EVPRR9xA8UrgU2cmCs+z4xwAQYLM94F
 ZZXpy07lwosmW+oBmnzhiIse94QiaKBbmPQSrDxmgiYVxQczO37Z/TkMLNdbFJvOI2Z8
 K4zA==
X-Gm-Message-State: APjAAAWPM1myOXWMbxhf8waLSAATkSIRVbihs/te9MSzJ0GRaJ9zJ3Gj
 NruEgahSJIJ9KG+5R4ZNuourwWVAmrw=
X-Google-Smtp-Source: APXvYqx9QNDNiQje+GZ/xt+nmuwg/YfY8ebbzhCIhqB6a2n8axCwPh6onxVEVdbi20aQ4K+dnuYVJQ==
X-Received: by 2002:a62:ee0f:: with SMTP id e15mr6613943pfi.256.1580585371277; 
 Sat, 01 Feb 2020 11:29:31 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/41] target/arm: Rename ARMMMUIdx_S1NSE* to
 ARMMMUIdx_Stage1_E*
Date: Sat,  1 Feb 2020 11:28:46 -0800
Message-Id: <20200201192916.31796-12-richard.henderson@linaro.org>
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
The EL1&0 regime is the only one that uses 2-stage translation.
Spelling out Stage avoids confusion with Secure.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Adjust || indentation (ajb)
---
 target/arm/cpu.h       |  4 ++--
 target/arm/internals.h |  6 +++---
 target/arm/helper.c    | 27 ++++++++++++++-------------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6da3d3043..afc3e76ce5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2923,8 +2923,8 @@ typedef enum ARMMMUIdx {
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
-    ARMMMUIdx_S1NSE0 = 0 | ARM_MMU_IDX_NOTLB,
-    ARMMMUIdx_S1NSE1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
 } ARMMMUIdx;
 
 /* Bit macros for the core-mmu-index values for each index,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1509e45e98..280b5b0c82 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -810,8 +810,8 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_S1E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
@@ -975,7 +975,7 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env);
 #ifdef CONFIG_USER_ONLY
 static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 {
-    return ARMMMUIdx_S1NSE0;
+    return ARMMMUIdx_Stage1_E0;
 }
 #else
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a6d4f449cc..2d87c3a2e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3041,7 +3041,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && (mmu_idx == ARMMMUIdx_S1NSE1 || mmu_idx == ARMMMUIdx_S1NSE0)) {
+            && (mmu_idx == ARMMMUIdx_Stage1_E1 ||
+                mmu_idx == ARMMMUIdx_Stage1_E0)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -3189,10 +3190,10 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_S1E3;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE1;
+            mmu_idx = ARMMMUIdx_Stage1_E1;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
             break;
         default:
             g_assert_not_reached();
@@ -3205,10 +3206,10 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
             mmu_idx = ARMMMUIdx_S1SE0;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE0;
+            mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
@@ -3262,7 +3263,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_S1E2;
@@ -3275,7 +3276,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_Stage1_E0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
         mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_E10_1;
@@ -8717,8 +8718,8 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1SE0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
     case ARMMMUIdx_S1SE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -8776,7 +8777,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
     }
 
     if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1)) {
+        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -8821,7 +8822,7 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
     if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_E10_0);
+        mmu_idx += (ARMMMUIdx_Stage1_E0 - ARMMMUIdx_E10_0);
     }
     return mmu_idx;
 }
@@ -8856,7 +8857,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
     case ARMMMUIdx_MUserNegPri:
@@ -9087,7 +9088,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
+    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
         !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
-- 
2.20.1


