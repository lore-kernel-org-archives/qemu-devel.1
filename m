Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSCX4-0002jm-Hw
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSCX2-00080s-03
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:26:10 -0400
Date: Mon, 11 Jun 2018 12:11:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180611021146.GD2737@umbus.fritz.box>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20180611011501.10235-6-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v4 05/40] hw: Use IEC binary prefix
 definitions from "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paul Burton <paul.burton@mips.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2018 at 10:14:26PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Code change produced with:
>=20
>   $ git ls-files | egrep '\.[ch]$' | \
>     xargs sed -i -e 's/\(\W[KMGTPE]\)_BYTE/\1iB/g'
>=20
> Suggested-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qemu/cutils.h  |  8 +-------
>  hw/arm/msf2-soc.c      |  4 ++--
>  hw/arm/msf2-som.c      |  6 +++---
>  hw/core/loader-fit.c   |  3 ++-
>  hw/core/machine.c      |  2 +-
>  hw/display/sm501.c     | 14 +++++++-------
>  hw/hppa/machine.c      |  2 +-
>  hw/mips/boston.c       | 28 ++++++++++++++--------------
>  hw/ppc/pnv.c           |  4 ++--
>  hw/ppc/ppc440_uc.c     | 26 +++++++++++++-------------
>  hw/ppc/prep.c          |  2 +-
>  hw/ppc/sam460ex.c      |  2 +-
>  hw/ppc/spapr.c         | 10 +++++-----
>  hw/ppc/spapr_rtas.c    |  2 +-
>  hw/sd/sd.c             |  4 ++--
>  hw/sd/sdhci.c          |  2 +-
>  tests/test-cutils.c    | 18 +++++++++---------
>  tests/test-keyval.c    |  6 +++---
>  tests/test-qemu-opts.c |  7 +++----
>  19 files changed, 72 insertions(+), 78 deletions(-)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index a663340b23..056e6629bb 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -2,6 +2,7 @@
>  #define QEMU_CUTILS_H
> =20
>  #include "qemu/fprintf-fn.h"
> +#include "qemu/units.h"
> =20
>  /**
>   * pstrcpy:
> @@ -147,13 +148,6 @@ int qemu_strtosz(const char *nptr, char **end, uint6=
4_t *result);
>  int qemu_strtosz_MiB(const char *nptr, char **end, uint64_t *result);
>  int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result);
> =20
> -#define K_BYTE     (1ULL << 10)
> -#define M_BYTE     (1ULL << 20)
> -#define G_BYTE     (1ULL << 30)
> -#define T_BYTE     (1ULL << 40)
> -#define P_BYTE     (1ULL << 50)
> -#define E_BYTE     (1ULL << 60)
> -
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
> =20
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 75c44adf7d..530e461c42 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -40,14 +40,14 @@
> =20
>  #define SRAM_BASE_ADDRESS     0x20000000
> =20
> -#define MSF2_ENVM_MAX_SIZE    (512 * K_BYTE)
> +#define MSF2_ENVM_MAX_SIZE    (512 * KiB)
> =20
>  /*
>   * eSRAM max size is 80k without SECDED(Single error correction and
>   * dual error detection) feature and 64k with SECDED.
>   * We do not support SECDED now.
>   */
> -#define MSF2_ESRAM_MAX_SIZE       (80 * K_BYTE)
> +#define MSF2_ESRAM_MAX_SIZE       (80 * KiB)
> =20
>  static const uint32_t spi_addr[MSF2_NUM_SPIS] =3D { 0x40001000 , 0x40011=
000 };
>  static const uint32_t uart_addr[MSF2_NUM_UARTS] =3D { 0x40000000 , 0x400=
10000 };
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index 0795a3a3a1..ed533bbde1 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -33,10 +33,10 @@
>  #include "cpu.h"
> =20
>  #define DDR_BASE_ADDRESS      0xA0000000
> -#define DDR_SIZE              (64 * M_BYTE)
> +#define DDR_SIZE              (64 * MiB)
> =20
> -#define M2S010_ENVM_SIZE      (256 * K_BYTE)
> -#define M2S010_ESRAM_SIZE     (64 * K_BYTE)
> +#define M2S010_ENVM_SIZE      (256 * KiB)
> +#define M2S010_ESRAM_SIZE     (64 * KiB)
> =20
>  static void emcraft_sf2_s2s010_init(MachineState *machine)
>  {
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 6387854b54..447f60857d 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "exec/memory.h"
>  #include "hw/loader.h"
>  #include "hw/loader-fit.h"
> @@ -194,7 +195,7 @@ static int fit_load_fdt(const struct fit_loader *ldr,=
 const void *itb,
> =20
>      err =3D fit_image_addr(itb, img_off, "load", &load_addr);
>      if (err =3D=3D -ENOENT) {
> -        load_addr =3D ROUND_UP(kernel_end, 64 * K_BYTE) + (10 * M_BYTE);
> +        load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
>      } else if (err) {
>          ret =3D err;
>          goto out;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 617e5f8d75..ccf3a4b9c7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -522,7 +522,7 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> =20
>      /* Default 128 MB as guest ram size */
> -    mc->default_ram_size =3D 128 * M_BYTE;
> +    mc->default_ram_size =3D 128 * MiB;
>      mc->rom_file_has_mr =3D true;
> =20
>      /* numa node memory size aligned on 8MB by default.
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index e47be99451..1c6c9445c5 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -452,12 +452,12 @@
> =20
>  /* SM501 local memory size taken from "linux/drivers/mfd/sm501.c" */
>  static const uint32_t sm501_mem_local_size[] =3D {
> -    [0] =3D 4 * M_BYTE,
> -    [1] =3D 8 * M_BYTE,
> -    [2] =3D 16 * M_BYTE,
> -    [3] =3D 32 * M_BYTE,
> -    [4] =3D 64 * M_BYTE,
> -    [5] =3D 2 * M_BYTE,
> +    [0] =3D 4 * MiB,
> +    [1] =3D 8 * MiB,
> +    [2] =3D 16 * MiB,
> +    [3] =3D 32 * MiB,
> +    [4] =3D 64 * MiB,
> +    [5] =3D 2 * MiB,
>  };
>  #define get_local_mem_size(s) sm501_mem_local_size[(s)->local_mem_size_i=
ndex]
> =20
> @@ -1826,7 +1826,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error=
 **errp)
>  }
> =20
>  static Property sm501_pci_properties[] =3D {
> -    DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * M_BYT=
E),
> +    DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index aba269bb85..2ba26962f9 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -275,7 +275,7 @@ static void machine_hppa_machine_init(MachineClass *m=
c)
>      mc->max_cpus =3D HPPA_MAX_CPUS;
>      mc->default_cpus =3D 1;
>      mc->is_default =3D 1;
> -    mc->default_ram_size =3D 512 * M_BYTE;
> +    mc->default_ram_size =3D 512 * MiB;
>      mc->default_boot_order =3D "cd";
>  }
> =20
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 52cce19766..512c60c03e 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -200,7 +200,7 @@ static uint64_t boston_platreg_read(void *opaque, hwa=
ddr addr,
>          val |=3D PLAT_BUILD_CFG_PCIE2_EN;
>          return val;
>      case PLAT_DDR_CFG:
> -        val =3D s->mach->ram_size / G_BYTE;
> +        val =3D s->mach->ram_size / GiB;
>          assert(!(val & ~PLAT_DDR_CFG_SIZE));
>          val |=3D PLAT_DDR_CFG_MHZ;
>          return val;
> @@ -355,7 +355,7 @@ static const void *boston_fdt_filter(void *opaque, co=
nst void *fdt_orig,
>          return NULL;
>      }
> =20
> -    ram_low_sz =3D MIN(256 * M_BYTE, machine->ram_size);
> +    ram_low_sz =3D MIN(256 * MiB, machine->ram_size);
>      ram_high_sz =3D machine->ram_size - ram_low_sz;
>      qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
>                                   1, 0x00000000, 1, ram_low_sz,
> @@ -436,8 +436,8 @@ static void boston_mach_init(MachineState *machine)
>      int fw_size, fit_err;
>      bool is_64b;
> =20
> -    if ((machine->ram_size % G_BYTE) ||
> -        (machine->ram_size > (2 * G_BYTE))) {
> +    if ((machine->ram_size % GiB) ||
> +        (machine->ram_size > (2 * GiB))) {
>          error_report("Memory size must be 1GB or 2GB");
>          exit(1);
>      }
> @@ -472,7 +472,7 @@ static void boston_mach_init(MachineState *machine)
> =20
>      flash =3D  g_new(MemoryRegion, 1);
>      memory_region_init_rom_nomigrate(flash, NULL,
> -                                     "boston.flash", 128 * M_BYTE, &err);
> +                                     "boston.flash", 128 * MiB, &err);
>      memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
> =20
>      ddr =3D g_new(MemoryRegion, 1);
> @@ -482,22 +482,22 @@ static void boston_mach_init(MachineState *machine)
> =20
>      ddr_low_alias =3D g_new(MemoryRegion, 1);
>      memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
> -                             ddr, 0, MIN(machine->ram_size, (256 * M_BYT=
E)));
> +                             ddr, 0, MIN(machine->ram_size, (256 * MiB))=
);
>      memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
> =20
>      xilinx_pcie_init(sys_mem, 0,
> -                     0x10000000, 32 * M_BYTE,
> -                     0x40000000, 1 * G_BYTE,
> +                     0x10000000, 32 * MiB,
> +                     0x40000000, 1 * GiB,
>                       get_cps_irq(s->cps, 2), false);
> =20
>      xilinx_pcie_init(sys_mem, 1,
> -                     0x12000000, 32 * M_BYTE,
> -                     0x20000000, 512 * M_BYTE,
> +                     0x12000000, 32 * MiB,
> +                     0x20000000, 512 * MiB,
>                       get_cps_irq(s->cps, 1), false);
> =20
>      pcie2 =3D xilinx_pcie_init(sys_mem, 2,
> -                             0x14000000, 32 * M_BYTE,
> -                             0x16000000, 1 * M_BYTE,
> +                             0x14000000, 32 * MiB,
> +                             0x16000000, 1 * MiB,
>                               get_cps_irq(s->cps, 0), true);
> =20
>      platreg =3D g_new(MemoryRegion, 1);
> @@ -527,7 +527,7 @@ static void boston_mach_init(MachineState *machine)
> =20
>      if (machine->firmware) {
>          fw_size =3D load_image_targphys(machine->firmware,
> -                                      0x1fc00000, 4 * M_BYTE);
> +                                      0x1fc00000, 4 * MiB);
>          if (fw_size =3D=3D -1) {
>              error_printf("unable to load firmware image '%s'\n",
>                            machine->firmware);
> @@ -553,7 +553,7 @@ static void boston_mach_class_init(MachineClass *mc)
>      mc->desc =3D "MIPS Boston";
>      mc->init =3D boston_mach_init;
>      mc->block_default_type =3D IF_IDE;
> -    mc->default_ram_size =3D 1 * G_BYTE;
> +    mc->default_ram_size =3D 1 * GiB;
>      mc->max_cpus =3D 16;
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("I6400");
>  }
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0314881316..bdb6f63d2c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -559,7 +559,7 @@ static void pnv_init(MachineState *machine)
>      char *chip_typename;
> =20
>      /* allocate RAM */
> -    if (machine->ram_size < (1 * G_BYTE)) {
> +    if (machine->ram_size < (1 * GiB)) {
>          warn_report("skiboot may not work with < 1GB of RAM");
>      }
> =20
> @@ -1096,7 +1096,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
>                                        * storage */
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
> -    mc->default_ram_size =3D 1 * G_BYTE;
> +    mc->default_ram_size =3D 1 * GiB;
>      xic->icp_get =3D pnv_icp_get;
>      xic->ics_get =3D pnv_ics_get;
>      xic->ics_resend =3D pnv_ics_resend;
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 123f4ac09d..b5b31b4b9b 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -215,13 +215,13 @@ void ppc4xx_l2sram_init(CPUPPCState *env)
>      l2sram =3D g_malloc0(sizeof(*l2sram));
>      /* XXX: Size is 4*64kB for 460ex, cf. U-Boot, ppc4xx-isram.h */
>      memory_region_init_ram(&l2sram->bank[0], NULL, "ppc4xx.l2sram_bank0",
> -                           64 * K_BYTE, &error_abort);
> +                           64 * KiB, &error_abort);
>      memory_region_init_ram(&l2sram->bank[1], NULL, "ppc4xx.l2sram_bank1",
> -                           64 * K_BYTE, &error_abort);
> +                           64 * KiB, &error_abort);
>      memory_region_init_ram(&l2sram->bank[2], NULL, "ppc4xx.l2sram_bank2",
> -                           64 * K_BYTE, &error_abort);
> +                           64 * KiB, &error_abort);
>      memory_region_init_ram(&l2sram->bank[3], NULL, "ppc4xx.l2sram_bank3",
> -                           64 * K_BYTE, &error_abort);
> +                           64 * KiB, &error_abort);
>      qemu_register_reset(&l2sram_reset, l2sram);
>      ppc_dcr_register(env, DCR_L2CACHE_CFG,
>                       l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
> @@ -513,28 +513,28 @@ static uint32_t sdram_bcr(hwaddr ram_base, hwaddr r=
am_size)
>      uint32_t bcr;
> =20
>      switch (ram_size) {
> -    case (8 * M_BYTE):
> +    case (8 * MiB):
>          bcr =3D 0xffc0;
>          break;
> -    case (16 * M_BYTE):
> +    case (16 * MiB):
>          bcr =3D 0xff80;
>          break;
> -    case (32 * M_BYTE):
> +    case (32 * MiB):
>          bcr =3D 0xff00;
>          break;
> -    case (64 * M_BYTE):
> +    case (64 * MiB):
>          bcr =3D 0xfe00;
>          break;
> -    case (128 * M_BYTE):
> +    case (128 * MiB):
>          bcr =3D 0xfc00;
>          break;
> -    case (256 * M_BYTE):
> +    case (256 * MiB):
>          bcr =3D 0xf800;
>          break;
> -    case (512 * M_BYTE):
> +    case (512 * MiB):
>          bcr =3D 0xf000;
>          break;
> -    case (1 * G_BYTE):
> +    case (1 * GiB):
>          bcr =3D 0xe000;
>          break;
>      default:
> @@ -561,7 +561,7 @@ static target_ulong sdram_size(uint32_t bcr)
>      if (sh =3D=3D 0) {
>          size =3D -1;
>      } else {
> -        size =3D 8 * M_BYTE * sh;
> +        size =3D 8 * MiB * sh;
>      }
> =20
>      return size;
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index a1e7219db6..a8d26f74fc 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -886,7 +886,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
>      mc->init =3D ibm_40p_init;
>      mc->max_cpus =3D 1;
>      mc->pci_allow_0_address =3D true;
> -    mc->default_ram_size =3D 128 * M_BYTE;
> +    mc->default_ram_size =3D 128 * MiB;
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_boot_order =3D "c";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("604");
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index bdc53d2603..2a98c10664 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -597,7 +597,7 @@ static void sam460ex_machine_init(MachineClass *mc)
>      mc->desc =3D "aCube Sam460ex";
>      mc->init =3D sam460ex_init;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("460exb");
> -    mc->default_ram_size =3D 512 * M_BYTE;
> +    mc->default_ram_size =3D 512 * MiB;
>  }
> =20
>  DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2375cbee12..3ba3bc8b6c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2317,7 +2317,7 @@ static void spapr_validate_node_memory(MachineState=
 *machine, Error **errp)
>          error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
>                     " is not aligned to %llu MiB",
>                     machine->ram_size,
> -                   SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +                   SPAPR_MEMORY_BLOCK_SIZE / MiB);
>          return;
>      }
> =20
> @@ -2325,7 +2325,7 @@ static void spapr_validate_node_memory(MachineState=
 *machine, Error **errp)
