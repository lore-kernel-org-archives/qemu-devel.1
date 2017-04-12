Received: from eggs.gnu.org ([2001:4830:134:3::10]:59773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyFOa-0007GY-9v
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyFOW-0006x3-7P
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cyFOV-0006wr-VU
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:21:00 -0400
Date: Wed, 12 Apr 2017 11:20:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170412102055.GC26272@stefanha-x1.localdomain>
References: <BM1PR01MB072299B8CAFBB379F8BF8DE584000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <BM1PR01MB072299B8CAFBB379F8BF8DE584000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and
 g_free in util/compatfd.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 08:04:43PM +0000, Prerna Garg wrote:
> From 9e25fdf1ea3e4f52a72bfefc053a701989b7af24 Mon Sep 17 00:00:00 2001
> From: Prerna Garg <prerna.garg@live.com>
> Date: Wed, 12 Apr 2017 01:29:40 +0530

Please resend using git-send-email(1) so that email is properly
formatted for git-am(1) and other tools who will process it.

qemu-devel@nongnu.org receives many patch emails every day that both
human maintainers and bots process.  Unfortunately free-form patch
submission doesn't scale so we all have to follow the guidelines:
http://wiki.qemu-project.org/Contribute/SubmitAPatch

I suggest sending the email to just yourself first so you can confirm
that it meets the guidelines.

> Subject: [PATCH 2/2] Changed malloc and free to g_malloc and g_free in
>  util/compatfd.c

Please follow the commit message conventions:

  compatfd: replace malloc() with g_malloc()

The first part is a prefix that indicates which component in QEMU is
affected.  You can use "git log path/to/file.c" to see what prefix is
commonly used for a file.

The second part is a brief summary written in present imperative.

>=20
> Signed-off-by: Prerna Garg <prerna.garg@live.com>
> ---
>  util/compatfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/compatfd.c b/util/compatfd.c
> index 980bd33..7bf1344 100644
> --- a/util/compatfd.c
> +++ b/util/compatfd.c
> @@ -71,14 +71,14 @@ static int qemu_signalfd_compat(const sigset_t *mask)
>      QemuThread thread;
>      int fds[2];
> =20
> -    info =3D malloc(sizeof(*info));
> +    info =3D g_malloc(sizeof(*info));
>      if (info =3D=3D NULL) {
>          errno =3D ENOMEM;
>          return -1;
>      }
> =20
>      if (pipe(fds) =3D=3D -1) {
> -        free(info);
> +        g_free(info);
>          return -1;
>      }

Looks good.

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7f+HAAoJEJykq7OBq3PIIGAH/2yh9ivcLrMCLx+PSb9gJ16I
np8BDocSwgG7cqT1kVrgDa0gm7nHQL68NMzZTowPk3134JBNqwwLSC3hFB1D8pHt
ZfZSHjq2nf4RF7GUHzeWg1E792nbZqoJned8xOMAX7Fnk0pu5a+JCTQrqTl6HQhZ
SYEAfGg749rtRKQPrmEzlnVLE3SD+0eAWm3koYXx6muatwMeX0uTNkFSI4P0yXH0
9dX7Pab43eanb1kRIGrIbQSj9dswqz6vLIJtNL44Ursqsq29d3gtU/CQ2DIvVM1/
sDyWRwqE6DUlTvdiU0ZK3pcoPg2Ny8GbDHOejULVGhNke7UC4MDCrmyb2h2Q8Xk=
=F49R
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
