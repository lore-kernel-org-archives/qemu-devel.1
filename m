Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA684CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6554620730
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCaxqqlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6554620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY75-0003ZT-FA
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw7-0006Td-Px
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw6-000675-CF
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id k12so22509001wmj.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PpEsdABitILB0n477zrURAQAbSkegxBFrS84gleg/2g=;
 b=XCaxqqlJpeNtUuZhvdYnjmF9wr3CxEs9j2mndyw5MbFOfLj+ez3gZe3PeS2zzInC1X
 9aJkFKbbWpaRNBo8cL1pgc2Cuqp1oueYZ8JtYujVwyyBut2SHKC2IKPjWVvRsHeAbkcK
 IAJ+fk8VGpuJpMuanOlQKXcvE9A9N7UsSh9rQuu6e/MG70cWoU1bSAt2bfka2G3fdhZP
 uvN9fWzyz2iGaC1ydYjHjkE1mxqHErOGUlFijGLS9vMhEDvvzc1Y8MwOsVmkgxHzwJSA
 k304bfkU7xMR2rkrYIjzZL0KoTn+H8XhxuzR8GohPOZW+r/HVOLj3b/9k7lggIyUjBk4
 gOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PpEsdABitILB0n477zrURAQAbSkegxBFrS84gleg/2g=;
 b=TpX7eBVAgJg1LfmhIhodQKPBGkaKrsFv9y+N2sYXp6hCLpeSpJYY+Xx6XRwiQKOPh2
 tUihkPYf4FigsQq20ygGOX7/u1AeQM08P+MuhHSGSTudcrFSiA5/V5rGmRVcqlLhlrXv
 LC5J9O2sBlSEI2BibstwHntZQ15hrzG/6HTYVJ4B8JOTeUDSLXL/BW36o9nATW/6I4BG
 rbHPe1fqqgvUWRY5vA6wYCteQ9YM2GGUKTCvdZhjOEvtks92eFUozI4oRyLsp+GP5eR2
 WmxgX4/jea478putCX0s37cKJ/w7nRuAn+Ahg4WSv/VF58v2WJIV+XrAWS+f/0/HkXKh
 uQ0A==
X-Gm-Message-State: AGi0Puaup0+wKX78LeVf99vpTxPGVvi8I09XJvuNxjIuzj85M5apy1nl
 MTBeTxbVu90lBEF3XwV8iTCg/A==
X-Google-Smtp-Source: APiQypJUr4F9gg0V2PGbaakM8F35k2z2EFTLVuz4C5jfluy7uNSF9DfcFUcDiDmBWRs7vTru+m5cmg==
X-Received: by 2002:a7b:c046:: with SMTP id u6mr8336567wmc.57.1589301556894;
 Tue, 12 May 2020 09:39:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/17] target/arm: Convert Neon VQSHL, VRSHL,
 VQRSHL 3-reg-same insns to decodetree
Date: Tue, 12 May 2020 17:38:54 +0100
Message-Id: <20200512163904.10918-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VQSHL, VRSHL and VQRSHL insns in the 3-reg-same
group to decodetree. We have already implemented the size==0b11
case of these insns; this commit handles the remaining sizes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 47 +++++++++++++++++++++++----------
 target/arm/translate-neon.inc.c | 43 ++++++++++++++++++++++++++++++
 target/arm/translate.c          | 22 +++------------
 3 files changed, 79 insertions(+), 33 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 353cb1f4992..e0da5a39fc2 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -74,14 +74,6 @@ VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
 VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 
 # The shift operations are of the form Vd = Vm << Vn.
-# By reversing the names of the fields here, we can use standard expanders.
-@3same_rev       .... ... . . . size:2 .... .... .... . q:1 . . .... \
-                 &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp
-
-VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
-VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
-
-# Insns operating on 64-bit elements (size!=0b11 handled elsewhere)
 # The _rev suffix indicates that Vn and Vm are reversed. This is
 # the case for shifts. In the Arm ARM these insns are documented
 # with the Vm and Vn fields in their usual places, but in the
@@ -92,15 +84,42 @@ VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 # function code (where we would otherwise need to manually swap
 # the operands over to call Neon helper functions that are shared
 # with AArch64 which does not have this odd reversed-operand situation).
+@3same_rev       .... ... . . . size:2 .... .... .... . q:1 . . .... \
+                 &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp
+
+VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
+VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
+
+# Insns operating on 64-bit elements (size!=0b11 handled elsewhere)
+# The _rev suffix indicates that Vn and Vm are reversed (as explained
+# by the comment for the @3same_rev format).
 @3same_64_rev    .... ... . . . 11 .... .... .... . q:1 . . .... \
                  &3same vm=%vn_dp vn=%vm_dp vd=%vd_dp size=3
 
