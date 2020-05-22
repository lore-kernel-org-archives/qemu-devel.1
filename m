Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36517C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D6C207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHXvFu0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D6C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc99E-0001h4-8c
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc95C-0002GG-U9
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc95B-0006U4-Ny
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id y17so2053730wrn.11
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FoqQhIGM3HzHgFWnngxDVlaiVoPhQ6wjnnlrtKQGvR4=;
 b=ZHXvFu0amsNfQpEww09UipIe68TAoumZtDqP79Mt30Unqbez+ZS6JIiClhvQRlAJtw
 nbfNN36JugBh5gG7sw6C5UReV7OB/NxAJvtrFW+ZGlYFs9aeVg5MdXR2dmy53w08vFLX
 P7AWb8LbMS652t5YDGTJZeh2BrlS/NWwRGpDnaYDXDcpirGv3yitS4aBWkvNzIBdGkxs
 18+2zAhATqkwpNfbzh18lk/RzXsIq1YeKpxVHIzBJHSPdKrVLx0kLfoi7viSWoFYG382
 Tc48DnuDL9/087LPNGn/hV0AB1b0N+Y9Lg41is3AXsgToU9aA8k0pcpc/cYRJfw10kQA
 SpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FoqQhIGM3HzHgFWnngxDVlaiVoPhQ6wjnnlrtKQGvR4=;
 b=Rt7IU7Lz0XdgOhKyDBIIhA89UISj2+UfH68KheOk0rgoUY7JRAh80rVywYTxepvPir
 Dmi3OfVQpyHJU9Bn9w3WfwCW+WIhkUuXnykLbpAnkMwNGYACqv17WeP5HESqZQTsFESN
 V2Oj9NrV7rPZawDDzXShmGr3+Ke6vi9aqPEHOmrhoV/hiCeFMM8/jUk14v/sqPTPUPea
 pN2wFXZvcyrnfs6/JZqIShx+PyZ6THLLmgjH9quKrxSBnbNuJGgnfjxF144Z/m/hq1mS
 2jgkNbFG6vrjcYivQ1ey9pgZUZ0GEMzZAjRGWQRWn2zIfF2Ou4R1DM7M+jFEo6cpEta4
 yzlQ==
X-Gm-Message-State: AOAM532lKxkjUhckrSRodB5ZraH88a8cJ6U9jjwvjT+AC4QROmTb9y8X
 Dp/QfMTybLxDtN1hhtE8CIj9iQ==
X-Google-Smtp-Source: ABdhPJyicNemLlj2yhN0zS0feH7TXMM3jOqqT1XkNmrg0UbX4p+SyQLqmBPcHPjVq0Qzbt3tSTF0Zg==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr2072583wru.117.1590159332270; 
 Fri, 22 May 2020 07:55:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y8sm1100561wmc.37.2020.05.22.07.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:55:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] target/arm: Convert VCVT fixed-point ops to decodetree
Date: Fri, 22 May 2020 15:55:19 +0100
Message-Id: <20200522145520.6778-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
References: <20200522145520.6778-1-peter.maydell@linaro.org>
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

Convert the VCVT fixed-point conversion operations in the
Neon 2-regs-and-shift group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       | 11 +++++
 target/arm/translate-neon.inc.c | 49 +++++++++++++++++++++
 target/arm/translate.c          | 75 +--------------------------------
 3 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 9dd13d13254..e217d51670d 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -249,6 +249,10 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 @2reg_shll_b     .... ... . . . 001 shift:3  .... .... 0 . . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0 q=0
 
+# We use size=0 for fp32 and size=1 for fp16 to match the 3-same encodings.
+@2reg_vcvt       .... ... . . . 1 ..... .... .... . q:1 . . .... \
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=0 shift=%neon_rshift_i5
+
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_d
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_s
 VSHR_S_2sh       1111 001 0 1 . ...... .... 0000 . . . 1 .... @2reg_shr_h
@@ -362,3 +366,10 @@ VSHLL_S_2sh      1111 001 0 1 . ...... .... 1010 . 0 . 1 .... @2reg_shll_b
 VSHLL_U_2sh      1111 001 1 1 . ...... .... 1010 . 0 . 1 .... @2reg_shll_s
 VSHLL_U_2sh      1111 001 1 1 . ...... .... 1010 . 0 . 1 .... @2reg_shll_h
 VSHLL_U_2sh      1111 001 1 1 . ...... .... 1010 . 0 . 1 .... @2reg_shll_b
