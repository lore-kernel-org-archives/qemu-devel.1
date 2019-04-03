Received: from eggs.gnu.org ([209.51.188.92]:33048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBee7-0000Vg-OS
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hBee6-0005eC-Qu
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:05:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hBee6-0005cd-Go
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:05:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id y13so21001770wrd.3
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 05:05:34 -0700 (PDT)
Date: Wed, 3 Apr 2019 13:05:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190403120531.GC32425@stefanha-x1.localdomain>
References: <20190401093051.16488-1-n.alekseev2104@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <20190401093051.16488-1-n.alekseev2104@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Add coroutine_fn to bdrv_check_co_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: n.alekseev2104@gmail.com
Cc: qemu-devel@nongnu.org, jusual@mail.ru, kwolf@redhat.com, mreitz@redhat.com


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 12:30:51PM +0300, n.alekseev2104@gmail.com wrote:
> From: Nikita Alekseev <n.alekseev2104@gmail.com>
>=20
> bdrv_check_co_entry calls bdrv_co_check, which is a coroutine function.
> Thus, it also needs to be marked as a coroutine.
>=20
> Signed-off-by: Nikita Alekseev <n.alekseev2104@gmail.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you!  I prefixed the commit message with "block: ".  Most commits
have a subsystem prefix to make browsing/searching git log easier.  In
the future you can add it yourself - look at git log for a file to
discover what prefix other people recently used.

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpKGLAAoJEJykq7OBq3PIHsAH/0XnEYJOJ/T6yraD+0pFSEEH
mmrvyceIFcOAAgvoECSAtJNjSYwruUhwhxKoUfLQWhibDMovKEr9mYaGdOL2NjKA
YxZ+37GMRUcSf6fVpa8dZ4L1SVOBWvusi3dBbKrITdZhpKHqMOJEbQ0GflNhzFeR
yys2I5z3snoJVWy5mRBmMx6tdltPWxu8PspEUycUGsb6LtwClvufT+Se/GGx5DWp
ibby8g/U6rKnia6Fba5ENWiZLJk00HpgoGTcyYT8QiPq1qkfxy21Q+HvqUeDTmHq
DT/9Qa88WJV+fpsW22P8mIXPgPyW6pGVelcUI9PHLskZob9yF28jcR3QL0d7yLI=
=/RTf
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
