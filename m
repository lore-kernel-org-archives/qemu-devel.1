Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E550C4727E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 03:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57BF206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 03:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SADVBLKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57BF206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOBLV-0005VF-Dg
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 23:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kOBIb-0004MQ-Sr; Thu, 01 Oct 2020 22:59:57 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56175 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kOBIX-0008Kh-Uh; Thu, 01 Oct 2020 22:59:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C2ZTg6MJNz9sSG; Fri,  2 Oct 2020 12:59:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601607575;
 bh=pj9eOeEcbsjQbuwUOWtVtRlkJrtpakrrfMpAKuFv1xI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SADVBLKUuA1S+HsfzTi6d5VxafPuAULF1iEl/T2Wb2E3i/UC50GH6HausnadEVJgi
 aIbLuf7KnSS14BXa7rUbQblo37mDts73on71n8vYP+OR9lmOy67zGI/dvD1GkUK8nm
 6MZaPCnFFX51u2hIe+VovoQgg5i05Lh8vIrCfnJ8=
Date: Fri, 2 Oct 2020 12:24:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 4/5] spapr_numa: consider user input when defining
 associativity
Message-ID: <20201002022456.GI1844@yekko.fritz.box>
References: <20200929133817.560278-1-danielhb413@gmail.com>
 <20200929133817.560278-5-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline
In-Reply-To: <20200929133817.560278-5-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 10:38:16AM -0300, Daniel Henrique Barboza wrote:
> This patch puts all the pieces together to finally allow user
> input when defining the NUMA topology of the spapr guest.
>=20
> For each NUMA node A, starting at node id 0, the new
> spapr_numa_define_associativity_domains() will:
>=20
> - get the distance between node A and B =3D A + 1
> - get the correspondent NUMA level for this distance
> - assign the associativity domain for A and B for the given
> NUMA level, using the lowest associativity domain value between
> them
> - if there is more NUMA nodes, increment B and repeat

I still find this description very confusing.  The one in the comment
is better, I think, can you maybe copy that one here.