>          error_setg(errp, "Maximum memory size 0x" RAM_ADDR_FMT
>                     " is not aligned to %llu MiB",
>                     machine->ram_size,
> -                   SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +                   SPAPR_MEMORY_BLOCK_SIZE / MiB);
>          return;
>      }
> =20
> @@ -2335,7 +2335,7 @@ static void spapr_validate_node_memory(MachineState=
 *machine, Error **errp)
>                         "Node %d memory size 0x%" PRIx64
>                         " is not aligned to %llu MiB",
>                         i, numa_info[i].node_mem,
> -                       SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +                       SPAPR_MEMORY_BLOCK_SIZE / MiB);
>              return;
>          }
>      }
> @@ -3195,7 +3195,7 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> =20
>      if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Hotplugged memory size must be a multiple of "
> -                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
>          return;
>      }
> =20
> @@ -3975,7 +3975,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->max_cpus =3D 1024;
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D "";
> -    mc->default_ram_size =3D 512 * M_BYTE;
> +    mc->default_ram_size =3D 512 * MiB;
>      mc->kvm_type =3D spapr_kvm_type;
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDG=
E);
>      mc->pci_allow_0_address =3D true;
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 7f9738daed..f32740b947 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -241,7 +241,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
>                                            "DesProcs=3D%d,"
>                                            "MaxPlatProcs=3D%d",
>                                            max_cpus,
> -                                          current_machine->ram_size / M_=
BYTE,
> +                                          current_machine->ram_size / Mi=
B,
>                                            smp_cpus,
>                                            max_cpus);
>          ret =3D sysparm_st(buffer, length, param_val, strlen(param_val) =
+ 1);
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 540bccb8d1..9a16b768ed 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -305,7 +305,7 @@ static void sd_ocr_powerup(void *opaque)
>      /* card power-up OK */
>      sd->ocr =3D FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
> =20
> -    if (sd->size > 1 * G_BYTE) {
> +    if (sd->size > 1 * GiB) {
>          sd->ocr =3D FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
>      }
>  }
> @@ -377,7 +377,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>      uint32_t sectsize =3D (1 << (SECTOR_SHIFT + 1)) - 1;
>      uint32_t wpsize =3D (1 << (WPGROUP_SHIFT + 1)) - 1;
> =20
> -    if (size <=3D 1 * G_BYTE) { /* Standard Capacity SD */
> +    if (size <=3D 1 * GiB) { /* Standard Capacity SD */
>          sd->csd[0] =3D 0x00;	/* CSD structure */
>          sd->csd[1] =3D 0x26;	/* Data read access-time-1 */
>          sd->csd[2] =3D 0x00;	/* Data read access-time-2 */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 3017e5a95a..a11e802485 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -414,7 +414,7 @@ static void sdhci_end_transfer(SDHCIState *s)
>  /*
>   * Programmed i/o data transfer
>   */
> -#define BLOCK_SIZE_MASK (4 * K_BYTE - 1)
> +#define BLOCK_SIZE_MASK (4 * KiB - 1)
> =20
>  /* Fill host controller's read buffer with BLKSIZE bytes of data from ca=
rd */
>  static void sdhci_read_block_from_card(SDHCIState *s)
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 64a489c2e9..ee543ac4bf 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -2022,7 +2022,7 @@ static void test_qemu_strtosz_units(void)
>      /* default is M */
>      err =3D qemu_strtosz_MiB(none, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, M_BYTE);
> +    g_assert_cmpint(res, =3D=3D, MiB);
>      g_assert(endptr =3D=3D none + 1);
> =20
>      err =3D qemu_strtosz(b, &endptr, &res);
> @@ -2032,32 +2032,32 @@ static void test_qemu_strtosz_units(void)
> =20
>      err =3D qemu_strtosz(k, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, K_BYTE);
> +    g_assert_cmpint(res, =3D=3D, KiB);
>      g_assert(endptr =3D=3D k + 2);
> =20
>      err =3D qemu_strtosz(m, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, M_BYTE);
> +    g_assert_cmpint(res, =3D=3D, MiB);
>      g_assert(endptr =3D=3D m + 2);
> =20
>      err =3D qemu_strtosz(g, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, G_BYTE);
> +    g_assert_cmpint(res, =3D=3D, GiB);
>      g_assert(endptr =3D=3D g + 2);
> =20
>      err =3D qemu_strtosz(t, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, T_BYTE);
> +    g_assert_cmpint(res, =3D=3D, TiB);
>      g_assert(endptr =3D=3D t + 2);
> =20
>      err =3D qemu_strtosz(p, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, P_BYTE);
> +    g_assert_cmpint(res, =3D=3D, PiB);
>      g_assert(endptr =3D=3D p + 2);
> =20
>      err =3D qemu_strtosz(e, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, E_BYTE);
> +    g_assert_cmpint(res, =3D=3D, EiB);
>      g_assert(endptr =3D=3D e + 2);
>  }
> =20
> @@ -2070,7 +2070,7 @@ static void test_qemu_strtosz_float(void)
> =20
>      err =3D qemu_strtosz(str, &endptr, &res);
>      g_assert_cmpint(err, =3D=3D, 0);
> -    g_assert_cmpint(res, =3D=3D, 12.345 * M_BYTE);
> +    g_assert_cmpint(res, =3D=3D, 12.345 * MiB);
>      g_assert(endptr =3D=3D str + 7);
>  }
> =20
> @@ -2106,7 +2106,7 @@ static void test_qemu_strtosz_trailing(void)
> =20
>      str =3D "123xxx";
>      err =3D qemu_strtosz_MiB(str, &endptr, &res);
> -    g_assert_cmpint(res, =3D=3D, 123 * M_BYTE);
> +    g_assert_cmpint(res, =3D=3D, 123 * MiB);
>      g_assert(endptr =3D=3D str + 3);
> =20
>      err =3D qemu_strtosz(str, NULL, &res);
> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> index 63cb14629b..92d8e9fa89 100644
> --- a/tests/test-keyval.c
> +++ b/tests/test-keyval.c
> @@ -457,11 +457,11 @@ static void test_keyval_visit_size(void)
>      visit_type_size(v, "sz2", &sz, &error_abort);
>      g_assert_cmpuint(sz, =3D=3D, 1536);
>      visit_type_size(v, "sz3", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 2 * M_BYTE);
> +    g_assert_cmphex(sz, =3D=3D, 2 * MiB);
>      visit_type_size(v, "sz4", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, G_BYTE / 10);
> +    g_assert_cmphex(sz, =3D=3D, GiB / 10);
>      visit_type_size(v, "sz5", &sz, &error_abort);
> -    g_assert_cmphex(sz, =3D=3D, 16777215 * T_BYTE);
> +    g_assert_cmphex(sz, =3D=3D, 16777215 * TiB);
>      visit_check_struct(v, &error_abort);
>      visit_end_struct(v, NULL);
>      visit_free(v);
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 7092e216f7..7074a176d7 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -704,13 +704,12 @@ static void test_opts_parse_size(void)
>      g_assert_cmpuint(opts_count(opts), =3D=3D, 3);
>      g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), =3D=3D, 8);
>      g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), =3D=3D, 1536);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), =3D=3D, 2 * M_B=
YTE);
> +    g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), =3D=3D, 2 * MiB=
);
>      opts =3D qemu_opts_parse(&opts_list_02, "size1=3D0.1G,size2=3D167772=
15T",
>                             false, &error_abort);
>      g_assert_cmpuint(opts_count(opts), =3D=3D, 2);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), =3D=3D, G_BYTE =
/ 10);
> -    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0),
> -                     =3D=3D, 16777215 * T_BYTE);
> +    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), =3D=3D, GiB / 1=
0);
> +    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), =3D=3D, 1677721=
5 * TiB);
> =20
>      /* Beyond limit with suffix */
>      opts =3D qemu_opts_parse(&opts_list_02, "size1=3D16777216T",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsd2mAACgkQbDjKyiDZ
s5KASw/+PZUM4YIRcKovX/DJO6Fy52RFTbT+IzULR3jeN7uqikDBf3J6Db+NwccK
enP6TcTPP6vbfjbHeBrrAQDNaJOYUoMhWtjtDCJaLvA261PG6JXB1SxkKVXPOU8v
Zspe578OugDPjlnB6+mupphKQfTKWUEbzPxy9dmOY+Mci5mvGjWC0KUGnbFGgiQ8
RyC56Fw3HUA3xXHFBkGxs84cKOfPIEYlTiWE2ey27rG2kqDF31F/2JJGgvOHfS2o
4+BSEqSNPjAeg/Aeb+20wAyyt+HWW60CDcI82b6HCIQbFRwx2WpzLo7sfdXcTSuh
Zu0j87dwsaLERg6eZ2GzCzkMWzuov+XXxGZ/HxWE57oKVAeth6X/eQ9VJdJqAyIz
wqLX8o4N7JwrUPWqnK8IOmm2uWxlRS5kWyhePOZJ5Wynxh2C8mivmBAQ0rwyLKf4
0L9k8MDzPrLPuxv9qEZaHFoNKkbmziagXblhcdC9OSLDu7uagqr05mNo9NZ7VPi0
hmlYc7Vst/Ye+L45m71SI6iUwDj8Q/gbOJDLd/HelyYwrqFWrbWGXEsXUkcxYU0X
0fG2IHVqVMx78nw8F2OXEKsFWClTDi90a/6f8CavDEEjTN0dW/7vqMRqOcTza5YH
k4t6GNfkWtsnurz7JJymhWUYR+5z/pxhoKJ6aqkhDEa1AbzRHqA=
=OP37
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
