Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332B3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D183206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="azfZQyfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D183206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLekR-0006pA-1u
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 23:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejJ-00057C-3T; Thu, 24 Sep 2020 23:49:05 -0400
Received: from ozlabs.org ([203.11.71.1]:37275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejG-0004OO-AW; Thu, 24 Sep 2020 23:49:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4ByHvg3Cwwz9sTQ; Fri, 25 Sep 2020 13:48:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601005727;
 bh=ak2X9l4J3Q5bnvej5+0Wy4dhSPXoi7+d8mIV4kXE8as=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=azfZQyfe+zZhTcc6V0WTHwUMEknQIpxYI/jv0OTy9aZbcJ0DPqWLpqfRrJUJDn/8q
 TLWAeWoZfCkUinLj7dKJA/ZwQwrNtq4MgFydFHzTyXTAZtAzvUo7gmp13EZMqb3GYI
 yLWM6pyjm5u5qHpoW7Rh4/7e7COCs4KDFGaw9S5M=
Date: Fri, 25 Sep 2020 13:48:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
Message-ID: <20200925034816.GV2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-3-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yC91f7qSViS67v3c"
Content-Disposition: inline
In-Reply-To: <20200924195058.362984-3-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 23:48:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:50:54PM -0300, Daniel Henrique Barboza wrote:
> The pSeries machine does not support asymmetrical NUMA
> configurations. This doesn't make much of a different
> since we're not using user input for pSeries NUMA setup,
> but this will change in the next patches.
>=20
> To avoid breaking existing setups, gate this change by
> checking for legacy NUMA support.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Having read the rest of the series, I realized there's another type of
configuration that PAPR can't represent, so possibly we should add
logic to catch that as well.  That's what I'm going to call
"non-transitive" configurations, e.g.

Node	0	1	2
0	10	20	40
1	20	10	20
2	40	20	10=09

Basically the closeness of 0 to 1 and 1 to 2 forces them all to be in
the same domain at every PAPR level, even though 0-2 is supposed to be
more expensive.

> ---
>  hw/ppc/spapr_numa.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 64fe567f5d..fe395e80a3 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -19,6 +19,24 @@
>  /* Moved from hw/ppc/spapr_pci_nvlink2.c */
>  #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
> =20
> +static bool spapr_numa_is_symmetrical(MachineState *ms)
> +{
> +    int src, dst;
> +    int nb_numa_nodes =3D ms->numa_state->num_nodes;
> +    NodeInfo *numa_info =3D ms->numa_state->nodes;
> +
> +    for (src =3D 0; src < nb_numa_nodes; src++) {
> +        for (dst =3D src; dst < nb_numa_nodes; dst++) {
> +            if (numa_info[src].distance[dst] !=3D
> +                numa_info[dst].distance[src]) {
> +                return false;
> +            }
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  void spapr_numa_associativity_init(SpaprMachineState *spapr,
>                                     MachineState *machine)
>  {
> @@ -61,6 +79,22 @@ void spapr_numa_associativity_init(SpaprMachineState *=
spapr,
> =20
>          spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] =3D cpu_to_b=
e32(i);
>      }
> +
> +    /*
> +     * Legacy NUMA guests (pseries-5.1 and older, or guests with only
> +     * 1 NUMA node) will not benefit from anything we're going to do
> +     * after this point.
> +     */
> +    if (spapr_machine_using_legacy_numa(spapr)) {
> +        return;
> +    }
> +
> +    if (!spapr_numa_is_symmetrical(machine)) {
> +        error_report("Asymmetrical NUMA topologies aren't supported "
> +                     "in the pSeries machine");
> +        exit(EXIT_FAILURE);
> +    }
> +
>  }
> =20
>  void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *f=
dt,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yC91f7qSViS67v3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9taIAACgkQbDjKyiDZ
s5KGoA//ZUXZmhcODTKD7ESs7bBXDecNjUnu8GmWuPXCHgxN5Hpe3Lt/feIQjfUr
cNYl3Hm+9I3O1pYitt3ganf7HTgBGLH7ZGeF+FdpXuyWcv1y7HFhTKy0h27qRH2e
QyfyZGX8KhX7vtMOg3bs8VzkSI1EmBWJ6E/vPW9GkaIOASdl1sb9wG3F/XNe6hS2
H3gW3Xoc35G7WRWPJ/y2WwAkAcKpWbTun1XUU0xsuNQNc2tSkn03K04ugWItH2Zw
ddEat0mI9u6ucw1PGT/1vsZDmWxiUcZjMQRQMCHTfHGtXAMBDGtmBV5ZN18WrZ0r
sFYAMzdwWbsdBJTF/7hWtEm3z9ONKQviw/CBCllmlDgOJj3hQlg8x+Y3OiyMFTKW
otn+W9/2fKF3SdkW/vLGwoQe9Zej2SoaBQTarNgLYgnbRwrUtHhPiUs4lxv25FJb
4sELfC+dpOfQaxf79GdXKPWU7AmFl6woLTU90MEJwagR9H2WtIWrvAPkmf+j4O5x
anxJ6Zidy9zEyCPLQVzM3QW83AR0Ecv0pNp4bL36lzB87VmflembH0gayqI3Xvhb
BuHmAYFx9ec+C/EhUheHugzG5RmIERwfwp7dYROliemiQXEV0sKFgdKTCrT5LZGo
9YYBpBdVEyVsc0IqeintHUGBmhKIA/mnzuwCUAq8SuGu6Iw15FM=
=gLmR
-----END PGP SIGNATURE-----

--yC91f7qSViS67v3c--

