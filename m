Received: from eggs.gnu.org ([2001:4830:134:3::10]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egymM-000283-VL
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egymM-0002C4-2k
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:14:46 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <36b4f1c1-3e19-d428-f91a-5466a2117d95@redhat.com>
Date: Wed, 31 Jan 2018 21:14:35 +0100
MIME-Version: 1.0
In-Reply-To: <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w5ZCXzdA5eJnIqmT8jqgfDn1gLAL3LFPV"
Subject: Re: [Qemu-devel] [PATCH v3 19/39] qcow2: Update get_cluster_table()
 to support L2 slices
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
--w5ZCXzdA5eJnIqmT8jqgfDn1gLAL3LFPV
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <36b4f1c1-3e19-d428-f91a-5466a2117d95@redhat.com>
Subject: Re: [PATCH v3 19/39] qcow2: Update get_cluster_table() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
In-Reply-To: <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This patch updates get_cluster_table() to return L2 slices instead of
> full L2 tables.
>=20
> The code itself needs almost no changes, it only needs to call
> offset_to_l2_slice_index() instead of offset_to_l2_index(). This patch
> also renames all the relevant variables and the documentation.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--w5ZCXzdA5eJnIqmT8jqgfDn1gLAL3LFPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyI6wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9An5EH/RuurgDwzfGrZFuwJbpkRpPL45RNddWg
sl3mUK/gRoE2rEj3lPL5LGiWKgGrpJ0hUJ4rQwBIoJbXetSe1HJ3h6xnjo+PTIwN
WGYv0H2hoyYYHVf0mLE5b9WCsLmDpzNlhfbuZd/ETUOZJSVz4aCe2IytwP1RyJ3O
4DDFMORij0qSQuu4jOY1q0z4kuC5PLdIb+/F3UUjsvlZxY7I1bEEl/q4hiL5SU2n
8ggvoOv+P33iwzVHtwaBaq7jlS66hNlxaSVYoOKAEOhsWd8Q8ZH4EKjCkRP/tyLw
LYsj4hsF/qesgDWRWk9dZKs08EgbGoAhfaFuT49FyJYnPD+qA2IWETc=
=tQ+I
-----END PGP SIGNATURE-----

--w5ZCXzdA5eJnIqmT8jqgfDn1gLAL3LFPV--
