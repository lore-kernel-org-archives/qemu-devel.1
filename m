Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E6C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4328E21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndNBi4YF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4328E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04oa-0005nI-C0
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hv-0000VL-Fc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hu-0002yw-4g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04ht-0002wL-PU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id p17so3045896wma.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=D621dwQXOCtDrRVeetHrEB9BflVBfYRoR+UKvBUiqEI=;
 b=ndNBi4YFlCWtcesszPV2vvsrHSu6AW2uDMSjwB3wb7nXK+PAA6eug9C0YE4dSC2thP
 7esJmbUliEutlorF4JX9NR2PTOGRPOX6Spv5v27Oux/cx22YV1BMaQkW/uOaZsk9PeAC
 El1dKtGH9Q71iJEeVq4f+Xm8lD61tmY6+iO+4xfzd0pjd4eUNcUGOt4UZ31+UXEtGVTr
 JkCBgHFmMHexAct26h5+7WbCk2ATot1gcaiGiAFx2aUXB+1UCGXN4R+xmFYtyrIPEEWX
 tSmFVl4u/d09ti12jDN205ePosjdImhhp1zzcLE3T6z7BTr9XMVNienMWoe5nb544Ino
 7TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D621dwQXOCtDrRVeetHrEB9BflVBfYRoR+UKvBUiqEI=;
 b=cP664dllTelmcH2o+2hk7LLr2my5CbuHOD7C/hFT75mVdoCfZwlSZeOlZDiAtUCIjK
 mXi5RPZD243+IL8ZwaGdv5efekXohn8+y9y+mf/t/qjLBz6PBNvJSvIoR1wFBzzkaCUk
 tuz+mTcVTpIDGOKt9kJce4sDH0sKbTTBsPy7wiwPIhG1XNp0Bcs6uUGDvjmGFw1Q1l3K
 LD1xnJ/qa0CD/bpr0b6Faf4bxhjMJ7y9t8mkhwca7MbDO5Mc7TRe0T5ul0+PRFLJqGFa
 39o01SCF2UG8gyuC9cYOj4Bt7/pA7pZkvVMYV7sykW+/8X8CqqWhKMcIMTEwMj2BpKXm
 UCdw==
X-Gm-Message-State: APjAAAVeRWnwYfilOluIC4rL5l66UhWAEfN0nqKgqEvbItL65878j+cW
 ju21tnjtR3G5Kd5ET/QZErn3SnPlKhA=
X-Google-Smtp-Source: APXvYqzaogO1wyErH4uxgmnyJsJm1lteUNvPEbzfRSaNgCYCdIDH3W92TEyi32D44+uho+CyLW9XTw==
X-Received: by 2002:a1c:7dd4:: with SMTP id y203mr4789590wmc.67.1581086048298; 
 Fri, 07 Feb 2020 06:34:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/48] target/arm: Add regime_has_2_ranges
Date: Fri,  7 Feb 2020 14:33:16 +0000
Message-Id: <20200207143343.30322-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

Create a predicate to indicate whether the regime has
both positive and negative addresses.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     | 18 ++++++++++++++++++
 target/arm/helper.c        | 23 ++++++-----------------
 target/arm/translate-a64.c |  3 +--
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0c4119a3a2e..6d4a942bde4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -837,6 +837,24 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
+/* Return true if this address translation regime has two ranges.  */
+static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_SE10_0:
+    case ARMMMUIdx_SE10_1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /* Return true if this address translation regime is secure */
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3ce37c2c163..f7bc7f1a8de 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9031,15 +9031,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     }
 
     if (is_aa64) {
-        switch (regime_el(env, mmu_idx)) {
-        case 1:
-            if (!is_user) {
-                xn = pxn || (user_rw & PAGE_WRITE);
-            }
-            break;
-        case 2:
-        case 3:
-            break;
+        if (regime_has_2_ranges(mmu_idx) && !is_user) {
+            xn = pxn || (user_rw & PAGE_WRITE);
         }
     } else if (arm_feature(env, ARM_FEATURE_V7)) {
         switch (regime_el(env, mmu_idx)) {
@@ -9573,7 +9566,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    uint32_t el = regime_el(env, mmu_idx);
     bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
@@ -9583,7 +9575,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
      */
     select = extract64(va, 55, 1);
 
-    if (el > 1) {
+    if (!regime_has_2_ranges(mmu_idx)) {
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -9739,10 +9731,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         param = aa64_va_parameters(env, address, mmu_idx,
                                    access_type != MMU_INST_FETCH);
         level = 0;
-        /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mark it
-         * invalid.
-         */
-        ttbr1_valid = (el < 2);
+        ttbr1_valid = regime_has_2_ranges(mmu_idx);
         addrsize = 64 - 8 * param.tbi;
         inputsize = 64 - param.tsz;
     } else {
@@ -11458,8 +11447,8 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
-    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-    if (regime_el(env, stage1) < 2) {
+    /* Get control bits for tagged addresses.  */
+    if (regime_has_2_ranges(mmu_idx)) {
         ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
         tbid = (p1.tbi << 1) | p0.tbi;
         tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fcfb96ce1fb..3982e1988dc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -175,8 +175,7 @@ static void gen_top_byte_ignore(DisasContext *s, TCGv_i64 dst,
     if (tbi == 0) {
         /* Load unmodified address */
         tcg_gen_mov_i64(dst, src);
-    } else if (s->current_el >= 2) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+    } else if (!regime_has_2_ranges(s->mmu_idx)) {
         /* Force tag byte to all zero */
         tcg_gen_extract_i64(dst, src, 0, 56);
     } else {
-- 
2.20.1


