Received: from eggs.gnu.org ([2001:4830:134:3::10]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKx6-0005Sb-PE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKsz-0004eQ-2Y
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:55:20 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<b60b90709552235df7e3716b43329cc399d8bbcb.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a6f27964-111c-4f55-6539-d6426ee0f515@redhat.com>
Date: Thu, 1 Feb 2018 20:49:52 +0100
MIME-Version: 1.0
In-Reply-To: <b60b90709552235df7e3716b43329cc399d8bbcb.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RKgG9UgsTc3u0HgQPrLbW0tkmehydr1oI"
Subject: Re: [Qemu-devel] [PATCH v3 34/39] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RKgG9UgsTc3u0HgQPrLbW0tkmehydr1oI
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <a6f27964-111c-4f55-6539-d6426ee0f515@redhat.com>
Subject: Re: [PATCH v3 34/39] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
References: <cover.1516978645.git.berto@igalia.com>
 <b60b90709552235df7e3716b43329cc399d8bbcb.1516978645.git.berto@igalia.com>
In-Reply-To: <b60b90709552235df7e3716b43329cc399d8bbcb.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RKgG9UgsTc3u0HgQPrLbW0tkmehydr1oI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzb2ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Af38H/1WzT7KrvBLartFaYM+RSxDKjZLt/CpV
24XNhy6o7qYvYGEjpIRoa4a0J6aqkKygP810tmvy7jrKYe7Eka8hQr8KeO1uRj8Y
nVtkUAxGQzdTTFev+wnev8mDo4bdL9KR5hlNMtz1DbOW8vyuNthbJp9nEzFrJaG5
XPd8CBqx0Lxt4Hl9IVQCdSzXF3z9+o/L9mReNheAchzB+h9iF9M4KwOvbSYs1v8H
JrtifZ8orCEsPhJbYrFqUJGYUU9AvyQpvIoB5TrngBJEI50GrvGU2ABvWPWIWOSW
3Fnqvg/NXfbHXjxP6aYy617dXkGiMumjtNMqMrG0GpP6FGAvLdAp9gQ=
=mlX3
-----END PGP SIGNATURE-----

--RKgG9UgsTc3u0HgQPrLbW0tkmehydr1oI--
