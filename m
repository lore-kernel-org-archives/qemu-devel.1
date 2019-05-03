Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA21C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9589E206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCt8MJdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9589E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35067 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRFt-0003FW-TA
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:01:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR98-0005N0-8l
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR91-0002xm-RL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:10 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR91-0002xI-HX; Fri, 03 May 2019 01:54:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id w20so2185863plq.3;
	Thu, 02 May 2019 22:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hDsDbN5xixiLnkL2VfXbM6rcGpngAkKIrMWVWa3efJM=;
	b=dCt8MJdJMSGsT2FgWLwo7n8sJfJtqiCSexxPk5D3Ww+WHmYDSWrs02NKvjkaD2S97l
	8ywdmb/iWCf+R4qASy9haeTXlLt89l1IiMUw7lLgTjq4L6xiLHOEl4cxn34Om8BokXM7
	xkl5j1v4lmwnfOkAOKM/Jrib9fDIpSbNyzMU0z65PZUoI7H6ESakj5KekW3nGroDjw4y
	pkDYPDSgXo/QbndRZ/aFkMnmiYIYaObhM4FW1U/ZNXyy5jiJ/OawKouDOKWMMOQ6smVG
	897nchlhOzLRsOHhWhumjjLcytKGsUKu4PqCtQg5/gFTJLE0ZOSd/VW2O6LCkUhYblf+
	hocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hDsDbN5xixiLnkL2VfXbM6rcGpngAkKIrMWVWa3efJM=;
	b=O4RdUAuUFkSyrXk/TjeCMAPoxxW2t6gl3WWFgV1ru8XIU808Gljwux6FR+FcvM8EZa
	piCafEhuS8HOwiwDH6utVg6xxA596cEyrFQMQMaZlDySgwLa6zSHUDVjMB7FuOitBjVf
	NouLzFkog0dS6AtEJfdT/mBNUjdZZlTAUnHUD0gmW56duNurKG75Lplv6YPVSGSQ7+CW
	K2rD0t2bj6scRKqsx2ClLO8uKl/JLxdxkjPSxuUV/2BMcuCAvytjjh9fSgk/o7+pQV4e
	i/Hbjswl6WFVQf6UlAhoWXSGdmbPhBAGcxwi2FBUSwmFy7q0mclN+HFk0JEtdrOxiazN
	ApyA==
X-Gm-Message-State: APjAAAVSs7UHbjWeiGaxS5aseuceC71XgXICPsA0ENnuBfMKbWpel0Ql
	ggeu1Hq2ERjV2IA5qWk7rq39kmrykdc=
X-Google-Smtp-Source: APXvYqygwVcw02BcNlL7Ivb13R0OTjVgbyZcm7A6EnMiEgkT4XjNt3MVJar/LsrOsqa3aqXPqzi1JA==
X-Received: by 2002:a17:902:8302:: with SMTP id
	bd2mr8050069plb.58.1556862842239; 
	Thu, 02 May 2019 22:54:02 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.53.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:01 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:08 +1000
Message-Id: <20190503055316.6441-6-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 05/13] target/ppc: Add privileged
 message send facilities
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055308.xTZtkduY0kX5DGnj-nNl_jTu3o6tvct3nDSHc53WgQ8@z>

Privileged message send facilities exist on POWER8 processors and later
and include a register and instructions which can be used to generate,
observe/modify the state of and clear privileged doorbell exceptions as
described below.

The Directed Privileged Doorbell Exception State (DPDES) register
reflects the state of pending privileged doorbell exceptions and can
also be used to modify that state. The register can be used to read and
modify the state of privileged doorbell exceptions for all threads of a
subprocessor and thus is a shared facility for that subprocessor. The
register can be read/written by the hypervisor and read by the
supervisor if enabled in the HFSCR, otherwise a hypervisor facility
unavailable exception is generated.

