Received: from eggs.gnu.org ([2001:4830:134:3::10]:45384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE04-0008Cl-MD
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE00-00005E-Nl
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:44 -0500
Date: Mon, 27 Nov 2017 18:15:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127071504.GF11775@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<2e4d338f84913729f8ab51837fbcb94b0958a745.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <2e4d338f84913729f8ab51837fbcb94b0958a745.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 07/17] e500: fix pci host bridge class/type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:05PM -0600, Michael Davidsaver wrote:
> Correct some confusion wrt. the PCI facing
> side of the PCI host bridge (not PCIe root complex).
> The ref. manual for the mpc8533 (as well as
> mpc8540 and mpc8540) give the class code as
> PCI_CLASS_PROCESSOR_POWERPC.
> While the PCI_HEADER_TYPE field is oddly omitted,
> the tables in the "PCI Configuration Header"
> section shows a type 0 layout using all 6 BAR
> registers (as 2x 32, and 2x 64 bit regions)
>=20
> So 997505065dc92e533debf5cb23012ba4e673d387
> seems to be in error.  Although there was
> perhaps some confusion as the mpc8533
> has a separate PCIe root complex.
> With PCIe, a root complex has PCI_HEADER_TYPE=3D1.
>=20
> Neither the PCI host bridge, nor the PCIe
> root complex advertise class PCI_CLASS_BRIDGE_PCI.
>=20
> This was confusing Linux guests, which try
> to interpret the host bridge as a pci-pci
> bridge, but get confused and re-enumerate
> the bus when the primary/secondary/subordinate
> bus registers don't have valid values.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.12.

> ---
>  hw/pci-host/ppce500.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index f2d108bc8a..8073d396ff 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -423,11 +423,6 @@ static void e500_pcihost_bridge_realize(PCIDevice *d=
, Error **errp)
>                                                        "/e500-ccsr"));
>      MemoryRegion *ccsr_mr =3D sysbus_mmio_get_region(ccsr, 0);
> =20
> -    pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
> -    d->config[PCI_HEADER_TYPE] =3D
> -        (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION) |
> -        PCI_HEADER_TYPE_BRIDGE;
> -
>      memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", cc=
sr_mr,
>                               0, memory_region_size(ccsr_mr));
>      pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobu3gACgkQbDjKyiDZ
s5KKNg/9HbnxsUetMeINTLBEndYdWhlxQYbcW8qKIUW6vsPxOeXIvMsWBQ7jRzch
kumbuLbxf60LcxeAdVA1MjHOchlGzdD97+ZVnR4m4CUTJWo9UW+AMMQI3786YBn2
9FJKsSbES0JlCGnG0hz/Vra8M+gBZZmJCffe5FkiSny28VTdTA0qCoCcQkkNi3ei
atUvw4CnSNgWinTJT5ID2Ls3//xkJ8V1faS+n4p207SmBFL/Oq2iktr+Zk/lRCfN
hoZKrYbNj1z47FTxvW+wJJbq44/aXIp3RlTXnhMtxUoNpypkfFDyUVJRWDy1tito
6yMkHe3e+S0f53/ypEEsiirH2QF9lrD71r3x4nus/UIXr2pRvOkDak8UerEWSgKr
mWKN2KOqZYjTksRPm8+OZtVlENr6/2/rdCdNvQPJ7z13Aces1QuV2VaesytUeg5s
wInIEnxs1uaAwsfVVXmOT8rg17NDHucRmEBkyjcoSMzZzNM9qfhqS8rj+h53vcnm
GeMJ/f7Nbfa6ntD7IB3tJIfFehiHknTloXpKlyEcpNdzlLm109wzN6BNOGsFgOqU
TeJt3/fiGkc8LPzNv4ztRopDBBDsK1ZBAOgy5AxvcrDpVbNqHdGqfqBL78SmqjAs
xDw9GI6hWH0CBwcS1piC7jwbASnroXRKLk+Nmfklv19KoKRB8Wc=
=acm7
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
