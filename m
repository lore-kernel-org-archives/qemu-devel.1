Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45783C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B6424953
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="So4AOh8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B6424953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX54E-0003TF-2D
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pF-0004Rh-Rw
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:09 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pE-00072Q-Al
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:09 -0400
Received: by mail-pj1-x1043.google.com with SMTP id e6so4386644pjt.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7MYAHSBEG+F9mmfJQAxzNPkIWeGVdFuYzsxiBlYTS3o=;
 b=So4AOh8dDY9izEikn5TqnsJNKMARs/18AEkWz0oT433UU4Kuj+nWxL2MwBLHdtFQmR
 KFq6t5NHPwchvlUMmvJv8k2KZp4D8u/N0r+VDCh0BvXmqOy/Wlltk10XWAWYXnoHUGQH
 22j0NXDmHjA/kEiBV10QNSnXFz/3457VJEqmKihXDAS+SOP6eRRxqe+3eizvQfrJUxRO
 KXU/TK6Vx2a5uQKfaqn56B8ZYlY8CwlCzeRMMTKZvhs5JalBEjA5APcr3566QfCkzzWX
 K3do8HFwiEul4ZHZUN2nj4BezSCtJjLhcJHpAb2WzCjqIzaXS8IdShtqpisKTvysalWw
 cotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7MYAHSBEG+F9mmfJQAxzNPkIWeGVdFuYzsxiBlYTS3o=;
 b=F5qfURpn8k/U0takD4G5qnWtcX8mXcpXvWoAwh5dg4mqcFe03GVhzgKIPeH0V7woCN
 /8ob9HZ8MCsa9fenydiNiFwzGtrPcSX1N/XwLwNgC7KzxWXq/G7LP9QGqoIYdvDHyWdv
 1wcfWorr5uAETMENtJsbflNTsP7MHAeINiEJyxiUhVpiyuLscTChriy4+0JV/x+OD1Kv
 ihtoP67Wck/J1J97JdDfBavAOW+3FLhtNFs0cspfvZ+QcWnchhVywOxW9XluItXtfqIs
 ZAS8l6RDpLxxkMJuFXZVW2sqVAQaRC/plFKJJHTB3KT8Ln2cZ1F0Rtp0ISrXThov+O2k
 ecbQ==
X-Gm-Message-State: AGi0PuYF/V+UCossNEBf5ReHvgIXY7/U79GqR/2Qv/zIlyrYOcK3uFvT
 J1h0RgUKCHsCHbLocIYzhQbPBKAFXqQ=
X-Google-Smtp-Source: APiQypItipJ/gX7ZKydgcDQf4CF/+b2oNEzckXcuuAzNr7w8ZLz102spoLchUKqb+MEZdXTEhg9mBg==
X-Received: by 2002:a17:90a:bd91:: with SMTP id
 z17mr6826512pjr.189.1588951326166; 
 Fri, 08 May 2020 08:22:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/16] target/arm: Create gen_gvec_{sri,sli}
Date: Fri,  8 May 2020 08:21:47 -0700
Message-Id: <20200508152200.6547-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

The functions eliminate duplication of the special cases for
this operation.  They match up with the GVecGen2iFn typedef.

Add out-of-line helpers.  We got away with only having inline
expanders because the neon vector size is only 16 bytes, and
we know that the inline expansion will always succeed.
When we reuse this for SVE, tcg-gvec-op may decide to use an
out-of-line helper due to longer vector lengths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  10 ++
 target/arm/translate.h     |   7 +-
 target/arm/translate-a64.c |  20 +---
 target/arm/translate.c     | 186 +++++++++++++++++++++----------------
 target/arm/vec_helper.c    |  38 ++++++++
 5 files changed, 160 insertions(+), 101 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index aeb1f52455..33c76192d2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -721,6 +721,16 @@ DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_sri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_sli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1db3b43a61..fa5c3f12b9 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -285,8 +285,6 @@ extern const GVecGen3 mls_op[4];
 extern const GVecGen3 cmtst_op[4];
 extern const GVecGen3 sshl_op[4];
 extern const GVecGen3 ushl_op[4];
-extern const GVecGen2i sri_op[4];
-extern const GVecGen2i sli_op[4];
 extern const GVecGen4 uqadd_op[4];
 extern const GVecGen4 sqadd_op[4];
 extern const GVecGen4 uqsub_op[4];
