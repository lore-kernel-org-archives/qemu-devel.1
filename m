Received: from eggs.gnu.org ([2001:4830:134:3::10]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RUI-0003ua-BV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RUH-0000bM-Ll
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:33:46 -0400
Date: Fri, 20 Apr 2018 16:33:35 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420083335.GM15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 06:58:43PM +0200, Max Reitz wrote:
> This flag signifies that a write request will not change the visible
> disk content.  With this flag set, it is sufficient to have the
> BLK_PERM_WRITE_UNCHANGED permission instead of BLK_PERM_WRITE.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h | 6 +++++-
>  block/io.c            | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2aXfAAoJEJykq7OBq3PI1GMIALg4Kuzt/9S/DoWrU5zFl6Da
Gyy744uMS4//p9qp60bbm392HN6wSHFbe+n8JvGRsUjH6ZxcwDvCdKwbmqE1dNxS
jc1ceTlqpcg9YTEwGzqLDu3PE2kUm5wsSiyp8x+hrnrzjWJom4FKp9ApIzhKAt24
irNoQHC7aortGdCYpaK1b639NDJJPHpEHMYJe3AST1HA6dGRUCkPJOjVLVXuBfnu
c/NMM371XrubX8P14/uwsda0j3+8n2Mdp3RG0kbqxvWmieeUKFdirMKlzpNjE4G9
NjQfVnInK2DpMj3qnyxChVF0lV4z4f1Zk12uxjdt4kESEBh8rRhbK5m971IR1+Q=
=bkjE
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--
