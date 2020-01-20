Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C18C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 02:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A34720678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 02:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BeXuA1cI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A34720678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itMw7-0004fX-EM
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 21:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itMvM-00047c-Mq
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itMvJ-0002bY-In
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:36:20 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49241 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itMvI-0002XW-7j; Sun, 19 Jan 2020 21:36:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481G4p1ysVz9sR1; Mon, 20 Jan 2020 13:36:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579487770;
 bh=Ef1qgzrrzBkGE9FCTDHQqBT8d6jnAwKn1cT81B4U4UE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BeXuA1cICaJujiQ88y6UOYIo+DEn+adHtjrbuZtgN12YfOO1wTJ1XkDEIhYpwCkEj
 cX7kauoGzZBGTcobqqgbPOjOoCwVb0K28+cd8DRm8P97m7hUFdhvbUlFDSN6GA5N7L
 navVKnsrnEAKKkgcOIC2VmwF0ZKC9qK0cwp6rcrk=
Date: Mon, 20 Jan 2020 13:35:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v6 3/3] target/ppc: support single stepping with KVM HV
Message-ID: <20200120023555.GK54439@umbus>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
 <20200110151344.278471-4-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LIxvNfiQb+4m9exP"
Content-Disposition: inline
In-Reply-To: <20200110151344.278471-4-farosas@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LIxvNfiQb+4m9exP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 12:13:44PM -0300, Fabiano Rosas wrote:
> The hardware singlestep mechanism in POWER works via a Trace Interrupt
> (0xd00) that happens after any instruction executes, whenever MSR_SE =3D
> 1 (PowerISA Section 6.5.15 - Trace Interrupt).
>=20
> However, with kvm_hv, the Trace Interrupt happens inside the guest and
> KVM has no visibility of it. Therefore, when the gdbstub uses the
> KVM_SET_GUEST_DEBUG ioctl to enable singlestep, KVM simply ignores it.
>=20
> This patch takes advantage of the Trace Interrupt to perform the step
> inside the guest, but uses a breakpoint at the Trace Interrupt handler
> to return control to KVM. The exit is treated by KVM as a regular
> breakpoint and it returns to the host (and QEMU eventually).
>=20
> Before signalling GDB, QEMU sets the Next Instruction Pointer to the
> instruction following the one being stepped and restores the MSR,
> SRR0, SRR1 values from before the step, effectively skipping the
> interrupt handler execution and hiding the trace interrupt breakpoint
> from GDB.
>=20
> This approach works with both of GDB's 'scheduler-locking' options
> (off, step).
>=20
> Note:
>=20
> - kvm_arch_emulate_singlestep happens after GDB asks for a single step,
>   while the vcpus are stopped.
>=20
> - kvm_handle_singlestep executes after the step, during the handling
>   of the Emulation Assist Interrupt (breakpoint).
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>


