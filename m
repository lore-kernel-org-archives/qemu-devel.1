Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E27C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6FA2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJoNT6xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6FA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbwW-0001BQ-Fd
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcm-0003Bo-61
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcj-00022F-W6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcj-000211-Nb
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:17 -0400
Received: by mail-pl1-x641.google.com with SMTP id a23so2746288plm.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TUH/iWxYaarqAhHTxewl7Cdd7qJ//bZUOWIU1IWx5z8=;
 b=pJoNT6xtsQOq3gFBSADOXLKKBy6htgXEVA+0bvS7tCgOo+fJQXfFi5yypP9l38HFU4
 dg8A6Y6z/vkysMm/HaR4HNqbcSHLJU+pCRblmnfyOqbiPsldQE0HvKYAhaLNBMiD7/+5
 YgFOaOhRXqKZSISylnOoYMa0CAkZZ9RTanP83HNGPMhkOsAbWd4cQKZl+gzeeyzI1o7F
 V1wjnhIdiy+n8YmOgJAL1A2pnMvEiTtgWSzz+Uj0RWqUKcmrg8PbN2/tSmzShlpYmkP0
 MKlo9NrZQ7n3oyMrSbs+qSmg7pTfHTWVLzsdMF83ZHpNfzyDQVg3MH4UfTdBq0Lftuqm
 8D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TUH/iWxYaarqAhHTxewl7Cdd7qJ//bZUOWIU1IWx5z8=;
 b=LG/P2pa4uxncZlcy9ktYdwNwoswMTN3dn+Q8Ba7aBmIY/pdkVpY3/tU3mYpPFCX4g/
 +GPp0z3hyU/8A9aS7Qt8IEFiC+yo6ndmuT9tZ1ODfO4dGtJLCLDzkn0+o5WLR0JM0g3/
 Si5smnNygaSF9MHPq+wIIpKoovzjWJNYBJyoRPg8KXlruHKnz7w3CMifcwtJjlMS0daj
 w1w9+3gIxKGcEQnKyFlZqfiNrVGY3/POTs8k2Z35yDsJO2F3VKpIEJ/0x/UKa4Tzb2Vb
 MQnv+EtjZ60Xt453fWWFmNkneX125WrkagvRe3KFo5qipfgq6RZ+TxdJVEXY+CsQuO46
 PaRQ==
X-Gm-Message-State: ANhLgQ3kooVCAbYvIwimgQTP1TaWtwNfqeqArPJ013NXqnaw2dJ4DVDW
 H87jNJNsmHocxH7PuAJEjHiUDqfFgoI=
X-Google-Smtp-Source: ADFU+vvRRKr7xFN/9pZOh13o0k7AlKZ/eqU0Xw7Ym7EyUa7gC4zac11T6W9A6B/DsdAU09qHckPmNA==
X-Received: by 2002:a17:90a:7105:: with SMTP id
 h5mr2615902pjk.54.1585264155988; 
 Thu, 26 Mar 2020 16:09:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/31] target/arm: Vectorize SABD/UABD
Date: Thu, 26 Mar 2020 16:08:36 -0700
Message-Id: <20200326230838.31112-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
 target/arm/helper.h        |  10 +++
 target/arm/translate.h     |   5 ++
 target/arm/translate-a64.c |   8 ++-
 target/arm/translate.c     | 133 ++++++++++++++++++++++++++++++++++++-
 target/arm/vec_helper.c    |  88 ++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5ef7bb158f..97ccbd70c6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -748,6 +748,16 @@ DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_sabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 843ecc1472..c453aa1c47 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -311,6 +311,11 @@ void arm_gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void arm_gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                       int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void arm_gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void arm_gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fc156a217a..1791c26a39 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12159,6 +12159,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
         }
         return;
+    case 0xe: /* SABD, UABD */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, arm_gen_gvec_uabd, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, arm_gen_gvec_sabd, size);
+        }
+        return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
@@ -12291,7 +12298,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0xe: /* SABD, UABD */
             case 0xf: /* SABA, UABA */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index bb6db53598..a29868976a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4849,6 +4849,126 @@ const GVecGen4 sqsub_op[4] = {
       .vece = MO_64 },
 };
 
+static void gen_sabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_sub_i32(d, b, a);
+    tcg_gen_movcond_i32(TCG_COND_LT, d, a, b, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_sabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_sub_i64(d, b, a);
+    tcg_gen_movcond_i64(TCG_COND_LT, d, a, b, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_sabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_smin_vec(vece, t, a, b);
+    tcg_gen_smax_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void arm_gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_smin_vec, INDEX_op_smax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_sabd_i32,
+          .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_sabd_i64,
+          .fniv = gen_sabd_vec,
+          .fno = gen_helper_gvec_sabd_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
+static void gen_uabd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_sub_i32(d, b, a);
+    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, d, t);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_uabd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_sub_i64(d, b, a);
+    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_uabd_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_umin_vec(vece, t, a, b);
+    tcg_gen_umax_vec(vece, d, a, b);
+    tcg_gen_sub_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+void arm_gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sub_vec, INDEX_op_umin_vec, INDEX_op_umax_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_b,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_h,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_uabd_i32,
+          .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_s,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_uabd_i64,
+          .fniv = gen_uabd_vec,
+          .fno = gen_helper_gvec_uabd_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -5107,6 +5227,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
                            u ? &ushl_op[size] : &sshl_op[size]);
             return 0;
+
+        case NEON_3R_VABD:
+            if (u) {
+                arm_gen_gvec_uabd(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            } else {
+                arm_gen_gvec_sabd(size, rd_ofs, rn_ofs, rm_ofs,
+                                  vec_size, vec_size);
+            }
+            return 0;
         }
 
         if (size == 3) {
@@ -5237,9 +5367,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
             GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
-        case NEON_3R_VABD:
-            GEN_NEON_INTEGER_OP(abd);
-            break;
         case NEON_3R_VABA:
             GEN_NEON_INTEGER_OP(abd);
             tcg_temp_free_i32(tmp2);
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 27035a8a42..e0694c16f4 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1492,3 +1492,91 @@ void HELPER(gvec_umulh_d)(void *vd, void *vn, void *vm, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_sabd_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sabd_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sabd_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sabd_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uabd_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uabd_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uabd_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uabd_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.20.1


