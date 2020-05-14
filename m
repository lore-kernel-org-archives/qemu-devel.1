Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2561DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36F2205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erP36loi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36F2205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFDF-0000hY-1n
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkm-0003oM-Cb
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkl-00060F-9A
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id e1so4372372wrt.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3my1ZsHEJZclD6Eew7pFGG7zBh5TiGgGHILSpeucyOM=;
 b=erP36loifoV+eFCVVz6aYXr3T6JIl1BY+p1ZNgMvc71wLficPPapQia37mwi+2vqpC
 rz/gxYq1bz/kvhjTNIVJzh3JFDFKjIffTfe7QM02DEHIVshrLZ8W1SLsfAVA8m50bivh
 +DpDTGInEWf40Qa5UxsGles9htkxkVi389WkMh5T9gHoJkev73lhvDmpQsSNSjNYklEq
 XrXJhQmO/PViMuMLKfyAXdmGoTuxAf13kT/bloIL3fCqPlU/0zwsH61817xezqEsBiMx
 EiI/4+XR/TVYpWn6vVq31q1Y+GDV+QSCjJzlk2iBi5bIfrsvBwYMnCt1scPvi2Ss8RVP
 7bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3my1ZsHEJZclD6Eew7pFGG7zBh5TiGgGHILSpeucyOM=;
 b=r4/hwGP/nDKGb9HEi5+jcWjSyvdNhsFREzOeVbwtbysHKNeb/MVqSJ49KP9JtXnfXr
 YltPpxUD/2DUt97mhHHY9ZmBHHGz67tjJ6/wPjPrdosC7++u2J0kH8JM+KKCfUAykr1H
 aGyiwRVZg9RAPFFQMiWcx7Dcb2cuxtDcVZH7xRuSpJRBfU6P5uo7EF3ItzE3Q1u/pBi7
 lMSXGnOPJSZRajM2x54RD/Rg48V14b1x2h321JwNbBFUrWOLRAsG6ri2KhXCqA+e/cwN
 fJOs6lFtCLZ2WaOtSUpC2zHEOTUugRDfGZnfNBIfXVrrb5jLOLMz0pp5pvfrGx9eD9et
 EYcA==
X-Gm-Message-State: AOAM532B20RFGzPQTWILz5K0cOZthLtAb5NsxdxtlmkKSaOkTCgPECRD
 EKOH/KnbqDavr/mnxjFMzdAB8VOm2QcDAA==
X-Google-Smtp-Source: ABdhPJz9SEBExtn6uUoDU+EIS0laO5ILpm/21H5RGu9gGyVdPtS9NuKxD7oRhfQOGSxsS4tz8XF7uA==
X-Received: by 2002:a5d:42c9:: with SMTP id t9mr6019209wrr.246.1589466145610; 
 Thu, 14 May 2020 07:22:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/45] target/arm: Convert Neon VQSHL, VRSHL,
 VQRSHL 3-reg-same insns to decodetree
Date: Thu, 14 May 2020 15:21:28 +0100
Message-Id: <20200514142138.20875-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Convert the VQSHL, VRSHL and VQRSHL insns in the 3-reg-same
group to decodetree. We have already implemented the size==0b11
case of these insns; this commit handles the remaining sizes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-8-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 30 ++++++++++++++++++-----
 target/arm/translate-neon.inc.c | 43 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 22 +++--------------
 3 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 4984a5d4e19..34bce81c434 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -95,12 +95,30 @@ VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
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


