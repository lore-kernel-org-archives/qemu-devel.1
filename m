Received: from eggs.gnu.org ([2001:4830:134:3::10]:34877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faAFI-0004Di-J2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faAFH-0004Mp-BE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:36:44 -0400
Date: Tue, 3 Jul 2018 11:33:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703013305.GI3422@umbus.fritz.box>
References: <20180702191345.19120-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fh0SynPkUvrWGMR0"
Content-Disposition: inline
In-Reply-To: <20180702191345.19120-1-mail@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org


--Fh0SynPkUvrWGMR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 09:13:45PM +0200, Sebastian Bauer wrote:
> Drivers for this card exists on PPC-based AmigaOS guests so it is useful =
to
> allow users to emulate the graphics card for PPC machines.
>=20
> As cirrus vga is currently preferred over std(vga) in absence of any user
> choice, this change also sets the default display of spapr machines to
> std as otherwise qemu refuses to start these machines. Not specifying an
> explicit graphics mode is for instance done by 'make check'.
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

Applied to ppc-for-3.0, thanks.

>=20
> ---
>=20
> v2
> Adds std as default display for spapr machines
>=20
> Notes
> This change will make all other ppc machines to use cirrusgd as default
> display because QEMU internally prefers that card. If this is considered
> as being too risky, setting the default mode for the other machines as it
> has been done for spapr would bring them back to the previous level.
> However, this is rarely used in the exiting code base.
>=20
> Alternatively, using the cirrusgd is possibly considered more an exception
> than the rule these days, so altering the code to prefer stdvga over
> cirrusgd may be the better solution (this should also render the changes
> of v2 obsolete).
>=20
> Feedback on how to proceed is welcome.
>=20
> The patch applies to current ppc-for-3.0 minus v1 of the patch.
> ---
>  default-configs/ppc-softmmu.mak | 1 +
>  hw/ppc/spapr.c                  | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 7e1a3d8135..6f12bf84f0 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -29,6 +29,7 @@ CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
>  CONFIG_BITBANG_I2C=3Dy
>  CONFIG_M41T80=3Dy
> +CONFIG_VGA_CIRRUS=3Dy
> =20
>  # For Macs
>  CONFIG_MAC=3Dy
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b2baec026f..0c12c404d4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3962,6 +3962,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D "";
>      mc->default_ram_size =3D 512 * M_BYTE;
> +    mc->default_display =3D "std";
>      mc->kvm_type =3D spapr_kvm_type;
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDG=
E);
>      mc->pci_allow_0_address =3D true;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fh0SynPkUvrWGMR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls60kwACgkQbDjKyiDZ
s5JL5Q/5AbXnFtmkzmNHNdQe8wVdHTlPlt4TR+RBdr140VnWRpuEj1jC8TzsYVbv
dKP0hPQmSX6vi8o4KAGIb01lDl+ocd7M5rPP/sotBB9c9kersOacHBxJDTPpfpLn
dBTc8XpKhBAhNv670qMn+Eo2bTag9AJkrYRScJYYZ7mXBICbqqARexgaM6y/4V7O
L22OkBreDiHxLFdIIzunTLREN/hF8oxEp8nEvhL/HMRFlDOeeJl21kiK0fGXJQUf
fHlUqcC8iQdaNSj3p22tdYMzeXHLfIodeAlefbfjPxty7s0lV5Gw0Tyt/v8XSotC
i9LGhROCwMbk54rdSfutJP4nOIgzJkiCFgI68XUDNaelZPwySffUeFku59ze2Jxl
fPPOmBrQSzn2R66+MCkBGF0wDIKmhLePgBrpmorPz40adKPl82Dh3X88A03aOPL7
C1dxLdAN7e9cmOrNGN3USH0I2W4HAoxhTKS8UmE1+/oKmXJfSy50/EThWfeIAiFh
iLKFADc3xouWeJ7Zx1NkMrgp54NwgS7F4bpj5Q1rn9AknNnR9Byzl15dKsifH3vE
1Q/ivX7SxkrSTEFGNApXsqMuK92ktuZEzLkuCFEAruq3F1W8QznFm3BSTt7uVJbP
iRBQiSkNJksX7PSYh5lOFkwVI6oh0bofUUTL+GYLoHyUcgcjrF4=
=NURl
-----END PGP SIGNATURE-----

--Fh0SynPkUvrWGMR0--
