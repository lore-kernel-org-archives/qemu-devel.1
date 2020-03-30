Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890AC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EB82072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EB82072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwRj-00054V-2G
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jIwQq-0004ex-7q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jIwQo-0005XJ-Cs
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:34:32 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:48271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jIwQo-0005NI-7S
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:34:30 -0400
Received: from player737.ha.ovh.net (unknown [10.110.171.40])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7005B161283
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 17:25:04 +0200 (CEST)
Received: from kaod.org (unknown [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 5E849779FC80;
 Mon, 30 Mar 2020 15:24:53 +0000 (UTC)
Subject: Re: [PATCH 4/7] target/ppc: Introduce ppc_radix64_xlate() for Radix
 tree translation
To: Greg Kurz <groug@kaod.org>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-5-clg@kaod.org> <20200330161848.27226542@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <99dd89d6-f385-7cc1-d688-c104708092c2@kaod.org>
Date: Mon, 30 Mar 2020 17:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330161848.27226542@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1103100435559975832
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.149
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

On 3/30/20 4:18 PM, Greg Kurz wrote:
> On Mon, 30 Mar 2020 11:49:43 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> This is moving code under a new ppc_radix64_xlate() routine shared by
>> the MMU Radix page fault handler and the get_phys_page_debug PPC
>> callback. The difference being that get_phys_page_debug does not
>> generate exceptions.
>>
>> The specific part of process-scoped Radix translation is moved under
>> ppc_radix64_process_scoped_xlate() in preparation of the future
>> support for partition-scoped Radix translation.
>>
>> It should be functionally equivalent.
>>
>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  target/ppc/mmu-radix64.c | 201 ++++++++++++++++++++++----------------=
-
>>  1 file changed, 116 insertions(+), 85 deletions(-)
>>
>> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
>> index d2422d1c54c9..b4e6abcd2d35 100644
>> --- a/target/ppc/mmu-radix64.c
>> +++ b/target/ppc/mmu-radix64.c
>> @@ -219,17 +219,119 @@ static bool validate_pate(PowerPCCPU *cpu, uint=
64_t lpid, ppc_v3_pate_t *pate)
>>      return true;
>>  }
>> =20
>> +static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>> +                                      vaddr eaddr, uint64_t lpid, uin=
t64_t pid,
>> +                                      ppc_v3_pate_t pate, hwaddr *g_r=
addr,
>> +                                      int *g_prot, int *g_page_size,
>> +                                      bool cause_excp)
>> +{
>> +    CPUState *cs =3D CPU(cpu);
>> +    uint64_t offset, size, prtbe_addr, prtbe0, pte;
>> +    int fault_cause =3D 0;
>> +    hwaddr pte_addr;
>> +
>> +    /* Index Process Table by PID to Find Corresponding Process Table=
 Entry */
>> +    offset =3D pid * sizeof(struct prtb_entry);
>> +    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
>> +    if (offset >=3D size) {
>> +        /* offset exceeds size of the process table */
>> +        if (cause_excp) {
>> +            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>> +        }
>> +        return 1;
>> +    }
>> +    prtbe_addr =3D (pate.dw1 & PATE1_R_PRTB) + offset;
>> +    prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
>> +
>> +    /* Walk Radix Tree from Process Table Entry to Convert EA to RA *=
/
>> +    *g_page_size =3D PRTBE_R_GET_RTS(prtbe0);
>> +    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
>> +                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE=
_R_RPDS,
>> +                                g_raddr, g_page_size, &fault_cause, &=
pte_addr);
>> +
>> +    if (!(pte & R_PTE_VALID) ||
>> +        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot)) =
{
>=20
> Current code checks !pte instead of !(pte & R_PTE_VALID)... and I it se=
ems
> that ppc_radix64_walk_tree() already handles that:
>=20
>     if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
>         *fault_cause |=3D DSISR_NOPTE;
>         return 0;
>     }

There are more changes in the following patches when partition-scoped
is introduced.

>=20
>> +        /* No valid pte or access denied due to protection */
>> +        if (cause_excp) {
>> +            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>> +        }
>> +        return 1;
>> +    }
>> +
>> +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
>> +
>> +    return 0;
>> +}
>> +
>> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>> +                             uint64_t lpid, uint64_t pid, bool reloca=
tion,
>> +                             hwaddr *raddr, int *psizep, int *protp,
>> +                             bool cause_excp)
>> +{
>> +    ppc_v3_pate_t pate;
>> +    int psize, prot;
>> +    hwaddr g_raddr;
>> +
>> +    *psizep =3D INT_MAX;
>> +    *protp =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>> +
>> +    /* Get Process Table */
>> +    if (cpu->vhyp && lpid =3D=3D 0) {
>=20
> Current code doesn't check lpid =3D=3D 0. Not sure to see what it's for=
...

cpu->vhyp means a pseries machine, lpid =3D=3D 0 means accessing quadrant=
3,=20
so it's the kernel.

> especially env->spr[SPR_LPIDR] is always 0 with pseries machine types
> AFAICT... is it even possible to have lpid !=3D 0 here ?

When under PowerNV, SPR_LPIDR can be set, but not under pseries.

C.

>=20
>=20
> Rest LGTM.
>=20
>> +        PPCVirtualHypervisorClass *vhc;
>> +        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> +        vhc->get_pate(cpu->vhyp, &pate);
>> +    } else {
>> +        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>> +            if (cause_excp) {
>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>> +            }
>> +            return 1;
>> +        }
>> +        if (!validate_pate(cpu, lpid, &pate)) {
>> +            if (cause_excp) {
>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONF=
IG);
>> +            }
>> +            return 1;
>> +        }
>> +        /* We don't support guest mode yet */
>> +        if (lpid !=3D 0) {
>> +            error_report("PowerNV guest support Unimplemented");
>> +            exit(1);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * Perform process-scoped translation if relocation enabled.
>> +     *
>> +     * - Translates an effective address to a host real address in
>> +     *   quadrants 0 and 3 when HV=3D1.
>> +     */
>> +    if (relocation) {
>> +        int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr,=
 lpid, pid,
>> +                                                   pate, &g_raddr, &p=
rot,
>> +                                                   &psize, cause_excp=
);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +        *psizep =3D MIN(*psizep, psize);
>> +        *protp &=3D prot;
>> +    } else {
>> +        g_raddr =3D eaddr & R_EADDR_MASK;
>> +    }
>> +
>> +    *raddr =3D g_raddr;
>> +    return 0;
>> +}
>> +
>>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rw=
x,
>>                                   int mmu_idx)
>>  {
>>      CPUState *cs =3D CPU(cpu);
>>      CPUPPCState *env =3D &cpu->env;
>> -    PPCVirtualHypervisorClass *vhc;
>> -    hwaddr raddr, pte_addr;
>> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
>> -    int page_size, prot, fault_cause =3D 0;
>> -    ppc_v3_pate_t pate;
>> +    uint64_t lpid =3D 0, pid =3D 0;
>> +    int page_size, prot;
>>      bool relocation;
>> +    hwaddr raddr;
>> =20
>>      assert(!(msr_hv && cpu->vhyp));
>>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
>> @@ -268,48 +370,11 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu=
, vaddr eaddr, int rwx,
>>          return 1;
>>      }
>> =20
>> -    /* Get Process Table */
>> -    if (cpu->vhyp) {
>> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> -        vhc->get_pate(cpu->vhyp, &pate);
>> -    } else {
>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>> -            return 1;
>> -        }
>> -        if (!validate_pate(cpu, lpid, &pate)) {
>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
>> -        }
>> -        /* We don't support guest mode yet */
>> -        if (lpid !=3D 0) {
>> -            error_report("PowerNV guest support Unimplemented");
>> -            exit(1);
>> -       }
>> -    }
>> -
>> -    /* Index Process Table by PID to Find Corresponding Process Table=
 Entry */
