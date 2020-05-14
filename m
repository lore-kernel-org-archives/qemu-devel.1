Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7259C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972982070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rht4GoqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972982070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEvT-0008Tn-OI
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkF-00037l-Jd
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkD-0005TH-Hd
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id 50so4329161wrc.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JsA738ox2tU8xDAqJCgnq7xGbwx2DjX+cKDDIqgm1c4=;
 b=rht4GoqW9SVtgWU28lJEQxbpL5+wnEqp4jUYWfg9nS9g2i1CwzqusNDl93pSM8WDYn
 SMHzLndFcxfIihes288Z1TQUH744hjUMVE0TKdD7fpu71DGjkdoRk0+dylV5gBK+/pJk
 6+MCHgogVV4bZVwBcTz/7BUm0SiM6L36S2MZtAGuXoFPP+iD6i+J32sbFU6k8WJ2crzL
 qbBI2PLFGi0ZvQnR8+aMVC0ZgBv1FYpF3OhjOAVCmQARuR5SqRhiho9JwL//Iv3LWlZ2
 FISYaKnPozosP5aoCPSKfOajQaIkc1DS57k2dBN+F2ySZz5mlmME6w8WKwK5C0st03Re
 0rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JsA738ox2tU8xDAqJCgnq7xGbwx2DjX+cKDDIqgm1c4=;
 b=iwOX28Cx46EuCaTEvDxaLGQ7+xTU60N9TeIQh/H0H6VyumCXYfGpjo6jdZgDBOu8Uh
 DZPNJ8PbIyakEvjN6RKfaxd9KaOY26r6LpGECJQw+m6Dyj4X8tp5MJaGao7o/oXAQKu8
 e38n+Rh2XOH60PG0Ko1PKPo2E8IwZgQ+GjmCStuKIUhIkaCQfLz05Q+tMEGK+mKl1Hns
 /r3ZdD/U86pWAJJb2g4ltOTWFkWZ54G8RzLBfUXPJgsntq0+McGU5CZrNil00VZeup0W
 gDGX6UUx2qIGHxrSll9nNRiNv/qxvbafrMoLiFynTB6smvkJDZPqkjtpXYiWgv9j3srg
 frIQ==
X-Gm-Message-State: AOAM533ZA9qFhfOyYL+f7uj2ehKw5oN7HlLk00kO+Sg0eZ60YThnNzTR
 fpBJIheQFJbaxRyF59xdRLzvfu7gLILfgQ==
X-Google-Smtp-Source: ABdhPJyL3+4OJDomKiL7WUAmhA/icAXyarEthB/9/zE1/KZeRPKxUQIt0RPgrWgfHFx5MKZKRpVr1A==
X-Received: by 2002:a5d:53c7:: with SMTP id a7mr6010476wrw.334.1589466111832; 
 Thu, 14 May 2020 07:21:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/45] target/arm: Create gen_gvec_{mla,mls}
Date: Thu, 14 May 2020 15:21:01 +0100
Message-Id: <20200514142138.20875-9-peter.maydell@linaro.org>
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
Message-id: 20200513163245.17915-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h          |   7 +-
 target/arm/translate-a64.c      |   4 +-
 target/arm/translate-neon.inc.c |  16 +----
 target/arm/translate.c          | 117 +++++++++++++++++---------------
 4 files changed, 71 insertions(+), 73 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index e35c812cc5e..9354ceba357 100644
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
index fef93dc27af..ab9df12e44d 100644
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
index 50b77b6d714..aefeff498a6 100644
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
index 010a158e632..face89a1f71 100644
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


