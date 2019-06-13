Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D1FC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95479205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGPy8QlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95479205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPPs-0000uv-MY
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdu-0008Te-2x
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdh-0004um-SB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdc-0004kq-CT
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id x17so5235862wrl.9
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=k5KHJjeORXTvuSg87MPqOF7vkfCS42YLavByWjR0+X0=;
 b=pGPy8QlXvlNRmv3Viy/OMe7NY1322AvTyB/8xB6Ht6D4inemf1qS0ridrFQbDnvJpi
 I3ZUNZHLfOP8KTDAuNR6OxciaFdUWiq8ioPkVxqdErl7jvZXaTJxV5OjPwPXooJnp1Ns
 JBuMieBVxaJt+qjFrybWBoDjokZr49oL9rz32jvwrqamKTdqW7+IDJPm1Pm+5ihZR1Bd
 jXpXx2vvNifvvwSAdIfCbwXXalgglM8KX5UUjxwHUvY/FyN1hbuhFesbTE1cqxR7i954
 Mr3e3mQwisb/3HdX1OHE6T87kR+fgyrcOzeHTuz9iH5EYzQv4vwqX8iQcURAXUI7vyw8
 NhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k5KHJjeORXTvuSg87MPqOF7vkfCS42YLavByWjR0+X0=;
 b=nRwBEUX54zR61WUcRpb30bdID677Y91dLqstZDgxXAwIvfFpCkowvo3Yn7HKDRm51p
 HM3N0bGGU9o9Aqt8U3BQ2uq/R2vH1I3/7ewCeQ/7BM3VhPR2itPQAKYi4etMXiM0djxJ
 ETGqR/qrFJInqDf8Svv2nXHz1GOnRt5KiXeQfASOJuJaRpxh0qZufdruRvV7k205gtvT
 qSjuB+WY8baTceXeRaFOdwk4BFRSv/WEZwL8c7P9/tu/ESPnscMZycvy/Xn/ryF8IduS
 06QFFGrWSBBrsLNZKMsuPB13HVurHd9FnL762OcxzbUHLy09JeyIy7mpzekmuRjoRAcv
 icBw==
X-Gm-Message-State: APjAAAV6AjBEKCsAmbYztsMo1ZAyyzyv9L4vSJkLp50h7TNEhyDhr/6j
 2TcRGkJeYcVM7qUGwYxpx05P+TRQ4FQf4A==
X-Google-Smtp-Source: APXvYqxjeWXhQXvRUOAUq2zGUdATi0xchcsZa1tm9nJ8iM0CoSp1uoLRawZCbuERo0VXIdimiagPwg==
X-Received: by 2002:adf:a18a:: with SMTP id u10mr37083745wru.351.1560428124256; 
 Thu, 13 Jun 2019 05:15:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:31 +0100
Message-Id: <20190613121433.5246-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 46/48] target/arm: Convert VCVT fp/fixed-point
 conversion insns to decodetree
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

Convert the VCVT (between floating-point and fixed-point) instructions
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 124 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  57 +--------------
 target/arm/vfp.decode          |  10 +++
 3 files changed, 136 insertions(+), 55 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 161f0fdd888..db07fdd8736 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2454,3 +2454,127 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     tcg_temp_free_i32(vd);
     return true;
 }
