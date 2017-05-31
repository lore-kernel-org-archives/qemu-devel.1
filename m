Received: from eggs.gnu.org ([2001:4830:134:3::10]:58349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2xN-00028B-3m
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2xM-0004RO-Bi
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:42:33 -0400
Date: Wed, 31 May 2017 13:42:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124224.GU16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-21-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qgEfXXHyyarqcYJd"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-21-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 20/29] qed: Add return value
 to qed_aio_write_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--qgEfXXHyyarqcYJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:01PM +0200, Kevin Wolf wrote:
> Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
> just return an error code and let the caller handle it.
>=20
> While refactoring qed_aio_write_alloc() to accomodate the change,
> qed_aio_write_zero_cluster() ended up with a single line, so I chose to
> inline that line and remove the function completely.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 58 +++++++++++++++++++++----------------------------------=
---
>  1 file changed, 21 insertions(+), 37 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qgEfXXHyyarqcYJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrowAAoJEJykq7OBq3PIejcH/0Dr5whoHeQixJcW/aXir6N9
VWPk1lB092imWoDnLJKqH7j2u4jZv2UwU97gmTrYQf3l/Vlno70e7kJ5K8wgms+5
AnqvISQVS66Q+cz8f6IN4+IzPJRrQHEQLz8LksVP28Rr0ayOchOyYBcGVRwAExZI
UyRGIMwyWIF5voA8OTsQIqMUfgfM+YRmPIEvLt9/b/q1Vp1ix/iNwNr/aOlJcJHE
/1nc/jiPnCg0/Qz4QIVB82uPrdYbO9aVfYG7L2b6hfrCcVEywa8JSjmtrVrByLVR
1cgUlZwQ+13ZFmgEpw+Qtjm4bdFAd5UVw/MANawiDoY31haUIwUcy/GYzgOABf0=
=0yN1
-----END PGP SIGNATURE-----

--qgEfXXHyyarqcYJd--
