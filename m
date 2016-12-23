Received: from eggs.gnu.org ([2001:4830:134:3::10]:46740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cKXqw-0008Nr-Hb
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 16:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cKXqt-00029b-IG
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 16:58:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cKXqt-00029T-A4
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 16:58:11 -0500
References: <87inqavlzj.fsf@mail.parknet.co.jp>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8eb87c0e-ba00-e748-8cec-fa089403e13c@redhat.com>
Date: Fri, 23 Dec 2016 15:58:07 -0600
MIME-Version: 1.0
In-Reply-To: <87inqavlzj.fsf@mail.parknet.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ufeq8L30C0U0L8twPqHv7P5Tw00UvXB8e"
Subject: Re: [Qemu-devel] [PATCH] ps2: Fix lost scancodes by recent changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ufeq8L30C0U0L8twPqHv7P5Tw00UvXB8e
From: Eric Blake <eblake@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <8eb87c0e-ba00-e748-8cec-fa089403e13c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ps2: Fix lost scancodes by recent changes
References: <87inqavlzj.fsf@mail.parknet.co.jp>
In-Reply-To: <87inqavlzj.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/23/2016 07:00 AM, OGAWA Hirofumi wrote:
>=20
> With "ps2: use QEMU qcodes instead of scancodes", key handling was
> changed to qcode base. But all scancodes are not converted to new one.
>=20
> This adds some missing qcodes what I found in using.
>=20
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>=20

> +++ qemu-hirofumi/qapi-schema.json	2016-12-23 21:14:59.840729469 +0900
> @@ -3642,7 +3642,8 @@
>              'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pg=
dn', 'end',
>              'left', 'up', 'down', 'right', 'insert', 'delete', 'stop',=
 'again',
>              'props', 'undo', 'front', 'copy', 'open', 'paste', 'find',=
 'cut',
> -            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro'=
,
> +            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
> +            'ro', 'hiragana', 'henkan', 'yen',
>              'kp_comma', 'kp_equals', 'power' ] }

Missing documentation (including a 'since 2.9' designation) for the new
enum members.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ufeq8L30C0U0L8twPqHv7P5Tw00UvXB8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYXZ3vAAoJEKeha0olJ0NqoFoH/203eQrs0X16bDlv/pPqgdZ4
2aSAi/sjzP3o1/f9iCxkX3t77ka+jDYPJraG/Mg4uDaJwZ687j1aNLFMKWbAIkA2
z36baHlUi+Yp8s5GRQP3svxR+qUvDIwS+rKlSncNrUSXvVnKgS8Zjdg/0ywCmRD3
NnfPia0n2y6NDqIiUjI0ALa/Ck2xpmeoYP69RA8syLVS0dowAW6+qDiolGvISfQW
PRKypMEHDAU8u7i2Zl4+AIfnxBRsV4KsM1OkkR4ICtxsJaR9lzyqUKkdMpZZd2f8
dWNTrO+tdu0X93v732i6kV3HUpVHJBiWNascEGgSG7Y0LzApN1X6+OZ5i+iFvKg=
=EWCo
-----END PGP SIGNATURE-----

--Ufeq8L30C0U0L8twPqHv7P5Tw00UvXB8e--
