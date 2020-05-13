Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0054B2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2N1z92H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0054B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuRB-0007hK-Er
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJk-0003oq-EE
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:12 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJi-00024N-0K
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:12 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mq3so11344061pjb.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hVHTEirUzJ20bAilpSh5nRxHdFXu/fWlu+BQCZdG8wI=;
 b=X2N1z92Hh3WJ7vtCRPIyz5OW5ZQqXBvZcJuxOr1p03Ok1f3zjOOOhcm3QhtN9pf2n8
 sJdYPuG8bPGGfm4MDawILYEODVnGPcyuOjT6Vj7gypDXPbBVCBRexH0A76ro2ttMtSjV
 NnOqtt/Qrq9LCW51kfQOpixKJrng2rjFZvsoHr3+z+OJabLvpBnlUA0agR66mZaDh+Ad
 GN9twoZhaL5SblFPpVUBznhhkvDVjJ8H3NYsfCKjaXct+Ya5yR6sZwAal5ECsuVNAYLq
 jHfEsJCYmTqMI8VTXzKJ7tO8kX00FhOPjzPtRDsHzGRZfAA7IAyIgFD3z5rOzoatNQhG
 6Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hVHTEirUzJ20bAilpSh5nRxHdFXu/fWlu+BQCZdG8wI=;
 b=PaxZLCjG6d9OHOoYXVSzFOBUQ1Qz6pSFJvOBevG1VFcXkXfVR3vypaJE4DHLGPyB3i
 N6/Sd6HUrc29ZqqApzPIMaWINqUn1IEbC7p46/JyL0Fc9vmo+0t+HADF/y/ZRd/vM6kB
 6oBykdeQysKVlD+KYzNbkZHncMRvPk7atNIOKHAxkNux3AnmXzABfsQLYzKP32lqg9OW
 kAuT+eKpIZSGKV1SCXMgBESPB8bsmWGalKG71VWHf3sZU7kt8/EhCpuEzoinLU7MrtuN
 uDJtEUwO4zYAia8zTJWMQR/XLtD8z/41WdcqvESFxXFlsXglQJCaHoSdcdy8pr/jLz7k
 Gteg==
X-Gm-Message-State: AOAM531XF7LIlewgEt+B9MVr+71/0TxOfl1VSEMbjUe/XtXA+E7dOWgT
 xkoSyv0jX+QoHsInsrpMk5ZLcmUQrFY=
X-Google-Smtp-Source: ABdhPJzY1mxRiT/M4Nihykdno47qUhipVo75UvqvEVQ2aC6ZYkwwQa0Jyukc5ziXlXadHfEjaYrgXA==
X-Received: by 2002:a17:902:8494:: with SMTP id c20mr2897plo.305.1589387588187; 
 Wed, 13 May 2020 09:33:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:33:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/16] target/arm: Vectorize SABA/UABA
Date: Wed, 13 May 2020 09:32:45 -0700
Message-Id: <20200513163245.17915-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

Include 64-bit element size in preparation for SVE2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  17 +++--
 target/arm/translate.h     |   5 ++
 target/arm/neon_helper.c   |  10 ---
 target/arm/translate-a64.c |  17 ++---
 target/arm/translate.c     | 134 +++++++++++++++++++++++++++++++++++--
 target/arm/vec_helper.c    |  24 +++++++
 6 files changed, 174 insertions(+), 33 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 4678d3a6f4..1857f4ee46 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -284,13 +284,6 @@ DEF_HELPER_2(neon_pmax_s8, i32, i32, i32)
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
@@ -741,6 +734,16 @@ DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
index bbfe3d1393..c937dfe9bf 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -342,6 +342,11 @@ void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 448be93fa1..2ef75e04c8 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -576,16 +576,6 @@ NEON_POP(pmax_s16, neon_s16, 2)
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
 #define NEON_FN(dest, src1, src2) do { \
     int8_t tmp; \
     tmp = (int8_t)src2; \
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 54b06553a6..991e451644 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11197,6 +11197,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
         }
         return;
+    case 0xf: /* SABA, UABA */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uaba, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
+        }
+        return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
@@ -11329,16 +11336,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
index d288721c23..e3d37ef2e9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5222,6 +5222,124 @@ void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
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
+void gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
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
+void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
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
@@ -5366,6 +5484,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 0;
 
+        case NEON_3R_VABA:
+            if (u) {
+                gen_gvec_uaba(size, rd_ofs, rn_ofs, rm_ofs,
+                              vec_size, vec_size);
+            } else {
+                gen_gvec_saba(size, rd_ofs, rn_ofs, rm_ofs,
+                              vec_size, vec_size);
+            }
+            return 0;
+
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
@@ -5510,12 +5638,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
index a4972d02fc..fa33df859e 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1431,3 +1431,27 @@ DO_ABD(gvec_uabd_s, uint32_t)
 DO_ABD(gvec_uabd_d, uint64_t)
 
 #undef DO_ABD
+
+#define DO_ABA(NAME, TYPE)                                      \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+                                                                \
+    for (i = 0; i < opr_sz / sizeof(TYPE); ++i) {               \
+        d[i] += n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];        \
+    }                                                           \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
+}
+
+DO_ABA(gvec_saba_b, int8_t)
+DO_ABA(gvec_saba_h, int16_t)
+DO_ABA(gvec_saba_s, int32_t)
+DO_ABA(gvec_saba_d, int64_t)
+
+DO_ABA(gvec_uaba_b, uint8_t)
+DO_ABA(gvec_uaba_h, uint16_t)
+DO_ABA(gvec_uaba_s, uint32_t)
+DO_ABA(gvec_uaba_d, uint64_t)
+
+#undef DO_ABA
-- 
2.20.1


