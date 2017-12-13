Received: from eggs.gnu.org ([2001:4830:134:3::10]:34994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4F6-0000Na-E3
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4F5-00040O-HA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:26:24 -0500
Date: Wed, 13 Dec 2017 10:26:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213102614.GF16782@stefanha-x1.localdomain>
References: <20171212134800.21836-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <20171212134800.21836-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Don't acquire
 AioContext in hmp_qemu_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 02:48:00PM +0100, Kevin Wolf wrote:
> Commit 15afd94a047 added code to acquire and release the AioContext in
> qemuio_command(). This means that the lock is taken twice now in the
> call path from hmp_qemu_io(). This causes BDRV_POLL_WHILE() to hang for
> any requests issued to nodes in a non-mainloop AioContext.
>=20
> Dropping the first locking from hmp_qemu_io() fixes the problem.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hmp.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMQBGAAoJEJykq7OBq3PIaTgH/ArXs4NSx8MtUnXf0uQqAPw5
O1H1lJskdSfPaf6g6B+nmbGE/8dp75WYAPvy0hFHLmmrNFIcTbhU4ox3RzLuvb6Z
1CuxjodHN3l9q4JJGBEr/S2Sm7u60a1qmPJvVuDKLnlYIWlZE7TxErZLE6VYr9nA
Q8yRQjHvG6j8r/A1OHVHK4ibR7hcYvREy1AIg47yt8dYBCDdFQxXwPWxbAFqqZk9
Szvz5Yfdi+TN/NDrqsnaYQ6MEComGBSV54L6Ci9VAimpfiTquRXvrri2UA2eMvPe
vkAg4JyuxcGs0bKjtE4ENepTYi65b2cp2EAyrFuYR3gvp9gYHel0Pd1SKMwqFUA=
=g8Gi
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
