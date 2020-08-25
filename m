Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011DCC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4B7206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBgK5IbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4B7206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgaf-0005jS-Qr
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg49-0000Fg-VJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:14 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:33073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg47-000214-JQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:13 -0400
Received: by mail-pg1-x52a.google.com with SMTP id o13so7690779pgf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DL6mixLq6S/ykZHeP+netlYcRnE/vfVwl7yqTg4dZh0=;
 b=YBgK5IbW7mQG8LtoiCkzu0EprDeVvBX/7TAE0q0kqTpTIM9hMuVM5w9babE/N2jiTY
 vTF6N3uF4ryLXBMS1mmbx2rWdVBQDU0LyqmO7t7PJcCHxIA180GXdHyjiFUn4RiVlUO8
 sqwiEa6e+qtBJpbdozEbgrh7+2WyoLG3Xm0Z+y2QGwOcECikqRtSGlnZwuc2fHX7GPms
 93/DQHcHjYKRfFT7zQgQXOgKJ2meV3bQBzbqE25mr/zU1gUk5Kk8vMTlpMWyyR8of8ZF
 ixaBKM7VoYEwu+8J1IpbnGqDO84x/78S48i4ZUxJMIJWhdWTXLnVsOY2YZ+Rii6adrwb
 yCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DL6mixLq6S/ykZHeP+netlYcRnE/vfVwl7yqTg4dZh0=;
 b=fpahUnlOE0+hVVGm6LNWBkrUMl2PbpL15V/U/Z4whrhLeMD6fALE3rBv43U+wNb9hB
 wcvoEZwKTT3EK0586j5xLCc0cqqHK9uNKD0RNl6XMdpR3Jbyn3uuNo6mCAyzcMgmic/n
 fvKViUSzcurgFPShlTQHVjllWdMl0eNTpiGFUTz35MKC/vnmlXo4A2ZqOwcqynNAg65P
 QY1psA05E5vZVvvSnqXj9bZGHVvGD0t1goPUu7PLw5L2MESqYM+UFQVxZZtOToBKWYWO
 YtqbDBZcK48QidKijHkOSzyOgcioByJnFhYvzIkNdjtkaScrepZ5p7kROeMANeat5Wis
 A5/Q==
X-Gm-Message-State: AOAM532FwcrA3hNhexfIdBYlfLUoE+22QMeZUHSCtk+dU6lsmzi9vAfv
 GKrPLr4hhpHXENltrI33CbfXAa3YR4013Q==
X-Google-Smtp-Source: ABdhPJwVpoEQv2oIuHHXUEwU2Df4vWhBt3MNfhaFAmk6+m/0O0GzhbSyLwLWsjjEJXt815+gaAwu0A==
X-Received: by 2002:a63:6f82:: with SMTP id k124mr7890307pgc.357.1598389268991; 
 Tue, 25 Aug 2020 14:01:08 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/77] target/microblaze: Use cc->do_unaligned_access
Date: Tue, 25 Aug 2020 13:59:31 -0700
Message-Id: <20200825205950.730499-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes the problem in which unaligned stores succeeded,
but then we raised the exception after modifying memory.
Store the ESS for the unaligned data access in the iflags
for the insn, so that it can be found during unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 10 ++++-
 target/microblaze/helper.h    |  1 -
 target/microblaze/cpu.c       |  1 +
 target/microblaze/helper.c    | 28 ++++++++++++++
 target/microblaze/op_helper.c | 21 ----------
 target/microblaze/translate.c | 72 +++++++++++++----------------------
 6 files changed, 64 insertions(+), 69 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 83fadd36a5..63b8d93d41 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -79,10 +79,13 @@ typedef struct CPUMBState CPUMBState;
 
 /* Exception State Register (ESR) Fields */
 #define          ESR_DIZ       (1<<11) /* Zone Protection */
+#define          ESR_W         (1<<11) /* Unaligned word access */
 #define          ESR_S         (1<<10) /* Store instruction */
 
 #define          ESR_ESS_FSL_OFFSET     5
 
+#define          ESR_ESS_MASK  (0x7f << 5)
+
 #define          ESR_EC_FSL             0
 #define          ESR_EC_UNALIGNED_DATA  1
 #define          ESR_EC_ILLEGAL_OP      2
@@ -256,9 +259,11 @@ struct CPUMBState {
     /* Internal flags.  */
 #define IMM_FLAG        (1 << 0)
 #define BIMM_FLAG       (1 << 1)
-/* MSR_EE               (1 << 8)  */
+#define ESR_ESS_FLAG    (1 << 2)  /* indicates ESR_ESS_MASK is present */
+/* MSR_EE               (1 << 8)  -- these 3 are not in iflags but tb_flags */
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
+/* ESR_ESS_MASK         [11:5]    -- unwind into iflags for unaligned excp */
 #define DRTI_FLAG	(1 << 16)
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
@@ -330,6 +335,9 @@ struct MicroBlazeCPU {
 
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
+void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                MMUAccessType access_type,
+                                int mmu_idx, uintptr_t retaddr);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index a473c1867b..3980fba797 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -25,7 +25,6 @@ DEF_HELPER_3(mmu_read, i32, env, i32, i32)
 DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
 #endif
 
-DEF_HELPER_5(memalign, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_2(get, i32, i32, i32)
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 1eabf5cc3f..67017ecc33 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -317,6 +317,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
     cc->do_interrupt = mb_cpu_do_interrupt;
+    cc->do_unaligned_access = mb_cpu_do_unaligned_access;
     cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 06f4322e09..0e3be251a7 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -296,3 +296,31 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                MMUAccessType access_type,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    uint32_t esr, iflags;
+
+    /* Recover the pc and iflags from the corresponding insn_start.  */
+    cpu_restore_state(cs, retaddr, true);
+    iflags = cpu->env.iflags;
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "Unaligned access addr=" TARGET_FMT_lx
+                  " pc=%x iflags=%x\n", addr, cpu->env.pc, iflags);
+
+    esr = ESR_EC_UNALIGNED_DATA;
+    if (likely(iflags & ESR_ESS_FLAG)) {
+        esr |= iflags & ESR_ESS_MASK;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "Unaligned access without ESR_ESS_FLAG\n");
+    }
+
+    cpu->env.ear = addr;
+    cpu->env.esr = esr;
+    cs->exception_index = EXCP_HW_EXCP;
+    cpu_loop_exit(cs);
+}
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index a99c467364..4a07d0ce3c 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -365,27 +365,6 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
     return 0;
 }
 
