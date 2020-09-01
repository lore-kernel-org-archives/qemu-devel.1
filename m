Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F433C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D93205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXNSDOYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D93205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8FS-000740-CN
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD841-0000cc-19
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83y-0006Hg-Ag
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id b79so1547270wmb.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iu8h7Tl7CzBF+w9whyh1jVt1Sw/rmBmwBzGlhSDazO8=;
 b=dXNSDOYlvjDSlRJryv0wPt+A8I8fC7ezqzLCi9BQ4cZfuR5Tmnpk303HSfDs2wGI3e
 MlnLiL8v6e8CJdRW2jHpifIiAB7d4g938Dvv4AS3DwjuXRRx5XA9s5104j+yQoCuaywk
 VuKD0dET2KzZmWqiIIuI8rhXa9OoHBkjxk5dP/xQuFmHqcm9/iKtWVJneEJBDymVlvpd
 9F9tJNNxr3d3X9lO54yr1UySF5Ty0ZhbBidTQRv1bvuhPQwmbRwWjQmGnJQ1MAWAVSXU
 r7ii3bvdoj4ysN8kKnRZrKKCRmP6S9VPZ+K3fP2aDVM6J29LyinytsvKf6qvwuSO+Evw
 HG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iu8h7Tl7CzBF+w9whyh1jVt1Sw/rmBmwBzGlhSDazO8=;
 b=qhFeyxxvrRUvHdWJv0sCtTyCKOtk82HscDVjfifqH+255KjAPPiVgITf7Gk6ybBzAn
 l7VDbvTs07Yy/wLar03ApCKOArXKBpMAPLYG/J/RBwWzbcP68v1SaTSsv3FUX92SWKSC
 WdtvX0LrXmhFqfR0WDdDjzvt4syHmx8F/7Gd+nP53N9XvR40ZxSq1MNDpH+vuuTIiHxK
 Bn8a2TUsbKOPnR6uPVDG2Dv/p/goP293NPleL0OWdvNPJlQFvBfLmAz9rEqLfnI6YNFf
 tE04HUgre1uynplqt9lsFCR+lk0eAnVZPolEoSRyU/szi7oZtYYbvP5Fgn0qHOQr5vsP
 e7/A==
X-Gm-Message-State: AOAM533VBVE0hi9VNjDhrzBW2PXU5emXMzpbKDt2QPa+2E3ShQZt3q4H
 ceOnAv8DjS4TUVxgYXXKGZNpcE1MI67q3nKA
X-Google-Smtp-Source: ABdhPJyshhxAmyf+lmkYiUAwZbGdukyfgFmwJf99XTgJ96SklROLBmjIYVbpDDB5Q6K1JWnq/7ILSQ==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr2288702wmf.93.1598973548576; 
 Tue, 01 Sep 2020 08:19:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/47] target/arm: Implement fp16 for Neon pairwise fp ops
Date: Tue,  1 Sep 2020 16:18:10 +0100
Message-Id: <20200901151823.29785-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the Neon pairwise fp ops to use a single gvic-style
helper to do the full operation instead of one helper call
for each 32-bit part. This allows us to use the same
framework to implement the fp16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-36-peter.maydell@linaro.org
---
 target/arm/helper.h             |  7 +++++
 target/arm/vec_helper.c         | 45 +++++++++++++++++++++++++++++++++
 target/arm/translate-neon.c.inc | 42 ++++++++++++------------------
 3 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5a716498913..f1f33c696d9 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -607,6 +607,13 @@ DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pminh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index e5bb5e395cb..46623d401e7 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1771,3 +1771,48 @@ DO_ABA(gvec_uaba_s, uint32_t)
 DO_ABA(gvec_uaba_d, uint64_t)
 
 #undef DO_ABA
