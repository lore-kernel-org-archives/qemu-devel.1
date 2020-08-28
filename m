Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D85DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266302065F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXnnzZ8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266302065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjG5-0007jp-CC
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCT-00028n-AG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCM-0005vi-SY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id a5so55124wrm.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=P4s9oZdr3MItAR+7GTZ+E61G0Uww+8i5fEzDSEJq2dA=;
 b=JXnnzZ8bHfd/j5/yRT/GAsAP2CgbF6dDFn1ikvwMaQANQxDC/5DQ8pl2Hzyry1WILr
 gE/V3rdZF+g1y0VKamcFAZCsbCL0EvGKGNLftJ2iN1eg4OLdUQoC4mQT5eOFsJAlirgg
 X6xdRj1YLEUXJ+SsHEQgOZnuOwXfrIVs9C6uEm6KE6qpY3FA/j6jfcbz5Z2TrsMlnlF6
 ZNbq4vIZBM/v103Tv9Y1OFaT6mpt+cGYDn9s6HbLyr8oGGCEoE/xRDTRzbn9sp0NnXFC
 X7GjdAoccXyhqK1d6kZsovuZ/1NJhc2VpvB7yB+ecfK0NGZtMtMaQq/roc4G6/O5C0WZ
 MbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P4s9oZdr3MItAR+7GTZ+E61G0Uww+8i5fEzDSEJq2dA=;
 b=EK0HrpG6anUsDOzWLS/5hbEdUCGe2qHCiRqsGOjMx5CI9rvLri7KN4+2yWtHheoH0y
 oKfSJ1oLh00QGq+ds1izDKStGfJaRyzY4Uw7lUzdbB1K2wUnT8JthY6MOVnNN1rpxZVl
 uuT1ylQe45zS9kKvknDR3+03UTLAb7iotStZInAp+PhCJAnMDQ9rkY0i7IBmZwgEgshu
 0lcfVhTF5o3L+ieUbRIWglmqK6F1apoy2oqSQFW7Wen/0jcu9FHFpf3mZHWzRF3NszsZ
 870m+gWHoJNeKfURvIrcwL9Teg+GG4d1DSiysAMylMv71adulf2IcjJ4yLR0xDAoP4i+
 0PXQ==
X-Gm-Message-State: AOAM533wJ/tpueJSTpUJd0W4vLWq1BfWpuf49cExdAmzOWhHszemcgF0
 iv5i2Z+27sv2t4knJ4Osji2urQ==
X-Google-Smtp-Source: ABdhPJweSpCkSZ94SLSee8ZlnfY2mET10U7Y2rylbXpCN+FYhmothyAdAjnlkQ4txs5f80/HuTjLog==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr256783wrw.378.1598639640339; 
 Fri, 28 Aug 2020 11:34:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:33:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/45] target/arm: Implement VFP fp16 for VFP_BINOP
 operations
Date: Fri, 28 Aug 2020 19:33:12 +0100
Message-Id: <20200828183354.27913-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Implmeent VFP fp16 support for simple binary-operator VFP insns VADD,
VSUB, VMUL, VDIV, VMINNM and VMAXNM:

 * make the VFP_BINOP() macro generate float16 helpers as well as
   float32 and float64
 * implement a do_vfp_3op_hp() function similar to the existing
   do_vfp_3op_sp()
 * add decode for the half-precision insn patterns

Note that the VFP_BINOP macro use creates a couple of unused helper
functions vfp_maxh and vfp_minh, but they're small so it's not worth
splitting the BINOP operations into "needs halfprec" and "no
halfprec" groups.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  8 ++++
 target/arm/vfp-uncond.decode   |  3 ++
 target/arm/vfp.decode          |  4 ++
 target/arm/vfp_helper.c        |  5 ++
 target/arm/translate-vfp.c.inc | 86 ++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3ca73a1764a..61e4e938861 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -101,20 +101,28 @@ DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
+DEF_HELPER_3(vfp_addh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_adds, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_addd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_subh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_subs, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_subd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_mulh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_muls, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_muld, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_divh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_divs, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_divd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_maxh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_maxs, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_maxd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_minh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_mins, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_mind, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_maxnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
 DEF_HELPER_1(vfp_negs, f32, f32)
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 34ca164266f..ee700e51972 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -49,6 +49,9 @@ VSEL        1111 1110 0. cc:2 .... .... 1010 .0.0 .... \
 VSEL        1111 1110 0. cc:2 .... .... 1011 .0.0 .... \
             vm=%vm_dp vn=%vn_dp vd=%vd_dp dp=1
 
+VMAXNM_hp   1111 1110 1.00 .... .... 1001 .0.0 ....         @vfp_dnm_s
+VMINNM_hp   1111 1110 1.00 .... .... 1001 .1.0 ....         @vfp_dnm_s
+
 VMAXNM_sp   1111 1110 1.00 .... .... 1010 .0.0 ....         @vfp_dnm_s
 VMINNM_sp   1111 1110 1.00 .... .... 1010 .1.0 ....         @vfp_dnm_s
 
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 2c793e3e87f..1ecd5e28ca0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -115,18 +115,22 @@ VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
 VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 ....        @vfp_dnm_s
 VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
+VMUL_hp      ---- 1110 0.10 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VMUL_sp      ---- 1110 0.10 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VMUL_dp      ---- 1110 0.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
 VNMUL_sp     ---- 1110 0.10 .... .... 1010 .1.0 ....        @vfp_dnm_s
 VNMUL_dp     ---- 1110 0.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
+VADD_hp      ---- 1110 0.11 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
+VSUB_hp      ---- 1110 0.11 .... .... 1001 .1.0 ....        @vfp_dnm_s
 VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 ....        @vfp_dnm_s
 VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
+VDIV_hp      ---- 1110 1.00 .... .... 1001 .0.0 ....        @vfp_dnm_s
 VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 02ab8d7f2d8..b8ca744bccc 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -236,6 +236,11 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val)
 #define VFP_HELPER(name, p) HELPER(glue(glue(vfp_,name),p))
 
 #define VFP_BINOP(name) \
