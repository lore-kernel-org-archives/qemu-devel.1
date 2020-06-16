Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A60C2098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9LQR8L6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A60C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF6M-0004Ii-OJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF53-0001Ho-Cs
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF50-0007T2-TC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so21555470wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/klidXRNhVmx5c20XB8gUIDpvSPxZBtSgZItdrt0HuY=;
 b=V9LQR8L6Boc4/gBLdE8O3b3aD+DFf87ZxBhVnvYVX4BMFTvbZH4JsCp85AGXg5J36z
 CGWA/ufYVnnFcP0G5x4/5oeep6c1pwGdm9xWSYfi8DPkCJJMmff33qUKlY+JihWfKcVA
 u5zXBgzNRi+Rkta7HS9PAAtyCOWSA8rODPSWyjJ1mQQT5SbT4pzUFI9kFZfG4x0wgyS2
 Cmd2ipx/Fj34inDCWDTJdvnRfOhtro56DrHapkdoTn1bE2tPk8/uMn8kEGLywSfLSO5X
 X/akZNV5kXNA4Wvo2k7AfTZd7NnYqoM+GOVNYZjAqVV1ccLhPV4CrnbuuLbDbNelBtA3
 q5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/klidXRNhVmx5c20XB8gUIDpvSPxZBtSgZItdrt0HuY=;
 b=J6MbDhKpeu29B0kfnWkxU0ml8w4k2gu5Poog3WZ8R075Ckx9d9UGMIcXpmgmLy5Vmv
 D/pRwOerPFr1ynR3Ljs2LpDx1+svJJPx5S5JtO3dr36FatmzevgdC0k4bHYTp83HdqDL
 tsRd19CaXbrdvuqXEE7BNg/zsj+tqBz6Ub7YBWyYW5LtHv72PkjV2BZwEcmjTT0NSSW7
 s2opDs23tCFXAE4p9i89EzR1m1HQR/RssPOfD8tkaAvT1KzBQ7IPN0UBs6NvPX6srTwl
 6K2ZaYD04J6GJxR5+2Fl+uuWYKuhis1Xujvyvoekkjh2xqJMqX/tRpwmjKwK4YNC7OhX
 /6ZA==
X-Gm-Message-State: AOAM533fpY4ckQ4Epml1zPs8bIZ7/usA68/OkCiel3iWbBACObtlZ0hB
 8HvIm+HwnkAULtkBpXQZlmE/TQ==
X-Google-Smtp-Source: ABdhPJxWIuXqOKOGq8KnlVcfbtbb4wlbwuaZAG2wulG3jWMBUzki7Tio4bYGOzx+wARmlZZ/abXi2Q==
X-Received: by 2002:adf:f251:: with SMTP id b17mr3891175wrp.289.1592327337483; 
 Tue, 16 Jun 2020 10:08:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/21] target/arm: Convert vectorised 2-reg-misc Neon ops to
 decodetree
Date: Tue, 16 Jun 2020 18:08:30 +0100
Message-Id: <20200616170844.13318-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Convert to decodetree the insns in the Neon 2-reg-misc grouping which
we implement using gvec.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 11 +++++++
 target/arm/translate-neon.inc.c | 55 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 35 +++++----------------
 3 files changed, 74 insertions(+), 27 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 8174f2f92f4..b5692070d62 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -447,9 +447,20 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VPADDL_S     1111 001 11 . 11 .. 00 .... 0 0100 . . 0 .... @2misc
     VPADDL_U     1111 001 11 . 11 .. 00 .... 0 0101 . . 0 .... @2misc
 
+    VMVN         1111 001 11 . 11 .. 00 .... 0 1011 . . 0 .... @2misc
+
     VPADAL_S     1111 001 11 . 11 .. 00 .... 0 1100 . . 0 .... @2misc
     VPADAL_U     1111 001 11 . 11 .. 00 .... 0 1101 . . 0 .... @2misc
 
