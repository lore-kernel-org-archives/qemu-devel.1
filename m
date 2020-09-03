Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7924C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DDB2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B1V+GO6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DDB2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDyj9-0001wG-Ll
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhx-0007zy-MN; Thu, 03 Sep 2020 19:31:57 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36213 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDyhs-0000hA-L6; Thu, 03 Sep 2020 19:31:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjHBr2wksz9sVM; Fri,  4 Sep 2020 09:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599175908;
 bh=dkdZqc/w85TOIe7UH4zy9N2KmymUa8F82ZipdqMDZHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1V+GO6AQaoRNa0PqEVJdgTORw+iwkjKizA9ftwpLjI5qgv9gfV7ayeY3qJAutUUt
 RZbsyAiS3/rs8ZazFgfi3oq/VvrKJHIPdQU/KzKgMiXRSVyfZstznOrH8GTPFncHKm
 UalYu/V21I5lfTkfFDw2KhEycbUMosaAoqY5d2Ho=
Date: Fri, 4 Sep 2020 09:31:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 7/7] spapr_numa: use spapr_numa_get_vcpu_assoc() in
 home_node hcall
Message-ID: <20200903233133.GE341806@yekko.fritz.box>
References: <20200903220639.563090-1-danielhb413@gmail.com>
 <20200903220639.563090-8-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20200903220639.563090-8-danielhb413@gmail.com>
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


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2020 at 07:06:39PM -0300, Daniel Henrique Barboza wrote:
> The current implementation of h_home_node_associativity hard codes
> the values of associativity domains of the vcpus. Let's make
> it consider the values already initialized in spapr->numa_assoc_array,
> via the spapr_numa_get_vcpu_assoc() helper.
>=20
> We want to set it and forget it, and for that we also need to
> assert that we don't overflow the registers of the hypercall.
> >From R4 to R9 we can squeeze in 12 associativity domains, so
> let's assert that MAX_DISTANCE_REF_POINTS isn't greater
> than that.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index abc7361921..850e61bf98 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -185,10 +185,12 @@ target_ulong h_home_node_associativity(PowerPCCPU *=
cpu,
>                                         target_ulong opcode,
>                                         target_ulong *args)
>  {
> +    g_autofree uint32_t *vcpu_assoc =3D NULL;
>      target_ulong flags =3D args[0];
>      target_ulong procno =3D args[1];
>      PowerPCCPU *tcpu;
> -    int idx;
> +    uint vcpu_assoc_size;
> +    int idx, assoc_idx;
> =20
>      /* only support procno from H_REGISTER_VPA */
>      if (flags !=3D 0x1) {
> @@ -200,16 +202,31 @@ target_ulong h_home_node_associativity(PowerPCCPU *=
cpu,
>          return H_P2;
>      }
> =20
> -    /* sequence is the same as in the "ibm,associativity" property */
> +    /*
> +     * Given that we want to be flexible with the sizes and indexes,
> +     * we must consider that there is a hard limit of how many
> +     * associativities domain we can fit in R4 up to o R9, which
typo  ...............................................   ^

> +     * would be 12. Assert and bail if that's not the case.
> +     */
> +    g_assert(MAX_DISTANCE_REF_POINTS <=3D 12);

Since MAX_DISTANCE_REF_POINTS is a compile time constant, you could
use G_STATIC_ASSERT() to make this a compile rather than runtime
error.

> +
> +    vcpu_assoc =3D spapr_numa_get_vcpu_assoc(spapr, tcpu, &vcpu_assoc_si=
ze);
> +    vcpu_assoc_size /=3D sizeof(uint32_t);
> +    /* assoc_idx starts at 1 to skip associativity size */
> +    assoc_idx =3D 1;
> =20
> -    idx =3D 0;
>  #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
>                               ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] =3D ASSOCIATIVITY(0, 0);
> -    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> -    args[idx++] =3D ASSOCIATIVITY(procno, -1);
> -    for ( ; idx < 6; idx++) {
> -        args[idx] =3D -1;
> +
> +    for (idx =3D 0; idx < 6; idx++) {
> +        int8_t a, b;

Do you really want int8_t, rather than say int32_t?

> +
> +        a =3D assoc_idx < vcpu_assoc_size ?
> +            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
> +        b =3D assoc_idx < vcpu_assoc_size ?
> +            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
> +
> +        args[idx] =3D ASSOCIATIVITY(a, b);
>      }
>  #undef ASSOCIATIVITY
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9RfNUACgkQbDjKyiDZ
s5IOaRAAt3G1u9Nc9TMVzm4twhxNixwhXPEQrjBsSVQDGRkIoI5AGQpntlmgOYlm
e8v88BNkrsR95Rm5fNeQdetl5JE/ZfXzy50k3Im6MOsYLIBbDBsNPzjaF1EO9JkI
taCzCHyCRFWqNEbwfcu/MxibPeJtHmJqzQbx64RPEF2Nae6ks75rROWIFIs92PJv
7L31PBt0UyRefGBbhh9VEjZhSIVEzu9cYpfou9cXZqwqoDsemYGIEY2OObZJqnkU
y84GM+b91ILntb/lNtK2MVuVmiwQ2bEG1us6JDT4TsFNsDyvMOrIU0pwLGDlX3Rw
VDEziwYlldKMi2N3fBkVto7sqm8UfTk1+xAd6k+YAuTljyy5cLeIHuYFr0zLIATI
jmrJdRY7wt/lttf8GplVA+hN8xpn6GsxpKLAEVr/0ep0kEL+WO4ryEZeGuxgXbzW
5ymoTO0WHrSrrmpbelh1cd5JoChG71cb1ENwA4jhokV9iOUz7z7YMl0awKmZNnC1
oVtpmYAhr99NudyurRVxT2btWGZHVxJZbTOltZ3ePkV1c7rMpReSIEJZAg53hFoX
THShz+ORWlopqRcaEjm1SzTWm8wofCJC/LkvvE866npor80IjhaIEmHPLbJewecZ
Vm/5xhzqIvop3wARH6FjOFmqlX4dHbxck+l4LIXLQLRi+XaDzOw=
=FVSi
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--

