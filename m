Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F4AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069AE20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJLLnuJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069AE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE59n-0002OD-50
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE57O-0008CE-2L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE57M-0004hl-07
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:21 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:38471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE57H-0004Ru-FG; Tue, 17 Mar 2020 01:50:15 -0400
Received: by mail-pj1-x102a.google.com with SMTP id m15so9281919pje.3;
 Mon, 16 Mar 2020 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jEBBurAialqfu/0/NXYl4O2o421cp1A0orXBdHPPaDg=;
 b=MJLLnuJcyWuYWjeBtaLLiXnPIAGl4W+IHKSMo58OfiPoXtd0IDBVri/g609WYZRe8M
 iEE17TtvvCBaBVWkA3Jwqoj9dTsjTqpXgvJHGj1VotMa/Bg/JG1Dp3gt7yUPEg5I8IlP
 wUYVAYNU9cJiwlOmHl27Ny9RTAAQcvumivMwu1JIgLezHEqcS3bpkcGALFj6W0vGbwMd
 ysujzOyICePUiDROX/1D2oiKvxUk1M414TWGtF+0TbQBEP2JQ+qPA5GWENtSygdbOIL/
 aPff83aGCkF20rPUUadGDcIgXr89c7wZw+ZGhP5r7pn6uwnjbKhxr8mMEuBnff9sAA0R
 LRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jEBBurAialqfu/0/NXYl4O2o421cp1A0orXBdHPPaDg=;
 b=m9IUNFi4kcL8L1P6ly2Oac7DvZkwkRbIoWBhbJ5jTOLHMtOI5ma/nK9V/W+iCwA1HM
 gasCWDsE7Af41r7FmqkXbxUKp9Bw8n+0EhmwB5aCmaJ3xSuH1YbpdB2ZTxj9oU61MlkP
 Vt7pQ/0lbk+J7A3lovQa75Wp6Ysl040bLeUdUl1njD/PW/7boBytAdlWf1lNr6cEHG67
 Kd0nxS1fhE/5DMfnrF/I5k6WoRkfDhxGQ7zz8JUbJvnKvvAGoH0cgRpmW0vJW8LDz8Fu
 2/+SaNLzO7nQoTpkKNsfLZw50Z2/ihWC4LkwFq/Ey4rIMEB0cXGlePIo/LmM7wP0SZlM
 5ZFg==
X-Gm-Message-State: ANhLgQ1LUkrE1NecCofMzUxVkbB43XGzPPZhJnGRGxWz5EDXRl1QOXZY
 RXDwbRbMjl9XNBlV5gRV2c/VtiTvDNM=
X-Google-Smtp-Source: ADFU+vvQRw1GeVVYCca5eoTA7wKrN0HqBgKx+B0G8kFYInRc1QAi2Qp4U/5CUGyp1v6YBKRjwI3hQg==
X-Received: by 2002:a17:90b:11d5:: with SMTP id
 gv21mr3605758pjb.191.1584424213997; 
 Mon, 16 Mar 2020 22:50:13 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id s206sm1599735pfs.100.2020.03.16.22.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:50:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v3 2/2] target/ppc: Add support for scv and rfscv instructions
Date: Tue, 17 Mar 2020 15:49:18 +1000
Message-Id: <20200317054918.199161-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317054918.199161-1-npiggin@gmail.com>
References: <20200317054918.199161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102a
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
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

POWER9 adds scv and rfscv instructions and the system call vectored
interrupt. Linux does not support this instruction yet but it has
been tested with a modified kernel that runs on real hardware.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v2:
- Rebased on top of FWNMI series

 linux-user/ppc/cpu_loop.c       |  1 +
 target/ppc/cpu.h                |  7 ++-
 target/ppc/excp_helper.c        | 98 ++++++++++++++++++++++++---------
 target/ppc/helper.h             |  1 +
 target/ppc/translate.c          | 46 +++++++++++++++-
 target/ppc/translate_init.inc.c |  3 +-
 6 files changed, 126 insertions(+), 30 deletions(-)

diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 5b27f8603e..df71e15a25 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -267,6 +267,7 @@ void cpu_loop(CPUPPCState *env)
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case POWERPC_EXCP_SYSCALL:  /* System call exception                 */
+        case POWERPC_EXCP_SYSCALL_VECTORED:
             cpu_abort(cs, "Syscall exception while in user mode. "
                       "Aborting\n");
             break;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ed8d2015bd..992f0a49e8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -127,8 +127,9 @@ enum {
     POWERPC_EXCP_SDOOR_HV = 100,
     /* ISA 3.00 additions */
     POWERPC_EXCP_HVIRT    = 101,
+    POWERPC_EXCP_SYSCALL_VECTORED = 102, /* scv exception                     */
     /* EOL                                                                   */
-    POWERPC_EXCP_NB       = 102,
+    POWERPC_EXCP_NB       = 103,
     /* QEMU exceptions: used internally during code translation              */
     POWERPC_EXCP_STOP         = 0x200, /* stop translation                   */
     POWERPC_EXCP_BRANCH       = 0x201, /* branch instruction                 */
@@ -475,6 +476,7 @@ typedef struct ppc_v3_pate_t {
 /* Facility Status and Control (FSCR) bits */
 #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
 #define FSCR_TAR        (63 - 55) /* Target Address Register */
+#define FSCR_SCV        (63 - 51) /* System call vectored */
 /* Interrupt cause mask and position in FSCR. HFSCR has the same format */
 #define FSCR_IC_MASK    (0xFFULL)
 #define FSCR_IC_POS     (63 - 7)
@@ -484,6 +486,7 @@ typedef struct ppc_v3_pate_t {
 #define FSCR_IC_TM          5
 #define FSCR_IC_EBB         7
 #define FSCR_IC_TAR         8
+#define FSCR_IC_SCV        12
 
 /* Exception state register bits definition                                  */
 #define ESR_PIL   PPC_BIT(36) /* Illegal Instruction                    */
@@ -551,6 +554,8 @@ enum {
     POWERPC_FLAG_VSX      = 0x00080000,
     /* Has Transaction Memory (ISA 2.07)                                     */
     POWERPC_FLAG_TM       = 0x00100000,
+    /* Has SCV (ISA 3.00)                                                    */
+    POWERPC_FLAG_SCV      = 0x00200000,
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 81ee19ebae..73b5c28d03 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -67,6 +67,18 @@ static inline void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 8), env->nip);
 }
 
+static inline void dump_syscall_vectored(CPUPPCState *env)
+{
+    qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
+                  " r3=%016" PRIx64 " r4=%016" PRIx64 " r5=%016" PRIx64
+                  " r6=%016" PRIx64 " r7=%016" PRIx64 " r8=%016" PRIx64
+                  " nip=" TARGET_FMT_lx "\n",
+                  ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
+                  ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
+                  ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
+                  ppc_dump_gpr(env, 8), env->nip);
+}
+
 static inline void dump_hcall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "hypercall r3=%016" PRIx64
@@ -185,7 +197,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
-    int srr0, srr1, asrr0, asrr1, lev, ail;
+    int srr0, srr1, asrr0, asrr1, lev = -1, ail;
     bool lpes0;
 
     qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
@@ -421,6 +433,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
             new_msr |= (target_ulong)MSR_HVB;
         }
         break;
+    case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
+        lev = env->error_code;
+        dump_syscall_vectored(env);
+        env->nip += 4;
+        new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
+        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
+        break;
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
     case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable          */
     case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
@@ -723,12 +742,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         break;
     }
 
-    /* Save PC */
-    env->spr[srr0] = env->nip;
-
-    /* Save MSR */
-    env->spr[srr1] = msr;
-
     /* Sanity check */
     if (!(env->msr_mask & MSR_HVB)) {
         if (new_msr & MSR_HVB) {
@@ -741,14 +754,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         }
     }
 
-    /* If any alternate SRR register are defined, duplicate saved values */
-    if (asrr0 != -1) {
-        env->spr[asrr0] = env->spr[srr0];
-    }
-    if (asrr1 != -1) {
-        env->spr[asrr1] = env->spr[srr1];
-    }
-
     /*
      * Sort out endianness of interrupt, this differs depending on the
      * CPU, the HV mode, etc...
@@ -783,14 +788,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     }
 #endif
 
-    /* Jump to handler */
-    vector = env->excp_vectors[excp];
-    if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
-    }
-    vector |= env->excp_prefix;
-
     /*
      * AIL only works if there is no HV transition and we are running
      * with translations enabled
@@ -799,10 +796,21 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         ((new_msr & MSR_HVB) && !(msr & MSR_HVB))) {
         ail = 0;
     }
-    /* Handle AIL */
-    if (ail) {
-        new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
-        vector |= ppc_excp_vector_offset(cs, ail);
+
+    vector = env->excp_vectors[excp];
+    if (vector == (target_ulong)-1ULL) {
+        cpu_abort(cs, "Raised an exception without defined vector %d\n",
+                  excp);
+    }
+
+    vector |= env->excp_prefix;
+
+    /* If any alternate SRR register are defined, duplicate saved values */
+    if (asrr0 != -1) {
+        env->spr[asrr0] = env->nip;
+    }
+    if (asrr1 != -1) {
+        env->spr[asrr1] = msr;
     }
 
 #if defined(TARGET_PPC64)
@@ -822,6 +830,37 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     }
 #endif
 
