Received: from eggs.gnu.org ([209.51.188.92]:48936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1xQI-000079-K3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1xQH-0007xb-Nl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:07:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1h1xQH-0007x9-GT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:07:13 -0500
Date: Thu, 7 Mar 2019 18:07:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190307180710.GE2915@stefanha-x1.localdomain>
References: <20190307161925.4158-1-rusakova.nastasia@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20190307161925.4158-1-rusakova.nastasia@icloud.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/block/virtio-blk: Clean req->dev
 repetitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anastasiia Rusakova <arusakova917@gmail.com>
Cc: qemu-devel@nongnu.org, jusual@mail.ru


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:19:25PM +0200, Anastasiia Rusakova wrote:
> From: Anastasiia Rusakova <arusakova917@gmail.com>
>=20
> Some functions sometimes uses req->dev even though a local variable
> VirtIOBlock* s =3D req->dev has already been defined.
> Updated places to use s everywhere in the file.
>=20
> Signed-off-by: Anastasiia Rusakova <arusakova917@gmail.com>
> ---
>  hw/block/virtio-blk.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgV3OAAoJEJykq7OBq3PI2uEH/Rn2e/4KN5PuZwYDRqItiTww
dEUf2p+n+CDyZJitvWm2iFHOmxp+yoj6BKSil4RJbtFx0MSvIsZ7BIzDfC/w+nTw
USxxWIUp2ELdxekM7lEAEju+i9xQK3ji+4ZflW4JoTNMi1smst5a2vPR0hRvovoj
IoZD6sjGPaDRIBT+oJQyqMpkx8Tatb4UShcwxDhhUu0zHRUcabXzKc5lNTK0Eexv
V6XAe1tqjwTgB2EDszw1VfYkn4DQ4mJ8BUxOqsaTyEMyY2/Kz+pp8RBoFXTsI78t
u/O3zBaevmxKf+bP8pbrZ06azCaj/KPA8pzQd3Qj2VRxNJ2ZGkHNg78JoegMJf4=
=jqFK
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
