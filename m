Received: from eggs.gnu.org ([2001:4830:134:3::10]:44909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9KWJ-0000ZM-DC
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9KJc-0006Vi-4P
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:26:33 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<f68a21f152eef2c51361539bdc6c8f5eefe6af61.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3e51a563-5793-8a07-f8d8-61eba631dd14@redhat.com>
Date: Mon, 8 Oct 2018 03:26:15 +0200
MIME-Version: 1.0
In-Reply-To: <f68a21f152eef2c51361539bdc6c8f5eefe6af61.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PpKiekmHoFETUiJdwK5tdfYZXu6v1OMNN"
Subject: Re: [Qemu-devel] [PATCH 07/14] block: Use
 bdrv_reopen_set_read_only() in qmp_change_backing_file()
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
--PpKiekmHoFETUiJdwK5tdfYZXu6v1OMNN
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3e51a563-5793-8a07-f8d8-61eba631dd14@redhat.com>
Subject: Re: [PATCH 07/14] block: Use bdrv_reopen_set_read_only() in
 qmp_change_backing_file()
References: <cover.1537367701.git.berto@igalia.com>
 <f68a21f152eef2c51361539bdc6c8f5eefe6af61.1537367701.git.berto@igalia.com>
In-Reply-To: <f68a21f152eef2c51361539bdc6c8f5eefe6af61.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  blockdev.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--PpKiekmHoFETUiJdwK5tdfYZXu6v1OMNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6sjcACgkQ9AfbAGHV
z0BSbQf+PL86DmH+kjk1nWq624RYT2FgcsG2vm9B4sUVrQKOC5B+9jGbf1Pcr8b3
lEz9VdJr2thoKDzt2MzatD7uVWkDXPESsYYXXzA2ltpB6Yd8qMMkWleWBw7zxpvt
kuwpy4D4me4wLilLJoIJyTKVdeWmzsYfu9FuauTl3wFRGu3UV3fatdRG1Ssx0Kji
Ayl5AZYih3J5MndoEOaasRP1K7l8AOdxqStKLUvK0BduEQ3BNfVbft8Q/VWkCMNo
XM9/koi1g5nNoG+392AU4dk4jbLdQukONOtgbACIFWv9T6X9Cz3e82N7UtQxrcOV
BpvAbn5Zw2rNAinirEG66sj2ky7XBw==
=paYl
-----END PGP SIGNATURE-----

--PpKiekmHoFETUiJdwK5tdfYZXu6v1OMNN--
