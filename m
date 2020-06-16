Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A247C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052432071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWsHFEF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052432071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8M7-0000DB-2V
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LA-00071f-MT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L8-000410-NN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so2407459wmi.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XoxCS62N7eX7NGCDKheRHVWchm2Ywp/u4RIaWwix4t4=;
 b=fWsHFEF5RlyKvijNXpgeyXJEaMlmS7OVuDdagMPFWRToc3piA/lnqdgRJc3VuEp9Rv
 t2nt8guw/Vh0VUhp0iX8JTV1IgW80ohPSMTGTulwuI5sa57uOlcNoPioC6fRHZTCcbF0
 D0jnkl8dh42bHIhUGyOzkq/l2YSqTUws+2Bt6nfbv1HME3uKxM3ELTwEtUIRBrIBuAic
 haIj+Y2reA7j+TlOcF2noi0fV3WF+7M1uIRfidpqhWwWKjrV0lMXOnKW6996RQzmhF71
 skqLZtuImZlp5a96+6uppVtvGynltYxwaEspyY7L1y0eT9zyktCn37Tn7jqklb8J6174
 VJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XoxCS62N7eX7NGCDKheRHVWchm2Ywp/u4RIaWwix4t4=;
 b=hxAWb5SZd88rppDGAVe4b2ocB9moD9HkbTAlPD2/8LA6ua74twZ7Ekwe35hgABDEWU
 UWGuGwDEZ19+agQMJCEmXaIzWzIsLCmNYH/VWr18niLiF57r4ExYTmaopCyrrxHj9puF
 pVBhYLnUZE8MGqCNA8agObtR71IQHbFUm+y0Qlei6ADBfGbhx9R61O2zy7DqjTFu2Ybk
 V6srmM5K+Xq326wFeNi5bZmBi8GJBc7yQik5+cNo9f8XT3Ljblq0AhtUsc8YqU/D7pwK
 IdkA+iPxXhXVw6v28uD5N6L82GyzeMmwPuNJWpx0qQagHv+FeabE+iTvXXdT/g/o2bcJ
 qAig==
X-Gm-Message-State: AOAM532QWsaQnPHO9qj+P0gjW0xVh2RmMr3GcaGwAewvG6ZhvsrkqhkP
 U4xOre5I851JWEhjj/x0z2gmdXGa95NYfg==
X-Google-Smtp-Source: ABdhPJxW7d309XdkDbpep6bGXZoP3HcJFVjCtfYrg+wovjIsi/VfBbZ9F5Pvtwdc45ozr2cXM3xdxA==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr2357963wmh.8.1592301428888;
 Tue, 16 Jun 2020 02:57:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] target/arm: Convert Neon 3-reg-diff narrowing ops to
 decodetree
Date: Tue, 16 Jun 2020 10:56:42 +0100
Message-Id: <20200616095702.25848-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
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

Convert the narrow-to-high-half insns VADDHN, VSUBHN, VRADDHN,
VRSUBHN in the Neon 3-registers-different-lengths group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  6 +++
 target/arm/translate-neon.inc.c | 87 +++++++++++++++++++++++++++++++
 target/arm/translate.c          | 91 ++++-----------------------------
 3 files changed, 104 insertions(+), 80 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 144a527ee65..a2234dfa4f3 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -438,5 +438,11 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VSUBW_S_3d   1111 001 0 1 . .. .... .... 0011 . 0 . 0 .... @3diff
     VSUBW_U_3d   1111 001 1 1 . .. .... .... 0011 . 0 . 0 .... @3diff
+
+    VADDHN_3d    1111 001 0 1 . .. .... .... 0100 . 0 . 0 .... @3diff
+    VRADDHN_3d   1111 001 1 1 . .. .... .... 0100 . 0 . 0 .... @3diff
+
+    VSUBHN_3d    1111 001 0 1 . .. .... .... 0110 . 0 . 0 .... @3diff
+    VRSUBHN_3d   1111 001 1 1 . .. .... .... 0110 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 9b9d4111077..0c3965802a5 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1932,3 +1932,90 @@ DO_PREWIDEN(VADDW_S, s, ext, add, true)
 DO_PREWIDEN(VADDW_U, u, extu, add, true)
 DO_PREWIDEN(VSUBW_S, s, ext, sub, true)
 DO_PREWIDEN(VSUBW_U, u, extu, sub, true)
