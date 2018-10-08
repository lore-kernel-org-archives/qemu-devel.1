Received: from eggs.gnu.org ([2001:4830:134:3::10]:39913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9K0d-0007nu-Ap
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Jsp-0004dl-1N
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 20:58:55 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<fd17cf9069d624e3a0b55ee3ba037830c23c60be.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <92f42cf4-14c8-28ab-f505-380670426060@redhat.com>
Date: Mon, 8 Oct 2018 02:58:28 +0200
MIME-Version: 1.0
In-Reply-To: <fd17cf9069d624e3a0b55ee3ba037830c23c60be.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P9kykwczRswi5cY4sEexkPiZWKpt0KMag"
Subject: Re: [Qemu-devel] [PATCH 03/14] block: Use
 bdrv_reopen_set_read_only() in bdrv_backing_update_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P9kykwczRswi5cY4sEexkPiZWKpt0KMag
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <92f42cf4-14c8-28ab-f505-380670426060@redhat.com>
Subject: Re: [PATCH 03/14] block: Use bdrv_reopen_set_read_only() in
 bdrv_backing_update_filename()
References: <cover.1537367701.git.berto@igalia.com>
 <fd17cf9069d624e3a0b55ee3ba037830c23c60be.1537367701.git.berto@igalia.com>
In-Reply-To: <fd17cf9069d624e3a0b55ee3ba037830c23c60be.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--P9kykwczRswi5cY4sEexkPiZWKpt0KMag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6q7QACgkQ9AfbAGHV
z0AJpQgAwM9pbPsNw3eCF9O2BNDKiqk/EH6Zl5IaSxu4+yF0RuqIOtH107USyLq7
lxonQu+3l/aMB6VtURCNwAHc2pf8zA0nVTY+c/KXsvyT64Fhm36f5gKVRZhYUtbO
3DLyPZyfLGCdr0Gj+Z9cd/LB2A57y1uaDXFrTy6w/aEoO1TZTN21mWr8vDiOME91
M1YyxhpnKIiqdo4wEuHkDmsME7yUZcleWrq1UVgvf5pTAYIDsppxgIugQT+f+Qn0
sSut3ZOWjsFWoadnINYyWxqcjNOzTX6EA8IzUb/DT0lObRhRCSbP7+izhH+0hRGy
XYToK/pKmNOtKHd/9flkse4Ox/lydg==
=+gZe
-----END PGP SIGNATURE-----

--P9kykwczRswi5cY4sEexkPiZWKpt0KMag--
