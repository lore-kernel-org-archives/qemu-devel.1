Received: from eggs.gnu.org ([209.51.188.92]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJfjL-0005Kd-MR
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJfjJ-00018K-5I
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJfjH-00014I-Eu
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:52:04 -0400
Date: Thu, 25 Apr 2019 15:51:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190425145154.GE17806@stefanha-x1.localdomain>
References: <20190425125650.28846-1-stefanha@redhat.com>
	<e06ee86a-b1bf-6d4b-6a43-f349925787b1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <e06ee86a-b1bf-6d4b-6a43-f349925787b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 03:14:29PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 4/25/19 2:56 PM, Stefan Hajnoczi wrote:
> > qemu.org hosts git repository mirrors of all submodules.  Update
> > .gitmodules to use the mirrors and not the upstream repositories.
> >=20
> > Mirroring upstream repositories ensures that QEMU continues to build
> > even when upstream repositories are deleted or temporarily offline.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Based-on: <20190424110041.8175-1-marcandre.lureau@redhat.com>
> >           "[PATCH v2 0/2] slirp: move slirp as git submodule project"
> >=20
> > Peter: Please apply Marc-Andr=E9's series.  I have set up the necessary
> > mirrors and this patch will fix up the libsirp URL as well as the
> > other URLs.
> >=20
> >  .gitmodules | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/.gitmodules b/.gitmodules
> > index aa77ce6f50..84b260031c 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -39,19 +39,19 @@
> >  	url =3D https://git.qemu.org/git/capstone.git
> >  [submodule "roms/seabios-hppa"]
> >  	path =3D roms/seabios-hppa
> > -	url =3D https://github.com/hdeller/seabios-hppa.git
> > +	url =3D https://git.qemu.org/git/seabios-hppa.git
> >  [submodule "roms/u-boot-sam460ex"]
> >  	path =3D roms/u-boot-sam460ex
> >  	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
> >  [submodule "tests/fp/berkeley-testfloat-3"]
> >  	path =3D tests/fp/berkeley-testfloat-3
> > -	url =3D https://github.com/cota/berkeley-testfloat-3
> > +	url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
> >  [submodule "tests/fp/berkeley-softfloat-3"]
> >  	path =3D tests/fp/berkeley-softfloat-3
> > -	url =3D https://github.com/cota/berkeley-softfloat-3
> > +	url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
> >  [submodule "roms/edk2"]
> >  	path =3D roms/edk2
> > -	url =3D https://github.com/tianocore/edk2.git
> > +	url =3D https://git.qemu.org/git/tianocore/edk2.git
>=20
> I'm getting:
>=20
> Entering 'roms/edk2'
> fatal: repository 'https://git.qemu.org/git/tianocore/edk2.git/' not found
>=20
> OK, got it, the correct URL is https://git.qemu.org/git/edk2.git
> (without 'tianocore')
>=20
> With the URL or the path locally updated:
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Doh, I should have run "git submodule update --init" in addition to
=2E/configure && make.

Will fix in v2.

Stefan

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwcmKAAoJEJykq7OBq3PIcFQH/j+dBToCrhH863VaMKCvy7Zi
vkei3z9W51pH8cJoYhu3Cxfp9CUOUwlY847bc6owuZt19GXF/giohHZjsEga9Mfh
WZoAnpgps9GvY0b3al6aRYOEyaIsebXSw+fzpfEdN9QPAkRRu7JhT3u5XbW+rtAT
WMtqis8tHepbIvY+HpxRpf4rqKm8rFicvpgaBOEX+syKYSxR9orpbHjZAL3a8RLx
4yR1dc3kgF5q71OM6DCfhAihnaPNTcSzcZBumNReJmeE3HO4OPuZQoj3fWYC0UQM
r9R+RFUvIsa5Jc0w2TXv6QSecZwvyliZboR2mohlawy3s15SgwN4Y9CJQN2YnMA=
=4jgF
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
