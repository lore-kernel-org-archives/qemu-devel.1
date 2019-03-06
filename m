Received: from eggs.gnu.org ([209.51.188.92]:55728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1KsH-0000nZ-87
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1KsF-0006N8-Vj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:57:33 -0500
Date: Wed, 6 Mar 2019 11:53:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190306005301.GG19715@umbus.fritz.box>
References: <20190304015401.14280-1-randrianasulu@gmail.com>
	<alpine.BSF.2.21.9999.1903040328140.78566@zero.eik.bme.hu>
	<201903041326.28249.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <201903041326.28249.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] Re-applying Freescale PPC
 E500 i2c/RTC patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 01:26:27PM +0300, Andrew Randrianasulu wrote:
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Monday 04 March 2019 05:51:27 BALATON Zoltan =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(=D0=B0):
> > On Mon, 4 Mar 2019, Andrew Randrianasulu wrote:
> > > From: Amit Singh Tomar <amit.tomar@freescale.com>
> > >
> > > Original commit message:
> > > This patch adds an emulation model for i2c controller found on most o=
f the FSL SoCs.
> > > It also integrates the RTC (ds1338) that sits on the i2c Bus with e50=
0 machine model.
> > >
> > > Patch was originally written by Amit Singh Tomar <amit.tomar@freescal=
e.com>
> > > see http://patchwork.ozlabs.org/patch/431475/
> > > I only fixed it enough for application on top of current qemu master
> > > 20b084c4b1401b7f8fbc385649d48c67b6f43d44, and hopefully fixed checkpa=
tch errors
> > >
> > > Tested by booting Linux kernel 4.20.12. Now e500 machine doesn't need
> > > network time protocol daemon because it will have working RTC
> > > (before all timestamps on files were from 2016)
> > >
> > > ---
> > >
> > > v1->v2: Expanded and fixed commit message
> > >
> > >
> > > Signed-off-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> > > ---
> >=20
> > Almost... Patch now applies but subject and commit message are not yet=
=20
> > right. Look at existing commit messages for examples how it should look=
=20
> > (e.g. git log hw/ppc/e500.c). The email subject will become commit titl=
e,=20
> > this should start with something showing which part you change like e50=
0:.=20
> > Then one line summary of what the patch is doing. You can probably keep=
=20
> > original title, no need to say re-applying or things like that there. Y=
ou=20
> > can explain this in patch body. The text up to the first --- will be th=
e=20
> > body of the commit message so you should describe in more detail what t=
he=20
> > patch does here. Also this should include all Signed-off-by and other=
=20
> > tags at the end before the ---.
> >=20
> > Everything after --- are additional comments that won't be included in =
the=20
> > commit message so you can put version history or any other remarks ther=
e=20
> > that should not be kept after applying the patch.
> >=20
> > This patch is missing Signed-off-by of the original author and has your=
s=20
> > below --- that's why checkpatch complains. You should keep the the=20
> > original Signed-off-by even if you add From: of the original author. I=
=20
> > think you may not include From: since you're not forwarding a patch=20
> > unchanged but this is now your patch based on the original since you've=
=20
> > changed it so it can have your From: address from email header and=20
> > Signed-off-by of both original author and yours to show where it came f=
rom=20
> > originally. You can also mention this in commit message to make it clea=
r.
> >=20
> > Or you can keep From of original author and explain in commit message w=
hat=20
> > you've changed but it still needs both Signed-off-by lines even then.
> >=20
> > Hopefully this makes sense. This should already be explained in the=20
> > SubmitAPatch wiki page but that can be complicated at first.
>=20
> Thanks for explaining all this.
> Right now top of my patch looks like this:
>=20
> From ad2b4baf8b369c8ef354e56f75ae780413acd989 Mon Sep 17 00:00:00 2001
> From: Andrew Randrianasulu <randrianasulu@gmail.com>
> Date: Sun, 3 Mar 2019 00:05:04 +0300
> Subject: [PATCH v3] PPC: E500: Add FSL I2C controller and integrate RTC w=
ith it
>=20
> Original commit message:
> This patch adds an emulation model for i2c controller found on most of th=
e FSL SoCs.
> It also integrates the RTC (ds1338) that sits on the i2c Bus with e500 ma=
chine model.
>=20
> Patch was originally written by Amit Singh Tomar <amit.tomar@freescale.co=
m>
> see http://patchwork.ozlabs.org/patch/431475/
> I only fixed it enough for application on top of current qemu master
> 20b084c4b1401b7f8fbc385649d48c67b6f43d44, and hopefully fixed checkpatch =
errors
>=20
> Tested by booting Linux kernel 4.20.12. Now e500 machine doesn't need.
> network time protocol daemon because it will have working RTC.
> (before all timestamps on files were from 2016)
>=20
>=20
> Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>
> Signed-off-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> ---
>=20
> v1->v2: Expanded and fixed commit message
>=20
> v2->v3: Changed Subject line back to original and From: field to.
> my email address, moved my SoB line above first '---' and
> added Tomar's Signed-off line back.
>=20
> ---
>=20
> is it OK ok to send? (assuming it applies, compiles and boots, I test thi=
s now
> with git am, make and launching qemu with -kernel option.)

That looks good, please go ahead and send.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/GesACgkQbDjKyiDZ
s5JIIBAA5Ym3tbBLKHAXEWer5ItGpKQBN6EPU1AA8sD3hJCSJxs1htwHDxB4XX0v
XLothlbJLZbD86wCv/pHZI85kZ6ngAfp6mPUGTgaM5123mYW7eToMlKdRMQ8mmDq
AUUOcgfGmyzTQg/I/DIARgLYgypFPIT0CLgHhd/T09z/zw2tuZyH90Tt0B9VV2dO
cV8rIOx9Yhn45EUqTfJQ0QXAHA2CASLOUUrd5HAsSP+X6wDRXqqwkyuHArlRlD2A
UVhDE30uX01HRRD1zpfwBhyJ7LihfsYmXHwF5silUoZPGuxYMDySBF4K6lxl22MD
easoKzl9TmWOgM5NLYS6BA/WG2mpkByuECCHgVeQjJSHFJYYxIJ6eLpnxm23gXwX
8v6guvgeyeg2nd9jHWBzPp8TT8uPzutqDT2/or2sRZ82o7NNHSh5Actsa+HWZt5/
03vW3mxFKTENux1wUxWWIVeNYTkYhQDEgkeTSQ8ExcN5uFprO542c/A/vjkgcU9r
iY9fK91uidZYg4lVTgNzb0bTs+pB7uq2X9H2J54XUFXv2wABYIqaDsZ4c8OFRtlT
OxEMuC32/CeLuHF/7tzJItxHdssFrh0iFS0K/fofdUCF7RHy0QvB2wWapGD7ClBv
xACqDg1dzkCF6RPheOV4Wd3PWMzDIKLIaLPOIh9OucGJTmTaNKQ=
=PJa4
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
