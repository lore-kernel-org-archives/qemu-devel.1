Received: from eggs.gnu.org ([2001:4830:134:3::10]:53352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02q-0004Fj-9S
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02m-0002D4-D3
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:52 -0400
Date: Wed, 14 Mar 2018 16:40:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314054028.GJ4182@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 00/19] uninorth fixes/mac_newworld board
 wiring improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:44PM +0000, Mark Cave-Ayland wrote:
> [This is for New World Machines: there is a follow-up patch for Old World=
 Machines]
>=20
> This patchset is a combination of uninorth fixes/cleanup with the final a=
im
> of removing the remaining custom init functions and switching IRQ arrays =
over
> to qdev GPIOs.
>=20
> The first couple of patches apply some style fixups and remove what appea=
rs to
> be an obsolete set of uninorth registers according to my testing.
>=20
> Following on from this, the next few patches QOMify the PCI/AGP host brid=
ges
> and change the existing _init() functions to return the device itself. Th=
is
> allows the memory regions to be setup during device init, and using a tem=
porary
> qdev pointer property allows moving the remaining initialisation to device
> realize.
>=20
> Next we fix the mixup between the PCI/AGP host bridges making sure that t=
he correct
> PCI bus instance is instantiated for the corresponding host bridge , and =
enabling
> the third PCI host bridge. This allows potential handling of any accesses=
 although
> it should be ignored for all OSs that correctly parse the DT since OpenBI=
OS currently
> only supports (and exposes) a single PCI host bridge.
>=20
> Once the legacy _init() functions have been removed and all devices are
> instantiated via the qdev API, it is then possible to wire up the PCI IO
> space to the relevant PCI bus.
>=20
> After this we implement a separate uninorth device (equivalent to uni-n i=
n the
> Mac New World DT) as suggested by the TODO comment and wire it up as part=
 of the
> board initialisation.
>=20
> Finally once this is done we can remove the temporary pics IRQ array and =
instead
> wire up the macio_newworld device to the PIC directly using the existing =
object
> link.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I'm afraid I haven't been able to have enough of a look at these in
time for the 2.12 soft freeze, so they'll have to wait until 2.13.  I
have started a ppc-for-2.13 tree though.

>=20
> Mark Cave-Ayland (19):
>   uninorth: trivial style fixups
>   uninorth: remove second set of uninorth token registers
>   uninorth: QOMify PCI and AGP host bridges
>   uninorth: remove stray PCIBus realize from mac_newworld.c
>   uninorth: move uninorth definitions into uninorth.h
>   uninorth: alter pci_pmac_init() and pci_pmac_u3_init() to return
>     uninorth device
>   uninorth: move PCI mmio memory region initialisation into init
>     function
>   uninorth: introduce temporary pic_irqs device property
>   uninorth: move PCI host bridge bus initialisation into device realize
>   uninorth: fix PCI and AGP bus mixup
>   uninorth: enable internal PCI host bridge
>   uninorth: remove obsolete pci_pmac_init() function
>   uninorth: remove obsolete pci_pmac_u3_init() function
>   uninorth: use object link to pass OpenPIC object to uninorth
>   uninorth: move PCI IO (ISA) memory region into the uninorth device
>   uninorth: rename UNINState to UNINHostState
>   uninorth: create new uninorth device
>   mac_newworld: remove pics IRQ array and wire up macio to OpenPIC
>     directly
>   mac_newworld: move wiring of macio IRQs to macio_newworld_realize()
>=20
>  hw/misc/macio/macio.c          |  37 ++--
>  hw/pci-host/trace-events       |   2 +
>  hw/pci-host/uninorth.c         | 415 ++++++++++++++++++++++++-----------=
------
>  hw/ppc/mac.h                   |  20 +-
>  hw/ppc/mac_newworld.c          | 124 ++++++------
>  hw/ppc/trace-events            |   4 -
>  include/hw/misc/macio/macio.h  |   1 -
>  include/hw/pci-host/uninorth.h |  65 +++++++
>  8 files changed, 404 insertions(+), 264 deletions(-)
>  create mode 100644 include/hw/pci-host/uninorth.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqotcwACgkQbDjKyiDZ
s5KEKxAA1NzZqSmnEEIzTZzCdsNIcdwHkFTu80xf9bxKM5XAnnqTPPHxeL/1DHtc
JsTLx5BM3hIjDdB2p/Pb/kNGYntIW//fyhHVOaTYonpx1CtzQJcdtpDczXz+NOvA
9eqLlwimGpp1uIZM/qsCqx63OKuOpyep338+4SkRPbpVu0dKLTmcldgHh/gaS/Nv
eQ/XlujiW7vC8vWm7YvHo7lb00eIJTzwwPtzRvutsqbgtiYH6/GreZMtablv7i6G
F7F8Zgc4CbKnIRcdgBOjBZfPdDDpXwV3nLUHJEhm4m3eEmEEdHtBcQoaZTmpwots
fyBSDryU2j6Euwgppr4IGs9QcmVZY2E9N8/qVi+UI7fw8QMYzRVlU6x1L4RHdq7G
mvgdj6vhDRpkUuLpT8RF9bLm2+Fvkxa5S3xmHK7unWLXvT/+Kgzh1JB+NKOXwQJQ
6r9FtI/yBODRZZFHso8aeWRnVSHPrflUM7EK0stjSDSB2+s1MDSpsbgMHSr+tzb0
OBF/nWJaLeEAXy8EZz22+c7ql1E560mzjJgt0bnyJfYuB4rQWggIB4xmKzSJqCzw
vmCfBLG6G+wJ31SGF0efybMWK2+tKn43Ubo/LI0U1k37oggVyB0SC41zEd0l7bsH
Q4m9Hw0brLpzAE6jyTr22Spgf2NoLBDjEabcSkosZm9TSFJ9gkY=
=EGt2
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
