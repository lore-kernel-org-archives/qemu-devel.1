Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5900C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2F8206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzzHaGO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2F8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOUs-000431-Vo
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSn-0001We-5v
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40620)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSl-0003sr-EJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r15so5315141wmh.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FZ8prL94hg9EnftAZeIn2FC6K26efpGZiHbA6LxJ8Ns=;
 b=MzzHaGO9uUDAgaJ4CRux/tQER3xf2CFf8gRwxhiAHbRJtJwwwaZDSYUPYJF+wkM3Or
 J9QO+6W57d5/V8NBKrceIi29m8/4O1oOElNwxhNswDgVXeojlb5YkG5xe7iXxnF4lS6I
 7qb2QFjKQiQzhcO/7IMwiJ3bcvz3gMHWWA6+snIw/qNiiD/Q3GMj1OIfIP16NdNjgjrF
 VK87yoRpgxfe1a0Oxem4zrzvve2oSCRf286QGrOYya90ziHEcUtm5oshRrSGA5RzBPKw
 fuRr4Yl0MkCYgOg8SPwkqr59BVUWTodzMhbECXf/xSaswGIllcBGpxh3MbZ8bpjAYhUy
 g30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FZ8prL94hg9EnftAZeIn2FC6K26efpGZiHbA6LxJ8Ns=;
 b=NY42Ztsrqxm6NNNP0BodXE5ORSD3PYxUKRSIZs6HwbFc5mGo+ihv6Q/AvlrFfq0pD0
 q81huCUi58te0aF/dLpSMEL2PrkHUSBDtdXdbnIyyYbvBJvI6URt+ufKfrDW2aEmGIzS
 K89J9Pw+auv7OuZyc6Ep7ObCXOpHqPlqcJw3ig0eaT1qXCvdQgDvrNeMdiQBZ1SCi4QB
 uqnekQm/CgL9BEcRXpSd0yGMIQGNzpW0O/DlC6XY8G68yBkYmnMOryskGHE0LmcRDdww
 epeNNb9YoIlrGjMDYDdZVXczX+RHu2usOYryfBJ0Q2NjhkVFZGW3UrI5h5R04Ey7vlks
 9CEQ==
X-Gm-Message-State: AOAM531nCiVuBYGZ9Ky/jDcEAxenvxeIUvvHCbk6/hBDNHgpzwBLRl0D
 T5Z7YabHHu+/f8S+vbOb8zii1g==
X-Google-Smtp-Source: ABdhPJw0JgzDor4B4HInC3F58OJ40u9IQbH5gKCRY8W6/bcSehf4GkxCOWb9TSxemVo6YvY99mUS0g==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr8392776wmh.6.1591886741583;
 Thu, 11 Jun 2020 07:45:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/10] target/arm: Convert Neon 2-reg-scalar long multiplies
 to decodetree
Date: Thu, 11 Jun 2020 15:45:26 +0100
Message-Id: <20200611144529.8873-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
References: <20200611144529.8873-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Convert the Neon 2-reg-scalar long multiplies to decodetree.
These are the last instructions in the group.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  18 ++++
 target/arm/translate-neon.inc.c | 163 ++++++++++++++++++++++++++++
 target/arm/translate.c          | 182 ++------------------------------
 3 files changed, 187 insertions(+), 176 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 7b069abe628..9ff182f56d7 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -476,16 +476,34 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     @2scalar     .... ... q:1 . . size:2 .... .... .... . . . . .... \
                  &2scalar vm=%vm_dp vn=%vn_dp vd=%vd_dp
+    # For the 'long' ops the Q bit is part of insn decode
+    @2scalar_q0  .... ... . . . size:2 .... .... .... . . . . .... \
+                 &2scalar vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
 
     VMLA_2sc     1111 001 . 1 . .. .... .... 0000 . 1 . 0 .... @2scalar
     VMLA_F_2sc   1111 001 . 1 . .. .... .... 0001 . 1 . 0 .... @2scalar
 
+    VMLAL_S_2sc  1111 001 0 1 . .. .... .... 0010 . 1 . 0 .... @2scalar_q0
+    VMLAL_U_2sc  1111 001 1 1 . .. .... .... 0010 . 1 . 0 .... @2scalar_q0
+
+    VQDMLAL_2sc  1111 001 0 1 . .. .... .... 0011 . 1 . 0 .... @2scalar_q0
+
     VMLS_2sc     1111 001 . 1 . .. .... .... 0100 . 1 . 0 .... @2scalar
     VMLS_F_2sc   1111 001 . 1 . .. .... .... 0101 . 1 . 0 .... @2scalar
 
