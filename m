Received: from eggs.gnu.org ([2001:4830:134:3::10]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fetzI-0003NX-0o
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 23:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fetzG-0004zJ-TM
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 23:15:48 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fetzF-0004xX-PQ
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 23:15:46 -0400
Date: Mon, 16 Jul 2018 12:53:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716025346.GF2599@umbus.fritz.box>
References: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1807151041060.88858@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] hw/display/sm501* status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>, qemu-devel@nongnu.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2018 at 11:29:56AM +0200, BALATON Zoltan wrote:
> Hello,
>=20
> I plan to make more changes to sm501 emulation to make it more usable for
> AmigaOS and other Amiga like OSes. This would include first cleaning up of
> current state, then trying to optimise 2D ops and display updates because=
 it
> was found these are currently quite slow. (Especially when using 8bit or
> 16bit screen modes as AmigaOS does where every screen update does pixel
> format conversion with a simple loop in a suboptimal way. Maybe we can use
> more optimal pixman routines for these.)
>=20
> We have found while merging previous patches that the status of sm501 is =
not
> clear. It was originally part of SH emulation added for the R2D board but
> now it's also used by PPC sam460ex board (and can be used with mac99 as w=
ell
> to run MorphOS that does not yet boot on sam460ex). David Gibson, the PPC
> maintainer has indicated that he can't review changes to this device and =
it
> is not really related to PPC so the practice of merging sm501 patches via
> his PPC tree is not preferred.
>=20
> So before sending more patches I'd like to clear who can review and merge
> patches for sm501 in the future and what is the maintainership of this
> device?

The unfortunate answer is that there isn't any great choice: that's
basically what having no maintainer means.

I suspect Gerd is the most qualified to review patches to this
technically, but even then that's only by general familiarity with
display devices.

At Peter's request, I'm willing to take sm501 patches through the ppc
tree.  Since I can't review the patches in depth, I'd be pretty much
taking anything you send unless there's something obviously bogus.

=2E. which would make you de facto sub-maintainer of sm501.  Given
which, I encourage you again to become *actual* maintainer; there
really is no-one better qualified at this point.  I realize that you
don't want to make a big ongoing job of thise, but AFAIK that's
exactly what the "Odd Fixes" maintainership status exists for.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMCLgACgkQbDjKyiDZ
s5KPJhAAi+NPvdyUlqP09e4JTIYqxIQGyyuplLerLchg21LBP9hkVzZEXI79Y5A5
cdi03Gtz6IV8N87hy/cC9umVSIlqh+5W4Q91xurTAKozL3pNFwox+V+JpUympHrw
z/eCRewvDjUG4UlXISN7MAemzzTP2YeUAFhTmzt91sgq8jco48uWX/Rz67dJKQb7
j6UmyWJe5xCJRZv8qN5V0YdxPJKk6tspaezVE1uZx9mQZgL/+NivFM55t701eXxP
T3ghkh7JvCRObK7ZRiVH95UB8Ku4azIYAH2BmIUQv2ZYydCNYD8vxkUe6LBBUDGR
n/9Hv2dUtf1Uf9DzLKsjWrA4g+bp+pKF+tLxe8iToa0ZjVnN75t+XZ018gl/9QxL
2Oog/XaChV1mdoAzrv2snWBJboFhkS8y4HIyvCRGJ0k7DzKnXA06Z82gn3NP1DEX
1hYqIOEG6UkZNPaJ3kxq/qCbB3i/j0o2e4kgK+zuOTDyKBPDcmFm+BfGAbgkB2zU
Kjm8L+dQfmLGIc2yySLTy7CnGWGC60OlHehKD/b2Q7KsM6SQpynPPlc4sQlWVlaU
jwFlkCgQtVZ/xEgMkDE7tF6qxXvAh3S0rOFAqBDP7i8qxaxi+ZniIOTYboXfix3w
NIqyUQSSTXKbdaBXYH+fWTKqRYYCmXYcvqyWdAOSUWI2b12m0Ac=
=nGde
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
