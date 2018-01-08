Received: from eggs.gnu.org ([2001:4830:134:3::10]:35795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYYTZ-0005oI-VH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYYTX-0000GH-8K
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:32:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYYTX-0000FG-0i
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:32:31 -0500
Date: Mon, 8 Jan 2018 14:32:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108143224.GB11758@stefanha-x1.localdomain>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-5-f4bug@amsat.org>
	<20180105153136.GF28322@stefanha-x1.localdomain>
	<3152656d-3503-fc70-e91c-e4a3fec55321@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <3152656d-3503-fc70-e91c-e4a3fec55321@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] tests: add some sdcard qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 12:55:41PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 01/05/2018 12:31 PM, Stefan Hajnoczi wrote:
> > On Wed, Jan 03, 2018 at 06:49:25PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> >> +static const char *machines[PROTO_COUNT] =3D {
> >> +    [PROTO_SD] =3D "nuri",
> >> +    //[PROTO_MMC] =3D "vexpress-a9",
> >> +    //[PROTO_SPI] =3D "lm3s6965evb"
> >> +};
> >> +
> >> +static const uint64_t sizes[] =3D {
> >> +    //512 * M_BYTE,
> >> +    //1 * G_BYTE,
> >> +    4 * G_BYTE,
> >> +    //64 * G_BYTE,
> >> +};
> >=20
> > Why are these commented out?
>=20
> As I didn't feel good feedback for the previous Python qtests, I
> prefered to send this as RFC and to see if this was the good way to go
> before spending more time learning QDECREF() and friends :)
>=20
> However I again forgot to replace RFC -> NOTFORMERGE in the subject :(
>=20
> These parameters are commented out because the current sd.c code doesn't
> work with those cases :(
> So to show the qtests is useful and pass Travis/Patchew build, they are
> commented, and to show the current model is broken (until I succeed to
> fix it), one can uncomment these and see failing tests :)

If you want to commit commented out code then please include a comment
that explains why it's commented out.  That way readers understand why
it's there.

Also please run checkpatch.pl against all patches.  It can be run as a
commit hook so all your code is checked at commit time:
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU4D4AAoJEJykq7OBq3PIOoMH/0SctBYI2EcMcFp6DSRdl1H2
mEqEPmy0yHmLxJSCbCZkc6EWg++l0iJg/UccvnrfT2yrCIFoEUilRrH8m4utBVuo
SiVmb47RYLIbKdRKP5AJOQleIeenxVCAE3mx3kGij1Lvhck47vWdOjPOoDh6yaOq
3wPHGfkaARu+v7M3RNAq7xj8ycf3Pvc1J7m/qBzYZJlJWkNPI7RAnHuE6Cti/pHt
BqGsMc+fNP/UsuJ0h31cxDX0X7lvl1iO1jloOYL4dytn2xbdAnsf4qQ158UOqtVp
YGOAdLg7lMot31X3Pu18vrFMDhBZqm161+WmhNumB1dj1Sshwf5hRkYVYgaAEE4=
=lgWf
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
