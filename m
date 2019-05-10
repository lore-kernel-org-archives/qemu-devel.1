Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53ACC04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F6A217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hvv6/z6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F6A217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzBE-0008Eo-LB
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:38:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOz7p-0005AV-6v
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOz7n-0004uM-Ch
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:35:21 -0400
Received: from ozlabs.org ([203.11.71.1]:46463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOz7m-0004oQ-Pf; Fri, 10 May 2019 02:35:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450gSD2XcHz9sBr; Fri, 10 May 2019 16:35:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557470108;
	bh=6Op+JlPdjESusEIExY2bcebxvAnvD8/N8whtz/p/sZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hvv6/z6iY0PiAR1r0+MpSfKdtoDcCxqP5kIWjagY7J8VnCXS5AC8+NW225wg8BBdV
	XRJ+t1uPX2l4iE1Xs8mGRExu1/4TOML7GzZvY2Vjab7UBnzNbClbX+yxCKHgTRyEzC
	WdAfzG3UsGA6XKpiwLVJFG+YIVtWz767ikeGLFM4=
Date: Fri, 10 May 2019 16:32:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510063209.GG20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-12-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-12-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 11/13] target/ppc: Implement
 hcall H_COPY_TOFROM_GUEST
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


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:14PM +1000, Suraj Jitindar Singh wrote:
> The hcall H_COPY_TOFROM_GUEST of used by a guest acting as a nested
> hypervisor to access quadrants since quadrant access is hypervisor
> privileged.
>=20
> Translate the guest address to be accessed, map the memory and perform
> the access on behalf of the guest. If the parameters are invalid, the
> address can't be translated or the memory cannot be mapped then fail
> the access.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c     | 74 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h   |  3 +-
>  target/ppc/mmu-radix64.c |  7 ++---
>  target/ppc/mmu-radix64.h |  4 +++
>  4 files changed, 83 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index a84d5e2163..a370d70500 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -17,6 +17,7 @@
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/ppc.h"
> +#include "mmu-radix64.h"
> =20
>  static bool has_spr(PowerPCCPU *cpu, int spr)
>  {
> @@ -2158,6 +2159,78 @@ static target_ulong h_nested_tlb_invalidate(PowerP=
CCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
> +                                        SpaprMachineState *spapr,
> +                                        target_ulong opcode, target_ulon=
g *args)
> +{
> +    target_ulong lpid =3D args[0];
> +    target_ulong pid =3D args[1];
> +    vaddr eaddr =3D args[2];
> +    target_ulong gp_to =3D args[3];
> +    target_ulong gp_from =3D args[4];
> +    target_ulong n =3D args[5];
> +    int is_load =3D !!gp_to;

Looks like this should be a bool.

> +    void *from, *to;
> +    int prot, psize;
> +    hwaddr raddr, to_len, from_len;
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) =3D=3D 0) {
> +        return H_FUNCTION;
> +    }
> +
> +    if ((gp_to && gp_from) || (!gp_to && !gp_from)) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (eaddr & (0xFFFUL << 52)) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (!lpid) {
> +        return H_PARAMETER;
> +    }
> +
> +    /* Translate eaddr to raddr */
> +    if (ppc_radix64_xlate(cpu, eaddr, is_load, lpid, pid, 1, &raddr, &ps=
ize,

Don't we need some validation that the guest is in radix mode?

> +                          &prot, 0)) {
> +        return H_NOT_FOUND;
> +    }
> +    if (((raddr & ((1UL << psize) - 1)) + n) >=3D (1UL << psize)) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (is_load) {
> +        gp_from =3D raddr;
> +    } else {
> +        gp_to =3D raddr;
> +    }
> +
> +    /* Map the memory regions and perform a memory copy */
> +    from =3D cpu_physical_memory_map(gp_from, &from_len, 0);
> +    if (!from) {
> +        return H_NOT_FOUND;
> +    }
> +    if (from_len < n) {
> +        cpu_physical_memory_unmap(from, from_len, 0, 0);
> +        return H_PARAMETER;
> +    }
> +    to =3D cpu_physical_memory_map(gp_to, &to_len, 1);
> +    if (!to) {
> +        cpu_physical_memory_unmap(from, from_len, 0, 0);
> +        return H_PARAMETER;
> +    }
> +    if (to_len < n) {
> +        cpu_physical_memory_unmap(from, from_len, 0, 0);
> +        cpu_physical_memory_unmap(to, to_len, 1, 0);
> +        return H_PARAMETER;
> +    }
> +    memcpy(to, from, n);
> +    cpu_physical_memory_unmap(from, from_len, 0, n);
> +    cpu_physical_memory_unmap(to, to_len, 1, n);
> +
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -2268,6 +2341,7 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_tabl=
e);
>      spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
>      spapr_register_hypercall(H_TLB_INVALIDATE, h_nested_tlb_invalidate);
> +    spapr_register_hypercall(H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
> =20
>      /* Virtual Processor Home Node */
>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6a614c445f..d62f4108d4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -505,7 +505,8 @@ struct SpaprMachineState {
>  #define H_SET_PARTITION_TABLE   0xF800
>  #define H_ENTER_NESTED          0xF804
>  #define H_TLB_INVALIDATE        0xF808
> -#define KVMPPC_HCALL_MAX        H_TLB_INVALIDATE
> +#define H_COPY_TOFROM_GUEST     0xF80C
> +#define KVMPPC_HCALL_MAX        H_COPY_TOFROM_GUEST
> =20
>  typedef struct SpaprDeviceTreeUpdateHeader {
>      uint32_t version_id;
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 6118ad1b00..2a8147fc38 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -429,10 +429,9 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t =
lpid, ppc_v3_pate_t *pate)
>      return true;
>  }
> =20
> -static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> -                             uint64_t lpid, uint64_t pid, bool relocatio=
n,
> -                             hwaddr *raddr, int *psizep, int *protp,
> -                             bool cause_excp)
> +int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx, uint64_t lp=
id,
> +                      uint64_t pid, bool relocation, hwaddr *raddr, int =
*psizep,
> +                      int *protp, bool cause_excp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      ppc_v3_pate_t pate;
> diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
> index 96228546aa..c0bbd5c332 100644
> --- a/target/ppc/mmu-radix64.h
> +++ b/target/ppc/mmu-radix64.h
> @@ -66,6 +66,10 @@ static inline int ppc_radix64_get_prot_amr(PowerPCCPU =
*cpu)
>             (iamr & 0x1 ? 0 : PAGE_EXEC);
>  }
> =20
> +int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx, uint64_t lp=
id,
> +                      uint64_t pid, bool relocation, hwaddr *raddr, int =
*psizep,
> +                      int *protp, bool cause_excp);
> +
>  #endif /* TARGET_PPC64 */
> =20
>  #endif /* CONFIG_USER_ONLY */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVGukACgkQbDjKyiDZ
s5JjARAA2gb9Q3x6ykeihSyJUR7bKQlrorDaMkyYVxaKwvbhJJB20aoliiAXxjSm
PgE24rxzz+g2oTHdlMZ/u589XvGaiK2X8lUkJewqcTlzuqCKGVFfpAlgbHBWqH6L
rTeTWMqarpXI+Kq6SthOXkN4A+mtS9CrRh6loosWxWxP3U7Vv89QArIhVNr5VntF
If0nMnSn/AvnzzGX9WXiWAF4vkphRxhi7DxoJAUCGVmR0yvIPUG9Ufh1E2j5/Lm2
wLMZ6KUhTBmLmbOERu/eXr/ixMLN13eqAaFROGA/rPlVGDrtwVYQMjH/4+o63hyW
5SZzsPAcloVVmD4fhb0d2e88jjREKpFg4QiUoeIk41yrlXWqUi97N+lDsF8cNYB6
SHGz1ylemjRuN0xZQvrDJAaucF0rpkNE8awcbWQO8MYJ8luEzv6yd3c05YsKGk5V
bMUo1JbjGFShXLBTYOMFX//iSYQsO1FVJ4+Yfi9gzUbTpMe+x4DfMzXmJS5xU/7n
dJVeKYpnoMn6eBS2hC+DghLfBdqAZynwGmXAnfET+LZh0jYmP7uTvE/fhw6vi2v+
0IMmR+3NZmv7fiRr24n02fA1NIfYdImzgSzl3B5avkatm3uq63SmZMG5zeB/uz40
mKOx+ggnfXIDSAaEEwwwmOlw4KajkruQO0l4NXNR9LZtyXkj/Rg=
=hQUa
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--