+    VCGT0        1111 001 11 . 11 .. 01 .... 0 0000 . . 0 .... @2misc
+    VCGE0        1111 001 11 . 11 .. 01 .... 0 0001 . . 0 .... @2misc
+    VCEQ0        1111 001 11 . 11 .. 01 .... 0 0010 . . 0 .... @2misc
+    VCLE0        1111 001 11 . 11 .. 01 .... 0 0011 . . 0 .... @2misc
+    VCLT0        1111 001 11 . 11 .. 01 .... 0 0100 . . 0 .... @2misc
+
+    VABS         1111 001 11 . 11 .. 01 .... 0 0110 . . 0 .... @2misc
+    VNEG         1111 001 11 . 11 .. 01 .... 0 0111 . . 0 .... @2misc
+
     VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
     VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index d37be597cf4..d80123514c2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3450,3 +3450,58 @@ static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
 
     return true;
 }
+
+static bool do_2misc_vec(DisasContext *s, arg_2misc *a, GVecGen2Fn *fn)
+{
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
+    if (a->size == 3) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn(a->size, rd_ofs, rm_ofs, vec_size, vec_size);
+
+    return true;
+}
+
+#define DO_2MISC_VEC(INSN, FN)                                  \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        return do_2misc_vec(s, a, FN);                          \
+    }
+
+DO_2MISC_VEC(VNEG, tcg_gen_gvec_neg)
+DO_2MISC_VEC(VABS, tcg_gen_gvec_abs)
+DO_2MISC_VEC(VCEQ0, gen_gvec_ceq0)
+DO_2MISC_VEC(VCGT0, gen_gvec_cgt0)
+DO_2MISC_VEC(VCLE0, gen_gvec_cle0)
+DO_2MISC_VEC(VCGE0, gen_gvec_cge0)
+DO_2MISC_VEC(VCLT0, gen_gvec_clt0)
+
+static bool trans_VMVN(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_2misc_vec(s, a, tcg_gen_gvec_not);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1ea09695546..0f0741a37bc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4859,7 +4859,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int size;
     int pass;
     int u;
-    int vec_size;
     TCGv_i32 tmp, tmp2;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -4883,7 +4882,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     VFP_DREG_D(rd, insn);
     VFP_DREG_M(rm, insn);
     size = (insn >> 20) & 3;
-    vec_size = q ? 16 : 8;
     rd_ofs = neon_reg_offset(rd, 0);
     rm_ofs = neon_reg_offset(rm, 0);
 
@@ -4929,6 +4927,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VSHLL:
                 case NEON_2RM_VCVT_F16_F32:
                 case NEON_2RM_VCVT_F32_F16:
+                case NEON_2RM_VMVN:
+                case NEON_2RM_VNEG:
+                case NEON_2RM_VABS:
+                case NEON_2RM_VCEQ0:
+                case NEON_2RM_VCGT0:
+                case NEON_2RM_VCLE0:
+                case NEON_2RM_VCGE0:
+                case NEON_2RM_VCLT0:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4989,31 +4995,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                        q ? gen_helper_crypto_sha256su0
                                        : gen_helper_crypto_sha1su1);
                     break;
-                case NEON_2RM_VMVN:
-                    tcg_gen_gvec_not(0, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-                case NEON_2RM_VNEG:
-                    tcg_gen_gvec_neg(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-                case NEON_2RM_VABS:
-                    tcg_gen_gvec_abs(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-
-                case NEON_2RM_VCEQ0:
-                    gen_gvec_ceq0(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-                case NEON_2RM_VCGT0:
-                    gen_gvec_cgt0(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-                case NEON_2RM_VCLE0:
-                    gen_gvec_cle0(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-                case NEON_2RM_VCGE0:
-                    gen_gvec_cge0(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
-                case NEON_2RM_VCLT0:
-                    gen_gvec_clt0(size, rd_ofs, rm_ofs, vec_size, vec_size);
-                    break;
 
                 default:
                 elementwise:
-- 
2.20.1


