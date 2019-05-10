Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3CC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300AD2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JpigxmsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300AD2182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvo0-0004Bl-EN
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:02:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjL-0000Us-1S
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjI-00019b-CE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39883 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjH-00015y-CU; Thu, 09 May 2019 22:57:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdM3pcMz9sNK; Fri, 10 May 2019 12:57:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457063;
	bh=TseU17s2S5xWl6vbAglh9hmCiSXbpfuODL34fQ+ce0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpigxmsPQCa0wesRTn13FsZFs17kDd9bi4Yf5PwBMph/rAnw77z3Mly7Z7UJ3ajzK
	zMyiB+WmtrAAOsNPR7eOi99UvIbYii74ApajRSryrwkEOHa/upIMCINdwB9GBkWMKC
	0n7knbQ3vLvLI21PNpyrgciDD5F5nb9aWC4cNAxQ=
Date: Fri, 10 May 2019 12:28:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510022817.GC20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-8-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-8-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 07/13] target/ppc: Handle
 partition scoped radix tree translation
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


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:10PM +1000, Suraj Jitindar Singh wrote:
> Radix tree translation is a 2 step process:
>=20
> Process Scoped Translation:
> Effective Address (EA) -> Virtual Address (VA)
>=20
> Paritition Scoped Translation:
> Virtual Address (VA) -> Real Address (RA)
>=20
> Performed based on:
>                                       MSR[HV]
>            -----------------------------------------------
>            |             |     HV =3D 0    |     HV =3D 1    |
>            -----------------------------------------------
>            | Relocation  |   Partition   |      No       |
>            | =3D Off       |    Scoped     |  Translation  |
> Relocation -----------------------------------------------
>            | Relocation  |  Partition &  |    Process    |
>            | =3D On        |Process Scoped |    Scoped     |
>            -----------------------------------------------
>=20
> Currently only process scoped translation is handled.
> Implement partitition scoped translation.
>=20
> The process of using the radix trees to perform partition scoped
> translation is identical to process scoped translation, however
> hypervisor exceptions are generated, and thus we can reuse the radix
> tree traversing code.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/cpu.h         |   2 +
>  target/ppc/excp_helper.c |   3 +-
>  target/ppc/mmu-radix64.c | 407 +++++++++++++++++++++++++++++++++--------=
------
>  3 files changed, 293 insertions(+), 119 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 1d2a088391..3acc248f40 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -501,6 +501,8 @@ typedef struct ppc_v3_pate_t {
>  /* Unsupported Radix Tree Configuration */
>  #define DSISR_R_BADCONFIG        0x00080000
>  #define DSISR_ATOMIC_RC          0x00040000
> +/* Unable to translate address of (guest) pde or process/page table entr=
y */
> +#define DSISR_PRTABLE_FAULT      0x00020000
> =20
>  /* SRR1 error code fields */
> =20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 7a4da7bdba..10091d4624 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -441,9 +441,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>      case POWERPC_EXCP_ISEG:      /* Instruction segment exception       =
     */
>      case POWERPC_EXCP_TRACE:     /* Trace exception                     =
     */
>          break;
> +    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
> +        msr |=3D env->error_code;
>      case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception    =
     */
>      case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception   =
     */
> -    case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
>      case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception   =
     */
>      case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment excep=
tion */
>      case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt       =
     */
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index afa5ba506a..6118ad1b00 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -112,9 +112,31 @@ static void ppc_radix64_raise_si(PowerPCCPU *cpu, in=
t rwx, vaddr eaddr,
>      }
>  }
> =20
> +static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, int rwx, vaddr eaddr,
> +                                  hwaddr g_raddr, uint32_t cause)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    if (rwx =3D=3D 2) { /* H Instruction Storage Interrupt */
> +        cs->exception_index =3D POWERPC_EXCP_HISI;
> +        env->spr[SPR_ASDR] =3D g_raddr;
> +        env->error_code =3D cause;
> +    } else { /* H Data Storage Interrupt */
> +        cs->exception_index =3D POWERPC_EXCP_HDSI;
> +        if (rwx =3D=3D 1) { /* Write -> Store */
> +            cause |=3D DSISR_ISSTORE;
> +        }
> +        env->spr[SPR_HDSISR] =3D cause;
> +        env->spr[SPR_HDAR] =3D eaddr;
> +        env->spr[SPR_ASDR] =3D g_raddr;
> +        env->error_code =3D 0;
> +    }
> +}
> =20
>  static bool ppc_radix64_check_prot(PowerPCCPU *cpu, int rwx, uint64_t pt=
e,
> -                                   int *fault_cause, int *prot)
> +                                   int *fault_cause, int *prot,
> +                                   bool partition_scoped)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      const int need_prot[] =3D { PAGE_READ, PAGE_WRITE, PAGE_EXEC };
> @@ -130,11 +152,11 @@ static bool ppc_radix64_check_prot(PowerPCCPU *cpu,=
 int rwx, uint64_t pte,
>      }
> =20
>      /* Determine permissions allowed by Encoded Access Authority */
> -    if ((pte & R_PTE_EAA_PRIV) && msr_pr) { /* Insufficient Privilege */
> +    if (!partition_scoped && (pte & R_PTE_EAA_PRIV) && msr_pr) {
>          *prot =3D 0;
> -    } else if (msr_pr || (pte & R_PTE_EAA_PRIV)) {
> +    } else if (msr_pr || (pte & R_PTE_EAA_PRIV) || partition_scoped) {
>          *prot =3D ppc_radix64_get_prot_eaa(pte);
> -    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) */
> +    } else { /* !msr_pr && !(pte & R_PTE_EAA_PRIV) && !partition_scoped =
*/
>          *prot =3D ppc_radix64_get_prot_eaa(pte);
>          *prot &=3D ppc_radix64_get_prot_amr(cpu); /* Least combined perm=
issions */
>      }
> @@ -199,44 +221,196 @@ static uint64_t ppc_radix64_set_rc(PowerPCCPU *cpu=
, int rwx, uint64_t pte, hwadd
>      return npte;
>  }
> =20
> -static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
> -                                      uint64_t base_addr, uint64_t nls,
> -                                      hwaddr *raddr, int *psize,
> -                                      int *fault_cause, hwaddr *pte_addr)
> +static uint64_t ppc_radix64_next_level(PowerPCCPU *cpu, vaddr eaddr,
> +                                       uint64_t *pte_addr, uint64_t *nls,
> +                                       int *psize, int *fault_cause)
>  {
>      CPUState *cs =3D CPU(cpu);
>      uint64_t index, pde;
> =20
> -    if (nls < 5) { /* Directory maps less than 2**5 entries */
> +    if (*nls < 5) { /* Directory maps less than 2**5 entries */
>          *fault_cause |=3D DSISR_R_BADCONFIG;
>          return 0;
>      }
> =20
>      /* Read page <directory/table> entry from guest address space */
> -    index =3D eaddr >> (*psize - nls); /* Shift */
> -    index &=3D ((1UL << nls) - 1); /* Mask */
> -    pde =3D ldq_phys(cs->as, base_addr + (index * sizeof(pde)));
> -    if (!(pde & R_PTE_VALID)) { /* Invalid Entry */
> +    pde =3D ldq_phys(cs->as, *pte_addr);
> +    if (!(pde & R_PTE_VALID)) {         /* Invalid Entry */
>          *fault_cause |=3D DSISR_NOPTE;
>          return 0;
>      }
> =20
> -    *psize -=3D nls;
> +    *psize -=3D *nls;
> +    if (!(pde & R_PTE_LEAF)) { /* Prepare for next iteration */
> +        *nls =3D pde & R_PDE_NLS;
> +        index =3D eaddr >> (*psize - *nls);       /* Shift */
> +        index &=3D ((1UL << *nls) - 1);           /* Mask */
> +        *pte_addr =3D (pde & R_PDE_NLB) + (index * sizeof(pde));
> +    }
> +    return pde;
> +}
> +
> +static uint64_t ppc_radix64_walk_tree(PowerPCCPU *cpu, vaddr eaddr,
> +                                      uint64_t base_addr, uint64_t nls,
> +                                      hwaddr *raddr, int *psize,
> +                                      int *fault_cause, hwaddr *pte_addr)
> +{
> +    uint64_t index, pde;
> +
> +    index =3D eaddr >> (*psize - nls);    /* Shift */
> +    index &=3D ((1UL << nls) - 1);       /* Mask */
> +    *pte_addr =3D base_addr + (index * sizeof(pde));
> +    do {
> +        pde =3D ppc_radix64_next_level(cpu, eaddr, pte_addr, &nls, psize,
> +                                     fault_cause);
> +    } while ((pde & R_PTE_VALID) && !(pde & R_PTE_LEAF));
> =20
> -    /* Check if Leaf Entry -> Page Table Entry -> Stop the Search */
> -    if (pde & R_PTE_LEAF) {
> +    /* Did we find a valid leaf? */
> +    if ((pde & R_PTE_VALID) && (pde & R_PTE_LEAF)) {
>          uint64_t rpn =3D pde & R_PTE_RPN;
>          uint64_t mask =3D (1UL << *psize) - 1;
> =20
>          /* Or high bits of rpn and low bits to ea to form whole real add=
r */
>          *raddr =3D (rpn & ~mask) | (eaddr & mask);
> -        *pte_addr =3D base_addr + (index * sizeof(pde));
> -        return pde;
>      }
> =20
> -    /* Next Level of Radix Tree */
> -    return ppc_radix64_walk_tree(cpu, eaddr, pde & R_PDE_NLB, pde & R_PD=
E_NLS,
> -                                 raddr, psize, fault_cause, pte_addr);
> +    return pde;
> +}
> +
> +static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
> +                                              vaddr eaddr, hwaddr g_radd=
r,
> +                                              ppc_v3_pate_t pate,
> +                                              hwaddr *h_raddr, int *h_pr=
ot,
> +                                              int *h_page_size, bool pde=
_addr,
> +                                              bool cause_excp)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    int fault_cause =3D 0;
> +    hwaddr pte_addr;
> +    uint64_t pte;
> +
> +restart:
> +    *h_page_size =3D PRTBE_R_GET_RTS(pate.dw0);
> +    pte =3D ppc_radix64_walk_tree(cpu, g_raddr, pate.dw0 & PRTBE_R_RPDB,
> +                                pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page=
_size,
> +                                &fault_cause, &pte_addr);
> +    /* No valid pte or access denied due to protection */
> +    if (!(pte & R_PTE_VALID) ||
> +            ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, =
1)) {
> +        if (pde_addr) /* address being translated was that of a guest pd=
e */
> +            fault_cause |=3D DSISR_PRTABLE_FAULT;
> +        if (cause_excp)
> +            ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
> +        return 1;
> +    }
> +
> +    /* Update Reference and Change Bits */
> +    if (ppc_radix64_hw_rc_updates(env)) {
> +        pte =3D ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
> +        if (!pte) {
> +            goto restart;
> +        }
> +    }
> +
> +    /* If the page doesn't have C, treat it as read only */
> +    if (!(pte & R_PTE_C))
> +        *h_prot &=3D ~PAGE_WRITE;
> +
> +    return 0;
> +}
> +
> +static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
> +                                            vaddr eaddr, uint64_t lpid, =
uint64_t pid,
> +                                            ppc_v3_pate_t pate, hwaddr *=
g_raddr,
> +                                            int *g_prot, int *g_page_siz=
e,
> +                                            bool cause_excp)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint64_t offset, size, prtbe_addr, prtbe0, base_addr, nls, index, pt=
e;
> +    int fault_cause =3D 0, h_page_size, h_prot, ret;
> +    hwaddr h_raddr, pte_addr;
> +
> +    /* Index Process Table by PID to Find Corresponding Process Table En=
try */
> +    offset =3D pid * sizeof(struct prtb_entry);
> +    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> +    if (offset >=3D size) {
> +        /* offset exceeds size of the process table */
> +        if (cause_excp)
> +            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> +        return 1;
> +    }
> +    prtbe_addr =3D (pate.dw1 & PATE1_R_PRTB) + offset;
> +    /* address subject to partition scoped translation */
> +    if (cpu->vhyp && (lpid =3D=3D 0)) {
> +        prtbe0 =3D ldq_phys(cs->as, prtbe_addr);
> +    } else {
> +        ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_=
addr,
> +                                                 pate, &h_raddr, &h_prot,
> +                                                 &h_page_size, 1, 1);
> +        if (ret)
> +            return ret;
> +        prtbe0 =3D ldq_phys(cs->as, h_raddr);
> +    }
> +
> +    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> +restart:
> +    *g_page_size =3D PRTBE_R_GET_RTS(prtbe0);
> +    base_addr =3D prtbe0 & PRTBE_R_RPDB;
> +    nls =3D prtbe0 & PRTBE_R_RPDS;
> +    if (msr_hv || (cpu->vhyp && (lpid =3D=3D 0))) {
> +        /* Can treat process tree addresses as real addresses */
> +        pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK, base_ad=
dr, nls,
> +                                    g_raddr, g_page_size, &fault_cause,
> +                                    &pte_addr);
> +    } else {
> +        index =3D (eaddr & R_EADDR_MASK) >> (*g_page_size - nls); /* Shi=
ft */
> +        index &=3D ((1UL << nls) - 1);                            /* Mas=
k */
> +        pte_addr =3D base_addr + (index * sizeof(pte));
> +
> +        /* Each process tree address subject to partition scoped transla=
tion */
> +        do {
> +            ret =3D ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pt=
e_addr,
> +                                                     pate, &h_raddr, &h_=
prot,
> +                                                     &h_page_size, 1, 1);
> +            if (ret)
> +                return ret;
> +
> +            pte =3D ppc_radix64_next_level(cpu, eaddr & R_EADDR_MASK, &h=
_raddr,
> +                                         &nls, g_page_size, &fault_cause=
);
> +            pte_addr =3D h_raddr;
> +        } while ((pte & R_PTE_VALID) && !(pte & R_PTE_LEAF));
> +
> +        /* Did we find a valid leaf? */
> +        if ((pte & R_PTE_VALID) && (pte & R_PTE_LEAF)) {
> +            uint64_t rpn =3D pte & R_PTE_RPN;
> +            uint64_t mask =3D (1UL << *g_page_size) - 1;
> +
> +            /* Or high bits of rpn and low bits to ea to form whole real=
 addr */
> +            *g_raddr =3D (rpn & ~mask) | (eaddr & mask);
> +        }
> +    }
> +
> +    if (!(pte & R_PTE_VALID) ||
> +            ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, =
0)) {
> +        /* No valid pte or access denied due to protection */
> +        if (cause_excp)
> +            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> +        return 1;
> +    }
> +
> +    /* Update Reference and Change Bits */
> +    if (ppc_radix64_hw_rc_updates(env)) {
> +        pte =3D ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
> +        if (!pte)
> +            goto restart;
> +    }
> +
> +    /* If the page doesn't have C, treat it as read only */
> +    if (!(pte & R_PTE_C))
> +        *g_prot &=3D ~PAGE_WRITE;
> +
> +    return 0;
>  }
> =20
>  static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t =
*pate)
> @@ -255,22 +429,99 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t=
 lpid, ppc_v3_pate_t *pate)
