Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D30C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3D2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="etNR8KVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3D2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bj2-0005TN-7d
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biI-00040N-V1; Wed, 19 Aug 2020 23:58:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48125 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biF-0007LD-R4; Wed, 19 Aug 2020 23:58:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX9pt1H0vz9sTR; Thu, 20 Aug 2020 13:57:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597895878;
 bh=DF3d2YDoPsVqfXZpQZXmBNWWjAjfZFhLXMKm+dPHGJE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=etNR8KVp4VoN5QRaZTlw+4Yvd6q8gf5JKY67I7opD0tL+vfrUMawAe7DCtavp7TGW
 jNOuP8d7/G4Z/J15CHwEBldLHOZp/l5xJDynmvsk40IG47ACi9hI+q7JxHOmm1gI9I
 U6rPYsmkJF6m6V+iK2G3vM+yqDctO1I98j0wisrw=
Date: Thu, 20 Aug 2020 12:55:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 05/10] spapr: make ibm,max-associativity-domains scale
 with user input
Message-ID: <20200820025543.GL271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-6-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <20200814205424.543857-6-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:54:19PM -0300, Daniel Henrique Barboza wrote:
> The ibm,max-associativity-domains is considering that only a single
> associativity domain can exist in the same NUMA level. This is true
> today because we do not support any type of NUMA distance user
> customization, and all nodes are in the same distance to each other.
>=20
> To enhance NUMA distance support in the pSeries machine we need to
> make this limit flexible. This patch rewrites the max-associativity
> logic to consider that multiple associativity domains can co-exist
> in the same NUMA level. We're using the legacy_numa() helper to
> avoid leaking unneeded guest changes.


Hrm.  I find the above a bit hard to understand.  Having the limit be
one less than the number of nodes at every level except the last seems
kind of odd to me.

> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 073a59c47d..b0c4b80a23 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -919,13 +919,20 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
>          cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
>          cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
>      };
> -    uint32_t maxdomain =3D cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 :=
 0);
> +
> +    /* The maximum domains for a given NUMA level, supposing that every
> +     * additional NUMA node belongs to the same domain (aside from the
> +     * 4th level, where we must support all available NUMA domains), is
> +     * total number of domains - 1. */
> +    uint32_t total_nodes_number =3D ms->numa_state->num_nodes +
> +                                  spapr->extra_numa_nodes;
> +    uint32_t maxdomain =3D cpu_to_be32(total_nodes_number - 1);
>      uint32_t maxdomains[] =3D {
>          cpu_to_be32(4),
>          maxdomain,
>          maxdomain,
>          maxdomain,
> -        cpu_to_be32(ms->numa_state->num_nodes + spapr->extra_numa_nodes),
> +        cpu_to_be32(total_nodes_number),
>      };
> =20
>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
> @@ -962,6 +969,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, =
void *fdt)
>                       qemu_hypertas->str, qemu_hypertas->len));
>      g_string_free(qemu_hypertas, TRUE);
> =20
> +    if (spapr_machine_using_legacy_numa(spapr)) {
> +        maxdomain =3D cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
> +        maxdomains[1] =3D maxdomain;
> +        maxdomains[2] =3D maxdomain;
> +        maxdomains[3] =3D maxdomain;
> +    }
> +
>      if (smc->pre_5_1_assoc_refpoints) {
>          nr_refpoints =3D 2;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl895i0ACgkQbDjKyiDZ
s5LNlA/5AUpZ4waZqPwhIrda24H8tuhIUAM1eLZkJwgY7/NnQ4B51RJni/1xeW5M
OWKMps/+NaPAyEkZjtJwI1Wxy/FSkBI7lqujn8QqDvAllfrN4vuLF1xeR/+lpj9o
1IxWnQ2Qnihs2cJkIFY6X6vmk7+f84nBK+xYMUatjWEaU4a4p7+45nn92eH18Nll
BarGUWbnTKp630JXndFrJMn5CSb7TE8syeuNgQLbQqNvdS0PAf+4tnlyjBeCgSOh
LVIyBfjLecy3eYdnnuUtZiB3H/tN8pAZ+U7Z3S9/ZtwGMD+SKYNBdhy/qy9K+ffO
iBlqdFJ+0PHSOJG84Iy5aTUTI7F1E1zOVbLLJPkDaxZM7G6hz29axjwc62z6ezNr
2J4aGE0ZLPLtDy4dGEpSnYIXHaKIxpvvd8TOWlmTE+DFl1FLUoJzhLIKNe83U6dz
VL3Z32qh11Us4/ucr5ftN6LrQdQRsY4h24+dUc/993vzbb/WvIHTBLQ/A4tpzuAD
XfCz+m0Fk6aAASkkOpGQnIzslg1fZoIOWhL2adCvgmUPPQadj/fXl2nscSb3hyZ9
OgS2X9nvynnC6bCQiErm24F2ZSqEUzOoyHb6BBdv6RIj+eKNY5qB0Z1KMHJ69y2X
hnYVVLGZKIf+KDHyrX9kDqOe49se2VcsK1wGrTgKit/M90GB2So=
=OnCx
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--

