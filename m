Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86379C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7722171F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7722171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZOl-0007sC-Hv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50291)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMx-0001IZ-Gz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMu-0000FO-Np
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:59 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57088)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMu-0000Et-7l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:56 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 589C8540081;
 Thu, 25 Jul 2019 11:44:55 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:44:55 +0300
Message-ID: <156404429499.18669.13404064982854123855.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
References: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH v2 8/8] icount: remove unnecessary
 gen_io_end calls
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior patch resets can_do_io flag at the TB entry. Therefore there is no
need in resetting this flag at the end of the block.
This patch removes redundant gen_io_end calls.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/translator.c                  |    2 +-
 target/alpha/translate.c                |    4 ++--
 target/arm/translate-a64.c              |    6 ++----
 target/arm/translate.c                  |   10 +++-------
 target/cris/translate.c                 |    4 ++--
 target/hppa/translate.c                 |    2 +-
 target/i386/translate.c                 |   18 ++++++++---------
 target/lm32/translate.c                 |   12 +++---------
 target/microblaze/translate.c           |    4 ++--
 target/mips/translate.c                 |   16 +++++-----------
 target/nios2/translate.c                |    4 +---
 target/ppc/translate.c                  |   18 +++++------------
 target/ppc/translate_init.inc.c         |    4 ++--
 target/riscv/insn_trans/trans_rvi.inc.c |    2 +-
 target/sparc/translate.c                |   32 ++++++++++++++++---------------
 target/unicore32/translate.c            |    2 +-
 target/xtensa/translate.c               |   20 +++++--------------
 17 files changed, 60 insertions(+), 100 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..5849cd250c 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -90,7 +90,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             /* Accept I/O on the last instruction.  */
             gen_io_start();
             ops->translate_insn(db, cpu);
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
         } else {
             ops->translate_insn(db, cpu);
         }
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2c9cccf6c1..97e7d55b4d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1332,7 +1332,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
         if (use_icount) {
             gen_io_start();
             helper(va);
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             return DISAS_PC_STALE;
         } else {
             helper(va);
@@ -2398,7 +2398,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
                 gen_helper_load_pcc(va, cpu_env);
-                gen_io_end();
+                /* No need for gen_io_end at the end of the block */
                 ret = DISAS_PC_STALE;
             } else {
                 gen_helper_load_pcc(va, cpu_env);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3231477a2..20e4638d5f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1797,7 +1797,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
 
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
-        gen_io_end();
+        /* No need for gen_io_end at the end of the block */
         s->base.is_jmp = DISAS_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
@@ -2104,9 +2104,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 
         gen_helper_exception_return(cpu_env, dst);
         tcg_temp_free_i64(dst);
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
+        /* No need for gen_io_end at the end of the block */
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
         return;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21..c17e5a8c04 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3245,9 +3245,7 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
         gen_io_start();
     }
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
     tcg_temp_free_i32(cpsr);
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
@@ -7338,7 +7336,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
         if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_lookup_tb(s);
         } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register write,
@@ -9207,9 +9205,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         gen_io_start();
                     }
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
-                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_end();
-                    }
+                    /* No need for gen_io_end at the end of the block */
                     tcg_temp_free_i32(tmp);
                     /* Must exit loop to check un-masked IRQs */
                     s->base.is_jmp = DISAS_EXIT;
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 3429a3b768..eeba534b29 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3225,8 +3225,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 
     npc = dc->pc;
 
-        if (tb_cflags(tb) & CF_LAST_IO)
-            gen_io_end();
+    /* No need for gen_io_end at the end of the block */
+
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || !dc->flagx_known
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 188fe688cb..695a1fdfb0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2161,7 +2161,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
             gen_helper_read_interval_timer(tmp);
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         } else {
             gen_helper_read_interval_timer(tmp);
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03150a86e2..b5469142cf 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5381,7 +5381,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_mov_reg_v(s, dflag, rm, s->T0);
             set_cc_op(s, CC_OP_EFLAGS);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
+                /* No need for gen_io_end at the end of the block */
                 gen_jmp(s, s->pc - s->cs_base);
             }
             break;
@@ -6443,7 +6443,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6464,7 +6464,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6482,7 +6482,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6502,7 +6502,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7206,7 +7206,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         gen_helper_rdtsc(cpu_env);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7666,7 +7666,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_helper_rdtscp(cpu_env);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
+                /* No need for gen_io_end at the end of the block */
                 gen_jmp(s, s->pc - s->cs_base);
             }
             break;
@@ -8036,9 +8036,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     gen_op_mov_v_reg(s, ot, s->T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          s->T0);
-                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_end();
-                    }
+                    /* No need for gen_io_end at the end of the block */
                     gen_jmp_im(s, s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index b9f2f2c4a7..d844177ced 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -885,9 +885,7 @@ static void dec_wcsr(DisasContext *dc)
         }
         gen_helper_wcsr_im(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
-        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
+        /* No need for gen_io_end at the end of the block */
         dc->is_jmp = DISAS_UPDATE;
         break;
     case CSR_IP:
@@ -897,9 +895,7 @@ static void dec_wcsr(DisasContext *dc)
         }
         gen_helper_wcsr_ip(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
-        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
+        /* No need for gen_io_end at the end of the block */
         dc->is_jmp = DISAS_UPDATE;
         break;
     case CSR_ICC:
@@ -1111,9 +1107,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
          && (dc->pc - page_start < TARGET_PAGE_SIZE)
          && num_insns < max_insns);
 
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 
     if (unlikely(cs->singlestep_enabled)) {
         if (dc->is_jmp == DISAS_NEXT) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9ce65f3bcf..ac4ee375f2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1724,8 +1724,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
             npc = dc->jmp_pc;
     }
 
