Received: from eggs.gnu.org ([2001:4830:134:3::10]:36525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8wF-0007bS-Vs
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8wC-0001SD-MN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP8wC-0001Ru-Ec
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:27:12 -0500
Date: Wed, 13 Dec 2017 15:27:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213152703.GD7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 03/26] qobject: let
 object_property_get_str() use new API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:37PM +0800, Peter Xu wrote:
> We can simplify object_property_get_str() using the new
> qobject_get_try_str().
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qom/object.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUbHAAoJEJykq7OBq3PIdasH+wQGjNm8djfJuY/nrQE48GPF
nUu/RGhzEiO2x4EjTK+axlWbSFdmzWWQYQ9osJLAnK9UJgy9Vei0QAZDT6ujjauF
WpuIg5/ZGvRaWZmFvybk75y7X7rJa3Pa1DHMzrOp8dwo7aRKKUsEN9bCMHPHH4M/
+Y+GJdpe1hNxpIN7BO04coA6wLHHxW2II0J+AFdpNZ6EqVC6xoqJG0cd8+DExafw
oDeujidQjjno4rtajNZOHRnmeIAKLslrX5T9A1Wa9ILKFdowUlfC5kzxNK9UVmGB
+4hXfB0N/wrmPFdqmZJNkF339lJ6RlnkR0kCJihoIgspYe9H1Yo5PQWLm7E65ms=
=4gOA
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