The privileged message send and clear instructions (msgsndp & msgclrp)
are used to generate and clear the presence of a directed privileged
doorbell exception, respectively. The msgsndp instruction can be used to
target any thread of the current subprocessor, msgclrp acts on the
thread issuing the instruction. These instructions are privileged, but
will generate a hypervisor facility unavailable exception if not enabled
in the HFSCR and executed in privileged non-hypervisor state.

Add and implement this register and instructions by reading or modifying the
pending interrupt state of the cpu.

Note that TCG only supports one thread per core and so we only need to
worry about the cpu making the access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h                |  7 +++++
 target/ppc/excp_helper.c        | 63 +++++++++++++++++++++++++++++++++++++----
 target/ppc/helper.h             |  5 ++++
 target/ppc/misc_helper.c        | 46 ++++++++++++++++++++++++++++++
 target/ppc/translate.c          | 28 ++++++++++++++++++
 target/ppc/translate_init.inc.c | 40 ++++++++++++++++++++++++++
 6 files changed, 184 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e324064111..1d2a088391 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -425,6 +425,10 @@ typedef struct ppc_v3_pate_t {
 #define PSSCR_ESL         PPC_BIT(42) /* Enable State Loss */
 #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
 
+/* HFSCR bits */
+#define HFSCR_MSGSNDP     PPC_BIT(53) /* Privileged Message Send Facilities */
+#define HFSCR_IC_MSGSNDP  0xA
+
 #define msr_sf   ((env->msr >> MSR_SF)   & 1)
 #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
 #define msr_shv  ((env->msr >> MSR_SHV)  & 1)
@@ -1355,6 +1359,8 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 #endif
 
 void store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask);
+void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, int bit,
+                              int sprn, int cause);
 
 static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 {
@@ -1501,6 +1507,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_MPC_ICTRL         (0x09E)
 #define SPR_MPC_BAR           (0x09F)
 #define SPR_PSPB              (0x09F)
+#define SPR_DPDES             (0x0B0)
 #define SPR_DAWR              (0x0B4)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index beafcf1ebd..7a4da7bdba 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -461,6 +461,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         env->spr[SPR_FSCR] |= ((target_ulong)env->error_code << 56);
 #endif
         break;
+    case POWERPC_EXCP_HV_FU:     /* Hypervisor Facility Unavailable Exception */
+        env->spr[SPR_HFSCR] |= ((target_ulong)env->error_code << FSCR_IC_POS);
+        srr0 = SPR_HSRR0;
+        srr1 = SPR_HSRR1;
+        new_msr |= (target_ulong)MSR_HVB;
+        new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
+        break;
     case POWERPC_EXCP_PIT:       /* Programmable interval timer interrupt    */
         LOG_EXCP("PIT exception\n");
         break;
@@ -884,7 +891,11 @@ static void ppc_hw_interrupt(CPUPPCState *env)
         }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL)) {
             env->pending_interrupts &= ~(1 << PPC_INTERRUPT_DOORBELL);
-            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
+            if (env->insns_flags & PPC_SEGMENT_64B) {
+                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_SDOOR);
+            } else {
+                powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
+            }
             return;
         }
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDOORBELL)) {
@@ -1202,19 +1213,26 @@ void helper_msgsnd(target_ulong rb)
 }
 
 /* Server Processor Control */
