Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797EAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0C420774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aQLKzZz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0C420774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL6h-0006w1-LN
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKx7-0003w0-Kd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:17 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKx5-00021y-9N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id d13so4633163pgl.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qR0UyCl8v/GSIwEq+eUv4q+D0UDYgCcO4b9CAiOWsMo=;
 b=aQLKzZz/QH2SvhKwq4wkcoTqWFboltSjSfxX8Du69gYQQ2GlAmubYi93Oeb+hKOv5Z
 /YDN/m7B9UWEXy6atKek2d00Rpmr+K6VILRmM0aN9I+4sK8YuxolHGRJFmqGlpSAXdUR
 J4IyHmA9lfU4L0MDB/UdEwbMf9I014jCTyGXGFl40syiT5S5l00bQmdBTPWY0k5p9WJ7
 1r1Tx18MFWv12MgLqA4KV6pOjC0HEJFFoDhyIT2FcisWA4Tz6b0hdUQ3VbLO9Ur83Hde
 1XMu+ITDTRu256xXYybq6qj6xCOTPQ2lW9Y1DoApUl2xxNBGguvZTlfhwuk/KeVPpXy3
 UCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qR0UyCl8v/GSIwEq+eUv4q+D0UDYgCcO4b9CAiOWsMo=;
 b=N5aeRwYPQTw1hcFsF827/oBBgtl5DBOxpXTUjN24JSrysrVrsxmBHTl59cEq9xP2MJ
 VJiGokLLy+DUyT9mfWnCiXiuIHKyHnlKJ/ZhspO/x2yL3Ih46A3Mg+3CAroEEoW+h7zz
 HYBKmgClF2oU66oUFzJaWzb3JckeTSFeNcq27Y9Nq63BEsybhi23n4UEI1p0PFgTjL93
 TF2UySHhPVf1ktiMyf9EGGwQmk1TPkvuUT1hresj5z2OzgCd62IQ7pODcUIACa5miiFp
 aFvp02Yae4kK5FoAFXpjpFqS9zClC6PwxjfP3cBP1qR0NCkR1SFnFssIB7ifweBU3+fE
 2pFw==
X-Gm-Message-State: AOAM533BEjGiTtObAWxCbnG5oG5TCYUn6i3fNNI80Fk3aXsz1LblrTul
 9Xb0sugvIYAMtv/4nx4YBCezAH6ppNDL6g==
X-Google-Smtp-Source: ABdhPJyLT5Vj3DNJi39QUVdbBJbqGKrevempSyl7JSIEEqQusvTqVCkO8naLKxnRP32kWpHX24Exvg==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id
 k22-20020a056a001356b029013ed13da084mr5249595pfu.27.1601406373744; 
 Tue, 29 Sep 2020 12:06:13 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:06:13 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 17/68] target/riscv: rvv-1.0: configure instructions
Date: Wed, 30 Sep 2020 03:03:52 +0800
Message-Id: <20200929190448.31116-18-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x542.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 14 ++++++++++----
 target/riscv/vector_helper.c            | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5ade7adc83..bf6ae18abf 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -143,8 +143,10 @@ static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
     s2 = tcg_temp_new();
     dst = tcg_temp_new();
 
-    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
-    if (a->rs1 == 0) {
+    if (a->rd == 0 && a->rs1 == 0) {
+        s1 = tcg_temp_new();
+        tcg_gen_mov_tl(s1, cpu_vl);
+    } else if (a->rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_const_tl(RV_VLEN_MAX);
     } else {
@@ -176,8 +178,10 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
     s2 = tcg_const_tl(a->zimm);
     dst = tcg_temp_new();
 
-    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
-    if (a->rs1 == 0) {
+    if (a->rd == 0 && a->rs1 == 0) {
+        s1 = tcg_temp_new();
+        tcg_gen_mov_tl(s1, cpu_vl);
+    } else if (a->rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_const_tl(RV_VLEN_MAX);
     } else {
@@ -187,6 +191,8 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
     gen_helper_vsetvl(dst, cpu_env, s1, s2);
     gen_set_gpr(a->rd, dst);
     mark_vs_dirty(ctx);
+    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
+    lookup_and_goto_ptr(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
 
     tcg_temp_free(s1);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 89aa7cbf73..61917d34ff 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -31,12 +31,24 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
+    uint64_t lmul = FIELD_EX64(s2, VTYPE, VLMUL);
     uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
     uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
     bool vill = FIELD_EX64(s2, VTYPE, VILL);
     target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    if (lmul & 4) {
+        /* Fractional LMUL. */
+        if (lmul == 4 ||
+            cpu->cfg.elen >> (8 - lmul) < sew) {
+            vill = true;
+        }
+    }
+
+    if ((sew > cpu->cfg.elen)
+        || vill
+        || (ediv != 0)
+        || (reserved != 0)) {
         /* only set vill bit. */
         env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
         env->vl = 0;
-- 
2.17.1


