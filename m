Received: from eggs.gnu.org ([208.118.235.92]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehOby-0004Js-PS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehOau-0001mv-Ns
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:49:46 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef6ce6f7-954f-7c88-0885-9258adaf94b4@redhat.com>
Date: Thu, 1 Feb 2018 21:04:06 +0100
MIME-Version: 1.0
In-Reply-To: <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3I1uPoBchuRU2RvoZ6WAZ67BzQdPXFDgw"
Subject: Re: [Qemu-devel] [PATCH v3 36/39] qcow2: Allow configuring the L2
 slice size
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
--3I1uPoBchuRU2RvoZ6WAZ67BzQdPXFDgw
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <ef6ce6f7-954f-7c88-0885-9258adaf94b4@redhat.com>
Subject: Re: [PATCH v3 36/39] qcow2: Allow configuring the L2 slice size
References: <cover.1516978645.git.berto@igalia.com>
 <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
In-Reply-To: <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> Now that the code is ready to handle L2 slices we can finally add an
> option to allow configuring their size.
>=20
> An L2 slice is the portion of an L2 table that is read by the qcow2
> cache. Until now the cache was always reading full L2 tables, and
> since the L2 table size is equal to the cluster size this was not very
> efficient with large clusters. Here's a more detailed explanation of
> why it makes sense to have smaller cache entries in order to load L2
> data:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html
>=20
> This patch introduces a new command-line option to the qcow2 driver
> named l2-cache-entry-size (cf. l2-cache-size). The cache entry size
> has the same restrictions as the cluster size: it must be a power of
> two and it has the same range of allowed values, with the additional
> requirement that it must not be larger than the cluster size.
>=20
> The L2 cache entry size (L2 slice size) remains equal to the cluster
> size for now by default, so this feature must be explicitly enabled.
> Although my tests show that 4KB slices consistently improve
> performance and give the best results, let's wait and make more tests
> with different cluster sizes before deciding on an optimal default.
>=20
> Now that the cache entry size is not necessarily equal to the cluster
> size we need to reflect that in the MIN_L2_CACHE_SIZE documentation.
> That minimum value is a requirement of the COW algorithm: we need to
> read two L2 slices (and not two L2 tables) in order to do COW, see
> l2_allocate() for the actual code.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c  | 10 ++++++++--
>  block/qcow2.c        | 34 +++++++++++++++++++++++++++-------
>  block/qcow2.h        |  6 ++++--
>  qapi/block-core.json |  6 ++++++
>  4 files changed, 45 insertions(+), 11 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--3I1uPoBchuRU2RvoZ6WAZ67BzQdPXFDgw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzcrYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AG+4H/11diP7oesV+aDgG9zMWc70YY4nmpRzw
KdwimZb9UR5sHo+DG9aVT6aCThfGxW66Tsifaf57MF2A8oeEu9oOQthKianVSPFb
gnWguDDEsK1bg7caaB5d2YeD+eTSIIVqIr/6yQeN4YRe4kDI20GQALQWPZbrVoO5
XLD8VISjf7A2riQeK/cgKBM5agA2LZgTqrchdbOven2pFd3XcupusnpVdHIvb6le
CBNPYyjMP6eU1nuNdPLEbZGBAcGFGRTjAodstY9CXjumQfcWfOVUdtJ1W1nYFkEA
aobEkgqKn9R8KySbeKM79/YCkq43+9Z3kVl+Tv+VntIV0muuqOyP0KE=
=mMZQ
-----END PGP SIGNATURE-----

--3I1uPoBchuRU2RvoZ6WAZ67BzQdPXFDgw--
