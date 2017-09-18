Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwd9-0004Ro-3X
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwd5-0003Dr-5g
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:02:35 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65e91d2c-9a0c-3cd1-7187-248b4415dea8@redhat.com>
Date: Mon, 18 Sep 2017 09:02:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ILUa3hefmrNDwCFgnR8BbCOCEgWwI2Pbw"
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block: support passthrough of
 BDRV_REQ_FUA in crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ILUa3hefmrNDwCFgnR8BbCOCEgWwI2Pbw
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <65e91d2c-9a0c-3cd1-7187-248b4415dea8@redhat.com>
Subject: Re: [PATCH v3 7/7] block: support passthrough of BDRV_REQ_FUA in
 crypto driver
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-8-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 06:28 AM, Daniel P. Berrange wrote:
> The BDRV_REQ_FUA flag can trivially be allowed in the crypt driver
> as a passthrough to the underlying block driver.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ILUa3hefmrNDwCFgnR8BbCOCEgWwI2Pbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/0ecACgkQp6FrSiUn
Q2qTkgf/RFuPBkwCEKaXuP1y7omGmq6PPRaUgWLBmqYld3RVH6B9/PREkl8ikZ1m
u3mlrJvCUQIfffjckqeVwj/Gq46Xj2g4n2/aTd+TArme3IOT2omRwujV2PxcS8qs
zpsv3t05t55g3uNGaxUIzp5oKBfr84pQNE0DD2dGfgDoGxIYn4g8wsA3eZgzJjHl
WzgFAFrylNFt1QVYWeW5UrF6TkI7ZaA/ELzulVjMu7x4bbfwysnioNI9hImTKxY4
md+hCgBxaLac/2YReg+kCa5VvRRsJtZR3Uzf8BxGxANFMlFnmVpLKxGMff81SR9+
FU02Bs15rdw7qHtHmsxk+1h61RrKqA==
=AhCI
-----END PGP SIGNATURE-----

--ILUa3hefmrNDwCFgnR8BbCOCEgWwI2Pbw--