+    VMLSL_S_2sc  1111 001 0 1 . .. .... .... 0110 . 1 . 0 .... @2scalar_q0
+    VMLSL_U_2sc  1111 001 1 1 . .. .... .... 0110 . 1 . 0 .... @2scalar_q0
+
+    VQDMLSL_2sc  1111 001 0 1 . .. .... .... 0111 . 1 . 0 .... @2scalar_q0
+
     VMUL_2sc     1111 001 . 1 . .. .... .... 1000 . 1 . 0 .... @2scalar
     VMUL_F_2sc   1111 001 . 1 . .. .... .... 1001 . 1 . 0 .... @2scalar
 
+    VMULL_S_2sc  1111 001 0 1 . .. .... .... 1010 . 1 . 0 .... @2scalar_q0
+    VMULL_U_2sc  1111 001 1 1 . .. .... .... 1010 . 1 . 0 .... @2scalar_q0
+
+    VQDMULL_2sc  1111 001 0 1 . .. .... .... 1011 . 1 . 0 .... @2scalar_q0
+
     VQDMULH_2sc  1111 001 . 1 . .. .... .... 1100 . 1 . 0 .... @2scalar
     VQRDMULH_2sc 1111 001 . 1 . .. .... .... 1101 . 1 . 0 .... @2scalar
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 19344ac331d..f054b567c8f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2649,3 +2649,166 @@ static bool trans_VQRDMLSH_2sc(DisasContext *s, arg_2scalar *a)
     };
     return do_vqrdmlah_2sc(s, a, opfn[a->size]);
 }
+
+static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
+                            NeonGenTwoOpWidenFn *opfn,
+                            NeonGenTwo64OpFn *accfn)
+{
+    /*
+     * Two registers and a scalar, long operations: perform an
+     * operation on the input elements and the scalar which produces
+     * a double-width result, and then possibly perform an accumulation
+     * operation of that result into the destination.
+     */
+    TCGv_i32 scalar, rn;
+    TCGv_i64 rn0_64, rn1_64;
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
+    if (!opfn) {
+        /* Bad size (including size == 3, which is a different insn group) */
+        return false;
+    }
+
+    if (a->vd & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    scalar = neon_get_scalar(a->size, a->vm);
+
+    /* Load all inputs before writing any outputs, in case of overlap */
+    rn = neon_load_reg(a->vn, 0);
+    rn0_64 = tcg_temp_new_i64();
+    opfn(rn0_64, rn, scalar);
+    tcg_temp_free_i32(rn);
+
+    rn = neon_load_reg(a->vn, 1);
+    rn1_64 = tcg_temp_new_i64();
+    opfn(rn1_64, rn, scalar);
+    tcg_temp_free_i32(rn);
+    tcg_temp_free_i32(scalar);
+
+    if (accfn) {
+        TCGv_i64 t64 = tcg_temp_new_i64();
+        neon_load_reg64(t64, a->vd);
+        accfn(t64, t64, rn0_64);
+        neon_store_reg64(t64, a->vd);
+        neon_load_reg64(t64, a->vd + 1);
+        accfn(t64, t64, rn1_64);
+        neon_store_reg64(t64, a->vd + 1);
+        tcg_temp_free_i64(t64);
+    } else {
+        neon_store_reg64(rn0_64, a->vd);
+        neon_store_reg64(rn1_64, a->vd + 1);
+    }
+    tcg_temp_free_i64(rn0_64);
+    tcg_temp_free_i64(rn1_64);
+    return true;
+}
+
+static bool trans_VMULL_S_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_helper_neon_mull_s16,
+        gen_mull_s32,
+        NULL,
+    };
+
+    return do_2scalar_long(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VMULL_U_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_helper_neon_mull_u16,
+        gen_mull_u32,
+        NULL,
+    };
+
+    return do_2scalar_long(s, a, opfn[a->size], NULL);
+}
+
+#define DO_VMLAL_2SC(INSN, MULL, ACC)                                   \
+    static bool trans_##INSN##_2sc(DisasContext *s, arg_2scalar *a)     \
+    {                                                                   \
+        static NeonGenTwoOpWidenFn * const opfn[] = {                   \
+            NULL,                                                       \
+            gen_helper_neon_##MULL##16,                                 \
+            gen_##MULL##32,                                             \
+            NULL,                                                       \
+        };                                                              \
+        static NeonGenTwo64OpFn * const accfn[] = {                     \
+            NULL,                                                       \
+            gen_helper_neon_##ACC##l_u32,                               \
+            tcg_gen_##ACC##_i64,                                        \
+            NULL,                                                       \
+        };                                                              \
+        return do_2scalar_long(s, a, opfn[a->size], accfn[a->size]);    \
+    }
+
+DO_VMLAL_2SC(VMLAL_S, mull_s, add)
+DO_VMLAL_2SC(VMLAL_U, mull_u, add)
+DO_VMLAL_2SC(VMLSL_S, mull_s, sub)
+DO_VMLAL_2SC(VMLSL_U, mull_u, sub)
+
+static bool trans_VQDMULL_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+
+    return do_2scalar_long(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VQDMLAL_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const accfn[] = {
+        NULL,
+        gen_VQDMLAL_acc_16,
+        gen_VQDMLAL_acc_32,
+        NULL,
+    };
+
+    return do_2scalar_long(s, a, opfn[a->size], accfn[a->size]);
+}
+
+static bool trans_VQDMLSL_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        NULL,
+        gen_VQDMULL_16,
+        gen_VQDMULL_32,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const accfn[] = {
+        NULL,
+        gen_VQDMLSL_acc_16,
+        gen_VQDMLSL_acc_32,
+        NULL,
+    };
+
+    return do_2scalar_long(s, a, opfn[a->size], accfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f0db029f66d..4d39bbf035b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -377,43 +377,6 @@ static void gen_revsh(TCGv_i32 dest, TCGv_i32 var)
     tcg_gen_ext16s_i32(dest, var);
 }
 
