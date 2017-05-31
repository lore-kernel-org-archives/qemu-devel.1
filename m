Received: from eggs.gnu.org ([2001:4830:134:3::10]:57221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2tC-0007Qy-EJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2tB-0003F1-Ly
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:38:14 -0400
Date: Wed, 31 May 2017 13:38:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123804.GP16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-16-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHiQ9nAwW5IGN2dL"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-16-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 15/29] qed: Make
 qed_aio_write_main() synchronous
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


--hHiQ9nAwW5IGN2dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:56PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 61 +++++++++++++++++++------------------------------------=
------
>  1 file changed, 19 insertions(+), 42 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hHiQ9nAwW5IGN2dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrksAAoJEJykq7OBq3PIg6oH/0sjm+BCJcAZ30vVREx5fvTy
U8tzXvtlUux3QouFG8kJMZBQW9PQBIdxJfV6kkM1qY7l9e4Nh9g5bVyPf39I8z+a
SboGbg7O8RopdthhFCwrzOq+iGDt8QcC90GR2C3P/N4GQLGuAkhHTYLrS32a6Sts
Tdzbb9kYxe5diU5j+b+Br/tvJ79Y1ZTXN50Rmi0dW9oxEvgSEPBPTNyfCNRTl31J
93iptKju8iB3n5YCCVLFQOTdyp7KlMEgWIdVjSWZduHQjLjDEFke+Qh0RusA/DIK
EbxSMgjo1tBRItr4N98DewY1KRWS+ZOQ3z8o+hW65uaFC2dJjptyvEI5bDmnhsU=
=l9gr
-----END PGP SIGNATURE-----

--hHiQ9nAwW5IGN2dL--