+
+#define DO_NEON_PAIRWISE(NAME, OP)                                      \
+    void HELPER(NAME##s)(void *vd, void *vn, void *vm,                  \
+                         void *stat, uint32_t oprsz)                    \
+    {                                                                   \
+        float_status *fpst = stat;                                      \
+        float32 *d = vd;                                                \
+        float32 *n = vn;                                                \
+        float32 *m = vm;                                                \
+        float32 r0, r1;                                                 \
+                                                                        \
+        /* Read all inputs before writing outputs in case vm == vd */   \
+        r0 = float32_##OP(n[H4(0)], n[H4(1)], fpst);                    \
+        r1 = float32_##OP(m[H4(0)], m[H4(1)], fpst);                    \
+                                                                        \
+        d[H4(0)] = r0;                                                  \
+        d[H4(1)] = r1;                                                  \
+    }                                                                   \
+                                                                        \
+    void HELPER(NAME##h)(void *vd, void *vn, void *vm,                  \
+                         void *stat, uint32_t oprsz)                    \
+    {                                                                   \
+        float_status *fpst = stat;                                      \
+        float16 *d = vd;                                                \
+        float16 *n = vn;                                                \
+        float16 *m = vm;                                                \
+        float16 r0, r1, r2, r3;                                         \
+                                                                        \
+        /* Read all inputs before writing outputs in case vm == vd */   \
+        r0 = float16_##OP(n[H2(0)], n[H2(1)], fpst);                    \
+        r1 = float16_##OP(n[H2(2)], n[H2(3)], fpst);                    \
+        r2 = float16_##OP(m[H2(0)], m[H2(1)], fpst);                    \
+        r3 = float16_##OP(m[H2(2)], m[H2(3)], fpst);                    \
+                                                                        \
+        d[H4(0)] = r0;                                                  \
+        d[H4(1)] = r1;                                                  \
+        d[H4(2)] = r2;                                                  \
+        d[H4(3)] = r3;                                                  \
+    }
+
+DO_NEON_PAIRWISE(neon_padd, add)
+DO_NEON_PAIRWISE(neon_pmax, max)
+DO_NEON_PAIRWISE(neon_pmin, min)
+
+#undef DO_NEON_PAIRWISE
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 4c6d63be3d3..d13075986e5 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1112,10 +1112,10 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
-static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
+static bool do_3same_fp_pair(DisasContext *s, arg_3same *a,
+                             gen_helper_gvec_3_ptr *fn)
 {
-    /* FP operations handled pairwise 32 bits at a time */
-    TCGv_i32 tmp, tmp2, tmp3;
+    /* FP pairwise operations */
     TCGv_ptr fpstatus;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -1134,26 +1134,14 @@ static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 
     assert(a->q == 0); /* enforced by decode patterns */
 
-    /*
-     * Note that we have to be careful not to clobber the source operands
-     * in the "vm == vd" case by storing the result of the first pass too
-     * early. Since Q is 0 there are always just two passes, so instead
-     * of a complicated loop over each pass we just unroll.
-     */
-    fpstatus = fpstatus_ptr(FPST_STD);
-    tmp = neon_load_reg(a->vn, 0);
-    tmp2 = neon_load_reg(a->vn, 1);
-    fn(tmp, tmp, tmp2, fpstatus);
-    tcg_temp_free_i32(tmp2);
 
-    tmp3 = neon_load_reg(a->vm, 0);
-    tmp2 = neon_load_reg(a->vm, 1);
-    fn(tmp3, tmp3, tmp2, fpstatus);
-    tcg_temp_free_i32(tmp2);
+    fpstatus = fpstatus_ptr(a->size != 0 ? FPST_STD_F16 : FPST_STD);
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpstatus, 8, 8, 0, fn);
     tcg_temp_free_ptr(fpstatus);
 
-    neon_store_reg(a->vd, 0, tmp);
-    neon_store_reg(a->vd, 1, tmp3);
     return true;
 }
 
@@ -1165,15 +1153,17 @@ static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
     static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
     {                                                               \
         if (a->size != 0) {                                         \
-            /* TODO fp16 support */                                 \
-            return false;                                           \
+            if (!dc_isar_feature(aa32_fp16_arith, s)) {             \
+                return false;                                       \
+            }                                                       \
+            return do_3same_fp_pair(s, a, FUNC##h);                 \
         }                                                           \
-        return do_3same_fp_pair(s, a, FUNC);                        \
+        return do_3same_fp_pair(s, a, FUNC##s);                     \
     }
 
-DO_3S_FP_PAIR(VPADD, gen_helper_vfp_adds)
-DO_3S_FP_PAIR(VPMAX, gen_helper_vfp_maxs)
-DO_3S_FP_PAIR(VPMIN, gen_helper_vfp_mins)
+DO_3S_FP_PAIR(VPADD, gen_helper_neon_padd)
+DO_3S_FP_PAIR(VPMAX, gen_helper_neon_pmax)
+DO_3S_FP_PAIR(VPMIN, gen_helper_neon_pmin)
 
 static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 {
-- 
2.20.1


