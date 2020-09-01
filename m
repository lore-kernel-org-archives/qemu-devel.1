Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77C7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D0B206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGBY0jWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D0B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD87l-00007X-LY
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83q-00006g-1J
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83o-0006Ff-2B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id e16so1996257wrm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hnPrlMASIerhAiEslXU9iTJZuDKi14WPZTfnr6gqnUc=;
 b=fGBY0jWY8ei1tv1asu0P004efrECJO8ACc8YBjQDd9ddmzY4opG5yQ0nsr2LqotRS8
 gC9p3QbAVNqY9GORQoKVtH/SaruLa7Y3pYqF2zTm8DRL4Gt1diciSv35np2ApBeU2y60
 2ql2M+gMNGoJ9CVwut8JjmtWBve/l6TesaszxSsIFKdK8sk7ei8xtmwl81YyYdHm4R8H
 M68nItnj17wtcWjIsOvF5ph4I5j1vOo2voghxJS/HiLJ92VvTC5+1+lrw6aS++Iv1Sjx
 jYgrZF/2XjH9aZL4T6CZomB8TyFsHO6gk1p3T6DUzJ0DhnrgycujoiIIBJellPsJYEad
 SJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hnPrlMASIerhAiEslXU9iTJZuDKi14WPZTfnr6gqnUc=;
 b=BwzghFeFPgsNfRpzQU/yJ0hb8u6rt2bqopst3VH9iiNhuXGZShUKbba1xHcH/JEVF5
 MjYfSecTHc+ktSmx8w3IEBcKwbOS8o1LgbXaHGxSIfaZUUhcXz+QbTiSRbgTLb6QLxan
 USQn7mK90394+bIQwmNUs92ZMOv6Gf+giNA264T6dZxpU7toFIchrDp1CBNUWQBuSVWa
 MfxL53tAE1asurGZaNeoCGpTx8VxhYeAJQZTxi+By1O+/yp/ES7IUckPy87gavlgARWW
 hFDAcWx2gFOdoSx+RcTntH21JQyJW1ao5DyxPgEau2DDsLJTKtn6EPU9Fy+Ym2uxA7W7
 O8Mw==
X-Gm-Message-State: AOAM532KwZOY4e4IW7aUNfq95b2QbOmpP8kGZXaMoIkRS/krNaJZVrwd
 +zKm62SJOGw0Csi+g11OuzuoaF/x+EUE+uqk
X-Google-Smtp-Source: ABdhPJw5smVG18kX5hnLIEbo5jj/sBBm451eEhvBdf9lq/Df7oakQ9hESv2RRLdJaWFQB2LTO0Qapg==
X-Received: by 2002:adf:8187:: with SMTP id 7mr2487274wra.266.1598973538452;
 Tue, 01 Sep 2020 08:18:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/47] target/arm: Implement fp16 for VCEQ, VCGE,
 VCGT comparisons
Date: Tue,  1 Sep 2020 16:18:01 +0100
Message-Id: <20200901151823.29785-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Convert the Neon floating-point vector comparison ops VCEQ,
VCGE and VCGT over to using a gvec helper and use this to
implement the fp16 case.

(We put the float16_ceq() etc functions above the DO_2OP()
macro definition because later when we convert the
compare-against-zero instructions we'll want their
definitions to be visible at that point in the source file.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-27-peter.maydell@linaro.org
---
 target/arm/helper.h             |  9 +++++++
 target/arm/vec_helper.c         | 44 +++++++++++++++++++++++++++++++++
 target/arm/translate-neon.c.inc |  6 ++---
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index aa1ac75571f..a05a0d1a427 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -632,6 +632,15 @@ DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 988d5784e83..f60968f4997 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -656,6 +656,41 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+/*
+ * Floating point comparisons producing an integer result (all 1s or all 0s).
+ * Note that EQ doesn't signal InvalidOp for QNaNs but GE and GT do.
+ * Softfloat routines return 0/1, which we convert to the 0/-1 Neon requires.
+ */
+static uint16_t float16_ceq(float16 op1, float16 op2, float_status *stat)
+{
+    return -float16_eq_quiet(op1, op2, stat);
+}
+
+static uint32_t float32_ceq(float32 op1, float32 op2, float_status *stat)
+{
+    return -float32_eq_quiet(op1, op2, stat);
+}
+
+static uint16_t float16_cge(float16 op1, float16 op2, float_status *stat)
+{
+    return -float16_le(op2, op1, stat);
+}
+
+static uint32_t float32_cge(float32 op1, float32 op2, float_status *stat)
+{
+    return -float32_le(op2, op1, stat);
+}
+
+static uint16_t float16_cgt(float16 op1, float16 op2, float_status *stat)
+{
+    return -float16_lt(op2, op1, stat);
+}
+
+static uint32_t float32_cgt(float32 op1, float32 op2, float_status *stat)
+{
+    return -float32_lt(op2, op1, stat);
+}
+
 #define DO_2OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)  \
 {                                                                 \
@@ -747,6 +782,15 @@ DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
 DO_3OP(gvec_fabd_h, float16_abd, float16)
 DO_3OP(gvec_fabd_s, float32_abd, float32)
 
+DO_3OP(gvec_fceq_h, float16_ceq, float16)
+DO_3OP(gvec_fceq_s, float32_ceq, float32)
+
+DO_3OP(gvec_fcge_h, float16_cge, float16)
+DO_3OP(gvec_fcge_s, float32_cge, float32)
+
+DO_3OP(gvec_fcgt_h, float16_cgt, float16)
+DO_3OP(gvec_fcgt_s, float32_cgt, float32)
+
 #ifdef TARGET_AARCH64
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 45cea6ca766..b2924ac1cdd 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1112,6 +1112,9 @@ DO_3S_FP_GVEC(VADD, gen_helper_gvec_fadd_s, gen_helper_gvec_fadd_h)
 DO_3S_FP_GVEC(VSUB, gen_helper_gvec_fsub_s, gen_helper_gvec_fsub_h)
 DO_3S_FP_GVEC(VABD, gen_helper_gvec_fabd_s, gen_helper_gvec_fabd_h)
 DO_3S_FP_GVEC(VMUL, gen_helper_gvec_fmul_s, gen_helper_gvec_fmul_h)
+DO_3S_FP_GVEC(VCEQ, gen_helper_gvec_fceq_s, gen_helper_gvec_fceq_h)
+DO_3S_FP_GVEC(VCGE, gen_helper_gvec_fcge_s, gen_helper_gvec_fcge_h)
+DO_3S_FP_GVEC(VCGT, gen_helper_gvec_fcgt_s, gen_helper_gvec_fcgt_h)
 
 /*
  * For all the functions using this macro, size == 1 means fp16,
@@ -1127,9 +1130,6 @@ DO_3S_FP_GVEC(VMUL, gen_helper_gvec_fmul_s, gen_helper_gvec_fmul_h)
         return do_3same_fp(s, a, FUNC, READS_VD);                   \
     }
 
-DO_3S_FP(VCEQ, gen_helper_neon_ceq_f32, false)
-DO_3S_FP(VCGE, gen_helper_neon_cge_f32, false)
-DO_3S_FP(VCGT, gen_helper_neon_cgt_f32, false)
 DO_3S_FP(VACGE, gen_helper_neon_acge_f32, false)
 DO_3S_FP(VACGT, gen_helper_neon_acgt_f32, false)
 DO_3S_FP(VMAX, gen_helper_vfp_maxs, false)
-- 
2.20.1


