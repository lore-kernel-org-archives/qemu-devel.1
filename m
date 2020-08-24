Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0EBC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A212071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOTkOiLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A212071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADbR-0004c3-RR
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTo-0008HM-HT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTl-0002gl-Kz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id w13so8586681wrk.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BJdw8FfCZJdSR7ShLg04kNyoxpE7jwtftdkn3y8quQ0=;
 b=VOTkOiLKDg60wFoBOY1Mf4lBchmikWt9cipAcoM4/dzG+lBAU5bHFZKOk/ZkpJCi3R
 Jn6ej0B7/T3uKt73UDaLqeKFq0tYiZX71Qk9eZkLH68lENE++QMhJeacOCk0S9s34vg8
 qhaRjjclTJb00LGSQdCkqWf0qscyEwLa85GTcvbAIx/C7mLI/mEoJgNGQrwnISHXXvpI
 3NX5MmIWj0phEiIiwDLlAT8CmfJUeBQUq85702OqNrT0g+IaF7wrVFTC3DbaaSfV4GyH
 OOUHWhiDDfYpY+Po+C/yxlsrcQL297Kb4EkZWV1QXwnQzeRDTXCvQMgueriu24isL5NH
 bT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BJdw8FfCZJdSR7ShLg04kNyoxpE7jwtftdkn3y8quQ0=;
 b=ul3wFyY034KJyGT5nnPB3wT4YaSVpNVSY3vaX0BhTzljinUzCAOsk/7WzZluUKM7Oj
 ZLUY1M4S5nI1eb8cy37ZWbrzzUFvmGWuiBpcbPPUPAQH3XVBZMupNm+r8A/BJC3Btqk9
 zfGvU4OVImKn2PJ53i+gGYvZAPisgh0oyN8MM22hRVgQO4JJRbsQcBc/2WnrOdPWBPKY
 /gW7bYSRFlRDXftTAwKaCN5suBA3O6SdteCtNh+4Mawtdfd0tK+gmRJTZ31O3bUOyHdM
 ViYkXRVt7/atmLTt5jsNtrcMiOM7O/t5z+BfElNU/ngbzT3qPL7kstO5124YnX45f33A
 nySg==
X-Gm-Message-State: AOAM530xyz8TqkPUdhIwnu/fItW9DvvUeFb/kLHGDcIj58hWq3ypl6EV
 TsWKRNXMLY6yoj6zOZdOZcwlfg==
X-Google-Smtp-Source: ABdhPJwhDEHVky85hBzxP15N35xJA+O1s9D5CtE5JNz7cniRuE+VyEOFEK8i33Zqgezmv3FDKpaMAA==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr6016716wrw.311.1598279384339; 
 Mon, 24 Aug 2020 07:29:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/22] target/arm: Macroify uses of do_vfp_2op_sp() and
 do_vfp_2op_dp()
Date: Mon, 24 Aug 2020 15:29:19 +0100
Message-Id: <20200824142934.20850-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
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

Macroify the uses of do_vfp_2op_sp() and do_vfp_2op_dp(); this will
make it easier to add the halfprec support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.c.inc | 49 ++++++++++------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index b5eb9d66b3d..f891d860bb9 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2234,55 +2234,34 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     return true;
 }
 
-static bool trans_VMOV_reg_sp(DisasContext *s, arg_VMOV_reg_sp *a)
-{
-    return do_vfp_2op_sp(s, tcg_gen_mov_i32, a->vd, a->vm);
-}
+#define DO_VFP_2OP(INSN, PREC, FN)                              \
+    static bool trans_##INSN##_##PREC(DisasContext *s,          \
+                                      arg_##INSN##_##PREC *a)   \
+    {                                                           \
+        return do_vfp_2op_##PREC(s, FN, a->vd, a->vm);          \
+    }
 
-static bool trans_VMOV_reg_dp(DisasContext *s, arg_VMOV_reg_dp *a)
-{
-    return do_vfp_2op_dp(s, tcg_gen_mov_i64, a->vd, a->vm);
-}
+DO_VFP_2OP(VMOV_reg, sp, tcg_gen_mov_i32)
+DO_VFP_2OP(VMOV_reg, dp, tcg_gen_mov_i64)
 
-static bool trans_VABS_sp(DisasContext *s, arg_VABS_sp *a)
-{
-    return do_vfp_2op_sp(s, gen_helper_vfp_abss, a->vd, a->vm);
-}
+DO_VFP_2OP(VABS, sp, gen_helper_vfp_abss)
+DO_VFP_2OP(VABS, dp, gen_helper_vfp_absd)
 
-static bool trans_VABS_dp(DisasContext *s, arg_VABS_dp *a)
-{
-    return do_vfp_2op_dp(s, gen_helper_vfp_absd, a->vd, a->vm);
-}
-
-static bool trans_VNEG_sp(DisasContext *s, arg_VNEG_sp *a)
-{
-    return do_vfp_2op_sp(s, gen_helper_vfp_negs, a->vd, a->vm);
-}
-
-static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
-{
-    return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
-}
+DO_VFP_2OP(VNEG, sp, gen_helper_vfp_negs)
+DO_VFP_2OP(VNEG, dp, gen_helper_vfp_negd)
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
     gen_helper_vfp_sqrts(vd, vm, cpu_env);
 }
 
-static bool trans_VSQRT_sp(DisasContext *s, arg_VSQRT_sp *a)
-{
-    return do_vfp_2op_sp(s, gen_VSQRT_sp, a->vd, a->vm);
-}
-
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
     gen_helper_vfp_sqrtd(vd, vm, cpu_env);
 }
 
-static bool trans_VSQRT_dp(DisasContext *s, arg_VSQRT_dp *a)
-{
-    return do_vfp_2op_dp(s, gen_VSQRT_dp, a->vd, a->vm);
-}
+DO_VFP_2OP(VSQRT, sp, gen_VSQRT_sp)
+DO_VFP_2OP(VSQRT, dp, gen_VSQRT_dp)
 
 static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
 {
-- 
2.20.1


