Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E939C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BDE205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAhDzBaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BDE205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADXS-0005pA-97
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTs-0008Sj-T1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTq-0002iY-Tr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id s20so3511520wmj.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ns18dr1TbvMInuyF6XsP9cAv2g8MfPEdo1sa6I2VYXQ=;
 b=DAhDzBaAB97/DphOstN0z5yRydSyUtL0benuls/OFabBeKPbpca5FTRYz3o+gXOyKa
 RrRsqOt2X2oTECiqnzE3g4qDGfGV2RK/M33reOWu097XTGcIsno3zJTM89T+IaRCk5Va
 amBWF5+OqkzEkkqxMI/xaVBpePnUXCqTG9wiUTTqbvzH7imaBGahM6vLBaKnBWbhW344
 JdEMxolO/QeY+1GtBU+kSrZCVlxXqWP7ggZMyBgJHoo64TSTPOjX8e2ew5YAH/lsdl+e
 ZSTDSDk4hb8ckgaXi8qWQ/l0ULSqhW+PTbT5lbFEjeY2SzakbVadrgjf2dr/hVJJHohg
 vhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ns18dr1TbvMInuyF6XsP9cAv2g8MfPEdo1sa6I2VYXQ=;
 b=uK8cT53NsJQBcbHJ+fqN2pYM9ZfhIQkxR87aU7/PezybeoAG+qOpen1K/aZd2HTZQd
 0CEimBaakg7gD6xWraRYI+qYyVEkL0q4/knaThdNOFTxmJ516BBWG1TAXYGGf2OBLJq0
 iyKT4Fn/4alNfrgvRrz01aau2DVwct17g+llyGs+u4G0wLVtEgJdkDQHTkySPl/YboGY
 qQXUp1wrt5g/ZFNPc+cbYKC4u7qXRPTXUgql1QM9DIfsWpjzYPpNvzUe7Ou1+PZndj0u
 PfNzlr+OtPpST8cwdysZb49Pg2otsZfCyI0drcVuabflyEcyzHoPIY40IT5W8kUd2g9r
 bRrA==
X-Gm-Message-State: AOAM530IU+vNlpSI36J5j5exnDS/dAPVkgrBJP855VvThspcuq3nMOCG
 tSQMHLKVgQA2jh4bBIPtXuvCsQ==
X-Google-Smtp-Source: ABdhPJwfFIXJSbXaeSN524Z+aDL9pULMLbTJbRZvV3FtEOdMVJ80Ut+rfgODduVybZPzSE5McJXBnA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr5786304wmc.179.1598279389443; 
 Mon, 24 Aug 2020 07:29:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/22] target/arm: Implement VFP fp16 VCVT between float and
 integer
Date: Mon, 24 Aug 2020 15:29:24 +0100
Message-Id: <20200824142934.20850-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

Implement the fp16 versions of the VFP VCVT instruction forms which
convert between floating point and integer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp.decode          |  4 +++
 target/arm/translate-vfp.c.inc | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 37f96e2d261..642ec039e3c 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -210,6 +210,8 @@ VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 ....        @vfp_dm_ds
 VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 ....        @vfp_dm_sd
 
 # VCVT from integer to floating point: Vm always single; Vd depends on size
+VCVT_int_hp  ---- 1110 1.11 1000 .... 1001 s:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
 VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
@@ -229,6 +231,8 @@ VCVT_fix_dp  ---- 1110 1.11 1.1. .... 1011 .1.0 .... \
              vd=%vd_dp imm=%vm_sp opc=%vcvt_fix_op
 
 # VCVT float to integer (VCVT and VCVTR): Vd always single; Vd depends on size
+VCVT_hp_int  ---- 1110 1.11 110 s:1 .... 1001 rz:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
 VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 59ef4d4fbc3..0140822d183 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2845,6 +2845,35 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     return true;
 }
 
+static bool trans_VCVT_int_hp(DisasContext *s, arg_VCVT_int_sp *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    if (a->s) {
+        /* i32 -> f16 */
+        gen_helper_vfp_sitoh(vm, vm, fpst);
+    } else {
+        /* u32 -> f16 */
+        gen_helper_vfp_uitoh(vm, vm, fpst);
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
 static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
 {
     TCGv_i32 vm;
@@ -3067,6 +3096,42 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     return true;
 }
 
+static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+
+    if (a->s) {
+        if (a->rz) {
+            gen_helper_vfp_tosizh(vm, vm, fpst);
+        } else {
+            gen_helper_vfp_tosih(vm, vm, fpst);
+        }
+    } else {
+        if (a->rz) {
+            gen_helper_vfp_touizh(vm, vm, fpst);
+        } else {
+            gen_helper_vfp_touih(vm, vm, fpst);
+        }
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
 static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
 {
     TCGv_i32 vm;
-- 
2.20.1


