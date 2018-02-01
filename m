Received: from eggs.gnu.org ([208.118.235.92]:52429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKpC-0000Wn-AO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKo8-0001Ny-Bp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:47:10 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ccc31d74-4cf5-080c-0ea8-152d47fb5622@redhat.com>
Date: Thu, 1 Feb 2018 20:44:49 +0100
MIME-Version: 1.0
In-Reply-To: <7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dozdPuIuqbEFKdX0HkuanuFWZpiNuqcf2"
Subject: Re: [Qemu-devel] [PATCH v3 30/39] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
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
--dozdPuIuqbEFKdX0HkuanuFWZpiNuqcf2
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <ccc31d74-4cf5-080c-0ea8-152d47fb5622@redhat.com>
Subject: Re: [PATCH v3 30/39] qcow2: Update expand_zero_clusters_in_l1() to
 support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
In-Reply-To: <7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> expand_zero_clusters_in_l1() expands zero clusters as a necessary step
> to downgrade qcow2 images to a version that doesn't support metadata
> zero clusters. This function takes an L1 table (which may or may not
> be active) and iterates over all its L2 tables looking for zero
> clusters.
>=20
> Since we'll be loading L2 slices instead of full tables we need to add
> an extra loop that iterates over all slices of each L2 table, and we
> should also use the slice size when allocating the buffer used when
> the L1 table is not active.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Finally, and since we have to touch the bdrv_read() / bdrv_write()
> calls anyway, this patch takes the opportunity to replace them with
> the byte-based bdrv_pread() / bdrv_pwrite().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 52 ++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 29 insertions(+), 23 deletions(-)

Aside from the void * casts (and slice_size2 *cough* *cough*):

Reviewed-by: Max Reitz <mreitz@redhat.com>


--dozdPuIuqbEFKdX0HkuanuFWZpiNuqcf2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzbjESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6XwH/3YpLdQzIXIRia5e0qEjvw1oTHh2FBCh
+1kUBxF2hanCg08IYha51P3vEq8q1gRMln9PWvSOrtXj2oiPWF2R3F+ghbAX7bNY
VQPhsg2LSAnhMVZVHgMtpLB/1bZY7zIsrGvu/i2SSrf9j1Ix6aPMrFXxk8E4VZSl
0lM64JtCHhEKQA+6D4iaKdKizJzO2uRhdHc4yLT4adiv347RsK4QRUb3pDqFHPXj
3428Xx2Wz2OzbY7VSvQA5bksfil1jc9gMmWg7u/zwsjSSHBlp3McqWxIvINJGRMl
6QQZctLPtbE6odRwerJorSL2oZRWGqsQl6xaUm4aTsI73TFoi9kSkpE=
=uE/i
-----END PGP SIGNATURE-----

--dozdPuIuqbEFKdX0HkuanuFWZpiNuqcf2--
