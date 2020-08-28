Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F20C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1272520776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="del1U37O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1272520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjgU-0001pD-7f
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD7-0003Q6-UE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD1-000669-RQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id y3so66907wrl.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hE3x5UYpTv4DTAsoywo/5Ti5Qf5DuCUIVQT2wDt49Fo=;
 b=del1U37Omwl17tNv4Zn0bmRZ8UNBpyX/1+pc8BdozEL0Nc8Y2YByu/phuHRXeFaSCO
 E+88gJBiUFb4AVRn9h1j1DHIYcFYQpBWshuBN2hKo3HjsJFyGzJ5nHroUx0mw4bJIUR/
 6em0g8PYtCdO3GDrItO1inf7DwViv/uLUmNAd8Ol7+zCmQO8k4RWxVIqAvGlCBbV3KCn
 2n6G9OnFJ65Y/Q2/cw8nFse39hpjfwtXKAIgC4hQGCYRX0iPjY8lQxR6Ma7lTixfREe6
 M+IM2GEWrLkgnB66Z/UxdDcufx8e5tNII6S1Xhm/wnyHIO2gb+inCx6GuSQar20vIkjq
 3tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hE3x5UYpTv4DTAsoywo/5Ti5Qf5DuCUIVQT2wDt49Fo=;
 b=alphyw/gwMq5x1TX9ZFIrJOAbciCpKv9VP+rYV4DiC47UfV2BkqVJxwMEVWhJA84w9
 Ff1KlvtWoSPWf9nDoOJ286evqq/6j6iL2Hsz376qX+W4CpTwl+Q1nryR3F2bQXCzoyPF
 WtUmjm1/fI+RMOULO919DgSSrD1ZUA3ruRaDd1DOoO0ug8SC/ivTfw6amG548XYIpOzo
 1EwN6L6tP4rWosJODw0D74TkFYuwjTGJWlFLt6AmU61xkh9uLUYSIUr0tsl2rUyq0qSa
 8NfC468cwjsE14B/Q56q77Iu2ObHoiLg5YjQ6egEXzICma9+D1x4Qnv+xeo8M6hFsr2X
 /zvQ==
X-Gm-Message-State: AOAM532G29s1s1cY8QqP7CLjQ9w37aMwbOXc2Wt4xT92/w6KDf8HLqvy
 ciuwbNfHhZ1gX4KZGUcXwpIXTA==
X-Google-Smtp-Source: ABdhPJyopbOd6OJBrOBEbRXciXOkiwen11dw6O2RBgcIohQBNDTtsyVl3g1VzyYTz2ntiQ6SgsxWiw==
X-Received: by 2002:a5d:6610:: with SMTP id n16mr261588wru.363.1598639682467; 
 Fri, 28 Aug 2020 11:34:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 38/45] target/arm: Implement fp16 for Neon VCVT fixed-point
Date: Fri, 28 Aug 2020 19:33:47 +0100
Message-Id: <20200828183354.27913-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

Implement fp16 for the Neon VCVT insns which convert between
float and fixed-point.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 5 +++++
 target/arm/neon-dp.decode       | 8 +++++++-
 target/arm/vec_helper.c         | 4 ++++
 target/arm/translate-neon.c.inc | 5 +++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 09e0fa052ef..8c98bc40eb3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -628,6 +628,11 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 686f9fbf46a..1e9e8592917 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -254,6 +254,8 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 # We use size=0 for fp32 and size=1 for fp16 to match the 3-same encodings.
 @2reg_vcvt       .... ... . . . 1 ..... .... .... . q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0 shift=%neon_rshift_i5
+@2reg_vcvt_f16   .... ... . . . 11 .... .... .... . q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=1 shift=%neon_rshift_i4
 
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
@@ -370,7 +372,11 @@ VSHLL_U_2sh      1111 001 1 1 . ...... .... 1010 . 0 . 1 .... @2reg_shll_h
 VSHLL_U_2sh      1111 001 1 1 . ...... .... 1010 . 0 . 1 .... @2reg_shll_b
 
 # VCVT fixed<->float conversions
-# TODO: FP16 fixed<->float conversions are opc==0b1100 and 0b1101
+VCVT_SH_2sh      1111 001 0 1 . ...... .... 1100 0 . . 1 .... @2reg_vcvt_f16
+VCVT_UH_2sh      1111 001 1 1 . ...... .... 1100 0 . . 1 .... @2reg_vcvt_f16
+VCVT_HS_2sh      1111 001 0 1 . ...... .... 1101 0 . . 1 .... @2reg_vcvt_f16
+VCVT_HU_2sh      1111 001 1 1 . ...... .... 1101 0 . . 1 .... @2reg_vcvt_f16
+
 VCVT_SF_2sh      1111 001 0 1 . ...... .... 1110 0 . . 1 .... @2reg_vcvt
 VCVT_UF_2sh      1111 001 1 1 . ...... .... 1110 0 . . 1 .... @2reg_vcvt
 VCVT_FS_2sh      1111 001 0 1 . ...... .... 1111 0 . . 1 .... @2reg_vcvt
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 6d83953ee8f..ea401910f37 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1863,5 +1863,9 @@ DO_VCVT_FIXED(gvec_vcvt_sf, helper_vfp_sltos, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_uf, helper_vfp_ultos, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_fs, helper_vfp_tosls_round_to_zero, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_fu, helper_vfp_touls_round_to_zero, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_sh, helper_vfp_shtoh, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_uh, helper_vfp_uhtoh, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_hs, helper_vfp_toshh_round_to_zero, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_hu, helper_vfp_touhh_round_to_zero, uint16_t)
 
 #undef DO_VCVT_FIXED
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 50fcf4159ea..b3b1d46e958 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1657,6 +1657,11 @@ DO_FP_2SH(VCVT_UF, gen_helper_gvec_vcvt_uf)
 DO_FP_2SH(VCVT_FS, gen_helper_gvec_vcvt_fs)
 DO_FP_2SH(VCVT_FU, gen_helper_gvec_vcvt_fu)
 
+DO_FP_2SH(VCVT_SH, gen_helper_gvec_vcvt_sh)
+DO_FP_2SH(VCVT_UH, gen_helper_gvec_vcvt_uh)
+DO_FP_2SH(VCVT_HS, gen_helper_gvec_vcvt_hs)
+DO_FP_2SH(VCVT_HU, gen_helper_gvec_vcvt_hu)
+
 static uint64_t asimd_imm_const(uint32_t imm, int cmode, int op)
 {
     /*
-- 
2.20.1


