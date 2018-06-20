Received: from eggs.gnu.org ([2001:4830:134:3::10]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXUX-0001YU-1H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVXUV-0008E4-SM
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:25:21 -0400
Date: Wed, 20 Jun 2018 17:25:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620072506.GE24636@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Misc sam460ex improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Sebastian Bauer <mail@sebastianbauer.info>


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
>=20
> Next spin of sam460ex pathces with changes according to review and
> some new patches.

So, the sm501 patches I don't really have the technical knowledge to
review, and I'm a little uncomfortable taking them through my tree,
since they aren't strictly related to ppc.

It looks like you're the only person that's made substantive changes
to sm501 lately, though.  So, given I haven't heard screaming, I think
it's fair to assume that either you know what you're doing, or you're
the only person that cares about sm501 anyway.

So, I think we should make you sm501 maintainer.

Specifically I think you should:
  * Fix the compile breakage I pointed out elsewhere
  * Split out your sm501 patches
  * Prepend a patch adding it to MAINTAINERS with yourself as
    maintainer (whether you call it "Maintained" or "Odd Fixes" is up
    to your level of dedication)
  * Send this new series direct to Peter Maydell, CC me, Gerd Hoffman
    <kraxel@redhat.com> and the SH maintainer(s) (as well as the lists
    and whoever else you think's appropriate)
  * I'll reply, making the case above to Peter for your
    maintainership.

With any luck, from there on you'll be able to send sm501 pull
requests directly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsqAVIACgkQbDjKyiDZ
s5IMwhAAgg+Z+/qAGSFJCyuiYBJioq3zwZ2iF8gbKQD4AIa7kL0oDEabbP+xqg4v
tUXwFx8BXywe4iZk5J+6LUbfLa8elVawxVqI+22vOhv2+ffx7ZEdxLb1B+5ZJtaN
3wy0P3up8oRW4CQWr/slck4m0Wf5fs3bYe7ErPwBJtBJnlnfhz2FjeFVLKhM2HvS
BWdgiOWdcGOScof2c/91AG6otajYW3kbrfX4GlyVPa1WEOWTW+OMvUJnal1iA4uu
H9uluN8Dr9TPBrVLJS+JsxNUQXMJs6NSf4C5UYowX4U1g482lsB2092KfEK/bAwb
aOaqoge5LboZ+AYT1esMsSIL0ydhtriPKs92nl1St3a8QtDpZIBMCAECtPCLqisF
E5nxkUOXDG1m7M5kDw4l/WHeghbqZ16okgW92RXzB2u3UPe8S0Ta5dmD1WSFztKL
Z0TT1dCHMs2uZDke0FWtPCMiLArA07dBezR2xWh+tfzc1R4cfcTM7F5aDY8slGCp
VB/crQ0Is2OX21ZxaUzzrCPI3sChmU4Kyz3qzaa5Yoi21MNZBssfBmmmMpXogXYe
NAD4hpp/9p7mW2tTCYPmlJkZAR7Ti5Al1f+mAxPvGbbS+rQ0EWz+L/jxGlwhJBSq
4zk2DvEaf70FbSw8B6ZO7kOWGuYqpKTq8vrm2IReAgyT1/8si20=
=wh3j
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
