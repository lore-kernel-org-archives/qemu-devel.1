Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29958C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8943214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 05:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FG47AaXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8943214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifGlZ-0005UW-0t
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 00:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGj9-0002Yt-I1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifGj7-0002XK-8m
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 00:09:27 -0500
Received: from ozlabs.org ([203.11.71.1]:35827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifGj4-0002Md-Fd; Thu, 12 Dec 2019 00:09:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47YMJx5q2cz9sPh; Thu, 12 Dec 2019 16:08:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576127329;
 bh=0frvnIHLcG+3VGPEGRBsICzCRzE5LhXqngWijXNzI9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FG47AaXh2MgqZOg/ETSMEwZV2fqm1Z46XG1XCuvknXhn2kWphuUPyTcRZujiYrnEv
 Tb5LxYlcBDiCz4r7/pWGDG5EHqUUkSRbfzAV5AY0syPPUB7E0Ktv+ZgAlcjHCfCvyl
 YFDXBkSoBLjXzHlJOfv3rl1viDGNxakm2DXSXjig=
Date: Thu, 12 Dec 2019 16:08:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] target/ppc: support single stepping with KVM HV
Message-ID: <20191212050841.GV207300@umbus.fritz.box>
References: <20191211191013.454125-1-farosas@linux.ibm.com>
 <20191211191013.454125-4-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jfWagoTHmfL/c8Ax"
Content-Disposition: inline
In-Reply-To: <20191211191013.454125-4-farosas@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--jfWagoTHmfL/c8Ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 04:10:13PM -0300, Fabiano Rosas wrote:
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
> - kvm_arch_set_singlestep happens after GDB asks for a single step,
>   while the vcpus are stopped.
>=20
> - kvm_handle_singlestep executes after the step, during the handling
>   of the Emulation Assist Interrupt (breakpoint).
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/cpu.h         |  16 ++++
>  target/ppc/excp_helper.c |  13 +++
>  target/ppc/gdbstub.c     |  35 +++++++
>  target/ppc/kvm.c         | 195 +++++++++++++++++++++++++++++++++++++--
>  4 files changed, 252 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e3e82327b7..37119cd0b4 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1156,6 +1156,11 @@ struct CPUPPCState {
>      uint32_t tm_vscr;
>      uint64_t tm_dscr;
>      uint64_t tm_tar;
> +
> +    /* Used for software single step */
> +    target_ulong sstep_msr;
> +    target_ulong sstep_srr0;
> +    target_ulong sstep_srr1;

Do we need to migrate these?

>  };
> =20
>  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
> @@ -1253,6 +1258,7 @@ struct PPCVirtualHypervisorClass {
>      OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
>                       TYPE_PPC_VIRTUAL_HYPERVISOR)
> =20
> +target_ulong ppc_get_trace_int_handler_addr(CPUState *cs);
>  void ppc_cpu_do_interrupt(CPUState *cpu);
>  bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> @@ -1266,6 +1272,12 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cpu=
, uint8_t *buf, int reg);
>  void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
>  const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
>  #endif
> +uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr);

AFAICT this is only used within the KVM code, so why does it need to
be public?

