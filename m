Received: from eggs.gnu.org ([2001:4830:134:3::10]:56947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrID-000462-Kq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZrIA-0008In-Fd
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:22:29 -0400
Date: Mon, 2 Jul 2018 15:22:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702052202.GY3422@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<607559ef0fd95f557b5001a5db29883f@sebastianbauer.info>
	<20180630061443.GP3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806301325320.13465@zero.eik.bme.hu>
	<20180702040239.GS3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Content-Disposition: inline
In-Reply-To: <20180702040239.GS3422@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, qemu-devel@nongnu.org, thuth@redhat.com, qemu-ppc@nongnu.org


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:02:39PM +1000, David Gibson wrote:
> On Sat, Jun 30, 2018 at 01:29:05PM +0200, BALATON Zoltan wrote:
> 11;rgb:ffff/ffff/ffff> On Sat, 30 Jun 2018, David Gibson wrote:
> > > On Fri, Jun 29, 2018 at 08:06:10PM +0200, Sebastian Bauer wrote:
> > > > Hi,
> > > >=20
> > > > Am 2018-06-19 06:36, schrieb David Gibson:
> > > > > Ok.  However, your patch doesn't apply against the ppc-for-3.0 tr=
ee.
> > > > > It looks like you've made it against a tree including some of BAL=
ATON
> > > > > Zoltan's proposed but not yet merged patches.
> > > > >=20
> > > > > Please make sure your patches are against the current ppc-for-3.0=
 tree
> > > > > before posting.
> > > >=20
> > > > The patch seems to apply now to ppc-for-3.0 without any problem as =
Zoltan's
> > > > changes have been integrated. Let me know if I shall resend the pat=
ch or if
> > > > you can use the original one. Thanks.
> > >=20
> > > Resend please.  Assuming it would need a respin, I didn't keep it
> > > around.
> >=20
> > Still avalilable here:
> >=20
> > http://patchwork.ozlabs.org/patch/931209/
> >=20
> > or here
> >=20
> > http://patchew.org/QEMU/20180618215601.8974-1-mail@sebastianbauer.info/
>=20
> Ok, applied.

And now unapplied, since it breaks make check all over the place for
ppc64-softmmu.

Please folks, running an all-targets make check is really the
*minimum* bar for testing before posting a patch for inclusion.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5tngACgkQbDjKyiDZ
s5L+4g//WchQDj1g+YzNM3c+rR6/YiS5vkeGegdFbFzLYFXGJ6kO1X9gXvvvP6nE
omojg01HVS/ersbzH3Olx631dDxah9uO9W57fHK7ZKpYoQpP5StEhPNkfFEwT76i
teARoO6rbJCFsjyKA81vbbDzV8vc5e2SF5m5WsjFrZnQkR//GsaZCXzfVi0ZUWQR
O/eOUbAJ3anxrOSWsx2gjPar463HNFAfB1d58m3IH9fRyNJYbOMGyukVoHrQZyn4
h0qrBAc9jceC74e3H3zuD0gGXNUHpnp9kVv7UcjU3VW3CKGSRMYSNvObdvu5/4Z2
LLzjaigd+eJ1m5TYU/xDj8kXfdlqpt+vmNTb2C0m3DWBzNwc3ZXgG+1rKEhtBuud
5+1UvxumNmSFNtRNWLG2Qp4lm8cRqIFX8zwlhu36KWBqa1NzdJCB3zVHOlkw24Rw
akLvvgehB/298SIJjBTAFoGwQecoz5aWylgXV5pnle5Uc4qOibuT3X2GUbySYFHd
RdlLwoAWJAwCUZXRRRpB19VFop0hHDft5gVE9YYpHsEfVIwf13UlGDpjWpbnZWwR
KpLOa6jQvHEkJ28ZxS6m9tkbiOIMJTa1iLjBBabAGuE2HYvqZ0t9Ky5XDsxddCJ4
odPAAjsbggzrb6RfdP3arCngQk8fHDjiwMarxbQzdjZywZzrWQk=
=18P8
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--
