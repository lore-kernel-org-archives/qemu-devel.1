Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0092B2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNm9eIGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0092B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLSh-0000hi-5d
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPJ-0004Jz-3g
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:45 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPH-0004c8-Du
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:44 -0400
Received: by mail-pl1-x642.google.com with SMTP id x10so56789plr.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FUfGRxc6GwZY+hIGXeIydpcbMLBkJyGMOcDJ5KEiVOE=;
 b=iNm9eIGIhykwfZUWzXVnpf9OxzuCyk9lMFV45qMF8hn68oR6yPPoPE3KWq+vWuMzZN
 IgltZqzwhicx1VcghyOA1qreVmD62CcDr2ZTZSrmEWJwEG1ydn2eRg57QVJs1rrRaiSF
 Au4AS7mSQCqS7uzvV6Iybcg2bGkYi9BgMM2klfLgT63L6exPoAs5PB+Vse5m3a4TwCXM
 wSAP8ZIEdDMU0BhMzJnYFFr6ks4XEPhIOTYFpXDEej/3dMDKYV4zoQ2VztOJ5RYp6j6O
 6SDxSXkRSy2RxBR+CVaIsGIVV+5oI1upL9GlEONA47RLrEf9qBYCZLnOxOTM2baqX1m4
 12aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FUfGRxc6GwZY+hIGXeIydpcbMLBkJyGMOcDJ5KEiVOE=;
 b=lNWBKEtVw8JPPqOPMatYWvijT5+xCsXtOc/WlwqmTuTbl/R3iv5baCvr3o2Ro01Z/A
 QGBg6jpYnmC8Vd8ieqa5QFsU2oFI7RzcwyrK00SuA3po6CbGWDx+5343xH2O+kOc+Rfe
 dooUS+2Xv37udzpDUHbWSU2fJorg1HvtXnnZo9ixRIGFVw/MRtlm0bfufJ5wYhhjpHM8
 eAMEg76/KmYAX+E1Zakt/PbNwH/6ID+iblquG46N5uCJTjHZ08VKR/xhja/4WpKyBRyz
 y3E0VUpkebce4VILvcQzyxOcrRsWpAAPdnKdYJfighZ9jYS9MUZ1edQjokX/JU1pZpFA
 q4og==
X-Gm-Message-State: AOAM5312q6DRaL0Ti9LjgPRNa8Cerqysof6UoHhXCN9jJxhH+zlWDV4h
 lKRMxFCHl9LA5p6DWid8gfiKYyT/ySo=
X-Google-Smtp-Source: ABdhPJzeUGsuIoeTfN3AaKvaO3deVf4o1frQcBPPPnuVgunzcD24SbgyaKcf/bIzE38HarmKg0NNXg==
X-Received: by 2002:a17:90a:d153:: with SMTP id t19mr10050pjw.42.1589491721560; 
 Thu, 14 May 2020 14:28:41 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm4986pjj.33.2020.05.14.14.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 14:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/arm: Split helper_crypto_sm3tt
Date: Thu, 14 May 2020 14:28:31 -0700
Message-Id: <20200514212831.31248-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514212831.31248-1-richard.henderson@linaro.org>
References: <20200514212831.31248-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than passing an opcode to a helper, fully decode the
operation at translate time.  Use clear_tail_16 to zap the
balance of the SVE register with the AdvSIMD write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  5 ++++-
 target/arm/crypto_helper.c | 24 ++++++++++++++++++------
 target/arm/translate-a64.c | 21 +++++----------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 13475ecf81..2a20c8174c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -531,7 +531,10 @@ DEF_HELPER_FLAGS_3(crypto_sha512su0, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha512su1, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(crypto_sm3tt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+DEF_HELPER_FLAGS_4(crypto_sm3tt1a, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sm3tt1b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sm3tt2a, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sm3tt2b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sm3partw1, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sm3partw2, TCG_CALL_NO_RWG,
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 636683d0f1..c76806dc8d 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -632,15 +632,14 @@ void HELPER(crypto_sm3partw2)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail_16(vd, desc);
 }
 
-void HELPER(crypto_sm3tt)(void *vd, void *vn, void *vm, uint32_t imm2,
-                          uint32_t opcode)
+static inline void QEMU_ALWAYS_INLINE
+crypto_sm3tt(uint64_t *rd, uint64_t *rn, uint64_t *rm,
+             uint32_t desc, uint32_t opcode)
 {
-    uint64_t *rd = vd;
-    uint64_t *rn = vn;
-    uint64_t *rm = vm;
     union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
     union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
     union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
+    uint32_t imm2 = simd_data(desc);
     uint32_t t;
 
     assert(imm2 < 4);
@@ -655,7 +654,7 @@ void HELPER(crypto_sm3tt)(void *vd, void *vn, void *vm, uint32_t imm2,
         /* SM3TT2B */
         t = cho(CR_ST_WORD(d, 3), CR_ST_WORD(d, 2), CR_ST_WORD(d, 1));
     } else {
-        g_assert_not_reached();
+        qemu_build_not_reached();
     }
 
     t += CR_ST_WORD(d, 0) + CR_ST_WORD(m, imm2);
@@ -680,8 +679,21 @@ void HELPER(crypto_sm3tt)(void *vd, void *vn, void *vm, uint32_t imm2,
 
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(rd, desc);
 }
 
+#define DO_SM3TT(NAME, OPCODE) \
+    void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+    { crypto_sm3tt(vd, vn, vm, desc, OPCODE); }
+
+DO_SM3TT(crypto_sm3tt1a, 0)
+DO_SM3TT(crypto_sm3tt1b, 1)
+DO_SM3TT(crypto_sm3tt2a, 2)
+DO_SM3TT(crypto_sm3tt2b, 3)
+
+#undef DO_SM3TT
+
 static uint8_t const sm4_sbox[] = {
     0xd6, 0x90, 0xe9, 0xfe, 0xcc, 0xe1, 0x3d, 0xb7,
     0x16, 0xb6, 0x14, 0xc2, 0x28, 0xfb, 0x2c, 0x05,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49ca7ac76e..9c1ebcc8e3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13861,13 +13861,15 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
  */
 static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
 {
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_crypto_sm3tt1a, gen_helper_crypto_sm3tt1b,
+        gen_helper_crypto_sm3tt2a, gen_helper_crypto_sm3tt2b,
+    };
     int opcode = extract32(insn, 10, 2);
     int imm2 = extract32(insn, 12, 2);
     int rm = extract32(insn, 16, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    TCGv_ptr tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr;
-    TCGv_i32 tcg_imm2, tcg_opcode;
 
     if (!dc_isar_feature(aa64_sm3, s)) {
         unallocated_encoding(s);
@@ -13878,20 +13880,7 @@ static void disas_crypto_three_reg_imm2(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-    tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-    tcg_rm_ptr = vec_full_reg_ptr(s, rm);
-    tcg_imm2   = tcg_const_i32(imm2);
-    tcg_opcode = tcg_const_i32(opcode);
-
-    gen_helper_crypto_sm3tt(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr, tcg_imm2,
-                            tcg_opcode);
-
-    tcg_temp_free_ptr(tcg_rd_ptr);
-    tcg_temp_free_ptr(tcg_rn_ptr);
-    tcg_temp_free_ptr(tcg_rm_ptr);
-    tcg_temp_free_i32(tcg_imm2);
-    tcg_temp_free_i32(tcg_opcode);
+    gen_gvec_op3_ool(s, true, rd, rn, rm, imm2, fns[opcode]);
 }
 
 /* C3.6 Data processing - SIMD, inc Crypto
-- 
2.20.1


