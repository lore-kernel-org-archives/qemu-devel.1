Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA574C10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 02:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BF12086A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 02:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jjn9Bf7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BF12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGDMS-0008Qm-DG
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 22:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGDHa-0006VV-UO
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 22:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGDHZ-00011V-AD
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 22:25:26 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56017)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGDHV-0000uF-Lx; Thu, 03 Oct 2019 22:25:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kty23HRxz9sPq; Fri,  4 Oct 2019 12:25:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570155914;
 bh=JXYfyJWqmwUgKWts+J50NYzPm8aCRHAvHjyxMKQBlmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jjn9Bf7PjvM/b0KBmV0Opt4a5S9xtqHs3HiP79dufjG9saq9NPXWtEw9NQdS7LUL4
 beicNxLifPABFQHDZxE0+YdgJFThV9lTvM3W9nWtCkGt+p5g75WZT/cPcapVFYkcgZ
 XKQWEQQq7KLRuPjhizeKrVhU2P1MBm6L7SOfC+NM=
Date: Fri, 4 Oct 2019 10:25:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Remove the XICSFabric Interface from the POWER9
 machine
Message-ID: <20191004002545.GA27597@umbus.fritz.box>
References: <20191003143617.21682-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20191003143617.21682-1-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 04:36:17PM +0200, C=E9dric Le Goater wrote:
> The POWER8 PowerNV machine needs to implement a XICSFabric interface
> as this is the POWER8 interrupt controller model. But the POWER9
> machine uselessly inherits of XICSFabric from the common PowerNV
> machine definition.
>=20
> Open code machine definitions to have a better control on the
> different interfaces each machine should define.
>=20
> Fixes: f30c843ced50 ("ppc/pnv: Introduce PowerNV machines with fixed CPU =
models")
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/pnv.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 77a86c6a2301..7cf64b6d2533 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1485,23 +1485,21 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
>          .parent        =3D TYPE_PNV9_CHIP,          \
>      }
> =20
> -#define DEFINE_PNV_MACHINE_TYPE(cpu, class_initfn)      \
> -    {                                                   \
> -        .name          =3D MACHINE_TYPE_NAME(cpu),        \
> -        .parent        =3D TYPE_PNV_MACHINE,              \
> -        .instance_size =3D sizeof(PnvMachineState),       \
> -        .instance_init =3D pnv_machine_instance_init,     \
> -        .class_init    =3D class_initfn,                  \
> -        .interfaces =3D (InterfaceInfo[]) {               \
> -            { TYPE_XICS_FABRIC },                       \
> -            { TYPE_INTERRUPT_STATS_PROVIDER },          \
> -            { },                                        \
> -        },                                              \
> -    }
> -
>  static const TypeInfo types[] =3D {
> -    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init),
> -    DEFINE_PNV_MACHINE_TYPE("powernv9", pnv_machine_power9_class_init),
> +    {
> +        .name          =3D MACHINE_TYPE_NAME("powernv9"),
> +        .parent        =3D TYPE_PNV_MACHINE,
> +        .class_init    =3D pnv_machine_power9_class_init,
> +    },
> +    {
> +        .name          =3D MACHINE_TYPE_NAME("powernv8"),
> +        .parent        =3D TYPE_PNV_MACHINE,
> +        .class_init    =3D pnv_machine_power8_class_init,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { TYPE_XICS_FABRIC },
> +            { },
> +        },
> +    },
>      {
>          .name          =3D TYPE_PNV_MACHINE,
>          .parent        =3D TYPE_MACHINE,
> @@ -1510,7 +1508,6 @@ static const TypeInfo types[] =3D {
>          .instance_init =3D pnv_machine_instance_init,
>          .class_init    =3D pnv_machine_class_init,
>          .interfaces =3D (InterfaceInfo[]) {
> -            { TYPE_XICS_FABRIC },
>              { TYPE_INTERRUPT_STATS_PROVIDER },
>              { },
>          },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2WkYkACgkQbDjKyiDZ
s5LC3w/9FWZ9xwFkz2KzYYah7AsoiUu/zJyP9gBkDQrxaS6yzSjdn9jWJx9d5M3a
EUZXeHRd8uX2Vspq7e/jb+miBJ7afdRLZHTfjdzzd8mdZkKYcUrcSQNq6oYhSRiu
P2ejglxzHjeA0GBdcAEnBWnvPohMiHR+tDotSsBe9heEQeapU15Nvl8qT1MR+IaK
jiiRC4nUv8xVLQdMTVZbJXD+Pdhgi7ELWDH/+etnd7zcZtgvdzjjq1vbHGPyqGT8
sNIywza0CJa8dUn4YY3K10rRkdMIuUliUoojmkOE/yoPkM1mqTb32u5BQXEU5JMn
Oi5GDJc3+QNXfYga+S3kN0D/0Bjt2oy+6y6cHmiBThv9dnMECfCXtwVQmzktu/Xp
8K53vqiSBiEYOpq7mg03GTIwMK3yPhYJJcpqiNXResCxdPlthllzg1QZbjT5AYkb
8JffNtcQ2JQfg5LrVeDAShNs+vO9tBRi/H0QaB+uvCkN8p3tcocEmtQ31+TSgRYi
ZwKQxt58DxmeeYogS7c7RgCm2kp/+vqbjls7Y64moTH1L3zlzeWRSmReJD4lfFhd
blkiEHxkUqEA4qvZueGhcsCfTBRt7B9naxzGnGU08D/MZH0D0CQt7ATMKu4LZGrr
JLdKGXqSP+kPf0n8MAWOU171UKIqgXtch5GBgG9NHzw4XTzjQqY=
=83VT
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

