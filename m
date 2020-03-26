Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63C8C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECED20409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpXqVdEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECED20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbvd-0008OC-L7
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcn-0003F8-DH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcl-00024j-8T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:21 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbck-000235-W4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:19 -0400
Received: by mail-pj1-x1042.google.com with SMTP id l36so3088799pjb.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=59fkymWDzWb5TOs7OFoXchMT/KmijGyH3f2e6vHC1Kk=;
 b=kpXqVdEj3qFqq7pDlrWworCzh0b+aZbdn51q8tVyXxCLo1KagMK8IwfOgtnBmbM3iG
 8P0NhzKUaT5s7wTyDO2uNBY2t0Hy/ANoDpPSq9X5bsvOvDCNXkmi60KFpW9ymXSVjRj/
 fIjJ0aLa4ytIZv5jqPVME2Arvyji4NiuFbzToxCEG04ZxcDTgA/jArhy9Cs5bgG3HOym
 FTN7iCEkU63Pu4CjqwmLV4Vf0765W2lVsk2QauuEVmturluVOqjXs+JnFKLfwwqngxnr
 GaVFbECe7EDJ6VBWzL+iL5M/5MMDc2w6PUlIbi7QeI3e5WuhOyevzOcyd9vYbAs+Uku6
 1fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=59fkymWDzWb5TOs7OFoXchMT/KmijGyH3f2e6vHC1Kk=;
 b=QL5y8VnGWXJXi8pYntri/s50c8A8f4xsgrB8/NtkHZ+Q7YTPsepRrqDjYRGmeyp4BE
 pFb0x72HJXlRn/rvnA3DseVjOTKIrUrXpDlvbivOT9RgcyiYvoRH6URIdjbPHZ1xxiOj
 WPEb/jSLwMZ06EIuEzLprPyZ8OcPI9GjQE74Xg6Av/xVP0Jqy9/ZwWJDC4pLRuJGn4nG
 Fra0Znd9tSTpsgyD5cp7ukzfLMa0EsvILUi79yi5enmj3O1elwIcfunZ1DY4Zv0TSYrk
 amxvXfE0KNhP38vP4IyOYcjisRt0iH0Hl66mvHB6Hy6xFhEwkP13YJbTtECOYuO4ckmB
 cKpw==
X-Gm-Message-State: ANhLgQ3e50YLqngzHpUfiL137jHdb4BACZHKXR4R1hN3n+CyUHSkpTUw
 9mmG1QSbLSY9e5ufdjLsqxJgUKDgkkg=
X-Google-Smtp-Source: ADFU+vt/jGF7wbyvNw8mttItdolN7MkJE8RAsUO5CdzwUYj8S+ReD5k+zvGcRqPwR6xGPYjj+KrcMQ==
X-Received: by 2002:a17:90a:cb14:: with SMTP id
 z20mr2496268pjt.170.1585264157065; 
 Thu, 26 Mar 2020 16:09:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/31] target/arm: Vectorize SABA/UABA
Date: Thu, 26 Mar 2020 16:08:37 -0700
Message-Id: <20200326230838.31112-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include 64-bit element size in preparation for SVE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  17 +++--
 target/arm/translate.h     |   5 ++
 target/arm/neon_helper.c   |  10 ---
 target/arm/translate-a64.c |  17 ++---
 target/arm/translate.c     | 134 +++++++++++++++++++++++++++++++++++--
 target/arm/vec_helper.c    |  88 ++++++++++++++++++++++++
 6 files changed, 238 insertions(+), 33 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 97ccbd70c6..5cf6a5b4a0 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -299,13 +299,6 @@ DEF_HELPER_2(neon_pmax_s8, i32, i32, i32)
 DEF_HELPER_2(neon_pmax_u16, i32, i32, i32)
 DEF_HELPER_2(neon_pmax_s16, i32, i32, i32)
 
-DEF_HELPER_2(neon_abd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_abd_s8, i32, i32, i32)
-DEF_HELPER_2(neon_abd_u16, i32, i32, i32)
-DEF_HELPER_2(neon_abd_s16, i32, i32, i32)
-DEF_HELPER_2(neon_abd_u32, i32, i32, i32)
-DEF_HELPER_2(neon_abd_s32, i32, i32, i32)
-
 DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
 DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
 DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
