Received: from eggs.gnu.org ([2001:4830:134:3::10]:36753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5yWM-0008FO-O9
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5yWL-0000wL-Ug
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:57:02 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-11-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ec3aa16b-3d3e-1927-6d8c-83c6f7a936dc@redhat.com>
Date: Wed, 3 May 2017 19:56:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-11-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9I1rKo8aNM2s74a7d4VVlT6WQcKbMjRnH"
Subject: Re: [Qemu-devel] [PATCH v10 10/17] qcow2: Assert that cluster
 operations are aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9I1rKo8aNM2s74a7d4VVlT6WQcKbMjRnH
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <ec3aa16b-3d3e-1927-6d8c-83c6f7a936dc@redhat.com>
Subject: Re: [PATCH v10 10/17] qcow2: Assert that cluster operations are
 aligned
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-11-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> We already audited (in commit 0c1bd469) that qcow2_discard_clusters()
> is only passed cluster-aligned start values; but we can further
> tighten the assertion that the only unaligned end value is at EOF.
>=20
> Recent commits have taken advantage of an unaligned tail cluster,
> for both discard and write zeroes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: rebase to context
> v9: rebase to master, by asserting that only tail cluster is unaligned
> v7, v8: only earlier half of series submitted for 2.9
> v6: avoid assertion on non-cluster-aligned image, use s->cluster_sector=
s
> to avoid a shift, drop R-b
> v5: no change
> v4: new patch
> ---
>  block/qcow2-cluster.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9I1rKo8aNM2s74a7d4VVlT6WQcKbMjRnH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKGeQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmkMH/i7L0vwhMWnjTuT5fbhLQTy1RpO5jYWu
F1dsn8idlonqmSfL5Zk8cnrfz3dK3bC282aEEReRiGKDQCLDFChzc6saun/qllm7
9k7gP2gLRL0NV9aSAzUCUuk0EFAACEKDqSKr9H4fyFkPxouztw0pHEocLrWILFFl
kQ1xHlZk58M0vVjX6luGoQG64yddreVMVf5deqzS+TE63MFynitFfqe1pju1ZjWf
mX6U/n0mOHRTDBc2w1JcQ4aZrfCbS+XI/BMtgyKfuqJFkRfHFk9jGIeo7R/9VLRH
CFbE4pFG+DOY572EyP24qCCMKG+2388yogwUOxkZje7MY0A1WZdzkZE=
=2EyW
-----END PGP SIGNATURE-----

--9I1rKo8aNM2s74a7d4VVlT6WQcKbMjRnH--