+
+static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
+                         NeonGenTwo64OpFn *opfn, NeonGenNarrowFn *narrowfn)
+{
+    /* 3-regs different lengths, narrowing (VADDHN/VSUBHN/VRADDHN/VRSUBHN) */
+    TCGv_i64 rn_64, rm_64;
+    TCGv_i32 rd0, rd1;
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
+    if (!opfn || !narrowfn) {
+        /* size == 3 case, which is an entirely different insn group */
+        return false;
+    }
+
+    if ((a->vn | a->vm) & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rn_64 = tcg_temp_new_i64();
+    rm_64 = tcg_temp_new_i64();
+    rd0 = tcg_temp_new_i32();
+    rd1 = tcg_temp_new_i32();
+
+    neon_load_reg64(rn_64, a->vn);
+    neon_load_reg64(rm_64, a->vm);
+
+    opfn(rn_64, rn_64, rm_64);
+
+    narrowfn(rd0, rn_64);
+
+    neon_load_reg64(rn_64, a->vn + 1);
+    neon_load_reg64(rm_64, a->vm + 1);
+
+    opfn(rn_64, rn_64, rm_64);
+
+    narrowfn(rd1, rn_64);
+
+    neon_store_reg(a->vd, 0, rd0);
+    neon_store_reg(a->vd, 1, rd1);
+
+    tcg_temp_free_i64(rn_64);
+    tcg_temp_free_i64(rm_64);
+
+    return true;
+}
+
+#define DO_NARROW_3D(INSN, OP, NARROWTYPE, EXTOP)                       \
+    static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
+    {                                                                   \
+        static NeonGenTwo64OpFn * const addfn[] = {                     \
+            gen_helper_neon_##OP##l_u16,                                \
+            gen_helper_neon_##OP##l_u32,                                \
+            tcg_gen_##OP##_i64,                                         \
+            NULL,                                                       \
+        };                                                              \
+        static NeonGenNarrowFn * const narrowfn[] = {                   \
+            gen_helper_neon_##NARROWTYPE##_high_u8,                     \
+            gen_helper_neon_##NARROWTYPE##_high_u16,                    \
+            EXTOP,                                                      \
+            NULL,                                                       \
+        };                                                              \
+        return do_narrow_3d(s, a, addfn[a->size], narrowfn[a->size]);   \
+    }
+
+static void gen_narrow_round_high_u32(TCGv_i32 rd, TCGv_i64 rn)
+{
+    tcg_gen_addi_i64(rn, rn, 1u << 31);
+    tcg_gen_extrh_i64_i32(rd, rn);
+}
+
+DO_NARROW_3D(VADDHN, add, narrow, tcg_gen_extrh_i64_i32)
+DO_NARROW_3D(VSUBHN, sub, narrow, tcg_gen_extrh_i64_i32)
+DO_NARROW_3D(VRADDHN, add, narrow_round, gen_narrow_round_high_u32)
+DO_NARROW_3D(VRSUBHN, sub, narrow_round, gen_narrow_round_high_u32)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 93765344414..3fe39cd4f49 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3231,16 +3231,6 @@ static inline void gen_neon_addl(int size)
     }
 }
 