-static int book3s_dbell2irq(target_ulong rb)
+static int book3s_dbell2irq(target_ulong rb, bool hv_dbell)
 {
     int msg = rb & DBELL_TYPE_MASK;
 
     /* A Directed Hypervisor Doorbell message is sent only if the
      * message type is 5. All other types are reserved and the
      * instruction is a no-op */
-    return msg == DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL : -1;
+    if (msg == DBELL_TYPE_DBELL_SERVER) {
+        if (hv_dbell)
+            return PPC_INTERRUPT_HDOORBELL;
+        else
+            return PPC_INTERRUPT_DOORBELL;
+    }
+
+    return -1;
 }
 
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
-    int irq = book3s_dbell2irq(rb);
+    int irq = book3s_dbell2irq(rb, 1);
 
     if (irq < 0) {
         return;
@@ -1225,7 +1243,42 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 
 void helper_book3s_msgsnd(target_ulong rb)
 {
-    int irq = book3s_dbell2irq(rb);
+    int irq = book3s_dbell2irq(rb, 1);
+    int pir = rb & DBELL_PROCIDTAG_MASK;
+    CPUState *cs;
+
+    if (irq < 0) {
+        return;
+    }
+
+    qemu_mutex_lock_iothread();
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *cenv = &cpu->env;
+
+        /* TODO: broadcast message to all threads of the same  processor */
+        if (cenv->spr_cb[SPR_PIR].default_value == pir) {
+            cenv->pending_interrupts |= 1 << irq;
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+    qemu_mutex_unlock_iothread();
+}
+
+void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
+{
+    int irq = book3s_dbell2irq(rb, 0);
+
+    if (irq < 0) {
+        return;
+    }
+
+    env->pending_interrupts &= ~(1 << irq);
+}
+
+void helper_book3s_msgsndp(target_ulong rb)
+{
+    int irq = book3s_dbell2irq(rb, 0);
     int pir = rb & DBELL_PROCIDTAG_MASK;
     CPUState *cs;
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6aee195528..040f59d1af 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -657,6 +657,8 @@ DEF_HELPER_1(msgsnd, void, tl)
 DEF_HELPER_2(msgclr, void, env, tl)
 DEF_HELPER_1(book3s_msgsnd, void, tl)
 DEF_HELPER_2(book3s_msgclr, void, env, tl)
+DEF_HELPER_1(book3s_msgsndp, void, tl)
+DEF_HELPER_2(book3s_msgclrp, void, env, tl)
 #endif
 
 DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
@@ -674,6 +676,7 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
 
 DEF_HELPER_2(load_dump_spr, void, env, i32)
 DEF_HELPER_2(store_dump_spr, void, env, i32)
+DEF_HELPER_4(hfscr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_4(msr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
@@ -688,6 +691,8 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_ptcr, void, env, tl)
+DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index c65d1ade15..d7d4acca7f 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -39,6 +39,17 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
 }
 
 #ifdef TARGET_PPC64
+static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
+                                  uint32_t sprn, uint32_t cause,
+                                  uintptr_t raddr)
+{
+    qemu_log("Facility SPR %d is unavailable (SPR HFSCR:%d)\n", sprn, bit);
+
+    env->spr[SPR_HFSCR] &= ~((target_ulong)FSCR_IC_MASK << FSCR_IC_POS);
+
+    raise_exception_err_ra(env, POWERPC_EXCP_HV_FU, cause, raddr);
+}
+
 static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
                                uint32_t sprn, uint32_t cause,
                                uintptr_t raddr)
@@ -53,6 +64,17 @@ static void raise_fu_exception(CPUPPCState *env, uint32_t bit,
 }
 #endif
 
+void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
+                                 uint32_t sprn, uint32_t cause)
+{
+#ifdef TARGET_PPC64
+    if ((env->msr_mask & MSR_HVB) && !msr_hv &&
+                                     !(env->spr[SPR_HFSCR] & (1UL << bit))) {
+        raise_hv_fu_exception(env, bit, sprn, cause, GETPC());
+    }
+#endif
+}
+
 void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
                                 uint32_t sprn, uint32_t cause)
 {
@@ -107,6 +129,30 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
 
     env->spr[SPR_PCR] = value & pcc->pcr_mask;
 }
