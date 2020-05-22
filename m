Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C8B205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utNuzSh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C8B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc97f-0007fp-HT
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc958-00023L-KB
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc957-0006Rh-2u
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id z4so8914765wmi.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4rtc+4OzXXy8odEDC6muCMK1fkclsdZsWvhdDDk5nks=;
 b=utNuzSh09XJ98KnwYjwhqFLFo7y/qYR056aCa1kHmUzEC8dGOsCAXcZZLj5YknNIL5
 9LgmzRR3Xh9cmNXJL5SKtx628M1lUzJRbBqYI2akgxAuEHKY1N+6yKVmMZIPz5oSBx1c
 lRwtvxq6GBsW6dh5TqrPR8DumxMPzlAYX+AChrHv2iqgw50lCF+zvHVCkjqAu75J/BCx
 mHMOznH+SAG5ecgHtZ/2U8p0iqWBFXMEsq5TKaQMZOaqHgKlIRz0OLCPJuLj8lqOxljb
 pmKiWmRMnc0o+jAmxtDZ+5IfeV3787k8gWwboMKMoMAeyIwmphvn2k9A4SAmxy577dLg
 Yhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4rtc+4OzXXy8odEDC6muCMK1fkclsdZsWvhdDDk5nks=;
 b=bS2Rzy/R9swJt78xfWVm8lJzoFnVA17fMMgaL00yrsc38qlarp8zp3LhLEVZXMdB/t
 f3Kvq7i+GSvuvYrib2pJiWUFkM7xA7ncftKjSTN+/1BSIyrd74uCjfIXx9D1e1nsyoHO
 lmTeo9704Uh4MyxgpLqQcPcFkFtGscExDUYMklbQEFDFIelKEq54lUyZDAnujtot9d5+
 k7vH112TUUiExid0yyc3+lrV4VsYKM4fasiSsm6+sAi0lDf/nl4LL/5F3oMxcrNlvw3E
 ARZJD8fKL02y0tdz+fH9eWMxL/qtNrMcRTWJXLL3VUNFTpgOClkdE70Q/wMF7XrxPrRd
 s/yA==
X-Gm-Message-State: AOAM533Lmph4tPp2CLpn66xENyUhGIeuLpKiXqZaeIf9qPtXkuCd6B/Z
 SmYmHUH2Hol4csSYlNimdazuf61a7QKzQQ==
X-Google-Smtp-Source: ABdhPJxd5UBifsd195GjM2J1JdQRXAKgJJPPJtFWkar7FpHuU81rgN+xlW8vcJsiljyJfYtTf5msYg==
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr13194961wmc.72.1590159327615; 
 Fri, 22 May 2020 07:55:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y8sm1100561wmc.37.2020.05.22.07.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:55:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] target/arm: Convert VQSHLU,
 VQSHL 2-reg-shift insns to decodetree
Date: Fri, 22 May 2020 15:55:15 +0100
Message-Id: <20200522145520.6778-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
References: <20200522145520.6778-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

Convert the VQSHLU and QVSHL 2-reg-shift insns to decodetree.
These are the last of the simple shift-by-immediate insns.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  15 +++++
 target/arm/translate-neon.inc.c | 108 +++++++++++++++++++++++++++++++
 target/arm/translate.c          | 110 +-------------------------------
 3 files changed, 126 insertions(+), 107 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index d99a07b16d4..f9183060a51 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -284,3 +284,18 @@ VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_b
+
+VQSHLU_64_2sh    1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_d
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_s
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_h
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_b
+
+VQSHL_S_64_2sh   1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
+
+VQSHL_U_64_2sh   1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index f4d42683aea..396db55565f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1396,3 +1396,111 @@ static bool trans_VSHR_U_2sh(DisasContext *s, arg_2reg_shift *a)
         return do_vector_2sh(s, a, tcg_gen_gvec_shri);
     }
 }
+
+static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
+                             NeonGenTwo64OpEnvFn *fn)
+{
+    /*
+     * 2-reg-and-shift operations, size == 3 case, where the
+     * function needs to be passed cpu_env.
+     */
+    TCGv_i64 constimm;
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
+    /*
+     * To avoid excessive duplication of ops we implement shift
+     * by immediate using the variable shift operations.
+     */
+    constimm = tcg_const_i64(dup_const(a->size, a->shift));
+
+    for (pass = 0; pass < a->q + 1; pass++) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+
+        neon_load_reg64(tmp, a->vm + pass);
+        fn(tmp, cpu_env, tmp, constimm);
+        neon_store_reg64(tmp, a->vd + pass);
+    }
+    tcg_temp_free_i64(constimm);
+    return true;
+}
+
+static bool do_2shift_env_32(DisasContext *s, arg_2reg_shift *a,
+                             NeonGenTwoOpEnvFn *fn)
+{
+    /*
+     * 2-reg-and-shift operations, size < 3 case, where the
+     * helper needs to be passed cpu_env.
+     */
+    TCGv_i32 constimm;
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
+    /*
+     * To avoid excessive duplication of ops we implement shift
+     * by immediate using the variable shift operations.
+     */
+    constimm = tcg_const_i32(dup_const(a->size, a->shift));
+
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        fn(tmp, cpu_env, tmp, constimm);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    tcg_temp_free_i32(constimm);
+    return true;
+}
+
+#define DO_2SHIFT_ENV(INSN, FUNC)                                       \
+    static bool trans_##INSN##_64_2sh(DisasContext *s, arg_2reg_shift *a) \
+    {                                                                   \
+        return do_2shift_env_64(s, a, gen_helper_neon_##FUNC##64);      \
+    }                                                                   \
+    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
+    {                                                                   \
+        static NeonGenTwoOpEnvFn * const fns[] = {                      \
+            gen_helper_neon_##FUNC##8,                                  \
+            gen_helper_neon_##FUNC##16,                                 \
+            gen_helper_neon_##FUNC##32,                                 \
+        };                                                              \
+        assert(a->size < ARRAY_SIZE(fns));                              \
+        return do_2shift_env_32(s, a, fns[a->size]);                    \
+    }
+
+DO_2SHIFT_ENV(VQSHLU, qshlu_s)
+DO_2SHIFT_ENV(VQSHL_U, qshl_u)
+DO_2SHIFT_ENV(VQSHL_S, qshl_s)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4a55986aad9..d711d39eb9d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3011,29 +3011,6 @@ static inline void gen_neon_rsb(int size, TCGv_i32 t0, TCGv_i32 t1)
     }
 }
 
