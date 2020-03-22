Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C5FC4332D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 05:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407B620722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 05:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XpIu+4ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407B620722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFtKZ-0007uu-Fc
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 01:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jFtJU-0006my-JU
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 01:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jFtJP-0007pR-Nf
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 01:38:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39211 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jFtJJ-0007jL-4J; Sun, 22 Mar 2020 01:38:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48lR9x0slYz9sPF; Sun, 22 Mar 2020 16:37:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584855477;
 bh=F4WJjh+4C1y+czVXBLaP8DstTq8ObneFRp7nfValy5s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XpIu+4MLnl+yeZ0C79fkefwDvOHeyInEHL+0sw6eWx06219QTexLt1cOQjy19sznI
 v2cqQeKn20S1uUvk/pt6C4lVITzJlwdTfPpUEX8fYqcCLUYPmuJje/XZnKgnvhudZy
 cq1Wxqfi/ZnXMHnppCskKhelGUWss3OPHzvl+FNU=
Date: Sun, 22 Mar 2020 16:34:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 04/11] hw/input/adb-kbd: Remove dead assignment
Message-ID: <20200322053427.GH781112@umbus.fritz.box>
References: <20200321144110.5010-1-philmd@redhat.com>
 <20200321144110.5010-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20200321144110.5010-5-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2020 at 03:41:03PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Since commit 5a1f49718 the 'olen' variable is not really
> used. Remove it to fix a warning reported by Clang static
> code analyzer:
>=20
>     CC      hw/input/adb-kbd.o
>   hw/input/adb-kbd.c:200:5: warning: Value stored to 'olen' is never read
>       olen =3D 0;
>       ^      ~
>=20
> Fixes: 5a1f49718 (adb: add support for QKeyCode)
> Reported-by: Clang Static Analyzer
> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2: Remove 'olen' (Zoltan)
> ---
>  hw/input/adb-kbd.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> index 0ba8207589..a6d5c9b7c9 100644
> --- a/hw/input/adb-kbd.c
> +++ b/hw/input/adb-kbd.c
> @@ -195,9 +195,7 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
>  {
>      KBDState *s =3D ADB_KEYBOARD(d);
>      int keycode;
> -    int olen;
> =20
> -    olen =3D 0;
>      if (s->count =3D=3D 0) {
>          return 0;
>      }
> @@ -216,7 +214,6 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
>      if (keycode =3D=3D 0x7f) {
>          obuf[0] =3D 0x7f;
>          obuf[1] =3D 0x7f;
> -        olen =3D 2;
>      } else {
>          obuf[0] =3D keycode;
>          /* NOTE: the power key key-up is the two byte sequence 0xff 0xff;
> @@ -224,10 +221,9 @@ static int adb_kbd_poll(ADBDevice *d, uint8_t *obuf)
>           * byte, but choose not to bother.
>           */
>          obuf[1] =3D 0xff;
> -        olen =3D 2;
>      }
> =20
> -    return olen;
> +    return 2;
>  }
> =20
>  static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl52+OMACgkQbDjKyiDZ
s5J3ihAAyQdD4J2JEB7fYHRvYktz4BhNLIrD6t2qFSAUGeBC2CU+FA4jy4r3qRy8
bk2AWU8o2poFSBT0CCYUZeGuFEPf1MkxZt3p6saNZVk0IX5q3z3WR2d9z+p6veWG
rUzXkpbraEZcI5QHQ+iG9iapqikWxmc4GMQAxD4FFRrSwkju9dTQDN4zlLXs7hhL
YGaQWoIcnfhMQBeM1QFV2mSF4M+SoTTp8RCNsteZAPqf0LAY6BJ3iVb8tH9dpoaO
qEv5Pyjgcs9IeYore+VR67yLq3dSMdKgryO35OBk2EQKrI+2xXjGt8ehECFgDNBt
JULe0H3mGq3EXefuKPTby5NReZaKIWDgtoTuzycDT4F1JERG/kCfUpEcKbjwS3N1
yJsCMshYqqSS1yBfEe0MXi453m8h6N+jzXIQAJXhFVqiyb3mIG2FENNu7g78TMiD
dN9L8f5lnhRxk0pZXzsOjCjyE9fkthUBU3UBE7xAyHczIaQ/+5nPjr2kKRkjc+Rw
RkLHCEfHMaJA81znCp6sQhQ5EKskkIVZxvIrdsRpweydRNUNfvdZtF6EGpJBStEc
btANFqt7dcMWVjxukE711vQJoq1A1k8IulwkkolJB+jnRq2TadAloQjhMdRSPiLE
CPUAX76wERETZC6h/hgmHd7PzQSFXT6J9gmP1ziJ62ibcLpda1A=
=8mA0
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--

