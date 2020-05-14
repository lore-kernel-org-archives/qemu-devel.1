Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58402C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220E520727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcSg68p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220E520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFAf-0002be-8a
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEks-00041I-JE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkr-000616-EI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so4406551wru.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IcPoZAWr90eAcgnD5xjdYB5j3Bxkpn9Z6Cbt0PEBTbM=;
 b=lcSg68p34MKWq9DZgHNpPHk1KvLfwJjSSvx73tFjRST9jzeZCGPIoWkoNj0+vElyxs
 rd7acrlOmtsKCrrz64EnD+QQ6LJmyPrXLh1hCosNsx0c1g5MV2CtaSyL5F66Ew8zvd3H
 nuafr6SRizxnf6qhgL/nJLXf/GkXer9Wc9JN5nisWdhawSmqGwq5IpMkhTHjQJ/AmNNR
 4VsrQ/oYqnPMalCrvEGX9H3JNEawoWXN/EkLa6hPPqySLpXMbqiaTJ09hs28OcPbmVe8
 Yw4uJPAaTJlhMX2e9BKh5jWVTVfkqszT9b+vsvEad2QXKfRKTamZb2BPuaFY6OqtU4eW
 4PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IcPoZAWr90eAcgnD5xjdYB5j3Bxkpn9Z6Cbt0PEBTbM=;
 b=OKXRsOqs4X9ivgu1Xb0zBb+9OkYRRy2ThND9lkEIVPmVBhcs9XloFmIJhBBwIeQ8t8
 tZSP3If/VwJJ1qImdH/I7DJ68ZDFAmtDFDQkRIGyLtOOmU+AazXtSwz0dvAFlw7+q7v+
 CEq98+3WVSu8i/pUqPRH7rGZET+PSV7GAOwnAhVxYaGrDjhh9ZqYVIZFU5+xe8J4fg6f
 0/rHfGvvGgvlZU/WbL/DQfIFye2pQ3bCqmbbaLiB5mzX0fSgOhPrmwSwyeq2DAgz1N8t
 g1tcq2ox52kafFt6F0lpSqz6BXB+g3V0tsh724iGf6e522poCu3rliIfxT8gCY2faLMs
 R+9Q==
X-Gm-Message-State: AOAM532qDb9y6CuCl5e2aaN3zW3Z6UIHTvRejJILlYYbaFd0T/+L0rwb
 338DglCBsjK4UFX5ii7j6+v88Lm0iEavAA==
X-Google-Smtp-Source: ABdhPJy9znf9D+3HLV6w6nCJYA39RI8qvEJQfYcGVlEEWj3V+9wbC85YRmI1j0SuFC2isQsaYysbqw==
X-Received: by 2002:adf:8483:: with SMTP id 3mr5826125wrg.206.1589466151597;
 Thu, 14 May 2020 07:22:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/45] target/arm: Convert Neon VPMIN/VPMAX/VPADD float
 3-reg-same insns to decodetree
Date: Thu, 14 May 2020 15:21:33 +0100
Message-Id: <20200514142138.20875-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

Convert the Neon float VPMIN, VPMAX and VPADD 3-reg-same insns to
decodetree. These are the only remaining 'pairwise' operations,
so we can delete the pairwise-specific bits of the old decoder's
for-each-element loop now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-13-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  5 +++
 target/arm/translate-neon.inc.c | 63 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 63 +++++----------------------------
 3 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 0dd02f3b720..d66c67ca585 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -48,6 +48,8 @@
 # For FP insns the high bit of 'size' is used as part of opcode decode
 @3same_fp        .... ... . . . . size:1 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
+@3same_fp_q0     .... ... . . . . size:1 .... .... .... . 0 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
 
 VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
 VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
@@ -176,4 +178,7 @@ VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
 
 VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
 VSUB_fp_3s       1111 001 0 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VPADD_fp_3s      1111 001 1 0 . 0 . .... .... 1101 ... 0 .... @3same_fp_q0
 VABD_fp_3s       1111 001 1 0 . 1 . .... .... 1101 ... 0 .... @3same_fp
+VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
+VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 540720f5e0d..7bdf1e3fee8 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1049,3 +1049,66 @@ DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
 DO_3S_FP_GVEC(VADD, gen_helper_gvec_fadd_s)
 DO_3S_FP_GVEC(VSUB, gen_helper_gvec_fsub_s)
 DO_3S_FP_GVEC(VABD, gen_helper_gvec_fabd_s)
