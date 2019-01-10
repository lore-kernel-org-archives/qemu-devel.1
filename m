Received: from eggs.gnu.org ([209.51.188.92]:45155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbpB-0001WS-8r
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbp6-0005bk-3F
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:00:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghbp5-0005aW-QO
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:00:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14D9AC0C9A8B
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 15:00:36 +0000 (UTC)
References: <20190110120047.25369-1-berrange@redhat.com>
	<20190110120047.25369-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c471db17-bab0-21e7-d8c2-7f1b8c1ef742@redhat.com>
Date: Thu, 10 Jan 2019 09:00:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190110120047.25369-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hCuWFFX2Kc8dLLeweUpjlEdo1sIWhfKs5"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] ui: install logo icons to
 $prefix/share/icons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hCuWFFX2Kc8dLLeweUpjlEdo1sIWhfKs5
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <c471db17-bab0-21e7-d8c2-7f1b8c1ef742@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] ui: install logo icons to
 $prefix/share/icons
References: <20190110120047.25369-1-berrange@redhat.com>
 <20190110120047.25369-2-berrange@redhat.com>
In-Reply-To: <20190110120047.25369-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 6:00 AM, Daniel P. Berrang=C3=A9 wrote:
> QEMU currently installs loogs to $prefix/share/qemu/ which means no GUI=


s/loogs/logos/

> toolkit or applications can find them by default.
>=20
> The accepted standards for desktop applications declare that applicatio=
n
> logos / icons should be installed under $prefix/share/icons, so use thi=
s
> directory location.
>=20
> Pre-rendered icons are provided at the standard sizes expected for GUI
> applications, along with the scalable SVG, to ensure maximum portabilit=
y.
>=20
> The PNGs are rendered from the SVG using inkscape, however, this is not=

> wired up into the default make rules to avoid requiring inkscape as a
> mandatory tool in build systems / developer workstations..

double trailing '.'. I like that the rules for automating it are there
as a separate make target, and that they are not part of the default
build (and hence the generated files must live in git).  That said,...

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---


> +++ b/ui/icons/Makefile
> @@ -0,0 +1,13 @@
> +
> +# Regenerate bitmaps from the SVG using inkscape CLI export
> +# and ImageMagick. Don't use ImageMagick for the initial
> +# SVG conversion, since it merely calls inkscape, but uses
> +# 96 DPI res resulting in poor quality output.

=2E..should this comment mention that it is intentional that this target
is not part of 'make all'? Should the target be named 'maint-regenerate'
to call attention to the fact that it is a maintainer-specific target?

> +
> +regenerate:
> +	for s in 16 24 32 48 64 128 256 512; \
> +	do \
> +	    inkscape --without-gui --export-png=3Dqemu_$${s}x$${s}.png \
> +		--export-width=3D$$s --export-height=3D$$s qemu.svg ; \
> +	done
> +	convert qemu_32x32.png qemu_32x32.bmp

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hCuWFFX2Kc8dLLeweUpjlEdo1sIWhfKs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw3XgsACgkQ3g5py3or
ov2gjQf/RYraQuMZ7+4dZJalqshL+eUrQWouhzC1lGBlVjSiRlphl29ApjHf6/wV
Iz3KrNtwkESqeDgwUTgBMLWIL100a2iKP0pFf0cv5b8d08fTe376a/QD6U4lOreE
XOVo3PxojwmUDdl0v2rbY48xp65lkZah/QsHeZZEwrKBioQE6+7GUxATWnh1aflN
39uV/ds2lC6hu6FsViuco4garJU4MKcb36Et0lfOk2nab/oOAk0GgBkU2snUOQQJ
LRk2r8XOMGHSqigPZ/6F2PC83eM5zupnAQavyhupWWP2+oBMyonAzCR5ALa191Gw
zNnkiSQYsCQpc4vjn0x+f+VhV/7kfw==
=9e/G
-----END PGP SIGNATURE-----

--hCuWFFX2Kc8dLLeweUpjlEdo1sIWhfKs5--