-/* 32x32->64 multiply.  Marks inputs as dead.  */
-static TCGv_i64 gen_mulu_i64_i32(TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 lo = tcg_temp_new_i32();
-    TCGv_i32 hi = tcg_temp_new_i32();
-    TCGv_i64 ret;
-
-    tcg_gen_mulu2_i32(lo, hi, a, b);
-    tcg_temp_free_i32(a);
-    tcg_temp_free_i32(b);
-
-    ret = tcg_temp_new_i64();
-    tcg_gen_concat_i32_i64(ret, lo, hi);
-    tcg_temp_free_i32(lo);
-    tcg_temp_free_i32(hi);
-
-    return ret;
-}
-
-static TCGv_i64 gen_muls_i64_i32(TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 lo = tcg_temp_new_i32();
-    TCGv_i32 hi = tcg_temp_new_i32();
-    TCGv_i64 ret;
-
-    tcg_gen_muls2_i32(lo, hi, a, b);
-    tcg_temp_free_i32(a);
-    tcg_temp_free_i32(b);
-
-    ret = tcg_temp_new_i64();
-    tcg_gen_concat_i32_i64(ret, lo, hi);
-    tcg_temp_free_i32(lo);
-    tcg_temp_free_i32(hi);
-
-    return ret;
-}
-
 /* Swap low and high halfwords.  */
 static void gen_swap_half(TCGv_i32 var)
 {
@@ -3164,58 +3127,6 @@ static inline void gen_neon_addl(int size)
     }
 }
 
