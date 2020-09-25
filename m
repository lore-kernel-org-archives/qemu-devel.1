Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB72C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8B72086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iKCH1GfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8B72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLemI-0001BG-D6
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 23:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejF-0004yu-JZ; Thu, 24 Sep 2020 23:49:01 -0400
Received: from ozlabs.org ([203.11.71.1]:38511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejB-0004Nc-78; Thu, 24 Sep 2020 23:49:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4ByHvg1Qqjz9sSn; Fri, 25 Sep 2020 13:48:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601005727;
 bh=oEqPO8N+6pn0spgwlvqMaaV5LG58LWG4+g4PdpRWsI8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iKCH1GfGVnmGD97tinCMsNZgJ1ydVsUS3OYe0TrXady1jLD3pOtBih4ST7/adCPzg
 SBdPPoO+dvLjdq2bOOTCm0/28llqP/i9mrE5i2ep7PHSxuZ1PKBWD4vw4xHjKOS0IZ
 m2FrYmOve9IE02UD0ISBAdEtgAPRYQsU66lQU6II=
Date: Fri, 25 Sep 2020 13:39:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 5/6] spapr_numa: consider user input when defining
 associativity
Message-ID: <20200925033945.GT2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-6-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WQ40utMgiyDduspJ"
Content-Disposition: inline
In-Reply-To: <20200924195058.362984-6-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 23:48:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


--WQ40utMgiyDduspJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:50:57PM -0300, Daniel Henrique Barboza wrote:
> This patch puts all the pieces together to finally allow user
> input when defining the NUMA topology of the spapr guest.
>=20
> We have one more kernel restriction to handle in this patch:
> the associativity array of node 0 must be filled with zeroes
> [1]. The strategy below ensures that this will happen.

Can you clarify exactly what "node 0" means?  Qemu and the guest
kernel each have node numberings, which I don't think are necessarily
the same.  With PAPR's scheme, it's not totally clear what "node 0"
even means.

> spapr_numa_define_associativity_domains() will read the distance
> (already PAPRified) between the nodes from numa_state and determine
> the appropriate NUMA level. The NUMA domains, processed in ascending
> order, are going to be matched via NUMA levels, and the lowest
> associativity domain value is assigned to that specific level for
> both.
>=20
> This will create an heuristic where the associativities of the first
> nodes have higher priority and are re-used in new matches, instead of
> overwriting them with a new associativity match. This is necessary
> because neither QEMU, nor the pSeries kernel, supports multiple
> associativity domains for each resource, meaning that we have to
> decide which associativity relation is relevant.

Hmm.  I find that a bit hard to follow.  So IIUC, what's going on is
you start out by treating every node as as distant as possible from
every other: they have a unique value at every level of the
associativity array.  Then you collapse together nodes that are
supposed to be closer by making some of their associativity entries
match.  Is that right?

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
>  hw/ppc/spapr_numa.c | 101 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index ea33439a15..21cae3f799 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -80,12 +80,99 @@ static void spapr_numa_PAPRify_distances(MachineState=
 *ms)
>      }
>  }
> =20
> +static uint8_t spapr_numa_get_numa_level(uint8_t distance)
> +{
> +    uint8_t numa_level;

This function reinforces my feeling that pre-PAPRizing the distances
might not be the best idea.  It could go directly from the user
distance to level just as easily.

> +
> +    switch (distance) {
> +    case 10:
> +        numa_level =3D 0x4;
> +        break;
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
> +             * we'll assign the lowest value of assoc_src and assoc_dst =
to be
> +             * the associativity domain of both, for the given NUMA leve=
l.

Ok, I follow this description better than the one in the commit message.

> +             * The PPC kernel expects the associativity domains of node =
0 to
> +             * be always 0, and this algorithm will grant that by defaul=
t.
> +             */
> +            uint8_t distance =3D numa_info[src].distance[dst];
> +            uint8_t n_level =3D spapr_numa_get_numa_level(distance);
> +            uint32_t assoc_src, assoc_dst;
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
> +            assoc_src =3D be32_to_cpu(spapr->numa_assoc_array[src][n_lev=
el]);
> +            assoc_dst =3D be32_to_cpu(spapr->numa_assoc_array[dst][n_lev=
el]);
> +
> +            if (assoc_src < assoc_dst) {

So, I don't think you need this logic.  It doesn't really matter which
associativity value you let win, as long as you're consistent.  So you
can just base it on src < dst, rather than assooc_src < assoc_dst.
But src <=3D dst always, because of the way you've constructed the loops.

> +                spapr->numa_assoc_array[dst][n_level] =3D cpu_to_be32(as=
soc_src);
> +            } else {
> +                spapr->numa_assoc_array[src][n_level] =3D cpu_to_be32(as=
soc_dst);
> +            }

Don't you need to match the values a all levels >=3D n_level, rather
than just n_level?  AFAICT it doesn't make sense for two components to
be in the same associativity domain at one level, but different
domains at "bigger" levels (i.e. something like two cores sharing an
L2 cache, but not an L3 cache).

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
> @@ -99,6 +186,17 @@ void spapr_numa_associativity_init(SpaprMachineState =
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
> @@ -128,7 +226,7 @@ void spapr_numa_associativity_init(SpaprMachineState =
*spapr,
>       * 1 NUMA node) will not benefit from anything we're going to do
>       * after this point.
>       */
> -    if (spapr_machine_using_legacy_numa(spapr)) {
> +    if (using_legacy_numa) {
>          return;
>      }
> =20
> @@ -139,6 +237,7 @@ void spapr_numa_associativity_init(SpaprMachineState =
*spapr,
>      }
> =20
>      spapr_numa_PAPRify_distances(machine);
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

--WQ40utMgiyDduspJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9tZn8ACgkQbDjKyiDZ
s5IbdQ/5AfH/h8xdBjBZ+Hht4Gozpz2BxkYZhI70LAFW1F+iSSvTxoaiyl9voFUL
fRWQZj3nCMKjPFvQNGvcs/Qn/VdIZXzuoZumjG1qlaUtzegw28gtKSp4F2nKG0zf
aYj3q2Kvzdmkm9LRCM1yr3/VWgj1nGeMw/P0G/eSxDx/hUXnB3VRb8pf989OB9I9
5d66oET5VSoWR6YmpxwQUxsfQA1bcBk8eZbesEaXSI5i5gWo4g3aNWzaE7to0GXT
WT4jdyStuXK30ey0SyLAClZIQHgiytgDm0sP8kUWtzua24k3JqIP5Khd+ulMOf69
pAIOIJlyO9WqlJz2aYc2L6V5y7mPY0tgGWhPWDGxZc37L5DHnvmBUIbJuKAXvT0e
YlCktwaYqUc1yij2nzYeBxHyHuxOx2Uqp50w+ZJGtwF3wWK3ZyPRb++HG+NXdp0u
UtbJ/WwPnyr0xpg4D9dOcVBtBvA47tV9MSz6+fjbmi91U1oOqK/xBHx8hpsbZaUF
vKxqmHi4fwMkYbNSNxior7yJ+c9NJffqAa7nWRTzuXXws4vV+NfEmGTJ9lK9zN8Q
L2/CWMOaLmCh1zfHYO8swXbRxaV/HF3acZ5epA8lwAGZ47+th98gbWU7/7FPW0rp
1Nyag22tR+42/PK3Xf0TXvNWmhn9YgjfjVOGHqS9Hg0C2OOxMLk=
=jCGC
-----END PGP SIGNATURE-----

--WQ40utMgiyDduspJ--

