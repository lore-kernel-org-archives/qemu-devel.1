Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2876D20767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aq+ceI8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2876D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Qd-0007P0-D6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L9-00070g-TR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L7-00040l-Rr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id x14so20093049wrp.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sAtagmRYLNeEbetzybKuDczi9NbWIDftXDYpu4Z9+Xw=;
 b=aq+ceI8T5PoOiRhpyrWyq9D8OVOPlA/+OJVHRHJ+dtoyFBlBiJwtG/vdbinw2CcAxp
 9jN9+sBvczbmjYRy5Am6GCxSuXQ4JRpDuT8PRDec4V36zE9TpDCjfCvRglhCeJsEA3VU
 I53nV1EaN0G9iMTn8maAbfK6zR4ZW3f25of7pAa8n9o3zSPQkq3xr2Z2+Gs5CAUVD/fZ
 k8bQBwt6JyKH4cRXEBrb+XaBjoDFYE6nnhD3nMjdvMHzBFmScfxEpoUquHIvB/phif2K
 rqKdMLtixgQDi5ilRqghfGgImscIZT+qElxf7yIb7uC2/8/FUDD3zPKgdq8hiVdwlr4I
 LV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sAtagmRYLNeEbetzybKuDczi9NbWIDftXDYpu4Z9+Xw=;
 b=nK/gaHqnoWjy+zFhRD9+xvE1oXLXEpPKw1PV6eqdfdiQfTSegqZieVXfRnE0NiUIZi
 ePyQY2CIVmbsYyDMsy2ILSbgy6KDaNvIMIrQe9lDpPcZM3WFzZZ6QdvOH1IiygUp6fNj
 Mg5UChXp36J8GxWD3sKgoTDxVhydAKvme5xCMfJuQQdeFr/CXK4RHsCsXwP4OeBaMA9k
 9nwuPbRRiZqsdh3i8jShsa2MWftGpHHHF2Kbj2qcM2uk0rWzPbeenT0zcJpXj9SU+j2a
 9ZU3yUiPzovEaiko7k7cVjkiX0XzRzPLf2Yz7N2U5D/L4CMS6fMxZ3iEQR4Zz7JfE4K4
 0Cpw==
X-Gm-Message-State: AOAM5312iWx07DgOwsO3BPtZMZLNcszfk10g01Dgbgq9TEVadc0tBbgS
 eCW5eevJkN6bIV/0se78+PleU36iLqq+Kg==
X-Google-Smtp-Source: ABdhPJy1+FubILM/QRgVGxDiPcasb3zhfgdG+KJ6T23jfXm6A5BJXrRcEpk6J9kW4EucqM5qp04bQw==
X-Received: by 2002:a5d:5551:: with SMTP id g17mr2080414wrw.45.1592301427775; 
 Tue, 16 Jun 2020 02:57:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] target/arm: Convert Neon 3-reg-diff prewidening ops to
 decodetree
Date: Tue, 16 Jun 2020 10:56:41 +0100
Message-Id: <20200616095702.25848-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Convert the "pre-widening" insns VADDL, VSUBL, VADDW and VSUBW
in the Neon 3-registers-different-lengths group to decodetree.
These insns work by widening one or both inputs to double their
size, performing an add or subtract at the doubled size and
then storing the double-size result.

As usual, rather than copying the loop of the original decoder
(which needs awkward code to avoid problems when source and
destination registers overlap) we just unroll the two passes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  43 +++++++++++++
 target/arm/translate-neon.inc.c | 104 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  16 ++---
 3 files changed, 151 insertions(+), 12 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index bd1b0e13f7d..144a527ee65 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -397,3 +397,46 @@ VCVT_FU_2sh      1111 001 1 1 . ...... .... 1111 0 . . 1 .... @2reg_vcvt
 # So we have a single decode line and check the cmode/op in the
 # trans function.
 Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
