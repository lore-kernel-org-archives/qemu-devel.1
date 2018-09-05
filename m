Received: from eggs.gnu.org ([2001:4830:134:3::10]:44132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fxMUR-0006Uj-Td
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fxMUO-000128-Ha
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:20:15 -0400
Date: Wed, 5 Sep 2018 10:13:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180905001349.GI2679@umbus.fritz.box>
References: <20180904194903.20712-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline
In-Reply-To: <20180904194903.20712-1-hpoussin@reactos.org>
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
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 09:49:03PM +0200, Herv=E9 Poussineau wrote:
> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
> Use it, instead of relying on an unmaintained and very limited firmware.
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

Uh.. against current ppc-for-3.1, plase.

> ---
>  hw/ppc/prep.c            | 2 +-
>  tests/boot-serial-test.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 3401570d98..1558855247 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -736,7 +736,7 @@ static void ibm_40p_init(MachineState *machine)
>      /* PCI host */
>      dev =3D qdev_create(NULL, "raven-pcihost");
>      if (!bios_name) {
> -        bios_name =3D BIOS_FILENAME;
> +        bios_name =3D "openbios-ppc";
>      }
>      qdev_prop_set_string(dev, "bios-name", bios_name);
>      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 952a2e7ead..276ca14c97 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -76,13 +76,13 @@ static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
>      { "ppc", "ppce500", "", "U-Boot" },
>      { "ppc", "prep", "-m 96", "Memory size: 96 MB" },
> -    { "ppc", "40p", "-boot d", "Booting from device d" },
> +    { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },
>      { "ppc", "mac99", "", "PowerPC,G4" },
>      { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
>      { "ppc64", "ppce500", "", "U-Boot" },
>      { "ppc64", "prep", "-boot e", "Booting from device e" },
> -    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
> +    { "ppc64", "40p", "-m 192", "Memory: 192M" },
>      { "ppc64", "mac99", "", "PowerPC,970FX" },
>      { "ppc64", "pseries", "", "Open Firmware" },
>      { "ppc64", "powernv", "-cpu POWER8", "OPAL" },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluPH7oACgkQbDjKyiDZ
s5KgNBAAzQpZJZGZiuJTVzWGkuVsCabNtf2nclUCSvnbqq1APwukQ+0Y65mW5YUS
wuZYsknvG4pwyHJ/trJe6xJc9fq2sZYRdNzhgyDygnz3acJcEi79ez2pF1gWR8h2
siUYYVqJ1gORSqv6wmTBkkcbKL4H3LrJgqY3E9GnqKhGfx3V29iARWXMy7nOMX2f
fqpM1SSGi4Tu5IZW3XTqUyLPL6u2OVmlAk6YS5R2czArF0/krfJyyol7iF5XsKiC
K0vkXimnxU4nktHLmY5EfkKJCufTYvoPmfwPgTMCw/O71hnuSQfWgEdrl1d2+qM6
Xy34AO/kqZ0jxKAKgibNn1qbPIWUoA8LQFzJb1CV7JYLYAbHi+zbktVdpiBf+ogT
mm5FP1+1qRMU0ai5XTxcbbbOGutszGftwXMIVHT3Pl25C2KYUzkXyp5ARPUKiZQf
Fp+GDibeSF2BUbZ6R7CUd+ZJDs9Z7DuyjhNFBicHiA8Sh+NLpCx7TIrs9mAJzp7M
sIUgKarTgqyEDBwJ5KwlAicEGJX5NDjEQjZu21/r5+aNS7BZjcBbtEjYvCgYj1vW
48VVme7jN4mdAu3slP0XOSQkI+6RoxQreJ01pEJHH8ki6foR+nrjBxHZVBmdy19F
RX9RJYU/WZHZZZTyvzVSwqRs2kvne7UxzBPCbMfIM04Mr/LI15Y=
=uFU5
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
