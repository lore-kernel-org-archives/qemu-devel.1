Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225DDC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A1E2171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kdwl74B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A1E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvSm-0000TS-2t
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMz-0005Dl-3O
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMx-0003dJ-QN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:34882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMx-0003cs-Ks
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id u14so32533762pfn.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F8zJJPz0HoAAcPGItYsG98fn3EhRGHL9/KSAWCPhxyQ=;
 b=Kdwl74B6/jWmsEEKylVhNh+FnEqvpfAEzIn2lRU1DV+O/n0aqloQ5a9vX12Kj+4j+a
 AhFLTo/SkoMoEZu0dPjijScKjTXgFHIreIjwOGrdEpw/a8TLIsXUs8BT66ED9TnXbzYe
 VuK58p3XkTOTfylmbJXdoHnsQkMk0JfAw3i8+dCotxAOcyZ3+WxrhPH5Y08pZ1xUdH6d
 VcGvyaF2775EPpVE1zlsbEJjPZwCAOwagUCd9m9Q1DmZ+W7jA25BCPeyS9hzI+wDedeq
 IsqL8bubc932Lws41JBLO2MTvydw/Bz8l12PPTb7Hxfkw9MctKDI6qdeZ+ZTcRXvAoae
 clgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=F8zJJPz0HoAAcPGItYsG98fn3EhRGHL9/KSAWCPhxyQ=;
 b=NtK6/tlsq29oH/i2+aAHn+UnnFoy0R890Fgju6eFfFVzJoX5aBQ89P7SNr+NtoCgSP
 I6tywbPPrMKVQlvA8+Rj10Nv3N2nLuJFduh7cn7rhk5ZHypTw2CZCk4xW0Ztska6cu5r
 bY4TBTrIWrmG65Y8f6wB0mc/yy3eY73W1lAVVLXHWUz01zQZciE+bKuiTrDC/d2B0xjH
 wkMp81EVmtY95WSFGaqLItKq0ZaAXHgTkjZP6CZNVuoI+B56Qn0sTL71H04wEIGNpI54
 NKilLDRnlUzm3S0vLwmWrlR8g5aHjXfs3LYBOz5It6X777hCaEUIQevFkL4juKbkNQHh
 DHrg==
X-Gm-Message-State: APjAAAVuDTWkcEAx8vqab69gXIKBoRPbpVL84rKPTw9XqCa+Iw63N3BN
 PLKA3+EIX3SeZfBO895NnwdkNwafA90=
X-Google-Smtp-Source: APXvYqzMfdfh+XWUeoxyr1jeHDBR6hkx2nkKxbcKB8o5LdXGl98IHaupUed4PR2GNMK8i22Pfx8bLg==
X-Received: by 2002:a63:7c0d:: with SMTP id x13mr75531824pgc.360.1564605522335; 
 Wed, 31 Jul 2019 13:38:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:03 -0700
Message-Id: <20190731203813.30765-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PATCH v2 22/32] target/arm: Add regime_has_2_ranges
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 16 ++++++++++++++++
 target/arm/helper.c        | 22 +++++-----------------
 target/arm/translate-a64.c |  3 +--
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dd0bc4377f..1b64ceeda6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -824,6 +824,22 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
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
index 9c2c81c434..5472424179 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9006,15 +9006,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
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
@@ -9548,7 +9541,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
                                         ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    uint32_t el = regime_el(env, mmu_idx);
     bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
@@ -9558,7 +9550,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
      */
     select = extract64(va, 55, 1);
 
-    if (el > 1) {
+    if (!regime_has_2_ranges(mmu_idx)) {
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -9714,10 +9706,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
@@ -11368,8 +11357,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
             int tbii, tbid;
 
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            if (regime_el(env, stage1) < 2) {
+            if (regime_has_2_ranges(mmu_idx)) {
                 ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
                 tbid = (p1.tbi << 1) | p0.tbi;
                 tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index dbe2189e51..06ff3a7f2e 100644
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


