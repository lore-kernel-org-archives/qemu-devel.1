Received: from eggs.gnu.org ([2001:4830:134:3::10]:57698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG7R-0000nG-5b
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG7Q-0000CY-7v
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:41:41 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <acddb6b0-a465-d3e2-ce49-8271df33d0c5@redhat.com>
Date: Fri, 10 Nov 2017 21:41:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ddtW3xexLoMLmR63JH5u7FKN2UU3Gtoeq"
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
--ddtW3xexLoMLmR63JH5u7FKN2UU3Gtoeq
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>
Message-ID: <acddb6b0-a465-d3e2-ce49-8271df33d0c5@redhat.com>
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

I see that Patchew complains, so let's try:

Based-on: <cover.1510143008.git.berto@igalia.com>

And let's see whether it can handle the recursive dependency...

(Letting Patchew base something on git branches would be nice O:-))


Also note my follow-up patch "qcow2: Repair unaligned preallocated zero
clusters" which fixes the TODO added in patch 2.

Max


--ddtW3xexLoMLmR63JH5u7FKN2UU3Gtoeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGDvcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANvgH/034AQE4tfP4Ukdes2E67eiqw/7jnznr
mG6amazeBSaMnmcTsSHTvhBsVtHrSTCdozZHoEvtggqrCzJATuGluyvFFuu7edVd
o81j5aOuAtOymq0ithaDbHcsN3zqGt/CdDyqc/HJoOeHMl9MP3sFNw+AYxwOfH0B
yyh06lDmVjLrN88rUtLwgdLivDSeHoL0vx3R3HPRtLZN/K5qZ5SLrejQtG4oaAtx
/0NztvXLmwhWMFIQuaiDTqIVnBbq5cV223UepYUaRqOUZNvr4qeBLqKPdgBl7stQ
oNYbDKTrSC4yGkWYPp/b6AkkR4Ek0eIx4kmdsuu+IHD7LpOgaiYu390=
=NnMc
-----END PGP SIGNATURE-----

--ddtW3xexLoMLmR63JH5u7FKN2UU3Gtoeq--
