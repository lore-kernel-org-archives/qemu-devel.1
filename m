Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B33C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7573F20727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y17d7k8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7573F20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF8f-0006yu-Ix
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkr-0003yY-Bn
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkq-00060v-60
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id g12so32909131wmh.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FRhwFSZ1TECSB4lFWuDOjzFOexVaiixs5eYkbmksPNk=;
 b=Y17d7k8megR0tLCHzFYIP/w2DYwWQhQpZI2UTebYvDguCxxdZIRmNFI2uUS6VfdHOZ
 rPcVyk4BU0XB4lN0iWpMtawNmm8pyHE/2ngLgsJ06nyp5k0VC/ZSGuBnLAVg1xETd3no
 kV0W0vQZSMfVtYYGQl6S7dfDTszbAHmSmStOzAFIg83oQHq249cuOo0e6gQ1hH7ZL9qM
 kbyOD4y85VKT8wJGPhva6BtWwz1rwQ0vH7q+pMsKV153f0GdKWbbrrqxTBbK07q4EZyd
 IICQay8rnktIzFFhUgmBCZkdrRXKqV64yA3sLFd5TllU2+xfc275ANUrBnBB5fVCb/KP
 gGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FRhwFSZ1TECSB4lFWuDOjzFOexVaiixs5eYkbmksPNk=;
 b=RxV3TnQubGnXZkX1g7EpG/+eNc0iIcoqGl9qKTid076KGQf0ETsxdYV/umDGzrrp6e
 GrRotR/A7lWJIwaqEZ6ebwPHw8L6yOMqQjQF1Cnv2Fl+O0CO3eTYYNAK0HeUfsvixQhR
 DAyWj5qg7+OiXnsqC3BLnrC+8x0eyLnpTqkywW8yJWtROygrF2ApePZwzJQNRGcZRkGz
 Hp0j1U/zpAiWcmAqKDHjuBXDhqrU/GCEiGn9+Oc9L2Qk9s682uNjXTxsax9UspUOjKY7
 7Mh1vtjNb50/aq08ZXXJodS7+80gbokR4kaa1YH5wq448FEjCiQnMkG8drwG/Jpr9DPo
 TwPQ==
X-Gm-Message-State: AGi0PuYHtyfU2y2QnuxOEqCggEdbHFHuVYVxDHgSUmwo7wQQAnfmufdE
 JqNbpVjmErZ5wEx1l0K29NFuEIPFv1lKfQ==
X-Google-Smtp-Source: APiQypIxS9dJYSSTIH+iP9sc4GSX3PjP7LrD0MP08UcsMdwVz3feDgBap6dBnaUWBnpg3iYywi7/nw==
X-Received: by 2002:a1c:9ac3:: with SMTP id
 c186mr18378199wme.150.1589466150437; 
 Thu, 14 May 2020 07:22:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/45] target/arm: Convert Neon VADD, VSUB,
 VABD 3-reg-same insns to decodetree
Date: Thu, 14 May 2020 15:21:32 +0100
Message-Id: <20200514142138.20875-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Convert the Neon VADD, VSUB, VABD 3-reg-same insns to decodetree.
We already have gvec helpers for addition and subtraction, but must
add one for fabd.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-12-peter.maydell@linaro.org
---
 target/arm/helper.h             |  3 ++-
 target/arm/neon-dp.decode       |  8 ++++++++
 target/arm/neon_helper.c        |  7 -------
 target/arm/translate-neon.inc.c | 28 ++++++++++++++++++++++++++++
 target/arm/translate.c          | 10 +++-------
 target/arm/vec_helper.c         |  7 +++++++
 6 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1857f4ee46a..6e9629c87b0 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -396,7 +396,6 @@ DEF_HELPER_FLAGS_2(neon_qneg_s16, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(neon_qneg_s32, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(neon_qneg_s64, TCG_CALL_NO_RWG, i64, env, i64)
 
-DEF_HELPER_3(neon_abd_f32, i32, i32, i32, ptr)
 DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, ptr)
 DEF_HELPER_3(neon_cge_f32, i32, i32, i32, ptr)
 DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, ptr)