@@ -758,6 +751,16 @@ DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_saba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_saba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_saba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_saba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uaba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uaba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uaba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uaba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index c453aa1c47..0df7ce51b2 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -316,6 +316,11 @@ void arm_gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void arm_gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void arm_gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void arm_gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index e6481a5764..4c1cf1e031 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -595,16 +595,6 @@ NEON_POP(pmax_s16, neon_s16, 2)
 NEON_POP(pmax_u16, neon_u16, 2)
 #undef NEON_FN
 
-#define NEON_FN(dest, src1, src2) \
-    dest = (src1 > src2) ? (src1 - src2) : (src2 - src1)
-NEON_VOP(abd_s8, neon_s8, 4)
-NEON_VOP(abd_u8, neon_u8, 4)
-NEON_VOP(abd_s16, neon_s16, 2)
-NEON_VOP(abd_u16, neon_u16, 2)
-NEON_VOP(abd_s32, neon_s32, 1)
-NEON_VOP(abd_u32, neon_u32, 1)
-#undef NEON_FN
-
 #define NEON_FN(dest, src1, src2) \
     (dest = do_uqrshl_bhs(src1, src2, 16, false, NULL))
 NEON_VOP(shl_u16, neon_u16, 2)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1791c26a39..d830a58c3f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12166,6 +12166,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, arm_gen_gvec_sabd, size);
         }
         return;
+    case 0xf: /* SABA, UABA */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, arm_gen_gvec_uaba, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, arm_gen_gvec_saba, size);
+        }
+        return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
@@ -12298,16 +12305,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0xf: /* SABA, UABA */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_abd_s8, gen_helper_neon_abd_u8 },
-                    { gen_helper_neon_abd_s16, gen_helper_neon_abd_u16 },
-                    { gen_helper_neon_abd_s32, gen_helper_neon_abd_u32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0x16: /* SQDMULH, SQRDMULH */
             {
                 static NeonGenTwoOpEnvFn * const fns[2][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a29868976a..4491ab0eb0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4969,6 +4969,124 @@ void arm_gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+static void gen_saba_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+    gen_sabd_i32(t, a, b);
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_saba_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_sabd_i64(t, a, b);
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_saba_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    gen_sabd_vec(vece, t, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void arm_gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_add_vec,
+        INDEX_op_smin_vec, INDEX_op_smax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_saba_i32,
+          .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_saba_i64,
+          .fniv = gen_saba_vec,
+          .fno = gen_helper_gvec_saba_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uaba_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+    gen_uabd_i32(t, a, b);
+    tcg_gen_add_i32(d, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_uaba_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    gen_uabd_i64(t, a, b);
+    tcg_gen_add_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_uaba_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    gen_uabd_vec(vece, t, a, b);
+    tcg_gen_add_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void arm_gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_add_vec,
+        INDEX_op_umin_vec, INDEX_op_umax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_b,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_8 },
+        { .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_h,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_16 },
+        { .fni4 = gen_uaba_i32,
+          .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_s,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_32 },
+        { .fni8 = gen_uaba_i64,
+          .fniv = gen_uaba_vec,
+          .fno = gen_helper_gvec_uaba_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .load_dest = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -5237,6 +5355,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                   vec_size, vec_size);
             }
             return 0;
+
+        case NEON_3R_VABA:
+            if (u) {
+                arm_gen_gvec_uaba(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                arm_gen_gvec_saba(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
+            return 0;
         }
 
         if (size == 3) {
@@ -5367,12 +5495,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
             GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
-        case NEON_3R_VABA:
-            GEN_NEON_INTEGER_OP(abd);
-            tcg_temp_free_i32(tmp2);
-            tmp2 = neon_load_reg(rd, pass);
-            gen_neon_add(size, tmp, tmp2);
-            break;
         case NEON_3R_VPMAX:
             GEN_NEON_INTEGER_OP(pmax);
             break;
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index e0694c16f4..cbd0382c71 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1580,3 +1580,91 @@ void HELPER(gvec_uabd_d)(void *vd, void *vn, void *vm, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_saba_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_saba_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_saba_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_saba_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uaba_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uaba_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uaba_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uaba_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.20.1


