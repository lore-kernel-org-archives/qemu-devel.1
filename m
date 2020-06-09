Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5865C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9126320760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Di5tjZLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigmc-0000l6-HU
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighh-0003Ld-M7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighd-0003QO-C1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:21 -0400
Received: by mail-wr1-x430.google.com with SMTP id c3so21894310wru.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8uhbH3R8ttA4y5SJ7ktopOo31UwAu136Rzv9dXmwq14=;
 b=Di5tjZLrOvFmYYA7v0V6R8YENuHksKXXYIalyPW3T5LHtkQw+a2phw8yYWsQKIh+ty
 RcXjsJLG2npTGSKMMIDNWtZA3t1hIS8XO9Fz6GBVClIJe7p1m3QUmspb0ysdHhY92Clu
 b7W0zDRzRdw/Xi6mRajwTMfUzfq6LzqVnW6YuXfFAGnQBE2K0kUXUHsoWu/pIcJJWIDA
 sTZpuDeVPh7tzSfyJPOu1ij1f9Oak9uZfRPoWiSxXc/IcmDl8r8e8cKbGx2AzMvgkRUa
 S80Qe6TclGQZobzf/qRW7zNOexBec3GMyhN27J7HbZVorgn3BrENfDBXuwxk2pX25mxi
 QkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8uhbH3R8ttA4y5SJ7ktopOo31UwAu136Rzv9dXmwq14=;
 b=mXbHTnaVyNIQ/00fXThZAyNHn59GeLO71kSRU28iJkhfW3CH/XDXR3LlAuCqt3QSAV
 m4m+0pNdZBMSV9/fPKhe7KDgb34V4hm5k5BrhOqC0Ozh3jbYmwHyi/5DYzEKfcUPXLci
 c4+JnK+DFMiagUlW3fjGHbE1HXDgjWvfavovvJg910nvbFEWmlKSgz7Bq23Idb+4/8GO
 yvjBNOl0TDydea7NUT9EeHGI/au15U0I8Zg5ruQr/5sOs56h+fSaKqfaEdEy13tKdRGN
 t7sqx8gS83g8wKVSwBp/jC2im4OllpY7mOYyoel+0TFDdNjOwt4m0e1MKMa953ufvbMR
 HXNg==
X-Gm-Message-State: AOAM5310ucT9/ZvP94bh7jlYJWP2E7Flm1Zmu3tr2OlHr813GJ2dGuk+
 e2S2Z3xwhsT8MXYPL0uyUk3wXEqaKF7qzg==
X-Google-Smtp-Source: ABdhPJxUzbXkubiEr0Y5kEQaepcBR0/VnH8NzkUF85PmQbDFtKLWj+nweYb1F1z1cbhRoEMgC7VeRw==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr5408891wrh.308.1591718535121; 
 Tue, 09 Jun 2020 09:02:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b81sm3699867wmc.5.2020.06.09.09.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:02:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/arm: Convert Neon 3-reg-diff prewidening ops to
 decodetree
Date: Tue,  9 Jun 2020 17:02:04 +0100
Message-Id: <20200609160209.29960-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
References: <20200609160209.29960-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Convert the "pre-widening" insns VADDL, VSUBL, VADDW and VSUBW
in the Neon 3-registers-different-lengths group to decodetree.
These insns work by widening one or both inputs to double their
size, performing an add or subtract at the doubled size and
then storing the double-size result.

As usual, rather than copying the loop of the original decoder
(which needs awkward code to avoid problems when source and
destination registers overlap) we just unroll the two passes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 299a61f067b..f0ec13e5a91 100644
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
+        NeonGenWidenFn *widenfn[] = {                                   \
+            gen_helper_neon_widen_##S##8,                               \
+            gen_helper_neon_widen_##S##16,                              \
+            tcg_gen_##EXT##_i32_i64,                                    \
+            NULL,                                                       \
+        };                                                              \
+        NeonGenTwo64OpFn *addfn[] = {                                   \
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


