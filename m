Received: from eggs.gnu.org ([2001:4830:134:3::10]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZNIT-0005Bt-8b
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZNIQ-000727-2a
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:48:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZNIP-00071F-Pk
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:48:25 -0500
References: <20180110202553.31889-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb5cf329-50b6-845b-ff74-cd0001778611@redhat.com>
Date: Wed, 10 Jan 2018 14:48:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180110202553.31889-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wXh0PLPahUUibbZF7Juceiobrplo4Qtx7"
Subject: Re: [Qemu-devel] [PATCH 0/3] tracetool: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wXh0PLPahUUibbZF7Juceiobrplo4Qtx7
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <cb5cf329-50b6-845b-ff74-cd0001778611@redhat.com>
Subject: Re: [PATCH 0/3] tracetool: improve error messages
References: <20180110202553.31889-1-stefanha@redhat.com>
In-Reply-To: <20180110202553.31889-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 02:25 PM, Stefan Hajnoczi wrote:
> This series improves the tracetool error messages to make them more
> user-friendly.
>=20
> Stefan Hajnoczi (3):
>   tracetool: prefix parse errors with line numbers
>   tracetool: clarify that "formats" means "format strings"
>   tracetool: report error on foo() instead of foo(void)

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

but see nit on patch 1

>=20
>  scripts/tracetool/__init__.py | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wXh0PLPahUUibbZF7Juceiobrplo4Qtx7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWfBAACgkQp6FrSiUn
Q2ru7ggAmIhPmuTdpp9nuLEe9KGJ3Ti1YSme9lK/I8C04Q92T8mVuEgsYT859Vz6
pStGw5BKjCc0Jzcg6CmgWYto0CcRqTf+bdqqthjGa0QXXO6PpIbXETbZp7pN7+g1
x1StWrf8Slxba1H6vb8L/iywlTWV+u41ZeO1X+ho4aiiPAVmK8Ew5g54zM9Bn2We
iZOG0M7bHnodrBtNJwO+tAYv0gQk1HctmkaSbW8Ag0rCO0FSvo8zYQkv5WDxyQWu
ZVyoB2kd9FLpiutmVPi26UJiJEkrctFEFhd6vYPinnoNq/KqpK8rXIrKO64Hfkje
Cy2mBju24yFowccju5D39u077HT4Lw==
=NjaW
-----END PGP SIGNATURE-----

--wXh0PLPahUUibbZF7Juceiobrplo4Qtx7--
