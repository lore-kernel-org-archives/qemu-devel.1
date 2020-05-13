Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85082C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CE7204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCqJ2f0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CE7204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuVL-0004Rt-2P
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJW-0003g4-Vm
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:32:59 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJV-00020b-3U
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:32:58 -0400
Received: by mail-pj1-x1044.google.com with SMTP id e6so11215598pjt.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l2QCtAJuqJw9W7z9OKqSJ6gRkNQUxusCmyvREvrDgd8=;
 b=oCqJ2f0Hw74eBQHT3/1vYVWd2us9cmQipR8aRjknPXKf7XxYTlimX2541YF22UAqTe
 o61ekV6Uz3j4veSejK9cmuhhDacienq2PeEpb3ksfN9qiqpwlk8D0hlm0fTeXn7i3FWQ
 tQlBHG9BH0Yvs7v0Uoqi3VulW7NqWo3DjHqt4YNQZM3ck1uawxbM2HhM3J9Iow7tp3gE
 cU9134CQ5b/dNKYvqrJjnhSS3Vedb2+qMn3ZuaC//xyoxllCiWMCLsKyrKN9tVmRIUoZ
 TtYdVuyTQGCEhpynK6KKznxlCqVWFoJwn4cqNMWBP/ajPCs7p2EKf/Vt1ytwdBSDtZeV
 VhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l2QCtAJuqJw9W7z9OKqSJ6gRkNQUxusCmyvREvrDgd8=;
 b=eNjJprNe2cNF9ku47qTRF74EKHPUm3Q4WWvA7v3SNUT+6qshXwGQIyS8lISsCrzg2i
 q+GrvI5dFID4Or2TcgRMWhyPKxFNgRkYmZpfJKW7pk7o1d9de/osoB2J3fsClA/eBxyA
 0GqRZxrwFU/ykBghPq7KBCeXmphJP4okRRa2M/UqY+TVjLZLxy6shdOG6kMEzD2F+5Uw
 wMqn8X8f17OX7biX5zNZk4ebHQ8tsDPSmwgHbt+XJhtRvmn2QMt93WVXobpobTNqJV6q
 sPaoHp2IXq7wEBGEO1AjNy9I7TY5bf/oWE3cLg2liHEwaIMGry9ANxKbxwRuFS6vSIsl
 c1Gw==
X-Gm-Message-State: AGi0Pub326dGgnsCxIHSzoqrFvcyAiRP/iZBiZhfHoJpjTC8ojMDJ5Fs
 6RYRPeopf20OVm+DuWWfcUw+Nq25AWk=
X-Google-Smtp-Source: APiQypJRTHk3Jn7AzihOsjSLoMD1/eXNP3+jO99cwcsRlwB7TxfSSOS/bUju04yY5N+d3KUgFOo1Jg==
X-Received: by 2002:a17:90b:f16:: with SMTP id
 br22mr35213498pjb.89.1589387575345; 
 Wed, 13 May 2020 09:32:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:32:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/16] target/arm: Create gen_gvec_{ceq,clt,cle,cgt,cge}0
Date: Wed, 13 May 2020 09:32:35 -0700
Message-Id: <20200513163245.17915-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Macro-ize the 5 nearly identical comparisons.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h     |  16 ++-
 target/arm/translate-a64.c |  22 ++--
 target/arm/translate.c     | 254 ++++++++-----------------------------
 3 files changed, 74 insertions(+), 218 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index fa5c3f12b9..e35c812cc5 100644
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
index d5e77f34a7..fef93dc27a 100644
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
index 2eec689c5e..010a158e63 100644
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


