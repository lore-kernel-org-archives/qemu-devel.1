Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B68C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23CF2175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc2Qyv97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23CF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxbn-0006AO-06
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:45:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVe-00018b-JC
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVb-0006vy-TY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:02 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVb-0006vO-Jb
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:38:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id w26so864238pfj.10
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/g6HfJ2gjjF5BRknAhZhLqn8QoGjqCxyswuw+nR205c=;
	b=Vc2Qyv97RjQl7ZRx8/ZRsWmM5EDZ50u70Q9TFNIrHweu893rTAC99i4f7fPYOMEAiM
	qkC0SjHS8zcyttmDcAD9t1h74ZVFcMN/NGAfpdFmZWQkYXRzuZZ5bESZzR8EDDlycpaM
	eTxSdqJyV7UNFTh8awGDygmE+MnS4DAGm/BYYsVCXXIlHLbpJ7ztPNWthPXWhwszUI+6
	1QY0TNe3+Om35JSJQzep5GXqnSH+U8aSRyG2x+cbWXFQtR6cV9zicyrNqjpTxaKuowio
	2g2NedXHx24vPIWInvUMvPNDkxR+GiDgNiCmFycPawDK2Bqz6dRj0n3Gy2wrhY3mCr3o
	FVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/g6HfJ2gjjF5BRknAhZhLqn8QoGjqCxyswuw+nR205c=;
	b=HnCP3xe5/eTYS6qJXA0kTTaaHSoUDOW1KH6peyLG3RnK2IVIrO0X3Bl2AO31jXDjzD
	0M9yiKHNFDO3xI92uB7DdvaxEKPMtH/xoj4bQ67f9Mu4ZScgV3Oe1UgLVhIJkp3UJKz+
	Ido3bW3KAACQdu7iT3Gl9xE3r2HcaASJblkDzNxv5wnGbifIEmzA3Aa/VXxtNT1pApLF
	B2lnq+0DVo6L2Q46rY9owIaIA0b+6LJ/4aMQn4eGGkmBagtpCXVYh+Tp5/n4iVgw9j+P
	6Nv3i8NWAR6lKTCyoTSFYDSyFHl88WsClerzy8sKAih+ll3Lk7EStFge2dSs538xi2so
	RJGw==
X-Gm-Message-State: APjAAAUA+1jusbdSKNFyaRopJ3Vhz+RZS9tF1yMHLT9BBBW89+sJgO6b
	hO66TBkI+PDjoXlDHYVD4NQHfVIkKQw=
X-Google-Smtp-Source: APXvYqwBEmWY4uhFdfgmcOvLZzZ8zq8ZVfpHFIEfu6n7etLs3f9Wb9OH//LGoJYt4wTUMRcxEm+jZg==
X-Received: by 2002:a65:6108:: with SMTP id z8mr25217771pgu.106.1556033937746; 
	Tue, 23 Apr 2019 08:38:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.38.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:47 -0700
Message-Id: <20190423153853.19790-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 1/7] tcg: Hoist max_insns computation to
 tb_gen_code
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423153847.WSpne8QSAuslFH8z7YiAyGwUEHP5YcQnrVAqgi9QKwI@z>

In order to handle TB's that translate to too much code, we
need to place the control of the length of the translation
in the hands of the code gen master loop.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h       |  4 ++--
 include/exec/translator.h     |  3 ++-
 accel/tcg/translate-all.c     | 15 +++++++++++++--
 accel/tcg/translator.c        | 15 ++-------------
 target/alpha/translate.c      |  4 ++--
 target/arm/translate.c        |  4 ++--
 target/cris/translate.c       | 10 +---------
 target/hppa/translate.c       |  5 ++---
 target/i386/translate.c       |  4 ++--
 target/lm32/translate.c       | 10 +---------
 target/m68k/translate.c       |  4 ++--
 target/microblaze/translate.c | 10 +---------
 target/mips/translate.c       |  4 ++--
 target/moxie/translate.c      | 11 ++---------
 target/nios2/translate.c      | 14 ++------------
 target/openrisc/translate.c   |  4 ++--
 target/ppc/translate.c        |  4 ++--
 target/riscv/translate.c      |  4 ++--
 target/s390x/translate.c      |  4 ++--
 target/sh4/translate.c        |  4 ++--
 target/sparc/translate.c      |  4 ++--
 target/tilegx/translate.c     | 12 +-----------
 target/tricore/translate.c    | 16 ++--------------
 target/unicore32/translate.c  | 10 +---------
 target/xtensa/translate.c     |  4 ++--
 25 files changed, 56 insertions(+), 127 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 97b90cb0db..58e988b3b1 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -40,8 +40,8 @@ typedef ram_addr_t tb_page_addr_t;
 
 #include "qemu/log.h"
 
