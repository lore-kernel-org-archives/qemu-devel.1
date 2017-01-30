Received: from eggs.gnu.org ([2001:4830:134:3::10]:37058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYDoe-0006w8-MP
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYDoZ-000192-Mf
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:24:24 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYDoZ-00018b-F9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:24:19 -0500
Received: by mail-wm0-x243.google.com with SMTP id r18so6443354wmd.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:24:19 -0800 (PST)
Date: Mon, 30 Jan 2017 15:24:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130152415.GM2118@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rpGc+ACYPE+RMC+Z"
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] block: move AioContext and QEMUTimer
 to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com


--rpGc+ACYPE+RMC+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:43:09PM +0100, Paolo Bonzini wrote:
> AioContext is fairly self contained, the only dependency is QEMUTimer but
> that in turn doesn't need anything else.  So move them out of block-obj-y
> to avoid introducing a dependency from io/ to block-obj-y.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: new patch [Daniel]
>=20
>  Makefile.objs                       |  5 +---
>  block/io.c                          | 29 -------------------
>  stubs/Makefile.objs                 |  2 ++
>  stubs/linux-aio.c                   | 32 +++++++++++++++++++++
>  stubs/main-loop.c                   |  8 ++++++
>  stubs/set-fd-handler.c              | 11 --------
>  tests/Makefile.include              | 13 ++++-----
>  util/Makefile.objs                  |  5 +++-
>  aio-posix.c =3D> util/aio-posix.c     |  0
>  aio-win32.c =3D> util/aio-win32.c     |  0
>  util/aiocb.c                        | 55 +++++++++++++++++++++++++++++++=
++++++
>  async.c =3D> util/async.c             |  3 +-
>  qemu-timer.c =3D> util/qemu-timer.c   |  0
>  thread-pool.c =3D> util/thread-pool.c |  0
>  14 files changed, 110 insertions(+), 53 deletions(-)
>  create mode 100644 stubs/linux-aio.c
>  create mode 100644 stubs/main-loop.c
>  rename aio-posix.c =3D> util/aio-posix.c (100%)
>  rename aio-win32.c =3D> util/aio-win32.c (100%)
>  create mode 100644 util/aiocb.c
>  rename async.c =3D> util/async.c (99%)
>  rename qemu-timer.c =3D> util/qemu-timer.c (100%)
>  rename thread-pool.c =3D> util/thread-pool.c (100%)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rpGc+ACYPE+RMC+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj1qfAAoJEJykq7OBq3PIfOIH/jLUEBnjvYdpw6XcWzdYNdgH
hkQl7QWLakhQre+c2lVjkYeybbUZzz6HZU0P40vwqT8l6GHuCPucz2ygQWkyjeud
3tSy3LbLl/VbMD5WwS9h+inhcNc1Gpk1BYet0vU2Amp3DFWmtcAnn2LvB+oQ5LqR
cg0DyJbWTXQtCCywKakHhGG37jJ/BCUvxiglvNR2RPDZmtV8DQDjvdvhu9L0hpst
fly4UW7vJUm68j17XrxsQU40PTfF+yuMIP0Z6OjF5/VjVD+ZCPpSSuNASqaI/7UN
DUf7qP/GYjmj/T4k6fl7bGHtj1sBkvP5VJn1yPB2ydU0uYoGK8B0GvbRvAHXUqo=
=54oi
-----END PGP SIGNATURE-----

--rpGc+ACYPE+RMC+Z--
