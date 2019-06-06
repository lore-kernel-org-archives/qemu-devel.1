Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5844C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791892083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbBUrf5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791892083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36411 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwwk-0000Qk-Ns
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:17:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUD-0004dN-Kn
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU7-0004D2-NH
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-0003B9-9t
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n4so3297745wrw.13
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DYPK+P+JSUxtoNlpvBWaaa9Mw2BXlyzOlDcWjRdGGn0=;
	b=NbBUrf5mKw3jfcFN3ktPU9a4uSCffrdw9pHyV+1wktCRpVkyahWZJJAedIbCdYENZ0
	4VFbASA3IO6v9HnOS7GuA3R7MF3wJN7fB8Q+bxAGDGRspBYmqS/ujM+T23v1Ogd3go3Y
	qQrJa7Od5VUp9nEBwKXSS+9vABrVFyvXh+rUOyrFvrfq30HjZcnhmmv/kLljBWw8fmYT
	1HXx61AGhj8033HonupdDuaYcdp76unR9YSNl2C2SqHGYMLxLme4zJZS6lcJMhdhdM5F
	EDkuBMt3/7543yNpcO3IPcUHX2eUB3goW029PhOrXHn9791s+j8o+uCMkdF/ukOxIjhT
	SgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DYPK+P+JSUxtoNlpvBWaaa9Mw2BXlyzOlDcWjRdGGn0=;
	b=iIQcOMl0eX2LCGsoJtjbnjwFtIohkjK45He/AYLG5DFJp5MkuqUNEWiXE/lx/i4eeh
	oXtjOJZXF7NYrbHQiwhBtZtnaNuSv1kI9FM2pnoJSaWfb7BTayP5Sx2qAKFsZKBkI6sP
	HPWoan+h0TGqguSAF1IB580ZA+JOfrtuxPEW92dXSUT7vvMdy52IdwMNgs2wUI12lsKi
	2BLyb7ykj+YUPsR9eUzGW6mN6ywCpazXJanHsXtXrpvEJsV+KCa27tqXzKl8tBZWR+Cc
	8cBN8upWadYi7irH8ja+v7sOwZNIxUT8f9igSCNMYVGGgtd4Nq7BO6o98eMbak3kY0cy
	qjsA==
X-Gm-Message-State: APjAAAUn0PaAO2H+e3zKAThAn14sIXdjZHjsGkX14GsOrnBfXcp2cMqP
	bJRZq2+MSmlGbbdBEyqPhOS94w==
X-Google-Smtp-Source: APXvYqy9iCSDwEMfPwGtNSqE1lbXJZ3pNvVCQJiADOqdnmsVroDrewSmXKtTaJ4B6S3Yz/wBfUS2fg==
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr3581270wrw.98.1559843201025; 
	Thu, 06 Jun 2019 10:46:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:54 +0100
Message-Id: <20190606174609.20487-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PATCH 27/42] target/arm: Convert VFP fused
 multiply-add insns to decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP fused multiply-add instructions (VFNMA, VFNMS,
VFMA, VFMS) to decodetree.

Note that in the old decode structure we were implementing
these to honour the VFP vector stride/length. These instructions
were introduced in VFPv4, and in the v7A architecture they
are UNPREDICTABLE if the vector stride or length are non-zero.
In v8A they must UNDEF if stride or length are non-zero, like
all VFP instructions; we choose to UNDEF always.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 121 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  53 +--------------
 target/arm/vfp.decode          |   9 +++
 3 files changed, 131 insertions(+), 52 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 6af99605d5c..ba6506a378c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1481,3 +1481,124 @@ static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_sp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
