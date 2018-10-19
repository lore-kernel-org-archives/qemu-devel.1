Received: from eggs.gnu.org ([2001:4830:134:3::10]:47572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gDTBo-0002CE-Pn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gDTBi-0005xu-HQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gDTBi-0005wW-B2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:43:30 -0400
Date: Fri, 19 Oct 2018 12:43:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181019114325.GE13137@stefanha-x1.localdomain>
References: <20181018223501.21683-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20181018223501.21683-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 01:34:58AM +0300, Julia Suvorova wrote:
> v3:
>     * Refactoring moved to a separate patch [Daniel]
>     * "websock" option renamed to "websocket" [Stefan]
>     * Added documentation [Daniel]
> v2:
>     * Fixed initialization order [Daniel]
>     * Function arguments refactoring [Paolo]
>     * Added test [Stefan]
>     * Added meaningful error message [Stefan]
>     * Added "websock:" URI prefix support
>=20
> Julia Suvorova (3):
>   chardev/char-socket: Function headers refactoring
>   chardev: Add websocket support
>   tests/test-char: Check websocket chardev functionality
>=20
>  chardev/char-socket.c | 117 ++++++++++++++++++++++++++++-----------
>  chardev/char.c        |   8 ++-
>  qapi/char.json        |   3 +
>  qemu-options.hx       |  13 ++++-
>  tests/test-char.c     | 125 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 231 insertions(+), 35 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbycNdAAoJEJykq7OBq3PIM6AH/27Bbas0yRORQQgaibDJdwS3
RLkddfKyFZh4cRk4PejfINC1K4K9flSfNWETBeVfnGMkPSj1ChtVT5fJL2hwl693
3YmoAikyxr/Y+HmXyZcQPFMGkQ3l+KXcWF/YStrZOjZYDCtmVxjB2m56CX7BtzBe
L5+9XOZdqjsaEaZZJizFFh2gy49TCL89TWBDEblOGLxB68ZVIYExormoaBxpMCRY
GQLKB/jvKavh+QMou3vu19GRKQ/dNAQFbmFoqE33ulUGjnVhhS6oRjMPDH/bszRn
IT+RslP/FMOpESvgRuLDP5GXZ9oi5V2vl67Vj4iPIJ8Z3LvvbhCcxoe5sqf5RXc=
=qBzZ
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