@@ -311,6 +309,11 @@ void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                     int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 50949d306b..2d7dad6c3f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -585,16 +585,6 @@ static void gen_gvec_op2(DisasContext *s, bool is_q, int rd,
                    is_q ? 16 : 8, vec_full_reg_size(s), gvec_op);
 }
 
-/* Expand a 2-operand + immediate AdvSIMD vector operation using
- * an op descriptor.
- */
-static void gen_gvec_op2i(DisasContext *s, bool is_q, int rd,
-                          int rn, int64_t imm, const GVecGen2i *gvec_op)
-{
-    tcg_gen_gvec_2i(vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
-                    is_q ? 16 : 8, vec_full_reg_size(s), imm, gvec_op);
-}
-
 /* Expand a 3-operand AdvSIMD vector operation using an op descriptor.  */
 static void gen_gvec_op3(DisasContext *s, bool is_q, int rd,
                          int rn, int rm, const GVecGen3 *gvec_op)
@@ -10191,12 +10181,9 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         gen_gvec_fn2i(s, is_q, rd, rn, shift,
                       is_u ? gen_gvec_usra : gen_gvec_ssra, size);
         return;
+
     case 0x08: /* SRI */
-        /* Shift count same as element size is valid but does nothing.  */
-        if (shift == 8 << size) {
-            goto done;
-        }
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &sri_op[size]);
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sri, size);
         return;
 
     case 0x00: /* SSHR / USHR */
@@ -10247,7 +10234,6 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     }
     tcg_temp_free_i64(tcg_round);
 
- done:
     clear_vec_high(s, is_q, rd);
 }
 
@@ -10272,7 +10258,7 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
     }
 
     if (insert) {
-        gen_gvec_op2i(s, is_q, rd, rn, shift, &sli_op[size]);
+        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sli, size);
     } else {
         gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shli, size);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 19bd514a84..e221d0c959 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4454,47 +4454,62 @@ static void gen_shr64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 
 static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
-    if (sh == 0) {
-        tcg_gen_mov_vec(d, a);
-    } else {
-        TCGv_vec t = tcg_temp_new_vec_matching(d);
-        TCGv_vec m = tcg_temp_new_vec_matching(d);
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
 
-        tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
-        tcg_gen_shri_vec(vece, t, a, sh);
-        tcg_gen_and_vec(vece, d, d, m);
-        tcg_gen_or_vec(vece, d, d, t);
+    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK((8 << vece) - sh, sh));
+    tcg_gen_shri_vec(vece, t, a, sh);
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
 
-        tcg_temp_free_vec(t);
-        tcg_temp_free_vec(m);
-    }
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
 }
 
