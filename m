Received: from eggs.gnu.org ([2001:4830:134:3::10]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXYx-0008Ii-2n
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXYs-0004Fo-Md
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:01:47 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYXYs-0004F2-H7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:01:42 -0400
Received: by mail-wm0-x241.google.com with SMTP id 65so6939729wmf.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:01:42 -0700 (PDT)
Date: Fri, 21 Jul 2017 14:01:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721130138.GG18014@stefanha-x1.localdomain>
References: <20170717101547.22295-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <20170717101547.22295-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] add editorconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 12:15:47PM +0200, Gerd Hoffmann wrote:
> Add a .editorconfig file for qemu.  Specifies the indent and tab style
> for various files (C code and Makefiles for starters).  Most popular
> editors support this either natively or via plugin.
>=20
> Check http://editorconfig.org/ for details.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  .editorconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 .editorconfig
>=20
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 0000000000..b2022e391a
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,15 @@
> +# http://editorconfig.org
> +root =3D true
> +
> +[*]
> +end_of_line =3D lf
> +insert_final_newline =3D true
> +charset =3D utf-8
> +
> +[Makefile*]
> +indent_style =3D tab
> +indent_size =3D 8
> +
> +[*.{c,h}]
> +indent_style =3D space
> +indent_size =3D 4

Missing .cpp and .cc (hard to choose one, we use both!).

Stefan

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcfsyAAoJEJykq7OBq3PIX7cIALJRmZ+XygPpNNlkigCfibRB
XgK9JCbsf0oeUF0KsrLFcYe8tX5YJ1y4SRJnr1IOe8QNjuNBqnNSFHPQKS8XCgxd
k8Incj3u0TPiHlx/KLr81x9ThRRj0pWQahTtmOhzDzcvpD2HaLaZZlM0N/4+BjuB
mqnWg5fxMCvzeO3MDfob1OpdEzqbDS+HROxCNG8cp6ZHse6cV+h+zlkS+wcQY8H7
CWiFmbinUa23KPQjNNp2b3SfFOB1RvgPda2HbM2BlcY6Gr9fuGLls0DvLX2Syyc1
/jxqZSMqgvTyahpiAI8nqd6F8dm3OQFSqoSns1+Relh9c+/N0w4BtVEL2bp/EQU=
=LlcF
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