+dh_ctype_f16 VFP_HELPER(name, h)(dh_ctype_f16 a, dh_ctype_f16 b, void *fpstp) \
+{ \
+    float_status *fpst = fpstp; \
+    return float16_ ## name(a, b, fpst); \
+} \
 float32 VFP_HELPER(name, s)(float32 a, float32 b, void *fpstp) \
 { \
     float_status *fpst = fpstp; \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 4eeafb494ad..01a5fd65115 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -1266,6 +1266,54 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     return true;
 }
 
+static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
+                          int vd, int vn, int vm, bool reads_vd)
+{
+    /*
+     * Do a half-precision operation. Functionally this is
+     * the same as do_vfp_3op_sp(), except:
+     *  - it uses the FPST_FPCR_F16
+     *  - it doesn't need the VFP vector handling (fp16 is a
+     *    v8 feature, and in v8 VFP vectors don't exist)
+     *  - it does the aa32_fp16_arith feature test
+     */
+    TCGv_i32 f0, f1, fd;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
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
+    f0 = tcg_temp_new_i32();
+    f1 = tcg_temp_new_i32();
+    fd = tcg_temp_new_i32();
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
+
+    neon_load_reg32(f0, vn);
+    neon_load_reg32(f1, vm);
+
+    if (reads_vd) {
+        neon_load_reg32(fd, vd);
+    }
+    fn(fd, f0, f1, fpst);
+    neon_store_reg32(fd, vd);
+
+    tcg_temp_free_i32(f0);
+    tcg_temp_free_i32(f1);
+    tcg_temp_free_i32(fd);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
 static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
                           int vd, int vn, int vm, bool reads_vd)
 {
@@ -1643,6 +1691,11 @@ static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_dp *a)
     return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
 }
 
+static bool trans_VMUL_hp(DisasContext *s, arg_VMUL_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_helper_vfp_mulh, a->vd, a->vn, a->vm, false);
+}
+
 static bool trans_VMUL_sp(DisasContext *s, arg_VMUL_sp *a)
 {
     return do_vfp_3op_sp(s, gen_helper_vfp_muls, a->vd, a->vn, a->vm, false);
@@ -1677,6 +1730,11 @@ static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_dp *a)
     return do_vfp_3op_dp(s, gen_VNMUL_dp, a->vd, a->vn, a->vm, false);
 }
 
+static bool trans_VADD_hp(DisasContext *s, arg_VADD_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_helper_vfp_addh, a->vd, a->vn, a->vm, false);
+}
+
 static bool trans_VADD_sp(DisasContext *s, arg_VADD_sp *a)
 {
     return do_vfp_3op_sp(s, gen_helper_vfp_adds, a->vd, a->vn, a->vm, false);
@@ -1687,6 +1745,11 @@ static bool trans_VADD_dp(DisasContext *s, arg_VADD_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
 }
 
+static bool trans_VSUB_hp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_helper_vfp_subh, a->vd, a->vn, a->vm, false);
+}
+
 static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
 {
     return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
@@ -1697,6 +1760,11 @@ static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
 }
 
+static bool trans_VDIV_hp(DisasContext *s, arg_VDIV_sp *a)
+{
+    return do_vfp_3op_hp(s, gen_helper_vfp_divh, a->vd, a->vn, a->vm, false);
+}
+
 static bool trans_VDIV_sp(DisasContext *s, arg_VDIV_sp *a)
 {
     return do_vfp_3op_sp(s, gen_helper_vfp_divs, a->vd, a->vn, a->vm, false);
@@ -1707,6 +1775,24 @@ static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
 
+static bool trans_VMINNM_hp(DisasContext *s, arg_VMINNM_sp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_hp(s, gen_helper_vfp_minnumh,
+                         a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMAXNM_hp(DisasContext *s, arg_VMAXNM_sp *a)
+{
+    if (!dc_isar_feature(aa32_vminmaxnm, s)) {
+        return false;
+    }
+    return do_vfp_3op_hp(s, gen_helper_vfp_maxnumh,
+                         a->vd, a->vn, a->vm, false);
+}
+
 static bool trans_VMINNM_sp(DisasContext *s, arg_VMINNM_sp *a)
 {
     if (!dc_isar_feature(aa32_vminmaxnm, s)) {
-- 
2.20.1


