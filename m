Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxkT-0008Tc-FZ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxgz-0004O1-Ls
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:27:18 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<32606f818dfcc21e2e503852b63f248cafb92871.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <118efdba-a5f2-faaa-dbfb-8b400252b02d@redhat.com>
Date: Wed, 29 Aug 2018 12:27:10 +0200
MIME-Version: 1.0
In-Reply-To: <32606f818dfcc21e2e503852b63f248cafb92871.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9Pp7epSbkVkQ9IDpVtaEpU8JHZsvHx64T"
Subject: Re: [Qemu-devel] [PATCH 2/9] file-posix: x-check-cache-dropped
 should default to false on reopen
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
--9Pp7epSbkVkQ9IDpVtaEpU8JHZsvHx64T
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <118efdba-a5f2-faaa-dbfb-8b400252b02d@redhat.com>
Subject: Re: [PATCH 2/9] file-posix: x-check-cache-dropped should default to
 false on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <32606f818dfcc21e2e503852b63f248cafb92871.1535291602.git.berto@igalia.com>
In-Reply-To: <32606f818dfcc21e2e503852b63f248cafb92871.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> The default value of x-check-cache-dropped is false. There's no reason
> to use the previous value as a default in raw_reopen_prepare() because
> bdrv_reopen_queue_child() already takes care of putting the old
> options in the BDRVReopenState.options QDict.

Well, the reason would be because one might want to retain unspecified
values as they were set before.  But we decided we don't want to do that.=


> If x-check-cache-dropped was previously set but is now missing from
> the reopen QDict then it should be reset to false.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

So:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9Pp7epSbkVkQ9IDpVtaEpU8JHZsvHx64T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGdP8ACgkQ9AfbAGHV
z0B51gf/cIGyODRSj90iJuob6cuh5t5iHGs9LMhVuzW0Yo6j8EzVXcwhx3VX2V+n
3fbqLQPbW0NmODjD2Wdl1cX1igwkgaLQ3yhKKkuLkzZRT8yU+gdoalhofcb/bs2l
7ymKFH+Cr8aQWJqTcwQ3zlMkxbsVPWcqEfGLEwRDTPRw3JCHphvMmiaURxQEBqj5
F5qPkMQq5bIKjD+lbTDBTERz1m7p4xltCu+mrOMCS0K4z4zGhwZNr2Sepln7TZEE
wfDhNrqBH0BkwqVxYf/XyxN4kFkZcRmAGLUXD+vD99cYdWch1c4yyf28ng8pvTYQ
DolwIjg0hdGxDZq5GqQuwA3fZm4Kmw==
=N2RH
-----END PGP SIGNATURE-----

--9Pp7epSbkVkQ9IDpVtaEpU8JHZsvHx64T--
