Received: from eggs.gnu.org ([2001:4830:134:3::10]:33671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDpp-000288-K9
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDm5-0005z5-7H
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:26:12 -0400
Date: Mon, 10 Sep 2018 12:49:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910024921.GC2890@umbus.fritz.box>
References: <20180908161421.18089-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20180908161421.18089-1-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH v3] hw/ppc: on 40p machine,
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
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2018 at 06:14:21PM +0200, Herv=E9 Poussineau wrote:
> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
> Use it, instead of relying on an unmaintained and very limited firmware.
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

Applied to ppc-for-3.1, thanks.

> ---
> Changes v2->v3:
> - rebased on dgibson/ppc-for-3.1
>=20
> Changes v1->v2:
> - rebased on master
> - fixed tests
>=20
>  hw/ppc/prep.c            | 2 +-
>  tests/boot-serial-test.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluV268ACgkQbDjKyiDZ
s5I+CA/+O2yXw0BtgtJrPorT9gBdaM6R5QDtlSIoOZqRmuNa5Hmt/sT1z3g8rvsZ
/4ScVbnJNJNOFf3ZrrGh/WYH0doExkuNxqOV+AZwgcLWXXP68JdjjxNFwFOfY098
KzquoUVi/D7n9nVH0pJEu793WYFXKth5Ewu9CwKOYUclkOiyR8kPixeF8ZwrJ0Fe
BprMYbENDPIFiKlb4Ip8enIY5fSB7Tfx3KNOTOrgvwRMM0Oh8YAD8WXbrLKIu7BA
Pf2XH2YwwQCjfH64Jzxd8XS/WoCxMiWejLGSZncXxYQr7tfrYogF3W0Atrz9rBen
2ot4ptzpLtCH3aZkYEpeQdS7+OvuSVwB8mDBBO54N/A6yu5zAhuzNJ8wBMXdt469
71YueqHjVg40yxjhR8MskOEFfMlE/LxfcTEg7wd7Ykq2PoDdfUwwCdS75Wle5yHw
stUesBC6+lELop/sHpDiSkH9h5yrVBBHkUMC9zA9CnLR/JHiwQLXSTFXtgjvqtDh
I0bNn2A/LEfmOVGYrZXgwaFYZvULl9IRht/IkYpuy97BLHnHmzCI8JzGLY0XPgRp
t838KaVX85/A8QpU3PNGO+sO9MICWPMy+w35X7m5FpeawPea41SSr6yeOEAdXdtl
dhohWsbtn1TqsOr+giFcskFbGqqKnBNmKay3/Hy8pBqxzakZZKg=
=n2b8
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
