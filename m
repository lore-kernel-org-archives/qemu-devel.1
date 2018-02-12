Received: from eggs.gnu.org ([2001:4830:134:3::10]:55565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elEaP-0003RD-Q7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elEaO-000800-SB
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:56:01 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-13-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9075460-c910-2c80-2ab9-a9c81f2119dd@redhat.com>
Date: Mon, 12 Feb 2018 14:55:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-13-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rzaf2BPdDnTXWABn13xenyR89eH3NZCRE"
Subject: Re: [Qemu-devel] [PATCH 12/27] file-posix: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rzaf2BPdDnTXWABn13xenyR89eH3NZCRE
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <b9075460-c910-2c80-2ab9-a9c81f2119dd@redhat.com>
Subject: Re: [PATCH 12/27] file-posix: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-13-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to file, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 20 +++++++++++++-
>  block/file-posix.c   | 77 +++++++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 74 insertions(+), 23 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Rzaf2BPdDnTXWABn13xenyR89eH3NZCRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBnOYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARxMIALYfd/jl1yW5iT8DhPRDUZA3rukv8Ibp
ULJHQnZkjSi66VBtHygbQ8viwt9yD1cfO5UzH9hQ+SemK4W09Sot3wyiLsRgw6fF
XNlSQzqjywEQO7Yd8yYclndMA8TmHhtOINPY8INKNr9ykhPyuHLF55M8isoYi609
37660quD4elBOh5V5cBxlIORQlDzSMdZ0jrPte5xGg6Yb2kzk2nrCuuuIPhNjEQI
RD+35oYEfY2ZgM3mbm+FF4oqf3Q0GlM3Jingj146/60kU7gd9GBl0D4oWIJ229mj
QN0Q7nB9sb3FqEH7uXUMRH8bU7bSfSQoedvQEkvvSX5AUJz/HhJM1N8=
=qUGs
-----END PGP SIGNATURE-----

--Rzaf2BPdDnTXWABn13xenyR89eH3NZCRE--
