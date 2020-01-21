Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A61C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41D92253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 03:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gmEXcE0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41D92253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkTb-0003qu-If
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 22:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSE-0002ZM-SX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itkSC-0006HI-P9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 22:43:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46773 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itkSB-00068S-Ka; Mon, 20 Jan 2020 22:43:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vXF26kCz9sRf; Tue, 21 Jan 2020 14:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579578221;
 bh=xQUGnjNLE5inVSFA9Nf/iUoC9pW2KVvYZwwgQsOQdxs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gmEXcE0CUyPCDPJu7MN4F/WiLjpzTv5f64QJeFP+vXZciPVjPt4DtpPLpB80+wSAU
 Eo5VxfoGfuibPXcv3nNpTplDbuEv87xZi/HyuoLGQsUOLVpj08aWWqFwwkTlx+G24E
 NaKIOVt7CHaT5rVnV9K9E3HDmmYp0SUu873ol9wU=
Date: Tue, 21 Jan 2020 14:32:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v6 3/3] target/ppc: support single stepping with KVM HV
Message-ID: <20200121033241.GM54439@umbus>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
 <20200110151344.278471-4-farosas@linux.ibm.com>
 <20200120023555.GK54439@umbus> <87d0bd28hl.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CoKeqzoheR24UlpS"
