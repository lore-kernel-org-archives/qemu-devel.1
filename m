Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9D0C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F50F206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="E94OS26X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F50F206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLekL-0006ah-AZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 23:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejF-0004yo-BL; Thu, 24 Sep 2020 23:49:01 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57799 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejB-0004Na-UY; Thu, 24 Sep 2020 23:49:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4ByHvf3lwSz9sSJ; Fri, 25 Sep 2020 13:48:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601005726;
 bh=MdW6sXukn7vg5MJvG2HlZEd0/aOSKSG9CbfcB31TQd0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E94OS26XB7wsufEqZTbbX1Sjo4uaWAEnx0D6QRy4HE45jvWr4tlOkWn1l723Z+Rqn
 7IS46gntmgvxeE4YtPDTNixP5fnpWMCfMxu7bzvXyN/x3Vc3nlKIvStqcNu/oC/8x6
 55WwsmOpsOoaBCqO0toYyTqCG/2HNQxb8Iwqqsq8=
Date: Fri, 25 Sep 2020 12:35:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 3/6] spapr_numa: translate regular NUMA distance to
 PAPR distance
Message-ID: <20200925023524.GQ2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-4-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Content-Disposition: inline
In-Reply-To: <20200924195058.362984-4-danielhb413@gmail.com>
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


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:50:55PM -0300, Daniel Henrique Barboza wrote:
> QEMU allows the user to set NUMA distances in the command line.
> For ACPI architectures like x86, this means that user input is
> used to populate the SLIT table, and the guest perceives the
> distances as the user chooses to.
>=20
> PPC64 does not work that way. In the PAPR concept of NUMA,
> associativity relations between the NUMA nodes are provided by
> the device tree, and the guest kernel is free to calculate the
> distances as it sees fit. Given how ACPI architectures works,
> this puts the pSeries machine in a strange spot - users expect
> to define NUMA distances like in the ACPI case, but QEMU does
> not have control over it. To give pSeries users a similar
> experience, we'll need to bring kernel specifics to QEMU
> to approximate the NUMA distances.
>=20
> The pSeries kernel works with the NUMA distance range 10,
> 20, 40, 80 and 160. The code starts at 10 (local distance) and
> searches for a match in the first NUMA level between the
> resources. If there is no match, the distance is doubled and
> then it proceeds to try to match in the next NUMA level. Rinse
> and repeat for MAX_DISTANCE_REF_POINTS levels.
>=20
> This patch introduces a spapr_numa_PAPRify_distances() helper
> that translates the user distances to kernel distance, which
> we're going to use to determine the associativity domains for
> the NUMA nodes.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

The idea of rounding the distances like this seems pretty good to me.
Since each level is a multiple of a distance from the preivous one it
might be more theoretically correct to place the thresholds at the
geometric mean between each level, rather than the arithmetic mean.  I
very much doubt it makes much different in practice though, and this
is simpler.

There is one nit, I'm less happy with though..

> ---
>  hw/ppc/spapr_numa.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index fe395e80a3..990a5fce08 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -37,6 +37,49 @@ static bool spapr_numa_is_symmetrical(MachineState *ms)
>      return true;
>  }
> =20
> +/*
> + * This function will translate the user distances into
> + * what the kernel understand as possible values: 10
> + * (local distance), 20, 40, 80 and 160. Current heuristic
> + * is:
> + *
> + *  - distances between 11 and 30 inclusive -> rounded to 20
> + *  - distances between 31 and 60 inclusive -> rounded to 40
> + *  - distances between 61 and 120 inclusive -> rounded to 80
> + *  - everything above 120 -> 160
> + *
> + * This step can also be done in the same time as the NUMA
> + * associativity domains calculation, at the cost of extra
> + * complexity. We chose to keep it simpler.
> + *
> + * Note: this will overwrite the distance values in
> + * ms->numa_state->nodes.
> + */
> +static void spapr_numa_PAPRify_distances(MachineState *ms)
> +{
> +    int src, dst;
> +    int nb_numa_nodes =3D ms->numa_state->num_nodes;
> +    NodeInfo *numa_info =3D ms->numa_state->nodes;
> +
> +    for (src =3D 0; src < nb_numa_nodes; src++) {
> +        for (dst =3D src; dst < nb_numa_nodes; dst++) {
> +            uint8_t distance =3D numa_info[src].distance[dst];
> +            uint8_t rounded_distance =3D 160;
> +
> +            if (distance > 11 && distance <=3D 30) {
> +                rounded_distance =3D 20;
> +            } else if (distance > 31 && distance <=3D 60) {
> +                rounded_distance =3D 40;
> +            } else if (distance > 61 && distance <=3D 120) {
> +                rounded_distance =3D 80;
> +            }
> +
> +            numa_info[src].distance[dst] =3D rounded_distance;
> +            numa_info[dst].distance[src] =3D rounded_distance;

=2E.I don't love the fact that we alter the distance table in place.
Even though it was never exposed to the guest, I'd prefer not to
destroy the information the user passed in.  It could lead to
surprising results with QMP introspection, and it may make future
extensions more difficult.

So I'd prefer to either (a) just leave the table as is and round
on-demand with a paprify_distance(NN) -> {20,40,80,..} type function,
or (b) create a parallel, spapr local, table with the rounded
distances

> +        }
> +    }
> +}
> +
>  void spapr_numa_associativity_init(SpaprMachineState *spapr,
>                                     MachineState *machine)
>  {
> @@ -95,6 +138,7 @@ void spapr_numa_associativity_init(SpaprMachineState *=
spapr,
>          exit(EXIT_FAILURE);
>      }
> =20
> +    spapr_numa_PAPRify_distances(machine);
>  }
> =20
>  void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *f=
dt,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9tV2oACgkQbDjKyiDZ
s5L1SBAAr5rajD4yKA4Isc/oeVGgQq1HCtHaHQC6qyBcaekV3DivDmbUbQRjSrRN
HiiLMC4/6Q5qhPmaOGIiRNaQegv0ZccucT34z9k7MoiUeDdOYp56rVHXS4NS8xhN
iAn7s8Llk88q2at1nO8Wkl8uEj7X0Poa1NfsOc2Yb9ETdWE3eDoObvEPfT8elt1C
dDE8TF07a2QU0PF0wtcNEMQa5zvo6Bz6NkbyJrhi/lJbZD4iUuEBh+4ZLRnNGq6p
soaTYg5+pk2SXz42ljVoMJsfZxCeoUsbN3+TA8/NX9MUWVVzIENpbb2c3mAgWS8n
o9fxE32/uywrcpwz0L41Aq35JxdUwzDUGlAenerI5+UYNBYK7MDF+aMCn/pQxVj4
a4icenwM9xoNFOlDIUViYbcNABOmOpL+Xe+SVSdKBQUoe25XVUQ0oXxFZNWDghYF
E7TX2J6KVvZ+iJl7hfB5sR9MLxR3cvGIwtNfSDmAQ4KT+/vwCQE0LYSr730D3gvh
jT+7MI5h2pyIx/FlNcIQ0USz3x/fQgSTCRCLud7VHB0a1pmkQON+4+ZcHBxs6+rW
HS7RGcFGUrkccRIv563bdgKYRc7IQAuhx/oj2WOjouCAaZ/qawIfvMyJ7SnRRmCf
NSB7rtFr8TGaAOngPJ+UVn+o7g8oS3p5gfy3I8NHKQHO6Y8CEmA=
=pOAB
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--

