Received: from eggs.gnu.org ([2001:4830:134:3::10]:53074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fy5e0-0004u5-4B
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 21:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fy5dn-00072F-Na
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 21:33:02 -0400
Date: Fri, 7 Sep 2018 11:32:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180907013240.GE26021@umbus.fritz.box>
References: <20180904194903.20712-1-hpoussin@reactos.org>
	<20180905001349.GI2679@umbus.fritz.box>
	<352cb605-d2d3-e5de-bc5d-c1924b3fc793@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <352cb605-d2d3-e5de-bc5d-c1924b3fc793@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc: on 40p machine,
 change default firmware to OpenBIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 05:38:26AM +0100, Mark Cave-Ayland wrote:
> On 05/09/18 01:13, David Gibson wrote:
>=20
> > On Tue, Sep 04, 2018 at 09:49:03PM +0200, Herv=E9 Poussineau wrote:
> >> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
> >> Use it, instead of relying on an unmaintained and very limited firmwar=
e.
> >>
> >> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> >=20
> > Uh.. against current ppc-for-3.1, plase.
>=20
> I was a bit confused as to why this failed to apply since the original
> had been part of a local branch for a while, but just noticed it was
> because of this change to Herv=E9's original which I had missed:
>=20
> [dwg: Drop prep from boot-serial test to avoid deprecation warnings]
>=20
> Included below is the new diff against ppc-for-3.1: David, is this
> enough for you to be able to fix up manually without a v3?

Well, I could have fixed it up manually from v2 - but I'm pushing that
busy work back on you as a contributor, because I'm having trouble
enough finding dtc maintenance time as it is.

> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 162b27a3b8..baca1d7c04 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -651,7 +651,7 @@ static void ibm_40p_init(MachineState *machine)
>      /* PCI host */
>      dev =3D qdev_create(NULL, "raven-pcihost");
>      if (!bios_name) {
> -        bios_name =3D BIOS_FILENAME;
> +        bios_name =3D "openbios-ppc";
>      }
>      qdev_prop_set_string(dev, "bios-name", bios_name);
>      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index f123b15e3e..f865822e32 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -75,12 +75,12 @@ typedef struct testdef {
>  static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
>      { "ppc", "ppce500", "", "U-Boot" },
> -    { "ppc", "40p", "-boot d", "Booting from device d" },
> +    { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },
>      { "ppc", "mac99", "", "PowerPC,G4" },
>      { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
>      { "ppc64", "ppce500", "", "U-Boot" },
> -    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
> +    { "ppc64", "40p", "-m 192", "Memory: 192M" },
>      { "ppc64", "mac99", "", "PowerPC,970FX" },
>      { "ppc64", "pseries", "", "Open Firmware" },
>      { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluR1TgACgkQbDjKyiDZ
s5LmrA//XZtI2GJJ8yiVLeBWFFgePn9QxwdNr6x4JF+a0qu/JpaPXK41il+8nK1g
+Hs+feLbAza8o2ZZiv/Cr0Mzmw/iQcP+JkA/6ry9jS4NXFg/IL+FMEYyqMPvDgCT
STQKQmSog0GA2l8kTXTMHTnRadXbEM3G94lj2DbiPWH1+5XCk2N7Reb6AtTsUoCc
fY25QeW6iIglvrGP0imJESPPbym6DgiEX1IaFD1QX6DhIZSWSNfBOVTHNiI66rv0
0CkHLkjcDPBNeMWkvqbEQpi6H7+Iui9QO1fQesju8RXeaWygtaLvyd9ipvhPeX3k
8fuJ3Ao0Wg3RLIdcqNOkuS8zcO4uBot5I/AdSkJhQzdzl5fm6FydDrzAer6q3xTM
sjzRZZoALSnoGGITQ2OVfbb4zUqZr/F1Of1GyqkPp5IWNP738Nb6tJMYG9SGOHsL
/NhZXgP9KjVvKtlPWHoy2sBBAYMMWpP/Sxn0k55pS+IevpCtemBk5Kz5LZP5x8ha
ynB38BgMrc/2DEH+lAEjDWzRmhcQFppl3HEj8LeOD1kJvk9s6tLwRc8ij+XX9ocQ
8zQWeMMRO1Lj7oM8MQIgmIwWMEcHzhYN2k85+t11qJgJeHjSQZq4wta5hBmmqUmi
R+4jmMbI/1UyKASpTRCjY9D/af5s/lqxv2TEn3oqydN61AQNj88=
=IySE
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