> +uint32_t ppc_gdb_get_op(uint32_t insn);
> +uint32_t ppc_gdb_get_xop(uint32_t insn);
> +uint32_t ppc_gdb_get_spr(uint32_t insn);
> +uint32_t ppc_gdb_get_rt(uint32_t insn);
> +
>  int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> @@ -2217,6 +2229,10 @@ enum {
>                          PPC2_ISA300)
>  };
> =20
> +#define XOP_RFID 18
> +#define XOP_MFMSR 83
> +#define XOP_MTSPR 467
> +
>  /***********************************************************************=
******/
>  /*
>   * Memory access type :
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 50b004d00d..8ce395004a 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -112,6 +112,8 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs, =
int ail)
>      uint64_t offset =3D 0;
> =20
>      switch (ail) {
> +    case AIL_NONE:
> +        break;

How did we get away with missing this case before?  I think this might
be clearer as a preliminary fixup patch.

>      case AIL_0001_8000:
>          offset =3D 0x18000;
>          break;
> @@ -782,6 +784,17 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      check_tlb_flush(env, false);
>  }
> =20
> +target_ulong ppc_get_trace_int_handler_addr(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    int ail;
> +
> +    ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
> +    return env->excp_vectors[POWERPC_EXCP_TRACE] |
> +        ppc_excp_vector_offset(cs, ail);
> +}
> +
>  void ppc_cpu_do_interrupt(CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 823759c92e..540b767445 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -383,3 +383,38 @@ const char *ppc_gdb_get_dynamic_xml(CPUState *cs, co=
nst char *xml_name)
>      return NULL;
>  }
>  #endif
> +
> +uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr)
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

I feel like there must be existing places that need to read
instructions, so I'm wondering why we need a new helper.

> +}
> +
> +uint32_t ppc_gdb_get_op(uint32_t insn)
> +{
> +    return extract32(insn, 26, 6);
> +}
> +
> +uint32_t ppc_gdb_get_xop(uint32_t insn)
> +{
> +    return extract32(insn, 1, 10);
> +}
> +
> +uint32_t ppc_gdb_get_spr(uint32_t insn)
> +{
> +    return extract32(insn, 11, 5) << 5 | extract32(insn, 16, 5);
> +}
> +
> +uint32_t ppc_gdb_get_rt(uint32_t insn)
> +{
> +    return extract32(insn, 21, 5);
> +}

These are all used in just the KVM code rather than the gdbstub code
directly, so this seems an odd place to put them.

> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3a2cfe883c..fedb8e787d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1542,6 +1542,86 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>      nb_hw_breakpoint =3D nb_hw_watchpoint =3D 0;
>  }
> =20
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong trace_handler_addr;
> +    uint32_t insn;
> +    bool rfid;
> +
> +    if (!enabled) {
> +        return;
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
> +    rfid =3D ppc_gdb_get_op(insn) =3D=3D 19 && ppc_gdb_get_xop(insn) =3D=
=3D
> XOP_RFID;

A symbolic constant rather than '19' would be nice.

> +
> +    if (rfid && kvm_find_sw_breakpoint(cs, env->spr[SPR_SRR0])) {
> +        /*
> +         * There is a breakpoint at the next instruction address. It
> +         * will already cause the vm exit we need for the single step,
> +         * so there's nothing to be done.
> +         */
> +        return;
> +    }
> +
> +    /*
> +     * Save the registers that will be affected by the single step
> +     * mechanism. These will be restored after the step at
> +     * kvm_handle_singlestep.
> +     */
> +    env->sstep_msr =3D env->msr;
> +    env->sstep_srr0 =3D env->spr[SPR_SRR0];
> +    env->sstep_srr1 =3D env->spr[SPR_SRR1];

Do we really need to save both MSR and SRR1?  AFAICT we check for one
bit in sstep_msr, but we never restore it or otherwise look at it.

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
> +            env->sstep_msr |=3D (1ULL << MSR_SE);
> +        }
> +
> +        env->spr[SPR_SRR1] |=3D (1ULL << MSR_SE);
> +    } else {
> +        env->msr |=3D (1ULL << MSR_SE);
> +    }
> +
> +    /*
> +     * We set a breakpoint at the interrupt handler address so
> +     * that the singlestep will be seen by KVM (this is treated by
> +     * KVM like an ordinary breakpoint) and control is returned to
> +     * QEMU.
> +     */
> +    trace_handler_addr =3D ppc_get_trace_int_handler_addr(cs);

What happens if the instruction we're setting changes the AIL value?

> +    if (env->nip =3D=3D trace_handler_addr) {
> +        /*
> +         * We are trying to step over the interrupt handler
> +         * address itself; move the breakpoint to the next
> +         * instruction.
> +         */
> +        trace_handler_addr +=3D 4;
> +    }
> +
> +    kvm_insert_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
> +}
> +
>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *d=
bg)
>  {
>      int n;
> @@ -1581,6 +1661,91 @@ void kvm_arch_update_guest_debug(CPUState *cs, str=
uct kvm_guest_debug *dbg)
>      }
>  }
> =20
> +/* Revert any side-effects caused during single step */
> +static void restore_singlestep_env(CPUState *cs)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint32_t insn;
> +    int reg;
> +    int spr;
> +
> +    insn =3D ppc_gdb_read_insn(cs, env->spr[SPR_SRR0] - 4);

Is the -4 always correct, even for branching instructions?

> +
> +    env->spr[SPR_SRR0] =3D env->sstep_srr0;
> +    env->spr[SPR_SRR1] =3D env->sstep_srr1;
> +
> +    if (ppc_gdb_get_op(insn) !=3D 31) {
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

I don't really understand why we need this.

> +        break;
> +    case XOP_MFMSR:
> +        /*
> +         * mfmsr: clear MSR_SE bit to avoid the guest knowing
> +         *         that it is being single-stepped.
> +         */
> +        env->gpr[reg] &=3D ~(1ULL << MSR_SE);

Shouldn't we be checking if the guest *also* set single stepping for
itself, and reporting it in that case?

> +        break;
> +    }
> +}
> +
> +static int kvm_handle_singlestep(CPUState *cs, target_ulong address)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong trace_handler_addr;
> +
> +    if (cap_ppc_singlestep) {
> +        return 1;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +    trace_handler_addr =3D ppc_get_trace_int_handler_addr(cs);

Again, what happens if the stepped instruction changes AIL?

> +    if (address =3D=3D trace_handler_addr) {
> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_=
SW);
> +
> +        if (env->sstep_msr & (1ULL << MSR_SE)) {
> +            /*
> +             * The guest expects the last instruction to have caused a
> +             * single step, go back into the interrupt handler.
> +             */
> +            return 1;
> +        }
> +
> +        env->nip =3D env->spr[SPR_SRR0];
> +        /* Bits 33-36, 43-47 are set by the interrupt */
> +        env->msr =3D env->spr[SPR_SRR1] & ~(1ULL << MSR_SE |
> +                                          PPC_BITMASK(33, 36) |
> +                                          PPC_BITMASK(43, 47));
> +        restore_singlestep_env(cs);
> +
> +    } else if (address =3D=3D trace_handler_addr + 4) {
> +        /*
> +         * A step at trace_handler_addr would interfere with the
> +         * singlestep mechanism itself, so we have previously
> +         * displaced the breakpoint to the next instruction.
> +         */
> +        kvm_remove_breakpoint(cs, trace_handler_addr + 4, 4, GDB_BREAKPO=
INT_SW);
> +        restore_singlestep_env(cs);
> +    }