-static inline void gen_neon_negl(TCGv_i64 var, int size)
-{
-    switch (size) {
-    case 0: gen_helper_neon_negl_u16(var, var); break;
-    case 1: gen_helper_neon_negl_u32(var, var); break;
-    case 2:
-        tcg_gen_neg_i64(var, var);
-        break;
-    default: abort();
-    }
-}
-
-static inline void gen_neon_addl_saturate(TCGv_i64 op0, TCGv_i64 op1, int size)
-{
-    switch (size) {
-    case 1: gen_helper_neon_addl_saturate_s32(op0, cpu_env, op0, op1); break;
-    case 2: gen_helper_neon_addl_saturate_s64(op0, cpu_env, op0, op1); break;
-    default: abort();
-    }
-}
-
-static inline void gen_neon_mull(TCGv_i64 dest, TCGv_i32 a, TCGv_i32 b,
-                                 int size, int u)
-{
-    TCGv_i64 tmp;
-
-    switch ((size << 1) | u) {
-    case 0: gen_helper_neon_mull_s8(dest, a, b); break;
-    case 1: gen_helper_neon_mull_u8(dest, a, b); break;
-    case 2: gen_helper_neon_mull_s16(dest, a, b); break;
-    case 3: gen_helper_neon_mull_u16(dest, a, b); break;
-    case 4:
-        tmp = gen_muls_i64_i32(a, b);
-        tcg_gen_mov_i64(dest, tmp);
-        tcg_temp_free_i64(tmp);
-        break;
-    case 5:
-        tmp = gen_mulu_i64_i32(a, b);
-        tcg_gen_mov_i64(dest, tmp);
-        tcg_temp_free_i64(tmp);
-        break;
-    default: abort();
-    }
-
-    /* gen_helper_neon_mull_[su]{8|16} do not free their parameters.
-       Don't forget to clean them now.  */
-    if (size < 2) {
-        tcg_temp_free_i32(a);
-        tcg_temp_free_i32(b);
-    }
-}
-
 static void gen_neon_narrow_op(int op, int u, int size,
                                TCGv_i32 dest, TCGv_i64 src)
 {
@@ -5120,7 +5031,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int u;
     int vec_size;
     uint32_t imm;
-    TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
+    TCGv_i32 tmp, tmp2, tmp3, tmp5;
     TCGv_ptr ptr1;
     TCGv_i64 tmp64;
 
@@ -5158,92 +5069,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         return 1;
     } else { /* (insn & 0x00800010 == 0x00800000) */
         if (size != 3) {
-            op = (insn >> 8) & 0xf;
-            if ((insn & (1 << 6)) == 0) {
-                /* Three registers of different lengths: handled by decodetree */
-                return 1;
-            } else {
-                /* Two registers and a scalar. NB that for ops of this form
-                 * the ARM ARM labels bit 24 as Q, but it is in our variable
-                 * 'u', not 'q'.
-                 */
-                if (size == 0) {
-                    return 1;
-                }
-                switch (op) {
-                case 0: /* Integer VMLA scalar */
-                case 4: /* Integer VMLS scalar */
-                case 8: /* Integer VMUL scalar */
-                case 1: /* Float VMLA scalar */
-                case 5: /* Floating point VMLS scalar */
-                case 9: /* Floating point VMUL scalar */
-                case 12: /* VQDMULH scalar */
-                case 13: /* VQRDMULH scalar */
-                case 14: /* VQRDMLAH scalar */
-                case 15: /* VQRDMLSH scalar */
-                    return 1; /* handled by decodetree */
-
-                case 3: /* VQDMLAL scalar */
-                case 7: /* VQDMLSL scalar */
-                case 11: /* VQDMULL scalar */
-                    if (u == 1) {
-                        return 1;
-                    }
-                    /* fall through */
-                case 2: /* VMLAL sclar */
-                case 6: /* VMLSL scalar */
-                case 10: /* VMULL scalar */
-                    if (rd & 1) {
-                        return 1;
-                    }
-                    tmp2 = neon_get_scalar(size, rm);
-                    /* We need a copy of tmp2 because gen_neon_mull
-                     * deletes it during pass 0.  */
-                    tmp4 = tcg_temp_new_i32();
-                    tcg_gen_mov_i32(tmp4, tmp2);
-                    tmp3 = neon_load_reg(rn, 1);
-
-                    for (pass = 0; pass < 2; pass++) {
-                        if (pass == 0) {
-                            tmp = neon_load_reg(rn, 0);
-                        } else {
-                            tmp = tmp3;
-                            tmp2 = tmp4;
-                        }
-                        gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
-                        if (op != 11) {
-                            neon_load_reg64(cpu_V1, rd + pass);
-                        }
-                        switch (op) {
-                        case 6:
-                            gen_neon_negl(cpu_V0, size);
-                            /* Fall through */
-                        case 2:
-                            gen_neon_addl(size);
-                            break;
-                        case 3: case 7:
-                            gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
-                            if (op == 7) {
-                                gen_neon_negl(cpu_V0, size);
-                            }
-                            gen_neon_addl_saturate(cpu_V0, cpu_V1, size);
-                            break;
-                        case 10:
-                            /* no-op */
-                            break;
-                        case 11:
-                            gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
-                            break;
-                        default:
-                            abort();
-                        }
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    }
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-            }
+            /*
+             * Three registers of different lengths, or two registers and
+             * a scalar: handled by decodetree
+             */
+            return 1;
         } else { /* size == 3 */
             if (!u) {
                 /* Extract.  */
-- 
2.20.1