-void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb);
-void restore_state_to_opc(CPUArchState *env, struct TranslationBlock *tb,
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns);
+void restore_state_to_opc(CPUArchState *env, TranslationBlock *tb,
                           target_ulong *data);
 
 void cpu_gen_init(void);
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 71e7b2c347..66dfe906c4 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -123,6 +123,7 @@ typedef struct TranslatorOps {
  * @db: Disassembly context.
  * @cpu: Target vCPU.
  * @tb: Translation block.
+ * @max_insns: Maximum number of insns to translate.
  *
  * Generic translator loop.
  *
@@ -137,7 +138,7 @@ typedef struct TranslatorOps {
  * - When too many instructions have been translated.
  */
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
-                     CPUState *cpu, TranslationBlock *tb);
+                     CPUState *cpu, TranslationBlock *tb, int max_insns);
 
 void translator_loop_temp_check(DisasContextBase *db);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8f593b926f..fcdfe6c0ec 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1673,7 +1673,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_page_addr_t phys_pc, phys_page2;
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
-    int gen_code_size, search_size;
+    int gen_code_size, search_size, max_insns;
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti;
@@ -1691,6 +1691,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     cflags &= ~CF_CLUSTER_MASK;
     cflags |= cpu->cluster_index << CF_CLUSTER_SHIFT;
 
+    max_insns = cflags & CF_COUNT_MASK;
+    if (max_insns == 0) {
+        max_insns = CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns = TCG_MAX_INSNS;
+    }
+    if (cpu->singlestep_enabled || singlestep) {
+        max_insns = 1;
+    }
+
  buffer_overflow:
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
@@ -1720,7 +1731,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_func_start(tcg_ctx);
 
     tcg_ctx->cpu = ENV_GET_CPU(env);
-    gen_intermediate_code(cpu, tb);
+    gen_intermediate_code(cpu, tb, max_insns);
     tcg_ctx->cpu = NULL;
 
     trace_translate_block(tb, tb->pc, tb->tc.ptr);
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index afd0a49ea6..8d65ead708 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -32,7 +32,7 @@ void translator_loop_temp_check(DisasContextBase *db)
 }
 
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
-                     CPUState *cpu, TranslationBlock *tb)
+                     CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     int bp_insn = 0;
 
@@ -42,20 +42,9 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->pc_next = db->pc_first;
     db->is_jmp = DISAS_NEXT;
     db->num_insns = 0;
+    db->max_insns = max_insns;
     db->singlestep_enabled = cpu->singlestep_enabled;
 
-    /* Instruction counting */
-    db->max_insns = tb_cflags(db->tb) & CF_COUNT_MASK;
-    if (db->max_insns == 0) {
-        db->max_insns = CF_COUNT_MASK;
-    }
-    if (db->max_insns > TCG_MAX_INSNS) {
-        db->max_insns = TCG_MAX_INSNS;
-    }
-    if (db->singlestep_enabled || singlestep) {
-        db->max_insns = 1;
-    }
-
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 9d8f9b3eea..2c9cccf6c1 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -3049,10 +3049,10 @@ static const TranslatorOps alpha_tr_ops = {
     .disas_log          = alpha_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc;
-    translator_loop(&alpha_tr_ops, &dc.base, cpu, tb);
+    translator_loop(&alpha_tr_ops, &dc.base, cpu, tb, max_insns);
 }
 
 void restore_state_to_opc(CPUAlphaState *env, TranslationBlock *tb,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d408e4d7ef..b6b65ca360 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13755,7 +13755,7 @@ static const TranslatorOps thumb_translator_ops = {
 };
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc;
     const TranslatorOps *ops = &arm_translator_ops;
@@ -13769,7 +13769,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     }
 #endif
 
-    translator_loop(ops, &dc.base, cpu, tb);
+    translator_loop(ops, &dc.base, cpu, tb, max_insns);
 }
 
 void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 11b2c11174..777810452d 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3080,7 +3080,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  */
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUCRISState *env = cs->env_ptr;
     uint32_t pc_start;
