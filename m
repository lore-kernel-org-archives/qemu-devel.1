Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91749C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFB620684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4MyJw/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFB620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyHJ-0003B3-S8
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxF-0003Kc-OL
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxA-0008Qf-S0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:19 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:38114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008H4-Hm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:16 -0500
Received: by mail-pg1-x534.google.com with SMTP id t3so873505pgl.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Xos4Pslsfo4lMRc6yGUlLi8dcXsFQtvPjw86xkjAaB4=;
 b=Q4MyJw/MPPJJLnumBttiKd6PWw2/qCyRSnsED03QpmI3408zBN8QUDgCCBEMnT63RF
 6LvGpvw96bFsVuVQubRf7yPryZZj7ZgJRgTsGNuJRca6EdZr/aI5cMg3S6DE0y20avs+
 Pyi8q//BDqYpsdZC89wliKYuN+9fWwn1iSPbFEpKwZOVsDG30KFKtKtg3MTfyORK2q1N
 gfVPqdYGopMTzm1kFydqesuXBAEtymkeGMjnx1+cafAYPiEoVwAFm9udh2k34/K5NNOP
 v2DwUpGt6e/Lu43l3HSYBYQUdYXuO7WWT6IVjblsmOLWkSvqrc5UzSGyveU32PkeS4th
 /DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Xos4Pslsfo4lMRc6yGUlLi8dcXsFQtvPjw86xkjAaB4=;
 b=NMyUwmW0vfDpo8RTgfCm/oB6YD8DtH5SqWtzEB8DELMbeqqfKAOrO+kK+6OwcwWnsf
 yBhY8rWpNxbMULpFa6aWPqSSxnScdum5ECNSTmoh27ihEZc/ltSwIvixZRcAB6QUsj0y
 RmXo1VZqWApR8oBeA+/cmKA/uBk79c66NTXK0LqUzLvw5jf7k9aIYMgs6ehzNIwI7XvR
 vX3vdOBOi/pem3DNHYt8sT2w/kD/hTkJpGNSHed/DK//ks2EhDD+mU70w2b1uHr+xfte
 iFuh6t9XlreOiX5iS4JVGqYgPk1uvy+1JvjTqss9RTfflCF3k4VrWrrAgL0iNutMP/z0
 iVmg==
X-Gm-Message-State: APjAAAVWtDqwa6vU0TW0r9muo55udmG0U4255NiSUnp717FucgAqXDNQ
 GN6XWTuzT/ghmdBCfCeq6OMXoHYthAg=
X-Google-Smtp-Source: APXvYqwGopLQkhOth2E4ve2RCS7+E9qTQ9Px53188YN/3AAd5eh+lTg8LLFspAIyr9gXG22QXiwN7Q==
X-Received: by 2002:a65:590f:: with SMTP id f15mr2729309pgu.381.1575340204022; 
 Mon, 02 Dec 2019 18:30:04 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/40] target/arm: Add regime_has_2_ranges
Date: Mon,  2 Dec 2019 18:29:16 -0800
Message-Id: <20191203022937.1474-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 16 ++++++++++++++++
 target/arm/helper.c        | 23 ++++++-----------------
 target/arm/translate-a64.c |  3 +--
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d73615064c..1ca9a7cc78 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -837,6 +837,22 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
+/* Return true if this address translation regime has two ranges.  */
+static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL20_0:
+    case ARMMMUIdx_EL20_2:
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
index f86285ffbe..27adf24fa6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8885,15 +8885,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
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
@@ -9427,7 +9420,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    uint32_t el = regime_el(env, mmu_idx);
     bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
@@ -9437,7 +9429,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
      */
     select = extract64(va, 55, 1);
 
-    if (el > 1) {
+    if (!regime_has_2_ranges(mmu_idx)) {
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -9593,10 +9585,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
@@ -11306,8 +11295,8 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
-    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-    if (regime_el(env, stage1) < 2) {
+    /* Get control bits for tagged addresses.  */
+    if (regime_has_2_ranges(mmu_idx)) {
         ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
         tbid = (p1.tbi << 1) | p0.tbi;
         tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 885c99f0c9..d0b65c49e2 100644
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
2.17.1


