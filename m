Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65826C2BA80
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 03:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203C020747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 03:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JG/UEd5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203C020747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM17B-0002QA-6Y
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 23:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jM168-0001IU-FE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 23:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jM166-0008GM-6V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 23:09:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53649 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jM165-0008EA-1W; Tue, 07 Apr 2020 23:09:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xq543qQWz9sPF; Wed,  8 Apr 2020 13:09:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586315384;
 bh=Keb/J+DwRNuE6ILhMQ87EYv/ij2M0w4JarHyKYdJ7g4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JG/UEd5Z5YlRezCgnDfwVeiOlKI79opF9c+UdvI7gzx4ySnKrKp1AdDbV3oi7UyT8
 8WQEIj/B6DpBwMYlZfJEZCLhFFLJLoiaJ+T28hguJD04nT1hiYaQEQGipJU1lS0WQq
 nadcTnS0jBiPKvgHwOn6e1NJPyCdJlIRx72YZy18=
Date: Wed, 8 Apr 2020 13:09:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 4/4] target/ppc: Add support for Radix
 partition-scoped translation
Message-ID: <20200408030931.GB304335@umbus.fritz.box>
References: <20200403140056.59465-1-clg@kaod.org>
 <20200403140056.59465-5-clg@kaod.org>
 <20200403171129.71c86479@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20200403171129.71c86479@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 05:11:29PM +0200, Greg Kurz wrote:
> On Fri,  3 Apr 2020 16:00:56 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > The Radix tree translation model currently supports process-scoped
> > translation for the PowerNV machine (Hypervisor mode) and for the
> > pSeries machine (Guest mode). Guests running under an emulated
> > Hypervisor (PowerNV machine) require a new type of Radix translation,
> > called partition-scoped, which is missing today.
> >=20
> > The Radix tree translation is a 2 steps process. The first step,
> > process-scoped translation, converts an effective Address to a guest
> > real address, and the second step, partition-scoped translation,
> > converts a guest real address to a host real address.
> >=20
> > There are difference cases to covers :
> >=20
> > * Hypervisor real mode access: no Radix translation.
> >=20
> > * Hypervisor or host application access (quadrant 0 and 3) with
> >   relocation on: process-scoped translation.
> >=20
> > * Guest OS real mode access: only partition-scoped translation.
> >=20
> > * Guest OS real or guest application access (quadrant 0 and 3) with
> >   relocation on: both process-scoped translation and partition-scoped
> >   translations.
> >=20
> > * Hypervisor access in quadrant 1 and 2 with relocation on: both
> >   process-scoped translation and partition-scoped translations.
> >=20
> > The radix tree partition-scoped translation is performed using tables
> > pointed to by the first double-word of the Partition Table Entries and
> > process-scoped translation uses tables pointed to by the Process Table
> > Entries (second double-word of the Partition Table Entries).
> >=20
> > Both partition-scoped and process-scoped translations process are
> > identical and thus the radix tree traversing code is largely reused.
> > However, errors in partition-scoped translations generate hypervisor
> > exceptions.
> >=20
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  target/ppc/cpu.h         |   3 +
> >  target/ppc/excp_helper.c |   3 +-
> >  target/ppc/mmu-radix64.c | 188 +++++++++++++++++++++++++++++++++++----
> >  3 files changed, 175 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index f4a5304d4356..6b6dd7e483f1 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -463,6 +463,9 @@ typedef struct ppc_v3_pate_t {
> >  #define DSISR_AMR                0x00200000
> >  /* Unsupported Radix Tree Configuration */
> >  #define DSISR_R_BADCONFIG        0x00080000
> > +#define DSISR_ATOMIC_RC          0x00040000
> > +/* Unable to translate address of (guest) pde or process/page table en=
try */
> > +#define DSISR_PRTABLE_FAULT      0x00020000
> > =20
> >  /* SRR1 error code fields */
> > =20
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index 1acc3786de0e..f05297966472 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -506,9 +506,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, i=
nt excp_model, int excp)
> >      case POWERPC_EXCP_ISEG:      /* Instruction segment exception     =
       */
> >      case POWERPC_EXCP_TRACE:     /* Trace exception                   =
       */
> >          break;
> > +    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exc=
eption */
> > +        msr |=3D env->error_code;
> >      case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception  =
       */
> >      case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception =
       */
> > -    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage exc=
eption */
> >      case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception =
       */
> >      case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment exc=
eption */
> >      case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt     =
       */
> > diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> > index 2400da41e06c..d473dc742e11 100644
> > --- a/target/ppc/mmu-radix64.c
> > +++ b/target/ppc/mmu-radix64.c
> > @@ -103,6 +103,27 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, =
int rwx, vaddr eaddr,
> >      }
> >  }
> > =20
> > +static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, int rwx, vaddr eadd=
r,
> > +                                  hwaddr g_raddr, uint32_t cause)
> > +{
> > +    CPUState *cs =3D CPU(cpu);
> > +    CPUPPCState *env =3D &cpu->env;
> > +
> > +    if (rwx =3D=3D 2) { /* H Instruction Storage Interrupt */
> > +        cs->exception_index =3D POWERPC_EXCP_HISI;
> > +        env->spr[SPR_ASDR] =3D g_raddr;
> > +        env->error_code =3D cause;
> > +    } else { /* H Data Storage Interrupt */
> > +        cs->exception_index =3D POWERPC_EXCP_HDSI;
> > +        if (rwx =3D=3D 1) { /* Write -> Store */
> > +            cause |=3D DSISR_ISSTORE;
> > +        }
> > +        env->spr[SPR_HDSISR] =3D cause;
> > +        env->spr[SPR_HDAR] =3D eaddr;
> > +        env->spr[SPR_ASDR] =3D g_raddr;
> > +        env->error_code =3D 0;
> > +    }
> > +}
> > =20
> >  static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t =
pte,
> >                                     int *fault_cause, int *prot,
> > @@ -243,6 +264,37 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_=
t lpid, ppc_v3_pate_t *pate)
> >      return true;
> >  }
> > =20
> > +static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
> > +                                              vaddr eaddr, hwaddr g_ra=
ddr,
> > +                                              ppc_v3_pate_t pate,
> > +                                              hwaddr *h_raddr, int *h_=
prot,
> > +                                              int *h_page_size, bool p=
de_addr,
> > +                                              bool cause_excp)
> > +{
> > +    int fault_cause =3D 0;
> > +    hwaddr pte_addr;
> > +    uint64_t pte;
> > +
> > +    *h_page_size =3D PRTBE_R_GET_RTS(pate.dw0);
> > +    /* No valid pte or access denied due to protection */
> > +    if (ppc_radix64_walk_tree(CPU(cpu)->as, g_raddr, pate.dw0 & PRTBE_=
R_RPDB,
> > +                              pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page=
_size,
> > +                              &pte, &fault_cause, &pte_addr) ||
> > +        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, tr=
ue)) {
> > +        if (pde_addr) /* address being translated was that of a guest =
pde */
> > +            fault_cause |=3D DSISR_PRTABLE_FAULT;
> > +        if (cause_excp) {
> > +            ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_caus=
e);
> > +        }
> > +        return 1;
> > +    }
> > +
> > +    /* Update Reference and Change Bits */
> > +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> > +
> > +    return 0;
> > +}
> > +
> >  static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
> >                                              vaddr eaddr, uint64_t pid,
> >                                              ppc_v3_pate_t pate, hwaddr=
 *g_raddr,
