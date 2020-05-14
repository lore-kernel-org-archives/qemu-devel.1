Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B794BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684E12070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUROHBJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684E12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEvl-0000Ul-CL
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkD-00034J-Uh
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkC-0005SK-Jl
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id i15so4311956wrx.10
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7t/S3jgVo6mBZ1+ru7bXNvY462zbAy/5ahkw4fshZNI=;
 b=xUROHBJLci/4qvSFIiWphFn9vJJDecEJ56ltrla9iHNvxtaovkPHfgsuL1pvYseXq0
 jCclTeYHyxl30i9fOi2LWF/+vRL4B+LtkFRh30qTgpoMkxeb6MavhNEuX0p6aZaq5Mas
 d78FtsAHOoWFzGnWvy/ZoQLPUoJ78cgFMaKEx6c6xwSPtlsyJ67VhqBev8e23Hmogrn0
 L5885fGuB/cJkIUfZv9E2FsQVdQLRBT3ohVkz9qOxI0uojwMb7tPwYNw7SqTlF+mSOOg
 UmJoKtQDddaGVh3APTs+BTPzZtq+e9WStA6/BG1t7dsoJwiAZDrH4POJTo/R1FPuszRs
 Fp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7t/S3jgVo6mBZ1+ru7bXNvY462zbAy/5ahkw4fshZNI=;
 b=H8zSyO5l2N2Bp46mpFlclxUewDNGpIZYoi6evrsLpfi9JdzW4jSZ0ADGUIBPNtRWqq
 rQHq7HnxEu7Jw91NIoQVBwAkpA6ibCAf3Y4rPl7D/AO4yGERTt9igzfwK4rqdijy2deR
 1PcZ4faG403BkpggpudbMaURg3zqm4A6dqt60GvEFCthce5q7wL2CnGH1BaXN/ikmr7A
 qB2GkxsS4PgA/5hiFwzJNzC0DLrSYt6kB++1wwSg8iLlZ+TNOyg5/aW7U3SR48tlIRxl
 7vA/INQdfQUYM4XYuiU3os/a5WzbxH5WIAprnQ+QQ3hQC2QYZEpL+/kstj00ukS9Rlex
 nliw==
X-Gm-Message-State: AOAM531CVSDt9c/fYMa+DOW/RuHtGmlAUSWXBHPNkATDqSTud8tBxjC2
 2JOzUXQQt3Tag7QhEKR8ZpE0UVC91B4DOQ==
X-Google-Smtp-Source: ABdhPJzBJrpioA71mEs/JB2DaKbgTJSCMmqblubVPhywrmHTb0Lfp8iP/i3U4WP1J8G44ADOhhgV2g==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr5675384wrw.325.1589466110705; 
 Thu, 14 May 2020 07:21:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/45] target/arm: Create gen_gvec_{ceq,clt,cle,cgt,cge}0
Date: Thu, 14 May 2020 15:21:00 +0100
Message-Id: <20200514142138.20875-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Macro-ize the 5 nearly identical comparisons.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     |  16 ++-
 target/arm/translate-a64.c |  22 ++--
 target/arm/translate.c     | 254 ++++++++-----------------------------
 3 files changed, 74 insertions(+), 218 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index fa5c3f12b96..e35c812cc5e 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -275,11 +275,17 @@ static inline void gen_swstep_exception(DisasContext *s, int isv, int ex)
 uint64_t vfp_expand_imm(int size, uint8_t imm8);
 
 /* Vector operations shared between ARM and AArch64.  */
-extern const GVecGen2 ceq0_op[4];
-extern const GVecGen2 clt0_op[4];
-extern const GVecGen2 cgt0_op[4];
-extern const GVecGen2 cle0_op[4];
-extern const GVecGen2 cge0_op[4];
+void gen_gvec_ceq0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_clt0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_cgt0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_cle0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_cge0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   uint32_t opr_sz, uint32_t max_sz);
+
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d5e77f34a7c..fef93dc27af 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -577,14 +577,6 @@ static void gen_gvec_fn4(DisasContext *s, bool is_q, int rd, int rn, int rm,
             is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
-/* Expand a 2-operand AdvSIMD vector operation using an op descriptor. */
-static void gen_gvec_op2(DisasContext *s, bool is_q, int rd,
-                         int rn, const GVecGen2 *gvec_op)
-{
-    tcg_gen_gvec_2(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
-                   is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
-}
-
 /* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
 static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                          int rn, int rm, const GVecGen3 *gvec_op)
@@ -12310,13 +12302,21 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         }
         break;
     case 0x8: /* CMGT, CMGE */
-        gen_gvec_op2(s, is_q, rd, rn, u ? &cge0_op[size] : &cgt0_op[size]);
+        if (u) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cge0, size);
+        } else {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cgt0, size);
+        }
         return;
     case 0x9: /* CMEQ, CMLE */
