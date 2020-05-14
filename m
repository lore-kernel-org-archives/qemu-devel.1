Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FEBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783C4205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRu+ghMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783C4205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZExh-0004Hh-FK
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkP-0003Qa-E9
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkN-0005e8-QT
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g14so14456855wme.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=F7W47CQDpa04EDhjS5DqwrnWGOV/TglOAJFRJOB3PM8=;
 b=mRu+ghMZCuueL4D4wT288RyGKkIEiK0DJbAp3dHy5m8tAGVeKcv7WN5vNefhLl1iUg
 bN8oyGYfP7m1NFoaZBXbVrxm1PGAKu95ZlAzX6bGUt8qmmy2LdDBBfhRsJMfgOpSDKb/
 D9qWq39WqVxy2OWYQTh0fDRNYy9ew24iemkd3PWZ0/vZ6Qm/HLraoWMqzhnPG89Wb9VT
 dkT11LooKxEV8K30OqGINsh/C6SuniQleruVIlRhH6cfuUX+cM/qvX+T3s+M+v2FgsBL
 3m0HSRn4D+zq2ukzYf6WI6OY/EFtyIfBgduKlY4utHzacOSFcF7oYHF2xZz7lRs3Irbd
 lZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F7W47CQDpa04EDhjS5DqwrnWGOV/TglOAJFRJOB3PM8=;
 b=dImNwViIj+EdydUBZpBu8SH7eGyGbtir435vtkxT3o0I6ogVqWUx7OPYhhjy0twxSR
 IyBbeXq4tXt44WYTTbfkqQJXMNf9ElIYpITobxgymyeL46nkTO3DX+R6trOwy/HH0e5f
 lgjs6cpxW0gkrd+lY5eBGWSFvLGIsNZm4Fuh7mbzjrG81ilt5PB1SGn0I80KXzA5NT98
 1FSWxpwaIcmnsOdNQo8XNz7pdIGuHxOiFJjDHlqrzx38M2O+aGmvDDd6p43Hi0UUrl3E
 0E+ZnerY97zB8fPPbAimvpAPgEk4YUuGlEU+H51reYXo64Lp8URdHvkVK3BsLTY2mPCn
 PQvQ==
X-Gm-Message-State: AGi0PuY3QRJaHAsm8QvdxagQAD4SJTHWUoJx7zM4O2hWDUAsqz2QT2/S
 uqjMxOjwRGil2a7Uml3iWEcULosGKoXC7Q==
X-Google-Smtp-Source: APiQypIAQxp0laF6OWmnfkTArd2sxC86QRDQfEUfyKaa/T6iN9bG+/A8kGl6+AUbVq4Vo5tryMdk8Q==
X-Received: by 2002:a05:600c:2dda:: with SMTP id
 e26mr40270846wmh.42.1589466121768; 
 Thu, 14 May 2020 07:22:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/45] target/arm: Vectorize SABD/UABD
Date: Thu, 14 May 2020 15:21:09 +0100
Message-Id: <20200514142138.20875-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Include 64-bit element size in preparation for SVE2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  10 +++
 target/arm/translate.h     |   5 ++
 target/arm/translate-a64.c |   8 ++-
 target/arm/translate.c     | 133 ++++++++++++++++++++++++++++++++++++-
 target/arm/vec_helper.c    |  24 +++++++
 5 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index aed30509655..4678d3a6f4e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -731,6 +731,16 @@ DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
index aea8a9759d2..bbfe3d13930 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -337,6 +337,11 @@ void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4577df3cf43..54b06553a65 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11190,6 +11190,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
         }
         return;
+    case 0xe: /* SABD, UABD */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
+        }
+        return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
@@ -11322,7 +11329,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0xe: /* SABD, UABD */
             case 0xf: /* SABA, UABA */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 21529a9b8f6..d288721c230 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5102,6 +5102,126 @@ void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
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
+void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
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
+void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
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
@@ -5236,6 +5356,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
+        case NEON_3R_VABD:
+            if (u) {
+                gen_gvec_uabd(size, rd_ofs, rn_ofs, rm_ofs,
+                              vec_size, vec_size);
+            } else {
+                gen_gvec_sabd(size, rd_ofs, rn_ofs, rm_ofs,
+                              vec_size, vec_size);
+            }
+            return 0;
+
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
@@ -5380,9 +5510,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
index a483841adda..a4972d02fc9 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1407,3 +1407,27 @@ DO_CMP0(gvec_cgt0_h, int16_t, >)
 DO_CMP0(gvec_cge0_h, int16_t, >=)
 
 #undef DO_CMP0
+
+#define DO_ABD(NAME, TYPE)                                      \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+                                                                \
+    for (i = 0; i < opr_sz / sizeof(TYPE); ++i) {               \
+        d[i] = n[i] < m[i] ? m[i] - n[i] : n[i] - m[i];         \
+    }                                                           \
+    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
+}
+
+DO_ABD(gvec_sabd_b, int8_t)
+DO_ABD(gvec_sabd_h, int16_t)
+DO_ABD(gvec_sabd_s, int32_t)
+DO_ABD(gvec_sabd_d, int64_t)
+
+DO_ABD(gvec_uabd_b, uint8_t)
+DO_ABD(gvec_uabd_h, uint16_t)
+DO_ABD(gvec_uabd_s, uint32_t)
+DO_ABD(gvec_uabd_d, uint64_t)
+
+#undef DO_ABD
-- 
2.20.1


