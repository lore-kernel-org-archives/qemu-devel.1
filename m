Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F459C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DDB2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i9/CwI4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DDB2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBLo-0008BW-Li
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvp-0004BQ-Qb
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvm-0005uS-SC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id z3so853352pfn.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1G8zWKyeVAzloRYKwSZXE73uroL9SBK5gG0F+v5JF8U=;
 b=i9/CwI4dnj+LmS2HEZ4hqYgKJIm2skkYUFYEMTHswNFapBfDCAHWhyl2UkVzOI2Kpb
 WqS62HFdt+hUH1DYlcd+HWT3Ka3HS4C5UF9wqemsZP0xD6+uKFfBfO4IpA34kdtw+2+A
 nnyzQUEUhMCK/QhiTOFrdTppmPxrEge1qPtdUtCUKNUxnKVLVyZ/8XKymleyZ8/RxHPM
 JcxX9oD/iImGE4rLjs+iFxpApXhqP7Z38cQMyb6c/f9vi0v9Vf3w11t6yQDVB/s7TyNO
 BrMuzS38p3p6knlYc62Nic8QjeIXxZAaec5kUACUIGWuWHMKrFBIAWGFpxKqSTlYw41e
 NQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1G8zWKyeVAzloRYKwSZXE73uroL9SBK5gG0F+v5JF8U=;
 b=Dgk6YUhfCqHkWbqdBtjoITr02mEQAlHEtLe5QusVDjnUTjdX3R3sbFR7YyJAZvEiL/
 326SsvTSx75sH+3aF8Yzhu4c5Ocj/KOgrApsZfB/YRuhgIaHZdq4FlmT/XdsSidy1/z3
 S1W/qwcc9ka5gNkuaM4gSuvtkJvFoCrAivN1kcZTOtW4PE26ggM0U5pbPRbuusumqSaa
 H9qDFU+LmZySzdtdyRInakpCjNVjgCavy7yl3Zgkj5q2l53PTF2uPocdPtpSCoPQd37k
 O017oD4CUpxxTxjTqCwP34RV2FlBUXWeAG+Laa2pbyUCDB9j9QRS0YtVjNNGBFTWPu66
 yBpg==
X-Gm-Message-State: AOAM530Jv/tpVvNMMnQfS10HtgUl1s5CiQ2b7EXyfyyJqZyOBRQYm5Ro
 kYx3v4KgUA4GbwExcWGaCQcwy2nSYqs=
X-Google-Smtp-Source: ABdhPJxrldAW5G52ywd68BYsVLHUQ6vg6pMeJ5XYaZWKoXDEIS1kcvydPT/a1FCMzRSDj1/5+5rv7A==
X-Received: by 2002:aa7:92d7:: with SMTP id k23mr29329762pfa.189.1595409653330; 
 Wed, 22 Jul 2020 02:20:53 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 46/76] target/riscv: rvv-0.9: integer
 add-with-carry/subtract-with-borrow
Date: Wed, 22 Jul 2020 17:16:09 +0800
Message-Id: <20200722091641.8834-47-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x443.google.com
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Clear tail elements only if VTA is agnostic.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              | 20 +++++-----
 target/riscv/insn_trans/trans_rvv.inc.c |  2 +-
 target/riscv/vector_helper.c            | 50 ++++++++++++++-----------
 3 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0521ca4ab4..481f909d47 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -324,16 +324,16 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
 vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
 vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
 vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
-vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r_vm_1
-vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r_vm_1
-vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_1
+vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_1
+vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
+vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
+vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
+vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_1
+vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
+vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
 vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3998011ef7..45853812f7 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1806,7 +1806,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
 
 /*
  * For vadc and vsbc, an illegal instruction exception is raised if the
- * destination vector register is v0 and LMUL > 1. (Section 12.3)
+ * destination vector register is v0 and LMUL > 1. (Section 12.4)
  */
 static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index aa940080a7..95248238df 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1316,24 +1316,28 @@ GEN_VEXT_VADC_VXM(vsbc_vxm_d, uint64_t, H8, DO_VSBC, clearq)
                           (__typeof(N))(N + M) < N)
 #define DO_MSBC(N, M, C) (C ? N <= M : N < M)
 
-#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)             \
-void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
-                  CPURISCVState *env, uint32_t desc)          \
-{                                                             \
-    uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
-    uint32_t i;                                               \
-                                                              \
-    for (i = 0; i < vl; i++) {                                \
-        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
-        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        uint8_t carry = vext_elem_mask(v0, i);                \
-                                                              \
-        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));      \
-    }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
+#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    uint32_t vl = env->vl;                                      \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
+    uint32_t vm = vext_vm(desc);                                \
+    uint32_t vta = vext_vta(desc);                              \
+    uint32_t i;                                                 \
+                                                                \
+    for (i = 0; i < vl; i++) {                                  \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
+        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;        \
+                                                                \
+        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));        \
+    }                                                           \
+    if (vta == 1) {                                             \
+        for (; i < vlmax; i++) {                                \
+            vext_set_elem_mask(vd, i, 1);                       \
+        }                                                       \
+    }                                                           \
 }
 
 GEN_VEXT_VMADC_VVM(vmadc_vvm_b, uint8_t,  H1, DO_MADC)
@@ -1352,17 +1356,21 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
 {                                                               \
     uint32_t vl = env->vl;                                      \
     uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
+    uint32_t vm = vext_vm(desc);                                \
+    uint32_t vta = vext_vta(desc);                              \
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
-        uint8_t carry = vext_elem_mask(v0, i);                  \
+        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;         \
                                                                 \
         vext_set_elem_mask(vd, i,                               \
                 DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
     }                                                           \
-    for (; i < vlmax; i++) {                                    \
-        vext_set_elem_mask(vd, i, 0);                           \
+    if (vta == 1) {                                             \
+        for (; i < vlmax; i++) {                                \
+            vext_set_elem_mask(vd, i, 1);                       \
+        }                                                       \
     }                                                           \
 }
 
-- 
2.17.1


