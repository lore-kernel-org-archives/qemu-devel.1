Received: from eggs.gnu.org ([209.51.188.92]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG6-0007XC-HQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtNG4-0000Lt-DE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:53:13 -0500
Date: Tue, 12 Feb 2019 11:22:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212002223.GD1884@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-7-clg@kaod.org>
	<20190208053554.GC12810@umbus.fritz.box>
	<36cd0056-a8b6-7128-5bf4-d5a479d99d76@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <36cd0056-a8b6-7128-5bf4-d5a479d99d76@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 06/13] spapr/xive: fix migration of the
 XiveTCTX under TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 08:12:12AM +0100, C=E9dric Le Goater wrote:
> On 2/8/19 6:36 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 07:39:39PM +0100, C=E9dric Le Goater wrote:
> >> When the thread interrupt management state is retrieved from the KVM
> >> VCPU, word2 is saved under the QEMU XIVE thread context to print out
> >> the OS CAM line under the QEMU monitor.
> >>
> >> This breaks the migration of a TCG guest (and with KVM when
> >> kernel_irqchip=3Doff) because the matching algorithm of the presenter
> >> relies on the OS CAM value. Fix with an extra reset of the thread
> >> contexts to restore the expected value.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Why is the CAM value you get from KVM different from the one you
> > expect in qemu?
>=20
> An NVT base identifier is allocated for each VM at the OPAL level
> and each vCPU getd an increment of this value. It is pushed in the=20
> OS CAM line when the vCPU is scheduled to run.
> =20
> KVM XIVE names this identifier a VP id.=20
>=20
> The QEMU emulation of XIVE uses a fixed value for the NVT base=20
> identifier.

Ah, I see.

Hmm.  Really this highlights why I'm uneasy migrating the whole TCTX
as just a blob of registers, even though only some of them are really
runtime state, and others are machine configuration that can be worked
out separately at the two ends.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiEb8ACgkQbDjKyiDZ
s5Jk8RAAyJUju3U3co96XYjAHvXChTvQmKU75ty/Eb9cnhxMoeK8FIsYKDjnKoes
2so3pYcyB9ENxe0a2VOYDaIRTp7ammSlyWB2bbwlXW82bliEdxGzA/X7P9mBCt+y
OtmHPQVBg9HB96sChYcdRtRyK1n20haD90tVJ8KEbAa7DbP9WzeE9S7c1EtDXiQ2
CVCcHSRYCEbL4SwkA9W9T/QFgBl0IULW+01Nntk8TdKCzIf9WfAiYWP1K5nytZJV
u/ejBZSHQgBd8zR0oykFXgV36m6s7I3rTA5Hx2MmyMJZ0Wl0xtrsNIcOr1Z2nILG
m9Pab559NS5DeCLoefFHu4sY5MWRdjZcPd94DyaELB6bpmZSEQrMaCXnw9wEFgW+
oierTlDzGCXAbymXKh16u6ifBD3s8CUaPZekZChNGHV4VC+pbBJbrjompoGfmf2H
OZ+x7TbvjFOx8nYdPnk40RhW7/w+uPopEiKieKxFiEZPS49+VQ9+UQi+dTvKWBSH
yHt4gwq3YWqbVG3tE9F75QPfDCZA8FAJygp3lNSLV9zXmFeQB6tZIisoVkEhZ93y
iaCwtu3s+M/nXAF1m7IHsIyoBPUQ+Qyd3wNiq3Yb6KJEp5rxKpa7dN2uMjU3KRdC
0onX3fVQV4zz0c9VFOcg66+mnHGGRXIkrA1o8Nc47lfGo/SDaR8=
=5VI8
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