>      return true;
>  }
> =20
> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> +                             uint64_t lpid, uint64_t pid, bool relocatio=
n,
> +                             hwaddr *raddr, int *psizep, int *protp,
> +                             bool cause_excp)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    ppc_v3_pate_t pate;
> +    int psize, prot;
> +    hwaddr g_raddr;
> +
> +    *psizep =3D INT_MAX;
> +    *protp =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +
> +    /* Get Process Table */
> +    if (cpu->vhyp && (lpid =3D=3D 0)) {
> +        PPCVirtualHypervisorClass *vhc;
> +        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->get_pate(cpu->vhyp, &pate);
> +    } else {
> +        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> +            if (cause_excp)
> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> +            return 1;
> +        }
> +        if (!validate_pate(cpu, lpid, &pate)) {
> +            if (cause_excp)
> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
> +            return 1;
> +        }
> +    }
> +
> +    /*
> +     * Radix tree translation is a 2 step translation process:
> +     * 1. Process Scoped translation - Guest Eff Addr -> Guest Real Addr
> +     * 2. Partition Scoped translation - Guest Real Addr -> Host Real Ad=
dr
> +     *
> +     *                                       MSR[HV]
> +     *            -----------------------------------------------
> +     *            |             |     HV =3D 0    |     HV =3D 1    |
> +     *            -----------------------------------------------
> +     *            | Relocation  |   Partition   |      No       |
> +     *            | =3D Off       |    Scoped     |  Translation  |
> +     * Relocation -----------------------------------------------
> +     *            | Relocation  |  Partition &  |    Process    |
> +     *            | =3D On        |Process Scoped |    Scoped     |
> +     *            -----------------------------------------------
> +     */
> +
> +    /* Perform process scoped translation if relocation enabled */
> +    if (relocation) {
> +        int ret =3D ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, lp=
id, pid,
> +                                                   pate, &g_raddr, &prot,
> +                                                   &psize, cause_excp);
> +        if (ret)
> +            return ret;
> +        *psizep =3D MIN(*psizep, psize);
> +        *protp &=3D prot;
> +    } else {
> +        g_raddr =3D eaddr & R_EADDR_MASK;
> +    }
> +
> +    /* Perform partition scoped xlate if !HV or HV access to quadrants 1=
 or 2 */