> Since we always start at the first node (id =3D 0) and go in
> ascending order, we are prioritizing any previous associativity
> already calculated. This is necessary because neither QEMU, nor
> the pSeries kernel, supports multiple associativity domains for
> each resource, meaning that we have to decide which associativity
> relation is relevant. Another side effect is that the first
> NUMA node, node 0, will always have an associativity array
> full of zeroes. This is intended - in fact, the Linux kernel
> expects it (see [1] for more info).
>=20
> Ultimately, all of this results in a best effort approximation for
> the actual NUMA distances the user input in the command line. Given
> the nature of how PAPR itself interprets NUMA distances versus the
> expectations risen by how ACPI SLIT works, there might be better
> algorithms but, in the end, it'll also result in another way to
> approximate what the user really wanted.
>=20
> To keep this commit message no longer than it already is, the next
> patch will update the existing documentation in ppc-spapr-numa.rst
> with more in depth details and design considerations/drawbacks.
>=20
> [1] https://lore.kernel.org/linuxppc-dev/5e8fbea3-8faf-0951-172a-b41a2138=
fbcf@gmail.com/
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 120 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 16badb1f4b..f3d43ceb1e 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -37,12 +37,118 @@ static bool spapr_numa_is_symmetrical(MachineState *=
ms)
>      return true;
>  }
> =20
> +/*
> + * This function will translate the user distances into
> + * what the kernel understand as possible values: 10
> + * (local distance), 20, 40, 80 and 160, and return the equivalent
> + * NUMA level for each. Current heuristic is:
> + *  - local distance (10) returns numa_level =3D 0x4
> + *  - distances between 11 and 30 inclusive -> rounded to 20,
> + *    numa_level =3D 0x3
> + *  - distances between 31 and 60 inclusive -> rounded to 40,
> + *    numa_level =3D 0x2
> + *  - distances between 61 and 120 inclusive -> rounded to 80,
> + *    numa_level =3D 0x1
> + *  - everything above 120 returns numa_level =3D 0 to indicate that
> + *    there is no match. This will be calculated as disntace =3D 160
> + *    by the kernel (as of v5.9)
> + */
> +static uint8_t spapr_numa_get_numa_level(uint8_t distance)
> +{
> +    uint8_t rounded_distance =3D 160;
> +    uint8_t numa_level;
> +
> +    if (distance > 11 && distance <=3D 30) {
> +        rounded_distance =3D 20;
> +    } else if (distance > 31 && distance <=3D 60) {
> +        rounded_distance =3D 40;
> +    } else if (distance > 61 && distance <=3D 120) {
> +        rounded_distance =3D 80;
> +    }
> +
> +    switch (rounded_distance) {
> +    case 10:
> +        numa_level =3D 0x4;
> +        break;

Uh.. you could just return the numa_level from the if-else chain
without going via rounded_distance.  (You could put the rounded
distances in comments on each if clause, if you like).

> +    case 20:
> +        numa_level =3D 0x3;
> +        break;
> +    case 40:
> +        numa_level =3D 0x2;
> +        break;
> +    case 80:
> +        numa_level =3D 0x1;
> +        break;
> +    default:
> +        numa_level =3D 0;
> +    }
> +
> +    return numa_level;
> +}
> +
> +static void spapr_numa_define_associativity_domains(SpaprMachineState *s=
papr)
> +{
> +    MachineState *ms =3D MACHINE(spapr);
> +    NodeInfo *numa_info =3D ms->numa_state->nodes;
> +    int nb_numa_nodes =3D ms->numa_state->num_nodes;
> +    int src, dst;
> +
> +    for (src =3D 0; src < nb_numa_nodes; src++) {
> +        for (dst =3D src; dst < nb_numa_nodes; dst++) {
> +            /*
> +             * This is how the associativity domain between A and B
> +             * is calculated:
> +             *
> +             * - get the distance between them
> +             * - get the correspondent NUMA level for this distance
> +             * - the arrays were initialized with their own numa_ids,
> +             * and we're calculating the distance in node_id ascending o=
rder,
> +             * starting from node 0. This will have a cascade effect in =
the
> +             * algorithm because the associativity domains that node 0 d=
efines
> +             * will be carried over to the other nodes, and node 1
> +             * associativities will be carried over unless there's alrea=
dy a
> +             * node 0 associativity assigned, and so on. This happens be=
cause
> +             * we'll assign assoc_src as the associativity domain of dst
> +             * as well, for the given NUMA level.
> +             *
> +             * The PPC kernel expects the associativity domains of node =
0 to
> +             * be always 0, and this algorithm will grant that by defaul=
t.
> +             */
> +            uint8_t distance =3D numa_info[src].distance[dst];
> +            uint8_t n_level =3D spapr_numa_get_numa_level(distance);
> +            uint32_t assoc_src;
> +
> +            /*
> +             * n_level =3D 0 means that the distance is greater than our=
 last
> +             * rounded value (120). In this case there is no NUMA level =
match
> +             * between src and dst and we can skip the remaining of the =
loop.
> +             *
> +             * The Linux kernel will assume that the distance between sr=
c and
> +             * dst, in this case of no match, is 10 (local distance) dou=
bled
> +             * for each NUMA it didn't match. We have MAX_DISTANCE_REF_P=
OINTS
> +             * levels (4), so this gives us 10*2*2*2*2 =3D 160.
> +             *
> +             * This logic can be seen in the Linux kernel source code, a=
s of
> +             * v5.9, in arch/powerpc/mm/numa.c, function __node_distance=
().
> +             */
> +            if (n_level =3D=3D 0) {
> +                continue;
> +            }
> +
> +            assoc_src =3D spapr->numa_assoc_array[src][n_level];
> +            spapr->numa_assoc_array[dst][n_level] =3D assoc_src;

I'm still not convinced that having the entry at n_level match, but
not those at "coarser"/"more distant" levels be different makes sense.

> +        }
> +    }
> +
> +}
> +
>  void spapr_numa_associativity_init(SpaprMachineState *spapr,
>                                     MachineState *machine)
>  {
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      int nb_numa_nodes =3D machine->numa_state->num_nodes;
>      int i, j, max_nodes_with_gpus;
> +    bool using_legacy_numa =3D spapr_machine_using_legacy_numa(spapr);
> =20
>      /*
>       * For all associativity arrays: first position is the size,
> @@ -56,6 +162,17 @@ void spapr_numa_associativity_init(SpaprMachineState =
*spapr,
>      for (i =3D 0; i < nb_numa_nodes; i++) {
>          spapr->numa_assoc_array[i][0] =3D cpu_to_be32(MAX_DISTANCE_REF_P=
OINTS);
>          spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] =3D cpu_to_b=
e32(i);
> +
> +        /*
> +         * Fill all associativity domains of non-zero NUMA nodes with
> +         * node_id. This is required because the default value (0) is
> +         * considered a match with associativity domains of node 0.
> +         */
> +        if (!using_legacy_numa && i !=3D 0) {
> +            for (j =3D 1; j < MAX_DISTANCE_REF_POINTS; j++) {
> +                spapr->numa_assoc_array[i][j] =3D cpu_to_be32(i);
> +            }
> +        }
>      }
> =20
>      /*
> @@ -85,7 +202,7 @@ void spapr_numa_associativity_init(SpaprMachineState *=
spapr,
>       * 1 NUMA node) will not benefit from anything we're going to do
>       * after this point.
>       */
> -    if (spapr_machine_using_legacy_numa(spapr)) {
> +    if (using_legacy_numa) {
>          return;
>      }
> =20
> @@ -95,6 +212,7 @@ void spapr_numa_associativity_init(SpaprMachineState *=
spapr,
>          exit(EXIT_FAILURE);
>      }
> =20
> +    spapr_numa_define_associativity_domains(spapr);
>  }
> =20
>  void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *f=
dt,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl92j3UACgkQbDjKyiDZ
s5IJ5A//RAisNOwiRgBqVhAAHUndC0rabr4XfwDgdwAs7Xhu2Scq0osKWvn1cTTx
3UcFwjryo2o/1QsLbvRuGc2NEcbWG7JT6svNE2DLn3v0q4rZfZEBZeIPl6BR1phr
myzosKQmsJnn6bvHw1GDKlL37hkzCFyETiRYaPUy293KKObzvryOKzsHbKYhrrkE
m76gcbrPCA6otwAneFzbggzSSL9Hrj5QnLmABdTPmDJ0F5s6HD3VDTYynp180GGd
4ZdwZ6A+VE0EnWIKnethdOnky4XIbsLH6KM31N10qVWvl4TMm5CZpb2nBgXtFqHa
s6KQLncOQ1Yg05D6K9Vr2LdoZU7fpW4iwSOVJep1NEWcuQZ4eDJoRfeVbZfRT8ew
Oe8oWc1xShVHAgelx07prTllc+X7u/ia/HgB+2GrQSXH1J7UpfRkChwDTUuWeUjZ
PFF0sIGMveWZ/rcau75ZEoGLQ/slUqKZHZFzjnSEV7I8VEF8IcqWNL+wFHxyA5V2
S6svM/BOHe0PtCFO7jgqP8Hm2zXrhtOAKNBebrFqct/0RuPLAEoPMMjfvRScc95K
Lg9VqmtlxFzglBFGfUN8+Vf1Z+f4uu8lgj3z16+xpKgw/2GaxGJSoW1Fr7Tb632V
rwL49ND5LJhtJV3vUIDBHizR1pL3Ud3IWg1jQqvwhW6B1i8fnSc=
=gpKa
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--

