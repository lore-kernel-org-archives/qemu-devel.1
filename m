Received: from eggs.gnu.org ([2001:4830:134:3::10]:56859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF4FK-0006rO-2S
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF4FI-0004Eh-Lx
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:25:17 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <947c8174-c559-962d-4c3d-de08ecafe332@redhat.com>
Date: Wed, 15 Nov 2017 21:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kj20FGkhLdb0F0FcCvQjkfrdARRkSQjnF"
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/5] qcow2: Fixes for corrupted
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kj20FGkhLdb0F0FcCvQjkfrdARRkSQjnF
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>
Message-ID: <947c8174-c559-962d-4c3d-de08ecafe332@redhat.com>
Subject: Re: [PATCH for-2.11 0/5] qcow2: Fixes for corrupted images
References: <20171110203111.7666-1-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 21:31, Max Reitz wrote:
> This series contains fixes for another batch of qcow2-related crashes
> reported on Launchpad by Nageswara (the first batch was
> http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00082.html b=
y
> Berto).
>=20
> Patch 4 fixes an out-of-bounds array access in memory which is not
> really a security issue for multiple reasons (really, at most you can
> read eight bytes from somewhere with an extremely high chance of
> crashing qemu and requiring the user to invoke a block_resize shrinking=

> the qcow2 image (and also reset some bit in the image from 1 to 0, but
> only if the overlap checks don't catch you)), but most importantly that=

> code hasn't been in 2.10, so we're fine.
>=20
>=20
> Max Reitz (5):
>   qcow2: check_errors are fatal
>   qcow2: Unaligned zero cluster in handle_alloc()
>   block: Guard against NULL bs->drv
>   qcow2: Add bounds check to get_refblock_offset()
>   qcow2: Refuse to get unaligned offsets from cache
>=20
>  block/qcow2.h              |   6 ---
>  block.c                    |  19 ++++++-
>  block/io.c                 |  36 +++++++++++++
>  block/qapi.c               |   8 ++-
>  block/qcow2-cache.c        |  21 ++++++++
>  block/qcow2-cluster.c      |  13 ++++-
>  block/qcow2-refcount.c     |  26 +++++++++-
>  block/qcow2.c              |   5 +-
>  block/replication.c        |  15 ++++++
>  block/vvfat.c              |   2 +-
>  tests/qemu-iotests/060     | 125 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/060.out | 115 +++++++++++++++++++++++++++++++++++++=
++++
>  12 files changed, 379 insertions(+), 12 deletions(-)

Applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--kj20FGkhLdb0F0FcCvQjkfrdARRkSQjnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMoqASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6rUIAMD5w0ir/o5ZWohdPFpi0CY2Kf5TjN04
zCEUXbsNB+s8qkwTjctnxIB42LjV04pYWbmWBrUijDIvP8DmMZJ42SNc6/SsUR9F
bzHKO/MIT1XLbGyXEcvZu5iz2Yjp6ZyJHfCegHVTlH2ZaJmDpETHYCJ7xVjnHpS8
pEF81RLdb/LYST0LBjYznm5EsScXLE94WoaG1dFt/4cmpDhiFtDJpJuBK54zLP9N
llRO0Os6ifyfRikg9Pggy0hlCLigshlK4XzsbPYa3rgvbOklgV4Z9bcvXtXNiuJE
mVEDSSzncMEgyKs4r6yxSnH+ZdpksoKUB/SgZZtINcyYa5eCUgjYTIU=
=+fd3
-----END PGP SIGNATURE-----

--kj20FGkhLdb0F0FcCvQjkfrdARRkSQjnF--
