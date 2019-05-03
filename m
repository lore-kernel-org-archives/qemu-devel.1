Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB64DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B32053B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFR1n3Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B32053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35169 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRM9-0008Qz-T4
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:07:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9O-0005cz-KD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9M-0003Dh-9h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:35332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9M-0003D4-0r; Fri, 03 May 2019 01:54:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id t87so1770194pfa.2;
	Thu, 02 May 2019 22:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WVKzTubn+fwCm8+EatH1HPYZd3qCwfmXk8iyRF28f6I=;
	b=eFR1n3PiP+zG5i9ZEZTy52GGaMrA4xyDfc5F5lpXP7RRbXzIK6FgEafxRjOCWXSFPV
	B6EvGne+vtt0PjNV/7J5TgX18W4a9QfSUbrUt3PNB+Nuynd1Tv4j080IwpgvV+lFPYnY
	5XDiZI2ibxjAGuFTgR/r776MA12QP00P5wWS4g6Y/BkWj1k3iWSo65ST/rAzE3aCROZB
	mihIXvE/db00zX/9HuaSI4KntsxeeU9YTkJstQCK2PgjRao9CEuudWTJR3HRibsm5+eH
	cJGCcNlAwAHgUZ3ojJTz2RpH8XXte49v9kkKd4zQkxqVDxqQRzRJ29xo6L5GquauYxAZ
	WUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WVKzTubn+fwCm8+EatH1HPYZd3qCwfmXk8iyRF28f6I=;
	b=hFOXS/EpI0h88buMJc84ikbU8916cTqKJT40HszQQ3K8FX6lqMNGaO/JDUk8/UcUtc
	YfQiO+ff1pyIzCkkZ+5g8cPZUYkgaXf3swftluriLGYpT6j0KTVsSdTjQIo2VfN7Y52a
	O4rnHn75QQBnRnuLSfzSiZ7yy0FXMlachZ9P6Pla3eQkzpwHDnQA0hXpzHPqqMDdwIZz
	In7VE0x8RHINoUGrnatXj4mJpJyCOhZVW9gz4XzePnELnYimP6Y/449bpQcnVCemjuVI
	azq7j8vEXRUQdzJ3+4DVQaZycqbJ9PDIX4R2iLo9G73kAdRkVfA1NUnXp/65zsL96OrD
	UTUQ==
X-Gm-Message-State: APjAAAX7w9FKvizoxi7Z77LOHnx4eQxQY4AGd/OVZPl/88RLNFLbj4ZT
	1aZbM6Ov0pAsDRlwZcQNASaO+TZDYUE=
X-Google-Smtp-Source: APXvYqzqWHDv0/ctB3M21d60dXgM8SgXMhdhrtOK1n65M9QT2D9yT1Z45C5tGpJIEndRkA64PiBF8w==
X-Received: by 2002:a63:fd58:: with SMTP id m24mr8025283pgj.298.1556862862372; 
	Thu, 02 May 2019 22:54:22 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:21 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:12 +1000
Message-Id: <20190503055316.6441-10-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42c
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 09/13] target/ppc: Implement hcall
 H_ENTER_NESTED
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
Message-ID: <20190503055312.l0VguLoDysg1ur4dxJuRde8Usgdo2Y9UhI0-gEk1usA@z>

The hcall H_ENTER_NESTED is used by a guest acting as a nested
hypervisor to provide the state of one of its guests which it would
like the real hypervisor to load onto the cpu and execute on its behalf.

