Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A558C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF2B206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roHs0q+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF2B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8c8-0005kv-Vf
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD843-0000jz-HH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD841-0006IY-In
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id b79so1547580wmb.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=b8e0Hf1syKpL4Xom2hVGpUNo2h9MsahshvEPebIE9SA=;
 b=roHs0q+Wqm8j+gu3pJFkyV0tFqAq2IXDWWxKvpwxxJAjlKy3yU6XQLfLMGmkO6DNVZ
 eqn5+N+jGM1fcZkmnMf3F7rE03q1CB8NyZHjIRA+kf+nw3rMHMDuu34pxsSC748FaXqH
 wz9dokPLQB/ZWESnAzuQPSep999Ow4e6uKxnoiDaoU8eDrXhCdfB6tHl4OyLFiY8Beec
 auIPiLVmFARHPHG0hxOOO0VYtHRsvldvHQxLq5uXT6yOFIc6qwAm5IqxLh8JSadKauwF
 7W/k1DMr6AhYNxCO3LqulLb6ZCb06eD+qf4TbP+dVvIMqUjiFhuNkNbzpsDYj+nipj15
 Lxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b8e0Hf1syKpL4Xom2hVGpUNo2h9MsahshvEPebIE9SA=;
 b=qwIXz4FnGtRpvdnnO/6smQSb6PhznbPjd1v127eYV9IB/wMd86giK9dZC434cIou7C
 +YEcE7u4V+wVFgj+2C+g+HXfD3F42+XLEslcjFmbhQz+whvt/hrEauMzGURz4KeTY4KZ
 haYQsZPF2EeJn/b5cxTlCmhNbGYjiabWHABI+/GOe4Pbe2pZX64O5Q9FU5DXHlhiKV8e
 bZIWZRjSiv+p86PLe4VTEDAjos/gsgT5Ply3jDLDxSwDPFmoRwAUqng/u4zqI3adRara
 GFkhWxyvs4Aw6Bx/jBwrxNNAx0/xkNxngVlZIzU1MZYEs2xGUC+0r62WEaE3gJQXrmwB
 CJAw==
X-Gm-Message-State: AOAM532O5YLI6NukllFsrUZJOc49jOjOBFjlhx/tpTQUbKgrJGLy13ki
 M7OtLvMMkEKSAYe/ugUa1jtZpAj0iCEGsa6l
X-Google-Smtp-Source: ABdhPJw78Wlozt8znQ2kgioUfwnNz/YeLHeJW6LPMYH71gOXaBS3mduzWZGygRKLo5aFar1VRaWSwQ==
X-Received: by 2002:a1c:2983:: with SMTP id p125mr2250402wmp.21.1598973551910; 
 Tue, 01 Sep 2020 08:19:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/47] target/arm: Implement fp16 for Neon VCVT fixed-point
Date: Tue,  1 Sep 2020 16:18:13 +0100
Message-Id: <20200901151823.29785-38-peter.maydell@linaro.org>
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

Implement fp16 for the Neon VCVT insns which convert between
float and fixed-point.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-39-peter.maydell@linaro.org
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
index 7e4324c5397..2f982bb7260 100644
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


