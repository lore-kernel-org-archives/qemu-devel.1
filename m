Received: from eggs.gnu.org ([209.51.188.92]:51084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjldl-0005eK-QX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjldk-0008H7-Ji
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:53:57 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-7-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <839f19ba-2e2e-0cc7-8abd-321deaf2a47a@redhat.com>
Date: Wed, 16 Jan 2019 14:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2g3OsvgNRDwvRlfI5hFZhP6igqi7pNbwL"
Subject: Re: [Qemu-devel] [PATCH v5 06/11] iotests: prepare 055 to graph
 changes during backup job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2g3OsvgNRDwvRlfI5hFZhP6igqi7pNbwL
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <839f19ba-2e2e-0cc7-8abd-321deaf2a47a@redhat.com>
Subject: Re: [PATCH v5 06/11] iotests: prepare 055 to graph changes during
 backup job
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-7-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Backup will append fleecing-hook node above source node, so, we can't
> resume by device name (because resume don't search recursively through
> backing chain).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/055 | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2g3OsvgNRDwvRlfI5hFZhP6igqi7pNbwL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw/NiYACgkQ9AfbAGHV
z0B+ywf/bDf06vzAadC/SHWOFoHm06WVlQl84YMhm0unp3pyBr5liByBmlSrNuRP
qhp/UMOjvqVT5wTW3Tt9RTcj4qoFwHrHZXxPth0aafDHaLYy7oP/9Mjsl5fmdLTa
8ogHH7AVfEQQOGDqy6/dNarEhvwCUbN26Xf8AyCk8/xVjyUxzZOL5yAC6NNjNElQ
GiDKC4L9Wv3q02zlr/Hv1nPZYHnv0nO+shZP7QtKhjJscp1HxMWg0E8Da22c8I+G
yq4Ktnm2AhTIVbNkOTOviP5KVBluy/IC/R6ZglJxdJVlQ9AiEGrpcCmgcqHm9hFm
AwdBL8qR8yfsjh2G+4RiJ7fcNrRk4A==
=HIjJ
-----END PGP SIGNATURE-----

--2g3OsvgNRDwvRlfI5hFZhP6igqi7pNbwL--