+    if (excp != POWERPC_EXCP_SYSCALL_VECTORED) {
+        /* Save PC */
+        env->spr[srr0] = env->nip;
+
+        /* Save MSR */
+        env->spr[srr1] = msr;
+
+        /* Handle AIL */
+        if (ail) {
+            new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
+            vector |= ppc_excp_vector_offset(cs, ail);
+        }
+
+#if defined(TARGET_PPC64)
+    } else {
+        /* scv AIL is a little different */
+        if (ail) {
+            new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
+        }
+        if (ail == AIL_C000_0000_0000_4000) {
+            vector |= 0xc000000000003000ull;
+        } else {
+            vector |= 0x0000000000017000ull;
+        }
+        vector += lev * 0x20;
+
+        env->lr = env->nip;
+        env->ctr = msr;
+#endif
+    }
+
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
@@ -1162,6 +1201,11 @@ void helper_rfid(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
 }
 
+void helper_rfscv(CPUPPCState *env)
+{
+    do_rfi(env, env->lr, env->ctr);
+}
+
 void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cfb4c07085..ee1498050d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -15,6 +15,7 @@ DEF_HELPER_1(rfmci, void, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_2(pminsn, void, env, i32)
 DEF_HELPER_1(rfid, void, env)
+DEF_HELPER_1(rfscv, void, env)
 DEF_HELPER_1(hrfid, void, env)
 DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 127c82a24e..eb0ddba850 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -173,6 +173,7 @@ struct DisasContext {
     bool vsx_enabled;
     bool spe_enabled;
     bool tm_enabled;
+    bool scv_enabled;
     bool gtse;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
@@ -4012,6 +4013,22 @@ static void gen_rfid(DisasContext *ctx)
 #endif
 }
 
+static void gen_rfscv(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    /* Restore CPU state */
+    CHK_SV;
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    gen_update_cfar(ctx, ctx->base.pc_next - 4);
+    gen_helper_rfscv(cpu_env);
+    gen_sync_exception(ctx);
+#endif
+}
+
 static void gen_hrfid(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -4030,6 +4047,7 @@ static void gen_hrfid(DisasContext *ctx)
 #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
 #else
 #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
+#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
 #endif
 static void gen_sc(DisasContext *ctx)
 {
@@ -4039,6 +4057,21 @@ static void gen_sc(DisasContext *ctx)
     gen_exception_err(ctx, POWERPC_SYSCALL, lev);
 }
 
+#if defined(TARGET_PPC64)
+static void gen_scv(DisasContext *ctx)
+{
+    uint32_t lev;
+
+    if (unlikely(!ctx->scv_enabled)) {
+        gen_exception_err(ctx, POWERPC_EXCP_FU, FSCR_IC_SCV);
+        return;
+    }
+
+    lev = (ctx->opcode >> 5) & 0x7F;
+    gen_exception_err(ctx, POWERPC_SYSCALL_VECTORED, lev);
+}
+#endif
+
 /***                                Trap                                   ***/
 
 /* Check for unconditional traps (always or never) */
@@ -7019,6 +7052,10 @@ GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
+/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
+GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stop, 0x13, 0x12, 0x0b, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(doze, 0x13, 0x12, 0x0c, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER_E(nap, 0x13, 0x12, 0x0d, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
@@ -7026,7 +7063,9 @@ GEN_HANDLER_E(sleep, 0x13, 0x12, 0x0e, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER_E(rvwinkle, 0x13, 0x12, 0x0f, 0x03FFF801, PPC_NONE, PPC2_PM_ISA206),
 GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 #endif
-GEN_HANDLER(sc, 0x11, 0xFF, 0xFF, 0x03FFF01D, PPC_FLOW),
+/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
+GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
+GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(tw, 0x1F, 0x04, 0x00, 0x00000001, PPC_FLOW),
 GEN_HANDLER(twi, 0x03, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 #if defined(TARGET_PPC64)
@@ -7805,6 +7844,11 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     } else {
         ctx->vsx_enabled = false;
     }
+    if ((env->flags & POWERPC_FLAG_SCV) && (env->spr[SPR_FSCR] & (1ull << FSCR_SCV))) {
+        ctx->scv_enabled = true;
+    } else {
+        ctx->scv_enabled = false;
+    }
 #if defined(TARGET_PPC64)
     if ((env->flags & POWERPC_FLAG_TM) && msr_tm) {
         ctx->tm_enabled = !!msr_tm;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0ae145e18d..15025cd5ea 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -3382,6 +3382,7 @@ static void init_excp_POWER9(CPUPPCState *env)
 
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_HVIRT]    = 0x00000EA0;
+    env->excp_vectors[POWERPC_EXCP_SYSCALL_VECTORED] = 0x00000000;
 #endif
 }
 
@@ -9030,7 +9031,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_lpcr;
-- 
2.23.0


