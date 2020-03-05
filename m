Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005762073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005762073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9n8a-0000h7-Ut
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j9n7D-0007zF-9C
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j9n7A-0005YX-Ko
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:48:26 -0500
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:35023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j9n7A-0005VH-FY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:48:24 -0500
Received: from player795.ha.ovh.net (unknown [10.108.42.66])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 273FA15CAA8
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 10:48:20 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 634BBFF36699;
 Thu,  5 Mar 2020 09:47:56 +0000 (UTC)
Date: Thu, 5 Mar 2020 10:47:53 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v7 11/17] target/ppc: Don't store VRMA SLBE persistently
Message-ID: <20200305104753.749437e0@bahia.home>
In-Reply-To: <efb1558c-15ab-70f8-0963-357c45da2682@redhat.com>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-12-david@gibson.dropbear.id.au>
 <efb1558c-15ab-70f8-0963-357c45da2682@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14619810293409618211
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.250.45
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 10:17:03 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi David,
>=20
> On 3/3/20 4:43 AM, David Gibson wrote:
> > Currently, we construct the SLBE used for VRMA translations when the LP=
CR
> > is written (which controls some bits in the SLBE), then use it later for
> > translations.
> >=20
> > This is a bit complex and confusing - simplify it by simply constructing
> > the SLBE directly from the LPCR when we need it.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >   target/ppc/cpu.h        |  3 --
> >   target/ppc/mmu-hash64.c | 92 ++++++++++++++++-------------------------
> >   2 files changed, 35 insertions(+), 60 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index f9871b1233..5a55fb02bd 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1044,9 +1044,6 @@ struct CPUPPCState {
> >       uint32_t flags;
> >       uint64_t insns_flags;
> >       uint64_t insns_flags2;
> > -#if defined(TARGET_PPC64)
> > -    ppc_slb_t vrma_slb;
> > -#endif
>=20
> I find it confusing to move this member to the stack, when other slb=20
> stay on the CPUState context on the heap.
>=20

The "other slb" sit in CPUPPCState because it is genuine state,
while vrma_slb is something we can derive from some other state
when we need it. David's patch goes into the good direction of
not exposing anymore something that shouldn't sit in CPUPPCState
in the first place.

What is confusing for you ?

> Consider amending the following (I can also send a patch later if you=20
> prefer):
>=20
> -- >8 --
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5a55fb02bd..ade71c3592 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -988,6 +988,7 @@ struct CPUPPCState {
>       /* MMU context, only relevant for full system emulation */
>   #if defined(TARGET_PPC64)
>       ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
> +    ppc_slb_t vrma_slbe;
>   #endif
>       target_ulong sr[32];   /* segment registers */
>       uint32_t nb_BATs;      /* number of BATs */
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 34f6009b1e..abbdd531c6 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -818,7 +818,6 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu,=20
> vaddr eaddr,
>   {
>       CPUState *cs =3D CPU(cpu);
>       CPUPPCState *env =3D &cpu->env;
> -    ppc_slb_t vrma_slbe;
>       ppc_slb_t *slb;
>       unsigned apshift;
>       hwaddr ptex;
> @@ -857,7 +856,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu,=20
> vaddr eaddr,
>               }
>           } else if (ppc_hash64_use_vrma(env)) {
>               /* Emulated VRMA mode */
> -            slb =3D &vrma_slbe;
> +            slb =3D &env->vrma_slbe;
>               if (build_vrma_slbe(cpu, slb) !=3D 0) {
>                   /* Invalid VRMA setup, machine check */
>                   cs->exception_index =3D POWERPC_EXCP_MCHECK;
> @@ -1006,7 +1005,6 @@ skip_slb_search:
>   hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong add=
r)
>   {
>       CPUPPCState *env =3D &cpu->env;
> -    ppc_slb_t vrma_slbe;
>       ppc_slb_t *slb;
>       hwaddr ptex, raddr;
>       ppc_hash_pte64_t pte;
> @@ -1028,7 +1026,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU=20
> *cpu, target_ulong addr)
>               return raddr | env->spr[SPR_HRMOR];
>           } else if (ppc_hash64_use_vrma(env)) {
>               /* Emulated VRMA mode */
> -            slb =3D &vrma_slbe;
> +            slb =3D &env->vrma_slbe;
>               if (build_vrma_slbe(cpu, slb) !=3D 0) {
>                   return -1;
>               }
> ---
>=20
> With the hunk amended I dare to give:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> >  =20
> >       int error_code;
> >       uint32_t pending_interrupts;
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index 4fd7b7ee74..34f6009b1e 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -784,11 +784,41 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
> >       return rma_sizes[rmls];
> >   }
> >  =20
> > +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> > +{
> > +    CPUPPCState *env =3D &cpu->env;
> > +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> > +    uint32_t vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> > +    target_ulong vsid =3D SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LL=
P_MASK);
> > +    int i;
> > +
> > +    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> > +        const PPCHash64SegmentPageSizes *sps =3D &cpu->hash64_opts->sp=
s[i];
> > +
> > +        if (!sps->page_shift) {
> > +            break;
> > +        }
> > +
> > +        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps->slb_enc) {
> > +            slb->esid =3D SLB_ESID_V;
> > +            slb->vsid =3D vsid;
> > +            slb->sps =3D sps;
> > +            return 0;
> > +        }
> > +    }
> > +
> > +    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=3D0x"
> > +                 TARGET_FMT_lx"\n", lpcr);
> > +
> > +    return -1;
> > +}
> > +
> >   int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
> >                                   int rwx, int mmu_idx)
> >   {
> >       CPUState *cs =3D CPU(cpu);
> >       CPUPPCState *env =3D &cpu->env;
> > +    ppc_slb_t vrma_slbe;
> >       ppc_slb_t *slb;
> >       unsigned apshift;
> >       hwaddr ptex;
> > @@ -827,8 +857,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
> >               }
> >           } else if (ppc_hash64_use_vrma(env)) {
> >               /* Emulated VRMA mode */
> > -            slb =3D &env->vrma_slb;
> > -            if (!slb->sps) {
> > +            slb =3D &vrma_slbe;
> > +            if (build_vrma_slbe(cpu, slb) !=3D 0) {
> >                   /* Invalid VRMA setup, machine check */
> >                   cs->exception_index =3D POWERPC_EXCP_MCHECK;
> >                   env->error_code =3D 0;
> > @@ -976,6 +1006,7 @@ skip_slb_search:
> >   hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong a=
ddr)
> >   {
> >       CPUPPCState *env =3D &cpu->env;
> > +    ppc_slb_t vrma_slbe;
> >       ppc_slb_t *slb;
> >       hwaddr ptex, raddr;
> >       ppc_hash_pte64_t pte;
> > @@ -997,8 +1028,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *=
cpu, target_ulong addr)
> >               return raddr | env->spr[SPR_HRMOR];
> >           } else if (ppc_hash64_use_vrma(env)) {
> >               /* Emulated VRMA mode */
> > -            slb =3D &env->vrma_slb;
> > -            if (!slb->sps) {
> > +            slb =3D &vrma_slbe;
> > +            if (build_vrma_slbe(cpu, slb) !=3D 0) {
> >                   return -1;
> >               }
> >           } else {
> > @@ -1037,65 +1068,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,=
 target_ulong ptex,
> >       cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCA=
L_FLUSH;
> >   }
> >  =20
> > -static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> > -{
> > -    CPUPPCState *env =3D &cpu->env;
> > -    const PPCHash64SegmentPageSizes *sps =3D NULL;
> > -    target_ulong esid, vsid, lpcr;
> > -    ppc_slb_t *slb =3D &env->vrma_slb;
> > -    uint32_t vrmasd;
> > -    int i;
> > -
> > -    /* First clear it */
> > -    slb->esid =3D slb->vsid =3D 0;
> > -    slb->sps =3D NULL;
> > -
> > -    /* Is VRMA enabled ? */
> > -    if (!ppc_hash64_use_vrma(env)) {
> > -        return;
> > -    }
> > -
> > -    /*
> > -     * Make one up. Mostly ignore the ESID which will not be needed
> > -     * for translation
> > -     */
> > -    lpcr =3D env->spr[SPR_LPCR];
> > -    vsid =3D SLB_VSID_VRMA;
> > -    vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> > -    vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
> > -    esid =3D SLB_ESID_V;
> > -
> > -    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> > -        const PPCHash64SegmentPageSizes *sps1 =3D &cpu->hash64_opts->s=
ps[i];
> > -
> > -        if (!sps1->page_shift) {
> > -            break;
> > -        }
> > -
> > -        if ((vsid & SLB_VSID_LLP_MASK) =3D=3D sps1->slb_enc) {
> > -            sps =3D sps1;
> > -            break;
> > -        }
> > -    }
> > -
> > -    if (!sps) {
> > -        error_report("Bad page size encoding esid 0x"TARGET_FMT_lx
> > -                     " vsid 0x"TARGET_FMT_lx, esid, vsid);
> > -        return;
> > -    }
> > -
> > -    slb->vsid =3D vsid;
> > -    slb->esid =3D esid;
> > -    slb->sps =3D sps;
> > -}
> > -
> >   void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
> >   {
> >       PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >       CPUPPCState *env =3D &cpu->env;
> >  =20
> >       env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
> > -    ppc_hash64_update_vrma(cpu);
> >   }
> >  =20
> >   void helper_store_lpcr(CPUPPCState *env, target_ulong val)
> >=20
>=20


