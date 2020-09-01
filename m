Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0CBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B421F21582
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9YT61NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B421F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Fj-0007RW-Rz
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83S-0007Zd-SJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83Q-0006Af-0u
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id l9so1554745wme.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=X8+3/yjoi0SOSIlxkn2Zqjo/WWunmWBdDwZBzfSe9Dw=;
 b=N9YT61NJAmBlsiTOwpLtzGWRxk0TA1pP+T5aJ+3wv0BCZh6b5GKOqJ09tkevljhVYY
 42JbzzCL4lGSu1scVrnFfCMCdmlxbPcvUOozmqEMw8t/BilNkulax9mEZ0OFN9/0SIWK
 /0VdxcQAo4PZCMZxRXi6ZelO6skwglDCCz/byam0/jFp5BvVyerV3lJfDEMtvM1iNz20
 sYDa9mv+2Lz0bJgD4RGGzn+yxElbXAloljXfC0cHGt/aF5qyMfruMnnov8g5BIelrRv7
 xnMjHCjPnuDvQzKq10Uix0VnMsJqnlf+uFO2DpSMQNuQDpoGy/L9MB1kDYfUtNQhSGKR
 cmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X8+3/yjoi0SOSIlxkn2Zqjo/WWunmWBdDwZBzfSe9Dw=;
 b=sphPkjk29FfqcdS1Nlh+mLr7OYdlb57TZV5EdWBHnA9r6XHc5jyo27oUFQDrU9netl
 1eAgrFXqKa+AG8l9MZ634T/tohelxaFn0hOdeSnckBPVm0HYxMFJEvi8IOlJZAu9bvUN
 EbOahATROPPcBe3hETWfAOQpBdKzc/qVX7zL7N6CHlztgsnE2v2HI9tUFVOZHb8xVijO
 fR5JlbLDTle/71RKssvmBjNgckQ+1Im2Ga4gXDlz65od5MTSsXrb4V4kvoAKPjnvHbnv
 2eaYjw3W+F51Vl+siiVcVlsbt6KrFg3XrfFxiKJ8jS64S+KviVAN7pdYQl6pxeNK1tq7
 Gqmw==
X-Gm-Message-State: AOAM530zPJpRPqv0u8Gog02NzXwSgbV/qrKXZ7AA+Fd9jPSAs25l6ffV
 cjQSMPurtq1/15gLuno0l2HKOhsPurWBfkIW
X-Google-Smtp-Source: ABdhPJw9GbJgyH+BLGdX4yceEPfUCkcWMMN5sZUcf9XC3+z8IV4Yn6TGwMbYzdT/+byDhrSHwVRNjQ==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr2311941wmb.11.1598973513944; 
 Tue, 01 Sep 2020 08:18:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/47] target/arm: Implement VFP fp16 for fused-multiply-add
Date: Tue,  1 Sep 2020 16:17:42 +0100
Message-Id: <20200901151823.29785-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Implement VFP fp16 support for fused multiply-add insns
VFNMA, VFNMS, VFMA, VFMS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-7-peter.maydell@linaro.org
---
 target/arm/helper.h            |  1 +
 target/arm/vfp.decode          |  5 +++
 target/arm/vfp_helper.c        |  7 ++++
 target/arm/translate-vfp.c.inc | 64 ++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 58f9c4e933e..538b1a20ce5 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -213,6 +213,7 @@ DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
 
 DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
 DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
+DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
 
 DEF_HELPER_3(recps_f32, f32, env, f32, f32)
 DEF_HELPER_3(rsqrts_f32, f32, env, f32, f32)
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index e5545076a51..af4829e201b 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -139,6 +139,11 @@ VDIV_hp      ---- 1110 1.00 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
+VFMA_hp      ---- 1110 1.10 .... .... 1001 .0. 0 ....       @vfp_dnm_s
+VFMS_hp      ---- 1110 1.10 .... .... 1001 .1. 0 ....       @vfp_dnm_s
+VFNMA_hp     ---- 1110 1.01 .... .... 1001 .0. 0 ....       @vfp_dnm_s
+VFNMS_hp     ---- 1110 1.01 .... .... 1001 .1. 0 ....       @vfp_dnm_s
+
 VFMA_sp      ---- 1110 1.10 .... .... 1010 .0. 0 ....       @vfp_dnm_s
 VFMS_sp      ---- 1110 1.10 .... .... 1010 .1. 0 ....       @vfp_dnm_s
 VFNMA_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index f93ddf0b208..579ca3832d1 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1062,6 +1062,13 @@ uint32_t HELPER(rsqrte_u32)(uint32_t a)
 }
 
 /* VFPv4 fused multiply-accumulate */
+dh_ctype_f16 VFP_HELPER(muladd, h)(dh_ctype_f16 a, dh_ctype_f16 b,
+                                   dh_ctype_f16 c, void *fpstp)
+{
+    float_status *fpst = fpstp;
+    return float16_muladd(a, b, c, 0, fpst);
+}
+
 float32 VFP_HELPER(muladd, s)(float32 a, float32 b, float32 c, void *fpstp)
 {
     float_status *fpst = fpstp;
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 9937fa569e4..b5eb9d66b3d 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -1913,6 +1913,69 @@ static bool trans_VMAXNM_dp(DisasContext *s, arg_VMAXNM_dp *a)
                          a->vd, a->vn, a->vm, false);
 }
 
+static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
+{
+    /*
+     * VFNMA : fd = muladd(-fd,  fn, fm)
+     * VFNMS : fd = muladd(-fd, -fn, fm)
+     * VFMA  : fd = muladd( fd,  fn, fm)
+     * VFMS  : fd = muladd( fd, -fn, fm)
+     *
+     * These are fused multiply-add, and must be done as one floating
+     * point operation with no rounding between the multiplication and
+     * addition steps.  NB that doing the negations here as separate
+     * steps is correct : an input NaN should come out with its sign
+     * bit flipped if it is a negated-input.
+     */
+    TCGv_ptr fpst;
+    TCGv_i32 vn, vm, vd;
+
+    /*
+     * Present in VFPv4 only, and only with the FP16 extension.
+     * Note that we can't rely on the SIMDFMAC check alone, because
+     * in a Neon-no-VFP core that ID register field will be non-zero.
+     */
+    if (!dc_isar_feature(aa32_fp16_arith, s) ||
+        !dc_isar_feature(aa32_simdfmac, s) ||
+        !dc_isar_feature(aa32_fpsp_v2, s)) {
+        return false;
+    }
+
+    if (s->vec_len != 0 || s->vec_stride != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vn = tcg_temp_new_i32();
+    vm = tcg_temp_new_i32();
+    vd = tcg_temp_new_i32();
+
+    neon_load_reg32(vn, a->vn);
+    neon_load_reg32(vm, a->vm);
+    if (neg_n) {
+        /* VFNMS, VFMS */
+        gen_helper_vfp_negh(vn, vn);
+    }
+    neon_load_reg32(vd, a->vd);
+    if (neg_d) {
+        /* VFNMA, VFNMS */
+        gen_helper_vfp_negh(vd, vd);
+    }
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    gen_helper_vfp_muladdh(vd, vn, vm, vd, fpst);
+    neon_store_reg32(vd, a->vd);
+
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(vn);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i32(vd);
+
+    return true;
+}
+
 static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 {
     /*
@@ -2062,6 +2125,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, false, true) \
     MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, true, true)
 
+MAKE_VFM_TRANS_FNS(hp)
 MAKE_VFM_TRANS_FNS(sp)
 MAKE_VFM_TRANS_FNS(dp)
 
-- 
2.20.1


