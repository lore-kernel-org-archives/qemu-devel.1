Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D42ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AE420684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SIe554cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AE420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTVL-0000Ye-N2
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTK-0006Ry-Ap
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTJ-0002sv-2Y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:34 -0400
Received: from ozlabs.org ([203.11.71.1]:45569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTI-0002nH-Mm; Wed, 23 Oct 2019 23:07:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS3FMrz9sPF; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=GQy2ZqkTqzoQoFHI6hPljBbVMX3AWSu6g0qWhEOgCZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SIe554cNg2mWCbZ16Jhh0M0LgbXBL98YGklqblU7laeyT3udb0e+AMf7D1pTD/jED
 aBFV769spyEyOp2tY63KNRs+Jio00joDJdESAsnsFjIPz2wf4hBIGezQQBIivArQUT
 b7DUHHYu5CuB5vtyKRPNRypDnUxamIcF8Ia70vB4=
Date: Thu, 24 Oct 2019 13:38:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Message-ID: <20191024023812.GO6439@umbus.fritz.box>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E187YRO8KGM40JwS"
Content-Disposition: inline
In-Reply-To: <20191022163812.330-5-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E187YRO8KGM40JwS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=E9dric Le Goater wrote:
> We will use it to reset the interrupt presenter from the CPU reset
> handler.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  include/hw/ppc/pnv_core.h | 3 +++
>  hw/ppc/pnv_core.c         | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index bfbd2ec42aa6..55eee95104da 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -31,6 +31,8 @@
>  #define PNV_CORE_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
> =20
> +typedef struct PnvChip PnvChip;
> +
>  typedef struct PnvCore {
>      /*< private >*/
>      CPUCore parent_obj;
> @@ -38,6 +40,7 @@ typedef struct PnvCore {
>      /*< public >*/
>      PowerPCCPU **threads;
>      uint32_t pir;
> +    PnvChip *chip;

I don't love having this as a redundant encoding of the information
already in the property, since it raises the possibility of confusing
bugs if they ever got out of sync.

It's not a huge deal, but it would be nice to at least to at least
consider either a) grabbing the property everywhere you need it (if
there aren't too many places) or b) customizing the property
definition so it's written directly into that field.

> =20
>      MemoryRegion xscom_regs;
>  } PnvCore;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 9f981a4940e6..cc17bbfed829 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>                                  "required link 'chip' not found: ");
>          return;
>      }
> +    pc->chip =3D PNV_CHIP(chip);
> =20
>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> @@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
> +        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
>          if (local_err) {
>              goto err;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E187YRO8KGM40JwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xDpQACgkQbDjKyiDZ
s5KA6xAAzGzg4wlErRDn08n0/uYlyqcD1FpJiuVo4zxqtgmJm7np9KyWNlizUew6
9TnXyZnjWLTQ7Rc+uO6uTmGJ0HCdglrpGQxn+hmUxDK0kkEpeZDR9Of9jbsl4g9Z
CAb76Pgv1yMiPpCHZaKQ1KH5b6HGJsYKBJ9JUEUyh/gzj4teXiTAsmsfl80NIYeA
rIh4I/TVk5eQciRIvoSyJedrXhW/wXx+DpiUvDuwqDnDDDwAFSKRVXND+0rJ88KL
AKtykQKA+7ctFdc0y+93+xslEF7NZ0XOHGN4L2JeGOVLO/+4pPmxUoI82DIzecbn
+Om1l0SGv9/zMQzQ/zXyd+kETRBOloYOJMvDhu0UeT6qMbi8iJjze7oEeuXjNtG6
fdiXXMocqXVtqzkVeSBzRCKn0C5UdGTsmO3PsU1a9qCnA8PkJ9iA77YS4DSLvm9j
KU6BaS6+EBqHT2TCryLTG0fAsqWBKwC9OO5EGgLKLZ1rgGlq1vpnb0eQ6HOnaAqA
NbEQ3mp0qGGuehXXIYxxxiO2bCdi47xQP7yh2DKpdqzPm5ITAX/LrzG0DsyxYMod
6mRfPqljT1+OlTISqUTjOWZib2uLZoqEdVbX/fqgcpZNriR8Kg+GuXqrl8svqKHC
yYysvcQ0l7/cV3cT9ZArOrSdvV8/h7d1g48G5N6olS8PX6DItMg=
=X6DF
-----END PGP SIGNATURE-----

--E187YRO8KGM40JwS--

