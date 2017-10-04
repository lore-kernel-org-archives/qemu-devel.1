Received: from eggs.gnu.org ([2001:4830:134:3::10]:39883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzd0A-00056W-Mt
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzd08-0002NM-Cg
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:17:50 -0400
Date: Wed, 4 Oct 2017 17:11:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004061117.GW3260@umbus.fritz.box>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<c3849730c544362ab5e7965f1c5c85ed987b57a7.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahZICQ7iXVM/oLYH"
Content-Disposition: inline
In-Reply-To: <c3849730c544362ab5e7965f1c5c85ed987b57a7.1506730372.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v2 32/47] hw/ppc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, qemu-ppc@nongnu.org, armbru@redhat.com


--ahZICQ7iXVM/oLYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2017 at 05:16:36PM -0700, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
>=20
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
>     {} +
>=20
> Some lines where then manually tweaked to pass checkpatch.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> Cc: qemu-ppc@nongnu.org
> ---
> V2:
>  - Split hw patch into individual directories
>=20
>  hw/ppc/e500.c          | 20 ++++++++++----------
>  hw/ppc/mac_newworld.c  |  2 +-
>  hw/ppc/mac_oldworld.c  |  2 +-
>  hw/ppc/mpc8544_guts.c  |  5 +++--
>  hw/ppc/ppc405_boards.c |  8 ++++----
>  hw/ppc/ppc440_bamboo.c | 19 ++++++++++---------
>  hw/ppc/ppc4xx_pci.c    |  3 ++-
>  hw/ppc/prep.c          |  4 ++--
>  hw/ppc/virtex_ml507.c  |  4 ++--
>  9 files changed, 35 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index db0e49ab8f..8a5350161f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -333,13 +333,13 @@ static int ppce500_load_device_tree(MachineState *m=
achine,
>          ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-star=
t",
>                                      initrd_base);
>          if (ret < 0) {
> -            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
> +            error_report("couldn't set /chosen/linux,initrd-start");
>          }
> =20
>          ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
>                                      (initrd_base + initrd_size));
>          if (ret < 0) {
> -            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
> +            error_report("couldn't set /chosen/linux,initrd-end");
>          }
> =20
>      }
> @@ -353,7 +353,7 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>      ret =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>                                        machine->kernel_cmdline);
>      if (ret < 0)
> -        fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +        error_report("couldn't set /chosen/bootargs");
> =20
>      if (kvm_enabled()) {
>          /* Read out host's frequencies */
> @@ -720,7 +720,7 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Para=
ms *params,
> =20
>      CPU_FOREACH(cs) {
>          if (kvm_openpic_connect_vcpu(dev, cs)) {
> -            fprintf(stderr, "%s: failed to connect vcpu to irqchip\n",
> +            error_report("%s: failed to connect vcpu to irqchip",
>                      __func__);
>              abort();
>          }
> @@ -821,7 +821,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>          cs =3D CPU(cpu);
> =20
>          if (env->mmu_model !=3D POWERPC_MMU_BOOKE206) {
> -            fprintf(stderr, "MMU model %i not supported by this machine.=
\n",
> +            error_report("MMU model %i not supported by this machine.",
>                  env->mmu_model);
>              exit(1);
>          }
> @@ -967,7 +967,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>                                            cur_base,
>                                            ram_size - cur_base);
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      machine->kernel_filename);
>              exit(1);
>          }
> @@ -982,8 +982,8 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>                                            ram_size - initrd_base);
> =20
>          if (initrd_size < 0) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
> -                    machine->initrd_filename);
> +            error_report("qemu: could not load initial ram disk '%s'",
> +                         machine->initrd_filename);
>              exit(1);
>          }
> =20
> @@ -1024,7 +1024,7 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>          kernel_size =3D load_uimage(filename, &bios_entry, &loadaddr, NU=
LL,
>                                    NULL, NULL);
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load firmware '%s'\n", file=
name);
> +            error_report("qemu: could not load firmware '%s'", filename);
>              exit(1);
>          }
>      }
> @@ -1037,7 +1037,7 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>                                         initrd_base, initrd_size,
>                                         kernel_base, kernel_size);
>      if (dt_size < 0) {
> -        fprintf(stderr, "couldn't load device tree\n");
> +        error_report("couldn't load device tree");
>          exit(1);
>      }
>      assert(dt_size < DTB_MAX_SIZE);
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 6d0ace20ca..fa54056bc3 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -278,7 +278,7 @@ static void ppc_core99_init(MachineState *machine)
>              }
>          }
>          if (ppc_boot_device =3D=3D '\0') {
> -            fprintf(stderr, "No valid boot device for Mac99 machine\n");
> +            error_report("No valid boot device for Mac99 machine");
>              exit(1);
>          }
>      }
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index bc7c8b7bd7..4d75113533 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -221,7 +221,7 @@ static void ppc_heathrow_init(MachineState *machine)
>  #endif
>          }
>          if (ppc_boot_device =3D=3D '\0') {
> -            fprintf(stderr, "No valid boot device for G3 Beige machine\n=
");
> +            error_report("No valid boot device for G3 Beige machine");
>              exit(1);
>          }
>      }
> diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
> index ce1254b5d4..3a2c49e3fd 100644
> --- a/hw/ppc/mpc8544_guts.c
> +++ b/hw/ppc/mpc8544_guts.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> @@ -83,7 +84,7 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr =
addr,
>          value =3D env->spr[SPR_E500_SVR];
>          break;
>      default:
> -        fprintf(stderr, "guts: Unknown register read: %x\n", (int)addr);
> +        error_report("guts: Unknown register read: %x", (int)addr);
>          break;
>      }
> =20
> @@ -102,7 +103,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr a=
ddr,
>          }
>          break;
>      default:
> -        fprintf(stderr, "guts: Unknown register write: %x =3D %x\n",
> +        error_report("guts: Unknown register write: %x =3D %x",
>                  (int)addr, (unsigned)value);
>          break;
>      }
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index e92db2c66a..0a31a1c116 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -324,7 +324,7 @@ static void ref405ep_init(MachineState *machine)
>          kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
>                                            ram_size - kernel_base);
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }
> @@ -336,8 +336,8 @@ static void ref405ep_init(MachineState *machine)
>              initrd_size =3D load_image_targphys(initrd_filename, initrd_=
base,
>                                                ram_size - initrd_base);
>              if (initrd_size < 0) {
> -                fprintf(stderr, "qemu: could not load initial ram disk '=
%s'\n",
> -                        initrd_filename);
> +                error_report("qemu: could not load initial ram disk '%s'=
",
> +                             initrd_filename);
>                  exit(1);
>              }
>          } else {
> @@ -607,7 +607,7 @@ static void taihu_405ep_init(MachineState *machine)
>          kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
>                                            ram_size - kernel_base);
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index f92d47f28d..77b74dfe9e 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -12,6 +12,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "net/net.h"
>  #include "hw/hw.h"
> @@ -80,22 +81,22 @@ static int bamboo_load_device_tree(hwaddr addr,
>      ret =3D qemu_fdt_setprop(fdt, "/memory", "reg", mem_reg_property,
>                             sizeof(mem_reg_property));
>      if (ret < 0)
> -        fprintf(stderr, "couldn't set /memory/reg\n");
> +        error_report("couldn't set /memory/reg");
> =20
>      ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
>                                  initrd_base);
>      if (ret < 0)
> -        fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
> +        error_report("couldn't set /chosen/linux,initrd-start");
> =20
>      ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
>                                  (initrd_base + initrd_size));
>      if (ret < 0)
> -        fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
> +        error_report("couldn't set /chosen/linux,initrd-end");
> =20
>      ret =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>                                    kernel_cmdline);
>      if (ret < 0)
> -        fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +        error_report("couldn't set /chosen/bootargs");
> =20
>      /* Copy data from the host device tree into the guest. Since the gue=
st can
>       * directly access the timebase without host involvement, we must ex=
pose
> @@ -190,7 +191,7 @@ static void bamboo_init(MachineState *machine)
>      env =3D &cpu->env;
> =20
>      if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
> -        fprintf(stderr, "MMU model %i not supported by this machine.\n",
> +        error_report("MMU model %i not supported by this machine.",
>              env->mmu_model);
>          exit(1);
>      }
> @@ -224,7 +225,7 @@ static void bamboo_init(MachineState *machine)
>                                  NULL);
>      pcibus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>      if (!pcibus) {
> -        fprintf(stderr, "couldn't create PCI controller!\n");
> +        error_report("couldn't create PCI controller!");
>          exit(1);
>      }
> =20
> @@ -265,7 +266,7 @@ static void bamboo_init(MachineState *machine)
>          }
>          /* XXX try again as binary */
>          if (success < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }
> @@ -277,7 +278,7 @@ static void bamboo_init(MachineState *machine)
>                                            ram_size - RAMDISK_ADDR);
> =20
>          if (initrd_size < 0) {
> -            fprintf(stderr, "qemu: could not load ram disk '%s' at %x\n",
> +            error_report("qemu: could not load ram disk '%s' at %x",
>                      initrd_filename, RAMDISK_ADDR);
>              exit(1);
>          }
> @@ -287,7 +288,7 @@ static void bamboo_init(MachineState *machine)
>      if (kernel_filename) {
>          if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
>                                      initrd_size, kernel_cmdline) < 0) {
> -            fprintf(stderr, "couldn't load device tree\n");
> +            error_report("couldn't load device tree");
>              exit(1);
>          }
>      }
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 6953f8b9ac..0b91d22253 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -20,6 +20,7 @@
>   * 4xx SoCs, such as the 440EP. */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/ppc/ppc4xx.h"
> @@ -254,7 +255,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq_=
num, int level)
> =20
>      trace_ppc4xx_pci_set_irq(irq_num);
>      if (irq_num < 0) {
> -        fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
> +        error_report("%s: PCI irq %d", __func__, irq_num);
>          return;
>      }
>      qemu_set_irq(pci_irqs[irq_num], level);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 94138a4e8c..7551d53fa5 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -576,7 +576,7 @@ static void ppc_prep_init(MachineState *machine)
>              }
>          }
>          if (ppc_boot_device =3D=3D '\0') {
> -            fprintf(stderr, "No valid boot device for Mac99 machine\n");
> +            error_report("No valid boot device for Mac99 machine");
>              exit(1);
>          }
>      }
> @@ -597,7 +597,7 @@ static void ppc_prep_init(MachineState *machine)
>      qdev_init_nofail(dev);
>      pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>      if (pci_bus =3D=3D NULL) {
> -        fprintf(stderr, "Couldn't create PCI host controller.\n");
> +        error_report("Couldn't create PCI host controller.");
>          exit(1);
>      }
>      sysctrl->contiguous_map_irq =3D qdev_get_gpio_in(dev, 0);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index ed9b406fd3..7641737f81 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -187,7 +187,7 @@ static int xilinx_load_device_tree(hwaddr addr,
> =20
>      r =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", kernel_cmd=
line);
>      if (r < 0)
> -        fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +        error_report("couldn't set /chosen/bootargs");
>      cpu_physical_memory_write(addr, fdt, fdt_size);
>      return fdt_size;
>  }
> @@ -219,7 +219,7 @@ static void virtex_init(MachineState *machine)
>      env =3D &cpu->env;
> =20
>      if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
> -        fprintf(stderr, "MMU model %i not supported by this machine.\n",
> +        error_report("MMU model %i not supported by this machine.",
>              env->mmu_model);
>          exit(1);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ahZICQ7iXVM/oLYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUe4UACgkQbDjKyiDZ
s5IOMBAAuslMNHC41JsPTlQrDik9NgcqbExnN+AM2SorvoM2eZ3MM8amkaXT/+48
8wsgHORk+ny9eGAvpJpInGpwchydgvUsTriVJ/rnzmKlfVd+GRdOk94nQ4OLqD71
4Qo4V6x4EqZfUBASL7IqHrmYzucyW8KmsXepb10KggWvbq6yVvjmJUGZZHxaV544
szzXR2DSaocUzIwyKAl96uWtR7iEXm4dGvpi/hmvEdO87igL9EiUOLBZLM1Cpg0P
HCNDODe7oWrEqWez5ZKMv0/YiGpgnYkNMnXkFKrD/LUYbh0IrFUhiMUa7YQW6O8+
hgwkSXf0PsxWq82jCZq9diRqaz2LDcXyoXSlXIZbBdYDUcAyanmxPYHVebNPZNWp
szThsrRx3XASVyAwQ9TzFuvhN02ydHucn/MVODA99oS9gzVXY8xv1LhJxJK1xthh
2lhl5hEo/cm23jn7/acq9oOMDTbKtfnUqKsqM5lXebJUW/CA45PK3DtbbcMpyTsF
nguOufk+4T55OWFIps8kp+sFdGS8bn9Yb1eFa0Z/sF7XRSb8tvurpgYNFV0JUvEA
nu1AFkmrPr1/MQ5ffXcHFThI/wVgwHTPTiDko0C9givRXASV1faxPPmd6vtQntHB
Pe8EAujXMpaA3B48C0X8zJXLk3Gm7ONLZaK3As5FgPzl6WCNEKM=
=0ZgX
-----END PGP SIGNATURE-----

--ahZICQ7iXVM/oLYH--