> ---
>  hw/ppc/spapr_hcall.c     |   5 +
>  target/ppc/cpu.h         |  21 +++
>  target/ppc/excp_helper.c |  15 ++
>  target/ppc/kvm.c         | 330 ++++++++++++++++++++++++++++++++++++++-
>  target/ppc/kvm_ppc.h     |   6 +-
>  5 files changed, 369 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index f1799b1b70..194b68ed22 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1382,6 +1382,7 @@ static target_ulong h_set_mode_resource_addr_trans_=
mode(PowerPCCPU *cpu,
>                                                          target_ulong val=
ue1,
>                                                          target_ulong val=
ue2)
>  {
> +    CPUState *cs =3D CPU(cpu);
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>      if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
> @@ -1400,6 +1401,10 @@ static target_ulong h_set_mode_resource_addr_trans=
_mode(PowerPCCPU *cpu,
> =20
>      spapr_set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
> =20
> +    if (cs->singlestep_enabled && kvm_enabled()) {
> +        kvm_singlestep_ail_change(cs);
> +    }
> +
>      return H_SUCCESS;
>  }
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 103bfe9dc2..b69f8565aa 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -440,6 +440,10 @@ typedef struct ppc_v3_pate_t {
>  #define msr_ts   ((env->msr >> MSR_TS1)  & 3)
>  #define msr_tm   ((env->msr >> MSR_TM)   & 1)
> =20
> +#define srr1_ir ((env->spr[SPR_SRR1] >> MSR_IR) & 1)
> +#define srr1_dr ((env->spr[SPR_SRR1] >> MSR_DR) & 1)
> +#define srr1_se ((env->spr[SPR_SRR1] >> MSR_SE) & 1)

I'd prefer not to introduce these.  The msr_xx macros are already kind
of dubious because they assume the meaning of 'env' in the context
they're used.  I'm ok to use them because they're so useful, so
often.  These srr1 variants however are used in far fewer situations.
So, I'd prefer to just open code these as (env->spr[SPR_SRR1] &
MSR_IR) in the relatively few places they're used for now.

>  #define DBCR0_ICMP (1 << 27)
>  #define DBCR0_BRT (1 << 26)
>  #define DBSR_ICMP (1 << 27)
> @@ -1158,6 +1162,16 @@ struct CPUPPCState {
>      uint32_t tm_vscr;
>      uint64_t tm_dscr;
>      uint64_t tm_tar;
> +
> +    /* Used for software single step */
> +    target_ulong sstep_srr0;
> +    target_ulong sstep_srr1;
> +    target_ulong sstep_insn;
> +    target_ulong trace_handler_addr;
> +    int sstep_kind;

Won't you need to migrate this extra state, at least some of the time?

> +#define SSTEP_REGULAR 0
> +#define SSTEP_PENDING 1
> +#define SSTEP_GUEST   2

Some comments on what these modes mean would be useful.

>  };
> =20
>  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
> @@ -1251,6 +1265,7 @@ struct PPCVirtualHypervisorClass {
>      OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
>                       TYPE_PPC_VIRTUAL_HYPERVISOR)
> =20
> +target_ulong ppc_get_trace_int_handler_addr(CPUState *cs, bool mmu_on);
>  void ppc_cpu_do_interrupt(CPUState *cpu);
>  bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> @@ -2220,6 +2235,12 @@ enum {
>                          PPC2_ISA300)
>  };
> =20
> +#define OP_RFID 19
> +#define XOP_RFID 18
> +#define OP_MOV 31
> +#define XOP_MFMSR 83
> +#define XOP_MTSPR 467
> +
>  /***********************************************************************=
******/
>  /*
>   * Memory access type :
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 5752ed4a4d..87230f871a 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -784,6 +784,21 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      check_tlb_flush(env, false);
>  }
> =20
> +target_ulong ppc_get_trace_int_handler_addr(CPUState *cs, bool mmu_on)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    int ail =3D AIL_NONE;
> +
> +    /* AIL is only used if translation is enabled */
> +    if (mmu_on) {
> +        ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
> +    }
> +
> +    return env->excp_vectors[POWERPC_EXCP_TRACE] |
> +        ppc_excp_vector_offset(cs, ail);
> +}
> +
>  void ppc_cpu_do_interrupt(CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6fb8687126..2b6cba59c8 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1546,6 +1546,202 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>      nb_hw_breakpoint =3D nb_hw_watchpoint =3D 0;
>  }
> =20
> +static uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint32_t insn;
> +
> +    cpu_memory_rw_debug(cs, addr, (uint8_t *)&insn, sizeof(insn), 0);
> +
> +    if (msr_le) {
> +        return ldl_le_p(&insn);
> +    } else {
> +        return ldl_be_p(&insn);
> +    }

I think you can just use cpu_ldl_code() for this.

