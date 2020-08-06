Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7210CC433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500A822DBF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E+I5bwt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500A822DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dlS-0005kC-9L
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSL-0003HC-2D
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:38723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSG-0007wU-Eg
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:04 -0400
Received: by mail-pj1-x102c.google.com with SMTP id ep8so6287684pjb.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SlZUQPHq8fRU7qvD3g0ccVpWc60dMPzUVEZmaPEF8nY=;
 b=E+I5bwt1sKY+Evb4LrTMq5I+LjpzVzhjAWitp0ET/8d8GhvZT8yolhD0mK0FkgJ+nw
 N+G2cHBy8bqq+6U0Aj6Z4J9MYjROziUS0xr5piQIQhLRMIuyStnn7YTYkXqXfvieSIBN
 0H4zhrZPa/Yw378nCxopwu5L2+I9KwhnijTUl/sqca5B1HfUNU7dJFvtnPxoRjVNHfJx
 S0/sR/wrUrNgPgNHuwKi6Fj3XAEJgbJPNDxQncC1bjbfXk2jx10qFhifbYSVWe632PMs
 kf3H/ISQ+fLoyrQ+MPIhsNyrQME42NpxmqSkVIeuTHBGviivioMJHpAgP4Q16/zeGh/c
 0qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SlZUQPHq8fRU7qvD3g0ccVpWc60dMPzUVEZmaPEF8nY=;
 b=kh43RAq7PwFuSUDZ53pQ5JdQDQzpmBMhkqr9Xs0pjGc9jewlXzg0UbuUQXE8mi6ATd
 f8UC7J0I2qDUKdV1O9iWlSbrB3+hw0q97aGsEKOmWckzfRPAKhvkEUtUHTbIADypZg+s
 blMdzUx7LGNMi6E95e2K3OxD/uR47gi+CkIBM0m+tEBnIadd4rSoDDfY7XejxfDQ+03m
 uBLKjVXjhtdbFbzy23o6q9TbsdddzEXyv4mYi8b0WULKTYup6zLjbgU43WvmOByg0rJf
 yxL9pI0lvBhS0Ee8hXt7/EOysr4Z+6WgDFPrW74JsGEZaen4nDZBQgwU6+sUsvV0oDt3
 uR7Q==
X-Gm-Message-State: AOAM531gz+HUCl2Y3rJKs3GTiqjYB4fJm85IotWbaHUhSIjpH1XXmu6F
 VuH6l2aAVzbrmNi6UTsmFKU4YK63XuQ=
X-Google-Smtp-Source: ABdhPJwIc2xsbP0qWWaYK64E8Nc+kNhe5J3H616e2O06TXQfoRY15AcccrrDuWwnRIsWv8eCt0AXZg==
X-Received: by 2002:a17:90a:f48d:: with SMTP id
 bx13mr7758152pjb.78.1596710937760; 
 Thu, 06 Aug 2020 03:48:57 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:57 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 39/71] target/riscv: rvv-1.0: floating-point scalar move
 instructions
Date: Thu,  6 Aug 2020 18:46:36 +0800
Message-Id: <20200806104709.13235-40-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102c.google.com
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

NaN-boxed the scalar floating-point register based on RVV 1.0's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  4 +--
 target/riscv/insn_trans/trans_rvv.inc.c | 46 ++++++++++++++-----------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6b90b67c7cc..97fce34fcd8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -601,8 +601,8 @@ vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
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
index 60ec83e412e..f5d72d68a79 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3262,14 +3262,22 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
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
@@ -3281,25 +3289,21 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
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
+        /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
-        if (s->sew == MO_64 && !has_ext(s, RVD)) {
-            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
-        } else {
-            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
-        }
+        do_nanbox(s, t1, cpu_fpr[a->rs1]);
+
         vec_element_storei(s, a->rd, 0, t1);
         tcg_temp_free_i64(t1);
         mark_vs_dirty(s);
-- 
2.17.1


