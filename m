Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C2C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406262182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EMxZWtlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406262182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvlI-0001lP-Au
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 22:59:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjN-0000WF-C9
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjK-0001B5-Rm
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41315 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjK-00019q-6K; Thu, 09 May 2019 22:57:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdM5k1Xz9sBr; Fri, 10 May 2019 12:57:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457063;
	bh=vbH+zcrFjX5QKI3JrwSarUWrTFkHBlGRfwFWPdIKa5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMxZWtlkub8+Gc8L+oUwnTgCS4IgiGI/9MDFBEPaZk/qes95KB0AFauZVXlKOn/mH
	/QCPTN3c7Em4pbCZ2ZJTcJ3x3NxBhWQa2CfBRL1JL5jtbse/+QeQQY7sRKy0T5Wqbv
	x8zo3Z5X3ABa3j3SyoerOwGSoG2JD3JBfHJie0rg=
Date: Fri, 10 May 2019 12:57:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510025735.GE20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-10-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-10-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 09/13] target/ppc: Implement
 hcall H_ENTER_NESTED
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:12PM +1000, Suraj Jitindar Singh wrote:
> The hcall H_ENTER_NESTED is used by a guest acting as a nested
> hypervisor to provide the state of one of its guests which it would
> like the real hypervisor to load onto the cpu and execute on its behalf.
>=20
> The hcall takes as arguments 2 guest real addresses which provide the
> location of a regs struct and a hypervisor regs struct which provide the
> values to use to execute the guest. These are loaded into the cpu state
> and then the function returns to continue tcg execution in the new
> context. When an interrupt requires us to context switch back we restore
> the old register values and save the cpu state back into the guest
> memory.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c     | 285 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h   |   3 +-
>  target/ppc/cpu.h         |  55 +++++++++
>  target/ppc/excp_helper.c |  13 ++-
>  4 files changed, 353 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 704ceff8e1..68f3282214 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -16,6 +16,7 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/ppc/ppc.h"
> =20
>  static bool has_spr(PowerPCCPU *cpu, int spr)
>  {
> @@ -1847,6 +1848,289 @@ static target_ulong h_set_partition_table(PowerPC=
CPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static void byteswap_pt_regs(struct pt_regs *regs)
> +{
> +    target_ulong *addr =3D (target_ulong *) regs;
> +
> +    for (; addr < ((target_ulong *) (regs + 1)); addr++) {
> +        *addr =3D bswap64(*addr);

Hrm.  pt_regs is defined in terms of target_ulongs, but this is
explicitly 64-bit.

> +    }
> +}
> +
> +static void byteswap_hv_regs(struct hv_guest_state *hr)

Bulk byteswapping structures like this always gives me the
heeby-jeebies.  It means whenever we have such a structure there's an
invisible bit of state: whether it is currently in originally
supplied, or "fixed" endianness at this moment.  That's not obvious to
either the compiler or future people looking at the code.  You can't
even use tools like sparse to help you, because the same type is used
for the swapped and unswapped versions.

I think it would be preferable to treat the hv_guest_state structure
as always being the L1-supplied endianness version and do the swaps
value by value at the point you transcribe from this into / out of the
qemu internal structures (host endianness).

Of course, that has its own complications since then we need to pass
what the actual endianness of the guest structure is down to those
functions.

I don't suppose there's any chance we could retcon the paravirt nested
interfaces to define these structures as always being of a fixed
endianness (I guess it would have to be LE), rather than L1 mode
dependent?

> +{
> +    hr->version =3D bswap64(hr->version);
> +    hr->lpid =3D bswap32(hr->lpid);
> +    hr->vcpu_token =3D bswap32(hr->vcpu_token);
> +    hr->lpcr =3D bswap64(hr->lpcr);
> +    hr->pcr =3D bswap64(hr->pcr);
> +    hr->amor =3D bswap64(hr->amor);
> +    hr->dpdes =3D bswap64(hr->dpdes);
> +    hr->hfscr =3D bswap64(hr->hfscr);
> +    hr->tb_offset =3D bswap64(hr->tb_offset);
> +    hr->dawr0 =3D bswap64(hr->dawr0);
> +    hr->dawrx0 =3D bswap64(hr->dawrx0);
> +    hr->ciabr =3D bswap64(hr->ciabr);
> +    hr->hdec_expiry =3D bswap64(hr->hdec_expiry);
> +    hr->purr =3D bswap64(hr->purr);
> +    hr->spurr =3D bswap64(hr->spurr);
> +    hr->ic =3D bswap64(hr->ic);
> +    hr->vtb =3D bswap64(hr->vtb);
> +    hr->hdar =3D bswap64(hr->hdar);
> +    hr->hdsisr =3D bswap64(hr->hdsisr);
> +    hr->heir =3D bswap64(hr->heir);
> +    hr->asdr =3D bswap64(hr->asdr);
> +    hr->srr0 =3D bswap64(hr->srr0);
> +    hr->srr1 =3D bswap64(hr->srr1);
> +    hr->sprg[0] =3D bswap64(hr->sprg[0]);
> +    hr->sprg[1] =3D bswap64(hr->sprg[1]);
> +    hr->sprg[2] =3D bswap64(hr->sprg[2]);
> +    hr->sprg[3] =3D bswap64(hr->sprg[3]);
> +    hr->pidr =3D bswap64(hr->pidr);
> +    hr->cfar =3D bswap64(hr->cfar);
> +    hr->ppr =3D bswap64(hr->ppr);
> +}
> +
> +static void save_regs(PowerPCCPU *cpu, struct pt_regs *regs)
> +{
> +    CPUPPCState env =3D cpu->env;
> +    int i;
> +
> +    for (i =3D 0; i < 32; i++)
> +        regs->gpr[i] =3D env.gpr[i];
> +    regs->nip =3D env.nip;
> +    regs->msr =3D env.msr;
> +    regs->ctr =3D env.ctr;
> +    regs->link =3D env.lr;
> +    regs->xer =3D env.xer;
> +    regs->ccr =3D 0UL;
> +    for (i =3D 0; i < 8; i++)
> +        regs->ccr |=3D ((env.crf[i] & 0xF) << ((7 - i) * 4));
> +    regs->dar =3D env.spr[SPR_DAR];
> +    regs->dsisr =3D env.spr[SPR_DSISR];
> +}
> +
> +static void save_hv_regs(PowerPCCPU *cpu, struct hv_guest_state *hv_regs)
> +{
> +    CPUPPCState env =3D cpu->env;
> +
> +    hv_regs->lpid =3D env.spr[SPR_LPIDR];
> +    hv_regs->lpcr =3D env.spr[SPR_LPCR];
> +    hv_regs->pcr =3D env.spr[SPR_PCR];
> +    hv_regs->amor =3D env.spr[SPR_AMOR];
> +    hv_regs->dpdes =3D !!(env.pending_interrupts & (1 << PPC_INTERRUPT_D=
OORBELL));
> +    hv_regs->hfscr =3D env.spr[SPR_HFSCR];
> +    hv_regs->tb_offset =3D env.tb_env->tb_offset;
> +    hv_regs->dawr0 =3D env.spr[SPR_DAWR];
> +    hv_regs->dawrx0 =3D env.spr[SPR_DAWRX];
> +    hv_regs->ciabr =3D env.spr[SPR_CIABR];
> +    hv_regs->purr =3D cpu_ppc_load_purr(&env);
> +    hv_regs->spurr =3D cpu_ppc_load_purr(&env);
> +    hv_regs->ic =3D env.spr[SPR_IC];
> +    hv_regs->vtb =3D cpu_ppc_load_vtb(&env);
> +    hv_regs->hdar =3D env.spr[SPR_HDAR];
> +    hv_regs->hdsisr =3D env.spr[SPR_HDSISR];
> +    hv_regs->asdr =3D env.spr[SPR_ASDR];
> +    hv_regs->srr0 =3D env.spr[SPR_SRR0];
> +    hv_regs->srr1 =3D env.spr[SPR_SRR1];
> +    hv_regs->sprg[0] =3D env.spr[SPR_SPRG0];
> +    hv_regs->sprg[1] =3D env.spr[SPR_SPRG1];
> +    hv_regs->sprg[2] =3D env.spr[SPR_SPRG2];
> +    hv_regs->sprg[3] =3D env.spr[SPR_SPRG3];
> +    hv_regs->pidr =3D env.spr[SPR_BOOKS_PID];
> +    hv_regs->cfar =3D env.cfar;
> +    hv_regs->ppr =3D env.spr[SPR_PPR];
> +}
> +
> +static void restore_regs(PowerPCCPU *cpu, struct pt_regs regs)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    int i;
> +
> +    for (i =3D 0; i < 32; i++)
> +        env->gpr[i] =3D regs.gpr[i];
> +    env->nip =3D regs.nip;
> +    ppc_store_msr(env, regs.msr);
> +    env->ctr =3D regs.ctr;
> +    env->lr =3D regs.link;
> +    env->xer =3D regs.xer;
> +    for (i =3D 0; i < 8; i++)
> +        env->crf[i] =3D (regs.ccr >> ((7 - i) * 4)) & 0xF;
> +    env->spr[SPR_DAR] =3D regs.dar;
> +    env->spr[SPR_DSISR] =3D regs.dsisr;
> +}
> +
> +static void restore_hv_regs(PowerPCCPU *cpu, struct hv_guest_state hv_re=
gs)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong lpcr_mask =3D LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL=
 | LPCR_LD
> +                                       | LPCR_LPES0 | LPCR_LPES1 | LPCR_=
MER;
> +
> +    env->spr[SPR_LPIDR] =3D hv_regs.lpid;
> +    ppc_store_lpcr(cpu, (hv_regs.lpcr & lpcr_mask) |
> +                        (env->spr[SPR_LPCR] & ~lpcr_mask));
> +    env->spr[SPR_PCR] =3D hv_regs.pcr;
> +    env->spr[SPR_AMOR] =3D hv_regs.amor;
> +    if (hv_regs.dpdes) {
> +        env->pending_interrupts |=3D 1 << PPC_INTERRUPT_DOORBELL;
> +        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> +    } else {
> +        env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_DOORBELL);
> +    }
> +    env->spr[SPR_HFSCR] =3D hv_regs.hfscr;
> +    env->spr[SPR_DAWR] =3D hv_regs.dawr0;
> +    env->spr[SPR_DAWRX] =3D hv_regs.dawrx0;
> +    env->spr[SPR_CIABR] =3D hv_regs.ciabr;
> +    cpu_ppc_store_purr(env, hv_regs.purr);      /* for TCG PURR =3D=3D S=
PURR */
> +    env->spr[SPR_IC] =3D hv_regs.ic;
> +    cpu_ppc_store_vtb(env, hv_regs.vtb);
> +    env->spr[SPR_HDAR] =3D hv_regs.hdar;
> +    env->spr[SPR_HDSISR] =3D hv_regs.hdsisr;
> +    env->spr[SPR_ASDR] =3D hv_regs.asdr;
> +    env->spr[SPR_SRR0] =3D hv_regs.srr0;
> +    env->spr[SPR_SRR1] =3D hv_regs.srr1;
> +    env->spr[SPR_SPRG0] =3D hv_regs.sprg[0];
> +    env->spr[SPR_SPRG1] =3D hv_regs.sprg[1];
> +    env->spr[SPR_SPRG2] =3D hv_regs.sprg[2];
> +    env->spr[SPR_SPRG3] =3D hv_regs.sprg[3];
> +    env->spr[SPR_BOOKS_PID] =3D hv_regs.pidr;
> +    env->cfar =3D hv_regs.cfar;
> +    env->spr[SPR_PPR] =3D hv_regs.ppr;
> +    tlb_flush(CPU(cpu));
> +}
> +
> +static void sanitise_hv_regs(PowerPCCPU *cpu, struct hv_guest_state *hv_=
regs)
> +{
> +    CPUPPCState env =3D cpu->env;
> +
> +    /* Apply more restrictive set of facilities */
> +    hv_regs->hfscr &=3D ((0xFFUL << 56) | env.spr[SPR_HFSCR]);
> +
> +    /* Don't match on hypervisor address */
> +    hv_regs->dawrx0 &=3D ~(1UL << 2);
> +
> +    /* Don't match on hypervisor address */
> +    if ((hv_regs->ciabr & 0x3) =3D=3D 0x3)
> +        hv_regs->ciabr &=3D ~0x3UL;
> +}
> +
> +static inline bool needs_byteswap(const CPUPPCState *env)
> +{
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    return msr_le;
> +#else
> +    return !msr_le;
> +#endif
> +}
> +
> +static target_ulong h_enter_nested(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
> +                                   target_ulong opcode, target_ulong *ar=
gs)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    env->hv_ptr =3D args[0];
> +    env->regs_ptr =3D args[1];
> +    uint64_t hdec;
> +
> +    assert(env->spr[SPR_LPIDR] =3D=3D 0);
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) =3D=3D 0) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (!env->has_hv_mode || !ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_=
3_00, 0,
> +                                               spapr->max_compat_pvr)
> +                          || !ppc64_v3_radix(cpu)) {
> +        error_report("pseries guest support only implemented for POWER9 =
radix\n");
> +        return H_HARDWARE;
> +    }
> +
> +    if (!env->spr[SPR_PTCR])
> +        return H_NOT_AVAILABLE;
> +
> +    memset(&env->l1_saved_hv, 0, sizeof(env->l1_saved_hv));
> +    memset(&env->l1_saved_regs, 0, sizeof(env->l1_saved_regs));
> +
> +    /* load l2 state from l1 memory */
> +    cpu_physical_memory_read(env->hv_ptr, &env->l2_hv, sizeof(env->l2_hv=
));
> +    if (needs_byteswap(env)) {
> +        byteswap_hv_regs(&env->l2_hv);
> +    }
> +    if (env->l2_hv.version !=3D 1)
> +        return H_P2;
> +    if (env->l2_hv.lpid =3D=3D 0)
> +        return H_P2;
> +    if (!(env->l2_hv.lpcr & LPCR_HR)) {
> +        error_report("pseries guest support only implemented for POWER9 =
radix guests\n");
> +        return H_P2;
> +    }
> +
> +    cpu_physical_memory_read(env->regs_ptr, &env->l2_regs, sizeof(env->l=
2_regs));
> +    if (needs_byteswap(env)) {
> +        byteswap_pt_regs(&env->l2_regs);
> +    }
> +
> +    /* save l1 values of things */
> +    save_regs(cpu, &env->l1_saved_regs);
> +    save_hv_regs(cpu, &env->l1_saved_hv);
> +
> +    /* adjust for timebase */
> +    hdec =3D env->l2_hv.hdec_expiry - cpu_ppc_load_tbl(env);
> +    env->tb_env->tb_offset +=3D env->l2_hv.tb_offset;
> +    /* load l2 values of things */
> +    sanitise_hv_regs(cpu, &env->l2_hv);
> +    restore_regs(cpu, env->l2_regs);
> +    env->msr &=3D ~MSR_HVB;
> +    restore_hv_regs(cpu, env->l2_hv);
> +    cpu_ppc_store_hdecr(env, hdec);
> +
> +    assert(env->spr[SPR_LPIDR] !=3D 0);
> +
> +    return env->gpr[3];
> +}
> +
> +void h_exit_nested(PowerPCCPU *cpu)

I'd prefer to call this something different, since it's not actually
invoked as an hcall.

> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    uint64_t delta_purr, delta_ic, delta_vtb;
> +    target_ulong trap =3D env->nip;
> +
> +    assert(env->spr[SPR_LPIDR] !=3D 0);
> +
> +    /* save l2 values of things */
> +    if (trap =3D=3D 0x100 || trap =3D=3D 0x200 || trap =3D=3D 0xc00) {
> +        env->nip =3D env->spr[SPR_SRR0];
> +        env->msr =3D env->spr[SPR_SRR1];
> +    } else {
> +        env->nip =3D env->spr[SPR_HSRR0];
> +        env->msr =3D env->spr[SPR_HSRR1];
> +    }
> +    save_regs(cpu, &env->l2_regs);
> +    delta_purr =3D cpu_ppc_load_purr(env) - env->l2_hv.purr;
> +    delta_ic =3D env->spr[SPR_IC] - env->l2_hv.ic;
> +    delta_vtb =3D cpu_ppc_load_vtb(env) - env->l2_hv.vtb;
> +    save_hv_regs(cpu, &env->l2_hv);
> +
> +    /* restore l1 state */
> +    restore_regs(cpu, env->l1_saved_regs);
> +    env->tb_env->tb_offset =3D env->l1_saved_hv.tb_offset;
> +    env->l1_saved_hv.purr +=3D delta_purr;
> +    env->l1_saved_hv.ic +=3D delta_ic;
> +    env->l1_saved_hv.vtb +=3D delta_vtb;
> +    restore_hv_regs(cpu, env->l1_saved_hv);
> +
> +    /* save l2 state back to l1 memory */
> +    if (needs_byteswap(env)) {
> +        byteswap_hv_regs(&env->l2_hv);
> +        byteswap_pt_regs(&env->l2_regs);
> +    }
> +    cpu_physical_memory_write(env->hv_ptr, &env->l2_hv, sizeof(env->l2_h=
v));
> +    cpu_physical_memory_write(env->regs_ptr, &env->l2_regs, sizeof(env->=
l2_regs));
> +
> +    assert(env->spr[SPR_LPIDR] =3D=3D 0);
> +
> +    env->gpr[3] =3D trap;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1955,6 +2239,7 @@ static void hypercall_register_types(void)
> =20
>      /* Platform-specific hcalls used for nested HV KVM */
>      spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_tabl=
e);
> +    spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
> =20
>      /* Virtual Processor Home Node */
>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e591ee0ba0..7083dea9ef 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -503,7 +503,8 @@ struct SpaprMachineState {
>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>  /* Platform-specific hcalls used for nested HV KVM */
>  #define H_SET_PARTITION_TABLE   0xF800
> -#define KVMPPC_HCALL_MAX        H_SET_PARTITION_TABLE
> +#define H_ENTER_NESTED          0xF804
> +#define KVMPPC_HCALL_MAX        H_ENTER_NESTED
> =20
>  typedef struct SpaprDeviceTreeUpdateHeader {
>      uint32_t version_id;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3acc248f40..426015c9cd 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -982,6 +982,54 @@ struct ppc_radix_page_info {
>  #define PPC_CPU_OPCODES_LEN          0x40
>  #define PPC_CPU_INDIRECT_OPCODES_LEN 0x20
> =20
> +struct pt_regs {
> +    target_ulong gpr[32];
> +    target_ulong nip;
> +    target_ulong msr;
> +    target_ulong orig_gpr3;
> +    target_ulong ctr;
> +    target_ulong link;
> +    target_ulong xer;
> +    target_ulong ccr;
> +    target_ulong softe;
> +    target_ulong trap;
> +    target_ulong dar;
> +    target_ulong dsisr;
> +    target_ulong result;
> +};
> +
> +struct hv_guest_state {
> +    uint64_t version;            /* version of this structure layout */
> +    uint32_t lpid;
> +    uint32_t vcpu_token;
> +    /* These registers are hypervisor privileged (at least for writing) =
*/
> +    uint64_t lpcr;
> +    uint64_t pcr;
> +    uint64_t amor;
> +    uint64_t dpdes;
> +    uint64_t hfscr;
> +    int64_t  tb_offset;
> +    uint64_t dawr0;
> +    uint64_t dawrx0;
> +    uint64_t ciabr;
> +    uint64_t hdec_expiry;
> +    uint64_t purr;
> +    uint64_t spurr;
> +    uint64_t ic;
> +    uint64_t vtb;
> +    uint64_t hdar;
> +    uint64_t hdsisr;
> +    uint64_t heir;
> +    uint64_t asdr;
> +    /* These are OS privileged but need to be set late in guest entry */
> +    uint64_t srr0;
> +    uint64_t srr1;
> +    uint64_t sprg[4];
> +    uint64_t pidr;
> +    uint64_t cfar;
> +    uint64_t ppr;
> +};

Could you get either or both of these structure definitions from the
imported kernel headers, rather than recreating them?

> +
>  struct CPUPPCState {
>      /* First are the most commonly used resources
>       * during translated code execution
> @@ -1184,6 +1232,11 @@ struct CPUPPCState {
>      uint32_t tm_vscr;
>      uint64_t tm_dscr;
>      uint64_t tm_tar;
> +
> +    /* used to store register state when running a nested kvm guest */
> +    target_ulong hv_ptr, regs_ptr;
> +    struct hv_guest_state l2_hv, l1_saved_hv;
> +    struct pt_regs l2_regs, l1_saved_regs;

I don't love adding this large chunk of data to the general cpu state
structure that's only useful on one machine type in limited circumstances.

>  };
> =20
>  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
> @@ -2647,4 +2700,6 @@ static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *e=
nv, int i)
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
> =20
>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
> +
> +void h_exit_nested(PowerPCCPU *cpu);
>  #endif /* PPC_CPU_H */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 10091d4624..9470c02512 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -347,7 +347,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>          env->nip +=3D 4;
> =20
>          /* "PAPR mode" built-in hypercall emulation */
> -        if ((lev =3D=3D 1) && cpu->vhyp) {
> +        if ((lev =3D=3D 1) && (cpu->vhyp && (env->spr[SPR_LPIDR] =3D=3D =
0))) {

This change doesn't quite make sense to me.  If cpu->vhyp is set, true
HV mode essentially doesn't exist on the vcpu, so it doesn't make
sense to process an hc instruction any other way than talking to the vhyp.


>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>              vhc->hypercall(cpu->vhyp, cpu);
> @@ -664,7 +664,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>      env->spr[srr1] =3D msr;
> =20
>      /* Sanity check */
> -    if (!(env->msr_mask & MSR_HVB)) {
> +    if (!(env->msr_mask & MSR_HVB) && (env->spr[SPR_LPIDR] =3D=3D 0)) {
>          if (new_msr & MSR_HVB) {
>              cpu_abort(cs, "Trying to deliver HV exception (MSR) %d with "
>                        "no HV support\n", excp);
> @@ -770,6 +770,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      /* Reset the reservation */
>      env->reserve_addr =3D -1;
> =20
> +    if ((!(env->msr_mask & MSR_HVB) && (new_msr & MSR_HVB))) {
> +        /*
> +         * We were in a guest, but this interrupt is setting the MSR[HV]=
 bit
> +         * meaning we want to handle this at l1. Call h_exit_nested to c=
ontext
> +         * switch back.
> +         */
> +        h_exit_nested(cpu);
> +    }
> +
>      /* Any interrupt is context synchronizing, check if TCG TLB
>       * needs a delayed flush on ppc64
>       */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU6J0ACgkQbDjKyiDZ
s5JSyw//YSbsTK4qZ/ybG7iVpZNoXS0TCFDR4YsiUs9a93NrjQqGnRPDail0VNtB
Hiah4UvJsROlii8evkgeKKNwEkVCiRUcXeaSkYy1viu7LwYxK5byEzgTAZYAOM75
KYBXuRVK3AHSlukyOS6hGVOwP5DzXznqMJHcIGL325mugyCFMI/Hk8r2BgNr/vXg
S9Z9r4oJiBlT3/PyR/O7aeJ1+vx9bDmWrBJtE/42tJjdtgUWRBdK9y5yL3WNouE6
YgFIz6zom6z7GyBOkENv571pUTIeRDVTjdKXkqwrA/nYvRxODWpUfrjz7TFnbiD7
bqNGvqfA9ggURGWJ6A4lTR+KC1pwbXCZ07SdyAj53SRZy1NBBuJ2qgpTZAcy0x5G
0l66WLRCyszyb4dpI7TyNT69VqhD5Sbk2a9ys7kYE5UiikOuPVOyGHcRpvYAQCHQ
VMBmlPu/zBBmZdTLM0ClR5tqrnrFHSyJZo6Lz4hwRyzp5HOkYke4rbPbv5fU8py6
3TrZJQuy8v6LED/SACvgt9gBmcA+x5f3jtSYSV46l3EP4ysx+wfMXGdWyMRFy07A
S8GWVTtgb1NtiV00oQJpmQWz8/49c7ZAOHhkNe4AJNI3z6yZVvc1wuNMssaH1g5O
PIb/Nkwb7oH200o3w4Us2djtk/VLN1k/Viirwf52EpiTkAZ5rIo=
=O+e5
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--

