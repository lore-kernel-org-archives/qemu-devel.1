Received: from eggs.gnu.org ([2001:4830:134:3::10]:59265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUx3e-00057r-Kl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUx3Z-0002Xk-KL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:26:38 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUx3Z-0002Wx-8Y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:26:33 -0400
Received: by mail-lf0-x241.google.com with SMTP id g21so484481lfk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:26:33 -0700 (PDT)
Date: Tue, 11 Jul 2017 16:26:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711152629.GC31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-7-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/35] coroutine: mark CoRwLock coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:17AM +0200, Marc-Andr=E9 Lureau wrote:
>   CC      util/qemu-coroutine-lock.o
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:371:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
>     qemu_co_mutex_lock(&lock->mutex);
>     ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:371:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:374:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
>         qemu_co_queue_wait(&lock->queue, &lock->mutex);
>         ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:374:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:377:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
>     qemu_co_mutex_unlock(&lock->mutex);
>     ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:377:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:390:9: warning: calling=
 function 'qemu_co_queue_restart_all' requires holding role '_coroutine_fn'=
 exclusively [-Wthread-safety-analysis]
>         qemu_co_queue_restart_all(&lock->queue);
>         ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:390:9: warning: calling=
 function 'qemu_co_queue_restart_all' requires holding role '_coroutine_fn'=
 exclusively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:394:9: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
>         qemu_co_mutex_lock(&lock->mutex);
>         ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:394:9: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:399:13: warning: callin=
g function 'qemu_co_queue_next' requires holding role '_coroutine_fn' exclu=
sively [-Wthread-safety-analysis]
>             qemu_co_queue_next(&lock->queue);
>             ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:399:13: warning: callin=
g function 'qemu_co_queue_next' requires holding role '_coroutine_fn' exclu=
sively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:402:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
>     qemu_co_mutex_unlock(&lock->mutex);
>     ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:402:5: warning: calling=
 function 'qemu_co_mutex_unlock' requires holding role '_coroutine_fn' excl=
usively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:407:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
>     qemu_co_mutex_lock(&lock->mutex);
>     ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:407:5: warning: calling=
 function 'qemu_co_mutex_lock' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:410:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
>         qemu_co_queue_wait(&lock->queue, &lock->mutex);
>         ^
> /home/elmarco/src/qemu/util/qemu-coroutine-lock.c:410:9: warning: calling=
 function 'qemu_co_queue_wait' requires holding role '_coroutine_fn' exclus=
ively [-Wthread-safety-analysis]
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/coroutine.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZO4lAAoJEJykq7OBq3PIGHEIALZbtBNjcXQZvqUPX7PkgicM
1YaMDfMVdHjz7jEmbCL6UhDGB644pYqfPHDJ5aF+Fw1GEuy4QX3eG+n3N1dBOvvo
1bgfb6a9vjGUr76B+bqwmGTlTnfpm4wDkXBycdwM3e6E42cXr/ZQP3DN1g9cU/AS
6eosXFE2d7ofBnnaMg2YU1okkqv4Hj47UCATW9hz+Q9Aoewao0gPH54vLmAt9ouN
GQ/Wnwhtu6MY4qCUlGnFMZ+DEzY8guKNVkVHKk0EAjdsETLbZRwUmnjSwAtdcji1
xWsEyIWZGFSuN2iNbIHGYZB1RrF6f0o7TlYRzZE5qoKPZd3Gwnor4WrlEJB1jm8=
=ccme
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
