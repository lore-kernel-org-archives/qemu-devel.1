Received: from eggs.gnu.org ([2001:4830:134:3::10]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hWY-0004hD-V5
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hWU-0003Cp-HD
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:19:42 -0400
Date: Sat, 7 Oct 2017 16:15:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171007051535.GG10050@umbus.fritz.box>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-59-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Content-Disposition: inline
In-Reply-To: <20171006235023.11952-59-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 58/88] ppc4xx: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 08:49:53PM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> [PMD: added more changes in hw/ppc/ppc405_uc.c and hw/ppc/ppc4xx_devs.c]

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc405_boards.c |  4 ++--
>  hw/ppc/ppc405_uc.c     | 24 ++++++++++++------------
>  hw/ppc/ppc440_bamboo.c |  2 +-
>  hw/ppc/ppc4xx_devs.c   |  6 +++---
>  4 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index e92db2c66a..a812985baa 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -169,7 +169,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, =
uint32_t base)
>      ref405ep_fpga_t *fpga;
>      MemoryRegion *fpga_memory =3D g_new(MemoryRegion, 1);
> =20
> -    fpga =3D g_malloc0(sizeof(ref405ep_fpga_t));
> +    fpga =3D g_new0(ref405ep_fpga_t, 1);
>      memory_region_init_io(fpga_memory, NULL, &ref405ep_fpga_ops, fpga,
>                            "fpga", 0x00000100);
>      memory_region_add_subregion(sysmem, base, fpga_memory);
> @@ -472,7 +472,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uin=
t32_t base)
>      taihu_cpld_t *cpld;
>      MemoryRegion *cpld_memory =3D g_new(MemoryRegion, 1);
> =20
> -    cpld =3D g_malloc0(sizeof(taihu_cpld_t));
> +    cpld =3D g_new0(taihu_cpld_t, 1);
>      memory_region_init_io(cpld_memory, NULL, &taihu_cpld_ops, cpld, "cpl=
d", 0x100);
>      memory_region_add_subregion(sysmem, base, cpld_memory);
>      qemu_register_reset(&taihu_cpld_reset, cpld);
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 8e58065f5f..02ab2a24ff 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -181,7 +181,7 @@ void ppc4xx_plb_init(CPUPPCState *env)
>  {
>      ppc4xx_plb_t *plb;
> =20
> -    plb =3D g_malloc0(sizeof(ppc4xx_plb_t));
> +    plb =3D g_new0(ppc4xx_plb_t, 1);
>      ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb=
);
>      ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb=
);
>      ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
> @@ -266,7 +266,7 @@ static void ppc4xx_pob_init(CPUPPCState *env)
>  {
>      ppc4xx_pob_t *pob;
> =20
> -    pob =3D g_malloc0(sizeof(ppc4xx_pob_t));
> +    pob =3D g_new0(ppc4xx_pob_t, 1);
>      ppc_dcr_register(env, POB0_BEAR, pob, &dcr_read_pob, &dcr_write_pob);
>      ppc_dcr_register(env, POB0_BESR0, pob, &dcr_read_pob, &dcr_write_pob=
);
>      ppc_dcr_register(env, POB0_BESR1, pob, &dcr_read_pob, &dcr_write_pob=
);
> @@ -397,7 +397,7 @@ static void ppc4xx_opba_init(hwaddr base)
>  {
>      ppc4xx_opba_t *opba;
> =20
> -    opba =3D g_malloc0(sizeof(ppc4xx_opba_t));
> +    opba =3D g_new0(ppc4xx_opba_t, 1);
>  #ifdef DEBUG_OPBA
>      printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
>  #endif
> @@ -595,7 +595,7 @@ void ppc405_ebc_init(CPUPPCState *env)
>  {
>      ppc4xx_ebc_t *ebc;
> =20
> -    ebc =3D g_malloc0(sizeof(ppc4xx_ebc_t));
> +    ebc =3D g_new0(ppc4xx_ebc_t, 1);
>      qemu_register_reset(&ebc_reset, ebc);
>      ppc_dcr_register(env, EBC0_CFGADDR,
>                       ebc, &dcr_read_ebc, &dcr_write_ebc);
> @@ -678,7 +678,7 @@ static void ppc405_dma_init(CPUPPCState *env, qemu_ir=
q irqs[4])
>  {
>      ppc405_dma_t *dma;
> =20
> -    dma =3D g_malloc0(sizeof(ppc405_dma_t));
> +    dma =3D g_new0(ppc405_dma_t, 1);
>      memcpy(dma->irqs, irqs, 4 * sizeof(qemu_irq));
>      qemu_register_reset(&ppc405_dma_reset, dma);
>      ppc_dcr_register(env, DMA0_CR0,
> @@ -819,7 +819,7 @@ static void ppc405_gpio_init(hwaddr base)
>  {
>      ppc405_gpio_t *gpio;
> =20
> -    gpio =3D g_malloc0(sizeof(ppc405_gpio_t));
> +    gpio =3D g_new0(ppc405_gpio_t, 1);
>  #ifdef DEBUG_GPIO
>      printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
>  #endif
> @@ -981,7 +981,7 @@ static void ppc405_ocm_init(CPUPPCState *env)
>  {
>      ppc405_ocm_t *ocm;
> =20
> -    ocm =3D g_malloc0(sizeof(ppc405_ocm_t));
> +    ocm =3D g_new0(ppc405_ocm_t, 1);
>      /* XXX: Size is 4096 or 0x04000000 */
>      memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
>                             &error_fatal);
> @@ -1264,7 +1264,7 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq i=
rqs[5])
>      ppc4xx_gpt_t *gpt;
>      int i;
> =20
> -    gpt =3D g_malloc0(sizeof(ppc4xx_gpt_t));
> +    gpt =3D g_new0(ppc4xx_gpt_t, 1);
>      for (i =3D 0; i < 5; i++) {
>          gpt->irqs[i] =3D irqs[i];
>      }
> @@ -1590,7 +1590,7 @@ static void ppc405cr_cpc_init (CPUPPCState *env, cl=
k_setup_t clk_setup[7],
>  {
>      ppc405cr_cpc_t *cpc;
> =20
> -    cpc =3D g_malloc0(sizeof(ppc405cr_cpc_t));
> +    cpc =3D g_new0(ppc405cr_cpc_t, 1);
>      memcpy(cpc->clk_setup, clk_setup,
>             PPC405CR_CLK_NB * sizeof(clk_setup_t));
>      cpc->sysclk =3D sysclk;
> @@ -1640,7 +1640,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_sp=
ace_mem,
>      /* OBP arbitrer */
>      ppc4xx_opba_init(0xef600600);
>      /* Universal interrupt controller */
> -    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] =3D
>          ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] =3D
> @@ -1934,7 +1934,7 @@ static void ppc405ep_cpc_init (CPUPPCState *env, cl=
k_setup_t clk_setup[8],
>  {
>      ppc405ep_cpc_t *cpc;
> =20
> -    cpc =3D g_malloc0(sizeof(ppc405ep_cpc_t));
> +    cpc =3D g_new0(ppc405ep_cpc_t, 1);
>      memcpy(cpc->clk_setup, clk_setup,
>             PPC405EP_CLK_NB * sizeof(clk_setup_t));
>      cpc->jtagid =3D 0x20267049;
> @@ -1997,7 +1997,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_sp=
ace_mem,
>      /* Initialize timers */
>      ppc_booke_timers_init(cpu, sysclk, 0);
>      /* Universal interrupt controller */
> -    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] =3D
>          ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] =3D
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index f92d47f28d..f55071abaf 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -200,7 +200,7 @@ static void bamboo_init(MachineState *machine)
>      ppc_dcr_init(env, NULL, NULL);
> =20
>      /* interrupt controller */
> -    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
>      pic =3D ppcuic_init(env, irqs, 0x0C0, 0, 1);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 6d7f7857fe..a5ea8f8a63 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -300,7 +300,7 @@ qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *ir=
qs,
>      ppcuic_t *uic;
>      int i;
> =20
> -    uic =3D g_malloc0(sizeof(ppcuic_t));
> +    uic =3D g_new0(ppcuic_t, 1);
>      uic->dcr_base =3D dcr_base;
>      uic->irqs =3D irqs;
>      if (has_vr)
> @@ -648,7 +648,7 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
>  {
>      ppc4xx_sdram_t *sdram;
> =20
> -    sdram =3D g_malloc0(sizeof(ppc4xx_sdram_t));
> +    sdram =3D g_new0(ppc4xx_sdram_t, 1);
>      sdram->irq =3D irq;
>      sdram->nbanks =3D nbanks;
>      sdram->ram_memories =3D ram_memories;
> @@ -911,7 +911,7 @@ void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum=
, uint8_t rxcnum,
>      int i;
> =20
>      assert(txcnum <=3D 32 && rxcnum <=3D 32);
> -    mal =3D g_malloc0(sizeof(*mal));
> +    mal =3D g_new0(ppc4xx_mal_t, 1);
>      mal->txcnum =3D txcnum;
>      mal->rxcnum =3D rxcnum;
>      mal->txctpr =3D g_new0(uint32_t, txcnum);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnYYvUACgkQbDjKyiDZ
s5JmLRAA5H9KZQFmRmqTtMEeKBTyMb1aT6/CzBVBvoyodwFhRQFTvz8dfLliL4a9
YI0ELyLOf7ZFrAbBjPbk4Ds3W8//rY+6rMIh34IHgMauareUeSvGvg6zDRLnqyA1
OdOr/dsvJd8oH7oUtCKaiPvwNSDmCU3vtGgdeBXImFdr3NELvsg60ivYiwAfqt5c
tHg5R78tU+4FOD2I1xAF3YdpjBdtgoytW6FFhrnCqjHc1e/Q+8uvJ31dEBv2KzLN
0umPVh4iySOJ5PoyWY//HHNLapvfcFWGQs3U4kMEg5mBu+BquUkTz0YlRjnpEraD
BCYLOg4JVohtm/10pO6J7vkRWWcfx9W4SuoAawFQdPcXVOwUG5pUpiZT2Kvlbg+5
p7rTW1JBVqrj4d4aEVCIIoxAOhD8jbd4x/JCucxMr2bd//6M8jGczXI/QLAMp4a3
Ysnq3Yzd75/WTASJNug/fRplzDp4OJ6Y+vinpxSglXWxXWIDR78lIE3Fm1DaD4c+
Kyw6oGXIqBalR1uoSCEgXTKLX9xgGdPvfevIZKnTD/YGBXqtm+3dDhyMIzxYOCCj
JfzrmuW9oVe4oBBBayPM5Cnajwgps6/Pul09OnAkq7l+XIJD8tXZwea5NMoybA6n
h42XYzWQ5Fhm/n+DxW68S+/0eQl43lh0Vm3608lPWsUmh+AyQZg=
=p92b
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--