-    if (tb_cflags(tb) & CF_LAST_IO)
-        gen_io_end();
+    /* No need for gen_io_end at the end of the block */
+
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ca628002ae..e6c0ee68b7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7126,9 +7126,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_io_start();
             }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
+            /* No need for gen_io_end at the end of the block */
             /*
              * Break the TB to be able to take timer interrupts immediately
              * after reading count. DISAS_STOP isn't sufficient, we need to
@@ -8293,7 +8291,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
+        /* No need for gen_io_end at the end of the block */
         /*
          * DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.
@@ -8604,9 +8602,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_io_start();
             }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
+            /* No need for gen_io_end at the end of the block */
             /*
              * Break the TB to be able to take timer interrupts immediately
              * after reading count. DISAS_STOP isn't sufficient, we need to
@@ -9745,7 +9741,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
+        /* No need for gen_io_end at the end of the block */
         /*
          * DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.
@@ -12810,9 +12806,7 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
             gen_io_start();
         }
         gen_helper_rdhwr_cc(t0, cpu_env);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
+        /* No need for gen_io_end at the end of the block */
         gen_store_gpr(t0, rt);
         /*
          * Break the TB to be able to take timer interrupts immediately
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 17d8f1877c..9798184468 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -862,9 +862,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
              !tcg_op_buf_full() &&
              num_insns < max_insns);
 
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 
     /* Indicate where the next block should start */
     switch (dc->is_jmp) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28036..fce3243f10 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1860,7 +1860,7 @@ static void gen_darn(DisasContext *ctx)
             gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
         }
         if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
+            /* No need for gen_io_end at the end of the block */
             gen_stop_exception(ctx);
         }
     }
@@ -3990,9 +3990,7 @@ static void gen_rfi(DisasContext *ctx)
     gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfi(cpu_env);
     gen_sync_exception(ctx);
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 #endif
 }
 
@@ -4010,9 +4008,7 @@ static void gen_rfid(DisasContext *ctx)
     gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfid(cpu_env);
     gen_sync_exception(ctx);
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 #endif
 }
 
@@ -4388,9 +4384,7 @@ static void gen_mtmsrd(DisasContext *ctx)
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
         gen_stop_exception(ctx);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
+        /* No need for gen_io_end at the end of the block */
     }
 #endif /* !defined(CONFIG_USER_ONLY) */
 }
@@ -4428,9 +4422,7 @@ static void gen_mtmsr(DisasContext *ctx)
         tcg_gen_mov_tl(msr, cpu_gpr[rS(ctx->opcode)]);
 #endif
         gen_helper_store_msr(cpu_env, msr);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
+        /* No need for gen_io_end at the end of the block */
         tcg_temp_free(msr);
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 86fc8f2e31..3e7a55987b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -189,7 +189,7 @@ static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
     }
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
+        /* No need for gen_io_end at the end of the block */
         gen_stop_exception(ctx);
     }
 }
@@ -201,7 +201,7 @@ static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
     }
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
+        /* No need for gen_io_end at the end of the block */
         gen_stop_exception(ctx);
     }
 }
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index ea6473111c..c70cb68ffc 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -511,7 +511,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
 } while (0)
 
 #define RISCV_OP_CSR_POST do {\
-    gen_io_end(); \
+    /* No need for gen_io_end at the end of the block */ \
     gen_set_gpr(a->rd, dest); \
     tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn); \
     exit_tb(ctx); \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 091bab53af..f5b83e46f8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4412,10 +4412,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_tick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
+                                    /*
+                                     * No need for gen_io_end
+                                     * at the end of the block
+                                     */
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
@@ -4440,10 +4440,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
+                                    /*
+                                     * No need for gen_io_end
+                                     * at the end of the block
+                                     */
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
@@ -4468,10 +4468,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_stick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
+                                    /*
+                                     * No need for gen_io_end
+                                     * at the end of the block
+                                     */
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
@@ -4588,10 +4588,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
+                                    /*
+                                     * No need for gen_io_end
+                                     * at the end of the block
+                                     */
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index d27451eed3..11e6c2d266 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1931,7 +1931,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                code.  */
             cpu_abort(cs, "IO on conditional branch instruction");
         }
-        gen_io_end();
+        /* No need for gen_io_end at the end of the block */
     }
 
     /* At this stage dc->condjmp will only be set when the skipped
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6f1da87875..1baf340289 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -540,9 +540,7 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
         gen_io_start();
     }
     gen_helper_waiti(cpu_env, pc, intlevel);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
 }
@@ -2216,9 +2214,7 @@ static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
     }
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 #endif
 }
 
@@ -2608,9 +2604,7 @@ static void translate_wsr_ccompare(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
     gen_helper_update_ccompare(cpu_env, tmp);
     tcg_temp_free(tmp);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 #endif
 }
 
@@ -2622,9 +2616,7 @@ static void translate_wsr_ccount(DisasContext *dc, const OpcodeArg arg[],
         gen_io_start();
     }
     gen_helper_wsr_ccount(cpu_env, arg[0].in);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 #endif
 }
 
@@ -2831,9 +2823,7 @@ static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(arg[0].out, tmp);
     tcg_temp_free(tmp);
 
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
+    /* No need for gen_io_end at the end of the block */
 #endif
 }
 


