Received: from eggs.gnu.org ([2001:4830:134:3::10]:60833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erZcp-0003V0-40
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erZco-0007kI-0s
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:36:43 -0500
Date: Fri, 2 Mar 2018 12:01:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180302010137.GC13135@umbus.fritz.box>
References: <20180301060550.14201-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20180301060550.14201-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr,
 e500: Use new property "stdout-path" for boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, benh@kernel.crashing.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 11:35:50AM +0530, Nikunj A Dadhania wrote:
> Linux kernel commit 2a9d832cc9aae21ea827520fef635b6c49a06c6d
> (of: Add bindings for chosen node, stdout-path) deprecated chosen property
> "linux,stdout-path" and "stdout".
>=20
> Introduce the new property "stdout-path" and continue supporting the older
> property to remain compatible with existing/older firmware. This older pr=
operty
> can be deprecated after 5 years.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ppc/e500.c  | 7 +++++++
>  hw/ppc/spapr.c | 7 +++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index a40d3ec3e3..a325a95015 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -119,7 +119,14 @@ static void dt_serial_create(void *fdt, unsigned lon=
g long offset,
>      qemu_fdt_setprop_string(fdt, "/aliases", alias, ser);
> =20
>      if (defcon) {
> +        /*
> +         * "linux,stdout-path" and "stdout" properties are deprecated by=
 linux
> +         * kernel. New platforms should only use the "stdout-path" prope=
rty. Set
> +         * the new property and continue using older property to remain
> +         * compatible with the existing firmware.
> +         */
>          qemu_fdt_setprop_string(fdt, "/chosen", "linux,stdout-path", ser=
);
> +        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", ser);
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 83c9d66dd5..58a44edc4a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1062,7 +1062,14 @@ static void spapr_dt_chosen(sPAPRMachineState *spa=
pr, void *fdt)
>      }
> =20
>      if (!spapr->has_graphics && stdout_path) {
> +        /*
> +         * "linux,stdout-path" and "stdout" properties are deprecated by=
 linux
> +         * kernel. New platforms should only use the "stdout-path" prope=
rty. Set
> +         * the new property and continue using older property to remain
> +         * compatible with the existing firmware.
> +         */
>          _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout=
_path));
> +        _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
>      }
> =20
>      spapr_dt_ov5_platform_support(fdt, chosen);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqYonAACgkQbDjKyiDZ
s5LOuw/+Mx/TculiNFtDlQVGNQS2tuVPgRrWMNvZVRD9TqugCXxBzo0F2Z0TKoCx
jdfxwm/bkyH0uSMomQpifaJHoUyQ/lDUFgbeJ68hllVDHO1eOlxDPw0nFiPaH5Hk
JjzwkRNcKRMl5DoJLDjVjeTnjHXRuo6SYPhHfKS1FnB7mfq0bX4J5F/aOQ18AZHN
fPenOnNiFLG+GQYSV49uyJbNftCnP5Ni89W9OxaBHaCwrzaVnDxpMvo95qI6GP65
8wBbwxmb6v9AdIHUIeOX+rXejP51uQkiiVgAQu04gPuQtdUBJe4UClmRV+ga7C9h
W8S5QhpREey+ebcvHNaOIgu4wO1/G4X0oFv9TMXQEnjnwCAyLh5jQAmGINdopbWw
2kPhHVtK0YO4hjWxmJMGr/oIoEfWxlvWO0stRr4RpDRh/5/8Bwi0yAV1+rOS916C
kO3QqLXJaXlhjqdcdVEV7BgDzF/ZjW+R3J58PBxJO9DWZNVJeq8KUEijRmLC71sI
EAkF7Nihtbfl/tFJsX9v7W/ZtxfpTrpe76f2JjUniZa5mXbUr1NSfqOkV1FIxpIf
aSQTPBkQ9pPxrqfdzs75TYfsAufn6IRYVi4AO+wPyMFFD0zQvADjCmwIZbQJD+w6
NcSdxpWW7Fxxrp6FY0LXhBvJBPR6zOlEZsGnYKlWAMRBbREKZC4=
=uqAU
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
