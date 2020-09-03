Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486AAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0653520797
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MlCqfMpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0653520797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDykY-0003yl-8A
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhy-00082J-G4; Thu, 03 Sep 2020 19:31:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50091 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhs-0000h8-Lg; Thu, 03 Sep 2020 19:31:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjHBr1VRZz9sVK; Fri,  4 Sep 2020 09:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599175908;
 bh=DoR4GnYr7hMJuiZWMw/ftM7UBHzzwBSnSIX0FFZUz2U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MlCqfMpjhV4Oa3VBYc7U0J/+p/5dNjWRl4wg1tFXte45bt24TWmTYzVlz7+fkRG2d
 tt4FXszGc5gWkIbGyFNQWjyk5noKfezCACTqcZxNevXoaeNeWznZaPGUlxkKPVpRt7
 t6UMxeB8PIOeyN9lKkZPWDk8LXc4flkPyntu8NXE=
Date: Fri, 4 Sep 2020 09:25:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 5/7] spapr: move h_home_node_associativity to
 spapr_numa.c
Message-ID: <20200903232543.GC341806@yekko.fritz.box>
References: <20200903220639.563090-1-danielhb413@gmail.com>
 <20200903220639.563090-6-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20200903220639.563090-6-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 07:06:37PM -0300, Daniel Henrique Barboza wrote:
> The implementation of this hypercall will be modified to use
> spapr->numa_assoc_arrays input. Moving it to spapr_numa.c makes
> make more sense.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c        | 37 +------------------------------------
>  hw/ppc/spapr_numa.c         | 36 ++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_numa.h |  4 ++++
>  3 files changed, 41 insertions(+), 36 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c1d01228c6..9e9b959bbd 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -18,6 +18,7 @@
>  #include "kvm_ppc.h"
>  #include "hw/ppc/fdt.h"
>  #include "hw/ppc/spapr_ovec.h"
> +#include "hw/ppc/spapr_numa.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> =20
> @@ -1873,42 +1874,6 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return ret;
>  }
> =20
> -static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> -                                              SpaprMachineState *spapr,
> -                                              target_ulong opcode,
> -                                              target_ulong *args)
> -{
> -    target_ulong flags =3D args[0];
> -    target_ulong procno =3D args[1];
> -    PowerPCCPU *tcpu;
> -    int idx;
> -
> -    /* only support procno from H_REGISTER_VPA */
> -    if (flags !=3D 0x1) {
> -        return H_FUNCTION;
> -    }
> -
> -    tcpu =3D spapr_find_cpu(procno);
> -    if (tcpu =3D=3D NULL) {
> -        return H_P2;
> -    }
> -
> -    /* sequence is the same as in the "ibm,associativity" property */
> -
> -    idx =3D 0;
> -#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> -                             ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] =3D ASSOCIATIVITY(0, 0);
> -    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> -    args[idx++] =3D ASSOCIATIVITY(procno, -1);
> -    for ( ; idx < 6; idx++) {
> -        args[idx] =3D -1;
> -    }
> -#undef ASSOCIATIVITY
> -
> -    return H_SUCCESS;
> -}
> -
>  static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>                                                SpaprMachineState *spapr,
>                                                target_ulong opcode,
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 93a000b729..d4dca57321 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -165,3 +165,39 @@ void spapr_numa_write_rtas_dt(SpaprMachineState *spa=
pr, void *fdt, int rtas)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
>  }
> +
> +target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> +                                       SpaprMachineState *spapr,
> +                                       target_ulong opcode,
> +                                       target_ulong *args)

So, if you're moving this function to this file, you should also move
the corresponding spapr_register_hypercall() to this file.  That will
let you keep this function static.

> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong procno =3D args[1];
> +    PowerPCCPU *tcpu;
> +    int idx;
> +
> +    /* only support procno from H_REGISTER_VPA */
> +    if (flags !=3D 0x1) {
> +        return H_FUNCTION;
> +    }
> +
> +    tcpu =3D spapr_find_cpu(procno);
> +    if (tcpu =3D=3D NULL) {
> +        return H_P2;
> +    }
> +
> +    /* sequence is the same as in the "ibm,associativity" property */
> +
> +    idx =3D 0;
> +#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> +                             ((uint64_t)(b) & 0xffffffff))
> +    args[idx++] =3D ASSOCIATIVITY(0, 0);
> +    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] =3D ASSOCIATIVITY(procno, -1);
> +    for ( ; idx < 6; idx++) {
> +        args[idx] =3D -1;
> +    }
> +#undef ASSOCIATIVITY
> +
> +    return H_SUCCESS;
> +}
> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
> index b3fd950634..5b4d165c06 100644
> --- a/include/hw/ppc/spapr_numa.h
> +++ b/include/hw/ppc/spapr_numa.h
> @@ -31,5 +31,9 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, v=
oid *fdt,
>                              int offset, PowerPCCPU *cpu);
>  int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void =
*fdt,
>                                           int offset);
> +target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> +                                       SpaprMachineState *spapr,
> +                                       target_ulong opcode,
> +                                       target_ulong *args);
> =20
>  #endif /* HW_SPAPR_NUMA_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9Re3cACgkQbDjKyiDZ
s5Lz8Q//V08sKen3DVOwhbYecKeIIvmHtLZw9nuq/H2fmfdqa0nzCuploX8/T9zk
8d31+o3bsow8/wUXu64lKHynSJdKFIwm+KQ/dbKZKZ4UnoR48qAlx8lUDZ3q1jSH
rjDdatEUcxt+NBsgOQvlbn6GwDMQpYPkVSCYjNKLbylSy2VRoFeUBtV+tsHWuwlb
tNVghJ56VGbgegSRGk6wjaXITkHeStBfcBqvMdiFIGEwinvigqDO5+gLtJ4aUlAR
kSaLobXbAObJ+QK57LmMHFf8wkwsYUkjgT8gE4PhWwJJL+PUYV81xsJBxt8N9GHT
ly4/V7upS39/0WiOeo9e99M5VUWoaw/HwoL5BH3mVcPulw+0cJztl2XIgWNdDAgS
NVVrPeliGLZOql8I6a/yhM+Gei6Nir5nU4Xe7dhi2bF3qW59ghmErN6xY3wtrCE0
x4Jod88unFMf27JN7mHL1NAK9WvuyLPZKR3sIX4u8jX6pvejhMH2WOLt9TFC/dK7
SnetrbB1i7sLupzGodOZxTMpKKdA1gQA7HzPHnEymMj0OMH04IJjDivpOcz4zl2V
eMKh2+GU8l2S0jylT2zVWdND/vdBbgzhF1gwvCcCqxLpUUgtKSyY07qp7XB06xar
E/wa3lu2iqFDOAfzdmAyVRcAjPB8SpwUbAAvXqADpZ4/SQIuMuM=
=GSJp
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--

