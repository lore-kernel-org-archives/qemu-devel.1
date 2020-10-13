Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0AFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC8F20870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F646NddO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC8F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHfh-00034R-Nl
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSHed-00027E-Me
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:35:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSHeZ-0003rK-Ti
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:35:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so14784370wrl.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rxq0YUJRRCjXNE+EXdh2OUkpg0FaXGP4WAIeZPZ2iAI=;
 b=F646NddOxB2034Gv1d9nAVWy2VH3kJTfA90etQ/sigizEJpekMDX2c34J3jpykfAqH
 i+5JHbT2uLaUt8XZxbKoz2G5veZtulkfofEvHJKMUEvFtXsziUOjbn1w2L0REJBzmu7b
 qQ4VA17NtrHE4ZApPoD5lIBtcqqfeWUjLG/jnixSMBWQw4GBUtjOHtR+qJ4XhI1nugbS
 dVXjgVUg4UYOgghnWtXw9qOZKzJ98UzpGZeqiq7GmA4O3vrcYfpLn88OHmcI7XhDtXHL
 OvqW++VsTDBrAuOmIGGTNqjMhliAQopGnWGYl7AO+jI2+A60NZl3+t+6nKLyKSex5oiK
 BJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rxq0YUJRRCjXNE+EXdh2OUkpg0FaXGP4WAIeZPZ2iAI=;
 b=uEi4HY4385ChTVJMlAIKVDl3LwyEJD7NQ5j6awdZfCKgNG+2zccf+BgInfgpciEI0w
 sdNivf2vG/GlOO7voGnqoiuFkLbEOSMjf0EbFUS78/tlMZ1ahWI/41QPwQkkmnPcOtNH
 RyczFSnMR4pfjYjV7245equYdny2X+xNS6SlFQ5iMV54KQtXj9BYhqmLnMfPeVJk6eNn
 YZ23t7mzQsc8oYNl9IbiyuphlnbjOBj9QnfoXR0Rabpb6DfEDOLLmVpQIC1+kFYtvlgm
 i2rFQy1WMB4wZZBEbpU5SufVdj9hhAQMNWE3EOusW4ZCBlOOe2Y8tzcSyDnyZWwSGdBW
 QZIg==
X-Gm-Message-State: AOAM532OnIrXv25pLpmDgOHHB1yILkQQi4B+F+f0W1/TVdvEOoC15urk
 0MJlrEwTe81XdXH1sIaxCzyXtw==
X-Google-Smtp-Source: ABdhPJweQo/mbqBPAoqEnCiFfSYl3Vx1poWF1bil2bNocvGSew0FivgWzOh5DJbgIGlDNsWWE4apLg==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr13930722wrq.279.1602585334076; 
 Tue, 13 Oct 2020 03:35:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x6sm27724713wmb.17.2020.10.13.03.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:35:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: AArch32 VCVT fixed-point to float is always
 round-to-nearest
Date: Tue, 13 Oct 2020 11:35:32 +0100
Message-Id: <20201013103532.13391-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
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


