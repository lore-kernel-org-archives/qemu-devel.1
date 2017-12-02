Received: from eggs.gnu.org ([2001:4830:134:3::10]:55923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLHHh-00051P-Mj
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 18:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLHHg-0000q7-OD
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 18:33:25 -0500
Date: Sat, 2 Dec 2017 12:33:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171202013353.GC2130@umbus.fritz.box>
References: <20171201160604.15265-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <20171201160604.15265-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] spapr: preliminary cleanups before
 introducing XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 05:05:59PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> These are initial patches of the XIVE patchset which prepare ground
> for the integration of the XIVE model.

Applied to ppc-for-2.12.

>=20
> Thanks,
>=20
> C.
>=20
> C=E9dric Le Goater (5):
>   ppc/xics: introduce an icp_create() helper
>   ppc/xics: assign of the CPU 'intc' pointer under the core
>   spapr: move the IRQ allocation routines under the machine
>   spapr: introduce a spapr_irq_set_lsi() helper
>   spapr: introduce a spapr_qirq() helper
>=20
>  hw/intc/trace-events        |   4 --
>  hw/intc/xics.c              |  34 ++++++-----
>  hw/intc/xics_spapr.c        | 114 -------------------------------------
>  hw/ppc/pnv_core.c           |  10 +---
>  hw/ppc/spapr.c              | 133 ++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_cpu_core.c     |  14 +----
>  hw/ppc/spapr_events.c       |  16 +++---
>  hw/ppc/spapr_pci.c          |  10 ++--
>  hw/ppc/spapr_vio.c          |   2 +-
>  hw/ppc/trace-events         |   4 ++
>  include/hw/pci-host/spapr.h |   2 +-
>  include/hw/ppc/spapr.h      |   7 +++
>  include/hw/ppc/spapr_vio.h  |   2 +-
>  include/hw/ppc/xics.h       |   8 +--
>  14 files changed, 187 insertions(+), 173 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloiAv8ACgkQbDjKyiDZ
s5LzuhAAv9rvoc9rVMAEz8GToZqzcIDu7/szZJsjqZF3dyypRrujSoHLT/Zbgw/x
ghURSpizKsEo3AjzL7JRVTqCC20PB71v7FjnaLSHkqiqGtEGubjBjqImgpJlUCEC
bnhZ4XCwn0Ry+Cd+kuwrqYXTXh3I/5cmfuZ3SvZrPo0hFE3AweDCbET51qHe9R7H
n+iEWC0s/WX+NhKmK/Ebgsgw5tp8jHFGB2NNOHLvNU2TSUfsmCYfX41dmButLN/S
P9ZTTNtEaNILQwaps6fOpyI5xCN7WxuZXhHfjDAYNeR8M+yz4tR7DUo/lJ2LSBs2
uI2egKuTjJ/A1twOrWD5gSBr6nENp1hsnNFGTSAjqU2Nep3I3fbOqJ64Su9DE6XH
dTs/8YjF5FdMFFLic7WOzcpx71I+BN3rzXkHx65P16ZVenHZGAhrSbkvMQ0+goEg
B7yeK4MdrRd0cDUHiNirshAtvEl0iXPe1EcdpDzVerQk8YRmz/154IDv0TYfn0QX
CpF1UERatRjvh6jn+HSr2u3+eiZYxV4nkjMnjpjLldjocecSdm1Qd8Ry/3j0NrlN
YwpNb9qjawKOLnMRTUjok6gXBnleKYlx4srzlz9IrEP2saAnLTXAS9bAM3ON8+0m
pUSxO6oDdnyfKA1oLkStYuO63Wd0v92hKP2+sPdYsxGd7iKLrP4=
=ZmxT
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
