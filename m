Received: from eggs.gnu.org ([2001:4830:134:3::10]:36355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emBL3-0008MS-Am
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emBL0-0002NQ-5q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:40:05 -0500
Date: Thu, 15 Feb 2018 15:38:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215043857.GI5247@umbus.fritz.box>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-11-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K1SnTjlYS/YgcDEx"
Content-Disposition: inline
In-Reply-To: <20180215042900.16078-11-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 10/30] hw/ppc: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:PReP" <qemu-ppc@nongnu.org>


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 01:28:40AM -0300, Philippe Mathieu-Daud=E9 wrote:
> It ease code review, unit is explicit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr.h |  2 +-
>  hw/pci-host/prep.c     |  2 +-
>  hw/ppc/e500.c          |  8 ++++----
>  hw/ppc/mac_oldworld.c  |  7 +++----
>  hw/ppc/ppc405_boards.c |  8 ++++----
>  hw/ppc/ppc405_uc.c     |  6 +++---
>  hw/ppc/ppc4xx_devs.c   | 21 +++++++++++----------
>  hw/ppc/ppce500_spin.c  |  2 +-
>  hw/ppc/prep.c          |  2 +-
>  hw/ppc/rs6000_mc.c     | 12 ++++++------
>  hw/ppc/virtex_ml507.c  |  4 ++--
>  11 files changed, 37 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 62c077ac20..ceeb274205 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -746,7 +746,7 @@ int spapr_rng_populate_dt(void *fdt);
>  #define SPAPR_MAX_RAM_SLOTS     32
> =20
>  /* 1GB alignment for hotplug memory region */
> -#define SPAPR_HOTPLUG_MEM_ALIGN (1ULL << 30)
> +#define SPAPR_HOTPLUG_MEM_ALIGN (1 * G_BYTE)
> =20
>  /*
>   * Number of 32 bit words in each LMB list entry in ibm,dynamic-memory
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 01f67f9db1..d06498e131 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -70,7 +70,7 @@ typedef struct PRePPCIState {
>      int contiguous_map;
>  } PREPPCIState;
> =20
> -#define BIOS_SIZE (1024 * 1024)
> +#define BIOS_SIZE (1 * M_BYTE)
> =20
>  static inline uint32_t raven_pci_io_config(hwaddr addr)
>  {
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index a40d3ec3e3..02675c7be4 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -45,7 +45,7 @@
>  #define BINARY_DEVICE_TREE_FILE    "mpc8544ds.dtb"
>  #define DTC_LOAD_PAD               0x1800000
>  #define DTC_PAD_MASK               0xFFFFF
> -#define DTB_MAX_SIZE               (8 * 1024 * 1024)
> +#define DTB_MAX_SIZE               (8 * M_BYTE)
>  #define INITRD_LOAD_PAD            0x2000000
>  #define INITRD_PAD_MASK            0xFFFFFF
> =20
> @@ -597,7 +597,7 @@ static int ppce500_prep_device_tree(MachineState *mac=
hine,
>  /* Create -kernel TLB entries for BookE.  */
>  hwaddr booke206_page_size_to_tlb(uint64_t size)
>  {
> -    return 63 - clz64(size >> 10);
> +    return 63 - clz64(size / K_BYTE);
>  }
> =20
>  static int booke206_initial_map_tsize(CPUPPCState *env)
> @@ -913,9 +913,9 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      /* Register spinning region */
>      sysbus_create_simple("e500-spin", params->spin_base, NULL);
> =20
> -    if (cur_base < (32 * 1024 * 1024)) {
> +    if (cur_base < 32 * M_BYTE) {
>          /* u-boot occupies memory up to 32MB, so load blobs above */
> -        cur_base =3D (32 * 1024 * 1024);
> +        cur_base =3D 32 * M_BYTE;
>      }
> =20
>      if (params->has_mpc8xxx_gpio) {
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 9b19551f56..a6b8b77937 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -117,10 +117,9 @@ static void ppc_heathrow_init(MachineState *machine)
>      }
> =20
>      /* allocate RAM */
> -    if (ram_size > (2047 << 20)) {
> -        fprintf(stderr,
> -                "qemu: Too much memory for this machine: %d MB, maximum =
2047 MB\n",
> -                ((unsigned int)ram_size / (1 << 20)));
> +    if (ram_size > 2047 * M_BYTE) {
> +        error_report("Too much memory for this machine: %llu MB, "
> +                     "maximum 2047 MB", ram_size / M_BYTE);
>          exit(1);
>      }
> =20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 0b658931ee..8c742449b8 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -41,7 +41,7 @@
>  #include "exec/address-spaces.h"
> =20
>  #define BIOS_FILENAME "ppc405_rom.bin"
> -#define BIOS_SIZE (2048 * 1024)
> +#define BIOS_SIZE (2 * M_BYTE)
> =20
>  #define KERNEL_LOAD_ADDR 0x00000000
>  #define INITRD_LOAD_ADDR 0x01800000
> @@ -217,14 +217,14 @@ static void ref405ep_init(MachineState *machine)
>      memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
>      ram_bases[1] =3D 0x00000000;
>      ram_sizes[1] =3D 0x00000000;
> -    ram_size =3D 128 * 1024 * 1024;
> +    ram_size =3D 128 * M_BYTE;
>  #ifdef DEBUG_BOARD_INIT
>      printf("%s: register cpu\n", __func__);
>  #endif
>      env =3D ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                          33333333, &pic, kernel_filename =3D=3D NULL ? 0 =
: 1);
>      /* allocate SRAM */
> -    sram_size =3D 512 * 1024;
> +    sram_size =3D 512 * K_BYTE;
>      memory_region_init_ram(sram, NULL, "ef405ep.sram", sram_size,
>                             &error_fatal);
>      memory_region_add_subregion(sysmem, 0xFFF00000, sram);
> @@ -590,7 +590,7 @@ static void taihu_405ep_init(MachineState *machine)
> =20
>          bios_size =3D blk_getlength(blk);
>          /* XXX: should check that size is 32MB */
> -        bios_size =3D 32 * 1024 * 1024;
> +        bios_size =3D 32 * M_BYTE;
>          fl_sectors =3D (bios_size + 65535) >> 16;
>  #ifdef DEBUG_BOARD_INIT
>          printf("Register parallel flash %d size %lx"
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 205ebcea93..0e9d5b0ff9 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -983,10 +983,10 @@ static void ppc405_ocm_init(CPUPPCState *env)
> =20
>      ocm =3D g_malloc0(sizeof(ppc405_ocm_t));
>      /* XXX: Size is 4096 or 0x04000000 */
> -    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
> +    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4 * K_BY=
TE,
>                             &error_fatal);
> -    memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc", &ocm=
->isarc_ram,
> -                             0, 4096);
> +    memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc",
> +                             &ocm->isarc_ram, 0, 4 * K_BYTE);
>      qemu_register_reset(&ocm_reset, ocm);
>      ppc_dcr_register(env, OCM0_ISARC,
>                       ocm, &dcr_read_ocm, &dcr_write_ocm);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 2e963894fe..52de988b13 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -29,6 +29,7 @@
>  #include "hw/boards.h"
>  #include "qemu/log.h"
>  #include "exec/address-spaces.h"
> +#include "qemu/error-report.h"
> =20
>  #define DEBUG_UIC
> =20
> @@ -353,25 +354,25 @@ static uint32_t sdram_bcr (hwaddr ram_base,
>      uint32_t bcr;
> =20
>      switch (ram_size) {
> -    case (4 * 1024 * 1024):
> +    case 4 * M_BYTE:
>          bcr =3D 0x00000000;
>          break;
> -    case (8 * 1024 * 1024):
> +    case 8 * M_BYTE:
>          bcr =3D 0x00020000;
>          break;
> -    case (16 * 1024 * 1024):
> +    case 16 * M_BYTE:
>          bcr =3D 0x00040000;
>          break;
> -    case (32 * 1024 * 1024):
> +    case 32 * M_BYTE:
>          bcr =3D 0x00060000;
>          break;
> -    case (64 * 1024 * 1024):
> +    case 64 * M_BYTE:
>          bcr =3D 0x00080000;
>          break;
> -    case (128 * 1024 * 1024):
> +    case 128 * M_BYTE:
>          bcr =3D 0x000A0000;
>          break;
> -    case (256 * 1024 * 1024):
> +    case 256 * M_BYTE:
>          bcr =3D 0x000C0000;
>          break;
>      default:
> @@ -399,7 +400,7 @@ static target_ulong sdram_size (uint32_t bcr)
>      if (sh =3D=3D 7)
>          size =3D -1;
>      else
> -        size =3D (4 * 1024 * 1024) << sh;
> +        size =3D (4 * M_BYTE) << sh;
> =20
>      return size;
>  }
> @@ -702,8 +703,8 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, i=
nt nr_banks,
> =20
>      ram_size -=3D size_left;
>      if (size_left) {
> -        printf("Truncating memory to %d MiB to fit SDRAM controller limi=
ts.\n",
> -               (int)(ram_size >> 20));
> +        error_report("Truncating memory to %llu MiB to fit SDRAM "
> +                     "controller limits", ram_size / M_BYTE);
>      }
> =20
>      memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_=
size);
> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> index 69ca2d0e42..b6d224c45b 100644
> --- a/hw/ppc/ppce500_spin.c
> +++ b/hw/ppc/ppce500_spin.c
> @@ -89,7 +89,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data dat=
a)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
>      SpinInfo *curspin =3D data.host_ptr;
> -    hwaddr map_size =3D 64 * 1024 * 1024;
> +    hwaddr map_size =3D 64 * M_BYTE;
>      hwaddr map_start;
> =20
>      cpu_synchronize_state(cs);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index f7c0a48558..eae475a34d 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -59,7 +59,7 @@
> =20
>  #define CFG_ADDR 0xf0000510
> =20
> -#define BIOS_SIZE (1024 * 1024)
> +#define BIOS_SIZE (1 * M_BYTE)
>  #define BIOS_FILENAME "ppc_rom.bin"
>  #define KERNEL_LOAD_ADDR 0x01000000
>  #define INITRD_LOAD_ADDR 0x01800000
> diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
> index b6135650bd..6999994fe4 100644
> --- a/hw/ppc/rs6000_mc.c
> +++ b/hw/ppc/rs6000_mc.c
> @@ -109,7 +109,7 @@ static void rs6000mc_port0820_write(void *opaque, uin=
t32_t addr, uint32_t val)
>              size =3D end_address - start_address;
>              memory_region_set_enabled(&s->simm[socket - 1], size !=3D 0);
>              memory_region_set_address(&s->simm[socket - 1],
> -                                      start_address * 8 * 1024 * 1024);
> +                                      start_address * 8 * M_BYTE);
>          }
>      }
>  }
> @@ -140,7 +140,7 @@ static void rs6000mc_realize(DeviceState *dev, Error =
**errp)
>  {
>      RS6000MCState *s =3D RS6000MC_DEVICE(dev);
>      int socket =3D 0;
> -    unsigned int ram_size =3D s->ram_size / (1024 * 1024);
> +    unsigned int ram_size =3D s->ram_size / M_BYTE;
> =20
>      while (socket < 6) {
>          if (ram_size >=3D 64) {
> @@ -163,8 +163,8 @@ static void rs6000mc_realize(DeviceState *dev, Error =
**errp)
>              char name[] =3D "simm.?";
>              name[5] =3D socket + '0';
>              memory_region_allocate_system_memory(&s->simm[socket], OBJEC=
T(dev),
> -                                                 name, s->simm_size[sock=
et]
> -                                                 * 1024 * 1024);
> +                                                 name,
> +                                                 s->simm_size[socket] * =
M_BYTE);
>              memory_region_add_subregion_overlap(get_system_memory(), 0,
>                                                  &s->simm[socket], socket=
);
>          }
> @@ -172,8 +172,8 @@ static void rs6000mc_realize(DeviceState *dev, Error =
**errp)
>      if (ram_size) {
>          /* unable to push all requested RAM in SIMMs */
>          error_setg(errp, "RAM size incompatible with this board. "
> -                   "Try again with something else, like %d MB",
> -                   s->ram_size / 1024 / 1024 - ram_size);
> +                   "Try again with something else, like %lld MB",
> +                   s->ram_size / M_BYTE - ram_size);
>          return;
>      }
> =20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 77a1778e07..dcfb6c2670 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -47,7 +47,7 @@
>  #include "sysemu/block-backend.h"
> =20
>  #define EPAPR_MAGIC    (0x45504150)
> -#define FLASH_SIZE     (16 * 1024 * 1024)
> +#define FLASH_SIZE     (16 * M_BYTE)
> =20
>  #define INTC_BASEADDR       0x81800000
>  #define UART16550_BASEADDR  0x83e01003
> @@ -237,7 +237,7 @@ static void virtex_init(MachineState *machine)
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      pflash_cfi01_register(PFLASH_BASEADDR, NULL, "virtex.flash", FLASH_S=
IZE,
>                            dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                          (64 * 1024), FLASH_SIZE >> 16,
> +                          64 * K_BYTE, FLASH_SIZE >> 16,
>                            1, 0x89, 0x18, 0x0000, 0x0, 1);
> =20
>      cpu_irq =3D (qemu_irq *) &env->irq_inputs[PPC40x_INPUT_INT];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K1SnTjlYS/YgcDEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqFDt4ACgkQbDjKyiDZ
s5JlsBAAn8rZeQUzjz7tCV7/D2DG/N4QA1xZ3ECm+czYWCeMzWsFZMb4AKudJORu
8AYnGNwTpdh8wazpv/0hpq7YHLw2qxd3WpjdD88pWHDJiCB11eepCxpqobzE0EMB
TniVndLB24RWytlZPbG8LaXeUKrYrVGG6iu8epu2a4fZd2vqGKCTpL1KhzHWJbx7
oi1WStYXHyRCY1kTuavQyPFw9ryx6ext5fhYAlN/cO1ISWCHAK+vTrDyumtqu1Jb
pqtj8SwLHdBCTzTmO/rhRL+ORCTfYjDBDgN9WcW4YAFDDf3Azc1QJ4TsMn8zMjH7
XWo0oIuScJP5FbEuVqlPvaTsI4D7D4epz5TuVgNnoivfdpziDQQMGKlE9Q176mJ9
rAgWNCI1b4UIF+PmTEfHNMHx8+/Hro7+JYeK853sQM9LMmCHxXng9GOQdVqu2S+z
xbxqaxvd98qXPPvFlRUUI78f0+vvsMnm+Qz+5rHAOY7SYnsijGe9Dr6q95fd5mI+
Sv9hXhJYPIBykgTUZeJorJhU1TBqPsbFX7Z/oLqecKhKlFRK/aomGW6Q+YRLiSNY
ulP30gDkFggS4PkVgpd/CDD0H8E81plJW4b4MZsRBH4NmkdFPlZGvmMLp6mapfYu
0DI+BH6zSritUMnoeHBjgwd2WPPNHeDkXNKvAlIWk7KIa7FJ1NE=
=nz2D
-----END PGP SIGNATURE-----

--K1SnTjlYS/YgcDEx--