Content-Disposition: inline
In-Reply-To: <87d0bd28hl.fsf@linux.ibm.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CoKeqzoheR24UlpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 05:11:50PM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> >> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >> index 103bfe9dc2..b69f8565aa 100644
> >> --- a/target/ppc/cpu.h
> >> +++ b/target/ppc/cpu.h
> >> @@ -440,6 +440,10 @@ typedef struct ppc_v3_pate_t {
> >>  #define msr_ts   ((env->msr >> MSR_TS1)  & 3)
> >>  #define msr_tm   ((env->msr >> MSR_TM)   & 1)
> >> =20
> >> +#define srr1_ir ((env->spr[SPR_SRR1] >> MSR_IR) & 1)
> >> +#define srr1_dr ((env->spr[SPR_SRR1] >> MSR_DR) & 1)
> >> +#define srr1_se ((env->spr[SPR_SRR1] >> MSR_SE) & 1)
> >
> > I'd prefer not to introduce these.  The msr_xx macros are already kind
> > of dubious because they assume the meaning of 'env' in the context
> > they're used.  I'm ok to use them because they're so useful, so
> > often.  These srr1 variants however are used in far fewer situations.
> > So, I'd prefer to just open code these as (env->spr[SPR_SRR1] &
> > MSR_IR) in the relatively few places they're used for now.
> >
>=20
> Ok. No problem.
>=20
> >>  #define DBCR0_ICMP (1 << 27)
> >>  #define DBCR0_BRT (1 << 26)
> >>  #define DBSR_ICMP (1 << 27)
> >> @@ -1158,6 +1162,16 @@ struct CPUPPCState {
> >>      uint32_t tm_vscr;
> >>      uint64_t tm_dscr;
> >>      uint64_t tm_tar;
> >> +
> >> +    /* Used for software single step */
> >> +    target_ulong sstep_srr0;
> >> +    target_ulong sstep_srr1;
> >> +    target_ulong sstep_insn;
> >> +    target_ulong trace_handler_addr;
> >> +    int sstep_kind;
> >
> > Won't you need to migrate this extra state, at least some of the time?
> >
>=20
> Ah. I haven't looked into this yet. Will do that for the next
> version. Need to learn a bit about migration first.
>=20
> >> +#define SSTEP_REGULAR 0
> >> +#define SSTEP_PENDING 1
> >> +#define SSTEP_GUEST   2
> >
> > Some comments on what these modes mean would be useful.
> >
>=20
> Ok.
>=20
> >> +static uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr)
> >> +{
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +    uint32_t insn;
> >> +
> >> +    cpu_memory_rw_debug(cs, addr, (uint8_t *)&insn, sizeof(insn), 0);
> >> +
> >> +    if (msr_le) {
> >> +        return ldl_le_p(&insn);
> >> +    } else {
> >> +        return ldl_be_p(&insn);
> >> +    }
> >
> > I think you can just use cpu_ldl_code() for this.
> >
>=20
> I'll look into it.
>=20
> >> +static void kvm_insert_singlestep_breakpoint(CPUState *cs, bool mmu_o=
n)
> >> +{
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +    target_ulong bp_addr;
> >> +    target_ulong saved_msr =3D env->msr;
> >> +
> >> +    bp_addr =3D ppc_get_trace_int_handler_addr(cs, mmu_on);
> >> +    if (env->nip =3D=3D bp_addr) {
> >> +        /*
> >> +         * We are trying to step the interrupt handler address itself;
> >> +         * move the breakpoint to the next instruction.
> >> +         */
> >> +        bp_addr +=3D 4;
> >
> > What if the first instruction of the interrupt handler is a branch?
> >
>=20
> Well, I need to displace the breakpoint somehow. I don't think I can
> handle this particular case without having _some_ knowledge of the
> handler's code. The ones I've seen so far don't have a branch as first
> instruction.

So, at least for unconditional branches it's possible - you could
parse the instruction and place your breakpoint on the target.  For
conditional branches it would be much harder, but they are much less
likely as the very first instruction on the interrupt vector.

I do think we should at least detect and flag some sort of error in
this situation though.

> >> +    }
> >> +
> >> +    /*
> >> +     * The actual access by the guest might be made in a mode
> >> +     * different than we are now (due to rfid) so temporarily set the
> >> +     * MSR to reflect that during the breakpoint placement.
> >> +     *
> >> +     * Note: we need this because breakpoints currently use
> >> +     * cpu_memory_rw_debug, which does the memory accesses from the
> >> +     * guest point of view.
> >> +     */
> >> +    if ((msr_ir & msr_dr) !=3D mmu_on) {
> >
> > Should be msr_ir && msr_dr - you only get away with bitwise and by
> > accident.
> >
>=20
> Ack.
>=20
> >> +        if (mmu_on) {
> >> +            env->msr |=3D (1ULL << MSR_IR | 1ULL << MSR_DR);
> >> +        } else {
> >> +            env->msr &=3D ~(1ULL << MSR_IR | 1ULL << MSR_DR);
> >> +        }
> >> +    }
> >
> > Wouldn't it be simpler to unconditionally set env->msr based on
> > mmu_on.
> >
>=20
> Yes.
>=20
> >> +
> >> +    kvm_insert_breakpoint(cs, bp_addr, 4, GDB_BREAKPOINT_SW);
> >
> > Hrm.... I don't actually see how changing env->msr helps you here.
> > AFAICT if kvm_insert_breakpoint() resolves to kvm_arch_sw_breakpoint()
> > it doesn't rely on the MSR value at all.  If it resolves to
> > kvm_arch_hw_breakpoint(), then it looks like it just stashes
> > information to be pushed into KVM when we re-enter the guest.  None of
> > the information stashed appears to depend on the current MSR, and once
> > we re-enter the MSR will already have been restored.
> >
>
> This is the call chain:
>=20
> kvm_arch_insert_sw_breakpoint -> cpu_memory_rw_debug ->
> cpu_get_phys_page_attrs_debug -> ppc_cpu_get_phys_page_debug ->
> ppc64_v3_get_phys_page_debug -> ppc_radix64_get_phys_page_debug:
>=20
>     /* Handle Real Mode */
>     if (msr_dr =3D=3D 0) {
>         /* In real mode top 4 effective addr bits (mostly) ignored */
>         return eaddr & 0x0FFFFFFFFFFFFFFFULL;
>     }

Ah, right.  Basically the issue is that kvm_insert_breakpoint() takes
an effective address, not a real address, but it might be happening in
a different context than we're executing right now.

Ok, that makes sense.  Though.. aren't you always inserting the
breakpoint into an interrupt vector?  So wouldn't it always be MMU
off?  Under what circumstances would this get called with mmu_on =3D
true?

> Actually, I think there is a bug after ppc_cpu_get_phys_page_debug
> somewhere. There are some cases where GDB wants to read/write to some
> memory, but it gets denied access. Presumably because of one such
> discrepancy as the one above. I need to spend more time looking at this
> to define the problem properly, though.

Hm, ok.

> >> +    /*
> >> +     * MSR_SE =3D 1 will cause a Trace Interrupt in the guest after t=
he
> >> +     * next instruction executes. If this is a rfid, use SRR1 instead
> >> +     * of MSR.
> >> +     */
> >> +    if (rfid) {
> >> +        if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
> >> +            /*
> >> +             * The guest is doing a single step itself. Make sure we
> >> +             * restore it later.
> >> +             */
> >> +            env->sstep_kind =3D SSTEP_GUEST;
> >> +        }
> >> +
> >> +        env->spr[SPR_SRR1] |=3D (1ULL << MSR_SE);
> >> +        mmu_on =3D srr1_ir & srr1_dr;
> >
> > s/&/&&/
> >
>=20
> Ack.
>=20
> >> +    } else {
> >> +        env->msr |=3D (1ULL << MSR_SE);
> >> +        mmu_on =3D msr_ir & msr_dr;
> >
> > s/&/&&/
> >
>=20
> Ack.
>=20
> > Also, what happens if the guest is using MSR[DR] !=3D MSR[IR]?  It's
> > rare, but it is occasionally useful.
>=20
> I understand from the ISA that for the purposes of AIL, both bits need
> to be set. So mmu_on =3D 0 is correct here.

I'm not sure what you mean by "for the purposes of AIL".

>=20
> >> +    }
> >> +
> >> +    kvm_insert_singlestep_breakpoint(cs, mmu_on);
> >> +}
> >> +
> >> +void kvm_singlestep_ail_change(CPUState *cs)
> >> +{
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +
> >> +    if (kvm_arch_can_singlestep(cs)) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * The instruction being stepped altered the interrupt vectors
> >> +     * location (AIL). Re-insert the single step breakpoint at the new
> >> +     * location
> >> +     */
> >> +    kvm_remove_breakpoint(cs, env->trace_handler_addr, 4, GDB_BREAKPO=
INT_SW);
> >> +    kvm_insert_singlestep_breakpoint(cs, (msr_ir & msr_dr));
> >
> > s/&/&&/
> >
>=20
> Ack.
>=20
> >> +}
> >> +
> >>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug=
 *dbg)
