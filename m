Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A187BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9A6207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/4uadFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9A6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX56Z-0007dL-K6
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pO-0004cK-7A
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:19 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pK-00076F-8u
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id j21so999785pgb.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bq1T35WTx3CYkI2SYC9Hyi7M0Eqbmy6VmAmWCxKnbCw=;
 b=b/4uadFitO7HkqRLhXIX7Tolfi/VbYL+s6jJbQW6xWidQNuMLPd3tYN+nYTrjycv6p
 HFsSUy8GU3AyR0wynL0KsCxpaMUI9ZzwUBkSyaVAab4IoEis52YQfmgCJJOhCuzA2f2D
 Keq6+eU6eFDW+NNf7yfLDj5QO29r+hi041iPL2wQVJruTP7M+3VOLPJEk7tLVPjxgLQ6
 mZghtUZ+MKrFzm1srOCz/WjeG/EAjDBnw7dOp5zUDSjNiBkYQ9kcqZGRIi8cGi/FipPM
 pDg36h/JP4y7n7x5yF1Nx/6jIqrSX7dAtzKawg91CDSMl5RNVB5+RidHQQP3k0RAxh/y
 HvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bq1T35WTx3CYkI2SYC9Hyi7M0Eqbmy6VmAmWCxKnbCw=;
 b=SnYa9FVfi7ATe5AMC/w5+y6j3gzWqRmqlqFK1JrH6b2awmZg1Dn2f8kzK9GJ3oSWJU
 dMiJwxRDXmOCaLFJ/H2uzbaZ0e2v1y2eMwBfzWITJmHY+fzHwxpdJnI9ehuzHzfbm8jj
 vgp5IuQ+x840zszJGdJxKC/MBXrlgSecxzEXkAWen2+D237XLe4ffQe6PhmCFgybcx2o
 znroicZA7G0a7KrJhMDC3nIrwL6WYvbUH2JE1je4p0+sj5AWZIzQzrDYxCy4jxR2/jj+
 1Hq8xkTBRsPf/QupfQ4BwRmOuUeXTmE2ZJRLn2YdjPSNXZ274FJ890vqCcpnV7kpvyjt
 Vlng==
X-Gm-Message-State: AGi0PubhYjZ7Rk8OCDABzo/DpF5M4jbqq2Lru9bn+g7MU9xjuLVoyn2G
 +je3GZRzojt5TK+uC0LRYkEMOoCssGg=
X-Google-Smtp-Source: APiQypLGrpDn7X1GKcv/i4UfKJKq4PLD6v2N/VMxWQJxWd+xA2U/2fPz5PN+bF4mdjOOKqWnIqLniQ==
X-Received: by 2002:aa7:842b:: with SMTP id q11mr3421533pfn.302.1588951331794; 
 Fri, 08 May 2020 08:22:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/16] target/arm: Create gen_gvec_{mla,mls}
Date: Fri,  8 May 2020 08:21:51 -0700
Message-Id: <20200508152200.6547-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
 target/arm/translate.h          |   7 +-
 target/arm/translate-a64.c      |   4 +-
 target/arm/translate-neon.inc.c |  16 +----
 target/arm/translate.c          | 117 +++++++++++++++++---------------
 4 files changed, 71 insertions(+), 73 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index e35c812cc5..9354ceba35 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -286,8 +286,11 @@ void gen_gvec_cle0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
 void gen_gvec_cge0(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    uint32_t opr_sz, uint32_t max_sz);
 
-extern const GVecGen3 mla_op[4];
-extern const GVecGen3 mls_op[4];
+void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 extern const GVecGen3 cmtst_op[4];
 extern const GVecGen3 sshl_op[4];
 extern const GVecGen3 ushl_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fef93dc27a..ab9df12e44 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11226,9 +11226,9 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         return;
     case 0x12: /* MLA, MLS */
         if (u) {
-            gen_gvec_op3(s, is_q, rd, rn, rm, &mls_op[size]);
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mls, size);
         } else {
-            gen_gvec_op3(s, is_q, rd, rn, rm, &mla_op[size]);
+            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mla, size);
         }
         return;
     case 0x11:
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 50b77b6d71..aefeff498a 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -632,6 +632,8 @@ DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
 DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
 DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
 DO_3SAME_NO_SZ_3(VMUL, tcg_gen_gvec_mul)
+DO_3SAME_NO_SZ_3(VMLA, gen_gvec_mla)
+DO_3SAME_NO_SZ_3(VMLS, gen_gvec_mls)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -685,20 +687,6 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMUL_p_3s);
 }
 
-#define DO_3SAME_GVEC3_NO_SZ_3(INSN, OPARRAY)                           \
-    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
-                                uint32_t rn_ofs, uint32_t rm_ofs,       \
-                                uint32_t oprsz, uint32_t maxsz)         \
-    {                                                                   \
-        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,                          \
-                       oprsz, maxsz, &OPARRAY[vece]);                   \
-    }                                                                   \
-    DO_3SAME_NO_SZ_3(INSN, gen_##INSN##_3s)
-
-
-DO_3SAME_GVEC3_NO_SZ_3(VMLA, mla_op)
-DO_3SAME_GVEC3_NO_SZ_3(VMLS, mls_op)
-
 #define DO_3SAME_GVEC3_SHIFT(INSN, OPARRAY)                             \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
                                 uint32_t rn_ofs, uint32_t rm_ofs,       \
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 45df3743f6..52b6d32cf1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4520,62 +4520,69 @@ static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 /* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
  * these tables are shared with AArch64 which does support them.
  */
+void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_add_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_mla8_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_mla16_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_mla32_i32,
+          .fniv = gen_mla_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_mla64_i64,
+          .fniv = gen_mla_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
-static const TCGOpcode vecop_list_mla[] = {
-    INDEX_op_mul_vec, INDEX_op_add_vec, 0
-};
-
-static const TCGOpcode vecop_list_mls[] = {
-    INDEX_op_mul_vec, INDEX_op_sub_vec, 0
-};
-
-const GVecGen3 mla_op[4] = {
-    { .fni4 = gen_mla8_i32,
-      .fniv = gen_mla_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_8 },
-    { .fni4 = gen_mla16_i32,
-      .fniv = gen_mla_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_16 },
-    { .fni4 = gen_mla32_i32,
-      .fniv = gen_mla_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_32 },
-    { .fni8 = gen_mla64_i64,
-      .fniv = gen_mla_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_mla,
-      .vece = MO_64 },
-};
-
-const GVecGen3 mls_op[4] = {
-    { .fni4 = gen_mls8_i32,
-      .fniv = gen_mls_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_8 },
-    { .fni4 = gen_mls16_i32,
-      .fniv = gen_mls_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_16 },
-    { .fni4 = gen_mls32_i32,
-      .fniv = gen_mls_vec,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_32 },
-    { .fni8 = gen_mls64_i64,
-      .fniv = gen_mls_vec,
-      .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-      .load_dest = true,
-      .opt_opc = vecop_list_mls,
-      .vece = MO_64 },
-};
+void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_mul_vec, INDEX_op_sub_vec, 0
+    };
+    static const GVecGen3 ops[4] = {
+        { .fni4 = gen_mls8_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni4 = gen_mls16_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = gen_mls32_i32,
+          .fniv = gen_mls_vec,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = gen_mls64_i64,
+          .fniv = gen_mls_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .load_dest = true,
+          .opt_opc = vecop_list,
+          .vece = MO_64 },
+    };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
+}
 
 /* CMTST : test is "if (X & Y != 0)". */
 static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-- 
2.20.1


