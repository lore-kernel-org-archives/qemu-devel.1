Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41120C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BB92072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lEQrMXJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BB92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bHz-0003ML-69
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asw-0002VZ-MR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:34515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asu-0005IG-1g
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id m71so7908643pfd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dcKRgf7mFROW1tRTTD8C8xi7WIslPEg+EkPEYNPMkgw=;
 b=lEQrMXJ/kY7LtwRbOIRNHuG6ECR39v78DoAWCBcJuvn74kCwqsdapMcFRk37jdRaBz
 SVDnejc8WgiOi8616/R9gIJ7ZUH2LGlMcOaGZ26p1ewxaczloMld4xuLf1y04B4ERgQB
 DXv8jN394MecAaMXwY+zg3wBMBZ98ymTibh14mreSO3uIjoCoY3TtBxuw0HkqkTSps+y
 PZUGhAwXPNZtL5YLBinxuAC4jwmTnnUveUbB7Htr14q1/AdRM3jKlUe2JyX3fOFkdIJg
 WcQbxleqin8eS06UBp7vyrd4Ofvl6xxVa283I3hVmAd64yQJlzHjh0rCUPJDLIgj8WGu
 ZA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dcKRgf7mFROW1tRTTD8C8xi7WIslPEg+EkPEYNPMkgw=;
 b=P1fqSYiG94/OtNdDeS4asD/gHKoE6nvE1hfDw4L7jWMzNNuHPPsvb3YxYFjLzCRBtg
 ECDyJlb8cIdz7nvvWzbayEcR3orBkUkVKeG3MoMCwApnPz8MfCIONDWSAXkNBhbKz/qM
 PsxF9Rk4D9u6imG3Tn+8U8J83eoE5+PwsbPaRDM5aB+DHgYXSIZBjRADPAWcq6AmbzIe
 P5MIs+BGWdJGIIdF1cnyJ6rUEsJhQ+Be0hRc0X0stAVjPiew29Ud7jrS+ErQNtD3YPmB
 OmsST4sHXOWr8ueLP996dfbtWCusMqeUbdwUlunb3fZP/h+Dg6avoFeUq+eTWLmyS28q
 cvNQ==
X-Gm-Message-State: AOAM533Cq905oZTsSJxmUCqz7gVYOGtQLS5o5QUVUX2NwCN6VBYDsmxT
 twH7HlVAhbUmAQY3mOLTWOjjEiVFY/H4jA==
X-Google-Smtp-Source: ABdhPJwSAXlG+/W6lGaYIS43qy1FuIM9rs0cEXiqFpa7pTeEFLFUN6eWsI4/JSlFqKSYnJqqI590VA==
X-Received: by 2002:a62:c5c6:: with SMTP id j189mr7688589pfg.145.1597654367127; 
 Mon, 17 Aug 2020 01:52:47 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:46 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 58/70] target/riscv: rvv-1.0: remove widening saturating
 scaled multiply-add
Date: Mon, 17 Aug 2020 16:49:43 +0800
Message-Id: <20200817084955.28793-59-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  22 ---
 target/riscv/insn32.decode              |   7 -
 target/riscv/insn_trans/trans_rvv.inc.c |   9 --
 target/riscv/vector_helper.c            | 205 ------------------------
 4 files changed, 243 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 0a21440d98d..ac655b8f274 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -747,28 +747,6 @@ DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
 