-        gen_gvec_op2(s, is_q, rd, rn, u ? &cle0_op[size] : &ceq0_op[size]);
+        if (u) {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_cle0, size);
+        } else {
+            gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_ceq0, size);
+        }
         return;
     case 0xa: /* CMLT */
-        gen_gvec_op2(s, is_q, rd, rn, &clt0_op[size]);
+        gen_gvec_fn2(s, is_q, rd, rn, gen_gvec_clt0, size);
         return;
     case 0xb:
         if (u) { /* ABS, NEG */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2eec689c5ed..010a158e632 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3645,204 +3645,59 @@ static int do_v81_helper(DisasContext *s, gen_helper_gvec_3_ptr *fn,
     return 1;
 }
 
-static void gen_ceq0_i32(TCGv_i32 d, TCGv_i32 a)
-{
-    tcg_gen_setcondi_i32(TCG_COND_EQ, d, a, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-static void gen_ceq0_i64(TCGv_i64 d, TCGv_i64 a)
-{
-    tcg_gen_setcondi_i64(TCG_COND_EQ, d, a, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_ceq0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
-{
-    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
-    tcg_gen_cmp_vec(TCG_COND_EQ, vece, d, a, zero);
-    tcg_temp_free_vec(zero);
-}
+#define GEN_CMP0(NAME, COND)                                            \
+    static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
+    {                                                                   \
+        tcg_gen_setcondi_i32(COND, d, a, 0);                            \
+        tcg_gen_neg_i32(d, d);                                          \
+    }                                                                   \
+    static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
+    {                                                                   \
+        tcg_gen_setcondi_i64(COND, d, a, 0);                            \
+        tcg_gen_neg_i64(d, d);                                          \
+    }                                                                   \
+    static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
+    {                                                                   \
+        TCGv_vec zero = tcg_const_zeros_vec_matching(d);                \
+        tcg_gen_cmp_vec(COND, vece, d, a, zero);                        \
+        tcg_temp_free_vec(zero);                                        \
+    }                                                                   \
+    void gen_gvec_##NAME##0(unsigned vece, uint32_t d, uint32_t m,      \
+                            uint32_t opr_sz, uint32_t max_sz)           \
+    {                                                                   \
+        const GVecGen2 op[4] = {                                        \
+            { .fno = gen_helper_gvec_##NAME##0_b,                       \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .vece = MO_8 },                                           \
+            { .fno = gen_helper_gvec_##NAME##0_h,                       \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .vece = MO_16 },                                          \
+            { .fni4 = gen_##NAME##0_i32,                                \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .vece = MO_32 },                                          \
+            { .fni8 = gen_##NAME##0_i64,                                \
+              .fniv = gen_##NAME##0_vec,                                \
+              .opt_opc = vecop_list_cmp,                                \
+              .prefer_i64 = TCG_TARGET_REG_BITS == 64,                  \
+              .vece = MO_64 },                                          \
+        };                                                              \
+        tcg_gen_gvec_2(d, m, opr_sz, max_sz, &op[vece]);                \
+    }
 
 static const TCGOpcode vecop_list_cmp[] = {
     INDEX_op_cmp_vec, 0
 };
 
-const GVecGen2 ceq0_op[4] = {
-    { .fno = gen_helper_gvec_ceq0_b,
-      .fniv = gen_ceq0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_8 },
-    { .fno = gen_helper_gvec_ceq0_h,
-      .fniv = gen_ceq0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_16 },
-    { .fni4 = gen_ceq0_i32,
-      .fniv = gen_ceq0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_32 },
-    { .fni8 = gen_ceq0_i64,
-      .fniv = gen_ceq0_vec,
-      .opt_opc = vecop_list_cmp,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .vece = MO_64 },
-};
+GEN_CMP0(ceq, TCG_COND_EQ)
+GEN_CMP0(cle, TCG_COND_LE)
+GEN_CMP0(cge, TCG_COND_GE)
+GEN_CMP0(clt, TCG_COND_LT)
+GEN_CMP0(cgt, TCG_COND_GT)
 
-static void gen_cle0_i32(TCGv_i32 d, TCGv_i32 a)
-{
-    tcg_gen_setcondi_i32(TCG_COND_LE, d, a, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-static void gen_cle0_i64(TCGv_i64 d, TCGv_i64 a)
-{
-    tcg_gen_setcondi_i64(TCG_COND_LE, d, a, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_cle0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
-{
-    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
-    tcg_gen_cmp_vec(TCG_COND_LE, vece, d, a, zero);
-    tcg_temp_free_vec(zero);
-}
-
-const GVecGen2 cle0_op[4] = {
-    { .fno = gen_helper_gvec_cle0_b,
-      .fniv = gen_cle0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_8 },
-    { .fno = gen_helper_gvec_cle0_h,
-      .fniv = gen_cle0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_16 },
-    { .fni4 = gen_cle0_i32,
-      .fniv = gen_cle0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_32 },
-    { .fni8 = gen_cle0_i64,
-      .fniv = gen_cle0_vec,
-      .opt_opc = vecop_list_cmp,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .vece = MO_64 },
-};
-
-static void gen_cge0_i32(TCGv_i32 d, TCGv_i32 a)
-{
-    tcg_gen_setcondi_i32(TCG_COND_GE, d, a, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-static void gen_cge0_i64(TCGv_i64 d, TCGv_i64 a)
-{
-    tcg_gen_setcondi_i64(TCG_COND_GE, d, a, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_cge0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
-{
-    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
-    tcg_gen_cmp_vec(TCG_COND_GE, vece, d, a, zero);
-    tcg_temp_free_vec(zero);
-}
-
-const GVecGen2 cge0_op[4] = {
-    { .fno = gen_helper_gvec_cge0_b,
-      .fniv = gen_cge0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_8 },
-    { .fno = gen_helper_gvec_cge0_h,
-      .fniv = gen_cge0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_16 },
-    { .fni4 = gen_cge0_i32,
-      .fniv = gen_cge0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_32 },
-    { .fni8 = gen_cge0_i64,
-      .fniv = gen_cge0_vec,
-      .opt_opc = vecop_list_cmp,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .vece = MO_64 },
-};
-
-static void gen_clt0_i32(TCGv_i32 d, TCGv_i32 a)
-{
-    tcg_gen_setcondi_i32(TCG_COND_LT, d, a, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-static void gen_clt0_i64(TCGv_i64 d, TCGv_i64 a)
-{
-    tcg_gen_setcondi_i64(TCG_COND_LT, d, a, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_clt0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
-{
-    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
-    tcg_gen_cmp_vec(TCG_COND_LT, vece, d, a, zero);
-    tcg_temp_free_vec(zero);
-}
-
-const GVecGen2 clt0_op[4] = {
-    { .fno = gen_helper_gvec_clt0_b,
-      .fniv = gen_clt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_8 },
-    { .fno = gen_helper_gvec_clt0_h,
-      .fniv = gen_clt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_16 },
-    { .fni4 = gen_clt0_i32,
-      .fniv = gen_clt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_32 },
-    { .fni8 = gen_clt0_i64,
-      .fniv = gen_clt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .vece = MO_64 },
-};
-
-static void gen_cgt0_i32(TCGv_i32 d, TCGv_i32 a)
-{
-    tcg_gen_setcondi_i32(TCG_COND_GT, d, a, 0);
-    tcg_gen_neg_i32(d, d);
-}
-
-static void gen_cgt0_i64(TCGv_i64 d, TCGv_i64 a)
-{
-    tcg_gen_setcondi_i64(TCG_COND_GT, d, a, 0);
-    tcg_gen_neg_i64(d, d);
-}
-
-static void gen_cgt0_vec(unsigned vece, TCGv_vec d, TCGv_vec a)
-{
-    TCGv_vec zero = tcg_const_zeros_vec_matching(d);
-    tcg_gen_cmp_vec(TCG_COND_GT, vece, d, a, zero);
-    tcg_temp_free_vec(zero);
-}
-
-const GVecGen2 cgt0_op[4] = {
-    { .fno = gen_helper_gvec_cgt0_b,
-      .fniv = gen_cgt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_8 },
-    { .fno = gen_helper_gvec_cgt0_h,
-      .fniv = gen_cgt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_16 },
-    { .fni4 = gen_cgt0_i32,
-      .fniv = gen_cgt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .vece = MO_32 },
-    { .fni8 = gen_cgt0_i64,
-      .fniv = gen_cgt0_vec,
-      .opt_opc = vecop_list_cmp,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .vece = MO_64 },
-};
+#undef GEN_CMP0
 
 static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
@@ -6772,24 +6627,19 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     break;
 
                 case NEON_2RM_VCEQ0:
-                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
-                                   vec_size, &ceq0_op[size]);
+                    gen_gvec_ceq0(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
                 case NEON_2RM_VCGT0:
-                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
-                                   vec_size, &cgt0_op[size]);
+                    gen_gvec_cgt0(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
                 case NEON_2RM_VCLE0:
-                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
-                                   vec_size, &cle0_op[size]);
+                    gen_gvec_cle0(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
                 case NEON_2RM_VCGE0:
-                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
-                                   vec_size, &cge0_op[size]);
+                    gen_gvec_cge0(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
                 case NEON_2RM_VCLT0:
-                    tcg_gen_gvec_2(rd_ofs, rm_ofs, vec_size,
-                                   vec_size, &clt0_op[size]);
+                    gen_gvec_clt0(size, rd_ofs, rm_ofs, vec_size, vec_size);
                     break;
 
                 default:
-- 
2.20.1


