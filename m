Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8982C2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RNERFHIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8982C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ5HP-0006zt-HP
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 21:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5Fn-0005Ct-57
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5Fm-0002mh-1V
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:59:43 -0400
Received: from ozlabs.org ([203.11.71.1]:55459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ5Fl-0002k8-KY; Mon, 30 Mar 2020 20:59:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rrZc4b3Mz9sSL; Tue, 31 Mar 2020 11:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585616376;
 bh=6SBeMpIUcoEUFG1loMqInWstKYLcCQ4kn9dRsltn5nQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RNERFHIJxOzVsC3XPkd4D4jAOypOTtzVsnyXRz/wx34KEh0BchfDMrQPuHGiJR1I2
 kpe5nMYfY4Uv1qjdUZQpSV8QPnQZJ170pJ/IENeHKWi2A0+8rgEch98z0ikY6W80zf
 K3lWZ1g+LoUfrTlBjZlf8uoDW730aztXqWb3AWZg=
Date: Tue, 31 Mar 2020 11:57:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/7] target/ppc: Enforce that the root page directory
 size must be at least 5
Message-ID: <20200331005738.GD47772@umbus.fritz.box>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20200330094946.24678-2-clg@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 11:49:40AM +0200, C=E9dric Le Goater wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> According to the ISA the root page directory size of a radix tree for
> either process- or partition-scoped translation must be >=3D 5.
>=20
> Thus add this to the list of conditions checked when validating the
> partition table entry in validate_pate();
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.1.

> ---
>  target/ppc/mmu-radix64.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 224e646c5094..99678570581b 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -212,6 +212,9 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t l=
pid, ppc_v3_pate_t *pate)
>      if (lpid =3D=3D 0 && !msr_hv) {
>          return false;
>      }
> +    if ((pate->dw0 & PATE1_R_PRTS) < 5) {
> +        return false;
> +    }
>      /* More checks ... */
>      return true;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6ClX8ACgkQbDjKyiDZ
s5K2JRAA0S5OvMaNJ/EUVjzcdqHxeBG2xSQ8pXvzNNJ8ZNc+Dm9SZxN0o70IUwzv
bpmratSjAYFi2kLsA2xo3KQqbo56IsJNiqnAfK8oJPYQds9SUDzdCnvlfDfyMQVg
WjITngMW6/kwWGpXfD1O7Qh0VLbDazTzTfifVrFn6Hzpx31ewQm/OKh8KEfZTGKb
gZUohEkjiPjEdTPdEOdF8q4yrwGrnk8Ibm2kirS2F726rYPwst40z5E0FmMXh6i+
t6ozCuyFLJo74W2mWWTRk6vxXaPRdaMJMf4QIQjsXVsre+cRc+OyKLj36yQnKILg
YTrxAi4fZMYcpdeUeY/Mlf/Hw5pUrvF9YR6IHC2F13ZQVaYROg04UbZTvOHyljBs
O2e4i7r0On/2AxNWB3pYfrS+roQT5FMK61A06wjdYqEngAdypHB5KJoaeyq10IWh
vyWbnxmXQjZa1SJaCagwRHM6ZeeLOFite18txMNADD6CRMLenFpC+ibyJirSiUky
vgOOKiiwKEBkyPrRNztRYUBaGSuLHM/YD5jyrnYosvXPv5jnQQCwDQHEpG2g5cet
K56ccOZcwQ+6CIr8rnPKFiyr7uZCvUSsZHNl73E7JdlJDNzKWRxNq/d7wtaCVpkP
dvxTWDLAseTPXy9wEY5yCelLqkIEu6kxRDEo6GEI3lK+nkD+Fjg=
=+z6m
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