> +}
> +
> +static uint32_t ppc_gdb_get_op(uint32_t insn)
> +{
> +    return extract32(insn, 26, 6);
> +}
> +
> +static uint32_t ppc_gdb_get_xop(uint32_t insn)
> +{
> +    return extract32(insn, 1, 10);
> +}
> +
> +static uint32_t ppc_gdb_get_spr(uint32_t insn)
> +{
> +    return extract32(insn, 11, 5) << 5 | extract32(insn, 16, 5);
> +}
> +
> +static uint32_t ppc_gdb_get_rt(uint32_t insn)
> +{
> +    return extract32(insn, 21, 5);
> +}
> +
> +static void kvm_insert_singlestep_breakpoint(CPUState *cs, bool mmu_on)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong bp_addr;
> +    target_ulong saved_msr =3D env->msr;
> +
> +    bp_addr =3D ppc_get_trace_int_handler_addr(cs, mmu_on);
> +    if (env->nip =3D=3D bp_addr) {
> +        /*
> +         * We are trying to step the interrupt handler address itself;
> +         * move the breakpoint to the next instruction.
> +         */
> +        bp_addr +=3D 4;

What if the first instruction of the interrupt handler is a branch?

> +    }
> +
> +    /*
> +     * The actual access by the guest might be made in a mode
> +     * different than we are now (due to rfid) so temporarily set the
> +     * MSR to reflect that during the breakpoint placement.
> +     *
> +     * Note: we need this because breakpoints currently use
> +     * cpu_memory_rw_debug, which does the memory accesses from the
> +     * guest point of view.
> +     */
> +    if ((msr_ir & msr_dr) !=3D mmu_on) {

Should be msr_ir && msr_dr - you only get away with bitwise and by
accident.

> +        if (mmu_on) {
> +            env->msr |=3D (1ULL << MSR_IR | 1ULL << MSR_DR);
> +        } else {
> +            env->msr &=3D ~(1ULL << MSR_IR | 1ULL << MSR_DR);
> +        }
> +    }

Wouldn't it be simpler to unconditionally set env->msr based on
mmu_on.

> +
> +    kvm_insert_breakpoint(cs, bp_addr, 4, GDB_BREAKPOINT_SW);

Hrm.... I don't actually see how changing env->msr helps you here.
AFAICT if kvm_insert_breakpoint() resolves to kvm_arch_sw_breakpoint()
it doesn't rely on the MSR value at all.  If it resolves to
kvm_arch_hw_breakpoint(), then it looks like it just stashes
information to be pushed into KVM when we re-enter the guest.  None of
the information stashed appears to depend on the current MSR, and once
we re-enter the MSR will already have been restored.

