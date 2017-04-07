Received: from eggs.gnu.org ([2001:4830:134:3::10]:40771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQaY-0000nC-5k
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQaX-0002bc-FA
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:53:54 -0400
Date: Fri, 7 Apr 2017 10:53:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407095344.GM13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<5767805b2cdb11651ba302297c19ee2362009dec.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
In-Reply-To: <5767805b2cdb11651ba302297c19ee2362009dec.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 9/9] block/rbd: Add support for
 reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:28:51PM -0400, Jeff Cody wrote:
> This adds support for reopen in rbd, for changing between r/w and r/o.
>=20
> Note, that this is only a flag change, but we will block a change from
> r/o to r/w if we are using an RBD internal snapshot.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY52GoAAoJEJykq7OBq3PIVlMH/0WAjtsvyruGYC9mm6KLAuJQ
BYv8tNu4bmY0fncoJ8ZhToiGPccTE4J78y2TnzA34LpNX/CyA1v1O0TVfjqs6C3Z
xx7rurGptFJj0W+epfanPEXlh8McLgCgNB+YYFhH99SLN/jsP/tigX85aeZCdIkr
/gkOuVrae/8xiEg55roEDMzPxsyBNvK1/tkLI2Q/M9sq5BkHGnnd201GWrStbzAK
N/fmyfbaib4/ujCg1buYH3fEe7Zk4u2RnfnpT+mQpNsJeoiejq4jMl4Ol81UuHpc
lNwBj/ITg3NTlrUm7nNmcSRC1nSNd4lQxmXC35b6Yf+AM9pR6TxYd0up37ftMho=
=I1C2
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