-VQSHL_S64_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
-VQSHL_U64_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
-VRSHL_S64_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
-VRSHL_U64_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
-VQRSHL_S64_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
-VQRSHL_U64_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
+{
+  VQSHL_S64_3s   1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
+  VQSHL_S_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_rev
+}
+{
+  VQSHL_U64_3s   1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_64_rev
+  VQSHL_U_3s     1111 001 1 0 . .. .... .... 0100 . . . 1 .... @3same_rev
+}
+{
+  VRSHL_S64_3s   1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
+  VRSHL_S_3s     1111 001 0 0 . .. .... .... 0101 . . . 0 .... @3same_rev
+}
+{
+  VRSHL_U64_3s   1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_64_rev
+  VRSHL_U_3s     1111 001 1 0 . .. .... .... 0101 . . . 0 .... @3same_rev
+}
+{
+  VQRSHL_S64_3s  1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
+  VQRSHL_S_3s    1111 001 0 0 . .. .... .... 0101 . . . 1 .... @3same_rev
+}
+{
+  VQRSHL_U64_3s  1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_64_rev
+  VQRSHL_U_3s    1111 001 1 0 . .. .... .... 0101 . . . 1 .... @3same_rev
+}
 
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index e9da47171c6..7097c18f334 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -875,9 +875,52 @@ DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
         return do_3same(s, a, gen_##INSN##_3s);                         \
     }
 
+/*
+ * Some helper functions need to be passed the cpu_env. In order
+ * to use those with the gvec APIs like tcg_gen_gvec_3() we need
+ * to create wrapper functions whose prototype is a NeonGenTwoOpFn()
+ * and which call a NeonGenTwoOpEnvFn().
+ */
+#define WRAP_ENV_FN(WRAPNAME, FUNC)                                     \
+    static void WRAPNAME(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m)            \
+    {                                                                   \
+        FUNC(d, cpu_env, n, m);                                         \
+    }
+
+#define DO_3SAME_32_ENV(INSN, FUNC)                                     \
+    WRAP_ENV_FN(gen_##INSN##_tramp8, gen_helper_neon_##FUNC##8);        \
+    WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##16);      \
+    WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##32);      \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        static const GVecGen3 ops[4] = {                                \
+            { .fni4 = gen_##INSN##_tramp8 },                            \
+            { .fni4 = gen_##INSN##_tramp16 },                           \
+            { .fni4 = gen_##INSN##_tramp32 },                           \
+            { 0 },                                                      \
+        };                                                              \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops[vece]); \
+    }                                                                   \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (a->size > 2) {                                              \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, gen_##INSN##_3s);                         \
+    }
+
 DO_3SAME_32(VHADD_S, hadd_s)
 DO_3SAME_32(VHADD_U, hadd_u)
 DO_3SAME_32(VHSUB_S, hsub_s)
 DO_3SAME_32(VHSUB_U, hsub_u)
 DO_3SAME_32(VRHADD_S, rhadd_s)
 DO_3SAME_32(VRHADD_U, rhadd_u)
+DO_3SAME_32(VRSHL_S, rshl_s)
+DO_3SAME_32(VRSHL_U, rshl_u)
+
+DO_3SAME_32_ENV(VQSHL_S, qshl_s)
+DO_3SAME_32_ENV(VQSHL_U, qshl_u)
+DO_3SAME_32_ENV(VQRSHL_S, qrshl_s)
+DO_3SAME_32_ENV(VQRSHL_U, qrshl_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ebb899d846e..3aabb18720b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5439,6 +5439,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VHSUB:
         case NEON_3R_VABD:
         case NEON_3R_VABA:
+        case NEON_3R_VQSHL:
+        case NEON_3R_VRSHL:
+        case NEON_3R_VQRSHL:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5449,17 +5452,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VQSHL:
-        case NEON_3R_VRSHL:
-        case NEON_3R_VQRSHL:
-            {
-                int rtmp;
-                /* Shift instruction operands are reversed.  */
-                rtmp = rn;
-                rn = rm;
-                rm = rtmp;
-            }
-            break;
         case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
@@ -5519,14 +5511,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VQSHL:
-            GEN_NEON_INTEGER_OP_ENV(qshl);
-            break;
-        case NEON_3R_VRSHL:
-            GEN_NEON_INTEGER_OP(rshl);
-            break;
-        case NEON_3R_VQRSHL:
-            GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
         case NEON_3R_VPMAX:
             GEN_NEON_INTEGER_OP(pmax);
-- 
2.20.1