> +    env->trace_handler_addr =3D bp_addr;
> +    env->msr =3D saved_msr;
> +}
> +
> +/*
> + * The emulated singlestep works by forcing a Trace Interrupt inside
> + * the guest by setting its MSR_SE bit.  When the guest executes the
> + * instruction, the Trace Interrupt triggers and the step is done. We
> + * then need to hide the fact that the interrupt ever happened before
> + * returning into the guest.
> + *
> + * Since the Trace Interrupt does not set MSR_HV (the whole point of
> + * having to emulate the step), we set a breakpoint at the interrupt
> + * handler address (0xd00) so that it reaches KVM (this is treated by
> + * KVM like an ordinary breakpoint) and control is returned to QEMU.
> + *
> + * There are things to consider before the step (this function):
> + *
> + * - The breakpoint location depends on where the interrupt vectors are,
> + *   which in turn depends on the LPCR_AIL and MSR_IR|DR bits;
> + *
> + * - If the stepped instruction changes the LPCR_AIL, the breakpoint
> + *   location needs to be updated mid-step;
> + *
> + * - If the stepped instruction is rfid, the MSR bits after the step
> + *   will come from SRR1.
> + *
> + *
> + * There are some fixups needed after the step, before returning to
> + * the guest (kvm_handle_singlestep):
> + *
> + * - The interrupt will set SRR0 and SRR1, so we need to restore them
> + *   to what they were before the interrupt;
> + *
> + * - If the stepped instruction wrote to the SRRs, we need to avoid
> + *   undoing that;
> + *
> + * - We set the MSR_SE bit, so it needs to be cleared.
> + *
> + */
> +void kvm_arch_emulate_singlestep(CPUState *cs, int enabled)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint32_t insn;
> +    bool rfid, mmu_on;
> +
> +    if (!enabled) {
> +        return;
> +    }
> +
> +    if (env->sstep_kind !=3D SSTEP_PENDING) {
> +        env->sstep_kind =3D SSTEP_REGULAR;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +    insn =3D ppc_gdb_read_insn(cs, env->nip);
> +
> +    /*
> +     * rfid needs special handling because it:
> +     *   - overwrites NIP with SRR0;
> +     *   - overwrites MSR with SRR1;
> +     *   - cannot be single stepped.
> +     */
> +    rfid =3D ppc_gdb_get_op(insn) =3D=3D OP_RFID && ppc_gdb_get_xop(insn=
) =3D=3D XOP_RFID;
> +
> +    if (rfid && (kvm_find_sw_breakpoint(cs, env->spr[SPR_SRR0]) ||
> +                 env->sstep_kind =3D=3D SSTEP_PENDING)) {
> +        /*
> +         * There is a breakpoint at the next instruction address or a
> +         * pending step. It will already cause the vm exit we need for
> +         * the single step, so there's nothing to be done.
> +         */
> +        env->sstep_kind =3D SSTEP_REGULAR;
> +        return;
> +    }
> +
> +    /*
> +     * Save the registers that will be affected by the single step
> +     * mechanism. These will be used after the step.
> +     */
> +    env->sstep_srr0 =3D env->spr[SPR_SRR0];
> +    env->sstep_srr1 =3D env->spr[SPR_SRR1];
> +    env->sstep_insn =3D insn;
> +
> +    /*
> +     * MSR_SE =3D 1 will cause a Trace Interrupt in the guest after the
> +     * next instruction executes. If this is a rfid, use SRR1 instead
> +     * of MSR.
> +     */
> +    if (rfid) {
> +        if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
> +            /*
> +             * The guest is doing a single step itself. Make sure we
> +             * restore it later.
> +             */
> +            env->sstep_kind =3D SSTEP_GUEST;
> +        }
> +
> +        env->spr[SPR_SRR1] |=3D (1ULL << MSR_SE);
> +        mmu_on =3D srr1_ir & srr1_dr;

s/&/&&/

> +    } else {
> +        env->msr |=3D (1ULL << MSR_SE);
> +        mmu_on =3D msr_ir & msr_dr;

s/&/&&/

Also, what happens if the guest is using MSR[DR] !=3D MSR[IR]?  It's
rare, but it is occasionally useful.

> +    }
> +
> +    kvm_insert_singlestep_breakpoint(cs, mmu_on);
> +}
> +
> +void kvm_singlestep_ail_change(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (kvm_arch_can_singlestep(cs)) {
> +        return;
> +    }
> +
> +    /*
> +     * The instruction being stepped altered the interrupt vectors
> +     * location (AIL). Re-insert the single step breakpoint at the new
> +     * location
> +     */
> +    kvm_remove_breakpoint(cs, env->trace_handler_addr, 4, GDB_BREAKPOINT=
_SW);
> +    kvm_insert_singlestep_breakpoint(cs, (msr_ir & msr_dr));

s/&/&&/

> +}
> +
>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *d=
bg)
>  {
>      int n;
> @@ -1585,6 +1781,98 @@ void kvm_arch_update_guest_debug(CPUState *cs, str=
uct kvm_guest_debug *dbg)
>      }
>  }
> =20
> +/* Revert any side-effects caused during single step */
> +static void restore_singlestep_env(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint32_t insn =3D env->sstep_insn;
> +    int reg;
> +    int spr;
> +
> +    env->spr[SPR_SRR0] =3D env->sstep_srr0;
> +    env->spr[SPR_SRR1] =3D env->sstep_srr1;
> +
> +    if (ppc_gdb_get_op(insn) !=3D OP_MOV) {
> +        return;
> +    }
> +
> +    reg =3D ppc_gdb_get_rt(insn);
> +
> +    switch (ppc_gdb_get_xop(insn)) {
> +    case XOP_MTSPR:
> +        /*
> +         * mtspr: the guest altered the SRR, so do not use the
> +         *        pre-step value.
> +         */
> +        spr =3D ppc_gdb_get_spr(insn);
> +        if (spr =3D=3D SPR_SRR0 || spr =3D=3D SPR_SRR1) {
> +            env->spr[spr] =3D env->gpr[reg];
> +        }
> +        break;
> +    case XOP_MFMSR:
> +        /*
> +         * mfmsr: clear MSR_SE bit to avoid the guest knowing
> +         *         that it is being single-stepped.
> +         */
> +        env->gpr[reg] &=3D ~(1ULL << MSR_SE);

Don't you need to check for the case where the guest also thinks it is
single stepping here?

> +        break;
> +    }
> +}
> +
> +static int kvm_handle_singlestep(CPUState *cs, target_ulong address)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (kvm_arch_can_singlestep(cs)) {
> +        return DEBUG_RETURN_GDB;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +
> +    if (address =3D=3D env->trace_handler_addr) {
> +        kvm_remove_breakpoint(cs, env->trace_handler_addr, 4,
> +                              GDB_BREAKPOINT_SW);
> +
> +        if (env->sstep_kind =3D=3D SSTEP_GUEST) {
> +            /*
> +             * The guest expects the last instruction to have caused a
> +             * single step, go back into the interrupt handler.
> +             */
> +            env->sstep_kind =3D SSTEP_REGULAR;
> +            return DEBUG_RETURN_GDB;
> +        }
> +
> +        env->nip =3D env->spr[SPR_SRR0];
> +        /* Bits 33-36, 43-47 are set by the interrupt */
> +        env->msr =3D env->spr[SPR_SRR1] & ~(1ULL << MSR_SE |
> +                                          PPC_BITMASK(33, 36) |
> +                                          PPC_BITMASK(43, 47));
> +        restore_singlestep_env(cs);
> +
> +    } else if (address =3D=3D env->trace_handler_addr + 4) {
> +        /*
> +         * A step at trace_handler_addr would interfere with the
> +         * single step mechanism itself, so we have previously
> +         * displaced the breakpoint to the next instruction.
> +         */
> +        kvm_remove_breakpoint(cs, env->trace_handler_addr + 4, 4,
> +                              GDB_BREAKPOINT_SW);
> +        restore_singlestep_env(cs);
> +    } else {
> +        /*
> +         * Another interrupt (e.g. system call, program interrupt)
> +         * took us somewhere else in the code and we hit a breakpoint
> +         * there. Mark the step as pending.
> +         */
> +        env->sstep_kind =3D SSTEP_PENDING;
> +    }
> +
> +    cs->singlestep_enabled =3D false;
> +    return DEBUG_RETURN_GDB;
> +}
> +
>  static int kvm_handle_hw_breakpoint(CPUState *cs,
>                                      struct kvm_debug_exit_arch *arch_inf=
o)
>  {
> @@ -1612,13 +1900,41 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>      return handle;
>  }
> =20
> -static int kvm_handle_singlestep(void)
> +static int kvm_handle_sw_breakpoint(CPUState *cs, target_ulong address)
>  {
> -    return DEBUG_RETURN_GDB;
> -}
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (kvm_arch_can_singlestep(cs)) {
> +        return DEBUG_RETURN_GDB;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +
> +    if (address =3D=3D env->trace_handler_addr) {
> +        if (env->sstep_kind =3D=3D SSTEP_PENDING) {
> +            /*
> +             * Although we have singlestep_enabled =3D=3D false by now,
> +             * the original step still wasn't handled (is pending).
> +             */
> +            cs->singlestep_enabled =3D true;
> +            env->sstep_kind =3D SSTEP_REGULAR;
> +
> +            return kvm_handle_singlestep(cs, address);
> +        }
> +
> +        CPU_FOREACH(cs) {
> +            if (cs->singlestep_enabled) {
> +                /*
> +                 * We hit this breakpoint while another cpu is doing a
> +                 * software single step. Go back into the guest to
> +                 * give chance for the single step to finish.
> +                 */
> +                return DEBUG_RETURN_GUEST;
> +            }
> +        }
> +    }
> =20
> -static int kvm_handle_sw_breakpoint(void)
> -{
>      return DEBUG_RETURN_GDB;
>  }
> =20
> @@ -1629,7 +1945,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct=
 kvm_run *run)
