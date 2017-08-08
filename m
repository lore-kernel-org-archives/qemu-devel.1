Received: from eggs.gnu.org ([2001:4830:134:3::10]:34235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Cs-00015b-WE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Cq-0005Hn-Dx
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:53:47 -0400
Date: Tue, 8 Aug 2017 10:53:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808095339.GA16801@stefanha-x1.localdomain>
References: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block/nfs: fix mutex
 assertion in nfs_file_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pl@kamp.de, qemu-block@nongnu.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 06:29:09PM -0400, Jeff Cody wrote:
> Commit c096358e747e88fc7364e40e3c354ee0bb683960 introduced assertion
> checks for when qemu_mutex() functions are called without the
> corresponding qemu_mutex_init() having initialized the mutex.
>=20
> This uncovered a latent bug in qemu's nfs driver - in
> nfs_client_close(), the NFSClient structure is overwritten with zeros,
> prior to the mutex being destroyed.
>=20
> Go ahead and destroy the mutex in nfs_client_close(), and change where
> we call qemu_mutex_init() so that it is correctly balanced.
>=20
> There are also a couple of memory leaks obscured by the memset, so this
> fixes those as well.
>=20
> Finally, we should be able to get rid of the memset(), as it isn't
> necessary.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/nfs.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiYojAAoJEJykq7OBq3PI850H/1n0dN64H1Y298AwTpJY+m/8
ji/xpgpHOVwST+sS+nfrL73/fKTq04gvSD0Ku/3QNWJViXQe3KbjUs4Aj/XrldaT
S1erLwnBFSZkgHwCWCiOG+9+iuoOR5PO2pkD9eDbKBu+8zfJRtzxHURkmdJciqYy
/tW2egwEXQwZ0o/2B0nUwVssIGT788O7T211tScOI9tHo8BZE38iCHe6JGyTEMVS
iPaTWUvNorFxJrmBVDzpwMVfbpy9ZpshdgehkRMPwhJLdGrSknCA9dZY6eILhbXP
c3NAwPEYySi19bbbIpt9TbpN9CjDi6VRiyCmgRmDoUbKxmtkVMUm/AbcUHYZmB0=
=BRUZ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
