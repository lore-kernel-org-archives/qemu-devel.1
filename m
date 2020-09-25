Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B36C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772092086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 03:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o0TA+aXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772092086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLemC-000127-Iv
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 23:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejD-0004yX-Ti; Thu, 24 Sep 2020 23:48:59 -0400
Received: from ozlabs.org ([203.11.71.1]:59057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kLejB-0004Nb-65; Thu, 24 Sep 2020 23:48:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4ByHvf5Y1Xz9sSC; Fri, 25 Sep 2020 13:48:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601005726;
 bh=JKQQATwlkwN/lEawxMHKDxbT7I+XJJIqcJK7SXhXu4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o0TA+aXb2CvI2OuV6zj7xXkFb7DwCN1NP9d4Hn5FoAqBKHKAaJejiQWfcIdFM72WM
 ZjvWsOgBgpaHQm2KmIhaVXXBAeCBH4FGa7Ze+LnuaaYMGJw8+5lG+QM8tbc006rYVY
 LhMSKKZuvjEkiamk6lKfoRMJb4IagJN4yT64iqV4=
Date: Fri, 25 Sep 2020 12:36:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
Message-ID: <20200925023648.GR2298@yekko.fritz.box>
References: <20200924195058.362984-1-danielhb413@gmail.com>
 <20200924195058.362984-3-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="19HmC3QOnaNVzKTI"
Content-Disposition: inline
In-Reply-To: <20200924195058.362984-3-danielhb413@gmail.com>
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


--19HmC3QOnaNVzKTI
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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

--19HmC3QOnaNVzKTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9tV8AACgkQbDjKyiDZ
s5I0IBAAi4FxxFY9n5j57xUadukJSwKsoYFBZp/Hd/Mexz1FX5xEF9JcyjaU1NKk
CNkt7n9djCVlJZ0MObZ1+xtEhJ8JiKb1MyUyACxcQmJL7bRImgYDUsCEXTkpMOob
wf96ZMIppZHwqIr7VMq7JDwVaNcF9/yTdMi8BAIHkz7lq45xjYwvDM3nGGQg4xJL
2QJ4SFi+506yg6iFhE+a/OuRCEmH27UJAWfQbTQi1ML8MPYbJNUiR/5fyNSLy9uO
KnvpFEIKPhR2R8GB3BktTxIIwVX2Pvv/dWi72qiabsio9yul9ZbSbw4Qv9PNphba
mhGZUzwi7uuvcJ54dJa5MCynxoQqlyDZBEEI8FOQyI1/9KT7sBRT2xQ3T1ScVZOp
R+8N8Aa1MGpZaKf/+cpwKbJHI91ZlXQxr34Fs0YN4kzoGwyD8GEdr0BHnn47Fgnp
SJPiFPPrfl0sjDENudZVbU4di5gXPGivtoXAUvdNHTcX/zrqXY019uLeNMg0KrNb
JziCFtvacZoYax6RfAcr+pwbRkEDVTVhaeDUfKfrW7O+x0XeQxNWUHv2jeZ/qN7+
OTo4RYpZhRbr5c7FxLytWMDdMdWP0uPCfRPZo54y9JL+0HX2WJaLlyRHsF5ryAwt
ww/zt9j4SQ3BcEXiU0l5NNiFVebGokA4MyZS0MNL+PY2FRKzGeg=
=5HuR
-----END PGP SIGNATURE-----

--19HmC3QOnaNVzKTI--

