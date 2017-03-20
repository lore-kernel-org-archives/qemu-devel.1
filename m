Received: from eggs.gnu.org ([2001:4830:134:3::10]:41517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv8P-0000si-2w
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv8N-0002n4-NI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:05:56 -0400
Date: Mon, 20 Mar 2017 11:05:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320110547.GK17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/16] block/qcow2: Lock s->lock
 in preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:41:11PM +0100, Max Reitz wrote:
> preallocate() is and will be called only from places that do not lock
> s->lock: Currently that is qcow2_create2(), as of a future patch it will
> be called from qcow2_truncate(), too.
>=20
> It therefore makes sense to move locking that mutex into preallocate()
> itself.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7eLAAoJEJykq7OBq3PIft0H/19xwPHs0QoT+K6QPxb5CLNQ
aTd4k55x1S83A7ni/6kbeF89pWA6u38QddwZ5JkyvxVATzoX9JSQbA+0HOoTRffe
mhCW5uVJK4NIABxLxN9qXnxvMnN0/Q04lqVeG3uz0ZOHJNsK0ssQEKWpVfdegYkA
MrvUTvfA7wdR1infZjkn6dtpPskVbqOxdKSljG211HtjLAPgFwHuh1YDd/h3yTMH
kO7Gc5Q0ewwyy+V1EQawe42lvdij/7h8tnbgVAcnjCil+zs9c+RKdmwjzIM1cJcR
w7Pt/UKIS3VD+dCMFupcoAgqTIanikbZ3avXhyUeWe19jn+AqysyhghYWAZM+PQ=
=nxGu
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
