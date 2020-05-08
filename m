Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D236C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFFE207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lPcA/yrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFFE207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX56I-000708-6X
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pR-0004hJ-TF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:56237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pN-00079l-Ua
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id js4so423515pjb.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wmlmEvDjH/qmc42bbx9VZXnXkTk1yDurmZ9MBCyd0Cw=;
 b=lPcA/yrMY46r1uejyXfemiobLrZgp9Q2QgS4Tl1dknPDWX4jwIROIxS7McmqpKINT8
 4/WNLmYvVryzN33Tv3woxJzUO9raRAV4MhCro0lHPQJYnQxVOzqIxKiNu/BNUiLVGGOo
 3MGLj3HXdqJ8x4itIP2suPoZNbgVsF/jmWmJeWC5MQ6JFwuVUSNYcA1dSuTtc0wpmwLN
 PvQc/kxVukh6yCxa1XDKgtloKW/nuBs2DSRfwQd2kSe4g+wL7AQxhGQ1/2wN85ilV4RD
 G8Zt8ya05UL2l3fs1RxvOi/RV9cRfF7Haqg4/21ITUOPYiQwwzQhqRDYfICMSuvqWVlc
 rC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wmlmEvDjH/qmc42bbx9VZXnXkTk1yDurmZ9MBCyd0Cw=;
 b=BkyAVKPJ+QNpnzxQdspmfWHacNOsT1Kr2u2OuUQdNAWLsEXH/ccCU77qSwm77Ypsff
 EuE/xtVxeDO6DlRp7qJPUt9HRauhpjTWPoVw/hhJqWJ629PHxDb03MfAH3Mf6zGIkUpZ
 NsNoDZdipgoQ7JtW9p9vpAv7/mmOybDQGoboVv0gZyFIQiAyGZJEn/UaCOklxHEIki/o
 lhGS12NlOoNAmlj4+I1T0tZbv+zmdGsT6gNTb0WdsdFx7gcHbDoqkAPpD9nLE4MN2qhy
 tZ7cbYpvHCh0Krwk0+5ZUS4Nvpfyv4LZHrEG4L/EAtMWclA5Xy83UYLvpA10qUT+emYY
 OZUQ==
X-Gm-Message-State: AGi0PubbGA5Z4V34bh/wnrgvxQ70hH+fb5nsy3y6C5HRPnew7i3pSvJX
 qmTX3jZOIv8GxAP6wNn5ho+k2wZ/11Y=
X-Google-Smtp-Source: APiQypL0O3nHRtnwomI63orZYDTfJ+wfGS9q1wBixOQpBD0u6PouMrabXfI8OAdSiRiOX8dSflSGkQ==
X-Received: by 2002:a17:90a:648d:: with SMTP id
 h13mr6507135pjj.12.1588951336008; 
 Fri, 08 May 2020 08:22:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/16] target/arm: Create gen_gvec_{uqadd, sqadd, uqsub,
 sqsub}
Date: Fri,  8 May 2020 08:21:54 -0700
Message-Id: <20200508152200.6547-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
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

Provide a functional interface for the vector expansion.
This fits better with the existing set of helpers that
we provide for other operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h          |  13 +-
 target/arm/translate-a64.c      |  22 ++-
 target/arm/translate-neon.inc.c |  19 +--
 target/arm/translate.c          | 228 +++++++++++++++++---------------
 4 files changed, 147 insertions(+), 135 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a02a54cabf..4e1778c5e0 100644
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
index 3956c19ed8..ea5f6ceadc 100644
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
index e16475c212..099491b16f 100644
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
index e366281274..72c3aab544 100644
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


