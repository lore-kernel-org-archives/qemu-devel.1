Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A0C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603A920774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="azhhwESx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603A920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLX9-0005lt-CZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyL-00069E-KE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:33 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:41908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyI-0002GH-Hi
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id z19so5520238pfn.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GqFqVVcVZj5NAClQNrBhIxG6QaVsOE7ZLxmH9hbhXRw=;
 b=azhhwESx10l/OMqGliCqrqicVinK9bwnG2rK8ROdDCn631BM6H5oZaC5XLsbEVzeKw
 u+/i0uBNiO5C9A9iFTuAJacCJfQF9+lVTRiNm/hUIGEzm1akkLD2LM/knj4rWr2M3xHe
 652W7Gm8nqWva4TRGKd7RyKTzM7xKPV7RFHBDA9E/anS2Xd2F0xYzExX7zrJYlerMmbO
 biiG4/5ewLuloVjEzJ/y/FCqo4VmXC2GiHl6xrges9lx7lOFeXumK0m14a84nM0tLNTB
 IC865AdGlv9tBf1cEm+6pdEuQLgHPlXJ34Mxk3rSCIE9J266FXx0i2OeYl798kFXX8Go
 qx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GqFqVVcVZj5NAClQNrBhIxG6QaVsOE7ZLxmH9hbhXRw=;
 b=Ol9R3ctLrCG5RABpEHVlgrWnNcIuzi1IrtWLvNykwh6ZbxilF2I7jX+0gArxz46j8s
 UpSyAnMax4kPK8h5Vh7y/f1o6AlAWiiDAE4EbDsmaBOqVT9lcSa29gmPb0rmYFLR2/Gs
 hzCVAHfZyh+R8PAQ1BHCQuyA5Ixx1K1eYUcMMPaB0581F/QCMiB0sUzbS5yAM1PfwHl+
 eO4rCtbxTc6AeFiB896xhs2pFYIY1FDh9uWrWK0A5xvgCLcpn+EYehzgzW+ctAbXZrLS
 tqw+/PhMSx48bdZ7pNjCOgJSr2/7eFjZi0614Fjhg52z6/i2oATKZLchoC808CEXKm8J
 xaxQ==
X-Gm-Message-State: AOAM531hPEhA44dk0OSY0ouxMNTaKN9pVcftGZ19bA5yrivvOdsyMX75
 a4ZFEYYGF33b+B4KswTUZ9z4FWX4MthPDw==
X-Google-Smtp-Source: ABdhPJz1vF9gh+hyMKqoATyBXPVnGa/dd0FZynR7uRGqXVunO52FbZ5oojt+rj+yisMVowc0d32fJw==
X-Received: by 2002:aa7:9491:0:b029:142:2501:34dd with SMTP id
 z17-20020aa794910000b0290142250134ddmr5472495pfk.54.1601406449029; 
 Tue, 29 Sep 2020 12:07:29 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 37/68] target/riscv: rvv-1.0: floating-point scalar move
 instructions
Date: Wed, 30 Sep 2020 03:04:12 +0800
Message-Id: <20200929190448.31116-38-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

NaN-boxed the scalar floating-point register based on RVV 1.0's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  4 +--
 target/riscv/insn_trans/trans_rvv.c.inc | 39 +++++++++++++------------
 target/riscv/internals.h                |  5 ----
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ad7d47748b..2a1fc1dd96 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -612,8 +612,8 @@ vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
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
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 254cface60..dc2d82bc96 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3294,14 +3294,20 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
 /* Floating-Point Scalar Move Instructions */
 static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
 {
-    if (!s->vill && has_ext(s, RVF) &&
-        (s->mstatus_fs != 0) && (s->sew != 0)) {
-        unsigned int len = 8 << s->sew;
+    if (require_rvv(s) &&
+        require_rvf(s) &&
+        vext_check_isa_ill(s)) {
+        unsigned int ofs = (8 << s->sew);
+        unsigned int len = 64 - ofs;
+        TCGv_i64 t_nan;
 
         vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0, false);
-        if (len < 64) {
-            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
-                            MAKE_64BIT_MASK(len, 64 - len));
+        /* NaN-box f[rd] as necessary for SEW */
+        if (len) {
+            t_nan = tcg_const_i64(UINT64_MAX);
+            tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                                t_nan, ofs, len);
+            tcg_temp_free_i64(t_nan);
         }
 
         mark_fs_dirty(s);
@@ -3313,25 +3319,20 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
 /* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
 static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 {
-    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
-        TCGv_i64 t1;
+    if (require_rvv(s) &&
+        require_rvf(s) &&
+        vext_check_isa_ill(s)) {
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
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index bca48297da..1c45e40201 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -32,11 +32,6 @@ target_ulong fclass_h(uint64_t frs1);
 target_ulong fclass_s(uint64_t frs1);
 target_ulong fclass_d(uint64_t frs1);
 
-#define SEW8  0
-#define SEW16 1
-#define SEW32 2
-#define SEW64 3
-
 static inline uint64_t nanbox_s(float32 f)
 {
     return f | MAKE_64BIT_MASK(32, 32);
-- 
2.17.1


