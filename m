Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD08C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DDE20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlBkcGvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DDE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhM1-0003lM-9N
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH3-00030n-NO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH0-0003F1-LK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id v3so12682629wrc.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qXjJvtW1Cc7ICBcUFbiKQwi/3qdYjZRksSHBdYctsCI=;
 b=IlBkcGvyJec6ueYdp3hHjDbijTxJzIfVfmvq1pAE0MgVx6dmzXKSPAp1ZyqZ6TD2yD
 xH0te5i0mE4UBP0+sAlNAjkW3DDUzcfSgwU3udypsYiIUa4hk261nDXNocOvqvNAfRSj
 J993tUn0StIXy3WR1Q8rF+4kmH+iuuI9H/o88clmFDn9Q45kM8scA1k89wA8Zz25lh8u
 SxA1OQSo608wDF2IMcPf36mIWKIvpoUDv57o3olPNIWTuPEXi+/pltiKDQ1etMZqxz50
 Tj/GAusFKD7iDI0wFVH4BSIXrnabmVTrMg8oioK5y/utfu3aPI5pdhTUG9uu9GflDzxz
 20Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qXjJvtW1Cc7ICBcUFbiKQwi/3qdYjZRksSHBdYctsCI=;
 b=a2QSlvCTLPNy0TGdp65obl37oK6l/G2MSvgDveCL7pDIUPOp2iKbDwkTsfQ4j2vjZb
 nNCWIK9I5olijuqxu1+opeFlf2+qMUGvMt8iMFO6uRV+v2CE1CEJJONzl2yXZikqPh6M
 xe7nYScTMmc23XaaKGvlEu93fMzzY/x51qOwyZI5XHL+nVqtC8ANmsCSUDuT63704S6R
 nuL5lVXKOCCsobo9I+TQc6bHuduNstYPICtDSFuLOuPDXEeQXODn/OBfboPSZiD/Bknk
 OfphdR1739A2B3jLUZq0ACxTSPGG9XAtey9jsF+30vo6JzDCBE8uoyfzj022K9SPFNwy
 1c7w==
X-Gm-Message-State: AOAM531q+43gR0WAAQpapNPLdd4WwDMYPJE2ZDT6bWFqfWaMcmUpdsxn
 fdIX9p5TlOl6ckZJ8UMiPkb0C/3bb78hxg==
X-Google-Smtp-Source: ABdhPJwze32qbTHG8v+PfuqXdHNhGpPaNES+tZw2nm61SQtzEx55jeQR/BIPrUHwRcJkA0D1cYpxWQ==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr23899486wrw.194.1592912368295; 
 Tue, 23 Jun 2020 04:39:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/42] target/arm: Convert Neon 2-reg-misc VRINT insns to
 decodetree
Date: Tue, 23 Jun 2020 12:38:41 +0100
Message-Id: <20200623113904.28805-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Convert the Neon 2-reg-misc VRINT insns to decodetree.
Giving these insns their own do_vrint() function allows us
to change the rounding mode just once at the start and end
rather than doing it for every element in the vector.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-18-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  8 +++++
 target/arm/translate-neon.inc.c | 61 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 31 +++--------------
 3 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index c9acd00f1e8..e0717c7e4a6 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -503,11 +503,19 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     SHA1SU1      1111 001 11 . 11 .. 10 .... 0 0111 0 . 0 .... @2misc_q1
     SHA256SU0    1111 001 11 . 11 .. 10 .... 0 0111 1 . 0 .... @2misc_q1
 
+    VRINTN       1111 001 11 . 11 .. 10 .... 0 1000 . . 0 .... @2misc
     VRINTX       1111 001 11 . 11 .. 10 .... 0 1001 . . 0 .... @2misc
+    VRINTA       1111 001 11 . 11 .. 10 .... 0 1010 . . 0 .... @2misc
+    VRINTZ       1111 001 11 . 11 .. 10 .... 0 1011 . . 0 .... @2misc
 
     VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
+
+    VRINTM       1111 001 11 . 11 .. 10 .... 0 1101 . . 0 .... @2misc
+
     VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
 
+    VRINTP       1111 001 11 . 11 .. 10 .... 0 1111 . . 0 .... @2misc
+
     VRECPE       1111 001 11 . 11 .. 11 .... 0 1000 . . 0 .... @2misc
     VRSQRTE      1111 001 11 . 11 .. 11 .... 0 1001 . . 0 .... @2misc
     VRECPE_F     1111 001 11 . 11 .. 11 .... 0 1010 . . 0 .... @2misc
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a62da21b152..0e7f86ad156 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3796,3 +3796,64 @@ DO_FP_CMP0(VCGE0_F, gen_helper_neon_cge_f32, FWD)
 DO_FP_CMP0(VCEQ0_F, gen_helper_neon_ceq_f32, FWD)
 DO_FP_CMP0(VCLE0_F, gen_helper_neon_cge_f32, REV)
 DO_FP_CMP0(VCLT0_F, gen_helper_neon_cgt_f32, REV)
+
+static bool do_vrint(DisasContext *s, arg_2misc *a, int rmode)
+{
+    /*
+     * Handle a VRINT* operation by iterating 32 bits at a time,
+     * with a specified rounding mode in operation.
+     */
+    int pass;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size != 2) {
+        /* TODO: FP16 will be the size == 1 case */
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
+    fpst = get_fpstatus_ptr(1);
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
+    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        gen_helper_rints(tmp, tmp, fpst);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    tcg_temp_free_i32(tcg_rmode);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
+#define DO_VRINT(INSN, RMODE)                                   \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        return do_vrint(s, a, RMODE);                           \
+    }
+
+DO_VRINT(VRINTN, FPROUNDING_TIEEVEN)
+DO_VRINT(VRINTA, FPROUNDING_TIEAWAY)
+DO_VRINT(VRINTZ, FPROUNDING_ZERO)
+DO_VRINT(VRINTM, FPROUNDING_NEGINF)
+DO_VRINT(VRINTP, FPROUNDING_POSINF)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dc98928856d..61dfc3ae7af 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4959,6 +4959,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VCEQ0_F:
                 case NEON_2RM_VCLE0_F:
                 case NEON_2RM_VCLT0_F:
+                case NEON_2RM_VRINTN:
+                case NEON_2RM_VRINTA:
+                case NEON_2RM_VRINTM:
+                case NEON_2RM_VRINTP:
+                case NEON_2RM_VRINTZ:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4993,32 +4998,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                             neon_store_reg(rm, pass, tmp2);
                             break;
-                        case NEON_2RM_VRINTN:
-                        case NEON_2RM_VRINTA:
-                        case NEON_2RM_VRINTM:
-                        case NEON_2RM_VRINTP:
-                        case NEON_2RM_VRINTZ:
-                        {
-                            TCGv_i32 tcg_rmode;
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            int rmode;
-
-                            if (op == NEON_2RM_VRINTZ) {
-                                rmode = FPROUNDING_ZERO;
-                            } else {
-                                rmode = fp_decode_rm[((op & 0x6) >> 1) ^ 1];
-                            }
-
-                            tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-                            gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
-                                                      cpu_env);
-                            gen_helper_rints(tmp, tmp, fpstatus);
-                            gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
-                                                      cpu_env);
-                            tcg_temp_free_ptr(fpstatus);
-                            tcg_temp_free_i32(tcg_rmode);
-                            break;
-                        }
                         case NEON_2RM_VCVTAU:
                         case NEON_2RM_VCVTAS:
                         case NEON_2RM_VCVTNU:
-- 
2.20.1


