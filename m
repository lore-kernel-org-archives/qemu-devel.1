Received: from eggs.gnu.org ([2001:4830:134:3::10]:47880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRW-0000VI-NE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRW-0000Mp-2E
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:38 -0400
Date: Thu, 3 May 2018 11:34:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180503103433.GF5301@stefanha-x1.localdomain>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-8-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20180418030424.28980-8-famz@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/7] qemu-img: Convert with copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 11:04:24AM +0800, Fam Zheng wrote:
> The new blk_co_copy_range interface offers a more efficient way in the
> case of network based storage. Make use of it to allow faster convert
> operation.
>=20
> Since copy offloading cannot do zero detection ('-S') and compression
> (-c), only try it when these options are not used.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6uW5AAoJEJykq7OBq3PIoZMH+wU8EcRDR8OLx2fv3/mtpu7i
xbOfCSGXPbf2upTnH17RtXq0khianHTdZb/6Za+T1+MB0Ud9R6cm1fT12iMXv95x
sC6tD024gmP5P1aj6KYi/9FHkfLpfhKC1vMk+8G7GHo8YH2llz/i7uwWG2QmfzV8
pQBTFkKd1MyeOWna8lCOXmqs19ROUgabCT76nHLSyqkEjgneCLgw9ZOSbkv5hE56
zZwdYfvpBqqpf/q/LsrngqX7wk/dKNulFWto+bcz6kEYcSyGJ5eyc4CNhoyHOIFs
+KfRJ8axNwgS4/lezHWFja5DPEqvQL/rND5dFcPRmOPYXYf2fSCtqV0Cwre1EB8=
=8Pp8
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