I'm not seeing any test on the quadrant below.

> +    if ((lpid !=3D 0) || (!cpu->vhyp && !msr_hv)) {
> +        int ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, =
g_raddr,
> +                                                     pate, raddr, &prot,=
 &psize,
> +                                                     0, cause_excp);
> +        if (ret)
> +            return ret;
> +        *psizep =3D MIN(*psizep, psize);
> +        *protp &=3D prot;
> +    } else {
> +        *raddr =3D g_raddr;
> +    }
> +
> +    return 0;
> +}
> +
>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                   int mmu_idx)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    PPCVirtualHypervisorClass *vhc;
> -    hwaddr raddr, pte_addr;
> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> -    int page_size, prot, fault_cause =3D 0;
> -    ppc_v3_pate_t pate;
> +    uint64_t pid, lpid =3D env->spr[SPR_LPIDR];
> +    int psize, prot;
> +    bool relocation;
> +    hwaddr raddr;
> =20
> +    assert(!(msr_hv && cpu->vhyp));
>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> =20
> +    relocation =3D ((rwx =3D=3D 2) && (msr_ir =3D=3D 1)) || ((rwx !=3D 2=
) && (msr_dr =3D=3D 1));
>      /* HV or virtual hypervisor Real Mode Access */
> -    if ((msr_hv || cpu->vhyp) &&
> -        (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_=
dr =3D=3D 0)))) {
> +    if (!relocation && (msr_hv || (cpu->vhyp && (lpid =3D=3D 0)))) {
>          /* In real mode top 4 effective addr bits (mostly) ignored */
>          raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
> =20
> @@ -294,75 +545,26 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
>          return 1;
>      }
> =20
> -    /* Get Process Table */
> -    if (cpu->vhyp) {
> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->get_pate(cpu->vhyp, &pate);
> -    } else {
> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> -            return 1;
> -        }
> -        if (!validate_pate(cpu, lpid, &pate)) {
> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
> -        }
> -        /* We don't support guest mode yet */
> -        if (lpid !=3D 0) {
> -            error_report("PowerNV guest support Unimplemented");
> -            exit(1);
> -       }
> -    }
> -
> -    /* Index Process Table by PID to Find Corresponding Process Table En=
try */
> -    offset =3D pid * sizeof(struct prtb_entry);
> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> -    if (offset >=3D size) {
> -        /* offset exceeds size of the process table */
> -        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
> -        return 1;
> -    }
> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> -
> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> - restart:
> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
> -                                &raddr, &page_size, &fault_cause, &pte_a=
ddr);
> -    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &pro=
t)) {
> -        /* Couldn't get pte or access denied due to protection */
> -        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
> +    /* Translate eaddr to raddr (where raddr is addr qemu needs for acce=
ss) */
> +    if (ppc_radix64_xlate(cpu, eaddr, rwx, lpid, pid, relocation, &raddr,
> +                          &psize, &prot, 1)) {
>          return 1;
>      }
> =20
> -    /* Update Reference and Change Bits */
> -    if (ppc_radix64_hw_rc_updates(env)) {
> -        pte =3D ppc_radix64_set_rc(cpu, rwx, pte, pte_addr);
> -        if (!pte) {
> -            goto restart;
> -        }
> -    }
> -    /* If the page doesn't have C, treat it as read only */
> -    if (!(pte & R_PTE_C)) {
> -        prot &=3D ~PAGE_WRITE;
> -    }
>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
> -                 prot, mmu_idx, 1UL << page_size);
> +                 prot, mmu_idx, 1UL << psize);
>      return 0;
>  }
> =20
>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong ead=
dr)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    PPCVirtualHypervisorClass *vhc;
> -    hwaddr raddr, pte_addr;
> -    uint64_t lpid =3D 0, pid =3D 0, offset, size, prtbe0, pte;
> -    int page_size, fault_cause =3D 0;
> -    ppc_v3_pate_t pate;
> +    uint64_t lpid =3D 0, pid =3D 0;
> +    int psize, prot;
> +    hwaddr raddr;
> =20
>      /* Handle Real Mode */
> -    if (msr_dr =3D=3D 0) {
> +    if ((msr_dr =3D=3D 0) && (msr_hv || (cpu->vhyp && (lpid =3D=3D 0))))=
 {
>          /* In real mode top 4 effective addr bits (mostly) ignored */
>          return eaddr & 0x0FFFFFFFFFFFFFFFULL;
>      }
> @@ -372,39 +574,8 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *c=
pu, target_ulong eaddr)
>          return -1;
>      }
> =20
> -    /* Get Process Table */
> -    if (cpu->vhyp) {
> -        vhc =3D PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -        vhc->get_pate(cpu->vhyp, &pate);
> -    } else {
> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> -            return -1;
> -        }
> -        if (!validate_pate(cpu, lpid, &pate)) {
> -            return -1;
> -        }
> -        /* We don't support guest mode yet */
> -        if (lpid !=3D 0) {
> -            error_report("PowerNV guest support Unimplemented");
> -            exit(1);
> -       }
> -    }
> -
> -    /* Index Process Table by PID to Find Corresponding Process Table En=
try */
> -    offset =3D pid * sizeof(struct prtb_entry);
> -    size =3D 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
> -    if (offset >=3D size) {
> -        /* offset exceeds size of the process table */
> -        return -1;
> -    }
> -    prtbe0 =3D ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
> -
> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
> -    page_size =3D PRTBE_R_GET_RTS(prtbe0);
> -    pte =3D ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_=
RPDS,
> -                                &raddr, &page_size, &fault_cause, &pte_a=
ddr);
> -    if (!pte) {
> +    if (ppc_radix64_xlate(cpu, eaddr, 0, lpid, pid, msr_dr, &raddr, &psi=
ze,
> +                          &prot, 0)) {
>          return -1;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU4b4ACgkQbDjKyiDZ
s5LHfxAAlZ804HQQq/P4Vu9RBkV1WsUh7wCzX+AqMcBy+u8aU0JE8HPOfXSwC8L0
KnZgwxcdVq3v8JqQG5PT8VL7qic/cAafxIfzACVyu+FvA/DX97jfYTPw9hNf736m
xPk9pcwayCWfTqlgpj5pqqe50WMVqa9lgkuezOFlwKO0L3Ijpu4FumgTXdoEenvU
L4T45nJZUTkC0+ksHZw0YiniKbZ7uRtY8v/4G+Ee9vlmorUm80VLKEXlCUuxLKIR
132KVk51fCeWUohubSaE6NyG4ozq/IZ/OEd4hvlPrS4TbjuqT5m330QDG/pFZHuV
r3eLnQVKoDlih97I4yPv3UEPyaafbruUCWtSLs3snKaxEKj8yp8kDu0BwH2VfjW0
f/y/sCGe+U2p8U6jgWBozBkXgrhpr1sQdKrsZkuGl+wIPRVdG/A6kBMSt0xOccgq
DQ6pilaRG71fRd26/BEyZG04dA6swnc/oW7iX/lXeApntmiH1LC6KqLQEVXn2jb3
0m4nGErL16eihTMXOg0IvqSooBQZyHaahCRIbCqdk5Of+kAK3zdP9l89dWQmgfY/
o5icNqwlcycehroHB0IoNl3n2nwDulLwhoCfzvAbmJiO3pILGhIW8L+E+sIuk0+D
/MHNndyq5r/WgLNXkbbicZ6MWcEC7fPe5rxHK6NWMaO+hg1sSJ4=
=KiMf
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--

