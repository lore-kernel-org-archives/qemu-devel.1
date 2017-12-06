Received: from eggs.gnu.org ([2001:4830:134:3::10]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMRFT-00018Z-VO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 23:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMRFT-0004CB-0U
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 23:23:55 -0500
Date: Wed, 6 Dec 2017 15:23:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206042343.GT3057@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-3-mdavidsaver@gmail.com>
	<20171122033643.GH2380@umbus.fritz.box>
	<20171206031228.GR3057@umbus.fritz.box>
	<19583e28-9078-3f88-d5e6-49ad0c7ef937@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Content-Disposition: inline
In-Reply-To: <19583e28-9078-3f88-d5e6-49ad0c7ef937@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 02/12] e500: consolidate mpc8540 guts with
 e500-ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 10:18:56PM -0500, Michael Davidsaver wrote:
> On 12/05/2017 10:12 PM, David Gibson wrote:
> > On Wed, Nov 22, 2017 at 02:36:43PM +1100, David Gibson wrote:
> >> On Sun, Nov 19, 2017 at 09:24:10PM -0600, Michael Davidsaver wrote:
> >>> Preparation for adding more MPCxxxx control
> >>> registers.
> >>>
> >>> Use e500 SVR to enable part specific registers.
> >>> Only the mpc8544 reset register at present.
> >>>
> >>> Expose CCSR as SysBusDevice region to eliminate
> >>> e500-ccsr.h.
> >>>
> >>> Track CCSR base address within device, and map on reset,
> >>> in preparation for CCSRBAR.
> >>>
> >>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> >>
> >> Applied to ppc-for-2.12.
> >=20
> > Sorry.  I've now pulled this from ppc-for-2.12, because it caused a
> > breakage of make check (specifically the boot-serial-test with ppc64).
>=20
> Oops, I'll begin running this test myself.  So far I've only been running
> tests for i386, amd64, arm, and ppc.

I really recommend running a build and make check smoke test for all
targets ("./configure && make && make check SPEED=3Dslow") before
posting patches for submission.  It takes a while, but not stupidly
long.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloncMwACgkQbDjKyiDZ
s5LYMw/9FZ7kXLigpbFwzZylOcJd5SWUFmzCSM8zvczd44sOQM+0r9zH1jquyHRz
Z/WP3d8ePacRIkEA7fWYP/Q/BGPhssoEMI9z+8TXOcSZylsoS/DOtRaSpaI9eWN4
hpxPSXmTOnwY8bKOAZ3x+GnTJtP0bHfgyz04dxbaCfFZe8Qu3LeP7q6m75+/LBQA
Z+zE0Esj0F2scqRkbgBGVPQC+0S9Vv6UNLUoH1N6KZAqivoZfbwd4T/DtJ9YAqs6
tCltJRaNmGoNF8odLF4Y3I9c27GiH0bGlHPerIzCmR8AH8rp0HXG4nKMEAIk7fg4
wAzWtGCsxL6b2JjJsua4XTPmku+6wDEtz+O0Q7mT/cK1PHCMjxHVviugnqqtmgjU
vHh8E3hDrooqlQdaxqXobwj/Pw/wr33KByhkHr3M8Vx/+OvjthB9jtiykM43n30n
SlKdkmyLZquyuyIPm6/mz7Cf74WELQB8/HxStFebEE95Ao2awV4GfaTxaBWqiGlx
6vaHv13dQJmDD5NEwiAGKc/qcfyGINz9u59PRIkQ3lqVs0+6q8JaHHtiRiMb3a0d
Jp688OvBUNXRQmgTPm+JO3xMjCwOBWqf4FCrL+UYFJtjh6mXMdE/2aeYRYmdrSf7
lu8dwuWS53ts8Dn3BUONJ2lkQApAIjtciUhliSh8w4KZ9IKNL0g=
=RX5R
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--