The hcall takes as arguments 2 guest real addresses which provide the
location of a regs struct and a hypervisor regs struct which provide the
values to use to execute the guest. These are loaded into the cpu state
and then the function returns to continue tcg execution in the new
context. When an interrupt requires us to context switch back we restore
the old register values and save the cpu state back into the guest
memory.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c     | 285 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h   |   3 +-
 target/ppc/cpu.h         |  55 +++++++++
 target/ppc/excp_helper.c |  13 ++-
 4 files changed, 353 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 704ceff8e1..68f3282214 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -16,6 +16,7 @@
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
+#include "hw/ppc/ppc.h"
 
 static bool has_spr(PowerPCCPU *cpu, int spr)
 {
@@ -1847,6 +1848,289 @@ static target_ulong h_set_partition_table(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static void byteswap_pt_regs(struct pt_regs *regs)
+{
+    target_ulong *addr = (target_ulong *) regs;
+
+    for (; addr < ((target_ulong *) (regs + 1)); addr++) {
+        *addr = bswap64(*addr);
+    }
+}
+
+static void byteswap_hv_regs(struct hv_guest_state *hr)
+{
+    hr->version = bswap64(hr->version);
+    hr->lpid = bswap32(hr->lpid);
+    hr->vcpu_token = bswap32(hr->vcpu_token);
+    hr->lpcr = bswap64(hr->lpcr);
+    hr->pcr = bswap64(hr->pcr);
+    hr->amor = bswap64(hr->amor);
+    hr->dpdes = bswap64(hr->dpdes);
+    hr->hfscr = bswap64(hr->hfscr);
+    hr->tb_offset = bswap64(hr->tb_offset);
+    hr->dawr0 = bswap64(hr->dawr0);
+    hr->dawrx0 = bswap64(hr->dawrx0);
+    hr->ciabr = bswap64(hr->ciabr);
+    hr->hdec_expiry = bswap64(hr->hdec_expiry);
+    hr->purr = bswap64(hr->purr);
+    hr->spurr = bswap64(hr->spurr);
+    hr->ic = bswap64(hr->ic);
+    hr->vtb = bswap64(hr->vtb);
+    hr->hdar = bswap64(hr->hdar);
+    hr->hdsisr = bswap64(hr->hdsisr);
+    hr->heir = bswap64(hr->heir);
+    hr->asdr = bswap64(hr->asdr);
+    hr->srr0 = bswap64(hr->srr0);
+    hr->srr1 = bswap64(hr->srr1);
+    hr->sprg[0] = bswap64(hr->sprg[0]);
+    hr->sprg[1] = bswap64(hr->sprg[1]);
+    hr->sprg[2] = bswap64(hr->sprg[2]);
+    hr->sprg[3] = bswap64(hr->sprg[3]);
+    hr->pidr = bswap64(hr->pidr);
+    hr->cfar = bswap64(hr->cfar);
+    hr->ppr = bswap64(hr->ppr);
+}
+
+static void save_regs(PowerPCCPU *cpu, struct pt_regs *regs)
+{
+    CPUPPCState env = cpu->env;
+    int i;
+
+    for (i = 0; i < 32; i++)
+        regs->gpr[i] = env.gpr[i];
+    regs->nip = env.nip;
+    regs->msr = env.msr;
+    regs->ctr = env.ctr;
+    regs->link = env.lr;
+    regs->xer = env.xer;
+    regs->ccr = 0UL;
+    for (i = 0; i < 8; i++)
+        regs->ccr |= ((env.crf[i] & 0xF) << ((7 - i) * 4));
+    regs->dar = env.spr[SPR_DAR];
+    regs->dsisr = env.spr[SPR_DSISR];
+}
+
+static void save_hv_regs(PowerPCCPU *cpu, struct hv_guest_state *hv_regs)
+{
+    CPUPPCState env = cpu->env;
+
+    hv_regs->lpid = env.spr[SPR_LPIDR];
+    hv_regs->lpcr = env.spr[SPR_LPCR];
+    hv_regs->pcr = env.spr[SPR_PCR];
+    hv_regs->amor = env.spr[SPR_AMOR];
+    hv_regs->dpdes = !!(env.pending_interrupts & (1 << PPC_INTERRUPT_DOORBELL));
+    hv_regs->hfscr = env.spr[SPR_HFSCR];
+    hv_regs->tb_offset = env.tb_env->tb_offset;
+    hv_regs->dawr0 = env.spr[SPR_DAWR];
+    hv_regs->dawrx0 = env.spr[SPR_DAWRX];
+    hv_regs->ciabr = env.spr[SPR_CIABR];
+    hv_regs->purr = cpu_ppc_load_purr(&env);
+    hv_regs->spurr = cpu_ppc_load_purr(&env);
+    hv_regs->ic = env.spr[SPR_IC];
+    hv_regs->vtb = cpu_ppc_load_vtb(&env);
+    hv_regs->hdar = env.spr[SPR_HDAR];
+    hv_regs->hdsisr = env.spr[SPR_HDSISR];
+    hv_regs->asdr = env.spr[SPR_ASDR];
+    hv_regs->srr0 = env.spr[SPR_SRR0];
+    hv_regs->srr1 = env.spr[SPR_SRR1];
+    hv_regs->sprg[0] = env.spr[SPR_SPRG0];
+    hv_regs->sprg[1] = env.spr[SPR_SPRG1];
+    hv_regs->sprg[2] = env.spr[SPR_SPRG2];
+    hv_regs->sprg[3] = env.spr[SPR_SPRG3];
+    hv_regs->pidr = env.spr[SPR_BOOKS_PID];
+    hv_regs->cfar = env.cfar;
+    hv_regs->ppr = env.spr[SPR_PPR];
+}
+
+static void restore_regs(PowerPCCPU *cpu, struct pt_regs regs)
+{
+    CPUPPCState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < 32; i++)
+        env->gpr[i] = regs.gpr[i];
+    env->nip = regs.nip;
+    ppc_store_msr(env, regs.msr);
+    env->ctr = regs.ctr;
+    env->lr = regs.link;
+    env->xer = regs.xer;
+    for (i = 0; i < 8; i++)
+        env->crf[i] = (regs.ccr >> ((7 - i) * 4)) & 0xF;
+    env->spr[SPR_DAR] = regs.dar;
+    env->spr[SPR_DSISR] = regs.dsisr;
+}
+
+static void restore_hv_regs(PowerPCCPU *cpu, struct hv_guest_state hv_regs)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL | LPCR_LD
+                                       | LPCR_LPES0 | LPCR_LPES1 | LPCR_MER;
+
+    env->spr[SPR_LPIDR] = hv_regs.lpid;
+    ppc_store_lpcr(cpu, (hv_regs.lpcr & lpcr_mask) |
+                        (env->spr[SPR_LPCR] & ~lpcr_mask));
+    env->spr[SPR_PCR] = hv_regs.pcr;
+    env->spr[SPR_AMOR] = hv_regs.amor;
+    if (hv_regs.dpdes) {
+        env->pending_interrupts |= 1 << PPC_INTERRUPT_DOORBELL;
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    } else {
+        env->pending_interrupts &= ~(1 << PPC_INTERRUPT_DOORBELL);
+    }
+    env->spr[SPR_HFSCR] = hv_regs.hfscr;
+    env->spr[SPR_DAWR] = hv_regs.dawr0;
+    env->spr[SPR_DAWRX] = hv_regs.dawrx0;
+    env->spr[SPR_CIABR] = hv_regs.ciabr;
+    cpu_ppc_store_purr(env, hv_regs.purr);      /* for TCG PURR == SPURR */
+    env->spr[SPR_IC] = hv_regs.ic;
+    cpu_ppc_store_vtb(env, hv_regs.vtb);
+    env->spr[SPR_HDAR] = hv_regs.hdar;
+    env->spr[SPR_HDSISR] = hv_regs.hdsisr;
+    env->spr[SPR_ASDR] = hv_regs.asdr;
+    env->spr[SPR_SRR0] = hv_regs.srr0;
+    env->spr[SPR_SRR1] = hv_regs.srr1;
+    env->spr[SPR_SPRG0] = hv_regs.sprg[0];
+    env->spr[SPR_SPRG1] = hv_regs.sprg[1];
+    env->spr[SPR_SPRG2] = hv_regs.sprg[2];
+    env->spr[SPR_SPRG3] = hv_regs.sprg[3];
+    env->spr[SPR_BOOKS_PID] = hv_regs.pidr;
+    env->cfar = hv_regs.cfar;
+    env->spr[SPR_PPR] = hv_regs.ppr;
+    tlb_flush(CPU(cpu));
+}
+
+static void sanitise_hv_regs(PowerPCCPU *cpu, struct hv_guest_state *hv_regs)
+{
+    CPUPPCState env = cpu->env;
+
+    /* Apply more restrictive set of facilities */
+    hv_regs->hfscr &= ((0xFFUL << 56) | env.spr[SPR_HFSCR]);
+
+    /* Don't match on hypervisor address */
+    hv_regs->dawrx0 &= ~(1UL << 2);
+
+    /* Don't match on hypervisor address */
+    if ((hv_regs->ciabr & 0x3) == 0x3)
+        hv_regs->ciabr &= ~0x3UL;
+}
+
+static inline bool needs_byteswap(const CPUPPCState *env)
+{
+#if defined(HOST_WORDS_BIGENDIAN)
+    return msr_le;
+#else
+    return !msr_le;
+#endif
+}
+
+static target_ulong h_enter_nested(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                   target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    env->hv_ptr = args[0];
+    env->regs_ptr = args[1];
+    uint64_t hdec;
+
+    assert(env->spr[SPR_LPIDR] == 0);
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    if (!env->has_hv_mode || !ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                                               spapr->max_compat_pvr)
+                          || !ppc64_v3_radix(cpu)) {
+        error_report("pseries guest support only implemented for POWER9 radix\n");
+        return H_HARDWARE;
+    }
+
+    if (!env->spr[SPR_PTCR])
+        return H_NOT_AVAILABLE;
+
+    memset(&env->l1_saved_hv, 0, sizeof(env->l1_saved_hv));
+    memset(&env->l1_saved_regs, 0, sizeof(env->l1_saved_regs));
+
+    /* load l2 state from l1 memory */
+    cpu_physical_memory_read(env->hv_ptr, &env->l2_hv, sizeof(env->l2_hv));
+    if (needs_byteswap(env)) {
+        byteswap_hv_regs(&env->l2_hv);
+    }
+    if (env->l2_hv.version != 1)
+        return H_P2;
+    if (env->l2_hv.lpid == 0)
+        return H_P2;
+    if (!(env->l2_hv.lpcr & LPCR_HR)) {
+        error_report("pseries guest support only implemented for POWER9 radix guests\n");
+        return H_P2;
+    }
+
+    cpu_physical_memory_read(env->regs_ptr, &env->l2_regs, sizeof(env->l2_regs));
+    if (needs_byteswap(env)) {
+        byteswap_pt_regs(&env->l2_regs);
+    }
+
+    /* save l1 values of things */
+    save_regs(cpu, &env->l1_saved_regs);
+    save_hv_regs(cpu, &env->l1_saved_hv);
+
+    /* adjust for timebase */
+    hdec = env->l2_hv.hdec_expiry - cpu_ppc_load_tbl(env);
+    env->tb_env->tb_offset += env->l2_hv.tb_offset;
+    /* load l2 values of things */
+    sanitise_hv_regs(cpu, &env->l2_hv);
+    restore_regs(cpu, env->l2_regs);
+    env->msr &= ~MSR_HVB;
+    restore_hv_regs(cpu, env->l2_hv);
+    cpu_ppc_store_hdecr(env, hdec);
+
+    assert(env->spr[SPR_LPIDR] != 0);
+
+    return env->gpr[3];
+}
+
+void h_exit_nested(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    uint64_t delta_purr, delta_ic, delta_vtb;
+    target_ulong trap = env->nip;
+
+    assert(env->spr[SPR_LPIDR] != 0);
+
+    /* save l2 values of things */
+    if (trap == 0x100 || trap == 0x200 || trap == 0xc00) {
+        env->nip = env->spr[SPR_SRR0];
+        env->msr = env->spr[SPR_SRR1];
+    } else {
+        env->nip = env->spr[SPR_HSRR0];
+        env->msr = env->spr[SPR_HSRR1];
+    }
+    save_regs(cpu, &env->l2_regs);
+    delta_purr = cpu_ppc_load_purr(env) - env->l2_hv.purr;
+    delta_ic = env->spr[SPR_IC] - env->l2_hv.ic;
+    delta_vtb = cpu_ppc_load_vtb(env) - env->l2_hv.vtb;
+    save_hv_regs(cpu, &env->l2_hv);
+
+    /* restore l1 state */
+    restore_regs(cpu, env->l1_saved_regs);
+    env->tb_env->tb_offset = env->l1_saved_hv.tb_offset;
+    env->l1_saved_hv.purr += delta_purr;
+    env->l1_saved_hv.ic += delta_ic;
+    env->l1_saved_hv.vtb += delta_vtb;
+    restore_hv_regs(cpu, env->l1_saved_hv);
+
+    /* save l2 state back to l1 memory */
+    if (needs_byteswap(env)) {
+        byteswap_hv_regs(&env->l2_hv);
+        byteswap_pt_regs(&env->l2_regs);
+    }
+    cpu_physical_memory_write(env->hv_ptr, &env->l2_hv, sizeof(env->l2_hv));
+    cpu_physical_memory_write(env->regs_ptr, &env->l2_regs, sizeof(env->l2_regs));
+
+    assert(env->spr[SPR_LPIDR] == 0);
+
+    env->gpr[3] = trap;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1955,6 +2239,7 @@ static void hypercall_register_types(void)
 
     /* Platform-specific hcalls used for nested HV KVM */
     spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
+    spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
 
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e591ee0ba0..7083dea9ef 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -503,7 +503,8 @@ struct SpaprMachineState {
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
 /* Platform-specific hcalls used for nested HV KVM */
 #define H_SET_PARTITION_TABLE   0xF800
-#define KVMPPC_HCALL_MAX        H_SET_PARTITION_TABLE
+#define H_ENTER_NESTED          0xF804
+#define KVMPPC_HCALL_MAX        H_ENTER_NESTED
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3acc248f40..426015c9cd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -982,6 +982,54 @@ struct ppc_radix_page_info {
 #define PPC_CPU_OPCODES_LEN          0x40
 #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
 
+struct pt_regs {
+    target_ulong gpr[32];
+    target_ulong nip;
+    target_ulong msr;
+    target_ulong orig_gpr3;
+    target_ulong ctr;
+    target_ulong link;
+    target_ulong xer;
+    target_ulong ccr;
+    target_ulong softe;
+    target_ulong trap;
+    target_ulong dar;
+    target_ulong dsisr;
+    target_ulong result;
+};
+
+struct hv_guest_state {
+    uint64_t version;            /* version of this structure layout */
+    uint32_t lpid;
+    uint32_t vcpu_token;
+    /* These registers are hypervisor privileged (at least for writing) */
+    uint64_t lpcr;
+    uint64_t pcr;
+    uint64_t amor;
+    uint64_t dpdes;
+    uint64_t hfscr;
+    int64_t  tb_offset;
+    uint64_t dawr0;
+    uint64_t dawrx0;
+    uint64_t ciabr;
+    uint64_t hdec_expiry;
+    uint64_t purr;
+    uint64_t spurr;
+    uint64_t ic;
+    uint64_t vtb;
+    uint64_t hdar;
+    uint64_t hdsisr;
+    uint64_t heir;
+    uint64_t asdr;
+    /* These are OS privileged but need to be set late in guest entry */
+    uint64_t srr0;
+    uint64_t srr1;
+    uint64_t sprg[4];
+    uint64_t pidr;
+    uint64_t cfar;
+    uint64_t ppr;
+};
+
 struct CPUPPCState {
     /* First are the most commonly used resources
      * during translated code execution
@@ -1184,6 +1232,11 @@ struct CPUPPCState {
     uint32_t tm_vscr;
     uint64_t tm_dscr;
     uint64_t tm_tar;
+
+    /* used to store register state when running a nested kvm guest */
+    target_ulong hv_ptr, regs_ptr;
+    struct hv_guest_state l2_hv, l1_saved_hv;
+    struct pt_regs l2_regs, l1_saved_regs;
 };
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
@@ -2647,4 +2700,6 @@ static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
+
+void h_exit_nested(PowerPCCPU *cpu);
 #endif /* PPC_CPU_H */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 10091d4624..9470c02512 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -347,7 +347,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         env->nip += 4;
 
         /* "PAPR mode" built-in hypercall emulation */
-        if ((lev == 1) && cpu->vhyp) {
+        if ((lev == 1) && (cpu->vhyp && (env->spr[SPR_LPIDR] == 0))) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
@@ -664,7 +664,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     env->spr[srr1] = msr;
 
     /* Sanity check */
-    if (!(env->msr_mask & MSR_HVB)) {
+    if (!(env->msr_mask & MSR_HVB) && (env->spr[SPR_LPIDR] == 0)) {
         if (new_msr & MSR_HVB) {
             cpu_abort(cs, "Trying to deliver HV exception (MSR) %d with "
                       "no HV support\n", excp);
@@ -770,6 +770,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     /* Reset the reservation */
     env->reserve_addr = -1;
 
+    if ((!(env->msr_mask & MSR_HVB) && (new_msr & MSR_HVB))) {
+        /*
+         * We were in a guest, but this interrupt is setting the MSR[HV] bit
+         * meaning we want to handle this at l1. Call h_exit_nested to context
+         * switch back.
+         */
+        h_exit_nested(cpu);
+    }
+
     /* Any interrupt is context synchronizing, check if TCG TLB
      * needs a delayed flush on ppc64
      */
-- 
2.13.6


