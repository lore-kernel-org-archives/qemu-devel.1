Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470FC2D0EB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973F020776
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973F020776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxtW-0002cX-OV
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jIxsa-0000uD-AY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jIxsY-0002pN-Io
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:07:16 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:43499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jIxsY-0002lI-C9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:07:14 -0400
Received: from player770.ha.ovh.net (unknown [10.108.35.122])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 32EE7162300
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 19:07:11 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 1B42D110482B5;
 Mon, 30 Mar 2020 17:07:06 +0000 (UTC)
Date: Mon, 30 Mar 2020 19:07:05 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/7] target/ppc: Introduce ppc_radix64_xlate() for Radix
 tree translation
Message-ID: <20200330190705.66fe941a@bahia.lan>
In-Reply-To: <88580970-a739-b32f-528f-26c6aa81b598@kaod.org>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-5-clg@kaod.org>
 <20200330161848.27226542@bahia.lan>
 <99dd89d6-f385-7cc1-d688-c104708092c2@kaod.org>
 <88580970-a739-b32f-528f-26c6aa81b598@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2827979093778012555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.220
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 17:34:40 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> >>> +        /* No valid pte or access denied due to protection */
> >>> +        if (cause_excp) {
> >>> +            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> >>> +        }
> >>> +        return 1;
> >>> +    }
> >>> +
> >>> +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >>> +                             uint64_t lpid, uint64_t pid, bool reloc=
ation,
> >>> +                             hwaddr *raddr, int *psizep, int *protp,
> >>> +                             bool cause_excp)
> >>> +{
> >>> +    ppc_v3_pate_t pate;
> >>> +    int psize, prot;
> >>> +    hwaddr g_raddr;
> >>> +
> >>> +    *psizep =3D INT_MAX;
> >>> +    *protp =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >>> +
> >>> +    /* Get Process Table */
> >>> +    if (cpu->vhyp && lpid =3D=3D 0) {
> >>
> >> Current code doesn't check lpid =3D=3D 0. Not sure to see what it's fo=
r...
> >=20
> > cpu->vhyp means a pseries machine, lpid =3D=3D 0 means accessing quadra=
nt3,=20
> > so it's the kernel.
>=20
> Sorry. I misread that. It would pid =3D=3D 0 for the kernel.=20
>=20

Yes.

> So yes, the test cpu->vhyp && lpid =3D=3D 0 might be a bit overkill, give=
n=20
> that lpid is always 0 when running under a QEMU pseries machine.
>=20

That's my thinking as well.

>=20
> C.
>=20
> >=20
> >> especially env->spr[SPR_LPIDR] is always 0 with pseries machine types
> >> AFAICT... is it even possible to have lpid !=3D 0 here ?
> >=20
> > When under PowerNV, SPR_LPIDR can be set, but not under pseries.
> >=20
> > C.
> >=20
> >>
> >>
> >> Rest LGTM.
> >>

Just a few nits below...

> >>> +        PPCVirtualHypervisorClass *vhc;
> >>> +        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >>> +        vhc->get_pate(cpu->vhyp, &pate);
> >>> +    } else {
> >>> +        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> >>> +            if (cause_excp) {
> >>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> >>> +            }
> >>> +            return 1;
> >>> +        }
> >>> +        if (!validate_pate(cpu, lpid, &pate)) {
> >>> +            if (cause_excp) {
> >>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCON=
FIG);
> >>> +            }
> >>> +            return 1;
> >>> +        }
> >>> +        /* We don't support guest mode yet */
> >>> +        if (lpid !=3D 0) {
> >>> +            error_report("PowerNV guest support Unimplemented");
> >>> +            exit(1);
> >>> +        }
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * Perform process-scoped translation if relocation enabled.
> >>> +     *
> >>> +     * - Translates an effective address to a host real address in
> >>> +     *   quadrants 0 and 3 when HV=3D1.
> >>> +     */
> >>> +    if (relocation) {
> >>> +        int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr=
, lpid, pid,
> >>> +                                                   pate, &g_raddr, &=
prot,
> >>> +                                                   &psize, cause_exc=
p);
> >>> +        if (ret) {
> >>> +            return ret;
> >>> +        }
> >>> +        *psizep =3D MIN(*psizep, psize);
> >>> +        *protp &=3D prot;
> >>> +    } else {
> >>> +        g_raddr =3D eaddr & R_EADDR_MASK;
> >>> +    }
> >>> +
> >>> +    *raddr =3D g_raddr;
> >>> +    return 0;
> >>> +}
> >>> +
> >>>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int r=
wx,
> >>>                                   int mmu_idx)
> >>>  {
> >>>      CPUState *cs =3D CPU(cpu);
> >>>      CPUPPCState *env =3D &cpu->env;
> >>> -    PPCVirtualHypervisorClass *vhc;
> >>> -    hwaddr raddr, pte_addr;
> >>> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> >>> -    int page_size, prot, fault_cause =3D 0;
> >>> -    ppc_v3_pate_t pate;
> >>> +    uint64_t lpid =3D 0, pid =3D 0;
> >>> +    int page_size, prot;
> >>>      bool relocation;
> >>> +    hwaddr raddr;
> >>> =20
> >>>      assert(!(msr_hv && cpu->vhyp));
> >>>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> >>> @@ -268,48 +370,11 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cp=
u, vaddr eaddr, int rwx,
> >>>          return 1;
> >>>      }
> >>> =20
> >>> -    /* Get Process Table */
> >>> -    if (cpu->vhyp) {
> >>> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >>> -        vhc->get_pate(cpu->vhyp, &pate);
> >>> -    } else {
> >>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> >>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> >>> -            return 1;
> >>> -        }
> >>> -        if (!validate_pate(cpu, lpid, &pate)) {
> >>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
> >>> -        }
> >>> -        /* We don't support guest mode yet */
> >>> -        if (lpid !=3D 0) {
> >>> -            error_report("PowerNV guest support Unimplemented");
> >>> -            exit(1);
> >>> -       }
> >>> -    }
> >>> -
> >>> -    /* Index Process Table by PID to Find Corresponding Process Tabl=
e Entry */
> >>> -    offset =3D pid * sizeof(struct prtb_entry);
> >>> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> >>> -    if (offset >=3D size) {
> >>> -        /* offset exceeds size of the process table */
> >>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> >>> +    /* Translate eaddr to raddr (where raddr is addr qemu needs for =
access) */
> >>> +    if (ppc_radix64_xlate(cpu, eaddr, rwx, lpid, pid, relocation, &r=
addr,
> >>> +                          &page_size, &prot, 1)) {

... passe true instead of 1 and...

> >>>          return 1;
> >>>      }
> >>> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> >>> -
> >>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA =
*/
> >>> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> >>> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> >>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTB=
E_R_RPDS,
> >>> -                                &raddr, &page_size, &fault_cause, &p=
te_addr);
> >>> -    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, =
&prot)) {
> >>> -        /* Couldn't get pte or access denied due to protection */
> >>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> >>> -        return 1;
> >>> -    }
> >>> -
> >>> -    /* Update Reference and Change Bits */
> >>> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
> >>> =20
> >>>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_M=
ASK,
> >>>                   prot, mmu_idx, 1UL << page_size);
> >>> @@ -318,16 +383,13 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cp=
u, vaddr eaddr, int rwx,
> >>> =20
> >>>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong=
 eaddr)