+
+######################################################################
+# Within the "two registers, or three registers of different lengths"
+# grouping ([23,4]=0b10), bits [21:20] are either part of the opcode
+# decode: 0b11 for VEXT, two-reg-misc, VTBL, and duplicate-scalar;
+# or they are a size field for the three-reg-different-lengths and
+# two-reg-and-scalar insn groups (where size cannot be 0b11). This
+# is slightly awkward for decodetree: we handle it with this
+# non-exclusive group which contains within it two exclusive groups:
+# one for the size=0b11 patterns, and one for the size-not-0b11
+# patterns. This allows us to check that none of the insns within
+# each subgroup accidentally overlap each other. Note that all the
+# trans functions for the size-not-0b11 patterns must check and
+# return false for size==3.
+######################################################################
+{
+  # 0b11 subgroup will go here
+
+  # Subgroup for size != 0b11
+  [
+    ##################################################################
+    # 3-reg-different-length grouping:
+    # 1111 001 U 1 D sz!=11 Vn:4 Vd:4 opc:4 N 0 M 0 Vm:4
+    ##################################################################
+
+    &3diff vm vn vd size
+
+    @3diff       .... ... . . . size:2 .... .... .... . . . . .... \
+                 &3diff vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+    VADDL_S_3d   1111 001 0 1 . .. .... .... 0000 . 0 . 0 .... @3diff
+    VADDL_U_3d   1111 001 1 1 . .. .... .... 0000 . 0 . 0 .... @3diff
+
+    VADDW_S_3d   1111 001 0 1 . .. .... .... 0001 . 0 . 0 .... @3diff
+    VADDW_U_3d   1111 001 1 1 . .. .... .... 0001 . 0 . 0 .... @3diff
+
+    VSUBL_S_3d   1111 001 0 1 . .. .... .... 0010 . 0 . 0 .... @3diff
+    VSUBL_U_3d   1111 001 1 1 . .. .... .... 0010 . 0 . 0 .... @3diff
+
+    VSUBW_S_3d   1111 001 0 1 . .. .... .... 0011 . 0 . 0 .... @3diff
+    VSUBW_U_3d   1111 001 1 1 . .. .... .... 0011 . 0 . 0 .... @3diff
+  ]
+}
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 299a61f067b..9b9d4111077 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1828,3 +1828,107 @@ static bool trans_Vimm_1r(DisasContext *s, arg_1reg_imm *a)
     }
     return do_1reg_imm(s, a, fn);
 }
