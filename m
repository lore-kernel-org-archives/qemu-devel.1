Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4BDC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20E72089E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIHzwYWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20E72089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwmq-0006rd-Oy
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:06:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTz-0004Ku-Pq
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTx-0003sZ-1O
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTt-0003My-4K
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so3338631wrs.5
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=c9wOcnXEMnU8Sqyypn+VOjsCvFWMEHtBhszMawwOJzg=;
	b=YIHzwYWlPN9XNcQkaGgoiqI/SwuscJLDYpvR0inVQJ3S8ZyaK+6j2PjJBAEV9aSe5j
	UOAYmZPbSMkTg8gN2Cu26HjhqhspacEIhv3UnQ6ig8OaLZVeZBl50LqmMf8n+Qoifdtv
	W8FyPAVqieHV/k3wRnLWNWL6f0waGT2k+AGH7rxLxTwoPdTMhjcGHnmylh+KBC+OlImN
	uFnwvEp+0WLrzr5mWUgsy+aJzOig6t2/KnY0MRT9TGnG054KczFxugLW7Lu8vhxbJK1N
	6S5OtaxQYs921IX63ssJeOwmTX6etM1XJ3TZfTH20YZdUFTkHA0BDUJ913x1svjALEbz
	orfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=c9wOcnXEMnU8Sqyypn+VOjsCvFWMEHtBhszMawwOJzg=;
	b=qFCzB3cbP7lWdqmErfkmtWztHG4GyALsLdhKs9wcv2QPBYLbPjRNZBhXyktrwgT2MO
	JqWbhjwTNlT/mFVqymg4w4hwVj2Ydx/weE1LFR/uXte67LKuJo1QMs6QQDacqjxUUQM/
	RC5OVOeXilrdwKeAomjADcL1EnEK9IrPHLezZ2ILiHlJh/5GuF/YgBVHi7e84T/T50ss
	Id1NNXbI4pF180O7B3wxb3JiBGaconB/AfCpmKGIu0s26Q/Xk2n9Y0y+JmXL9LFdZ4I/
	N1+nK89jBvUd2XKFtq/Zz4sXk9m13HYDc0KjpJlml6TcNMZyw+qNufICmoZxm9XUILob
	YzWw==
X-Gm-Message-State: APjAAAXLoJ1UQE/lQXz2NEQO2zxWlSeEkDHS0fuFw9vWMEwrNGgc/BMK
	i33WNdd2EYQriJ+RCD+2xJFp0Q==
X-Google-Smtp-Source: APXvYqxA69KFeWt8OhAqoZsYu11FV/wQ2lcCUk4kxBHfp1kmYzWlZApG7oSMJSKamAIxilUr8jOUMw==
X-Received: by 2002:adf:e309:: with SMTP id b9mr30659940wrj.135.1559843215650; 
	Thu, 06 Jun 2019 10:46:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:07 +0100
Message-Id: <20190606174609.20487-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 40/42] target/arm: Convert VCVT fp/fixed-point
 conversion insns to decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VCVT (between floating-point and fixed-point) instructions
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 124 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  57 +--------------
 target/arm/vfp.decode          |  10 +++
 3 files changed, 136 insertions(+), 55 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 9bc852076a0..80804ebff90 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2442,3 +2442,127 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
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
index 687ef093f97..16c24aafc98 100644
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


