Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF9CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C833A206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4cfQOu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C833A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEqQ-0006T8-Sf
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkI-0003EC-UI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkH-0005US-BJ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id y3so4396834wrt.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xSudeFEaV9n3tBz1GQv6hJerW9a0Gu7yjBVu7zayWd4=;
 b=I4cfQOu6E+pFLb3ZpfA918UpAOiW0sr7tgne8qbfaufJ67pO7wXTUZDCiBOcJXL0gS
 +Uv1OYcRBVtqwn4aemXuXuRcPUnOJPjrXh7SJ6qooSjhCpr6+Awwp3w+oSh2VfnUZTji
 3r0BFbDmUwg1+F38UVdCkld1odw3ZrwAlLllYYLS/I1CtCNUvs/vKZo7P4kO4A5818wi
 uXfJaKu0LGeHJCMAgYj4pD2yu/qzlOTPBnlr/uotVlkw1z6X84fT6LDgczsumbliIUSY
 W3nmPiNvgcxF8kmED3Cadzlp/JQn6OMEPQaQbjoZ/Xa/vJyJR6ECqsdk9FcGlLTBOJD/
 fy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xSudeFEaV9n3tBz1GQv6hJerW9a0Gu7yjBVu7zayWd4=;
 b=t6p20N/gp9Lr7TxhoMoC3DcKyLUdFu62gXC8KZi/8GwK79tds/hQohCcC4+LRm7k6F
 GjA1+HUQYp0Yjn7hZ8SMA1Pfa0gnZs2GPbco4ah/q2eulkWC8u8njs7XuqFhcpVl0eWG
 RAfsronqOS5tymP/Ax2UEEbnLgAltQIwLryzJez3LNbUVcH6P8bf38p6CIpgECRnmOi/
 NH2RVXijy/JkMokqHmfQ160NUWJDltmzycVQmr3f/zR5RQ8bvXzgNtcLoJVcpizeKBm5
 ilUXT5VXMnHcvJpmPC9ClhjWsl/mqQmIfn32fnCkRQzYQoJsowgDdwFZijSZ9HVoNKeq
 nSEQ==
X-Gm-Message-State: AOAM5315bgRVUoJ/uzVrPVxGltPXmZARwlH1vdaIYib/MLFLb1SzjifM
 16Jyn3hSv8C3OB6HUzm1En8ueQkMuvIzxg==
X-Google-Smtp-Source: ABdhPJxApusU0lexFR94Z+PoqGFijBf77x4Jr17uk1HVQiUtlMPRsEoBJ7DLxcUASeRpQKlLlYXRsA==
X-Received: by 2002:a05:6000:1045:: with SMTP id
 c5mr5560372wrx.31.1589466115446; 
 Thu, 14 May 2020 07:21:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/45] target/arm: Create gen_gvec_{uqadd, sqadd, uqsub, sqsub}
Date: Thu, 14 May 2020 15:21:04 +0100
Message-Id: <20200514142138.20875-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h          |  13 +-
 target/arm/translate-a64.c      |  22 ++-
 target/arm/translate-neon.inc.c |  19 +--
 target/arm/translate.c          | 228 +++++++++++++++++---------------
 4 files changed, 147 insertions(+), 135 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a02a54cabf7..4e1778c5e09 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -298,16 +298,21 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
-extern const GVecGen4 uqadd_op[4];
-extern const GVecGen4 sqadd_op[4];
-extern const GVecGen4 uqsub_op[4];
-extern const GVecGen4 sqsub_op[4];
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
 void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
+void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3956c19ed8b..ea5f6ceadcb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11168,20 +11168,18 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x01: /* SQADD, UQADD */
-        tcg_gen_gvec_4(vec_full_reg_offset(s, rd),
-                       offsetof(CPUARMState, vfp.qc),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm),
-                       is_q ? 16 : 8, vec_full_reg_size(s),
-                       (u ? uqadd_op : sqadd_op) + size);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqadd_qc, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqadd_qc, size);
+        }
         return;
     case 0x05: /* SQSUB, UQSUB */
