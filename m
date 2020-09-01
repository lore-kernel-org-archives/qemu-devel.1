Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4332AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5DB205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpRDTMR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5DB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8It-0005hy-77
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD846-0000tE-Rs
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD844-0006JA-SZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id u18so1543721wmc.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5z9TFgNWgbVG/WM8ku8UCc0MDNs1S/TF2DWgUn0oBUg=;
 b=UpRDTMR3HH66SDtjz96UV4BLX6JFLQ9k2jaEt4ygmlZGLKbONUja57pfJ+Zh1BR2Br
 WXYy3o6SsVsc0agRULGExXEZ94SN8gn9Q1En61/uOWo35jc9ytFEhFBXrnFaxPyayOxw
 Na+SvMBOB731R8ErcawusDvAfZ3OETWfWQLf9TE/R8qnDqBZs/6HFMazy0KZ/HQ0NwG3
 M8SikMDcHwhf1lEQbgVopwwToZjbNEgI4GecS+ghqYk5oJR0LUvKbJ9OrpVw9+Lx7S2M
 7V6zTLRV/c8zR0RpchJt91yoNFzcDG4mx5f7DHboqzhAvx1n1WdKTu3IRpi6RxnKZtHx
 ESeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5z9TFgNWgbVG/WM8ku8UCc0MDNs1S/TF2DWgUn0oBUg=;
 b=J9YATWKg41MxdPSfxjUFnnFoXqv7G1v5AcIxE2C63+FWQlvGMUU3/DLABPeAX8SXAV
 8Wdwf68ViiEXCOtRvdrTOHLDP9ybWGSkCL7a7Tu28kDcNnVAAPOOXgWNnLqr505uTSnd
 Nv/fgTrLVcCrfrmFGVvBRKAg3nmAOBwqNrcqcCyU0te7pGUIAig5Zc3wkN8HfcITEukW
 4K5PNDZvwGHsjVR14RzAKr1mZ+0PGLXoDymnTbszicYOJ+02X/NQStBoeIsSnoRRxOqO
 uWs32EuqOGuyhn2djY3iobcFUOy4LFo3xEHrU7kJMnNXFtGu5Ul6QXpRygVF6ZU3Jh/Y
 OViA==
X-Gm-Message-State: AOAM532QlCR5vPhWHjMRDCxgbBOlFZbqQ/jdKya53amrTqxYcHvpzfUC
 9OOJosTU3WngwoeoVjyODspxJj4hscCEZiZs
X-Google-Smtp-Source: ABdhPJxOx2jDXGOYhP/YWNd5fdha+bQ1lMgQGol9eDMKTc05yCQPR8CjhhJjbNsix1uKTZorkEUQvw==
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr2288877wme.139.1598973555243; 
 Tue, 01 Sep 2020 08:19:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/47] target/arm: Implement fp16 for Neon VRINTX
Date: Tue,  1 Sep 2020 16:18:16 +0100
Message-Id: <20200901151823.29785-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-42-peter.maydell@linaro.org
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
index 77a85d468fb..5726afe4d72 100644
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
@@ -3758,12 +3717,14 @@ DO_2MISC_FP_VEC(VCVT_FU, gen_helper_gvec_ustoh, gen_helper_gvec_uitos)
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