+{
+    /*
+     * VFNMA : fd = muladd(-fd,  fn, fm)
+     * VFNMS : fd = muladd(-fd, -fn, fm)
+     * VFMA  : fd = muladd( fd,  fn, fm)
+     * VFMS  : fd = muladd( fd, -fn, fm)
+     *
+     * These are fused multiply-add, and must be done as one floating
+     * point operation with no rounding between the multiplication and
+     * addition steps.  NB that doing the negations here as separate
+     * steps is correct : an input NaN should come out with its sign
+     * bit flipped if it is a negated-input.
+     */
+    TCGv_ptr fpst;
+    TCGv_i32 vn, vm, vd;
+
+    /*
+     * Present in VFPv4 only.
+     * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
+     * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
+     */
+    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
+        (s->vec_len != 0 || s->vec_stride != 0)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vn = tcg_temp_new_i32();
+    vm = tcg_temp_new_i32();
+    vd = tcg_temp_new_i32();
+
+    neon_load_reg32(vn, a->vn);
+    neon_load_reg32(vm, a->vm);
+    if (a->o2) {
+        /* VFNMS, VFMS */
+        gen_helper_vfp_negs(vn, vn);
+    }
+    neon_load_reg32(vd, a->vd);
+    if (a->o1 & 1) {
+        /* VFNMA, VFNMS */
+        gen_helper_vfp_negs(vd, vd);
+    }
+    fpst = get_fpstatus_ptr(0);
+    gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
+    neon_store_reg32(vd, a->vd);
+
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(vn);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_i32(vd);
+
+    return true;
+}
+
+static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
+{
+    /*
+     * VFNMA : fd = muladd(-fd,  fn, fm)
+     * VFNMS : fd = muladd(-fd, -fn, fm)
+     * VFMA  : fd = muladd( fd,  fn, fm)
+     * VFMS  : fd = muladd( fd, -fn, fm)
+     *
+     * These are fused multiply-add, and must be done as one floating
+     * point operation with no rounding between the multiplication and
+     * addition steps.  NB that doing the negations here as separate
+     * steps is correct : an input NaN should come out with its sign
+     * bit flipped if it is a negated-input.
+     */
+    TCGv_ptr fpst;
+    TCGv_i64 vn, vm, vd;
+
+    /*
+     * Present in VFPv4 only.
+     * In v7A, UNPREDICTABLE with non-zero vector length/stride; from
+     * v8A, must UNDEF. We choose to UNDEF for both v7A and v8A.
+     */
+    if (!arm_dc_feature(s, ARM_FEATURE_VFP4) ||
+        (s->vec_len != 0 || s->vec_stride != 0)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vn = tcg_temp_new_i64();
+    vm = tcg_temp_new_i64();
+    vd = tcg_temp_new_i64();
+
+    neon_load_reg64(vn, a->vn);
+    neon_load_reg64(vm, a->vm);
+    if (a->o2) {
+        /* VFNMS, VFMS */
+        gen_helper_vfp_negd(vn, vn);
+    }
+    neon_load_reg64(vd, a->vd);
+    if (a->o1 & 1) {
+        /* VFNMA, VFNMS */
+        gen_helper_vfp_negd(vd, vd);
+    }
+    fpst = get_fpstatus_ptr(0);
+    gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
+    neon_store_reg64(vd, a->vd);
+
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(vn);
+    tcg_temp_free_i64(vm);
+    tcg_temp_free_i64(vd);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d35bf9d92c3..e8785fd26e6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3093,7 +3093,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 8:
+            case 0 ... 13:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3279,57 +3279,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 10: /* VFNMA : fd = muladd(-fd,  fn, fm) */
-                case 11: /* VFNMS : fd = muladd(-fd, -fn, fm) */
-                case 12: /* VFMA  : fd = muladd( fd,  fn, fm) */
-                case 13: /* VFMS  : fd = muladd( fd, -fn, fm) */
-                    /* These are fused multiply-add, and must be done as one
-                     * floating point operation with no rounding between the
-                     * multiplication and addition steps.
-                     * NB that doing the negations here as separate steps is
-                     * correct : an input NaN should come out with its sign bit
-                     * flipped if it is a negated-input.
-                     */
-                    if (!arm_dc_feature(s, ARM_FEATURE_VFP4)) {
-                        return 1;
-                    }
-                    if (dp) {
-                        TCGv_ptr fpst;
-                        TCGv_i64 frd;
-                        if (op & 1) {
-                            /* VFNMS, VFMS */
-                            gen_helper_vfp_negd(cpu_F0d, cpu_F0d);
-                        }
-                        frd = tcg_temp_new_i64();
-                        tcg_gen_ld_f64(frd, cpu_env, vfp_reg_offset(dp, rd));
-                        if (op & 2) {
-                            /* VFNMA, VFNMS */
-                            gen_helper_vfp_negd(frd, frd);
-                        }
-                        fpst = get_fpstatus_ptr(0);
-                        gen_helper_vfp_muladdd(cpu_F0d, cpu_F0d,
-                                               cpu_F1d, frd, fpst);
-                        tcg_temp_free_ptr(fpst);
-                        tcg_temp_free_i64(frd);
-                    } else {
-                        TCGv_ptr fpst;
-                        TCGv_i32 frd;
-                        if (op & 1) {
-                            /* VFNMS, VFMS */
-                            gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
-                        }
-                        frd = tcg_temp_new_i32();
-                        tcg_gen_ld_f32(frd, cpu_env, vfp_reg_offset(dp, rd));
-                        if (op & 2) {
-                            gen_helper_vfp_negs(frd, frd);
-                        }
-                        fpst = get_fpstatus_ptr(0);
-                        gen_helper_vfp_muladds(cpu_F0s, cpu_F0s,
-                                               cpu_F1s, frd, fpst);
-                        tcg_temp_free_ptr(fpst);
-                        tcg_temp_free_i32(frd);
-                    }
-                    break;
                 case 14: /* fconst */
                     if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
                         return 1;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index de305f60e18..37eec0e1310 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -142,3 +142,12 @@ VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VFM_sp       ---- 1110 1.01 .... .... 1010 . o2:1 . 0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=1
+VFM_dp       ---- 1110 1.01 .... .... 1011 . o2:1 . 0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=1
+VFM_sp       ---- 1110 1.10 .... .... 1010 . o2:1 . 0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=2
+VFM_dp       ---- 1110 1.10 .... .... 1011 . o2:1 . 0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=2
-- 
2.20.1


