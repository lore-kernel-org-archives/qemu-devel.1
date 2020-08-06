Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5748CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFB4221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g7WhmYEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFB4221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3djj-0002Aq-Go
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSC-0003D8-4I
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:56 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:55713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dS7-0007vQ-Kj
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id 2so6440325pjx.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fKofpUOwGIiETrzVxOu9R2JNaVRtNujUWavem8k+IKY=;
 b=g7WhmYEG7FCVq6mR2+BbIeHxlFmKC13owltjXER8QRgUzs/uk7UiXDP052O8ueEal6
 2l2ztj9gkGF9SBurlgXdpA9MxI8Xg3N6ercd/et4fu39gDMd9mxAi/ZPSeqfCB34tXTL
 +d719JEQ39y+DfdaNfun/5A1/X5mX5QqqXQowgsT9TOW2Qo5ik4S2cxFqhBPvvutlQLR
 tPIh7mgzapV0o0VV5jkhx/NjVVFyU6qdbTEZEXCZnT/NJZKheQHbz07dnUZIZ074vPaL
 iQa1xnx58Cg3Kfh7V+5VB09weFtNWcPdfJgfPXw/0o7PaD8NR9D+jIPKEMHTk396F+a9
 GaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fKofpUOwGIiETrzVxOu9R2JNaVRtNujUWavem8k+IKY=;
 b=PVHyX/mbzkDTpjCiYWuWw4G6BE/TPzGGjDnlE1uFWN71x7PzKRdZxza/WGx4V4AUt1
 ygT5whZUfELMHzy3goJnMnZ0+VX0RXvebgvrVYQo33ClvnSsloz3IV0olSWKWVJ9kXpZ
 jxxjBvgGdTAAE36xGzZnPuQd7KoXgbrbHUC5//VY8xUUWiYYBwmy24fPP1e2cfgA8w3s
 Md8bOuW7GSYKhlMZMjt7vlWRDHCUHwNyaR3eNkCrujZp4QpMCXlJpPyeJ3SR4hRc4I72
 NB4S3VNb2l1X/nGSHGPToF/5So+xhkdnMFOk/fSLO6sCEPwTAcYf7GNKKz46D1sgOKuJ
 +dJw==
X-Gm-Message-State: AOAM532adBtC0iLF6ZokIuAafQ8p+tB9romFI+mcoA46NlrdVYJcgOX5
 /rIdJIAo3Jxp9ppSKybWenz6sX8wdNY=
X-Google-Smtp-Source: ABdhPJzd6DpowR9DsNDUNg7B5OKdv28yNFcgd117tk8upUbce+LGJag39BO6NRl/f7POKSzddcqbqw==
X-Received: by 2002:a17:902:ac82:: with SMTP id
 h2mr7239618plr.300.1596710929799; 
 Thu, 06 Aug 2020 03:48:49 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:49 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 36/71] target/riscv: rvv-1.0: register gather instructions
Date: Thu,  6 Aug 2020 18:46:33 +0800
Message-Id: <20200806104709.13235-37-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102b.google.com
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

* Add vrgatherei16.vv instruction.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 21 ++++++++--
 target/riscv/vector_helper.c            | 53 ++++++++++++++-----------
 4 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index a5d58010134..35fb09d2892 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1105,6 +1105,10 @@ DEF_HELPER_6(vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 15afc469cb0..67306ac7161 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -609,6 +609,7 @@ vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
 vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
 vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
 vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
+vrgatherei16_vv 001110 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
 vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 469d0bad056..6698e1e860b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3308,7 +3308,21 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
            require_vm(a->vm, a->rd);
 }
 
+static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
+{
+    float emul = 16.0 / (1 << (s->sew + 3)) * s->flmul;
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (emul >= 0.125 && emul <= 8) &&
+           require_align(a->rd, s->flmul) &&
+           require_align(a->rs1, emul) &&
+           require_align(a->rs2, s->flmul) &&
+           (a->rd != a->rs2 && a->rd != a->rs1) &&
+           require_vm(a->vm, a->rd);
+}
+
 GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
+GEN_OPIVV_TRANS(vrgatherei16_vv, vrgatherei16_vv_check)
 
 static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
@@ -3328,11 +3342,11 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        int vlmax = s->vlen;
+        int vlmax = s->vlen * s->flmul / (1 << (s->sew + 3));
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
-            vec_element_loadi(s, dest, a->rs2, 0);
+            vec_element_loadi(s, dest, a->rs2, 0, false);
         } else {
             vec_element_loadx(s, dest, a->rs2, cpu_gpr[a->rs1], vlmax);
         }
@@ -3359,7 +3373,8 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        if (a->rs1 >= s->vlen) {
+        int vlmax = s->vlen * s->flmul / (1 << (s->sew + 3));
+        if (a->rs1 >= vlmax) {
             tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), 0);
         } else {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 13ce6f33a9e..d7827a9db10 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4711,33 +4711,38 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
 
 /* Vector Register Gather Instruction */
-#define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H)                              \
-void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
-                  CPURISCVState *env, uint32_t desc)                      \
-{                                                                         \
-    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
-    uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vl = env->vl;                                                \
-    uint32_t index, i;                                                    \
-                                                                          \
-    for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, i)) {                              \
-            continue;                                                     \
-        }                                                                 \
-        index = *((ETYPE *)vs1 + H(i));                                   \
-        if (index >= vlmax) {                                             \
-            *((ETYPE *)vd + H(i)) = 0;                                    \
-        } else {                                                          \
-            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
-        }                                                                 \
-    }                                                                     \
+#define GEN_VEXT_VRGATHER_VV(NAME, TS1, TS2, HS1, HS2)          \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(TS1), false);  \
+    uint32_t vm = vext_vm(desc);                                \
+    uint32_t vl = env->vl;                                      \
+    uint32_t index, i;                                          \
+                                                                \
+    for (i = 0; i < vl; i++) {                                  \
+        if (!vm && !vext_elem_mask(v0, i)) {                    \
+            continue;                                           \
+        }                                                       \
+        index = *((TS1 *)vs1 + HS1(i));                         \
+        if (index >= vlmax) {                                   \
+            *((TS2 *)vd + HS2(i)) = 0;                          \
+        } else {                                                \
+            *((TS2 *)vd + HS2(i)) = *((TS2 *)vs2 + HS2(index)); \
+        }                                                       \
+    }                                                           \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
-GEN_VEXT_VRGATHER_VV(vrgather_vv_b, uint8_t,  H1)
-GEN_VEXT_VRGATHER_VV(vrgather_vv_h, uint16_t, H2)
-GEN_VEXT_VRGATHER_VV(vrgather_vv_w, uint32_t, H4)
-GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_b, uint8_t,  uint8_t,  H1, H1)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_h, uint16_t, uint16_t, H2, H2)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_w, uint32_t, uint32_t, H4, H4)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, uint64_t, H8, H8)
+
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_b, uint16_t, uint8_t,  H2, H1)
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_h, uint16_t, uint16_t, H2, H2)
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_w, uint16_t, uint32_t, H2, H4)
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_d, uint16_t, uint64_t, H2, H8)
 
 #define GEN_VEXT_VRGATHER_VX(NAME, ETYPE, H)                              \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
-- 
2.17.1


