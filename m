Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3981DC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 01:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E120820C01
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 01:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XUXLd5H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOBKo-0007B8-19
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 21:25:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOBJV-0006SX-Lt
	for qemu-devel@nongnu.org; Tue, 07 May 2019 21:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOBJU-0001N3-DB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 21:24:05 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOBJQ-00013T-VF; Tue, 07 May 2019 21:24:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44zJf22K4Zz9s3q; Wed,  8 May 2019 11:23:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557278634;
	bh=DxLFN7mtgOiWqnrEjlI2GPxmwGRfkp5LAerwEzitFiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUXLd5H53SuDik8XVVCvCNjkCzxVWPmk1n7331BeY+fOgM3kv9OMV09rNtqjaaX53
	/2143aahyaa27r5Ex10Pi0jpc2yUaOrDN5HvzE1m639BDRAUuS+LiqtP7LsEY5gFyg
	c+4MHiedg/rtrGRt+uZLi9mHD1as82vHbP1Ugd+M=
Date: Wed, 8 May 2019 11:23:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190508012316.GM7073@umbus.fritz.box>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Content-Disposition: inline
In-Reply-To: <20190507163416.24647-2-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 01/16] hw/ppc/pnv: Use
 object_initialize_child for correct reference counting
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


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 06:34:01PM +0200, Philippe Mathieu-Daud=E9 wrote:
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
> ?-   object_unref(OBJECT(child_ptr));
>  |
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_si=
ze,
>  +                            child_type, errp, NULL);
>      ... when !=3D parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr),=
 errp);
>      ...
> ?-   object_unref(OBJECT(child_ptr));
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
>  hw/ppc/pnv.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index dfb4ea5742c..31aa20ee25d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -994,14 +994,12 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, =
Error **errp)
>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + (i * 4) * typesize);
>          int core_id =3D CPU_CORE(pnv_core)->core_id;
> =20
> -        object_initialize(eq, sizeof(*eq), TYPE_PNV_QUAD);
>          snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
> +        object_initialize_child(OBJECT(chip), eq_name, eq, sizeof(*eq),
> +                                TYPE_PNV_QUAD, &error_fatal, NULL);
> =20
> -        object_property_add_child(OBJECT(chip), eq_name, OBJECT(eq),
> -                                  &error_fatal);
>          object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal);
>          object_property_set_bool(OBJECT(eq), true, "realized", &error_fa=
tal);
> -        object_unref(OBJECT(eq));
> =20
>          pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->id),
>                                  &eq->xscom_regs);
> @@ -1165,10 +1163,9 @@ static void pnv_chip_core_realize(PnvChip *chip, E=
rror **errp)
>              continue;
>          }
> =20
> -        object_initialize(pnv_core, typesize, typename);
>          snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid);
> -        object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_co=
re),
> -                                  &error_fatal);
> +        object_initialize_child(OBJECT(chip), core_name, pnv_core, types=
ize,
> +                                typename, &error_fatal, NULL);
>          object_property_set_int(OBJECT(pnv_core), smp_threads, "nr-threa=
ds",
>                                  &error_fatal);
>          object_property_set_int(OBJECT(pnv_core), core_hwid,
> @@ -1180,7 +1177,6 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
>                                         OBJECT(chip), &error_fatal);
>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>                                   &error_fatal);
> -        object_unref(OBJECT(pnv_core));
> =20
>          /* Each core has an XSCOM MMIO region */
>          if (!pnv_chip_is_power9(chip)) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzSL4IACgkQbDjKyiDZ
s5KlIQ/8D+bNy6GErxnEOc5N9C5oPD8yIaHOQPc5zr9TrLedsd6znfqwCX2tHsSs
gvmCooJsyL5I1eKQZKH1R2Ns0EBm4suOYJXqEOgtnvT2L43hbcF3dEvVbhwzaDSQ
9KBo5doqXZ9BvztRW3jQL0Mfk0durgDsnuc8iQjT8hNJj9kLguPfGoJdcEeEldoF
Lqo/9o49VFnASfnwfb07kOFrCyMJ9JphjXl5paDob8/IiaZATZtd7ss1OjQ9LybP
4vQVJZlkdX93vqyWUKs5J2YPnFWW5i2G7Ba7i5ukbPYIVl90hnrx7iK7zcRMgye2
aURQtK9Uhta0++e+Du4cyBHACfUdpwGGhm65Zu9ccaHHgqw7i3mMgSLfahSGQQHs
b6sygusUsHGwRoGw8S9N5gtRwFTQ1yOnVR9dudkg7qOgPvHe9gfl9K8iqEFL8GJw
IKKIgKtXiVd4xkBSZIQBydKf2BCgFeswKq8Itm/Ijkz0XqXiIKCqhSfktl6/ixs8
dck8PdS81GmzsYqOLKvwDD1igDIH467IY7lgJkhZw17PWvL28vYlNTl0z/lZB+d6
PaKVvAkCSoG3B2yIhcae+ckCUz+MKkll3F4ol4ktJChHj9K2O7P8kI0VJlwVo3GN
7nlaZi6Hru7XEcXEi39yzA9Usw3CnWMIOIH/CPSqFIBvH3t7NBg=
=2xTF
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--