+
+static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
+{
+    /* FP operations handled pairwise 32 bits at a time */
+    TCGv_i32 tmp, tmp2, tmp3;
+    TCGv_ptr fpstatus;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    assert(a->q == 0); /* enforced by decode patterns */
+
+    /*
+     * Note that we have to be careful not to clobber the source operands
+     * in the "vm == vd" case by storing the result of the first pass too
+     * early. Since Q is 0 there are always just two passes, so instead
+     * of a complicated loop over each pass we just unroll.
+     */
+    fpstatus = get_fpstatus_ptr(1);
+    tmp = neon_load_reg(a->vn, 0);
+    tmp2 = neon_load_reg(a->vn, 1);
+    fn(tmp, tmp, tmp2, fpstatus);
+    tcg_temp_free_i32(tmp2);
+
+    tmp3 = neon_load_reg(a->vm, 0);
+    tmp2 = neon_load_reg(a->vm, 1);
+    fn(tmp3, tmp3, tmp2, fpstatus);
+    tcg_temp_free_i32(tmp2);
+    tcg_temp_free_ptr(fpstatus);
+
+    neon_store_reg(a->vd, 0, tmp);
+    neon_store_reg(a->vd, 1, tmp3);
+    return true;
+}
+
+/*
+ * For all the functions using this macro, size == 1 means fp16,
+ * which is an architecture extension we don't implement yet.
+ */
+#define DO_3S_FP_PAIR(INSN,FUNC)                                    \
+    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
+    {                                                               \
+        if (a->size != 0) {                                         \
+            /* TODO fp16 support */                                 \
+            return false;                                           \
+        }                                                           \
+        return do_3same_fp_pair(s, a, FUNC);                        \
+    }
+
+DO_3S_FP_PAIR(VPADD, gen_helper_vfp_adds)
+DO_3S_FP_PAIR(VPMAX, gen_helper_vfp_maxs)
+DO_3S_FP_PAIR(VPMIN, gen_helper_vfp_mins)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8a94856cd28..ca6ed09ec34 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5348,7 +5348,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int shift;
     int pass;
     int count;
-    int pairwise;
     int u;
     int vec_size;
     uint32_t imm;
@@ -5433,6 +5432,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VPMIN:
         case NEON_3R_VPADD_VQRDMLAH:
         case NEON_3R_VQDMULH_VQRDMULH:
+        case NEON_3R_FLOAT_ARITH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5441,16 +5441,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             /* 64-bit element instructions: handled by decodetree */
             return 1;
         }
-        pairwise = 0;
         switch (op) {
-        case NEON_3R_FLOAT_ARITH:
-            pairwise = (u && size < 2); /* if VPADD (float) */
-            if (!pairwise) {
-                return 1; /* handled by decodetree */
-            }
-            break;
         case NEON_3R_FLOAT_MINMAX:
-            pairwise = u; /* if VPMIN/VPMAX (float) */
+            if (u) {
+                return 1; /* VPMIN/VPMAX handled by decodetree */
+            }
             break;
         case NEON_3R_FLOAT_CMP:
             if (!u && size) {
@@ -5478,41 +5473,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             break;
         }
 
-        if (pairwise && q) {
-            /* All the pairwise insns UNDEF if Q is set */
-            return 1;
-        }
-
         for (pass = 0; pass < (q ? 4 : 2); pass++) {
 
-        if (pairwise) {
-            /* Pairwise.  */
-            if (pass < 1) {
-                tmp = neon_load_reg(rn, 0);
-                tmp2 = neon_load_reg(rn, 1);
-            } else {
-                tmp = neon_load_reg(rm, 0);
-                tmp2 = neon_load_reg(rm, 1);
-            }
-        } else {
-            /* Elementwise.  */
-            tmp = neon_load_reg(rn, pass);
-            tmp2 = neon_load_reg(rm, pass);
-        }
+        /* Elementwise.  */
+        tmp = neon_load_reg(rn, pass);
+        tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            switch ((u << 2) | size) {
-            case 4: /* VPADD */
-                gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
-                break;
-            default:
-                abort();
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
         case NEON_3R_FLOAT_MULTIPLY:
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
@@ -5603,22 +5569,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         tcg_temp_free_i32(tmp2);
 
-        /* Save the result.  For elementwise operations we can put it
-           straight into the destination register.  For pairwise operations
-           we have to be careful to avoid clobbering the source operands.  */
-        if (pairwise && rd == rm) {
-            neon_store_scratch(pass, tmp);
-        } else {
-            neon_store_reg(rd, pass, tmp);
-        }
+        neon_store_reg(rd, pass, tmp);
 
         } /* for pass */
-        if (pairwise && rd == rm) {
-            for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                tmp = neon_load_scratch(pass);
-                neon_store_reg(rd, pass, tmp);
-            }
-        }
         /* End of 3 register same size operations.  */
     } else if (insn & (1 << 4)) {
         if ((insn & 0x00380080) != 0) {
-- 
2.20.1


