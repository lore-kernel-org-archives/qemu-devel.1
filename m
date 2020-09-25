Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E84C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2223206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SEnVw+m3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2223206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLekK-0006aM-MH
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 23:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejD-0004yW-Se; Thu, 24 Sep 2020 23:48:59 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejB-0004Ne-GU; Thu, 24 Sep 2020 23:48:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4ByHvf6sjyz9sSf; Fri, 25 Sep 2020 13:48:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601005726;
 bh=aztyh5kRnN3IjMd+gwz8A9KzQM5vU2R11UVtnsH8Mzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SEnVw+m3PR/ZsORGzgF0FSrmH2IldAr4Y/RKa8WhqKS2bMTQukE7Sezh0ftiy6Z8t
 jsMgqV0PAvwxGaE7FKa0TgjldOixZxrnRj3ZTVv9PTItmfSHceQwuyHkZRg1pYT1Uq
 eK9xJhoIq7T6ZCjTYxkuxkBXUqslj+tJcwJ6F50U=
Date: Fri, 25 Sep 2020 12:38:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 4/6] spapr_numa: change reference-points and maxdomain
 settings
Message-ID: <20200925023843.GS2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-5-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9wW3yB/H9ZmnRBtb"
Content-Disposition: inline
In-Reply-To: <20200924195058.362984-5-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9wW3yB/H9ZmnRBtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:50:56PM -0300, Daniel Henrique Barboza wrote:
> This is the first guest visible change introduced in
> spapr_numa.c. The previous settings of both reference-points
> and maxdomains were too restrictive, but enough for the
> existing associativity we're setting in the resources.
>=20
> We'll change that in the following patches, populating the
> associativity arrays based on user input. For those changes
> to be effective, reference-points and maxdomains must be
> more flexible. After this patch, we'll have 4 distinct
> levels of NUMA (0x4, 0x3, 0x2, 0x1) and maxdomains will
> allow for any type of configuration the user intends to
> do - under the scope and limitations of PAPR itself, of
> course.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Although..

> ---
>  hw/ppc/spapr_numa.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 990a5fce08..ea33439a15 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -222,24 +222,48 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachi=
neState *spapr, void *fdt,
>   */
>  void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int r=
tas)
>  {
> +    MachineState *ms =3D MACHINE(spapr);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      uint32_t refpoints[] =3D {
>          cpu_to_be32(0x4),
> -        cpu_to_be32(0x4),
> +        cpu_to_be32(0x3),
>          cpu_to_be32(0x2),
> +        cpu_to_be32(0x1),
>      };
>      uint32_t nr_refpoints =3D ARRAY_SIZE(refpoints);
> -    uint32_t maxdomain =3D cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
> +    uint32_t maxdomain =3D ms->numa_state->num_nodes + spapr->gpu_numa_i=
d;
>      uint32_t maxdomains[] =3D {
>          cpu_to_be32(4),
> -        maxdomain,
> -        maxdomain,
> -        maxdomain,
> -        cpu_to_be32(spapr->gpu_numa_id),
> +        cpu_to_be32(maxdomain),
> +        cpu_to_be32(maxdomain),
> +        cpu_to_be32(maxdomain),
> +        cpu_to_be32(maxdomain)
>      };
> =20
> -    if (smc->pre_5_1_assoc_refpoints) {
> -        nr_refpoints =3D 2;
> +    if (spapr_machine_using_legacy_numa(spapr)) {
> +        uint32_t legacy_refpoints[] =3D {
> +            cpu_to_be32(0x4),
> +            cpu_to_be32(0x4),
> +            cpu_to_be32(0x2),
> +        };
> +        uint32_t legacy_maxdomain =3D spapr->gpu_numa_id > 1 ? 1 : 0;
> +        uint32_t legacy_maxdomains[] =3D {
> +            cpu_to_be32(4),
> +            cpu_to_be32(legacy_maxdomain),
> +            cpu_to_be32(legacy_maxdomain),
> +            cpu_to_be32(legacy_maxdomain),
> +            cpu_to_be32(spapr->gpu_numa_id),
> +        };
> +
> +        nr_refpoints =3D 3;
> +
> +        memcpy(refpoints, legacy_refpoints, sizeof(legacy_refpoints));
> +        memcpy(maxdomains, legacy_maxdomains, sizeof(legacy_maxdomains));

It would be nice to have a G_STATIC_ASSERT() or QEMU_BUILD_BUG_MSG()
ro ensure that the two structures are the same size, if they became
different the memcpy is wildly unsafe.

> +        /* pseries-5.0 and older reference-points array is {0x4, 0x4} */
> +        if (smc->pre_5_1_assoc_refpoints) {
> +            nr_refpoints =3D 2;
> +        }
>      }
> =20
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9wW3yB/H9ZmnRBtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9tWDMACgkQbDjKyiDZ
s5L+GRAAr1ea5lQLFDxTfHHq4i5gNeSqara9px6eUzctxtQPQ5AN61hoe5OriYBi
rwFdNDlCNvP4Dw0XZamgfahN353rBDhMaIjPxaJ8IPDK84/H4JBIENjCW3W5CNCL
V367byA9dH/85AKHtmQoqx3kavj/TNG+7bXzv4bcZGr2xoWF3olcg3BSpdMhIfax
SO2bmK9+diE3uUxIAg9rUJe1wu7tjG9ywpTpmvmzZJUDxF2Y5iQuGIeU1bjY5FdB
Bb0nqoFEcfzMktXRRMRal42I2suYXWpzmT2OL4/YHA8aw8OW5B7DcKU5HgXksTIj
wDeT/DVghTrACQl0hv1aGc0DYaakFM/1AFu5mNZbKsjZZ8G+ratvOY9xOLGfXzSp
nZfkF+WHgJRF7OQ1+kloBBuyipO5CcQgqDBGpQcBIInJ55MsXgBNi3UOKNx2lTm2
V09xZWyhBz5HPW7DnvMVnvMMwtOIrdI+nGtLZ2U02Dfs0AdHYWhqhRZiiX0fZVAC
H0MOjmMEeblpoQQFLD835cqwSzQRKSKR7P/LlrbfYeZ+e3sdYD25SillzZXzMseQ
0KSYzZn8cMitOm44i1A0QJmYbDFUaD6if+B2bPm0BAXEcJel9+5/ciSZgXyGUi1v
6pEoXWAEiwHbwaTKx2hkGLlIYQ5UgnrW6IfDsNNctf3RRwz4LV0=
=vH/R
-----END PGP SIGNATURE-----

--9wW3yB/H9ZmnRBtb--

