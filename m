Received: from eggs.gnu.org ([2001:4830:134:3::10]:45235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGDH-0000ic-8X
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGDG-0006zd-3h
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:39:03 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGDF-0006xy-Sk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:39:02 -0400
Received: by mail-lf0-x244.google.com with SMTP id q24so3292582lfb.1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:39:01 -0700 (PDT)
Date: Mon, 15 May 2017 14:38:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515133858.GJ1201@stefanha-x1.localdomain>
References: <20170512143717.30391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKy6e3LXpfmanBFM"
Content-Disposition: inline
In-Reply-To: <20170512143717.30391-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.9 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--tKy6e3LXpfmanBFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 10:37:14AM -0400, Stefan Hajnoczi wrote:
> The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c5269=
49:
>=20
>   maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -04=
00)
>=20
> are available in the git repository at:
>=20
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>=20
> for you to fetch changes up to 321d1dba8bef9676a77e9399484e3cd8bf2cf16a:
>=20
>   aio: add missing aio_notify() to aio_enable_external() (2017-05-12 10:3=
6:46 -0400)
>=20
> ----------------------------------------------------------------
>=20
> ----------------------------------------------------------------
>=20
> Daniel P. Berrange (1):
>   coroutine: remove GThread implementation
>=20
> Eric Blake (1):
>   block: Simplify BDRV_BLOCK_RAW recursion
>=20
> Stefan Hajnoczi (1):
>   aio: add missing aio_notify() to aio_enable_external()
>=20
>  configure                |  19 ++---
>  include/block/aio.h      |  10 ++-
>  block/io.c               |   4 +-
>  util/coroutine-gthread.c | 198 -----------------------------------------=
------
>  .travis.yml              |   5 +-
>  5 files changed, 16 insertions(+), 220 deletions(-)
>  delete mode 100644 util/coroutine-gthread.c
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my master tree:
https://github.com/stefanha/qemu/commits/master

Stefan

--tKy6e3LXpfmanBFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGa9yAAoJEJykq7OBq3PIWKAIAJIAvOy47PyZrVD1WXhj+IaV
Qu3o1COgtCRM9T+GYmg4WptSPpogK6EOT2gf1sVu0iDb3sF4kKZO3BUQZnuy9RUy
Yvj44GTTC/I4fqnprqn4ahU2aQ762FcxM8dvPE+/T7YupEz/icHGTgwBMrnwvrfx
EXqrQG1WtME4CZ1udUc0+1J1vkPA1+MmBVRvL8OMJMNnqGtQZgRAyOCriMa//TX6
6JSQc6BAaXsW5yWEYANKzlI8rKA7/KYgnxc0jumGghmngLZbCmQ4667ufpjMZOe9
3hMczYP1REM5yQCnfbX+uvKlMS9Jv7UjRej3mDyjKelDH+jmB2k4i3gIILReEGQ=
=Ffm9
-----END PGP SIGNATURE-----

--tKy6e3LXpfmanBFM--
