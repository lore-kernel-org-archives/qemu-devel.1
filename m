Received: from eggs.gnu.org ([209.51.188.92]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzZe-000256-RZ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzZe-0006Fu-5z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:48:38 -0500
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-5-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ba0783f0-768f-e1bd-2d14-738640b0a167@redhat.com>
Date: Wed, 27 Feb 2019 13:32:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181214134240.217870-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J2vZashBWpK7Gx6xFpLkse491t38QvLiJ"
Subject: Re: [Qemu-devel] [PATCH v4 4/5] qcow2-refcount: check_refcounts_l2:
 don't count fixed cluster as allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J2vZashBWpK7Gx6xFpLkse491t38QvLiJ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <ba0783f0-768f-e1bd-2d14-738640b0a167@redhat.com>
Subject: Re: [PATCH v4 4/5] qcow2-refcount: check_refcounts_l2: don't count
 fixed cluster as allocated
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
 <20181214134240.217870-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.12.18 14:42, Vladimir Sementsov-Ogievskiy wrote:
> Do not count a cluster which is fixed to be ZERO as allocated.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--J2vZashBWpK7Gx6xFpLkse491t38QvLiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2g3oACgkQ9AfbAGHV
z0DNvQf8D/V/RwxmnXTubpCcuR0avcxLYFL8KNS+fHC5ONy1xFmefxMCgF2klDdC
aJrlZhD4GSMSeMkBmxGExULl6gyLIxFSVFH9OJVTyByqIMUqyGgMfOSESn//s1nC
KjP8k1uqm1fzc+KiOyVLGiQ0qoQAd3lUwo18RcVtebfAhMq79kwPkLdVqjY5H4Ly
fdARCqfFVp8uow5oRbDeIbetsB95m2a3P9T8KG0+eKDHYbNkQHhSgIykpZvZGTBx
ASEIsv3JNmu24GXpnTmkd31TujSxJEdcPJVSU99ZAaIeJdfyt5Si+EoHX4ccQU8C
rWuMVHZ1al636Nc2aeSvSdJB8+tN/Q==
=EfJD
-----END PGP SIGNATURE-----

--J2vZashBWpK7Gx6xFpLkse491t38QvLiJ--