@@ -3090,7 +3090,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     uint32_t page_start;
     target_ulong npc;
     int num_insns;
-    int max_insns;
 
     if (env->pregs[PR_VR] == 32) {
         dc->decoder = crisv32_decoder;
@@ -3136,13 +3135,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
 
     gen_tb_start(tb);
     do {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 43b74367ea..7c03c62768 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4312,11 +4312,10 @@ static const TranslatorOps hppa_tr_ops = {
     .disas_log          = hppa_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
-
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext ctx;
-    translator_loop(&hppa_tr_ops, &ctx.base, cs, tb);
+    translator_loop(&hppa_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
diff --git a/target/i386/translate.c b/target/i386/translate.c
index b725bec37c..77d6b73e42 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8590,11 +8590,11 @@ static const TranslatorOps i386_tr_ops = {
 };
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc;
 
-    translator_loop(&i386_tr_ops, &dc.base, cpu, tb);
+    translator_loop(&i386_tr_ops, &dc.base, cpu, tb, max_insns);
 }
 
 void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index b32feb7564..ac5169c4e7 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1049,7 +1049,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPULM32State *env = cs->env_ptr;
     LM32CPU *cpu = lm32_env_get_cpu(env);
@@ -1057,7 +1057,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     uint32_t pc_start;
     uint32_t page_start;
     int num_insns;
-    int max_insns;
 
     pc_start = tb->pc;
     dc->features = cpu->features;
@@ -1077,13 +1076,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
 
     gen_tb_start(tb);
     do {
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6217a683f1..838ff64875 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6169,10 +6169,10 @@ static const TranslatorOps m68k_tr_ops = {
     .disas_log          = m68k_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc;
-    translator_loop(&m68k_tr_ops, &dc.base, cpu, tb);
+    translator_loop(&m68k_tr_ops, &dc.base, cpu, tb, max_insns);
 }
 
 static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 78ca265b04..efdea5b635 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1600,7 +1600,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUMBState *env = cs->env_ptr;
     MicroBlazeCPU *cpu = mb_env_get_cpu(env);
@@ -1610,7 +1610,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     uint32_t page_start, org_flags;
     uint32_t npc;
     int num_insns;
-    int max_insns;
 
     pc_start = tb->pc;
     dc->cpu = cpu;
@@ -1634,13 +1633,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
 
     gen_tb_start(tb);
     do
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 364bd6dc4f..ee630e1c5d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29720,11 +29720,11 @@ static const TranslatorOps mips_tr_ops = {
     .disas_log          = mips_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext ctx;
 
-    translator_loop(&mips_tr_ops, &ctx.base, cs, tb);
+    translator_loop(&mips_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 static void fpu_dump_state(CPUMIPSState *env, FILE *f, fprintf_function fpu_fprintf,
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 68ca223e22..d6eebf527f 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -813,13 +813,13 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUMoxieState *env = cs->env_ptr;
     MoxieCPU *cpu = moxie_env_get_cpu(env);
     DisasContext ctx;
     target_ulong pc_start;
-    int num_insns, max_insns;
+    int num_insns;
 
     pc_start = tb->pc;
     ctx.pc = pc_start;
@@ -829,13 +829,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     ctx.singlestep_enabled = 0;
     ctx.bstate = BS_NONE;
     num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
 
     gen_tb_start(tb);
     do {
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 7fa03ed05a..a402e572df 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -805,12 +805,11 @@ static void gen_exception(DisasContext *dc, uint32_t excp)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUNios2State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     int num_insns;
-    int max_insns;
 
     /* Initialize DC */
     dc->cpu_env = cpu_env;
@@ -823,20 +822,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 
     /* Set up instruction counts */
     num_insns = 0;
-    if (cs->singlestep_enabled || singlestep) {
-        max_insns = 1;
-    } else {
+    if (max_insns > 1) {
         int page_insns = (TARGET_PAGE_SIZE - (tb->pc & TARGET_PAGE_MASK)) / 4;
-        max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-        if (max_insns == 0) {
-            max_insns = CF_COUNT_MASK;
-        }
         if (max_insns > page_insns) {
             max_insns = page_insns;
         }
-        if (max_insns > TCG_MAX_INSNS) {
-            max_insns = TCG_MAX_INSNS;
-        }
     }
 
     gen_tb_start(tb);
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 89680f882d..92a2b99f9a 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1408,11 +1408,11 @@ static const TranslatorOps openrisc_tr_ops = {
     .disas_log          = openrisc_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext ctx;
 
-    translator_loop(&openrisc_tr_ops, &ctx.base, cs, tb);
+    translator_loop(&openrisc_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index badc1ae1a3..d625687910 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7864,11 +7864,11 @@ static const TranslatorOps ppc_tr_ops = {
     .disas_log          = ppc_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext ctx;
 
-    translator_loop(&ppc_tr_ops, &ctx.base, cs, tb);
+    translator_loop(&ppc_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 void restore_state_to_opc(CPUPPCState *env, TranslationBlock *tb,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index dd763647ea..967eac7bc3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -783,11 +783,11 @@ static const TranslatorOps riscv_tr_ops = {
     .disas_log          = riscv_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext ctx;
 
-    translator_loop(&riscv_tr_ops, &ctx.base, cs, tb);
+    translator_loop(&riscv_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 void riscv_translate_init(void)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 0afa8f7ca5..d4951836ad 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6552,11 +6552,11 @@ static const TranslatorOps s390x_tr_ops = {
     .disas_log          = s390x_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc;
 
-    translator_loop(&s390x_tr_ops, &dc.base, cs, tb);
+    translator_loop(&s390x_tr_ops, &dc.base, cs, tb, max_insns);
 }
 
 void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ab254b0e8d..34d3438250 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2382,11 +2382,11 @@ static const TranslatorOps sh4_tr_ops = {
     .disas_log          = sh4_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext ctx;
 
-    translator_loop(&sh4_tr_ops, &ctx.base, cs, tb);
+    translator_loop(&sh4_tr_ops, &ctx.base, cs, tb, max_insns);
 }
 
 void restore_state_to_opc(CPUSH4State *env, TranslationBlock *tb,
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 74315cdf09..091bab53af 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5962,11 +5962,11 @@ static const TranslatorOps sparc_tr_ops = {
     .disas_log          = sparc_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc = {};
 
-    translator_loop(&sparc_tr_ops, &dc.base, cs, tb);
+    translator_loop(&sparc_tr_ops, &dc.base, cs, tb, max_insns);
 }
 
 void sparc_tcg_init(void)
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index df1e4d0fef..c46a4ab151 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -2369,7 +2369,7 @@ static void translate_one_bundle(DisasContext *dc, uint64_t bundle)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUTLGState *env = cs->env_ptr;
     DisasContext ctx;
@@ -2377,7 +2377,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     uint64_t pc_start = tb->pc;
     uint64_t page_start = pc_start & TARGET_PAGE_MASK;
     int num_insns = 0;
-    int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
 
     dc->pc = pc_start;
     dc->mmuidx = 0;
@@ -2392,15 +2391,6 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
     }
-    if (!max_insns) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (cs->singlestep_enabled || singlestep) {
-        max_insns = 1;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
     gen_tb_start(tb);
 
     while (1) {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index b12c391be5..30d3ff77f5 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8807,24 +8807,12 @@ static void decode_opc(CPUTriCoreState *env, DisasContext *ctx, int *is_branch)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUTriCoreState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
-    int num_insns, max_insns;
-
-    num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (singlestep) {
-        max_insns = 1;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
+    int num_insns = 0;
 
     pc_start = tb->pc;
     ctx.pc = pc_start;
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 002569ff3b..8547164e47 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1870,14 +1870,13 @@ static void disas_uc32_insn(CPUUniCore32State *env, DisasContext *s)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUUniCore32State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     target_ulong pc_start;
     uint32_t page_start;
     int num_insns;
-    int max_insns;
 
     /* generate intermediate code */
     num_temps = 0;
@@ -1896,13 +1895,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     cpu_F1d = tcg_temp_new_i64();
     page_start = pc_start & TARGET_PAGE_MASK;
     num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
 
 #ifndef CONFIG_USER_ONLY
     if ((env->uncached_asr & ASR_M) == ASR_MODE_USER) {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 65561d2c49..435955dab0 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1634,10 +1634,10 @@ static const TranslatorOps xtensa_translator_ops = {
     .disas_log          = xtensa_tr_disas_log,
 };
 
-void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     DisasContext dc = {};
-    translator_loop(&xtensa_translator_ops, &dc.base, cpu, tb);
+    translator_loop(&xtensa_translator_ops, &dc.base, cpu, tb, max_insns);
 }
 
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
-- 
2.17.1


