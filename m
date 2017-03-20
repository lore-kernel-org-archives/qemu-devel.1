Received: from eggs.gnu.org ([2001:4830:134:3::10]:40991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv6j-0008KB-N8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv6i-0000lt-WF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:04:13 -0400
Date: Mon, 20 Mar 2017 11:04:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320110404.GJ17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-7-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-7-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 09/16] block/qcow2:
 Generalize preallocate()
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


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:38PM +0100, Max Reitz wrote:
> This patch adds two new parameters to the preallocate() function so we
> will be able to use it not just for preallocating a new image but also
> for preallocated image growth.
>=20
> The offset parameter allows the caller to specify a virtual offset from
> which to start preallocating. For newly created images this is always 0,
> but for preallocating growth this will be the old image length.
>=20
> The new_length parameter specifies the supposed new length of the image
> (basically the "end offset" for preallocation). During image truncation,
> bdrv_getlength() will return the old image length so we cannot rely on
> its return value then.

You documented the arguments in the commit description.  Please move
them into doc comments.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7ckAAoJEJykq7OBq3PIdWgH/RslkCNU6UXMmxAPlpKlzakS
IDFxDJRUoeBVisRwaOrYxFpbXm7wx0C8zS8x4i4OXS6HvQlBLMwNAQ6Xd+BQWeDD
h4/13T9M4AuuRja5Z7xk2ozo0qbci2gt7ghABviZiIz3GaLlTM1udT8RY/5mwQY+
n1yvCxW2wYP1NDkeJlHc/Nxc8IvXtDTgux4gfjHAGljR5LeaeC+bOYBMMC5dbdqQ
qeYERrGmxqzTj8rkdK6ArAnnu5kcl44ACBymzQyRbPcX0ISZvuZXuGmpx7cUWZke
A8j9dEb9zmyIN6e2UGJSCLduQx/Hi+29mvEbf261/Qg+hUKwKD9UZ2JtZ4Jdd+k=
=cxhD
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
