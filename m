Received: from eggs.gnu.org ([2001:4830:134:3::10]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNc3z-0007I1-MV
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNc3z-0004R5-0k
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:41:11 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3d59455d-8b72-2d2a-a1f9-58481edd2c9a@redhat.com>
Date: Tue, 29 May 2018 12:40:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sop73Y3DJH5pJPATofQNzN9grJZK32Lpo"
Subject: Re: [Qemu-devel] [PATCH 02/14] vhdx: Fix vhdx_co_create() return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sop73Y3DJH5pJPATofQNzN9grJZK32Lpo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <3d59455d-8b72-2d2a-a1f9-58481edd2c9a@redhat.com>
Subject: Re: [PATCH 02/14] vhdx: Fix vhdx_co_create() return value
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-3-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> .bdrv_co_create() is supposed to return 0 on success, but vhdx could
> return a positive value instead. Fix this.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vhdx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sop73Y3DJH5pJPATofQNzN9grJZK32Lpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNLjsACgkQ9AfbAGHV
z0CIbAf/UPHb/jTl6hr2zd6ZWflG05csn0zTY6Y1Tj8LgAz04bCgJLOuliQR3jjm
s51YFjaaGtq8SGL9T9ua7rgNS5BrU3Kch2rEBuarnMNRrEIsIOCNy5IZT3tpEwIL
2vRW6fO04l3yo0vKotfckkqK10+wDvCJnmD/mLOCbGPaj+ZWHhBxuS9U6VIJIueJ
KDKs/KDglrnW0CqDh22K9L1Q/N7zIe5yarusm6xTstkyeLAWq4lvbCkBKH4sDENZ
6/V/tH+KSdUgk/6hbDIYSxSH+bo+k6cr0tiSr3R1WPOdTzgLZBac7gXic7JsKcBo
Pa48nWw9JdozreqhEqCwMJxoXBlDzg==
=dgHR
-----END PGP SIGNATURE-----

--sop73Y3DJH5pJPATofQNzN9grJZK32Lpo--
