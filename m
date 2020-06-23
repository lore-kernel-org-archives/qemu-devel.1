Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E995C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498EF20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5i5oU4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498EF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhKy-0001AT-H0
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGq-0002WR-FG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGo-0003B6-D9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id 17so2864652wmo.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A7eYDgZAAs2KTvVuHcnbdKug1DdrwXimAuXS2ZcmzWk=;
 b=v5i5oU4AmIWEg5ruWpA5FA/GW9bnZCWd/r+YMw9aYgfGNrEz2n9b1N581tOUMe7i1l
 1itDFZz+BtHuNB9LjzfmVu1fXKL3uNmWKw+ppeCPmKq38d8KrD+O0U8IVIBxPEiyt2oH
 bQj6KuylLlVjXuOjQJ072ajblBl/inRutHtCAKgzFNyW2fXD0pFbBSmvbzct8hHrjIqA
 wDRrONOrj/Aot42jVgMg9/0UnhnZBvQTMCfBNjP/HtAI3/zQij0SKRx3yHBPWRVnmmaq
 beTuZYS/qzSGXtWyREjJ4YhpKUO9bjEUr6wo8ho0TP2WiZnelkxOGAX+6blBDUwceEnp
 xoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A7eYDgZAAs2KTvVuHcnbdKug1DdrwXimAuXS2ZcmzWk=;
 b=AaPcZofeiWRWq4+e//40GrDaihJQa5YOiHGlOQZmPPIwSeg3J6QMotj0yWT0TstVKv
 NgRr1kuMVOgzGieX/nrTCg9zZ2BR2toWNB2Ftpd9nwrjZb0HUAOWObD0cT56Hnje22aU
 Wprk0kFgggf6/e5SA2GsYjVJc+5FAN5CJQJpdxCPiWpHmcIbsXyilVbM7QXek+DgrBW7
 DDdGdPNKUmodWd1MShfDWfZr4s/Qqlvg0B4+Bo5ksAP+Qlpuwa827eKaG0WyuTmctFjn
 kE87bGM5yn6mMZZo4zhI+7+us/jmItVfo2T8CRAwHxcAJdCaoCG2K3C4Va8QU+epN/Mg
 WFWg==
X-Gm-Message-State: AOAM532F7Ob7xAL0NEn54P97TU982O9so+K3aJ1wy0X3Ahe+8zvLeSEm
 yPnlHTvEQeNrkjyofP2x51SdKCzD0WUFwg==
X-Google-Smtp-Source: ABdhPJxch/abuKJgmFotdZV9zIXS/BoxOJpiH9VFW6rUS0fx27rhOLbvTNPWny1XSY6sdiR5h91L2g==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr4441074wme.139.1592912356440;
 Tue, 23 Jun 2020 04:39:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/42] target/arm: Convert vectorised 2-reg-misc Neon ops to
 decodetree
Date: Tue, 23 Jun 2020 12:38:31 +0100
Message-Id: <20200623113904.28805-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert to decodetree the insns in the Neon 2-reg-misc grouping which
we implement using gvec.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-8-peter.maydell@linaro.org
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


