Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7FF2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="axFFqSGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7FF2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBGc-0006BT-3t
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvV-0003Kf-90
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:55326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvS-0005os-RS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:36 -0400
Received: by mail-pj1-x102b.google.com with SMTP id k1so862608pjt.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BQ/w72oiGdyOS4wgaZxohpaXTkk17SEH1EVT1dtoFas=;
 b=axFFqSGvNKm26A+tecrOcJOawEYs7lotbIdYklMLdY9lWxdD6nXqFcAyAEl0J3Qork
 DdB+Shbgx6U57ZPPV2f59vBpqZ+PlHtx06DjuMVMAKuVp0WoJs60m66Y8JeA1ylixeWa
 e6l/ieT4oJQbvYWTgyOPNUwwzEH/Pm4Qm76rG/N0IZIeUoVKtKRhSNIz0tjqaD8TAvql
 GNCq2xrVUOqkF6akW8mpPS97lggtyYEJQ7p0n+19sszOojhQXeH4W0sPhZuHsH5GIKZF
 WWSFSkWSilRMLZgGHZQb+RV0PVFtX6A+k5rsrgVfsfaKLcxfejaIRw1tPahIyN64BWBj
 X1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BQ/w72oiGdyOS4wgaZxohpaXTkk17SEH1EVT1dtoFas=;
 b=WI08M4XQDzCHIMKJ70RRfciLnMypqmiy3bagvjtfNnPIuQcYiCdOwM1tkzUQdzE28F
 N6UREPVjXSr192HK8tQhA2rsTnjcFZaPR5R2rOaAi1zVyxs5n3Tjudz6fq2wCAR8ZjYv
 qFm2NTninBA+65X0fPWJ8tYKIRezoh+iWNqGXbiYWIo4bxjHKhZ1YM0uToxS4zgpKZXo
 BDB/S++H/GMdZgXqVk9DvmiCFfATWjiKghFQMG6zPKR1bA/pLv2xgW4hYMQ6c6yDOatH
 pNSmbieoAg2DQOr4vrRGApKvZoVmMG674DXxVk4c5vp55jwr72FfdVQtSt7Zx5yo5Kdf
 yd2w==
X-Gm-Message-State: AOAM533vHCCFtZaZloXFwepUiexHpepzIa+zHlU6MFfNUwcBeX3gnpcm
 orBmTnKWsIL+DtHcPZtIgSMcCaDew2M=
X-Google-Smtp-Source: ABdhPJwx0szqpQX3QnGvgGMRYabdx1L1/m7WWHs3cnYeb1U4cesqp+Wkq2MBq6YawXfbMxxXlPszmw==
X-Received: by 2002:a17:90b:1106:: with SMTP id
 gi6mr9547163pjb.2.1595409633002; 
 Wed, 22 Jul 2020 02:20:33 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 41/76] target/riscv: rvv-0.9: floating-point scalar move
 instructions
Date: Wed, 22 Jul 2020 17:16:04 +0800
Message-Id: <20200722091641.8834-42-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
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

NaN-boxed the scalar floating-point register based on RVV 0.9's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  4 +--
 target/riscv/insn_trans/trans_rvv.inc.c | 45 ++++++++++++++++---------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ef53df7c73..4be1b88e2d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -583,8 +583,8 @@ vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vmv_x_s         010000 1 ..... 00000 010 ..... 1010111 @r2rd
 vmv_s_x         010000 1 00000 ..... 110 ..... 1010111 @r2
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
-vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
-vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
+vfmv_f_s        010000 1 ..... 00000 001 ..... 1010111 @r2rd
+vfmv_s_f        010000 1 00000 ..... 101 ..... 1010111 @r2
 vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
 vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
 vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 54c08ea1f8..56cd7444f2 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3326,14 +3326,22 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
 /* Floating-Point Scalar Move Instructions */
 static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
 {
-    if (!s->vill && has_ext(s, RVF) &&
-        (s->mstatus_fs != 0) && (s->sew != 0)) {
-        unsigned int len = 8 << s->sew;
-
-        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
-        if (len < 64) {
-            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
-                            MAKE_64BIT_MASK(len, 64 - len));
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        has_ext(s, RVF) &&
+        (s->mstatus_fs != 0) &&
+        (s->sew != 0)) {
+        unsigned int ofs = (8 << s->sew);
+        unsigned int len = 64 - ofs;
+        TCGv_i64 t_nan;
+
+        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0, false);
+        /* NaN-box f[rd] as necessary for SEW */
+        if (len) {
+            t_nan = tcg_const_i64(UINT64_MAX);
+            tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                                t_nan, ofs, len);
+            tcg_temp_free_i64(t_nan);
         }
 
         mark_fs_dirty(s);
@@ -3345,22 +3353,27 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
 /* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
 static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 {
-    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
-        TCGv_i64 t1;
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s) &&
+        has_ext(s, RVF) &&
+        (s->sew != 0)) {
         /* The instructions ignore LMUL and vector register group. */
-        uint32_t vlmax = s->vlen >> 3;
+        TCGv_i64 t1;
+        TCGLabel *over = gen_new_label();
 
         /* if vl == 0, skip vector register write back */
-        TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        /* zeroed all elements */
-        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
-
-        /* NaN-box f[rs1] as necessary for SEW */
         t1 = tcg_temp_new_i64();
         if (s->sew == MO_64 && !has_ext(s, RVD)) {
+            /* SEW > FLEN, f[rs1] is NaN-boxed to SEW bits */
             tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
+        } else if ((s->sew < MO_64 && has_ext(s, RVD)) ||
+                   (s->sew < MO_32)) {
+            /* SEW < FLEN */
+            TCGv_i32 sew = tcg_const_i32(1 << (s->sew + 3));
+            gen_helper_narrower_nanbox_fpr(t1, cpu_fpr[a->rs1], sew, cpu_env);
+            tcg_temp_free_i32(sew);
         } else {
             tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
         }
-- 
2.17.1