>      struct kvm_debug_exit_arch *arch_info =3D &run->debug.arch;
> =20
>      if (cs->singlestep_enabled) {
> -        return kvm_handle_singlestep();
> +        return kvm_handle_singlestep(cs, arch_info->address);
>      }
> =20
>      if (arch_info->status) {
> @@ -1637,7 +1953,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct=
 kvm_run *run)
>      }
> =20
>      if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> -        return kvm_handle_sw_breakpoint();
> +        return kvm_handle_sw_breakpoint(cs, arch_info->address);
>      }
> =20
>      /*
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f22daabf51..dc1b6df422 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -81,7 +81,7 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
>  void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
> -
> +void kvm_singlestep_ail_change(CPUState *cs);
>  #else
> =20
>  static inline uint32_t kvmppc_get_tbfreq(void)
> @@ -211,6 +211,10 @@ static inline void kvmppc_set_reg_tb_offset(PowerPCC=
PU *cpu, int64_t tb_offset)
>  {
>  }
> =20
> +static inline void kvm_singlestep_ail_change(CPUState *cs)
> +{
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static inline bool kvmppc_spapr_use_multitce(void)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LIxvNfiQb+4m9exP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4lEggACgkQbDjKyiDZ
s5L4QBAA3NwkJlE77J3oxJR3z+of2OU2GPuANzYiRgyJzOMpI2kg39CppnUOgU+i
S6D1zDqmBMLCkaIE2QgybibQLxhwVNrRwUg1a1EYrubcRLgQaqFJtQtn03H1fkmi
WLj5vdd9Kc+NATtAxzuvzmx3p+I+bUc1+40AcIN0mJku/Ofw2+QSC4MtTFEaaum4
srwnQ0ZmUzyO0ZwAbTjxbKhi8WfsjceuEhKZtqD2Rr3FLWdvICWhTgqpFRIuhVw3
alGyWgbOGmiX0KI9DRVi10JCzQ71uSUOvmiwbcqcNr45bNTkyMkMgYpzLZExuWEj
mU8RWv7IJAojmmzsuRtIKimf273tEAsqY/xNfXGFYyfP8vP0qWr9yZowx56jg11z
7hJjUNj897BVHWzXfxtttswK0FkqZwqk5SVKYUa9MtGIg0kRgy6TNwTdguXoB/Ac
5CNhUN88zSMmWsi1fpqJ2ErbccnXa6dPhZ+bKPI0gZ/oN6TfNGpEP4M88s4DFpA1
Bywr9fjJeuBGqyaZdS1JJKLYB7QNUwoMDwbbj90060LNMkHytmm6Xi7zoxTsxoU6
kUz578wI9P9AA9TUcB7kY32ogiqmaCUktK7ZuI6jOtguJM+lYXo8owlHJHM90Kco
Zq2hga7GGK3/7ZV2WTf08R4rUrQT+hn0gxzPWEGS+Yt4kYmvHWI=
=5eIc
-----END PGP SIGNATURE-----

--LIxvNfiQb+4m9exP--