-DEF_HELPER_6(vwsmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vwsmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-
 DEF_HELPER_6(vssrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vssrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vssrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 39565ef047c..99320705cca 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -474,13 +474,6 @@ vasubu_vv       001010 . ..... ..... 010 ..... 1010111 @r_vm
 vasubu_vx       001010 . ..... ..... 110 ..... 1010111 @r_vm
 vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
 vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
-vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
-vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
-vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
-vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
-vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
-vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
-vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
 vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
 vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
 vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9c92ad62915..d3b1499c64c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2358,15 +2358,6 @@ GEN_OPIVX_TRANS(vasubu_vx,  opivx_check)
 GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
 GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
 
-/* Vector Widening Saturating Scaled Multiply-Add */
-GEN_OPIVV_WIDEN_TRANS(vwsmaccu_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwsmacc_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwsmaccsu_vv, opivv_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
-GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
-
 /* Vector Single-Width Scaling Shift Instructions */
 GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
 GEN_OPIVV_TRANS(vssra_vv, opivv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 00743cbce34..1aeb3b5e4aa 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2747,211 +2747,6 @@ GEN_VEXT_VX_RM(vsmul_vx_h, 2, 2)
 GEN_VEXT_VX_RM(vsmul_vx_w, 4, 4)
 GEN_VEXT_VX_RM(vsmul_vx_d, 8, 8)
 
-/* Vector Widening Saturating Scaled Multiply-Add */
-static inline uint16_t
-vwsmaccu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b,
-          uint16_t c)
-{
-    uint8_t round;
-    uint16_t res = (uint16_t)a * b;
-
-    round = get_round(vxrm, res, 4);
-    res   = (res >> 4) + round;
-    return saddu16(env, vxrm, c, res);
-}
-
-static inline uint32_t
-vwsmaccu16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b,
-           uint32_t c)
-{
-    uint8_t round;
-    uint32_t res = (uint32_t)a * b;
-
-    round = get_round(vxrm, res, 8);
-    res   = (res >> 8) + round;
-    return saddu32(env, vxrm, c, res);
-}
-
-static inline uint64_t
-vwsmaccu32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b,
-           uint64_t c)
-{
-    uint8_t round;
-    uint64_t res = (uint64_t)a * b;
-
-    round = get_round(vxrm, res, 16);
-    res   = (res >> 16) + round;
-    return saddu64(env, vxrm, c, res);
-}
-
-#define OPIVV3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
-static inline void                                                 \
-do_##NAME(void *vd, void *vs1, void *vs2, int i,                   \
-          CPURISCVState *env, int vxrm)                            \
-{                                                                  \
-    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
-    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
-    TD d = *((TD *)vd + HD(i));                                    \
-    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1, d);                \
-}
-
-RVVCALL(OPIVV3_RM, vwsmaccu_vv_b, WOP_UUU_B, H2, H1, H1, vwsmaccu8)
-RVVCALL(OPIVV3_RM, vwsmaccu_vv_h, WOP_UUU_H, H4, H2, H2, vwsmaccu16)
-RVVCALL(OPIVV3_RM, vwsmaccu_vv_w, WOP_UUU_W, H8, H4, H4, vwsmaccu32)
-GEN_VEXT_VV_RM(vwsmaccu_vv_b, 1, 2)
-GEN_VEXT_VV_RM(vwsmaccu_vv_h, 2, 4)
-GEN_VEXT_VV_RM(vwsmaccu_vv_w, 4, 8)
-
-#define OPIVX3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)         \
-static inline void                                                 \
-do_##NAME(void *vd, target_long s1, void *vs2, int i,              \
-          CPURISCVState *env, int vxrm)                            \
-{                                                                  \
-    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
-    TD d = *((TD *)vd + HD(i));                                    \
-    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1, d);       \
-}
-
-RVVCALL(OPIVX3_RM, vwsmaccu_vx_b, WOP_UUU_B, H2, H1, vwsmaccu8)
-RVVCALL(OPIVX3_RM, vwsmaccu_vx_h, WOP_UUU_H, H4, H2, vwsmaccu16)
-RVVCALL(OPIVX3_RM, vwsmaccu_vx_w, WOP_UUU_W, H8, H4, vwsmaccu32)
-GEN_VEXT_VX_RM(vwsmaccu_vx_b, 1, 2)
-GEN_VEXT_VX_RM(vwsmaccu_vx_h, 2, 4)
-GEN_VEXT_VX_RM(vwsmaccu_vx_w, 4, 8)
-
-static inline int16_t
-vwsmacc8(CPURISCVState *env, int vxrm, int8_t a, int8_t b, int16_t c)
-{
-    uint8_t round;
-    int16_t res = (int16_t)a * b;
-
-    round = get_round(vxrm, res, 4);
-    res   = (res >> 4) + round;
-    return sadd16(env, vxrm, c, res);
-}
-
-static inline int32_t
-vwsmacc16(CPURISCVState *env, int vxrm, int16_t a, int16_t b, int32_t c)
-{
-    uint8_t round;
-    int32_t res = (int32_t)a * b;
-
-    round = get_round(vxrm, res, 8);
-    res   = (res >> 8) + round;
-    return sadd32(env, vxrm, c, res);
-
-}
-
-static inline int64_t
-vwsmacc32(CPURISCVState *env, int vxrm, int32_t a, int32_t b, int64_t c)
-{
-    uint8_t round;
-    int64_t res = (int64_t)a * b;
-
-    round = get_round(vxrm, res, 16);
-    res   = (res >> 16) + round;
-    return sadd64(env, vxrm, c, res);
-}
-
-RVVCALL(OPIVV3_RM, vwsmacc_vv_b, WOP_SSS_B, H2, H1, H1, vwsmacc8)
-RVVCALL(OPIVV3_RM, vwsmacc_vv_h, WOP_SSS_H, H4, H2, H2, vwsmacc16)
-RVVCALL(OPIVV3_RM, vwsmacc_vv_w, WOP_SSS_W, H8, H4, H4, vwsmacc32)
-GEN_VEXT_VV_RM(vwsmacc_vv_b, 1, 2)
-GEN_VEXT_VV_RM(vwsmacc_vv_h, 2, 4)
-GEN_VEXT_VV_RM(vwsmacc_vv_w, 4, 8)
-RVVCALL(OPIVX3_RM, vwsmacc_vx_b, WOP_SSS_B, H2, H1, vwsmacc8)
-RVVCALL(OPIVX3_RM, vwsmacc_vx_h, WOP_SSS_H, H4, H2, vwsmacc16)
-RVVCALL(OPIVX3_RM, vwsmacc_vx_w, WOP_SSS_W, H8, H4, vwsmacc32)
-GEN_VEXT_VX_RM(vwsmacc_vx_b, 1, 2)
-GEN_VEXT_VX_RM(vwsmacc_vx_h, 2, 4)
-GEN_VEXT_VX_RM(vwsmacc_vx_w, 4, 8)
-
-static inline int16_t
-vwsmaccsu8(CPURISCVState *env, int vxrm, uint8_t a, int8_t b, int16_t c)
-{
-    uint8_t round;
-    int16_t res = a * (int16_t)b;
-
-    round = get_round(vxrm, res, 4);
-    res   = (res >> 4) + round;
-    return ssub16(env, vxrm, c, res);
-}
-
-static inline int32_t
-vwsmaccsu16(CPURISCVState *env, int vxrm, uint16_t a, int16_t b, uint32_t c)
-{
-    uint8_t round;
-    int32_t res = a * (int32_t)b;
-
-    round = get_round(vxrm, res, 8);
-    res   = (res >> 8) + round;
-    return ssub32(env, vxrm, c, res);
-}
-
-static inline int64_t
-vwsmaccsu32(CPURISCVState *env, int vxrm, uint32_t a, int32_t b, int64_t c)
-{
-    uint8_t round;
-    int64_t res = a * (int64_t)b;
-
-    round = get_round(vxrm, res, 16);
-    res   = (res >> 16) + round;
-    return ssub64(env, vxrm, c, res);
-}
-
-RVVCALL(OPIVV3_RM, vwsmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, vwsmaccsu8)
-RVVCALL(OPIVV3_RM, vwsmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, vwsmaccsu16)
-RVVCALL(OPIVV3_RM, vwsmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, vwsmaccsu32)
-GEN_VEXT_VV_RM(vwsmaccsu_vv_b, 1, 2)
-GEN_VEXT_VV_RM(vwsmaccsu_vv_h, 2, 4)
-GEN_VEXT_VV_RM(vwsmaccsu_vv_w, 4, 8)
-RVVCALL(OPIVX3_RM, vwsmaccsu_vx_b, WOP_SSU_B, H2, H1, vwsmaccsu8)
-RVVCALL(OPIVX3_RM, vwsmaccsu_vx_h, WOP_SSU_H, H4, H2, vwsmaccsu16)
-RVVCALL(OPIVX3_RM, vwsmaccsu_vx_w, WOP_SSU_W, H8, H4, vwsmaccsu32)
-GEN_VEXT_VX_RM(vwsmaccsu_vx_b, 1, 2)
-GEN_VEXT_VX_RM(vwsmaccsu_vx_h, 2, 4)
-GEN_VEXT_VX_RM(vwsmaccsu_vx_w, 4, 8)
-
-static inline int16_t
-vwsmaccus8(CPURISCVState *env, int vxrm, int8_t a, uint8_t b, int16_t c)
-{
-    uint8_t round;
-    int16_t res = (int16_t)a * b;
-
-    round = get_round(vxrm, res, 4);
-    res   = (res >> 4) + round;
-    return ssub16(env, vxrm, c, res);
-}
-
-static inline int32_t
-vwsmaccus16(CPURISCVState *env, int vxrm, int16_t a, uint16_t b, int32_t c)
-{
-    uint8_t round;
-    int32_t res = (int32_t)a * b;
-
-    round = get_round(vxrm, res, 8);
-    res   = (res >> 8) + round;
-    return ssub32(env, vxrm, c, res);
-}
-
-static inline int64_t
-vwsmaccus32(CPURISCVState *env, int vxrm, int32_t a, uint32_t b, int64_t c)
-{
-    uint8_t round;
-    int64_t res = (int64_t)a * b;
-
-    round = get_round(vxrm, res, 16);
-    res   = (res >> 16) + round;
-    return ssub64(env, vxrm, c, res);
-}
-
-RVVCALL(OPIVX3_RM, vwsmaccus_vx_b, WOP_SUS_B, H2, H1, vwsmaccus8)
-RVVCALL(OPIVX3_RM, vwsmaccus_vx_h, WOP_SUS_H, H4, H2, vwsmaccus16)
-RVVCALL(OPIVX3_RM, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
-GEN_VEXT_VX_RM(vwsmaccus_vx_b, 1, 2)
-GEN_VEXT_VX_RM(vwsmaccus_vx_h, 2, 4)
-GEN_VEXT_VX_RM(vwsmaccus_vx_w, 4, 8)
-
 /* Vector Single-Width Scaling Shift Instructions */
 static inline uint8_t
 vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
-- 
2.17.1


