Received: from eggs.gnu.org ([2001:4830:134:3::10]:35244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl13Y-0007K8-Qn
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl13U-0002Sv-5W
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dl13T-0002SM-Ro
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:56:52 -0400
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<20170818142613.32394-4-ldoktor@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <116344ac-8075-0b6d-dd93-70d4d0fc3cc7@redhat.com>
Date: Thu, 24 Aug 2017 18:56:43 -0400
MIME-Version: 1.0
In-Reply-To: <20170818142613.32394-4-ldoktor@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kvidTUHbWxBbuiE6cIKWrxRwb8fADmK0w"
Subject: Re: [Qemu-devel] [PATCH v6 03/10] qemu.py: Use iteritems rather
 than keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kvidTUHbWxBbuiE6cIKWrxRwb8fADmK0w
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org
Message-ID: <116344ac-8075-0b6d-dd93-70d4d0fc3cc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 03/10] qemu.py: Use iteritems rather than
 keys()
References: <20170818142613.32394-1-ldoktor@redhat.com>
 <20170818142613.32394-4-ldoktor@redhat.com>
In-Reply-To: <20170818142613.32394-4-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> Let's avoid creating an in-memory list of keys and query for each value=

> and use `iteritems` which is an iterator of key-value pairs.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 5d09de4..db21407 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -186,11 +186,11 @@ class QEMUMachine(object):
>      def qmp(self, cmd, conv_keys=3DTrue, **args):
>          '''Invoke a QMP command and return the response dict'''
>          qmp_args =3D dict()
> -        for key in args.keys():
> +        for key, value in args.iteritems():
>              if conv_keys:
> -                qmp_args[key.translate(self.underscore_to_dash)] =3D a=
rgs[key]
> +                qmp_args[key.translate(self.underscore_to_dash)] =3D v=
alue
>              else:
> -                qmp_args[key] =3D args[key]
> +                qmp_args[key] =3D value
> =20
>          return self._qmp.cmd(cmd, args=3Dqmp_args)
> =20
>=20

Yep, I could tell this was coming while reading patch 01.

Reviewed-by: Cleber Rosa <crosa@redhat.com>


--kvidTUHbWxBbuiE6cIKWrxRwb8fADmK0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfWasACgkQZX6NM6Xy
CfOdQw//eruwL3yDSZ9DyR2O8jUoBvpPdnbNHfjBkyJMRjYpBnnrYISiuJUa/fGq
VQdI7sxLCj8Ljv4Bfkn0E97U2WAX3ZXC2TRdy5ycmXKV28v0XhfIDWn9n0HhiBsn
T9tPKfTRpjP6QOfab7fNYoEKFIJ2XX803t4qThsPenLofQKeqwHYLmZELzFWTXR1
MdE1C5l0puwNjOFQIU/dSb42jQd4DkShyu2+LR5qm1twddPRDR8HsTWIKvcsChzs
70VDk/v65F4LXGPS791dSW5wC60cg7JZCYOaiTqW+JRCsVtx0SvZmuLd7yqAIbx7
X0J3CDRIoQxKfAOR3R4cDmgN31lp/qidoExSfJePUEJubfQJTmBBA95jH9D8JqZG
xKn1vlhir+8agMto0evUZDCXDSdnywR3ljWMx3J1p5AK0ixPTPrT/iRrz2639z6U
78puDwkpbNCAx2IkUI4Jn05GlQfiOi7JlV0q6x6snbLbhdmyQNLqZ7VA2q2UrOoC
fEwGMO4z74O/R4kEPgytcyoVOy0W//VHfrMdYzCpKHK1obWoM70UvoPc3XlyiuYA
BIWTr7vAQA+eAZ186HzCGqJA1yZrSbSti0/q6JGtX8x8QoJNFWDHi40c2F8ZacL0
WasD8MWeO6aULsGQA6VXmfxMz556zOy0OJKatzAId+dZ8cgzTtI=
=adLo
-----END PGP SIGNATURE-----

--kvidTUHbWxBbuiE6cIKWrxRwb8fADmK0w--