-void helper_memalign(CPUMBState *env, target_ulong addr,
-                     uint32_t dr, uint32_t wr,
-                     uint32_t mask)
-{
-    if (addr & mask) {
-            qemu_log_mask(CPU_LOG_INT,
-                          "unaligned access addr=" TARGET_FMT_lx
-                          " mask=%x, wr=%d dr=r%d\n",
-                          addr, mask, wr, dr);
-            env->ear = addr;
-            env->esr = ESR_EC_UNALIGNED_DATA | (wr << 10) | (dr & 31) << 5;
-            if (mask == 3) {
-                env->esr |= 1 << 11;
-            }
-            if (!(env->msr & MSR_EE)) {
-                return;
-            }
-            helper_raise_exception(env, EXCP_HW_EXCP);
-    }
-}
-
 void helper_stackprot(CPUMBState *env, target_ulong addr)
 {
     if (addr < env->slr || addr > env->shr) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 930b8a9600..6e70873333 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -751,10 +751,22 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
     return ret;
 }
 
+static void record_unaligned_ess(DisasContext *dc, int rd,
+                                 MemOp size, bool store)
+{
+    uint32_t iflags = tcg_get_insn_start_param(dc->insn_start, 1);
+
+    iflags |= ESR_ESS_FLAG;
+    iflags |= rd << 5;
+    iflags |= store * ESR_S;
+    iflags |= (size == MO_32) * ESR_W;
+
+    tcg_set_insn_start_param(dc->insn_start, 1, iflags);
+}
+
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
                     int mem_index, bool rev)
 {
-    TCGv_i32 v;
     MemOp size = mop & MO_SIZE;
 
     /*
@@ -774,34 +786,15 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
     sync_jmpstate(dc);
 
-    /*
-     * Microblaze gives MMU faults priority over faults due to
-     * unaligned addresses. That's why we speculatively do the load
-     * into v. If the load succeeds, we verify alignment of the
-     * address and if that succeeds we write into the destination reg.
-     */
-    v = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
-
-    /* TODO: Convert to CPUClass::do_unaligned_access.  */
-    if (dc->cpu->cfg.unaligned_exceptions && size > MO_8) {
-        TCGv_i32 t0 = tcg_const_i32(0);
-        TCGv_i32 treg = tcg_const_i32(rd);
-        TCGv_i32 tsize = tcg_const_i32((1 << size) - 1);
-
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
-        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
-
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(treg);
-        tcg_temp_free_i32(tsize);
+    if (size > MO_8 &&
+        (dc->tb_flags & MSR_EE) &&
+        dc->cpu->cfg.unaligned_exceptions) {
+        record_unaligned_ess(dc, rd, size, false);
+        mop |= MO_ALIGN;
     }
 
-    if (rd) {
-        tcg_gen_mov_i32(cpu_R[rd], v);
-    }
+    tcg_gen_qemu_ld_i32(reg_for_write(dc, rd), addr, mem_index, mop);
 
-    tcg_temp_free_i32(v);
     tcg_temp_free(addr);
     return true;
 }
@@ -931,28 +924,15 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
     sync_jmpstate(dc);
 
-    tcg_gen_qemu_st_i32(reg_for_read(dc, rd), addr, mem_index, mop);
-
-    /* TODO: Convert to CPUClass::do_unaligned_access.  */
-    if (dc->cpu->cfg.unaligned_exceptions && size > MO_8) {
-        TCGv_i32 t1 = tcg_const_i32(1);
-        TCGv_i32 treg = tcg_const_i32(rd);
-        TCGv_i32 tsize = tcg_const_i32((1 << size) - 1);
-
-        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
-        /* FIXME: if the alignment is wrong, we should restore the value
-         *        in memory. One possible way to achieve this is to probe
-         *        the MMU prior to the memaccess, thay way we could put
-         *        the alignment checks in between the probe and the mem
-         *        access.
-         */
-        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
-
-        tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(treg);
-        tcg_temp_free_i32(tsize);
+    if (size > MO_8 &&
+        (dc->tb_flags & MSR_EE) &&
+        dc->cpu->cfg.unaligned_exceptions) {
+        record_unaligned_ess(dc, rd, size, true);
+        mop |= MO_ALIGN;
     }
 
+    tcg_gen_qemu_st_i32(reg_for_read(dc, rd), addr, mem_index, mop);
+
     tcg_temp_free(addr);
     return true;
 }
-- 
2.25.1


