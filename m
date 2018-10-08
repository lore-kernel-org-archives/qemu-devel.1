Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9K9v-0004fw-Lq
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9K9v-00019A-2s
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:16:31 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<27ece91df0fbe7528e01425e94992e46b71ff042.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0c3e96a9-9820-ec0d-55b5-8776180630a6@redhat.com>
Date: Mon, 8 Oct 2018 03:16:21 +0200
MIME-Version: 1.0
In-Reply-To: <27ece91df0fbe7528e01425e94992e46b71ff042.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uJa26T1kjKTOdq5MMhb68iMBlU7ThRg9i"
Subject: Re: [Qemu-devel] [PATCH 05/14] block: Use
 bdrv_reopen_set_read_only() in bdrv_commit()
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
--uJa26T1kjKTOdq5MMhb68iMBlU7ThRg9i
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <0c3e96a9-9820-ec0d-55b5-8776180630a6@redhat.com>
Subject: Re: [PATCH 05/14] block: Use bdrv_reopen_set_read_only() in
 bdrv_commit()
References: <cover.1537367701.git.berto@igalia.com>
 <27ece91df0fbe7528e01425e94992e46b71ff042.1537367701.git.berto@igalia.com>
In-Reply-To: <27ece91df0fbe7528e01425e94992e46b71ff042.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--uJa26T1kjKTOdq5MMhb68iMBlU7ThRg9i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6r+UACgkQ9AfbAGHV
z0A3KAf/UQZeLf5oa4BPFWTUEs1aYcgLtW+nJvd8jwNU1GJ/G37Vl9cg1q/STMW4
r7BvB04Vu4pv9Y8ep/UwONh2VnlWTGPsc6aGH8KOSfTKtGJ8YfO8Ky9PrU8MqIUg
mhJgC7AEtxeWgTE/L78dnW4Bw4uOicwmF6f8T07Y5r73TuZcn9zV3yGLt8FMs1ZK
2cF2+qwQ66Xjhwjjm28ssZSPzpdGk5jQfDLrGXqhZRRjO7SbAWv5Pj5n8orS/X00
UBC3kb+kM0ukBetDblQAn7zLTyjiFGWPjgY17ieBum4vGYQP4fXh9j0qaHQu11c6
al9O+J1t1GkXLs6F+ewJaZeWSz+gag==
=Avpm
-----END PGP SIGNATURE-----

--uJa26T1kjKTOdq5MMhb68iMBlU7ThRg9i--
