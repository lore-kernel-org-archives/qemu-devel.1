Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5CC22249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPXLm48Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5CC22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu4Y-00011w-6o
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0b-0004Ab-2e
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0Y-0003qa-KR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id c16so2512821wmd.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hW/WffD7mpSuczr6jlz/cmphSo0bxHD9q1xWU7+BhZQ=;
 b=xPXLm48ZYbt4HC4VSmZz+LNnqFa5dakGiNH4VPmRXD0Zvyu9uYe/Tx8GalckW56+S+
 tYTOG76sXKD+Xv7nlvyEclil0FEA9NL8b55cHTvVkb200YArW+8NmBfxFMG9imKXXp4S
 WZlMiMsF+oA77zXvt6oS6Q966mECvJQz+8RHgRvpj/QnJmBmN1KVMOIyvuPZ+hwZ+hbG
 5bWwXYEqZWgLuVK88amys5KFGj6EqDiYU31Uic8FIb9+BWMuOKSUE+7BHfBfOKXiHGWS
 poawm/R3VdNzy1cnWp5ZlihYSCYwKwa+khH6shmzddpc6CHZFX8kQtjwlxRGtcJ8u2VC
 8D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hW/WffD7mpSuczr6jlz/cmphSo0bxHD9q1xWU7+BhZQ=;
 b=NiGi96OjahCvRE3rmMgVuLKqErrq+su70ZX7ZCnBLMf3mWDnLtx9m1fCOLwYvb/fJl
 mh1nyGQaceZqRnCTlYZNYQcxeErUmoW6LSOsWjTFuCvomDcr7vMLQxQXudOkzA9NHmMi
 d/BE/aAQKOP2Vw/svDalC50ZqNKXoNrm/kJN5PrUUm+vsAblvczrInO165MDCZEA6Qoq
 sSZzxyHY7YLFNzKJ9uQNYZkTxQYKDqnz6qMGjQqHX5OpXu1NWkAcseMpI/BQY1wfOjCz
 9VUiI3the8IKnlXbmrFFrn8fMFEmZe1Xm48MqosfiyEwwRvhVMFw4xZbNqdvo/JJ197v
 osBw==
X-Gm-Message-State: AOAM533jf3FltCSEMmoAWFWS+t3qA094bb1MtWlz2FvD52LZwhbR5ebb
 bLjROLQQP1iUj+9EcxRUb1cNOehor3CWfw==
X-Google-Smtp-Source: ABdhPJw1AUZpeYO3CaeOq9AJ69ixoaj3dwfwKyI0M2R6zJCWT91tdhsrc9kzLvyiFCPQoRHgeosb0Q==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr3564224wmh.156.1603209424179; 
 Tue, 20 Oct 2020 08:57:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] target/arm: AArch32 VCVT fixed-point to float is always
 round-to-nearest
Date: Tue, 20 Oct 2020 16:56:17 +0100
Message-Id: <20201020155656.8045-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
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

For AArch32, unlike the VCVT of integer to float, which honours the
rounding mode specified by the FPSCR, VCVT of fixed-point to float is
always round-to-nearest. (AArch64 fixed-point-to-float conversions
always honour the FPCR rounding mode.)

Implement this by providing _round_to_nearest versions of the
relevant helpers which set the rounding mode temporarily when making
the call to the underlying softfloat function.

We only need to change the VFP VCVT instructions, because the
standard- FPSCR value used by the Neon VCVT is always set to
round-to-nearest, so we don't need to do the extra work of saving
and restoring the rounding mode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201013103532.13391-1-peter.maydell@linaro.org
---
 target/arm/helper.h            | 13 +++++++++++++
 target/arm/vfp_helper.c        | 23 ++++++++++++++++++++++-
 target/arm/translate-vfp.c.inc | 24 ++++++++++++------------
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8defd7c8019..774d2cddb5c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -213,6 +213,19 @@ DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
 DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
 DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
 
+DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, ptr)
+
 DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 
 DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 5666393ef79..abfdb6a8e23 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -393,12 +393,32 @@ float32 VFP_HELPER(fcvts, d)(float64 x, CPUARMState *env)
     return float64_to_float32(x, &env->vfp.fp_status);
 }
 