+
+static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
+{
+    TCGv_i32 vd, shift;
+    TCGv_ptr fpst;
+    int frac_bits;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    frac_bits = (a->opc & 1) ? (32 - a->imm) : (16 - a->imm);
+
+    vd = tcg_temp_new_i32();
+    neon_load_reg32(vd, a->vd);
+
+    fpst = get_fpstatus_ptr(false);
+    shift = tcg_const_i32(frac_bits);
+
+    /* Switch on op:U:sx bits */
+    switch (a->opc) {
+    case 0:
+        gen_helper_vfp_shtos(vd, vd, shift, fpst);
+        break;
+    case 1:
+        gen_helper_vfp_sltos(vd, vd, shift, fpst);
+        break;
+    case 2:
+        gen_helper_vfp_uhtos(vd, vd, shift, fpst);
+        break;
+    case 3:
+        gen_helper_vfp_ultos(vd, vd, shift, fpst);
+        break;
+    case 4:
+        gen_helper_vfp_toshs_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 5:
+        gen_helper_vfp_tosls_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 6:
+        gen_helper_vfp_touhs_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 7:
+        gen_helper_vfp_touls_round_to_zero(vd, vd, shift, fpst);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i32(shift);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
+{
+    TCGv_i64 vd;
+    TCGv_i32 shift;
+    TCGv_ptr fpst;
+    int frac_bits;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    frac_bits = (a->opc & 1) ? (32 - a->imm) : (16 - a->imm);
+
+    vd = tcg_temp_new_i64();
+    neon_load_reg64(vd, a->vd);
+
+    fpst = get_fpstatus_ptr(false);
+    shift = tcg_const_i32(frac_bits);
+
+    /* Switch on op:U:sx bits */
+    switch (a->opc) {
+    case 0:
+        gen_helper_vfp_shtod(vd, vd, shift, fpst);
+        break;
+    case 1:
+        gen_helper_vfp_sltod(vd, vd, shift, fpst);
+        break;
+    case 2:
+        gen_helper_vfp_uhtod(vd, vd, shift, fpst);
+        break;
+    case 3:
+        gen_helper_vfp_ultod(vd, vd, shift, fpst);
+        break;
+    case 4:
+        gen_helper_vfp_toshd_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 5:
+        gen_helper_vfp_tosld_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 6:
+        gen_helper_vfp_touhd_round_to_zero(vd, vd, shift, fpst);
+        break;
+    case 7:
+        gen_helper_vfp_tould_round_to_zero(vd, vd, shift, fpst);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    neon_store_reg64(vd, a->vd);
+    tcg_temp_free_i64(vd);
+    tcg_temp_free_i32(shift);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d5347c55ad4..d7a77fca9ac 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1439,13 +1439,9 @@ static inline void gen_vfp_##name(int dp, int shift, int neon) \
     tcg_temp_free_i32(tmp_shift); \
     tcg_temp_free_ptr(statusptr); \
 }
-VFP_GEN_FIX(tosh, _round_to_zero)
 VFP_GEN_FIX(tosl, _round_to_zero)
-VFP_GEN_FIX(touh, _round_to_zero)
 VFP_GEN_FIX(toul, _round_to_zero)
-VFP_GEN_FIX(shto, )
 VFP_GEN_FIX(slto, )
-VFP_GEN_FIX(uhto, )
 VFP_GEN_FIX(ulto, )
 #undef VFP_GEN_FIX
 
@@ -3050,7 +3046,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 19:
+                case 0 ... 23:
+                case 28 ... 31:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3070,21 +3067,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     rd_is_dp = false;
                     break;
 
-                case 0x14: /* vcvt fp <-> fixed */
-                case 0x15:
-                case 0x16:
-                case 0x17:
-                case 0x1c:
-                case 0x1d:
-                case 0x1e:
-                case 0x1f:
-                    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                        return 1;
-                    }
-                    /* Immediate frac_bits has same format as SREG_M.  */
-                    rm_is_dp = false;
-                    break;
-
                 default:
                     return 1;
                 }
@@ -3143,17 +3125,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* Load the initial operands.  */
             if (op == 15) {
                 switch (rn) {
-                case 0x14: /* vcvt fp <-> fixed */
-                case 0x15:
-                case 0x16:
-                case 0x17:
-                case 0x1c:
-                case 0x1d:
-                case 0x1e:
-                case 0x1f:
-                    /* Source and destination the same.  */
-                    gen_mov_F0_vreg(dp, rd);
-                    break;
                 default:
                     /* One source operand.  */
                     gen_mov_F0_vreg(rm_is_dp, rm);
@@ -3170,18 +3141,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 20: /* fshto */
-                        gen_vfp_shto(dp, 16 - rm, 0);
-                        break;
-                    case 21: /* fslto */
-                        gen_vfp_slto(dp, 32 - rm, 0);
-                        break;
-                    case 22: /* fuhto */
-                        gen_vfp_uhto(dp, 16 - rm, 0);
-                        break;
-                    case 23: /* fulto */
-                        gen_vfp_ulto(dp, 32 - rm, 0);
-                        break;
                     case 24: /* ftoui */
                         gen_vfp_toui(dp, 0);
                         break;
@@ -3194,18 +3153,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 27: /* ftosiz */
                         gen_vfp_tosiz(dp, 0);
                         break;
-                    case 28: /* ftosh */
-                        gen_vfp_tosh(dp, 16 - rm, 0);
-                        break;
-                    case 29: /* ftosl */
-                        gen_vfp_tosl(dp, 32 - rm, 0);
-                        break;
-                    case 30: /* ftouh */
-                        gen_vfp_touh(dp, 16 - rm, 0);
-                        break;
-                    case 31: /* ftoul */
-                        gen_vfp_toul(dp, 32 - rm, 0);
-                        break;
                     default: /* undefined */
                         g_assert_not_reached();
                     }
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 1a7c9b533de..c3223a124ac 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -224,3 +224,13 @@ VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
 # VJCVT is always dp to sp
 VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+# VCVT between floating-point and fixed-point. The immediate value
+# is in the same format as a Vm single-precision register number.
+# We assemble bits 18 (op), 16 (u) and 7 (sx) into a single opc field
+# for the convenience of the trans_VCVT_fix functions.
+%vcvt_fix_op 18:1 16:1 7:1
+VCVT_fix_sp  ---- 1110 1.11 1.1. .... 1010 .1.0 .... \
+             vd=%vd_sp imm=%vm_sp opc=%vcvt_fix_op
+VCVT_fix_dp  ---- 1110 1.11 1.1. .... 1011 .1.0 .... \
+             vd=%vd_dp imm=%vm_sp opc=%vcvt_fix_op
-- 
2.20.1


