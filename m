Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEAAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841292054F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4rAA2HK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841292054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFGU-00086U-LP
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkt-00043t-Rk
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEks-00061E-Kx
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id z72so23311894wmc.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GFvmd5zbpcn7bQMEd5IvmIkHSHj20IaZOGguSx76NLA=;
 b=x4rAA2HKd7QE4T9mOcwmQkJtBw6SEaNO4yi4vCpTuwl9sTYB8j7urJCbm8FLevHh5i
 kP/id2yNzBr8PDOmNECQJBvmKZ7rl3ZxE/RHsMqKUR36RxvmWWroecfXea9kzn3Fcppu
 8eHKFzH/UjfYFZOpyTT+ApjgM9Syf+H0HnCjHm1EXQQthqUQf9xqa7l5S1p8kHnaG8Cn
 D3oUrJ9kvJ35vYCHCNkaowmc1ioHKXFfZ8BWGz3X5nACsNlEhFB2gWX//bjiRmnNWIhw
 Pv3OFi3cYxpG5hUQxgHLUsHri3th+ycCzMWse7mdXZkauDjH2kZpViSDF9RrW9aySinl
 TOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GFvmd5zbpcn7bQMEd5IvmIkHSHj20IaZOGguSx76NLA=;
 b=pH4orNUqIb66gLbAX9KJYtII82DFsCShA/gDLCwa+P/pb5HfkIMmMPfRhCpDSbBBhk
 0Z4jSEs8/OkNtlnQRAR19aOem5QNWQqogLYtCcqMiX5GVS9NtWdjVo6p/AsM7w+AXSmJ
 Ka2ef6BXF2xd3aDt0WjximvDvLGRlp0SOXCQ3FLt2RZVsAfWpQL+WudUhS1mt9Vzagxa
 xKeacTnK/JzDf8qPPWPntONd6pkmzwDqktm/9VHy1TZoD5pXEMti7sSeR9EVMNzXAgku
 n4/fe6WuQT+VpBlwgsBSrOojCZFyE3TEzUL7X205phz7zGJT5jT5ZqWCwTTW/zccqirt
 i3NA==
X-Gm-Message-State: AOAM533tH1IQ8/YmjqRwaLAen1mXE4jtEKePAYvqq4jMsYzqcYisC0Im
 +pHJDw9Kd5spKW0BzIDAZ32calVkgt+Idg==
X-Google-Smtp-Source: ABdhPJy3xvzvRfDWMH40vIf5KeM1GFPe6i9dHVsmt30hxKBsB1pGkYAtjovyrJV+bcTaKASa5qVkIA==
X-Received: by 2002:a1c:5985:: with SMTP id n127mr8726205wmb.64.1589466152764; 
 Thu, 14 May 2020 07:22:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/45] target/arm: Convert Neon fp VMUL, VMLA,
 VMLS 3-reg-same insns to decodetree
Date: Thu, 14 May 2020 15:21:34 +0100
Message-Id: <20200514142138.20875-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-14-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 81 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 17 +------
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index d66c67ca585..4c2f8c770d1 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -180,5 +180,8 @@ VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
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


