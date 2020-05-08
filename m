Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84782C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D7F21841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd+gaqc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D7F21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX52N-0000XP-8B
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pL-0004bL-HZ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pI-00075w-Bu
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id j21so999752pgb.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pyNuivcPxdt7V5pwewNgwdn/FthppnmmYlM/tMN7sI8=;
 b=Dd+gaqc56PmGvvHoUGZANJnIrsXHNHBDb0YjyIjCd5EIve/gQjKpkOFANWPAwOq/Zm
 /I1fBjNQ0QWHCRIyXS0K0Mkv8457rDvI5yqZkiHTaOjV/OMhPXGvMzFD5sX85zr+h2uq
 e8sKMXhFD6lfOi3j5OFdcIomcTDQr0tIHP0vDJT4BU6BAcfYkuq6GwAA759RPEcsnUol
 OVIgoSu5N4SAB5MLvJMURycd79WsWcONpjXQD6gpzXb3cJMbotdAJfvjQ89m/hI3WBI4
 7sCpoXBLWuvoTyWCP6ebvtFS73RJwmp2Ei/VnavSIeNNpZlsBiXTEcLb+Lnx1oBifLxY
 FFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pyNuivcPxdt7V5pwewNgwdn/FthppnmmYlM/tMN7sI8=;
 b=aMZmKNaZiSdvLnDMCXRnQtW7pS1xf9m7qR0GYCDUV48OO3RjsTdsqO2YLC2STc7afe
 zVNfgDUwF2TF0Hj5f5gzySh4D/kaJKhOlEIGJ5OZQGNciPTAHQ3k1xe13ldA3EdSOPxB
 h3KIms+SFKiIF5tNf6QIJr7gE99LWCT1VBP5Rxq3/UTp2+bNEnJALXn2RPCct38YIG8T
 9xgMEDBxNR67frNPtQzsnYi9bk2VW+qT5feFgLytbufh0dXyWnVqMizfBsQl6aDMci0F
 NibQPz1KeFDTohIiyYXeUivy6sTreow84kWQbU1pFVGg+H6xt09oQXpvFIaqjAnY8Wmn
 IYXg==
X-Gm-Message-State: AGi0PuYcuvGPKahCI7eaDgD3j1jZMXsHpNbKPsNXcPHa0VQVQy3F7ILM
 qpNonq2tHDi6AgqNsAsdanzNlwtsYUA=
X-Google-Smtp-Source: APiQypI9VG2o4EGTDGGpawp+rUGyL7sW8TCyTI8GwwaY/uVHDAT4XmuhCMcmonWZ8aeD1NhoPoa5hg==
X-Received: by 2002:a63:30c4:: with SMTP id w187mr2615045pgw.276.1588951330273; 
 Fri, 08 May 2020 08:22:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] target/arm: Create gen_gvec_{ceq,clt,cle,cgt,cge}0
Date: Fri,  8 May 2020 08:21:50 -0700
Message-Id: <20200508152200.6547-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
index 967108b3f4..45df3743f6 100644
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
@@ -6770,24 +6625,19 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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


