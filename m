Received: from eggs.gnu.org ([209.51.188.92]:58251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLqpU-0003X8-WE
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLqpP-00064L-15
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:07:26 -0400
Date: Mon, 29 Apr 2019 12:13:31 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190429161331.GC13640@stefanha-x1.localdomain>
References: <20190429105741.31033-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20190429105741.31033-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: Fix qcow2_make_empty()
 with external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 12:57:41PM +0200, Kevin Wolf wrote:
> make_completely_empty() is an optimisated path for bdrv_make_empty()
> where completely new metadata is created inside the image file instead
> of going through all clusters and discarding them. For an external data
> file, however, we actually need to do discard operations on the data
> file; just overwriting the qcow2 file doesn't get rid of the data.
>=20
> The necessary slow path with an explicit discard operation already
> exists for other cases. Use it for external data files, too.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxyKrAAoJEJykq7OBq3PIU8cH/Rp4YpsMyrtD9O2KA5mvpEcB
JutWX3bfCQxwPfT49VwhL2beKHLoc4sLlh+t4K6kyB4TIoK/GHGQFKN9/La6waTy
yUg4YJ74O9Ir/Cny9Q+ht1HdqWJ/1FRPulNwJENwAQ4UbBp0vL3KrUe6VDX2aRgC
vSGnqlKE+IGJz+qHOWkIP3csgsyFWc7i7GCT9z11mP7LAjoZf8NETz2D53RoT2/N
/9gLXONIoAMpr+SJWUv/NUH60ZtDWYfDPwztYmziY5syHd0L4j3l29sT3aW+MFEH
c8qMctinA3E+JqIr0cs8/BSZLxkgBdRDIxa5S57haNf3b7XZx4XXDJfzXWCtKC0=
=pAiJ
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