-static inline void gen_neon_subl(int size)
-{
-    switch (size) {
-    case 0: gen_helper_neon_subl_u16(CPU_V001); break;
-    case 1: gen_helper_neon_subl_u32(CPU_V001); break;
-    case 2: tcg_gen_sub_i64(CPU_V001); break;
-    default: abort();
-    }
-}
-
 static inline void gen_neon_negl(TCGv_i64 var, int size)
 {
     switch (size) {
@@ -5239,8 +5229,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             op = (insn >> 8) & 0xf;
             if ((insn & (1 << 6)) == 0) {
                 /* Three registers of different lengths.  */
-                int src1_wide;
-                int src2_wide;
                 /* undefreq: bit 0 : UNDEF if size == 0
                  *           bit 1 : UNDEF if size == 1
                  *           bit 2 : UNDEF if size == 2
@@ -5254,9 +5242,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VADDW: handled by decodetree */
                     {0, 0, 0, 7}, /* VSUBL: handled by decodetree */
                     {0, 0, 0, 7}, /* VSUBW: handled by decodetree */
-                    {0, 1, 1, 0}, /* VADDHN */
+                    {0, 0, 0, 7}, /* VADDHN: handled by decodetree */
                     {0, 0, 0, 0}, /* VABAL */
-                    {0, 1, 1, 0}, /* VSUBHN */
+                    {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
                     {0, 0, 0, 0}, /* VABDL */
                     {0, 0, 0, 0}, /* VMLAL */
                     {0, 0, 0, 9}, /* VQDMLAL */
@@ -5268,17 +5256,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
                 };
 
-                src1_wide = neon_3reg_wide[op][1];
-                src2_wide = neon_3reg_wide[op][2];
                 undefreq = neon_3reg_wide[op][3];
 
                 if ((undefreq & (1 << size)) ||
                     ((undefreq & 8) && u)) {
                     return 1;
                 }
-                if ((src1_wide && (rn & 1)) ||
-                    (src2_wide && (rm & 1)) ||
-                    (!src2_wide && (rd & 1))) {
+                if (rd & 1) {
                     return 1;
                 }
 
@@ -5302,42 +5286,26 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 /* Avoid overlapping operands.  Wide source operands are
                    always aligned so will never overlap with wide
                    destinations in problematic ways.  */
-                if (rd == rm && !src2_wide) {
+                if (rd == rm) {
                     tmp = neon_load_reg(rm, 1);
                     neon_store_scratch(2, tmp);
-                } else if (rd == rn && !src1_wide) {
+                } else if (rd == rn) {
                     tmp = neon_load_reg(rn, 1);
                     neon_store_scratch(2, tmp);
                 }
                 tmp3 = NULL;
                 for (pass = 0; pass < 2; pass++) {
-                    if (src1_wide) {
-                        neon_load_reg64(cpu_V0, rn + pass);
-                        tmp = NULL;
+                    if (pass == 1 && rd == rn) {
+                        tmp = neon_load_scratch(2);
                     } else {
-                        if (pass == 1 && rd == rn) {
-                            tmp = neon_load_scratch(2);
-                        } else {
-                            tmp = neon_load_reg(rn, pass);
-                        }
+                        tmp = neon_load_reg(rn, pass);
                     }
-                    if (src2_wide) {
-                        neon_load_reg64(cpu_V1, rm + pass);
-                        tmp2 = NULL;
+                    if (pass == 1 && rd == rm) {
+                        tmp2 = neon_load_scratch(2);
                     } else {
-                        if (pass == 1 && rd == rm) {
-                            tmp2 = neon_load_scratch(2);
-                        } else {
-                            tmp2 = neon_load_reg(rm, pass);
-                        }
+                        tmp2 = neon_load_reg(rm, pass);
                     }
                     switch (op) {
-                    case 0: case 1: case 4: /* VADDL, VADDW, VADDHN, VRADDHN */
-                        gen_neon_addl(size);
-                        break;
-                    case 2: case 3: case 6: /* VSUBL, VSUBW, VSUBHN, VRSUBHN */
-                        gen_neon_subl(size);
-                        break;
                     case 5: case 7: /* VABAL, VABDL */
                         switch ((size << 1) | u) {
                         case 0:
@@ -5395,43 +5363,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             abort();
                         }
                         neon_store_reg64(cpu_V0, rd + pass);
-                    } else if (op == 4 || op == 6) {
-                        /* Narrowing operation.  */
-                        tmp = tcg_temp_new_i32();
-                        if (!u) {
-                            switch (size) {
-                            case 0:
-                                gen_helper_neon_narrow_high_u8(tmp, cpu_V0);
-                                break;
-                            case 1:
-                                gen_helper_neon_narrow_high_u16(tmp, cpu_V0);
-                                break;
-                            case 2:
-                                tcg_gen_extrh_i64_i32(tmp, cpu_V0);
-                                break;
-                            default: abort();
-                            }
-                        } else {
-                            switch (size) {
-                            case 0:
-                                gen_helper_neon_narrow_round_high_u8(tmp, cpu_V0);
-                                break;
-                            case 1:
-                                gen_helper_neon_narrow_round_high_u16(tmp, cpu_V0);
-                                break;
-                            case 2:
-                                tcg_gen_addi_i64(cpu_V0, cpu_V0, 1u << 31);
-                                tcg_gen_extrh_i64_i32(tmp, cpu_V0);
-                                break;
-                            default: abort();
-                            }
-                        }
-                        if (pass == 0) {
-                            tmp3 = tmp;
-                        } else {
-                            neon_store_reg(rd, 0, tmp3);
-                            neon_store_reg(rd, 1, tmp);
-                        }
                     } else {
                         /* Write back the result.  */
                         neon_store_reg64(cpu_V0, rd + pass);
-- 
2.20.1