+
+target_ulong helper_load_dpdes(CPUPPCState *env)
+{
+    helper_hfscr_facility_check(env, HFSCR_MSGSNDP, SPR_DPDES,
+                                HFSCR_IC_MSGSNDP);
+
+    if (env->pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL))
+        return 1;
+    return 0;
+}
+
+void helper_store_dpdes(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    if (val) {
+        /* Only one cpu for now */
+        env->pending_interrupts |= 1 << PPC_INTERRUPT_DOORBELL;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        env->pending_interrupts &= ~(1 << PPC_INTERRUPT_DOORBELL);
+    }
+}
 #endif /* defined(TARGET_PPC64) */
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fb42585a1c..2c3e83d18e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6537,6 +6537,30 @@ static void gen_msgsnd(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
+static void gen_msgclrp(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGSNDP, 0,
+                             HFSCR_IC_MSGSNDP);
+    gen_helper_book3s_msgclrp(cpu_env, cpu_gpr[rB(ctx->opcode)]);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+
+static void gen_msgsndp(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGSNDP, 0,
+                             HFSCR_IC_MSGSNDP);
+    gen_helper_book3s_msgsndp(cpu_gpr[rB(ctx->opcode)]);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+
 static void gen_msgsync(DisasContext *ctx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -7054,6 +7078,10 @@ GEN_HANDLER2_E(msgclr, "msgclr", 0x1F, 0x0E, 0x07, 0x03ff0001,
                PPC_NONE, PPC2_PRCNTL),
 GEN_HANDLER2_E(msgsync, "msgsync", 0x1F, 0x16, 0x1B, 0x00000000,
                PPC_NONE, PPC2_PRCNTL),
+GEN_HANDLER2_E(msgsndp, "msgsndp", 0x1F, 0x0E, 0x04, 0x03ff0001,
+               PPC_NONE, PPC2_ISA207S),
+GEN_HANDLER2_E(msgclrp, "msgclrp", 0x1F, 0x0E, 0x05, 0x03ff0001,
+               PPC_NONE, PPC2_ISA207S),
 GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
 GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 8e287066e5..46f9399097 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -454,6 +454,19 @@ static void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_pcr(cpu_env, cpu_gpr[gprn]);
 }
+
+/* DPDES */
+static void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_hfscr_facility_check(ctx, SPR_HFSCR, HFSCR_MSGSNDP, sprn,
+                             HFSCR_IC_MSGSNDP);
+    gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
+}
+
+static void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
+}
 #endif
 #endif
 
@@ -7478,6 +7491,20 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
 #define POWERPC970_HID5_INIT 0x00000000
 #endif
 
+void gen_hfscr_facility_check(DisasContext *ctx, int facility_sprn, int bit,
+                              int sprn, int cause)
+{
+    TCGv_i32 t1 = tcg_const_i32(bit);
+    TCGv_i32 t2 = tcg_const_i32(sprn);
+    TCGv_i32 t3 = tcg_const_i32(cause);
+
+    gen_helper_hfscr_facility_check(cpu_env, t1, t2, t3);
+
+    tcg_temp_free_i32(t3);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t1);
+}
+
 static void gen_fscr_facility_check(DisasContext *ctx, int facility_sprn,
                                     int bit, int sprn, int cause)
 {
@@ -8249,6 +8276,17 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
 #endif
 }
 
+static void gen_spr_power8_dpdes(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_dpdes, SPR_NOACCESS,
+                        &spr_read_dpdes, &spr_write_dpdes,
+                        KVM_REG_PPC_DPDES, 0x0UL);
+#endif
+}
+
 static void gen_spr_power9_mmu(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -8637,6 +8675,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power8_ic(env);
     gen_spr_power8_book4(env);
     gen_spr_power8_rpr(env);
+    gen_spr_power8_dpdes(env);
 
     /* env variables */
     env->dcache_line_size = 128;
@@ -8826,6 +8865,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power8_ic(env);
     gen_spr_power8_book4(env);
     gen_spr_power8_rpr(env);
+    gen_spr_power8_dpdes(env);
     gen_spr_power9_mmu(env);
 
     /* POWER9 Specific registers */
-- 
2.13.6


