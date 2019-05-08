Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5976C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 01:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8022C20C01
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 01:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z9KrCCdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8022C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOBKt-0007FK-RH
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 21:25:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOBJV-0006S9-21
	for qemu-devel@nongnu.org; Tue, 07 May 2019 21:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOBJT-0001Kz-MU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 21:24:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40977 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOBJP-00010e-LU; Tue, 07 May 2019 21:24:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44zJf235Rsz9s3l; Wed,  8 May 2019 11:23:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557278634;
	bh=0fBnanrGf7xKhTU3enoxcHjF+pVmxBK7EFPrGpZJHkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9KrCCdcle8BKVsK+Dw0JVEK/rmDRlQYyqMSrvXFY72qoF1dd66ZKEEsT13pNUmUr
	i55nbHpXoOLFEGGt3Eqbhs8voybUCT5IS7dsPr8IVNofnuKJsk59zVY2MSatB7LVb5
	bjgnrD9f7mlmVHSLYrRQtlf6x4Ud28PgSWf0qNZg=
Date: Wed, 8 May 2019 11:23:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190508012345.GN7073@umbus.fritz.box>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Content-Disposition: inline
In-Reply-To: <20190507163416.24647-3-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 02/16] hw/misc/macio: Use
 object_initialize_child for correct ref. counting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paul Burton <pburton@wavecomp.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Andrew Jeffery <andrew@aj.id.au>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 06:34:02PM +0200, Philippe Mathieu-Daud=E9 wrote:
> As explained in commit aff39be0ed97:
>=20
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
>=20
> This patch was generated using the following Coccinelle script
> (with a bit of manual fix-up for overly long lines):
>=20
>  @use_object_initialize_child@
>  expression parent_obj;
>  expression child_ptr;
>  expression child_name;
>  expression child_type;
>  expression child_size;
>  expression errp;
>  @@
>  (
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
>  +                           child_type, &error_abort, NULL);
>      ... when !=3D parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 NULL);
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  |
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
>  +                            child_type, errp, NULL);
>      ... when !=3D parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 errp);
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  )
>=20
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/misc/macio/macio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 94da85c8d7d..b726c73022c 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -346,12 +346,12 @@ static void macio_newworld_realize(PCIDevice *d, Er=
ror **errp)
>          object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &e=
rr);
> =20
>          /* PMU */
> -        object_initialize(&s->pmu, sizeof(s->pmu), TYPE_VIA_PMU);
> +        object_initialize_child(OBJECT(s), "pmu", &s->pmu, sizeof(s->pmu=
),
> +                                TYPE_VIA_PMU, &error_abort, NULL);
>          object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "g=
pio",
>                                   &error_abort);
>          qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
>          qdev_set_parent_bus(DEVICE(&s->pmu), BUS(&s->macio_bus));
> -        object_property_add_child(OBJECT(s), "pmu", OBJECT(&s->pmu), NUL=
L);
> =20
>          object_property_set_bool(OBJECT(&s->pmu), true, "realized", &err=
);
>          if (err) {
> @@ -365,9 +365,9 @@ static void macio_newworld_realize(PCIDevice *d, Erro=
r **errp)
>                                      sysbus_mmio_get_region(sysbus_dev, 0=
));
>      } else {
>          /* CUDA */
> -        object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
> +        object_initialize_child(OBJECT(s), "cuda", &s->cuda, sizeof(s->c=
uda),
> +                                TYPE_CUDA, &error_abort, NULL);
>          qdev_set_parent_bus(DEVICE(&s->cuda), BUS(&s->macio_bus));
> -        object_property_add_child(OBJECT(s), "cuda", OBJECT(&s->cuda), N=
ULL);
>          qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
>                               s->frequency);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzSL6EACgkQbDjKyiDZ
s5Kw6hAA2Hc5Y6SadB7mco+ruDYrj68fUlTO3GB4S7saegyCbbMVOHq9sxr9hj7b
LVk5Yu1+eY/TcuyqhdVDqOpGOWLKhx8LPIvvHwe1tiYakqV+qaIPgS0+U61cxaKg
B7dXBRIz60Xo/8cx39bK5V7akI4MfxSUl4/kDqGgjuoY/bTruk5pMyTTuUghYGM7
1T2Oct9EQFBLNYTZz30cv7bYNGLAgvic+8A9mO69qaugaGFX7WHtPex7c1CROLmC
7ATAyKGEZ7ROGy5gIi64udSwVZEK864aGu2ihFDsUIySu/O6eBvs9rwJjmqb5/Gs
U8JdU+DGwOBHPhkbF+Mj1jWeEzTgykvyIg31Gf5XcReah8PFDHl0GhECc0XJwC9P
oDVzKEgEPkyYA9ShAd2THrkaNlPLxSsxfYExpleHcsa0azkLlRTztoRqlmbcsN4f
zHnAqvfOc0civsyALWRXDRvQPbNCw2xbjgCjk4B7JUpHFbDowNTJr+jDs1HYdiL6
pShSWI6qiJYFcSLIhWdBrJNP0yl1vhwOtuTZNS7hA/z1QG8GZADaJ76CDHqoPK4E
izK4SndlH2p3itZOD6rDcOv4HZpfSFmQJrEwyvQWILzasCpFlauuyRfmua+xdcFe
YEIwt8OJEvLyaCQNKVsIvJTsjWMod446XSQB+oWHxqo0sKefdHo=
=8tJh
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--

