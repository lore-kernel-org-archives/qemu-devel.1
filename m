Received: from eggs.gnu.org ([2001:4830:134:3::10]:51975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX2Z7-0003Yw-6l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX2Z3-0004JH-8f
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:43:45 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dX2Z3-0004Iw-1j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:43:41 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t70so9888310wmt.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:43:40 -0700 (PDT)
Date: Mon, 17 Jul 2017 10:43:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717094337.GD7163@stefanha-x1.localdomain>
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>, patches@linaro.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 11:45:17AM +0100, Peter Maydell wrote:
> In various places in our test makefiles and scripts we use the
> shell $RANDOM to create a random number. This is a bash
> specific extension, and doesn't work on other shells.
> With dash the shell doesn't complain, it just effectively
> always evaluates $RANDOM to 0:
>   echo $((RANDOM + 32768))     =3D> 32768
>=20
> However, on NetBSD the shell will complain:
>   "-sh: arith: syntax error: "RANDOM + 32768"
>=20
> which means that "make check" fails.
>=20
> Switch to using "${RANDOM:-0}" instead of $RANDOM,
> which will portably either give us a random number or zero.
> This means that on non-bash shells we don't get such
> good test coverage via the MALLOC_PERTURB_ setting, but
> we were already in that situation for non-bash shells.
>=20
> Our only other uses of $RANDOM (in tests/qemu-iotests/check
> and tests/qemu-iotests/162) are in shell scripts which use
> a #!/bin/bash line so they are always run under bash.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbIbJAAoJEJykq7OBq3PIWm0H+QE1WPZV0lBV76VxiHHwOXYP
rk3lC7u133AdEOPLfCj8ZOihyXOgXEWb5346upJ65d5RX++UBCBcGSCBX/uJjPOD
M4OJTqOo9xeK9fZDjVNqHha+uRXkFdhHqLgRaPz73WXB3pebflDuOvG7jVX+n061
O4ppaGRPcWBbpjnsISLf1FuxvCr0vfPKDjfasddvK4Ylf2ZJfXiSSv0S/aNm5bWB
+/w20CPR0v24lt4Wp3ha6XJyQ/9NbkoC6YPpUCnlaDa0jEmhrxqOuYSzMeaUUk7J
/0voi/Yn6wo1YlwO7OeQ4f4KFt21eNs7OJmjV1syYJw2QKqVynt6oaZlcQna3ZQ=
=OD1D
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