> > @@ -250,9 +302,10 @@ static int ppc_radix64_process_scoped_xlate(PowerP=
CCPU *cpu, int rwx,
> >                                              bool cause_excp)
> >  {
> >      CPUState *cs =3D CPU(cpu);
> > -    uint64_t offset, size, prtbe_addr, prtbe0, pte;
> > -    int fault_cause =3D 0;
> > -    hwaddr pte_addr;
> > +    CPUPPCState *env =3D &cpu->env;
> > +    uint64_t offset, size, prtbe_addr, prtbe0, base_addr, nls, index, =
pte;
> > +    int fault_cause =3D 0, h_page_size, h_prot;
> > +    hwaddr h_raddr, pte_addr;
> >      int ret;
> > =20
> >      /* Index Process Table by PID to Find Corresponding Process Table =
Entry */
> > @@ -266,18 +319,85 @@ static int ppc_radix64_process_scoped_xlate(Power=
PCCPU *cpu, int rwx,
> >          return 1;
> >      }
> >      prtbe_addr =3D (pate.dw1 & PATE1_R_PRTB) + offset;
> > -    prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
> > +
> > +    if (cpu->vhyp) {
> > +        prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
> > +    } else {
> > +        /*
> > +         * Process table addresses are subject to partition-scoped
> > +         * translation
> > +         *
> > +         * On a Radix host, the partition-scoped page table for LPID=
=3D0
> > +         * is only used to translate the effective addresses of the
> > +         * process table entries.
> > +         */
> > +        ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtb=
e_addr,
> > +                                                 pate, &h_raddr, &h_pr=
ot,
> > +                                                 &h_page_size, 1, 1);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +        prtbe0 =3D ldq_phys(cs->as, h_raddr);
> > +    }
> > =20
> >      /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> >      *g_page_size =3D PRTBE_R_GET_RTS(prtbe0);
> > -    ret =3D ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK,
> > -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_=
R_RPDS,
> > -                                g_raddr, g_page_size, &pte, &fault_cau=
se,
> > -                                &pte_addr);
> > -
> > -    if (ret ||
> > -        ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, fa=
lse)) {
> > -        /* No valid pte or access denied due to protection */
> > +    base_addr =3D prtbe0 & PRTBE_R_RPDB;
> > +    nls =3D prtbe0 & PRTBE_R_RPDS;
> > +    if (msr_hv || cpu->vhyp) {
> > +        /*
> > +         * Can treat process table addresses as real addresses
> > +         */
> > +        ret =3D ppc_radix64_walk_tree(cs->as, eaddr & R_EADDR_MASK, ba=
se_addr,
> > +                                    nls, g_raddr, g_page_size, &pte,
> > +                                    &fault_cause, &pte_addr);
> > +        if (ret) {
> > +            /* No valid PTE */
> > +            if (cause_excp) {
> > +                ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> > +            }
> > +            return ret;
> > +        }
> > +    } else {
> > +        uint64_t rpn, mask;
> > +
> > +        index =3D (eaddr & R_EADDR_MASK) >> (*g_page_size - nls); /* S=
hift */
> > +        index &=3D ((1UL << nls) - 1);                            /* M=
ask */
> > +        pte_addr =3D base_addr + (index * sizeof(pte));
> > +
> > +        /*
> > +         * Each process table address is subject to a partition-scoped
> > +         * translation
> > +         */
> > +        do {
> > +            ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, =
pte_addr,
> > +                                                     pate, &h_raddr, &=
h_prot,
> > +                                                     &h_page_size, 1, =
1);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +
> > +            ret =3D ppc_radix64_next_level(cs->as, eaddr & R_EADDR_MAS=
K, &h_raddr,
> > +                                         &nls, g_page_size, &pte, &fau=
lt_cause);
> > +            if (ret) {
> > +                /* No valid pte */
> > +                if (cause_excp) {
> > +                    ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> > +                }
> > +                return ret;
> > +            }
> > +            pte_addr =3D h_raddr;
> > +        } while (!(pte & R_PTE_LEAF));
> > +
> > +        rpn =3D pte & R_PTE_RPN;
> > +        mask =3D (1UL << *g_page_size) - 1;
> > +
> > +        /* Or high bits of rpn and low bits to ea to form whole real a=
ddr */
> > +        *g_raddr =3D (rpn & ~mask) | (eaddr & mask);
> > +    }
> > +
> > +    if (ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, fa=
lse)) {
> > +        /* Access denied due to protection */
> >          if (cause_excp) {
> >              ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> >          }
> > @@ -289,11 +409,29 @@ static int ppc_radix64_process_scoped_xlate(Power=
PCCPU *cpu, int rwx,
> >      return 0;
> >  }
> > =20
> > +/*
> > + * Radix tree translation is a 2 steps translation process:
> > + *
> > + * 1. Process-scoped translation:   Guest Eff Addr  -> Guest Real Addr
> > + * 2. Partition-scoped translation: Guest Real Addr -> Host Real Addr
> > + *
> > + *                                  MSR[HV]
> > + *              +-------------+----------------+---------------+
> > + *              |             |     HV =3D 0     |     HV =3D 1    |
> > + *              +-------------+----------------+---------------+
> > + *              | Relocation  |    Partition   |      No       |
> > + *              | =3D Off       |     Scoped     |  Translation  |
> > + *  Relocation  +-------------+----------------+---------------+
> > + *              | Relocation  |   Partition &  |    Process    |
> > + *              | =3D On        | Process Scoped |    Scoped     |
> > + *              +-------------+----------------+---------------+
> > + */
> >  static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> >                               bool relocation,
> >                               hwaddr *raddr, int *psizep, int *protp,
> >                               bool cause_excp)
> >  {
> > +    CPUPPCState *env =3D &cpu->env;
> >      uint64_t lpid =3D 0, pid =3D 0;
> >      ppc_v3_pate_t pate;
> >      int psize, prot;
> > @@ -325,11 +463,6 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vadd=
r eaddr, int rwx,
> >              }
> >              return 1;
> >          }
> > -        /* We don't support guest mode yet */
> > -        if (lpid !=3D 0) {
> > -            error_report("PowerNV guest support Unimplemented");
> > -            exit(1);
> > -        }
> >      }
> > =20
> >      *psizep =3D INT_MAX;
> > @@ -340,6 +473,8 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr=
 eaddr, int rwx,
