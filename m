Received: from eggs.gnu.org ([2001:4830:134:3::10]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1aJJ-00042n-2Z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1aJI-000301-5P
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:49:41 -0400
References: <20171009153856.20387-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c2d4119f-a3b1-3f2c-cd2c-401d2438a650@redhat.com>
Date: Mon, 9 Oct 2017 17:49:30 +0200
MIME-Version: 1.0
In-Reply-To: <20171009153856.20387-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pAcvdTX3JSQKNKHk9WB3vosjqdw9L3gTv"
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: Use BDRV_SECTOR_BITS instead of
 its literal value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pAcvdTX3JSQKNKHk9WB3vosjqdw9L3gTv
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <c2d4119f-a3b1-3f2c-cd2c-401d2438a650@redhat.com>
Subject: Re: [PATCH v2] qcow2: Use BDRV_SECTOR_BITS instead of its literal
 value
References: <20171009153856.20387-1-berto@igalia.com>
In-Reply-To: <20171009153856.20387-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 17:38, Alberto Garcia wrote:
> BDRV_SECTOR_BITS is defined to be 9 in block.h (and BDRV_SECTOR_SIZE
> is calculated from that), but there are still a couple of places where
> we are using the literal value instead of the macro.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--pAcvdTX3JSQKNKHk9WB3vosjqdw9L3gTv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnbmooSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYXkH+gLd/P9yDZGWI43EHN+7+SOxp1NoCUxj
S/JMfY2tfe8GTZ+uqtzdJVZMukzaO6j+r/mRBDeweMBQUyW08y4ZiJO928xOiRAA
veF4Z+5byAMV1l2TYqCy6LKyncxECSYSMYv/DqLZKBSGm3T4fmZWjjmdg2M/Uq/6
bsxyu5KTXQ1qK7HtpEXKH24CI9UNPhHUMRpzl0dgoRCXmXi/1TAvLnpdPyCBl6Ot
1ll40Ycq0h/3TXWnAk8jeHe+o4jWrIx7llnyhAwrkUA2DqAMHjFqwOXCP4GuCPXV
I2CCEPQ/Fhl2RPiWRIDUZMRUD32bIS5F7XooV6Alp8CvsXW6pR6coVQ=
=P6G5
-----END PGP SIGNATURE-----

--pAcvdTX3JSQKNKHk9WB3vosjqdw9L3gTv--
