Received: from eggs.gnu.org ([2001:4830:134:3::10]:54601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyUZ-00023U-7p
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyUX-0007Hx-Da
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:56:23 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<ae713f0e51ce2be7fd837a384eecf20a92720be5.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ec986c21-d897-a049-1966-db3f6dbf71b8@redhat.com>
Date: Wed, 31 Jan 2018 20:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <ae713f0e51ce2be7fd837a384eecf20a92720be5.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DqLHqIUSgOZh0dcdymLtmnrpABM769vnC"
Subject: Re: [Qemu-devel] [PATCH v3 15/39] qcow2: Update l2_load() to
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
--DqLHqIUSgOZh0dcdymLtmnrpABM769vnC
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <ec986c21-d897-a049-1966-db3f6dbf71b8@redhat.com>
Subject: Re: [PATCH v3 15/39] qcow2: Update l2_load() to support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <ae713f0e51ce2be7fd837a384eecf20a92720be5.1516978645.git.berto@igalia.com>
In-Reply-To: <ae713f0e51ce2be7fd837a384eecf20a92720be5.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> Each entry in the qcow2 L2 cache stores a full L2 table (which uses a
> complete cluster in the qcow2 image). A cluster is usually too large
> to be used efficiently as the size for a cache entry, so we want to
> decouple both values by allowing smaller cache entries. Therefore the
> qcow2 L2 cache will no longer return full L2 tables but slices
> instead.
>=20
> This patch updates l2_load() so it can handle L2 slices correctly.
> Apart from the offset of the L2 table (which we already had) we also
> need the guest offset in order to calculate which one of the slices
> we need.
>=20
> An L2 slice has currently the same size as an L2 table (one cluster),
> so for now this function will load exactly the same data as before.
>=20
> This patch also removes a stale comment about the return value being
> a pointer to the L2 table. This function returns an error code since
> 55c17e9821c474d5fcdebdc82ed2fc096777d611.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--DqLHqIUSgOZh0dcdymLtmnrpABM769vnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyH1sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZasIAK9ajbXK5iGmOxyFyOfoRTtTAtXerBjw
6Gr3XaIYS850F0GQGVZ/qBvV5iFB8eZ/ggL1WwHtCffzqahOwB2RYfaGwrGa4zu5
QeLn0wF5EL1UvMBO7JdhKCoT6x05BWFbbZ3Z5ulrWZ+/3V6W6klKH7YZnBrf+orm
Ufjb6bLIfEwrXyk38uO/3NPQlWVnQzzcIT22UkCUNFu2uZXyu4OxxP1XQ+7/xYyS
46zZnvac5XheeB7t2pEzA6xGCG+YbIOJqNu49E1zic41llkkhrXS0w4Z1BWnS5l7
TMQ2uxZIo2S/SpRAsr/kF89HJJy0j+yeDe+w8faT/zTl0pNnLGUThHc=
=qdX0
-----END PGP SIGNATURE-----

--DqLHqIUSgOZh0dcdymLtmnrpABM769vnC--
