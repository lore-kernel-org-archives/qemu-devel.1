Received: from eggs.gnu.org ([2001:4830:134:3::10]:59801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiirQ-0000FY-4H
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiirP-0005tT-A1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:39:12 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<20fc0415bf0e011e29f6487ec86eb06a11f37445.1517840877.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cbfdef0c-f291-a35f-01b6-24e16b206888@redhat.com>
Date: Mon, 5 Feb 2018 16:38:58 +0100
MIME-Version: 1.0
In-Reply-To: <20fc0415bf0e011e29f6487ec86eb06a11f37445.1517840877.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OiIhLG6kpXdY51kX8TKItRtfararV9voZ"
Subject: Re: [Qemu-devel] [PATCH v4 17/39] qcow2: Update l2_allocate() to
 support L2 slices
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
--OiIhLG6kpXdY51kX8TKItRtfararV9voZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <cbfdef0c-f291-a35f-01b6-24e16b206888@redhat.com>
Subject: Re: [PATCH v4 17/39] qcow2: Update l2_allocate() to support L2 slices
References: <cover.1517840876.git.berto@igalia.com>
 <20fc0415bf0e011e29f6487ec86eb06a11f37445.1517840877.git.berto@igalia.com>
In-Reply-To: <20fc0415bf0e011e29f6487ec86eb06a11f37445.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 15:33, Alberto Garcia wrote:
> This patch updates l2_allocate() to support the qcow2 cache returning
> L2 slices instead of full L2 tables.
>=20
> The old code simply gets an L2 table from the cache and initializes it
> with zeroes or with the contents of an existing table. With a cache
> that returns slices instead of tables the idea remains the same, but
> the code must now iterate over all the slices that are contained in an
> L2 table.
>=20
> Since now we're operating with slices the function can no longer
> return the newly-allocated table, so it's up to the caller to retrieve
> the appropriate L2 slice after calling l2_allocate() (note that with
> this patch the caller is still loading full L2 tables, but we'll deal
> with that in a separate patch).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 56 +++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 34 insertions(+), 22 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--OiIhLG6kpXdY51kX8TKItRtfararV9voZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp4epISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvmgH+QHG7nzsm6OXb/8VihXvlRPvXuL4fHTk
f5+NRnmNb+ddVZGh6l6GovYXoqLowSqRffGzVN6DF4zTmg6Ls/ngxh7ipE0ujbRN
X9xas1RRIOEg5TqUphdubOgbD5KuHDBRagyYIxWZyk+d591QFB+LfQsMVmg+T8/5
NuF6ydmELSli87/Kb2/mnOKRgR9PQWkVuBHsDVFKNznxbUBzdNI2DG3JCn5seIP/
O8YpOaFwac4V2PpG35tGyMMhwBezfCuDXRWp6ynZLxQqaPVQvHsv1L8lxz1yUoGD
RRBTWIjOs0Lsdg3+5UbqLIgRAYYKH6upzS0A8fGRFy4ge1AT+G68S6s=
=l8yg
-----END PGP SIGNATURE-----

--OiIhLG6kpXdY51kX8TKItRtfararV9voZ--