> >>>  {
> >>> -    CPUState *cs =3D CPU(cpu);
> >>>      CPUPPCState *env =3D &cpu->env;
> >>> -    PPCVirtualHypervisorClass *vhc;
> >>> -    hwaddr raddr, pte_addr;
> >>> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> >>> -    int page_size, fault_cause =3D 0;
> >>> -    ppc_v3_pate_t pate;
> >>> +    uint64_t lpid =3D 0, pid =3D 0;
> >>> +    int psize, prot;
> >>> +    hwaddr raddr;
> >>> =20
> >>>      /* Handle Real Mode */
> >>> -    if (msr_dr =3D=3D 0) {
> >>> +    if ((msr_dr =3D=3D 0) && (msr_hv || (cpu->vhyp && lpid =3D=3D 0)=
)) {
> >>>          /* In real mode top 4 effective addr bits (mostly) ignored */
> >>>          return eaddr & 0x0FFFFFFFFFFFFFFFULL;
> >>>      }
> >>> @@ -337,39 +399,8 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCP=
U *cpu, target_ulong eaddr)
> >>>          return -1;
> >>>      }
> >>> =20
> >>> -    /* Get Process Table */
> >>> -    if (cpu->vhyp) {
> >>> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> >>> -        vhc->get_pate(cpu->vhyp, &pate);
> >>> -    } else {
> >>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> >>> -            return -1;
> >>> -        }
> >>> -        if (!validate_pate(cpu, lpid, &pate)) {
> >>> -            return -1;
> >>> -        }
> >>> -        /* We don't support guest mode yet */
> >>> -        if (lpid !=3D 0) {
> >>> -            error_report("PowerNV guest support Unimplemented");
> >>> -            exit(1);
> >>> -       }
> >>> -    }
> >>> -
> >>> -    /* Index Process Table by PID to Find Corresponding Process Tabl=
e Entry */
> >>> -    offset =3D pid * sizeof(struct prtb_entry);
> >>> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> >>> -    if (offset >=3D size) {
> >>> -        /* offset exceeds size of the process table */
> >>> -        return -1;
> >>> -    }
> >>> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> >>> -
> >>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA =
*/
> >>> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> >>> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> >>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTB=
E_R_RPDS,
> >>> -                                &raddr, &page_size, &fault_cause, &p=
te_addr);
> >>> -    if (!pte) {
> >>> +    if (ppc_radix64_xlate(cpu, eaddr, 0, lpid, pid, msr_dr, &raddr, =
&psize,
> >>> +                          &prot, 0)) {

... false here since ppc_radix64_xlate() takes a bool argument.

> >>>          return -1;
> >>>      }
> >>> =20
> >>
> >=20
>=20


