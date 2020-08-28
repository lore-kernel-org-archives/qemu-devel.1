Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB7C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6682075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buG9bh10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6682075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjTp-0004n6-Kd
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjDA-0003TN-1x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD7-00066n-M8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id c18so43312wrm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pnesOqSOJA+00ifnyHrnB/Him0ao7vqDMzU/OBSQI8s=;
 b=buG9bh10NrOQkW7WNEn1ra57xo+0mhy8qnB1hdkrPqUm4wef9bM6MAcmYZ0yNWMGai
 WfTt8vOadiRCCxvZLscjJXj1InooWyNQG64cVk6hLY4vGmVgARmjS5Ieq9vfjH4vaXLQ
 jT7eOlPqa5+gMSOuNer9TZ2zb8HuIlOTnBL4qz1+HKg5d/IoziiAv9ZcioJe5NZHfgTF
 TjiwRSEuLN43r+NO9f1HeF7jIUfbk081GGC4KLfWtn8F2i4StX0tO+z8AKVNyYK6Xhd3
 0gmiQIuhx9vyw0zk9w0TlrXqbiueB2SxqkSJsiMiJgZlZNpthC6MEAyX4s7eVExgfXth
 VoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pnesOqSOJA+00ifnyHrnB/Him0ao7vqDMzU/OBSQI8s=;
 b=DqarCdSayrXiQWbH1pi27lzoTurdeGTk6p29jwXy2ce4p8r+xEskmWf6P1NPvjTFj0
 oXnHIqXP0sDSflH0qofyyDbKyVefRz5K/d+IL8NWrasNXS4zrBZMC4KKO8KUmJb3+8+c
 DYuNxWkphvycmTySByNnLWUZExs5ovvp2boWfgbidwZkMlLM4JcQblCxruXTvgsZV/h9
 Nw8dw4cYAzvf01uBr1lXSb/ktpBZsZu31E51KVLFpsZcAjefA8Whg04mqZiKpOlFcE42
 ekeEB8cSCgVc56xRQK5x8oKS8/6SbZmsOEQIFOEjaVdFQxOqNaPIwRun4IheA66GpP9F
 +nQw==
X-Gm-Message-State: AOAM533Cyo8/VCHFRuG8aYm5AN23vpQuwV60E6dKgPX1Fq8OWigG+S3T
 up3FKw8VGWlAKqBRmS0z8xgo1Q==
X-Google-Smtp-Source: ABdhPJxK6mNk+CMFdDBXUwFA9QBWk9L5mCsvPuxd5XNdLoN2Kl7lv7k65KqD3mHaAkd+i8ZmeLgWDg==
X-Received: by 2002:adf:9ed1:: with SMTP id b17mr279646wrf.140.1598639685875; 
 Fri, 28 Aug 2020 11:34:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 41/45] target/arm: Implement fp16 for Neon VRINTX
Date: Fri, 28 Aug 2020 19:33:50 +0100
Message-Id: <20200828183354.27913-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Convert the Neon VRINTX insn to use gvec, and use this to implement
fp16 support for it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  3 +++
 target/arm/vec_helper.c         |  3 +++
 target/arm/translate-neon.c.inc | 45 +++------------------------------
 3 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 83f7804dfe9..cbdbf824d8d 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -640,6 +640,9 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vrintx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 7ddf1e791c9..20f153b47a1 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -750,6 +750,9 @@ DO_2OP(gvec_frsqrte_h, helper_rsqrte_f16, float16)
 DO_2OP(gvec_frsqrte_s, helper_rsqrte_f32, float32)
 DO_2OP(gvec_frsqrte_d, helper_rsqrte_f64, float64)
 
+DO_2OP(gvec_vrintx_h, float16_round_to_int, float16)
+DO_2OP(gvec_vrintx_s, float32_round_to_int, float32)
+
 DO_2OP(gvec_sitos, helper_vfp_sitos, int32_t)
 DO_2OP(gvec_uitos, helper_vfp_uitos, uint32_t)
 DO_2OP(gvec_tosizs, helper_vfp_tosizs, float32)
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index fe9dc9597bd..e728415c276 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3679,47 +3679,6 @@ static bool trans_VQNEG(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, fn[a->size]);
 }
 
-static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
-                        NeonGenOneSingleOpFn *fn)
-{
-    int pass;
-    TCGv_ptr fpst;
-
-    /* Handle a 2-reg-misc operation by iterating 32 bits at a time */
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if (a->size != 2) {
-        /* TODO: FP16 will be the size == 1 case */
-        return false;
-    }
-
-    if ((a->vd | a->vm) & a->q) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    fpst = fpstatus_ptr(FPST_STD);
-    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
-        fn(tmp, tmp, fpst);
-        neon_store_reg(a->vd, pass, tmp);
-    }
-    tcg_temp_free_ptr(fpst);
-
-    return true;
-}
-
 #define DO_2MISC_FP_VEC(INSN, HFUNC, SFUNC)                             \
     static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
                            uint32_t rm_ofs,                             \
@@ -3756,12 +3715,14 @@ DO_2MISC_FP_VEC(VCVT_FU, gen_helper_gvec_ustoh, gen_helper_gvec_uitos)
 DO_2MISC_FP_VEC(VCVT_SF, gen_helper_gvec_tosszh, gen_helper_gvec_tosizs)
 DO_2MISC_FP_VEC(VCVT_UF, gen_helper_gvec_touszh, gen_helper_gvec_touizs)
 
+DO_2MISC_FP_VEC(VRINTX_impl, gen_helper_gvec_vrintx_h, gen_helper_gvec_vrintx_s)
+
 static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
 {
     if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
         return false;
     }
-    return do_2misc_fp(s, a, gen_helper_rints_exact);
+    return trans_VRINTX_impl(s, a);
 }
 
 #define DO_VEC_RMODE(INSN, RMODE, OP)                                   \
-- 
2.20.1


