Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbZJ-0006k5-CC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbZI-0006uW-KS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:46:09 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2cf6b657-e6f4-3e1c-5582-69bf6af1316c@redhat.com>
Date: Tue, 31 Jan 2017 10:45:56 -0600
MIME-Version: 1.0
In-Reply-To: <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UdMmskgSE5RSl9OxwwQEEhnnGQmBbsaEa"
Subject: Re: [Qemu-devel] [PATCH 2/2] iov: assert that qiov->size doesn't
 exceed INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UdMmskgSE5RSl9OxwwQEEhnnGQmBbsaEa
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <2cf6b657-e6f4-3e1c-5582-69bf6af1316c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iov: assert that qiov->size doesn't
 exceed INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
In-Reply-To: <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 10:09 AM, Alberto Garcia wrote:
> The type of qiov->size is size_t but the QEMU I/O code uses int all
> over the place to measure request sizes. Overflows are likely going
> to be detected by any of the many assert(qiov->size =3D=3D nbytes), whe=
re
> nbytes is an int, but let's add proper checks in the QEMUIOVector
> initialization, which is where it belongs.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  util/iov.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UdMmskgSE5RSl9OxwwQEEhnnGQmBbsaEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkL9EAAoJEKeha0olJ0NqXRgH/3aEAVHuGhGjGom06isKOaa0
CsfTIB8r7WZl68X4aNxAWQv/ETMbEiEEExiO8N+V8mVXc31m0d5/Y9ezl7/RIWMJ
pfg0BWkq22TdnwMwFUHh4ntoA4/K2AZt+CebRdECNGUWRufi1r+ujWSA83ZNrenb
97IX6myDVSkGxCwxqlGorZHhOuNzHgXNAor7WKfDQB5mILjPAfhRgzWMk+Oln96x
qiNn5FDYVg/2j1UXcpaVYuCNcNvKuoCuRTM2kwXX/xzwC07FxwPHm1GyVIG/a13C
KQkQx88cQY9YLt4piL+id1MeMKK/x3+TCaWzvdFlrlnhfB5O68pN/sQdXGW7x84=
=krgO
-----END PGP SIGNATURE-----

--UdMmskgSE5RSl9OxwwQEEhnnGQmBbsaEa--