-/* VFP3 fixed point conversion.  */
+/*
+ * VFP3 fixed point conversion. The AArch32 versions of fix-to-float
+ * must always round-to-nearest; the AArch64 ones honour the FPSCR
+ * rounding mode. (For AArch32 Neon the standard-FPSCR is set to
+ * round-to-nearest so either helper will work.) AArch32 float-to-fix
+ * must round-to-zero.
+ */
 #define VFP_CONV_FIX_FLOAT(name, p, fsz, ftype, isz, itype)            \
 ftype HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift,      \
                                      void *fpstp) \
 { return itype##_to_##float##fsz##_scalbn(x, -shift, fpstp); }
 
+#define VFP_CONV_FIX_FLOAT_ROUND(name, p, fsz, ftype, isz, itype)      \
+    ftype HELPER(vfp_##name##to##p##_round_to_nearest)(uint##isz##_t  x, \
+                                                     uint32_t shift,   \
+                                                     void *fpstp)      \
+    {                                                                  \
+        ftype ret;                                                     \
+        float_status *fpst = fpstp;                                    \
+        FloatRoundMode oldmode = fpst->float_rounding_mode;            \
+        fpst->float_rounding_mode = float_round_nearest_even;          \
+        ret = itype##_to_##float##fsz##_scalbn(x, -shift, fpstp);      \
+        fpst->float_rounding_mode = oldmode;                           \
+        return ret;                                                    \
+    }
+
 #define VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype, ROUND, suff) \
 uint##isz##_t HELPER(vfp_to##name##p##suff)(ftype x, uint32_t shift,      \
                                             void *fpst)                   \
@@ -412,6 +432,7 @@ uint##isz##_t HELPER(vfp_to##name##p##suff)(ftype x, uint32_t shift,      \
 
 #define VFP_CONV_FIX(name, p, fsz, ftype, isz, itype)            \
 VFP_CONV_FIX_FLOAT(name, p, fsz, ftype, isz, itype)              \
+VFP_CONV_FIX_FLOAT_ROUND(name, p, fsz, ftype, isz, itype)        \
 VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype,        \
                          float_round_to_zero, _round_to_zero)    \
 VFP_CONV_FLOAT_FIX_ROUND(name, p, fsz, ftype, isz, itype,        \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28e0dba5f14..9b11b81f80d 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3141,16 +3141,16 @@ static bool trans_VCVT_fix_hp(DisasContext *s, arg_VCVT_fix_sp *a)
     /* Switch on op:U:sx bits */
     switch (a->opc) {
     case 0:
-        gen_helper_vfp_shtoh(vd, vd, shift, fpst);
+        gen_helper_vfp_shtoh_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 1:
-        gen_helper_vfp_sltoh(vd, vd, shift, fpst);
+        gen_helper_vfp_sltoh_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 2:
-        gen_helper_vfp_uhtoh(vd, vd, shift, fpst);
+        gen_helper_vfp_uhtoh_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 3:
-        gen_helper_vfp_ultoh(vd, vd, shift, fpst);
+        gen_helper_vfp_ultoh_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 4:
         gen_helper_vfp_toshh_round_to_zero(vd, vd, shift, fpst);
@@ -3200,16 +3200,16 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     /* Switch on op:U:sx bits */
     switch (a->opc) {
     case 0:
-        gen_helper_vfp_shtos(vd, vd, shift, fpst);
+        gen_helper_vfp_shtos_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 1:
-        gen_helper_vfp_sltos(vd, vd, shift, fpst);
+        gen_helper_vfp_sltos_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 2:
-        gen_helper_vfp_uhtos(vd, vd, shift, fpst);
+        gen_helper_vfp_uhtos_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 3:
-        gen_helper_vfp_ultos(vd, vd, shift, fpst);
+        gen_helper_vfp_ultos_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 4:
         gen_helper_vfp_toshs_round_to_zero(vd, vd, shift, fpst);
@@ -3265,16 +3265,16 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     /* Switch on op:U:sx bits */
     switch (a->opc) {
     case 0:
-        gen_helper_vfp_shtod(vd, vd, shift, fpst);
+        gen_helper_vfp_shtod_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 1:
-        gen_helper_vfp_sltod(vd, vd, shift, fpst);
+        gen_helper_vfp_sltod_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 2:
-        gen_helper_vfp_uhtod(vd, vd, shift, fpst);
+        gen_helper_vfp_uhtod_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 3:
-        gen_helper_vfp_ultod(vd, vd, shift, fpst);
+        gen_helper_vfp_ultod_round_to_nearest(vd, vd, shift, fpst);
         break;
     case 4:
         gen_helper_vfp_toshd_round_to_zero(vd, vd, shift, fpst);
-- 
2.20.1


