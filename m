Received: from eggs.gnu.org ([2001:4830:134:3::10]:42623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etQbS-0003iK-Fd
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etQbR-0003cR-BJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:22:58 -0500
Date: Wed, 7 Mar 2018 15:11:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180307041127.GJ3083@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 02/19] uninorth: remove second set of
 uninorth token registers
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


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:46PM +0000, Mark Cave-Ayland wrote:
> Commit 593c181160: "PPC: Newworld: Add second uninorth control register s=
et"
> added a second set of uninorth registers at 0xf3000000.
>=20
> Testing MacOS 9.2 to MacOS X 10.4 reveals no accesses to this address and=
 I
> can't find any reference to it in Apple's Core99.cpp source so I'm assumi=
ng
> that this was the result of another bug that has now been fixed.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/ppc/mac_newworld.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index a749e2565d..1eba79d54b 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -148,7 +148,6 @@ static void ppc_core99_init(MachineState *machine)
>      qemu_irq *pic, **openpic_irqs;
>      MemoryRegion *isa =3D g_new(MemoryRegion, 1);
>      MemoryRegion *unin_memory =3D g_new(MemoryRegion, 1);
> -    MemoryRegion *unin2_memory =3D g_new(MemoryRegion, 1);
>      int linux_boot, i, j, k;
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
>      hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
> @@ -283,9 +282,6 @@ static void ppc_core99_init(MachineState *machine)
>      memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0=
x1000);
>      memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_me=
mory);
> =20
> -    memory_region_init_io(unin2_memory, NULL, &unin_ops, token, "unin", =
0x1000);
> -    memory_region_add_subregion(get_system_memory(), 0xf3000000, unin2_m=
emory);
> -
>      openpic_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
>      openpic_irqs[0] =3D
>          g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqfZm8ACgkQbDjKyiDZ
s5JRjxAAxoU6IRbPoSX7R1mOgpJK7hwXvI5NICUa7gE1tEgD+siumX3wMUe2OfF9
ua8lSt5FLuREdp97LJcrFWDh7B7/nYiyPvOSMebDgWOsyUn8eK3shLINWWW7M/EL
FVuNRIdd6cZrWgmgbj2ysbpYt+tBp9B27Hjk30YGIozR5Yao86EAQg/DZIkpDxa0
x90lkgRvrF3lg6ukR34fEews9L+O/uZYxSFgFshdLW/pyCxJF+NYupIQAHCZBRuI
RwxpjR5yherS52vFDru5b2oRupsPT5vgiRn3EhCyn+LH4prj7OguehSe3D+ReRa+
gBy3DgZFgevqZ/zeL4T/63R3kgKdVGqcYBorGT/Ilad/KYT9mi8GA6TcPFbmEtyd
vj1CSzezdh8t5fDp379nVzA+fAcaDRHY6h+M/95Vbu/DvU1VRxh4SW3grXIntDcE
syLh4FK/Bs1Szypki03ICnP33tr+syjU3rHAgCgn0s5ERwghup3nGLmHJXI+2Bch
k+1NUx1hj8jAxH3SNGmKmoTsOlJ9TSRmzgIYwQIoL2mIq7zv8XPpOGRtO+FZTyq7
794okNL/iq3Vy9Rhp9v+ZiVFQKSm9Pg3PssMhLvvQ0NUbXb2VW7i0+gIkoH+TBrT
tHVwcy3gsgO8DNGcdNYe8J3T676hPrw3WZvDt5BLi4/iOKOiuEw=
=rDDl
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
