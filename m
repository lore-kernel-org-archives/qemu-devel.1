Received: from eggs.gnu.org ([2001:4830:134:3::10]:36877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCy-0002cK-NN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0005GS-Kl
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:52 -0400
Date: Fri, 6 Oct 2017 14:12:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006031249.GK3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-9-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ktyc2UzNUDZzGzis"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-9-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/23] ppc: replace cpu_model with cpu_type
 on ref405ep, taihu boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--ktyc2UzNUDZzGzis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:35PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc405_uc.c   | 6 ++++--
>  hw/ppc/ppc4xx_devs.c | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 8e58065..205ebce 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -1629,7 +1629,8 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_sp=
ace_mem,
>      qemu_irq *pic, *irqs;
> =20
>      memset(clk_setup, 0, sizeof(clk_setup));
> -    cpu =3D ppc4xx_init("405cr", &clk_setup[PPC405CR_CPU_CLK],
> +    cpu =3D ppc4xx_init(POWERPC_CPU_TYPE_NAME("405crc"),
> +                      &clk_setup[PPC405CR_CPU_CLK],
>                        &clk_setup[PPC405CR_TMR_CLK], sysclk);
>      env =3D &cpu->env;
>      /* Memory mapped devices registers */
> @@ -1981,7 +1982,8 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_sp=
ace_mem,
> =20
>      memset(clk_setup, 0, sizeof(clk_setup));
>      /* init CPUs */
> -    cpu =3D ppc4xx_init("405ep", &clk_setup[PPC405EP_CPU_CLK],
> +    cpu =3D ppc4xx_init(POWERPC_CPU_TYPE_NAME("405ep"),
> +                      &clk_setup[PPC405EP_CPU_CLK],
>                        &tlb_clk_setup, sysclk);
>      env =3D &cpu->env;
>      clk_setup[PPC405EP_CPU_CLK].cb =3D tlb_clk_setup.cb;
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 6d7f785..2e96389 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -48,7 +48,7 @@ static void ppc4xx_reset(void *opaque)
> =20
>  /***********************************************************************=
******/
>  /* Generic PowerPC 4xx processor instantiation */
> -PowerPCCPU *ppc4xx_init(const char *cpu_model,
> +PowerPCCPU *ppc4xx_init(const char *cpu_type,
>                          clk_setup_t *cpu_clk, clk_setup_t *tb_clk,
>                          uint32_t sysclk)
>  {
> @@ -56,7 +56,7 @@ PowerPCCPU *ppc4xx_init(const char *cpu_model,
>      CPUPPCState *env;
> =20
>      /* init CPUs */
> -    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
> +    cpu =3D POWERPC_CPU(cpu_create(cpu_type));
>      env =3D &cpu->env;
> =20
>      cpu_clk->cb =3D NULL; /* We don't care about CPU clock frequency cha=
nges */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ktyc2UzNUDZzGzis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW9LEACgkQbDjKyiDZ
s5KaYw/+J2+J58hQEtdCZOV/xpV1Oo7eof5f/hM2X8lAi663uAPHN5nh3uD9nZRq
R41B83svQRi8VdoCbB4nmiWMggVPU2tOHVMOsE4AiJy5MEOaF2UM9z/Ofc6bor9V
iAuyD47QI68DJYsKR+zbiu357IniRP/uAy2b/zbSH0IFzx7yfQR33sOa2Si/2ce7
iG5gXXeCZ8BQUz9ZEy0wqqEpvY45rQ7RPyEhkgSFt/D7SrcHfP4p1qNjIrx2FAYS
T1aHfbQQmO7E94kO0vb1ccblPX4pkvO4wWTdMHkChnapXKaWGZxfQlzTzuaALH7W
SsjHPwzOHMd28z0cTob6MriypKCBWYTnY9Yaq3zszB13QwMg9hkraht+4xWz45H0
H9YKf53rrpY2At1JQE5nV81xdlT313UF/+tlLgI6jpOtuC9Vh/G8jolf6drLw51l
N1TldSO98EzMHZEjr/RNF6WVAMlq4GfYD18eUVIjnBR1n9A84ngs7PHcKm/gneYj
K08Sn3kDSzalfU0k2RoPHZ6qVN3S98IKm+PuwzpTKnLp8R1GjWQml/lpYNbs561w
axbPXgE/3e5t8FtWcKUlyAwINjYPbFG46qanKNiC9GAlDkLR3r9iLW9XYhe4+HqW
DYytY89k/qsBzy7r8Cgf0GX9df6FL878APxmsSGsdBL9OHwt7QI=
=F1kn
-----END PGP SIGNATURE-----

--ktyc2UzNUDZzGzis--
