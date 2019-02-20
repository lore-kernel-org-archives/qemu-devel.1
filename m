Received: from eggs.gnu.org ([209.51.188.92]:41847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwTjE-0007jE-D7
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwTjC-0007Ln-Mt
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gwTjA-0006nD-BQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id x10so6787550wmg.2
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:22:21 -0800 (PST)
Date: Wed, 20 Feb 2019 15:22:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220152218.GB30403@stefanha-x1.localdomain>
References: <alpine.BSF.2.21.9999.1902151046540.80982@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1902151046540.80982@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] MemoryRegionOps access sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 10:55:59AM +0100, BALATON Zoltan wrote:
> Hello,
>=20
> Could someone please explain how the MemoryRegionOps
> valid.{min,max}_access_size and unaligned and corresponding impl constrai=
nts
> work and where are these implemented? And in particular if this would wor=
k:
>=20
> static const MemoryRegionOps ops =3D {
>     .read =3D readfn,
>     .write =3D writefn,
>     .valid.min_access_size =3D 1,
>     .valid.max_access_size =3D 4,
>     .impl.min_access_size =3D 4,
>     .impl.max_access_size =3D 4,
>     .endianness =3D DEVICE_LITTLE_ENDIAN,
> };
>=20
> This is related to this question:
> http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg03157.html
> but that's probably ignored in the middle of a thread so I ask separately.

CCing Paolo and Peter, who might know the answer.

Otherwise the easiest way to understand the behavior would be to create
the memory region and try it out using qtest to see what happens in
practice.

Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbXCqAAoJEJykq7OBq3PIuW4H/3l4JNeod6ijBbE4h5CFUA7P
NN/1GPmrQ+vnY4czOPlc89NLUX133wnP4p5otuRqiMQthRY9e5WcjsMfrNaN1zOF
FCSV1fbYocv1XnA7B0Fw4wbYoW+zNLDZwHUpkn9u93VRFDftR2UM8x6bTl1ignGL
dYY6fTPkDH4vC9cUIa2jeBKHYF+crEaTPXQ6/riDRoKpHet881LIdd9Rij6E69um
m/EHxh18aauIPLcwGu+gOuvcDDSyXVS7wRyytSIOF2ibHxP2FTACP8yKYG/Bku8q
HejbVY1P9vtY3GBum+KGRUMCqGo5aaeKnL5RX/sTJUF/t+1PxEIrh7ecpiYzCWA=
=U+5d
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