+
+# VCVT fixed<->float conversions
+# TODO: FP16 fixed<->float conversions are opc==0b1100 and 0b1101
+VCVT_SF_2sh      1111 001 0 1 . ...... .... 1110 0 . . 1 .... @2reg_vcvt
+VCVT_UF_2sh      1111 001 1 1 . ...... .... 1110 0 . . 1 .... @2reg_vcvt
+VCVT_FS_2sh      1111 001 0 1 . ...... .... 1111 0 . . 1 .... @2reg_vcvt
+VCVT_FU_2sh      1111 001 1 1 . ...... .... 1111 0 . . 1 .... @2reg_vcvt
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 5678bfd0d4d..8d1c58eddc2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1768,3 +1768,52 @@ static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
     };
     return do_vshll_2sh(s, a, widenfn[a->size], true);
 }
+
+static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
+                      NeonGenTwoSingleOPFn *fn)
+{
+    /* FP operations in 2-reg-and-shift group */
+    TCGv_i32 tmp, shiftv;
+    TCGv_ptr fpstatus;
+    int pass;
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
+    fpstatus = get_fpstatus_ptr(1);
+    shiftv = tcg_const_i32(a->shift);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        tmp = neon_load_reg(a->vm, pass);
+        fn(tmp, tmp, shiftv, fpstatus);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    tcg_temp_free_ptr(fpstatus);
+    tcg_temp_free_i32(shiftv);
+    return true;
+}
+
+#define DO_FP_2SH(INSN, FUNC)                                           \
+    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
+    {                                                                   \
+        return do_fp_2sh(s, a, FUNC);                                   \
+    }
+
+DO_FP_2SH(VCVT_SF, gen_helper_vfp_sltos)
+DO_FP_2SH(VCVT_UF, gen_helper_vfp_ultos)
+DO_FP_2SH(VCVT_FS, gen_helper_vfp_tosls_round_to_zero)
+DO_FP_2SH(VCVT_FU, gen_helper_vfp_touls_round_to_zero)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ef39c89f10a..9cc44e6258e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5193,7 +5193,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int q;
     int rd, rn, rm, rd_ofs, rn_ofs, rm_ofs;
     int size;
-    int shift;
     int pass;
     int u;
     int vec_size;
@@ -5234,78 +5233,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         return 1;
     } else if (insn & (1 << 4)) {
         if ((insn & 0x00380080) != 0) {
-            /* Two registers and shift.  */
-            op = (insn >> 8) & 0xf;
-
-            switch (op) {
-            case 0: /* VSHR */
-            case 1: /* VSRA */
-            case 2: /* VRSHR */
-            case 3: /* VRSRA */
-            case 4: /* VSRI */
-            case 5: /* VSHL, VSLI */
-            case 6: /* VQSHLU */
-            case 7: /* VQSHL */
-            case 8: /* VSHRN, VRSHRN, VQSHRUN, VQRSHRUN */
-            case 9: /* VQSHRN, VQRSHRN */
-            case 10: /* VSHLL, including VMOVL */
-                return 1; /* handled by decodetree */
-            default:
-                break;
-            }
-
-            if (insn & (1 << 7)) {
-                /* 64-bit shift. */
-                if (op > 7) {
-                    return 1;
-                }
-                size = 3;
-            } else {
-                size = 2;
-                while ((insn & (1 << (size + 19))) == 0)
-                    size--;
-            }
-            shift = (insn >> 16) & ((1 << (3 + size)) - 1);
-            if (op >= 14) {
-                /* VCVT fixed-point.  */
-                TCGv_ptr fpst;
-                TCGv_i32 shiftv;
-                VFPGenFixPointFn *fn;
-
-                if (!(insn & (1 << 21)) || (q && ((rd | rm) & 1))) {
-                    return 1;
-                }
-
-                if (!(op & 1)) {
-                    if (u) {
-                        fn = gen_helper_vfp_ultos;
-                    } else {
-                        fn = gen_helper_vfp_sltos;
-                    }
-                } else {
-                    if (u) {
-                        fn = gen_helper_vfp_touls_round_to_zero;
-                    } else {
-                        fn = gen_helper_vfp_tosls_round_to_zero;
-                    }
-                }
-
-                /* We have already masked out the must-be-1 top bit of imm6,
-                 * hence this 32-shift where the ARM ARM has 64-imm6.
-                 */
-                shift = 32 - shift;
-                fpst = get_fpstatus_ptr(1);
-                shiftv = tcg_const_i32(shift);
-                for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                    TCGv_i32 tmpf = neon_load_reg(rm, pass);
-                    fn(tmpf, tmpf, shiftv, fpst);
-                    neon_store_reg(rd, pass, tmpf);
-                }
-                tcg_temp_free_ptr(fpst);
-                tcg_temp_free_i32(shiftv);
-            } else {
-                return 1;
-            }
+            /* Two registers and shift: handled by decodetree */
+            return 1;
         } else { /* (insn & 0x00380080) == 0 */
             int invert, reg_ofs, vec_size;
 
-- 
2.20.1