-#define GEN_NEON_INTEGER_OP_ENV(name) do { \
-    switch ((size << 1) | u) { \
-    case 0: \
-        gen_helper_neon_##name##_s8(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 1: \
-        gen_helper_neon_##name##_u8(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 2: \
-        gen_helper_neon_##name##_s16(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 3: \
-        gen_helper_neon_##name##_u16(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 4: \
-        gen_helper_neon_##name##_s32(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 5: \
-        gen_helper_neon_##name##_u32(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    default: return 1; \
-    }} while (0)
-
 static TCGv_i32 neon_load_scratch(int scratch)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -5252,7 +5229,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int size;
     int shift;
     int pass;
-    int count;
     int u;
     int vec_size;
     uint32_t imm;
@@ -5302,6 +5278,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             case 3: /* VRSRA */
             case 4: /* VSRI */
             case 5: /* VSHL, VSLI */
+            case 6: /* VQSHLU */
+            case 7: /* VQSHL */
                 return 1; /* handled by decodetree */
             default:
                 break;
@@ -5319,89 +5297,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     size--;
             }
             shift = (insn >> 16) & ((1 << (3 + size)) - 1);
-            if (op < 8) {
-                /* Shift by immediate:
-                   VSHR, VSRA, VRSHR, VRSRA, VSRI, VSHL, VQSHL, VQSHLU.  */
-                if (q && ((rd | rm) & 1)) {
-                    return 1;
-                }
-                if (!u && (op == 4 || op == 6)) {
-                    return 1;
-                }
-                /* Right shifts are encoded as N - shift, where N is the
-                   element size in bits.  */
-                if (op <= 4) {
-                    shift = shift - (1 << (size + 3));
-                }
-
-                if (size == 3) {
-                    count = q + 1;
-                } else {
-                    count = q ? 4: 2;
-                }
-
-                /* To avoid excessive duplication of ops we implement shift
-                 * by immediate using the variable shift operations.
-                  */
-                imm = dup_const(size, shift);
-
-                for (pass = 0; pass < count; pass++) {
-                    if (size == 3) {
-                        neon_load_reg64(cpu_V0, rm + pass);
-                        tcg_gen_movi_i64(cpu_V1, imm);
-                        switch (op) {
-                        case 6: /* VQSHLU */
-                            gen_helper_neon_qshlu_s64(cpu_V0, cpu_env,
-                                                      cpu_V0, cpu_V1);
-                            break;
-                        case 7: /* VQSHL */
-                            if (u) {
-                                gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
-                                                         cpu_V0, cpu_V1);
-                            } else {
-                                gen_helper_neon_qshl_s64(cpu_V0, cpu_env,
-                                                         cpu_V0, cpu_V1);
-                            }
-                            break;
-                        default:
-                            g_assert_not_reached();
-                        }
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    } else { /* size < 3 */
-                        /* Operands in T0 and T1.  */
-                        tmp = neon_load_reg(rm, pass);
-                        tmp2 = tcg_temp_new_i32();
-                        tcg_gen_movi_i32(tmp2, imm);
-                        switch (op) {
-                        case 6: /* VQSHLU */
-                            switch (size) {
-                            case 0:
-                                gen_helper_neon_qshlu_s8(tmp, cpu_env,
-                                                         tmp, tmp2);
-                                break;
-                            case 1:
-                                gen_helper_neon_qshlu_s16(tmp, cpu_env,
-                                                          tmp, tmp2);
-                                break;
-                            case 2:
-                                gen_helper_neon_qshlu_s32(tmp, cpu_env,
-                                                          tmp, tmp2);
-                                break;
-                            default:
-                                abort();
-                            }
-                            break;
-                        case 7: /* VQSHL */
-                            GEN_NEON_INTEGER_OP_ENV(qshl);
-                            break;
-                        default:
-                            g_assert_not_reached();
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        neon_store_reg(rd, pass, tmp);
-                    }
-                } /* for pass */
-            } else if (op < 10) {
+            if (op < 10) {
                 /* Shift by immediate and narrow:
                    VSHRN, VRSHRN, VQSHRN, VQRSHRN.  */
                 int input_unsigned = (op == 8) ? !u : u;
-- 
2.20.1


