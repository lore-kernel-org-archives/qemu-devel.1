Received: from eggs.gnu.org ([2001:4830:134:3::10]:56757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dpUv0-0003Ig-Jb
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dpUuz-0001HC-7e
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:38:38 -0400
Date: Wed, 6 Sep 2017 16:56:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170906065658.GF2735@umbus.fritz.box>
References: <1504550378-2291-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1504550378-2291-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170905011343.GD2735@umbus.fritz.box>
	<20170906031619.GE2735@umbus.fritz.box>
	<f6d2df4e-a67d-a601-40a1-0c9d0d610eec@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
In-Reply-To: <f6d2df4e-a67d-a601-40a1-0c9d0d610eec@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/1] net: Add SunGEM device emulation as
 found on Apple UniNorth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2017 at 06:21:08AM +0100, Mark Cave-Ayland wrote:
> On 06/09/17 04:16, David Gibson wrote:
> > On Tue, Sep 05, 2017 at 11:13:43AM +1000, David Gibson wrote:
> >> On Mon, Sep 04, 2017 at 07:39:38PM +0100, Mark Cave-Ayland wrote:
> >>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>
> >>> This adds a simplistic emulation of the Sun GEM ethernet controller
> >>> found in Apple ASICs.
> >>>
> >>> Currently we only support the Apple UniNorth 1.x variant, but the
> >>> other Apple or Sun variants should mostly be a matter of adding
> >>> PCI IDs options.
> >>>
> >>> We have a very primitive emulation of a single Broadcom 5201 PHY
> >>> which is supported by the MacOS driver.
> >>>
> >>> This model brings out-of-the-box networking to MacOS 9, and all
> >>> versions of OS X I tried with the mac99 platform.
> >>>
> >>> Further improvements from Mark:
> >>> - Remove sungem.h file, moving constants into sungem.c as required
> >>> - Switch to using tracepoints for debugging
> >>> - Split register blocks into separate memory regions
> >>> - Use arrays in SunGEMState to hold register values
> >>> - Add state-saving support
> >>>
> >>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>
> >> Applied to ppc-for-2.11.
> >=20
> > Until I discovered that it breaks compile with
> > --enable-trace-backend=3Dust.   So I've removed it again.
>=20
> Oh that's interesting. I've had --enable-trace-backend=3Dsimple as part of
> my default build for a long while now, so I'm quite surprised that the
> trace-events are backend sensitive.
>=20
> Any clue as to what the error might be before I go and start installing
> the relevant libraries?

Not so far.  I'd investigate myself, but I'm actually really sick
right now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmvnDQACgkQbDjKyiDZ
s5LprQ/+OkZRNorwpa2Ed4YFqGGEKL7T1v2iGN5/O4KrmPJ5ANSH/u2DhMHyds7m
4zWKXczyFVT/1963wCInVwaG76CTmyS2UpD/HjF3RcqkBd8s5YSfwILYzBcMqh7B
/FFVMtF2pWeQ5MAxBH6VCvvGlrd9iJLiqvrYbtphEb/ir0yCf0s5JL3GayJOF+KI
3a2S3HR5SL9Ee03caBAOVlC4YSqIBIeNR9qEFhb9rCpKUykF5Kth6MsSFHyhAJgd
tiVh4LAbOGGPrXLVYgusvlOtbyHnGT12Hu5HKGxasHef0pjFlmhp/S60dUq6vzNn
U5ljqfXBxSXktk29ZCMUciV6PyhnYZiUCsEBUi8cwIxaBSchH8OE5Drh67L/XcJx
SLlz35Vn5qITVHpuhhLiCsBtWFX0uQ3nhVF4Wtqx2vZTPE1x7RfYJIHuaaoHhjXT
Z3AP3Jt57Ph8K9aPiRpeI3gilPlbuuLhsfTXQD9hr7fhRvKU9UwSGu0D3T8tf95R
ugPW37BYqdf1IVfL00xnTypN5gH9pVbjI3b7gCLyz54uD21t38PKIetWrSnsrHcj
ixF4sI0UvfpHlhn8jaJ43aVA+DMIM437s2eePdmpaTc+UqYeVqmFRkQM2lu3g4C1
hmYyoB09hAihChZfClzSF+VPVE8/be6Yd7d+SswsVp/Pj4xSjQs=
=cu5I
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
