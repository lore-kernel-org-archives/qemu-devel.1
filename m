Received: from eggs.gnu.org ([2001:4830:134:3::10]:57186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8ukx-0006Oc-RS
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8ukv-0001n0-Pk
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:32:15 -0400
Date: Thu, 11 May 2017 16:32:10 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511203210.GQ24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-15-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-15-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 14/16] nbd: Allow
 BLK_PERM_AIO_CONTEXT_CHANGE on BB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:54PM +0800, Fam Zheng wrote:
> This is safe because of the aio context notifier we'll register on this
> node. So allow it.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  nbd/server.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMpKAAoJEJykq7OBq3PIvZcH/0jZh+a8nnqGamGzec91yobo
03MFuXjP4zJHi9QdnHKZ0E9Y8oIlcGwTrHHgkR6FPy4qwBfs9S2BSqEvNZpxgYBp
pyc1lzAOKYOrTgnjdCUq2MnOpzQEiycMniQTIlUYySqg9JOsHTsZo+jl7WOxE+jr
RzabOXgnjBe7olaFLBy5QzpZCHMxFM083FXmEjFHPgYC1cqz5QLY5AXdlOsbTgEH
keAs4PzvucMV70EB9xPviwRLXz7iow3UrxZXG5Dgs1o4SHR/woRNH1Jk2fgz542G
XPl0PHv962Ex3bdy6tJVUvURnXvHB6+rc2Z9RE23kL5UTP+T4swx+alKKO3CWMk=
=gFXb
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
