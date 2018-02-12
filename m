Received: from eggs.gnu.org ([2001:4830:134:3::10]:54184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI6m-0000RS-EL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI6l-00071W-Mf
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:40 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-25-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <32d252a0-0d81-b672-a5c5-2ced50b9fd16@redhat.com>
Date: Mon, 12 Feb 2018 18:41:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-25-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="twL51DsdxANMGTSzmHWkSaHQDSx4g0gMu"
Subject: Re: [Qemu-devel] [PATCH 24/27] file-posix: Fix no-op
 bdrv_truncate() with falloc preallocation
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
--twL51DsdxANMGTSzmHWkSaHQDSx4g0gMu
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <32d252a0-0d81-b672-a5c5-2ced50b9fd16@redhat.com>
Subject: Re: [PATCH 24/27] file-posix: Fix no-op bdrv_truncate() with falloc
 preallocation
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-25-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-25-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> If bdrv_truncate() is called, but the requested size is the same as
> before, don't call posix_fallocate(), which returns -EINVAL for length
> zero and would therefore make bdrv_truncate() fail.
>=20
> The problem can be triggered by creating a zero-sized raw image with
> 'falloc' preallocation mode.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--twL51DsdxANMGTSzmHWkSaHQDSx4g0gMu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqB0ckSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcVgIAMHNGHFbG0DS9eDiDTyXV7fjfHmWOIHU
venr9xEJ5vTp2NI5r51Uyazxxz23/B57Pmd+cwBnFGxLccqeFMvhtLRjFHr/DlEu
2pr+Mqk+ioDWAa9YLxUThxargcC7+4ku8gLAl3CTl99LWYXHgD4xa0cL8yLAB39j
JGax3BEhnat82So/4Ry0ePbkkjqV+GmWYktC3bVKYaokeLOt3OIY2NUdEM0wlMjk
tWF0LlZu2nwjEk308n9yARVQyo6aV39rFW5SeYt/+o3o5YrOVzwE20xtiHEA25T9
pApZ0x8ImIPnkVhSh5J9PgktVr/dABLo0mJFmH/nb67WK9GnFuJdRa4=
=zufg
-----END PGP SIGNATURE-----

--twL51DsdxANMGTSzmHWkSaHQDSx4g0gMu--