>> -    offset =3D pid * sizeof(struct prtb_entry);
>> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
>> -    if (offset >=3D size) {
>> -        /* offset exceeds size of the process table */
>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>> +    /* Translate eaddr to raddr (where raddr is addr qemu needs for a=
ccess) */
>> +    if (ppc_radix64_xlate(cpu, eaddr, rwx, lpid, pid, relocation, &ra=
ddr,
>> +                          &page_size, &prot, 1)) {
>>          return 1;
>>      }
>> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
>> -
>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA *=
/
>> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
>> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE=
_R_RPDS,
>> -                                &raddr, &page_size, &fault_cause, &pt=
e_addr);
>> -    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &=
prot)) {
>> -        /* Couldn't get pte or access denied due to protection */
>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>> -        return 1;
>> -    }
>> -
>> -    /* Update Reference and Change Bits */
>> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
>> =20
>>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MA=
SK,
>>                   prot, mmu_idx, 1UL << page_size);
>> @@ -318,16 +383,13 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu=
, vaddr eaddr, int rwx,
>> =20
>>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong =
eaddr)
>>  {
>> -    CPUState *cs =3D CPU(cpu);
>>      CPUPPCState *env =3D &cpu->env;
>> -    PPCVirtualHypervisorClass *vhc;
>> -    hwaddr raddr, pte_addr;
>> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
>> -    int page_size, fault_cause =3D 0;
>> -    ppc_v3_pate_t pate;
>> +    uint64_t lpid =3D 0, pid =3D 0;
>> +    int psize, prot;
>> +    hwaddr raddr;
>> =20
>>      /* Handle Real Mode */
>> -    if (msr_dr =3D=3D 0) {
>> +    if ((msr_dr =3D=3D 0) && (msr_hv || (cpu->vhyp && lpid =3D=3D 0))=
) {
>>          /* In real mode top 4 effective addr bits (mostly) ignored */
>>          return eaddr & 0x0FFFFFFFFFFFFFFFULL;
>>      }
>> @@ -337,39 +399,8 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU=
 *cpu, target_ulong eaddr)
>>          return -1;
>>      }
>> =20
>> -    /* Get Process Table */
>> -    if (cpu->vhyp) {
>> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> -        vhc->get_pate(cpu->vhyp, &pate);
>> -    } else {
>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>> -            return -1;
>> -        }
>> -        if (!validate_pate(cpu, lpid, &pate)) {
>> -            return -1;
>> -        }
>> -        /* We don't support guest mode yet */
>> -        if (lpid !=3D 0) {
>> -            error_report("PowerNV guest support Unimplemented");
>> -            exit(1);
>> -       }
>> -    }
>> -
>> -    /* Index Process Table by PID to Find Corresponding Process Table=
 Entry */
>> -    offset =3D pid * sizeof(struct prtb_entry);
>> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
>> -    if (offset >=3D size) {
>> -        /* offset exceeds size of the process table */
>> -        return -1;
>> -    }
>> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
>> -
>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA *=
/
>> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
>> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE=
_R_RPDS,
>> -                                &raddr, &page_size, &fault_cause, &pt=
e_addr);
>> -    if (!pte) {
>> +    if (ppc_radix64_xlate(cpu, eaddr, 0, lpid, pid, msr_dr, &raddr, &=
psize,
>> +                          &prot, 0)) {
>>          return -1;
>>      }
>> =20
>=20