@@ -595,6 +594,8 @@ DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index fd32837fb17..0dd02f3b720 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -45,6 +45,10 @@
 @3same_q0        .... ... . . . size:2 .... .... .... . 0 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
 
+# For FP insns the high bit of 'size' is used as part of opcode decode
+@3same_fp        .... ... . . . . size:1 .... .... .... . q:1 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
 VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
 VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
@@ -169,3 +173,7 @@ SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... \
                  vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
 VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
+
+VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
+VSUB_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 2ef75e04c83..b637265691a 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -1825,13 +1825,6 @@ uint64_t HELPER(neon_qneg_s64)(CPUARMState *env, uint64_t x)
 }
 
 /* NEON Float helpers.  */
-uint32_t HELPER(neon_abd_f32)(uint32_t a, uint32_t b, void *fpstp)
-{
-    float_status *fpst = fpstp;
-    float32 f0 = make_float32(a);
-    float32 f1 = make_float32(b);
-    return float32_val(float32_abs(float32_sub(f0, f1, fpst)));
-}
 
 /* Floating point comparisons produce an integer result.
  * Note that EQ doesn't signal InvalidOp for QNaNs but GE and GT do.
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index f52302f42b1..540720f5e0d 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1021,3 +1021,31 @@ DO_3SAME_PAIR(VPADD, padd_u)
 
 DO_3SAME_VQDMULH(VQDMULH, qdmulh)
 DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
+
+/*
+ * For all the functions using this macro, size == 1 means fp16,
+ * which is an architecture extension we don't implement yet.
+ */
+#define DO_3S_FP_GVEC(INSN,FUNC)                                        \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        TCGv_ptr fpst = get_fpstatus_ptr(1);                            \
+        tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, fpst,                \
+                           oprsz, maxsz, 0, FUNC);                      \
+        tcg_temp_free_ptr(fpst);                                        \
+    }                                                                   \
+    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a)     \
+    {                                                                   \
+        if (a->size != 0) {                                             \
+            /* TODO fp16 support */                                     \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, gen_##INSN##_3s);                         \
+    }
+
+
+DO_3S_FP_GVEC(VADD, gen_helper_gvec_fadd_s)
+DO_3S_FP_GVEC(VSUB, gen_helper_gvec_fsub_s)
+DO_3S_FP_GVEC(VABD, gen_helper_gvec_fabd_s)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 561cb67286d..8a94856cd28 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5445,6 +5445,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         switch (op) {
         case NEON_3R_FLOAT_ARITH:
             pairwise = (u && size < 2); /* if VPADD (float) */
+            if (!pairwise) {
+                return 1; /* handled by decodetree */
+            }
             break;
         case NEON_3R_FLOAT_MINMAX:
             pairwise = u; /* if VPMIN/VPMAX (float) */
@@ -5501,16 +5504,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
             switch ((u << 2) | size) {
-            case 0: /* VADD */
             case 4: /* VPADD */
                 gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
                 break;
-            case 2: /* VSUB */
-                gen_helper_vfp_subs(tmp, tmp, tmp2, fpstatus);
-                break;
-            case 6: /* VABD */
-                gen_helper_neon_abd_f32(tmp, tmp, tmp2, fpstatus);
-                break;
             default:
                 abort();
             }
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index fa33df859e5..50a499299fd 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -691,6 +691,11 @@ static float64 float64_ftsmul(float64 op1, uint64_t op2, float_status *stat)
     return result;
 }
 
+static float32 float32_abd(float32 op1, float32 op2, float_status *stat)
+{
+    return float32_abs(float32_sub(op1, op2, stat));
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
@@ -718,6 +723,8 @@ DO_3OP(gvec_ftsmul_h, float16_ftsmul, float16)
 DO_3OP(gvec_ftsmul_s, float32_ftsmul, float32)
 DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
 
+DO_3OP(gvec_fabd_s, float32_abd, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
-- 
2.20.1