> >>  {
> >>      int n;
> >> @@ -1585,6 +1781,98 @@ void kvm_arch_update_guest_debug(CPUState *cs, =
struct kvm_guest_debug *dbg)
> >>      }
> >>  }
> >> =20
> >> +/* Revert any side-effects caused during single step */
> >> +static void restore_singlestep_env(CPUState *cs)
> >> +{
> >> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +    uint32_t insn =3D env->sstep_insn;
> >> +    int reg;
> >> +    int spr;
> >> +
> >> +    env->spr[SPR_SRR0] =3D env->sstep_srr0;
> >> +    env->spr[SPR_SRR1] =3D env->sstep_srr1;
> >> +
> >> +    if (ppc_gdb_get_op(insn) !=3D OP_MOV) {
> >> +        return;
> >> +    }
> >> +
> >> +    reg =3D ppc_gdb_get_rt(insn);
> >> +
> >> +    switch (ppc_gdb_get_xop(insn)) {
> >> +    case XOP_MTSPR:
> >> +        /*
> >> +         * mtspr: the guest altered the SRR, so do not use the
> >> +         *        pre-step value.
> >> +         */
> >> +        spr =3D ppc_gdb_get_spr(insn);
> >> +        if (spr =3D=3D SPR_SRR0 || spr =3D=3D SPR_SRR1) {
> >> +            env->spr[spr] =3D env->gpr[reg];
> >> +        }
> >> +        break;
> >> +    case XOP_MFMSR:
> >> +        /*
> >> +         * mfmsr: clear MSR_SE bit to avoid the guest knowing
> >> +         *         that it is being single-stepped.
> >> +         */
> >> +        env->gpr[reg] &=3D ~(1ULL << MSR_SE);
> >
> > Don't you need to check for the case where the guest also thinks it is
> > single stepping here?
> >
>=20
> Hm. I had this in some previous version but removed it for some
> reason. I'll review it.
>=20
>=20
> Thanks
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CoKeqzoheR24UlpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4mcNcACgkQbDjKyiDZ
s5L5PBAAjxb4ZXOdh0zAgqWHTJWw7jXmt+Yoi6IJANvtuLf9QIaEa4p2atyVngnW
TFtQcPvl0N8epAD2g+0S6HxgEsXVyJ1maidZBe5LIZkyRWseJ6VXkZkFs4P3hk0y
1oJHQk+naSZXdYYdhMssjukiy9yfKZ+UJctD8zKhNLWUU7udiRWkkCPkKVYiPEz/
UEIQyB/Ah1gU3Fy1B0e3Ktqi7JHkAS+eIJnpRJjMJuzVkjjtI8oL42mBleVI+GOs
JoylwbnewopyDJ0GdTbgdAo74wt7OGbXVWE3h4+YeZC0QspirbQaiBrJKk4KBW66
rVqzmkSx57yEiZCn1yleqBk+R295kmGtWdfYPs5vBMBRxLzf/C+PIY77C2r1PZio
xnoSkfRxpoMV5lN2D8VszJyGqqDQJOrswadspvHAJahpImaQXuQwe75mPzgw+V+/
VEh1968lDMcM9DI7Gq2zvc9ss5QF6tsyziWwA1fYTsPGAdlzYqmNUB0M6lMBff/5
NCvLUfVt/5trcbh3Gx+/HBuKwsjvPGHzUAxF4S7X9UqsaGAyUoIJPKPBx4+HMbPh
8EvMocYcDeMiJaQ/xiUZOotu69xxyX7UY8DksAT+RSAQ3A9gkL3WmjyfueMwmzxM
hp32Zlm/NJGaCtSD+qXkrQtWvy4m9Ami4KdkNHfGYfdwrzsbl/Y=
=eRCi
-----END PGP SIGNATURE-----

--CoKeqzoheR24UlpS--