And if the address is neither of those things..?  Is that an error, or
is that a no-op?

> +
> +    return 1;
> +}
> +
>  static int kvm_handle_hw_breakpoint(CPUState *cs,
>                                      struct kvm_debug_exit_arch *arch_inf=
o)
>  {
> @@ -1608,13 +1773,29 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>      return handle;
>  }
> =20
> -static int kvm_handle_singlestep(void)
> +static int kvm_handle_sw_breakpoint(CPUState *cs, target_ulong address)
>  {
> -    return 1;
> -}
> +    target_ulong trace_handler_addr;
> =20
> -static int kvm_handle_sw_breakpoint(void)
> -{
> +    if (cap_ppc_singlestep) {
> +        return 1;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +    trace_handler_addr =3D ppc_get_trace_int_handler_addr(cs);
> +
> +    if (address =3D=3D trace_handler_addr) {
> +        CPU_FOREACH(cs) {
> +            if (cs->singlestep_enabled) {
> +                /*
> +                 * We hit this breakpoint while another cpu is doing a
> +                 * software single step. Go back into the guest to
> +                 * give chance for the single step to finish.
> +                 */
> +                return 0;
> +            }
> +        }
> +    }
>      return 1;
>  }
> =20
> @@ -1625,7 +1806,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct=
 kvm_run *run)
>      struct kvm_debug_exit_arch *arch_info =3D &run->debug.arch;
> =20
>      if (cs->singlestep_enabled) {
> -        return kvm_handle_singlestep();
> +        return kvm_handle_singlestep(cs, arch_info->address);
>      }
> =20
>      if (arch_info->status) {
> @@ -1633,7 +1814,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct=
 kvm_run *run)
>      }
> =20
>      if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> -        return kvm_handle_sw_breakpoint();
> +        return kvm_handle_sw_breakpoint(cs, arch_info->address);
>      }
> =20
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jfWagoTHmfL/c8Ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3xy1UACgkQbDjKyiDZ
s5LxCQ//V6WftiZgOAPDUY+5Cl+NO3AIhlXgT50sq+dzP7gcwowNqzDGxmddz1GL
0upbaZfH7/4tTP7hvDavdwBIgbwLCycb98bOkmQOQjh5Lk8a0Pp8lHFfJAXi+IWz
srkivJXwLmxMCKb9MUAsveNApyAtyAqYNO7KOKqcuEIkM5aAD5C6RAlLf+y7NgSe
uuHSEQ4dj1ygMEMUZWXM0LNQ6U2IMkLAc8FDkILml2YRbF7jne9vmD4+fychFU8Z
kORNmQYwVqEwcqTDVF78QSNDdPxl2OS8xYFWcWSN2SRvcS91KfTCMJ1rrnphjHZI
3rwtjzZrwCaEumc0Nc5CPeHbhT3JqkZmuLYBjkS/opcvfkle5FTrcStASeNpBVzD
vnHjfiOSl1Tr5SFggZ7j3vaiCvuNt4B8UgpNQdEuzicijngTWaoDx9TFU7Du4SlG
zn+4ZSTkek/BXDDdAUz+/DT4S44+QJeuITyDjtHd3Z1pvE+u+qGh+s/9t0DmwOzK
v3UfIhkgefkbjRtnzq9KAl7Vsa3RpoQjQfVcDEhvmBrCom5hs0keeL9lgTomJ1Hc
YGUgwHQkoAN4Wk6RChJf0E2uvmjjwppyGHFa6Yv1R/F/3d8AwbL+b6oAQCgi4Hl4
mcchbiYDBuSKFznRHBnP42iuTDpIB4+opdMI+lmOtiJGV6HTuZU=
=iYPV
-----END PGP SIGNATURE-----

--jfWagoTHmfL/c8Ax--

