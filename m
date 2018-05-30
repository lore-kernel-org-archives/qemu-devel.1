Received: from eggs.gnu.org ([2001:4830:134:3::10]:56247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNzpZ-0005VL-Vk
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNzpZ-00062r-68
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:03:53 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-2-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a06c8a4a-9de1-cee9-f083-40e1e506d041@redhat.com>
Date: Wed, 30 May 2018 14:03:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-2-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l4Eq2G1D6uQpDXHNZzja3ZZT4FUxd63wJ"
Subject: Re: [Qemu-devel] [PATCH 01/17] block: iterate_format with account
 of whitelisting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l4Eq2G1D6uQpDXHNZzja3ZZT4FUxd63wJ
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <a06c8a4a-9de1-cee9-f083-40e1e506d041@redhat.com>
Subject: Re: [PATCH 01/17] block: iterate_format with account of whitelisting
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-2-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-2-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> bdrv_iterate_format (which is currently only used for printing out the
> formats supported by the block layer) doesn't take format whitelisting
> into account.
>=20
> As a result, QEMU lies when asked for the list of block drivers it
> supports with "-drive format=3D?": some of the formats there may be
> recognized by qemu-* tools but unusable in qemu proper.
>=20
> To avoid that, exclude formats that are not whitelisted from
> enumeration, if whitelisting is in use.  Since we have separate
> whitelists for r/w and r/o, take this as a parameter to
> bdrv_iterate_format, and print two lists of supported formats (r/w and
> r/o) in main qemu.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  include/block/block.h |  2 +-
>  block.c               | 23 +++++++++++++++++++----
>  blockdev.c            |  4 +++-
>  qemu-img.c            |  2 +-
>  4 files changed, 24 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--l4Eq2G1D6uQpDXHNZzja3ZZT4FUxd63wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOkxkACgkQ9AfbAGHV
z0CAQgf+OO0I7BHez3wuWu+7wc845t+iAy9nzTONbvbq33tMmto5uz79HqrV0jEi
4lxAoFCP+lCRS7v3U42IZkJyveecQYu4G7Yt+t59UAQmrNLV+rC5ea1a8K1P5brg
bm5OT6De08jU+en1JPyLyrm1Ux3o3SEi0JcG0bvygiKePBdWjBCcKRaKwWBPBzUl
/181J5BhIqdwoY/Xm1Q3XZ2u7EEM5YwVs5mzetlr+OfyY4IKEbGORhfSBpfPBYNC
l9B4tPKSX69ipDF6Q3lLkxJ4rxWkzr3N1eF+Oci6+04SgLWxXkm//nrZLqGCYwSd
F47D11bTTId8WuCtQRjCUQNwAVKmEA==
=3RXj
-----END PGP SIGNATURE-----

--l4Eq2G1D6uQpDXHNZzja3ZZT4FUxd63wJ--
