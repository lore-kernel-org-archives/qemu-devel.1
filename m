Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddduo-0000MD-F8
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddduP-0000Qc-Fu
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:49:26 -0400
References: <20170804143658.23020-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0cf16030-d5d0-6e7e-8fc7-88abd8f6d3ca@redhat.com>
Date: Fri, 4 Aug 2017 09:42:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170804143658.23020-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SxkLw1AoEJ1nSmBVdUvooG0uu8h1nGa4O"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Clarify about relative
 backing file options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SxkLw1AoEJ1nSmBVdUvooG0uu8h1nGa4O
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <0cf16030-d5d0-6e7e-8fc7-88abd8f6d3ca@redhat.com>
Subject: Re: [PATCH v2] qemu-img: Clarify about relative backing file options
References: <20170804143658.23020-1-famz@redhat.com>
In-Reply-To: <20170804143658.23020-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 09:36 AM, Fam Zheng wrote:
> It's not too surprising when a user specifies the backing file relative=

> to the current working directory instead of the top layer image. This
> causes error when they differ. Though the error message has enough
> information to infer the fact about the misunderstanding, it is better
> if we document this explicitly, so that users don't have to learn from
> mistakes.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
> v2: Improve wording. [Eric]
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SxkLw1AoEJ1nSmBVdUvooG0uu8h1nGa4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEh/MACgkQp6FrSiUn
Q2py8QgApEuiyukd6N/TbGgwR0OtHbV1yIm/j1Cm2DvM3HbS+cnrYgNLg0Hm/7Ie
tm9WGzcQPBjf0bWCjxCYB+wrgJhhKDG7EwXHIwsoCCApIWTpW4mIyhqmxO5hldO/
RFzQWBALie4cvn7NXnWRP+CbawfC/N81UBxMMMCyYmbnzAeST5CvYqH9/6refL7g
T0jV3aE7v/Jug5sb4X6L9OzC8C1ZBZrtJAO0t7qJA3voQvZPSKP6f+VSVYT4x10Y
YxH8Uv0t6LtSpN4uClXTf/mW+4ju8rYJxezCYZ98ecK+xTf78ktFzAO0o8TMBUH0
fxMFAwQapAWPgYMNgs7DGgagezPAzQ==
=/Ecc
-----END PGP SIGNATURE-----

--SxkLw1AoEJ1nSmBVdUvooG0uu8h1nGa4O--
