Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9611BCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581E8206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H85ZFcM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581E8206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY6E-0002zV-Du
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwG-0006n7-4y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwE-0006HH-KP
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id z72so14581697wmc.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1c0sA0VXCHDtNOClCYM5tpbz5xGR3LiI9SrLPs+uUSg=;
 b=H85ZFcM4wC8Nx3ytnFQ4rLCqrDo43ErNcpKuCE+SmKuNSHy4wNeqlruoMSw9wufrVZ
 lbEurnaLHpZCEmy1AWEs/t613po1I+RY4rcA7j+KBAKp90IFW6A6ekVY2agTI3wh/Kp/
 ZIKo9yDw/FwYUdoltiRYwickGkqg0QVvvFypFQ9P/p0K12mzBnmiA2tSLYmcznoeozKj
 r1A5Wf6BfmKhJoeSIZ3uoBPN0tUlyzD2eV6G4hG/x/NyJaX7Hi0wUnYr+116H5FHXSIm
 l8Xg5YxvI6A1X+/MLe4QHSHOlVnpAEdy25HqkyGvV0FkkdD4eUQf0mSy+38otWFBxH8u
 tXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1c0sA0VXCHDtNOClCYM5tpbz5xGR3LiI9SrLPs+uUSg=;
 b=ZhVgyuyg5+kUkSymvOr4HNmlb1XuBJv92SP673/IBcYplZvatjp95yyDFiptKGoaxE
 Xd/+2XzyN+hiMQFTVelMgm2q/Xk/6kruqHvxlMbKR4imABdJuCVTN1lTUQ2UjLzHrBvL
 3CnahkkbJrx+uDFfTmyat7Zfg7beIpeMO6vy4UrETrbRcSYZSsi9bbB18TW9wSfUB4bP
 mcUg3y5m8P8POmXOoheLQiiSMIO+LzxAvSCLdBPUT3ePcRi6nbU8/WNq9YP4PzVK6Ue6
 of5jIIjo472NM4F6YGWKZ++OLuybZ2+1tu3KzwEBv5ZCCglAdRwztvWqqmHNMz+uYmte
 aE0Q==
X-Gm-Message-State: AGi0PuZz16T9z/T9COtfxUmLReqjb1400jtgKbBqawNjU1aXZDehfE1r
 Gp5+Nc6vTZsF75uGVejmR6U8eL0PfaQGGA==
X-Google-Smtp-Source: APiQypLkXud+KEFktjTWJ6/AhoGbpTnA/492feSQC2AMiIQokmM9DD2/nszpNQnwd02rJCIkiOw+PA==
X-Received: by 2002:a7b:caf2:: with SMTP id t18mr15665722wml.35.1589301565036; 
 Tue, 12 May 2020 09:39:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/17] target/arm: Convert Neon fp VMUL, VMLA,
 VMLS 3-reg-same insns to decodetree
Date: Tue, 12 May 2020 17:39:00 +0100
Message-Id: <20200512163904.10918-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon integer VMUL, VMLA, and VMLS 3-reg-same inssn to
decodetree.

We don't have a gvec helper for multiply-accumulate, so VMLA and VMLS
need a loop function do_3same_fp().  This takes a reads_vd parameter
to do_3same_fp() which tells it to load the old value into vd before
calling the callback function, in the same way that the do_vfp_3op_sp()
and do_vfp_3op_dp() functions in translate-vfp.inc.c work. (The
only uses in this patch pass reads_vd == true, but later commits
will use reads_vd == false.)

This conversion fixes in passing an underdecoding for VMUL
(originally reported by Fredrik Strupe <fredrik@strupe.net>): bit 1
of the 'size' field must be 0.  The old decoder didn't enforce this,
but the decodetree pattern does.

The gen_VMLA_fp_reg() function performs the addition operation
with the operands in the opposite order to the old decoder:
since Neon sets 'default NaN mode' float32_add operations are
commutative so there is no behaviour difference, but putting
them this way around matches the Arm ARM pseudocode and the
required operation order for the subtraction in gen_VMLS_fp_reg().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 81 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 17 +------
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 1f289750dcd..0f74b31dcd1 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -181,5 +181,8 @@ VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
 VSUB_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
 VPADD_fp_3s      1111 001 1 0 . 0 . .... .... 1101 ... 0 .... @3same_fp_q0
 VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VMLA_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
