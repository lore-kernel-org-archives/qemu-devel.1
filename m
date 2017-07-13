Received: from eggs.gnu.org ([2001:4830:134:3::10]:39056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSdv-0000A3-Nx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSdr-0004It-OO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:10:11 -0400
Date: Thu, 13 Jul 2017 11:09:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713010957.GS4083@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MdJ3p2aQbVp3YFXz"
Content-Disposition: inline
In-Reply-To: <20170712055317.26225-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCHv2 0/8] spapr: DRC cleanups (part VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, groug@kaod.org, danielhb@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com


--MdJ3p2aQbVp3YFXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 03:53:09PM +1000, David Gibson wrote:
> This sixth set of DRC cleanup patches is a complete rework of DRC
> state management.  We stop tracking some unnecessary things, and
> change the basic state representation to a simpler and more robust
> model.
>=20
> Many of the patches in this set "break" migration from earlier git
> snapshots, but not from any released qemu version.  The previous
> migration stream format had multiple problems, so better to fix them
> now, before 2.10 is out.
>=20
> Although there are certainly more things that can be improved in the
> DRC system, with this series we should have a solid foundation for
> migrating DRCs - the state trasferred is about as minimal and well
> defined as it's possible to be.

Thanks for the reviews.  I've made a few tweaks as suggested.  I'm now
sufficiently confident of the series, that I've merged it into
ppc-for-2.10.

>=20
> Changes since v1:
>   * Rebased onto current tree
>   * Added cleanup to unplug path
>   * Added restriction of DR-indicator to physical DRCs
>   * Included revised version of Laurent's patch to correctly handle
>     things "hot" plugged before incoming migration
>=20
> David Gibson (7):
>   spapr: Remove 'awaiting_allocation' DRC flag
>   spapr: Simplify unplug path
>   spapr: Refactor spapr_drc_detach()
>   spapr: Cleanups relating to DRC awaiting_release field
>   spapr: Consolidate DRC state variables
>   spapr: Remove sPAPRConfigureConnectorState sub-structure
>   spapr: Implement DR-indicator for physical DRCs only
>=20
> Laurent Vivier (1):
>   spapr: Treat devices added before inbound migration as coldplugged
>=20
>  hw/ppc/spapr.c             |  89 +++-------
>  hw/ppc/spapr_drc.c         | 399 ++++++++++++++++++++++++---------------=
------
>  hw/ppc/spapr_pci.c         |  17 +-
>  hw/ppc/trace-events        |   3 +-
>  include/hw/ppc/spapr_drc.h |  74 ++++++---
>  5 files changed, 301 insertions(+), 281 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MdJ3p2aQbVp3YFXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZshjAAoJEGw4ysog2bOSN9AP/RRcMh/L+hq+u7EzX0fmziei
SLNByl9r6WudERZi55MtQca7AD+jVW00Hloo4Tiy7+5rkgSxLmKL2fB/p0OtJNRE
iry6iIkKmOvFliUFoOsFjuLpZ5B7hURIBOq6jmKvbts4crw2R8aw/hgvYJdSaknp
1n+4NZ5AfHraGuDE2Fsp1UIbNr8j6Uq82VkLJIxGdSrDJU4FmLW9c0fna3fxfKiO
9rD1S4h1y7x8nQv1vs2gd739LCCPxWHVOX+4WLxTymmHDKVxE1Zzld1eW8HX3Fn7
T0lTnuI6aA4rf+FP7hGEEu26AbjmSRn2egm2+7eEffv8du/nccaiKcT/0lQdKypJ
58jRVkbWaJTWjD/jv6FtQte48y2VfFWRJ+epl4UAALRNNapXeTTkcKYyWXFb4MCs
m3mZhBSQdCvE0Qb7WsRX3VQCwF3cXO5QlMQ3zGbyhUEF2hLnPX6REp29NPSfxfAp
REftMGXdp/STxg4mnqUO7I076pnLZnqNocPAKkXBPm23ANpxJjfHnE/P9lL18Qg4
EkZU04Rn4A405ijP+4dxODXHtumbolfjx8Y+2ek4pLKNaUTcBp+eDQIbYeblb/gS
sRUiZU0GYb3DWc4y8/Q08DHlln5rGvT0vxo41EipDJtjBH77wnJ6J3Dbo+NL52Rk
ERDONcmiFGXUkWpISSZG
=/x69
-----END PGP SIGNATURE-----

--MdJ3p2aQbVp3YFXz--