-        tcg_gen_gvec_4(vec_full_reg_offset(s, rd),
-                       offsetof(CPUARMState, vfp.qc),
-                       vec_full_reg_offset(s, rn),
-                       vec_full_reg_offset(s, rm),
-                       is_q ? 16 : 8, vec_full_reg_size(s),
-                       (u ? uqsub_op : sqsub_op) + size);
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqsub_qc, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqsub_qc, size);
+        }
         return;
     case 0x08: /* SSHL, USHL */
         if (u) {
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index e16475c212e..099491b16f3 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -605,6 +605,10 @@ DO_3SAME(VORN, tcg_gen_gvec_orc)
 DO_3SAME(VEOR, tcg_gen_gvec_xor)
 DO_3SAME(VSHL_S, gen_gvec_sshl)
 DO_3SAME(VSHL_U, gen_gvec_ushl)
+DO_3SAME(VQADD_S, gen_gvec_sqadd_qc)
+DO_3SAME(VQADD_U, gen_gvec_uqadd_qc)
+DO_3SAME(VQSUB_S, gen_gvec_sqsub_qc)
+DO_3SAME(VQSUB_U, gen_gvec_uqsub_qc)
 
 /* These insns are all gvec_bitsel but with the inputs in various orders. */
 #define DO_3SAME_BITSEL(INSN, O1, O2, O3)                               \
@@ -653,21 +657,6 @@ DO_3SAME_CMP(VCGE_S, TCG_COND_GE)
 DO_3SAME_CMP(VCGE_U, TCG_COND_GEU)
 DO_3SAME_CMP(VCEQ, TCG_COND_EQ)
 
-#define DO_3SAME_GVEC4(INSN, OPARRAY)                                   \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),           \
-                       rn_ofs, rm_ofs, oprsz, maxsz, &OPARRAY[vece]);   \
-    }                                                                   \
-    DO_3SAME(INSN, gen_##INSN##_3s)
-
-DO_3SAME_GVEC4(VQADD_S, sqadd_op)
-DO_3SAME_GVEC4(VQADD_U, uqadd_op)
-DO_3SAME_GVEC4(VQSUB_S, sqsub_op)
-DO_3SAME_GVEC4(VQSUB_U, uqsub_op)
-
 static void gen_VMUL_p_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                            uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index df91ff73e3d..7eb30cde600 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4925,32 +4925,37 @@ static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_uqadd[] = {
-    INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
-};
-
-const GVecGen4 uqadd_op[4] = {
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_b,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_8 },
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_h,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_16 },
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_s,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_32 },
-    { .fniv = gen_uqadd_vec,
-      .fno = gen_helper_gvec_uqadd_d,
-      .write_aofs = true,
-      .opt_opc = vecop_list_uqadd,
-      .vece = MO_64 },
-};
+void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_b,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_h,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_s,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fniv = gen_uqadd_vec,
+          .fno = gen_helper_gvec_uqadd_d,
+          .write_aofs = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -4963,32 +4968,37 @@ static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_sqadd[] = {
-    INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
-};
-
-const GVecGen4 sqadd_op[4] = {
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_b,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_8 },
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_h,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_16 },
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_s,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_32 },
-    { .fniv = gen_sqadd_vec,
-      .fno = gen_helper_gvec_sqadd_d,
-      .opt_opc = vecop_list_sqadd,
-      .write_aofs = true,
-      .vece = MO_64 },
-};
+void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_sqadd_vec,
+          .fno = gen_helper_gvec_sqadd_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -5001,32 +5011,37 @@ static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_uqsub[] = {
-    INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
-};
-
-const GVecGen4 uqsub_op[4] = {
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_b,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_8 },
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_h,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_16 },
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_s,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_32 },
-    { .fniv = gen_uqsub_vec,
-      .fno = gen_helper_gvec_uqsub_d,
-      .opt_opc = vecop_list_uqsub,
-      .write_aofs = true,
-      .vece = MO_64 },
-};
+void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_uqsub_vec,
+          .fno = gen_helper_gvec_uqsub_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
                           TCGv_vec a, TCGv_vec b)
@@ -5039,32 +5054,37 @@ static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
-static const TCGOpcode vecop_list_sqsub[] = {
-    INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
-};
-
-const GVecGen4 sqsub_op[4] = {
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_b,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_8 },
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_h,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_16 },
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_s,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_32 },
-    { .fniv = gen_sqsub_vec,
-      .fno = gen_helper_gvec_sqsub_d,
-      .opt_opc = vecop_list_sqsub,
-      .write_aofs = true,
-      .vece = MO_64 },
-};
+void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                       uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen4 ops[4] = {
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_b,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_8 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_h,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_16 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_s,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_32 },
+        { .fniv = gen_sqsub_vec,
+          .fno = gen_helper_gvec_sqsub_d,
+          .opt_opc = vecop_list,
+          .write_aofs = true,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                   rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
-- 
2.20.1


