Received: from eggs.gnu.org ([209.51.188.92]:47142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2EM1-00008S-0L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2ELy-0000Yh-NI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:11:55 -0500
Date: Fri, 8 Mar 2019 22:09:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308110951.GB15851@umbus.fritz.box>
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-8-armbru@redhat.com>
	<20190308001032.GF7722@umbus.fritz.box>
	<874l8dj0bv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <874l8dj0bv.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 07/14] ppc405_boards: Don't size flash
 memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 08:24:04AM +0100, Markus Armbruster wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Thu, Mar 07, 2019 at 02:03:16PM +0100, Markus Armbruster wrote:
> >> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
> >> Image size is rounded up to the next multiple of 64KiB.  Useless,
> >> because pflash_cfi02_realize() fails with "failed to read the initial
> >> flash content" unless the rounding is a no-op.
> >>=20
> >> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
> >> other stuff.  No idea how that would play out, but useful outcomes
> >> seem unlikely.
> >>=20
> >> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
> >> regardless of image size, to match the physical hardware.
> >>=20
> >> Machine "taihu" maps its boot flash memory similarly.  The code even
> >> has a comment /* XXX: should check that size is 2MB */, followed by
> >> disabled code to adjust the size to 2MiB regardless of image size.
> >>=20
> >> Its code to map its application flash memory looks the same, except
> >> there the XXX comment asks for 32MiB, and the code to adjust the size
> >> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
> >> to read the initial flash content" for images smaller than 32MiB.
> >>=20
> >> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
> >> to match the physical hardware.  Delete dead code from application
> >> flash mapping, and simplify some.
> >>=20
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >
> > I'm assuming because this is in a series I'm not otherwise CCed on
> > that this is going in through someone else's tree.  Let me know if you
> > want me take it through mine.
>=20
> I intend to take the complete series through my tree unless a maintainer
> objects.

No objection here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyCTX8ACgkQbDjKyiDZ
s5JuXw//c0xDtWRxWDrkEY9xUatFB05fZvP5UzT5BpNEHOTPdcdeENL/AaXmD5Re
s5fhJM+iGR5aEKPB6lI9Vbyzqb05UpkYGN8umpgt1H/CuD3vp6bENeOsUnjZJOBR
B2FbqLpMBBqU1bJniaq0rxNuFwa9vlrJPsxJvwY3XJNbPBV0fLRu5hvsB7P08KHA
aCO+3aTou7nWb+ZYzd/MT1tujuWoOcE4auSw5M1yWmuYCUz1oFg5+tcPFqumwS3A
4FWqw1NhZ/J8dJ7c080saVPfZqcQZ8JVZylrKD08is1IzJCJGPoFM/HNHzjmlr/y
7efeFIfaKy5bZhJGeKKwJT3lQ2Nw8CmJiWX9v9VbozYcALmKkjN/QI7dYBjmeHMh
zWeulxgDYb/0eG1ryB/xbOKM3XYfdfXehiC6s+7YR8T9tli5l0EG3jC6KenKIPA5
T2i6j6eFE7K7KK2SXnickC7ksrAS7Wp056mI8JVR+0C5DwQ6UAO+CR0oxCICX+9Z
OUeewWY4O23oXh6EgdS1yzkRTLWJTDhvE6c+Zhir5mGFfQAmFbob2ZZ7XtU68mHH
f1Wy22Nyb2kvt5DMtoNAOY6tCRKvy4n8LhtpjhBlLblnXaWBqCPuzLLtVCwRTv/m
4ZSOD9XxP82g0gKkoE7gQP1mIHqdJSECS4vpwxC5V8tGWa3MxOo=
=O1Yf
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
