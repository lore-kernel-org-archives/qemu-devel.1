Received: from eggs.gnu.org ([209.51.188.92]:56137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtskg-0006fz-Us
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtskf-0002I7-SI
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:30:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gtskZ-0002A4-7B
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:30:50 -0500
References: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ed5a9f55-f2e5-298d-58ac-414759e9b491@redhat.com>
Date: Wed, 13 Feb 2019 12:30:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AxACv0HkmV2RJD9Ht0yWfiUTmepKExDmC"
Subject: Re: [Qemu-devel] Clearing slirp/ license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxACv0HkmV2RJD9Ht0yWfiUTmepKExDmC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-02-13 12:03, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> As we are trying to move slirp/ in a standalone project, which
> eventually could be installed as a shared library, we need to clear
> the license.
>=20
> slirp is supposed to be 3-Clause BSD license (according to
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2f5f89963186d42a7ded2=
53bc6cf5b32abb45cec)
> but it seems to be effectively a 2-Clause BSD (the third clause is not
> in COPYRIGHT)
>=20
> However, there are two units that are GPL-2:
>=20
> - dhcpv6.c, dhcpv6.h:
>   The code was contributed by Thomas Huth <thuth@redhat.com>
>=20
> $ git shortlog -nes slirp/dhcpv6.{c,h}
>      6  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>      1  Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>      1  Thomas Huth <thuth@redhat.com>
>      1  Yuval Shaia <yuval.shaia@oracle.com>
>=20
> - ncsi.c, ncsi-pkt.h:
>   The code was contributed by C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> $ git shortlog -nes slirp/ncsi.c slirp/ncsi-pkt.h
>      5  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>      4  C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Could you reply that you have no objection in relicensing those files
> are 3-Clause BSD?

Ok, for the records: I'm fine if you change the license of dhcpv6.[ch]
to either 3-Clause BSD or 2-Clause BSD.

 Thomas


--AxACv0HkmV2RJD9Ht0yWfiUTmepKExDmC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcY//dAAoJEC7Z13T+cC21r2sP/1C5Y1rxNSlAMJB5Zhigy6Y8
zCkNJh252CnlU5VKRAvYx+oGj0GkQZiFLZGiqNIbCtkcrH/rxIEOaPDJheklhhBf
xQ5iLOsODZ/DqqqEptCfRfFi8Omu/+Q/ACgUUWWrvH0tC72NWXmERH5AewDHqh6e
03U6N2Q+fU8gQM53psSJNGPUWglYzxcldoEhqL//VGCknE4rL0E4A1bhghmBCZAr
IFWVRqD8SfkfSBr7m//hLuW5M/L8mnorAQuYY6nmDxxQP67BI+mcq2pGqeQoaicN
qsqxdyaS29hr5czCGv0BQB2kErQhsAd4yPfSn1wL4lb12ILUcSeemfOr9zw3xZ+g
e0fY0WpWcVR8m+LM6zZ2stnseSHtHoEQxsDvZexkel+QuSzF4uEr7fFYFoWidbN8
GJvHgHuXPeCR7ROmHqb+4Kdk1X2NMgv0t6tQ4fqM7OHR6AvHDZNCHFpqFTwcEaq6
J4WHnyl/0jy/OhofZbHW64LNuGPCb6jV7z586KpdQowD3gycIkzboxb1yajRBuAG
04WcIsfW8fEytwjyoiwZci1NneGPxV76Ke2os98AeYuJCcWrYPEMUz6UrbhChHgP
S5y02emk77TJiCfBDOexFl+f7DWVZdkCAnWRHUqx+rNhM8EWHpTC0AwY7dcIZFk1
ajZDcQjuS7sWKDTCfIPu
=/b11
-----END PGP SIGNATURE-----

--AxACv0HkmV2RJD9Ht0yWfiUTmepKExDmC--