+VMLS_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 1 .... @3same_fp
+VMUL_fp_3s       1111 001 1 0 . 0 . .... .... 1101 ... 1 .... @3same_fp
 VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
 VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7bdf1e3fee8..18896598bb4 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1022,6 +1022,55 @@ DO_3SAME_PAIR(VPADD, padd_u)
 DO_3SAME_VQDMULH(VQDMULH, qdmulh)
 DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
 
+static bool do_3same_fp(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn,
+                        bool reads_vd)
+{
+    /*
+     * FP operations handled elementwise 32 bits at a time.
+     * If reads_vd is true then the old value of Vd will be
+     * loaded before calling the callback function. This is
+     * used for multiply-accumulate type operations.
+     */
+    TCGv_i32 tmp, tmp2;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    TCGv_ptr fpstatus = get_fpstatus_ptr(1);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        tmp = neon_load_reg(a->vn, pass);
+        tmp2 = neon_load_reg(a->vm, pass);
+        if (reads_vd) {
+            TCGv_i32 tmp_rd = neon_load_reg(a->vd, pass);
+            fn(tmp_rd, tmp, tmp2, fpstatus);
+            neon_store_reg(a->vd, pass, tmp_rd);
+            tcg_temp_free_i32(tmp);
+        } else {
+            fn(tmp, tmp, tmp2, fpstatus);
+            neon_store_reg(a->vd, pass, tmp);
+        }
+        tcg_temp_free_i32(tmp2);
+    }
+    tcg_temp_free_ptr(fpstatus);
+    return true;
+}
+
 /*
  * For all the functions using this macro, size == 1 means fp16,
  * which is an architecture extension we don't implement yet.
@@ -1049,6 +1098,38 @@ DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
 DO_3S_FP_GVEC(VADD, gen_helper_gvec_fadd_s)
 DO_3S_FP_GVEC(VSUB, gen_helper_gvec_fsub_s)
 DO_3S_FP_GVEC(VABD, gen_helper_gvec_fabd_s)
+DO_3S_FP_GVEC(VMUL, gen_helper_gvec_fmul_s)
+
+/*
+ * For all the functions using this macro, size == 1 means fp16,
+ * which is an architecture extension we don't implement yet.
+ */
+#define DO_3S_FP(INSN,FUNC,READS_VD)                                \
+    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
+    {                                                               \
+        if (a->size != 0) {                                         \
+            /* TODO fp16 support */                                 \
+            return false;                                           \
+        }                                                           \
+        return do_3same_fp(s, a, FUNC, READS_VD);                   \
+    }
+
+static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
+                            TCGv_ptr fpstatus)
+{
+    gen_helper_vfp_muls(vn, vn, vm, fpstatus);
+    gen_helper_vfp_adds(vd, vd, vn, fpstatus);
+}
+
+static void gen_VMLS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
+                            TCGv_ptr fpstatus)
+{
+    gen_helper_vfp_muls(vn, vn, vm, fpstatus);
+    gen_helper_vfp_subs(vd, vd, vn, fpstatus);
+}
+
+DO_3S_FP(VMLA, gen_VMLA_fp_3s, true)
+DO_3S_FP(VMLS, gen_VMLS_fp_3s, true)
 
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ca6ed09ec34..06b6925d31e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5433,6 +5433,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VQDMULH_VQRDMULH:
         case NEON_3R_FLOAT_ARITH:
+        case NEON_3R_FLOAT_MULTIPLY:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5479,22 +5480,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         tmp = neon_load_reg(rn, pass);
         tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_MULTIPLY:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            gen_helper_vfp_muls(tmp, tmp, tmp2, fpstatus);
-            if (!u) {
-                tcg_temp_free_i32(tmp2);
-                tmp2 = neon_load_reg(rd, pass);
-                if (size == 0) {
-                    gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
-                } else {
-                    gen_helper_vfp_subs(tmp, tmp2, tmp, fpstatus);
-                }
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
         case NEON_3R_FLOAT_CMP:
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.20.1