-static const TCGOpcode vecop_list_sri[] = { INDEX_op_shri_vec, 0 };
+void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shri_vec, 0 };
+    const GVecGen2i ops[4] = {
+        { .fni8 = gen_shr8_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shr16_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shr32_ins_i32,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_shr64_ins_i64,
+          .fniv = gen_shr_ins_vec,
+          .fno = gen_helper_gvec_sri_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
 
-const GVecGen2i sri_op[4] = {
-    { .fni8 = gen_shr8_ins_i64,
-      .fniv = gen_shr_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_8 },
-    { .fni8 = gen_shr16_ins_i64,
-      .fniv = gen_shr_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_16 },
-    { .fni4 = gen_shr32_ins_i32,
-      .fniv = gen_shr_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_32 },
-    { .fni8 = gen_shr64_ins_i64,
-      .fniv = gen_shr_ins_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_sri,
-      .vece = MO_64 },
-};
+    /* tszimm encoding produces immediates in the range [1..esize]. */
+    tcg_debug_assert(shift > 0);
+    tcg_debug_assert(shift <= (8 << vece));
+
+    /* Shift of esize leaves destination unchanged. */
+    if (shift < (8 << vece)) {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    } else {
+        /* Nop, but we do need to clear the tail. */
+        tcg_gen_gvec_mov(vece, rd_ofs, rd_ofs, opr_sz, max_sz);
+    }
+}
 
 static void gen_shl8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
@@ -4532,47 +4547,60 @@ static void gen_shl64_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 
 static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
 {
-    if (sh == 0) {
-        tcg_gen_mov_vec(d, a);
-    } else {
-        TCGv_vec t = tcg_temp_new_vec_matching(d);
-        TCGv_vec m = tcg_temp_new_vec_matching(d);
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGv_vec m = tcg_temp_new_vec_matching(d);
 
-        tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
-        tcg_gen_shli_vec(vece, t, a, sh);
-        tcg_gen_and_vec(vece, d, d, m);
-        tcg_gen_or_vec(vece, d, d, t);
+    tcg_gen_shli_vec(vece, t, a, sh);
+    tcg_gen_dupi_vec(vece, m, MAKE_64BIT_MASK(0, sh));
+    tcg_gen_and_vec(vece, d, d, m);
+    tcg_gen_or_vec(vece, d, d, t);
 
-        tcg_temp_free_vec(t);
-        tcg_temp_free_vec(m);
-    }
+    tcg_temp_free_vec(t);
+    tcg_temp_free_vec(m);
 }
 
-static const TCGOpcode vecop_list_sli[] = { INDEX_op_shli_vec, 0 };
+void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                  int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
+    const GVecGen2i ops[4] = {
+        { .fni8 = gen_shl8_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_b,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = gen_shl16_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_h,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_shl32_ins_i32,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_s,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_shl64_ins_i64,
+          .fniv = gen_shl_ins_vec,
+          .fno = gen_helper_gvec_sli_d,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
 
-const GVecGen2i sli_op[4] = {
-    { .fni8 = gen_shl8_ins_i64,
-      .fniv = gen_shl_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_8 },
-    { .fni8 = gen_shl16_ins_i64,
-      .fniv = gen_shl_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_16 },
-    { .fni4 = gen_shl32_ins_i32,
-      .fniv = gen_shl_ins_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_32 },
-    { .fni8 = gen_shl64_ins_i64,
-      .fniv = gen_shl_ins_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_sli,
-      .vece = MO_64 },
-};
+    /* tszimm encoding produces immediates in the range [0..esize-1]. */
+    tcg_debug_assert(shift >= 0);
+    tcg_debug_assert(shift < (8 << vece));
+
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, rd_ofs, rm_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
+    }
+}
 
 static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
@@ -5713,20 +5741,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     /* Right shift comes here negative.  */
                     shift = -shift;
-                    /* Shift out of range leaves destination unchanged.  */
-                    if (shift < 8 << size) {
-                        tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size, vec_size,
-                                        shift, &sri_op[size]);
-                    }
+                    gen_gvec_sri(size, rd_ofs, rm_ofs, shift,
+                                 vec_size, vec_size);
                     return 0;
 
                 case 5: /* VSHL, VSLI */
                     if (u) { /* VSLI */
-                        /* Shift out of range leaves destination unchanged.  */
-                        if (shift < 8 << size) {
-                            tcg_gen_gvec_2i(rd_ofs, rm_ofs, vec_size,
-                                            vec_size, shift, &sli_op[size]);
-                        }
+                        gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
+                                     vec_size, vec_size);
                     } else { /* VSHL */
                         /* Shifts larger than the element size are
                          * architecturally valid and results in zero.
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index fd8b2bff49..096fea67ef 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -974,6 +974,44 @@ DO_RSRA(gvec_ursra_d, uint64_t)
 
 #undef DO_RSRA
 
+#define DO_SRI(NAME, TYPE)                              \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        d[i] = deposit64(d[i], 0, sizeof(TYPE) * 8 - shift, n[i] >> shift); \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_SRI(gvec_sri_b, uint8_t)
+DO_SRI(gvec_sri_h, uint16_t)
+DO_SRI(gvec_sri_s, uint32_t)
+DO_SRI(gvec_sri_d, uint64_t)
+
+#undef DO_SRI
+
+#define DO_SLI(NAME, TYPE)                              \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)    \
+{                                                       \
+    intptr_t i, oprsz = simd_oprsz(desc);               \
+    int shift = simd_data(desc);                        \
+    TYPE *d = vd, *n = vn;                              \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {        \
+        d[i] = deposit64(d[i], shift, sizeof(TYPE) * 8 - shift, n[i]); \
+    }                                                   \
+    clear_tail(d, oprsz, simd_maxsz(desc));             \
+}
+
+DO_SLI(gvec_sli_b, uint8_t)
+DO_SLI(gvec_sli_h, uint16_t)
+DO_SLI(gvec_sli_s, uint32_t)
+DO_SLI(gvec_sli_d, uint64_t)
+
+#undef DO_SLI
+
 /*
  * Convert float16 to float32, raising no exceptions and
  * preserving exceptional values, including SNaN.
-- 
2.20.1