+
+static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
+                           NeonGenWidenFn *widenfn,
+                           NeonGenTwo64OpFn *opfn,
+                           bool src1_wide)
+{
+    /* 3-regs different lengths, prewidening case (VADDL/VSUBL/VAADW/VSUBW) */
+    TCGv_i64 rn0_64, rn1_64, rm_64;
+    TCGv_i32 rm;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!widenfn || !opfn) {
+        /* size == 3 case, which is an entirely different insn group */
+        return false;
+    }
+
+    if ((a->vd & 1) || (src1_wide && (a->vn & 1))) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rn0_64 = tcg_temp_new_i64();
+    rn1_64 = tcg_temp_new_i64();
+    rm_64 = tcg_temp_new_i64();
+
+    if (src1_wide) {
+        neon_load_reg64(rn0_64, a->vn);
+    } else {
+        TCGv_i32 tmp = neon_load_reg(a->vn, 0);
+        widenfn(rn0_64, tmp);
+        tcg_temp_free_i32(tmp);
+    }
+    rm = neon_load_reg(a->vm, 0);
+
+    widenfn(rm_64, rm);
+    tcg_temp_free_i32(rm);
+    opfn(rn0_64, rn0_64, rm_64);
+
+    /*
+     * Load second pass inputs before storing the first pass result, to
+     * avoid incorrect results if a narrow input overlaps with the result.
+     */
+    if (src1_wide) {
+        neon_load_reg64(rn1_64, a->vn + 1);
+    } else {
+        TCGv_i32 tmp = neon_load_reg(a->vn, 1);
+        widenfn(rn1_64, tmp);
+        tcg_temp_free_i32(tmp);
+    }
+    rm = neon_load_reg(a->vm, 1);
+
+    neon_store_reg64(rn0_64, a->vd);
+
+    widenfn(rm_64, rm);
+    tcg_temp_free_i32(rm);
+    opfn(rn1_64, rn1_64, rm_64);
+    neon_store_reg64(rn1_64, a->vd + 1);
+
+    tcg_temp_free_i64(rn0_64);
+    tcg_temp_free_i64(rn1_64);
+    tcg_temp_free_i64(rm_64);
+
+    return true;
+}
+
+#define DO_PREWIDEN(INSN, S, EXT, OP, SRC1WIDE)                         \
+    static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
+    {                                                                   \
+        static NeonGenWidenFn * const widenfn[] = {                     \
+            gen_helper_neon_widen_##S##8,                               \
+            gen_helper_neon_widen_##S##16,                              \
+            tcg_gen_##EXT##_i32_i64,                                    \
+            NULL,                                                       \
+        };                                                              \
+        static NeonGenTwo64OpFn * const addfn[] = {                     \
+            gen_helper_neon_##OP##l_u16,                                \
+            gen_helper_neon_##OP##l_u32,                                \
+            tcg_gen_##OP##_i64,                                         \
+            NULL,                                                       \
+        };                                                              \
+        return do_prewiden_3d(s, a, widenfn[a->size],                   \
+                              addfn[a->size], SRC1WIDE);                \
+    }
+
+DO_PREWIDEN(VADDL_S, s, ext, add, false)
+DO_PREWIDEN(VADDL_U, u, extu, add, false)
+DO_PREWIDEN(VSUBL_S, s, ext, sub, false)
+DO_PREWIDEN(VSUBL_U, u, extu, sub, false)
+DO_PREWIDEN(VADDW_S, s, ext, add, true)
+DO_PREWIDEN(VADDW_U, u, extu, add, true)
+DO_PREWIDEN(VSUBW_S, s, ext, sub, true)
+DO_PREWIDEN(VSUBW_U, u, extu, sub, true)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index bcdfec34d28..93765344414 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5241,7 +5241,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 /* Three registers of different lengths.  */
                 int src1_wide;
                 int src2_wide;
-                int prewiden;
                 /* undefreq: bit 0 : UNDEF if size == 0
                  *           bit 1 : UNDEF if size == 1
                  *           bit 2 : UNDEF if size == 2
@@ -5251,10 +5250,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 int undefreq;
                 /* prewiden, src1_wide, src2_wide, undefreq */
                 static const int neon_3reg_wide[16][4] = {
-                    {1, 0, 0, 0}, /* VADDL */
-                    {1, 1, 0, 0}, /* VADDW */
-                    {1, 0, 0, 0}, /* VSUBL */
-                    {1, 1, 0, 0}, /* VSUBW */
+                    {0, 0, 0, 7}, /* VADDL: handled by decodetree */
+                    {0, 0, 0, 7}, /* VADDW: handled by decodetree */
+                    {0, 0, 0, 7}, /* VSUBL: handled by decodetree */
+                    {0, 0, 0, 7}, /* VSUBW: handled by decodetree */
                     {0, 1, 1, 0}, /* VADDHN */
                     {0, 0, 0, 0}, /* VABAL */
                     {0, 1, 1, 0}, /* VSUBHN */
@@ -5269,7 +5268,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
                 };
 
-                prewiden = neon_3reg_wide[op][0];
                 src1_wide = neon_3reg_wide[op][1];
                 src2_wide = neon_3reg_wide[op][2];
                 undefreq = neon_3reg_wide[op][3];
@@ -5322,9 +5320,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         } else {
                             tmp = neon_load_reg(rn, pass);
                         }
-                        if (prewiden) {
-                            gen_neon_widen(cpu_V0, tmp, size, u);
-                        }
                     }
                     if (src2_wide) {
                         neon_load_reg64(cpu_V1, rm + pass);
@@ -5335,9 +5330,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         } else {
                             tmp2 = neon_load_reg(rm, pass);
                         }
-                        if (prewiden) {
-                            gen_neon_widen(cpu_V1, tmp2, size, u);
-                        }
                     }
                     switch (op) {
                     case 0: case 1: case 4: /* VADDL, VADDW, VADDHN, VRADDHN */
-- 
2.20.1


