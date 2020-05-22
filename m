Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E938205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMxNxv7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E938205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc96O-0004ds-HT
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc954-0001rh-4T
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc953-0006Qc-6Q
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so3115185wmj.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h8C+sirQq0LQGA2KO8QQ/JH+LvpC1dkrtfwj+w2/EgY=;
 b=BMxNxv7A9Vy7Urv6dZp/woQVK04umX7oDDjfeYhqcy67rZ++ALmevlO5+6JJP+5kZT
 beqoF2xNbJP4sbrlvx9jNVHFzoRhtkE098KOnNytmV7cEoG7HIdbME0aiite15o7PRB9
 dth4pZeAbgR9OZA7WtIhDx6fbBBdIRLzo+8nMekIi9E25MUIyR0vkTOkS1GWUGASb/0M
 RtHkJPPip2cv1hHlASCKxsthMVjKhcWK01YvaKErKPl4yyuNZrnS1/Sb2hSboQqGixX2
 lQGIRSdKs3Txq6UQICSWKSrK6OrPTnBQljoeAx5QKMv+zy+jSkqih9pmEvXEqJjT6O6j
 EJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h8C+sirQq0LQGA2KO8QQ/JH+LvpC1dkrtfwj+w2/EgY=;
 b=BbTdfsQCWZLguobtRRkOwI3/Ym9PAAQm2UsIDCdAvN6GK3Lw3NqvIHFuoyoZaNZx5d
 fjS5Hxr+YUjioo6TybDckIrSTFcC2T9Ni+qIKrsOOWVx3qmA6AjVM+NVIWNOQuwuSkiJ
 zexVbybbKxp7NUQ3sVrZWawVuWvfUSSn65SIIEdb2Rpkw4syAyIufN1Leza4TQAZNOQ4
 RyAMUPGHQuRe+QXe73W/RTY1i+HZzpSTGQrQkzy+pcWggCakjct4d5Zim0TLts3uyI1g
 NiT6rkdrwjo46zRwwZk83fM+KaCwrNsnZQAVhu2F0GWiCxTYq895rBSKUDHGa3kSQ9IX
 dJaA==
X-Gm-Message-State: AOAM532CJ7HRHE0fWuiDnZLNg2ujK4iwt6E1IKKQqlY7uQhWjm1f7ypT
 L6sxkG86asxPY8s0fm+XPxcFuAmQ24e81Q==
X-Google-Smtp-Source: ABdhPJxS2MrbO7Ed8twQngqrzxSCCOlSVsqYd7Ca7qYonI6WUgVxEKo4ufj0ySD3fSPrqI/sFkIUQw==
X-Received: by 2002:a05:600c:34c:: with SMTP id
 u12mr13543022wmd.4.1590159323776; 
 Fri, 22 May 2020 07:55:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y8sm1100561wmc.37.2020.05.22.07.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:55:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] target/arm: Convert Neon VSHL and VSLI 2-reg-shift
 insn to decodetree
Date: Fri, 22 May 2020 15:55:12 +0100
Message-Id: <20200522145520.6778-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
References: <20200522145520.6778-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VSHL and VSLI insns from the Neon 2-registers-and-a-shift
group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 25 ++++++++++++++++++++++
 target/arm/translate-neon.inc.c | 38 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 18 +++++++---------
 3 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 8beb1db768b..4bd305e7ea0 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -199,3 +199,28 @@ VRECPS_fp_3s     1111 001 0 0 . 0 . .... .... 1111 ... 1 .... @3same_fp
 VRSQRTS_fp_3s    1111 001 0 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 VMAXNM_fp_3s     1111 001 1 0 . 0 . .... .... 1111 ... 1 .... @3same_fp
 VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
+
+######################################################################
+# 2-reg-and-shift grouping:
+# 1111 001 U 1 D immH:3 immL:3 Vd:4 opc:4 L Q M 1 Vm:4
+######################################################################
+&2reg_shift vm vd q shift size
+
+@2reg_shl_d      .... ... . . . shift:6      .... .... 1 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=3
+@2reg_shl_s      .... ... . . . 1 shift:5    .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=2
+@2reg_shl_h      .... ... . . . 01 shift:4   .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=1
+@2reg_shl_b      .... ... . . . 001 shift:3  .... .... 0 q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=0
+
+VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
+VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
+VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
+VSHL_2sh         1111 001 0 1 . ...... .... 0101 . . . 1 .... @2reg_shl_b
+
+VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
+VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
+VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
+VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_b
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 3fe65a0b080..305213fe6d9 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1310,3 +1310,41 @@ static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 DO_3S_FP_PAIR(VPADD, gen_helper_vfp_adds)
 DO_3S_FP_PAIR(VPMAX, gen_helper_vfp_maxs)
 DO_3S_FP_PAIR(VPMIN, gen_helper_vfp_mins)
+
+static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
+{
+    /* Handle a 2-reg-shift insn which can be vectorized. */
+    int vec_size = a->q ? 16 : 8;
+    int rd_ofs = neon_reg_offset(a->vd, 0);
+    int rm_ofs = neon_reg_offset(a->vm, 0);
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn(a->size, rd_ofs, rm_ofs, a->shift, vec_size, vec_size);
+    return true;
+}
+
+#define DO_2SH(INSN, FUNC)                                              \
+    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
+    {                                                                   \
+        return do_vector_2sh(s, a, FUNC);                               \
+    }                                                                   \
+
+DO_2SH(VSHL, tcg_gen_gvec_shli)
+DO_2SH(VSLI, gen_gvec_sli)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c8296116d4b..d0a4a08f6d9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5294,6 +5294,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         if ((insn & 0x00380080) != 0) {
             /* Two registers and shift.  */
             op = (insn >> 8) & 0xf;
+
+            switch (op) {
+            case 5: /* VSHL, VSLI */
+                return 1; /* handled by decodetree */
+            default:
+                break;
+            }
+
             if (insn & (1 << 7)) {
                 /* 64-bit shift. */
                 if (op > 7) {
@@ -5387,16 +5395,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     gen_gvec_sri(size, rd_ofs, rm_ofs, shift,
                                  vec_size, vec_size);
                     return 0;
-
-                case 5: /* VSHL, VSLI */
-                    if (u) { /* VSLI */
-                        gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
-                                     vec_size, vec_size);
-                    } else { /* VSHL */
-                        tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
-                                          vec_size, vec_size);
-                    }
-                    return 0;
                 }
 
                 if (size == 3) {
-- 
2.20.1


