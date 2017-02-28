Received: from eggs.gnu.org ([2001:4830:134:3::10]:56294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijXs-000571-OR
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijXn-0006pk-AG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:18:32 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-23-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5955153e-ad10-d39e-06ca-3288b1b7f2ed@redhat.com>
Date: Tue, 28 Feb 2017 16:18:18 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-23-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P0ltIB5JrKNbGTqxOwnv4VOJ8uTG90FVt"
Subject: Re: [Qemu-devel] [PATCH v3 22/44] block: Include details on
 permission errors in message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P0ltIB5JrKNbGTqxOwnv4VOJ8uTG90FVt
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <5955153e-ad10-d39e-06ca-3288b1b7f2ed@redhat.com>
Subject: Re: [PATCH v3 22/44] block: Include details on permission errors in
 message
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-23-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> Instead of just telling that there was some conflict, we can be specifi=
c
> and tell which permissions were in conflict and which way the conflict
> is.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
--------
>  1 file changed, 56 insertions(+), 11 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--P0ltIB5JrKNbGTqxOwnv4VOJ8uTG90FVt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1lLoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALzoIAKKWCUzc4iaKp9pWsQK0YCm+honwv7KK
dvY8Di0gPgwC4zMMDfsB4uDNHi0tp5tNWqbH5V9p3wio7ahXyPam6lQ3LCMW3+uV
pZzxLLoAEoHB1zR1X+dRXm/bCsbo2CH9wWXOahadM4vrhFy3IFUJ66x3q6JYemHE
/vEiD80mW3IvkilHmCUK/zfFvPz/gypZyYKXNw8FOrsFizW9VohvVvciyHmRIQFz
xI/w8okrJUJ8gv2T3RpJTyQYtKnd1SU5uf1d6NSXq6GJvY8safTmWNEw6vyGH8iT
NAZE6rDHVt2uULvefZx9byxumwJxTP3+EiB+KvqxF/Lm6Ef8THy7/TU=
=lRGl
-----END PGP SIGNATURE-----

--P0ltIB5JrKNbGTqxOwnv4VOJ8uTG90FVt--
