Received: from eggs.gnu.org ([2001:4830:134:3::10]:57777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f8mer-0007xr-3E
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f8meq-0002LO-5i
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:57:57 -0400
References: <cover.1523968389.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7854480d-1c3f-b090-4327-9108fb3a8123@redhat.com>
Date: Wed, 18 Apr 2018 14:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1523968389.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Eu9ATMk9qDbBMGXZnH5ht2zr4qx9CV8Bz"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Give the refcount cache the minimum
 possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Eu9ATMk9qDbBMGXZnH5ht2zr4qx9CV8Bz
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <7854480d-1c3f-b090-4327-9108fb3a8123@redhat.com>
Subject: Re: [PATCH v3 0/2] Give the refcount cache the minimum possible size
 by default
References: <cover.1523968389.git.berto@igalia.com>
In-Reply-To: <cover.1523968389.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-17 14:37, Alberto Garcia wrote:
> Hi,
>=20
> we talked about this the other day, so here are the patches to change
> the default cache sizes in qcow2.
>=20
> Without this patch:
>=20
>  * refcount-cache-size =3D l2-cache-size / 4
>=20
> unless otherwise specified by the user. This is wasteful, the refcount
> cache is accessed sequentially during normal I/O, so there's no point
> in caching more tables. I measured the effect on the refcount cache
> size when populating an empty qcow2 image using random writes, and
> there's no difference between having the minimum or the maximum
> sizes(*).
>=20
> With this patch:
>=20
>  * refcount-cache-size is always 4 clusters by default (the minimum)
>=20
>  * If "cache-size" is set then l2-cache-size is set to the maximum if
>    possible (disk_size * 8 / cluster_size) and the remainder is
>    assigned to the refcount cache.
>=20
> Regards,
>=20
> Berto
>=20
> (*) there is, actually: having a very large cache can even make the
>     I/O slightly slower, because the larger the cache the longer it
>     takes longer to find a cached entry. I only noticed this under
>     tmpfs anyway.
>=20
> Changes:
> v3:
> - Mention that if you use internal snapshots you may want to increase
>   the cache size [Max]
>=20
> v2: https://lists.gnu.org/archive/html/qemu-block/2018-03/msg00822.html=

> - s/overriden/overridden/ (in both patches)
>=20
> v1: https://lists.gnu.org/archive/html/qemu-block/2018-03/msg00709.html=

> - Initial release
>=20
> Alberto Garcia (2):
>   qcow2: Give the refcount cache the minimum possible size by default
>   docs: Document the new default sizes of the qcow2 caches
>=20
>  block/qcow2.c              | 31 +++++++++++++++++++------------
>  block/qcow2.h              |  4 ----
>  docs/qcow2-cache.txt       | 33 ++++++++++++++++-----------------
>  tests/qemu-iotests/137.out |  2 +-
>  4 files changed, 36 insertions(+), 34 deletions(-)

Thanks, applied to my block-next branch:

https://github.com/XanClic/qemu/commits/block-next

Max


--Eu9ATMk9qDbBMGXZnH5ht2zr4qx9CV8Bz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrXQMoACgkQ9AfbAGHV
z0Cpqgf+P79yLGhRX3Fy59u3bH6hHiHhMbIuXIJ7GIg1PZmPlisURzLHANFgEswT
JJJfeQoA4/MXZTBtdHzPbpO+m9WxM/Y+vcMIITr0hIPtovGlVnJ8Qu+UBf9YMhuy
Xenjgdqi0R8QDokyfaC23Toh5ghWex0YthluZsnAfjdkTzJZecjeFv0lqrkKo2ub
eX3eFdjTuI64t78nqaWCAhJeoHADbTIY0Go3QiABz2/YRi3t/aSY9OE4wr7cICt4
AQMAdkUDzly8Oh+Zqpkyvx5vzh+MsvPSfDvZv8k6emosmdNLFe4FHZEnnrbyypCL
jteFp6h/legIiC7nBrAcFX0FNrzclA==
=gNzM
-----END PGP SIGNATURE-----

--Eu9ATMk9qDbBMGXZnH5ht2zr4qx9CV8Bz--
