Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B276C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4284620815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4284620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49445 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiI1-0004wL-D2
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:49:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxR-0003GC-4B
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfq-0005lQ-3d
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfp-0005ku-T3
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so5633204pll.11
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=LXJd80+rVzo+6MrKZjE1/RNSK5bbLw+nuyiN2acnnV0=;
	b=sS4HUF+Q2K8cAbTSoDTI9aTns7TYGmk2xdP3AtcG5eeKrhO/fH5IqbogJATzf9cGt1
	oN/EEDT6v5Da8fDkc/Cv6G1xk+53bf6Lu7zXBuI5ZIzXLlgbtALobOIhNPlWtb57W97K
	wPHfgzyz++AGyHle17I+RQcoItvTP7Q/whC/jNut9g5A/wbaoimKFJ5RGKEv6GltlliJ
	1Cy9hOtSCF5ok2ljYmIf5/skTHr+ENq87yy9l4U82Ce0NkrTtE9E4z0PXlkLQhb+wC+E
	dVs0N+QGqKnmQfYqyMH+8mKpfuBThW5eCBrM2EdkONJRoy0rYRRkm5eiYRnQEzgscaPf
	R3jA==
X-Gm-Message-State: APjAAAWw65HZqjmo/0DpvcQIXETkmX+E/U96oTGwTjwFSejSimjutAvL
	0KXcUqAO1HbI5o2FDEly9oOSPw==
X-Google-Smtp-Source: APXvYqyiy41NSKoY3Tb0+XF2asLqi4OG3ntQxI8DozLIf6MZqvZVPr1cwPPeX1PdtQSI3NojP2k8AA==
X-Received: by 2002:a17:902:b195:: with SMTP id
	s21mr15276485plr.16.1558833004404; 
	Sat, 25 May 2019 18:10:04 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	u20sm7544774pfm.145.2019.05.25.18.10.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:03 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:22 -0700
Message-Id: <20190526010948.3923-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.193
Subject: [Qemu-devel] [PULL 03/29] RISC-V: fix single stepping over ret and
 other branching instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
	Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fabien Chouteau <chouteau@adacore.com>

This patch introduces wrappers around the tcg_gen_exit_tb() and
tcg_gen_lookup_and_goto_ptr() functions that handle single stepping,
i.e. call gen_exception_debug() when single stepping is enabled.

Theses functions are then used instead of the originals, bringing single
stepping handling in places where it was previously ignored such as jalr
and system branch instructions (ecall, mret, sret, etc.).

Signed-off-by: Fabien Chouteau <chouteau@adacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 .../riscv/insn_trans/trans_privileged.inc.c   |  8 ++---
 target/riscv/insn_trans/trans_rvi.inc.c       |  6 ++--
 target/riscv/translate.c                      | 30 +++++++++++++++----
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index acb605923e68..664d6ba3f2cc 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -22,7 +22,7 @@ static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
-    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -30,7 +30,7 @@ static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
 {
     generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
-    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -47,7 +47,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 
     if (has_ext(ctx, RVS)) {
         gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
-        tcg_gen_exit_tb(NULL, 0); /* no chaining */
+        exit_tb(ctx); /* no chaining */
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
         return false;
@@ -68,7 +68,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #ifndef CONFIG_USER_ONLY
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
     gen_helper_mret(cpu_pc, cpu_env, cpu_pc);
-    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 #else
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index d420a4d8b2e9..37b0b9dd198e 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -60,7 +60,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     if (a->rd != 0) {
         tcg_gen_movi_tl(cpu_gpr[a->rd], ctx->pc_succ_insn);
     }
-    tcg_gen_lookup_and_goto_ptr();
+    lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
         gen_set_label(misaligned);
@@ -483,7 +483,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
      * however we need to end the translation block
      */
     tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
-    tcg_gen_exit_tb(NULL, 0);
+    exit_tb(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -504,7 +504,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
     gen_io_end(); \
     gen_set_gpr(a->rd, dest); \
     tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn); \
-    tcg_gen_exit_tb(NULL, 0); \
+    exit_tb(ctx); \
     ctx->base.is_jmp = DISAS_NORETURN; \
     tcg_temp_free(source1); \
     tcg_temp_free(csr_store); \
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2ff6b49487b7..840ecbef36e7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -109,6 +109,26 @@ static void gen_exception_debug(void)
     tcg_temp_free_i32(helper_tmp);
 }
 
+/* Wrapper around tcg_gen_exit_tb that handles single stepping */
+static void exit_tb(DisasContext *ctx)
+{
+    if (ctx->base.singlestep_enabled) {
+        gen_exception_debug();
+    } else {
+        tcg_gen_exit_tb(NULL, 0);
+    }
+}
+
+/* Wrapper around tcg_gen_lookup_and_goto_ptr that handles single stepping */
+static void lookup_and_goto_ptr(DisasContext *ctx)
+{
+    if (ctx->base.singlestep_enabled) {
+        gen_exception_debug();
+    } else {
+        tcg_gen_lookup_and_goto_ptr();
+    }
+}
+
 static void gen_exception_illegal(DisasContext *ctx)
 {
     generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
@@ -138,14 +158,14 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         /* chaining is only allowed when the jump is to the same page */
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
+
+        /* No need to check for single stepping here as use_goto_tb() will
+         * return false in case of single stepping.
+         */
         tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        if (ctx->base.singlestep_enabled) {
-            gen_exception_debug();
-        } else {
-            tcg_gen_lookup_and_goto_ptr();
-        }
+        lookup_and_goto_ptr(ctx);
     }
 }
 
-- 
2.21.0