> >       *
> >       * - Translates an effective address to a host real address in
> >       *   quadrants 0 and 3 when HV=3D1.
> > +     *
> > +     * - Translates an effective address to a guest real address.
> >       */
> >      if (relocation) {
> >          int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, =
pid,
> > @@ -354,7 +489,24 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vadd=
r eaddr, int rwx,
> >          g_raddr =3D eaddr & R_EADDR_MASK;
> >      }
> > =20
> > -    *raddr =3D g_raddr;
> > +    /*
> > +     * Perform partition-scoped translation if !HV or HV access to
> > +     * quadrants 1 or 2. Translates a guest real address to a host
> > +     * real address.
> > +     */
> > +    if ((lpid !=3D 0) || (!cpu->vhyp && !msr_hv)) {
>=20
> This check is too complex for my taste. Also it doesn't seem right
> to look at lpid if the machine is pseries, even if it would happen
> to work because pseries cannot have lpid !=3D 0. I think we should
> have distinct paths for powernv and pseries.
>=20
> A bit like with the following squashed in:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -489,22 +489,28 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr=
 eaddr, int rwx,
>          g_raddr =3D eaddr & R_EADDR_MASK;
>      }
> =20
> -    /*
> -     * Perform partition-scoped translation if !HV or HV access to
> -     * quadrants 1 or 2. Translates a guest real address to a host
> -     * real address.
> -     */
> -    if ((lpid !=3D 0) || (!cpu->vhyp && !msr_hv)) {
> -        int ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, =
g_raddr,
> +    if (cpu->vhyp) {
> +        *raddr =3D g_raddr;
> +    } else {
> +        /*
> +         * Perform partition-scoped translation if !HV or HV access to
> +         * quadrants 1 or 2. Translates a guest real address to a host
> +         * real address.
> +         */
> +        if (lpid || !msr_hv) {
> +            int ret;
> +
> +            ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, =
g_raddr,
>                                                       pate, raddr, &prot,=
 &psize,
>                                                       0, cause_excp);
> -        if (ret) {
> -            return ret;
> +            if (ret) {
> +                return ret;
> +            }
> +            *psizep =3D MIN(*psizep, psize);
> +            *protp &=3D prot;
> +        } else {
> +            *raddr =3D g_raddr;
>          }
> -        *psizep =3D MIN(*psizep, psize);
> -        *protp &=3D prot;
> -    } else {
> -        *raddr =3D g_raddr;
>      }
> =20
>      return 0;
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> David,
>=20
> If my comment makes sense to you, can you squash the above fix into
> Cedric's patch ?

Yes.  I also think we shouldn't be looking at lpid for the vhyp case.
I've applied the rest of the series to ppc-for-5.1, and folded in this
correction as suggested.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6NQGgACgkQbDjKyiDZ
s5LitxAAyj6ItkE6uLycSMtREJprg9QWPrMLz298sLbfs0nHnmAIFFe7l3qdk/RK
rRE9fu4AEWh9T2zqhVA1JoME/AAqC+eEoYF9uXyc5wrkPWM8zrnoCV2JbdepiAEj
KCeiU9a8uN0j83WKMze+uWNVDi2afgujQ3VejQV41JJ9aao8EQbwGIjaTEOtppou
LiudX4cwERBCMsmrZJcBlIBZnePTNNLIWLjB2yCXS6NMpDqjzkBtGsKwD+C+FTHI
IatL3ZgK1m6JI2pZoP0lQw1+7Gu3fPi8vbYMtTQgpuvl1YlzM7eBBy7knwntik6H
Rv+4Tlu1bWx+2MXA35KQPscZ+45rmubYPQk5fhhja/Al3S1jDycVS7VIUx8Q/bj7
5maSB6cuY47fykoh8s5RB0AtqcAvqe+7y3YPWDj3zp1y/nK0RVJu6g0UDQCm9h8A
RSpMappWLP4Vryl+mN9jicbm+d2jFrizdmP5+J03S4UAtxo+lCBUoWVWdR0fPS8D
N9+aqBtziyV2x0X/jEeXZd61tFfQjSFuXzhIXwgTnzaRvyT68tphvcpZtWXAMLHz
QPUCE/HpBYBYESktPCEdmY8ShSfS2C+sDniTpxuVG/V66PX+BPJ33zjUgYRpMZ6m
zvUaFFtIu01BuzOUbKiqwC8BrZw3WSX/W/hd8ALVeVsjpHwcEaY=
=V3WR
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

