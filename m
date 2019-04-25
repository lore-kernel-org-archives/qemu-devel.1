Received: from eggs.gnu.org ([209.51.188.92]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJbE5-0006zR-Cg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJbE3-0007FH-VE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJbE3-0007Ej-OQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:03:31 -0400
Date: Thu, 25 Apr 2019 11:03:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190425100326.GF30231@stefanha-x1.localdomain>
References: <20190424110041.8175-1-marcandre.lureau@redhat.com>
	<20190424110041.8175-3-marcandre.lureau@redhat.com>
	<CAFEAcA-_mX4_sJQ1KxSZbdcR1weANO+8430Y+zSYNBKgezPPLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_mX4_sJQ1KxSZbdcR1weANO+8430Y+zSYNBKgezPPLA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] build-sys: move slirp as git
 submodule project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jeff Cody <codyprime@gmail.com>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 01:14:57PM +0100, Peter Maydell wrote:
> On Wed, 24 Apr 2019 at 12:13, Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The slirp project is now hosted on freedesktop at:
> > https://gitlab.freedesktop.org/slirp.
> >
> > The libslirp source was extracted from qemu/slirp filtered through
> > clang-format (available in project tree). The qemu slirp directory can
> > be swapped by a git submodule.
> >
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -52,3 +52,6 @@
> >  [submodule "roms/edk2"]
> >         path =3D roms/edk2
> >         url =3D https://github.com/tianocore/edk2.git
> > +[submodule "slirp"]
> > +       path =3D slirp
> > +       url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
>=20
> We should prefer to set up a mirror of the git repo
> on git.qemu.org and use that, rather than a remote repo.
>=20
> We also need to do that for the berkeley softfloat
> and edk2 repos, I notice.
>=20
> Stefan or Jeff, could one of you set that up, please?

The mirrors are now set up:

  https://git.qemu.org/

I will send a .gitmodules patch that switches over to our mirrors.  I
will also include this libslirp submodule patch.

Stefan

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwYXuAAoJEJykq7OBq3PIZAMH/RP4VNIpHJFHGYNYbSHltvAO
HaVD5p6kMVSsYKTTvT1gESuy8B9RhEUK1gw3lKm/1ANXT/VuXq/qA2Ffvg9lSBcW
HDFox1Hj0BBJDZaMInh2HdzfnDRUPu1HAlgD0GCiIe8JpOETiDZk3aVRXBFu3uWq
L2hxmBXlAo9DdAXDeG+HaD37Nl/YuHkwrCQbASg9+IOcMtCyqFUzfFcuAevE3kE6
aGFstk2cTqq7e2OSl/W3PmYRDwp9grjh1IMC8XjU9AT01AY4qtiZBmG36LUqgFji
of5djH15euLghNFNEZZOMtpHDpX3i9UNVAcljeRN5VJq3YPKFrHf98p1ZtThIk0=
=korS
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
