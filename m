Received: from eggs.gnu.org ([2001:4830:134:3::10]:57970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QLW-0004Ob-Uy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QLW-0007ZN-BQ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:20:38 -0400
Date: Fri, 20 Apr 2018 15:20:31 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420072031.GF15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-9-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 08/19] block: Remove
 bdrv_drain_recurse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 06:39:29PM +0200, Kevin Wolf wrote:
> For bdrv_drain(), recursively waiting for child node requests is
> pointless because we didn't quiesce their parents, so new requests could
> come in anyway. Letting the function work only on a single node makes it
> more consistent.
>=20
> For subtree drains and drain_all, we already have the recursion in
> bdrv_do_drained_begin(), so the extra recursion doesn't add anything
> either.
>=20
> Remove the useless code.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZS/AAoJEJykq7OBq3PIqTAH/AtLRQK/KiDTfd9zg89gW+N+
N23ILQgUAzHOfmU9YRQC5N9CF2yCoHSE2IhRAd4CtZ1XzUkRrRnwdu4GM+crnMOT
lMK8Ynsew60wu/9eh75hdX0ICr/8tpn7y4T4gZjYMmsSj92QKJ9brEDTZaO6jHqw
JrhylP1i20HJtZ2lf11jzoW80g8X05KcCfSJl3qYASAU65od9LtV4lVmircUE9g4
Ulj746rt6DQKdubbQILkmYh1l++nqHOTOyn0t7ZK0xobRUrYC1yk5NNzRietjIaX
9YCLP8ifsb2pDMCkT5SOzybScQRq1fi4Mt5+3HiQYc7EQKg0xWJ9TrIZp/TrwxE=
=0KYB
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
