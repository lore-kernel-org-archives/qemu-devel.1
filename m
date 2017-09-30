Received: from eggs.gnu.org ([2001:4830:134:3::10]:54689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7o4-0004xm-CD
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7o1-0001y5-Hv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:47:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<d057adf716f3dbd24ab2c0721baf8318c15a866c.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <70a7f96c-d952-3a43-1b56-85beb045e41d@amsat.org>
Date: Fri, 29 Sep 2017 23:46:56 -0300
MIME-Version: 1.0
In-Reply-To: <d057adf716f3dbd24ab2c0721baf8318c15a866c.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 05/47] hw/arm: Replace
 fprintf(stderr, "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, qemu-arm@nongnu.org, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:15 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: qemu-arm@nongnu.org
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/arm/armv7m.c      |  2 +-
>   hw/arm/boot.c        | 34 +++++++++++++++++-----------------
>   hw/arm/gumstix.c     | 13 +++++++------
>   hw/arm/mainstone.c   |  7 ++++---
>   hw/arm/musicpal.c    |  2 +-
>   hw/arm/omap1.c       |  5 +++--
>   hw/arm/omap2.c       | 23 ++++++++++++-----------
>   hw/arm/omap_sx1.c    |  6 +++---
>   hw/arm/palm.c        | 10 +++++-----
>   hw/arm/pxa2xx.c      |  7 ++++---
>   hw/arm/stellaris.c   |  3 ++-
>   hw/arm/tosa.c        | 17 +++++++++--------
>   hw/arm/versatilepb.c |  2 +-
>   hw/arm/vexpress.c    |  8 ++++----
>   hw/arm/z2.c          |  6 +++---
>   15 files changed, 76 insertions(+), 69 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index bb2dfc942b..56770a7048 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -278,7 +278,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>   #endif
>   
>       if (!kernel_filename && !qtest_enabled()) {
> -        fprintf(stderr, "Guest image must be specified (using -kernel)\n");
> +        error_report("Guest image must be specified (using -kernel)");
>           exit(1);
>       }
>   
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c2720c8046..5b2d17f08a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include <libfdt.h>
>   #include "hw/hw.h"
> @@ -418,13 +419,13 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>           char *filename;
>           filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, binfo->dtb_filename);
>           if (!filename) {
> -            fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
> +            error_report("Couldn't open dtb file %s", binfo->dtb_filename);
>               goto fail;
>           }
>   
>           fdt = load_device_tree(filename, &size);
>           if (!fdt) {
> -            fprintf(stderr, "Couldn't open dtb file %s\n", filename);
> +            error_report("Couldn't open dtb file %s", filename);
>               g_free(filename);
>               goto fail;
>           }
> @@ -432,7 +433,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>       } else {
>           fdt = binfo->get_dtb(binfo, &size);
>           if (!fdt) {
> -            fprintf(stderr, "Board was unable to create a dtb blob\n");
> +            error_report("Board was unable to create a dtb blob");
>               goto fail;
>           }
>       }
> @@ -451,7 +452,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>       scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
>                                      NULL, &error_fatal);
>       if (acells == 0 || scells == 0) {
> -        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
> +        error_report("dtb file invalid (#address-cells or #size-cells 0)");
>           goto fail;
>       }
>   
> @@ -459,8 +460,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>           /* This is user error so deserves a friendlier error message
>            * than the failure of setprop_sized_cells would provide
>            */
> -        fprintf(stderr, "qemu: dtb file not compatible with "
> -                "RAM size > 4GB\n");

Maybe we can drop the "qemu:"

> +        error_report("qemu: dtb file not compatible with RAM size > 4GB");
>           goto fail;
>       }
>   
> @@ -480,7 +480,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                                                 acells, mem_base,
>                                                 scells, mem_len);
>               if (rc < 0) {
> -                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
> +                error_report("couldn't set %s/reg for node %d", nodename,
>                           i);
>                   goto fail;
>               }
> @@ -505,7 +505,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                                             acells, binfo->loader_start,
>                                             scells, binfo->ram_size);
>           if (rc < 0) {
> -            fprintf(stderr, "couldn't set /memory/reg\n");
> +            error_report("couldn't set /memory/reg");
>               goto fail;
>           }
>       }
> @@ -519,7 +519,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>           rc = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>                                        binfo->kernel_cmdline);
>           if (rc < 0) {
> -            fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +            error_report("couldn't set /chosen/bootargs");
>               goto fail;
>           }
>       }
> @@ -528,14 +528,14 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>           rc = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
>                                      binfo->initrd_start);
>           if (rc < 0) {
> -            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
> +            error_report("couldn't set /chosen/linux,initrd-start");
>               goto fail;
>           }
>   
>           rc = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
>                                      binfo->initrd_start + binfo->initrd_size);
>           if (rc < 0) {
> -            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
> +            error_report("couldn't set /chosen/linux,initrd-end");
>               goto fail;
>           }
>       }
> @@ -690,7 +690,7 @@ static void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
>           gsize length;
>   
>           if (!g_file_get_contents(image_name, &contents, &length, NULL)) {
> -            fprintf(stderr, "failed to load \"%s\"\n", image_name);
> +            error_report("failed to load \"%s\"", image_name);
>               exit(1);
>           }
>           size = length;
> @@ -956,7 +956,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>           is_linux = 1;
>       }
>       if (kernel_size < 0) {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +        error_report("qemu: could not load kernel '%s'",
>                   info->kernel_filename);
>           exit(1);
>       }
> @@ -976,7 +976,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>                                                     info->initrd_start);
>               }
>               if (initrd_size < 0) {
> -                fprintf(stderr, "qemu: could not load initrd '%s'\n",
> +                error_report("qemu: could not load initrd '%s'",
>                           info->initrd_filename);
>                   exit(1);
>               }
> @@ -1021,9 +1021,9 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>           } else {
>               fixupcontext[FIXUP_ARGPTR] = info->loader_start + KERNEL_ARGS_ADDR;
>               if (info->ram_size >= (1ULL << 32)) {
> -                fprintf(stderr, "qemu: RAM size must be less than 4GB to boot"
> -                        " Linux kernel using ATAGS (try passing a device tree"
> -                        " using -dtb)\n");
> +                error_report("qemu: RAM size must be less than 4GB to boot"
> +                            " Linux kernel using ATAGS (try passing a device tree"
> +                            " using -dtb)");
>                   exit(1);
>               }
>           }
> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
> index bba9e9f57a..8bd34956b7 100644
> --- a/hw/arm/gumstix.c
> +++ b/hw/arm/gumstix.c
> @@ -35,6 +35,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/arm/pxa.h"
>   #include "net/net.h"
> @@ -62,8 +63,8 @@ static void connex_init(MachineState *machine)
>   
>       dinfo = drive_get(IF_PFLASH, 0, 0);
>       if (!dinfo && !qtest_enabled()) {
> -        fprintf(stderr, "A flash image must be given with the "
> -                "'pflash' parameter\n");
> +        error_report("A flash image must be given with the "
> +                     "'pflash' parameter");
>           exit(1);
>       }
>   
> @@ -76,7 +77,7 @@ static void connex_init(MachineState *machine)
>                                  dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                  sector_len, connex_rom / sector_len,
>                                  2, 0, 0, 0, 0, be)) {
> -        fprintf(stderr, "qemu: Error registering flash memory.\n");
> +        error_report("qemu: Error registering flash memory.");
>           exit(1);
>       }
>   
> @@ -99,8 +100,8 @@ static void verdex_init(MachineState *machine)
>   
>       dinfo = drive_get(IF_PFLASH, 0, 0);
>       if (!dinfo && !qtest_enabled()) {
> -        fprintf(stderr, "A flash image must be given with the "
> -                "'pflash' parameter\n");
> +        error_report("A flash image must be given with the "
> +                     "'pflash' parameter");
>           exit(1);
>       }
>   
> @@ -113,7 +114,7 @@ static void verdex_init(MachineState *machine)
>                                  dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                  sector_len, verdex_rom / sector_len,
>                                  2, 0, 0, 0, 0, be)) {
> -        fprintf(stderr, "qemu: Error registering flash memory.\n");
> +        error_report("qemu: Error registering flash memory.");
>           exit(1);
>       }
>   
> diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
> index d07972a966..5c454c7109 100644
> --- a/hw/arm/mainstone.c
> +++ b/hw/arm/mainstone.c
> @@ -12,6 +12,7 @@
>    * GNU GPL, version 2 or (at your option) any later version.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "hw/hw.h"
>   #include "hw/arm/pxa.h"
> @@ -143,8 +144,8 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
>               if (qtest_enabled()) {
>                   break;
>               }
> -            fprintf(stderr, "Two flash images must be given with the "
> -                    "'pflash' parameter\n");
> +            error_report("Two flash images must be given with the "
> +                         "'pflash' parameter");
>               exit(1);
>           }
>   
> @@ -154,7 +155,7 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
>                                      blk_by_legacy_dinfo(dinfo),
>                                      sector_len, MAINSTONE_FLASH / sector_len,
>                                      4, 0, 0, 0, 0, be)) {
> -            fprintf(stderr, "qemu: Error registering flash memory.\n");
> +            error_report("qemu: Error registering flash memory.");
>               exit(1);
>           }
>       }
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index b648770882..06127a873d 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1626,7 +1626,7 @@ static void musicpal_init(MachineState *machine)
>           flash_size = blk_getlength(blk);
>           if (flash_size != 8*1024*1024 && flash_size != 16*1024*1024 &&
>               flash_size != 32*1024*1024) {
> -            fprintf(stderr, "Invalid flash image size\n");
> +            error_report("Invalid flash image size");
>               exit(1);
>           }
>   
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 64f2ee8356..c6d19387fc 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -18,6 +18,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
> @@ -2313,7 +2314,7 @@ void omap_uwire_attach(struct omap_uwire_s *s,
>                   uWireSlave *slave, int chipselect)
>   {
>       if (chipselect < 0 || chipselect > 3) {
> -        fprintf(stderr, "%s: Bad chipselect %i\n", __func__, chipselect);
> +        error_report("%s: Bad chipselect %i", __func__, chipselect);
>           exit(-1);
>       }
>   
> @@ -3989,7 +3990,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>   
>       dinfo = drive_get(IF_SD, 0, 0);
>       if (!dinfo) {
> -        fprintf(stderr, "qemu: missing SecureDigital device\n");
> +        error_report("qemu: missing SecureDigital device");

anyway:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>           exit(1);
>       }
>       s->mmc = omap_mmc_init(0xfffb7800, system_memory,
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index 758a26f3d8..e7afcc822a 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
> @@ -1311,8 +1312,8 @@ static void omap_prcm_apll_update(struct omap_prcm_s *s)
>       /* TODO: update clocks */
>   
>       if (mode[0] == 1 || mode[0] == 2 || mode[1] == 1 || mode[1] == 2)
> -        fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
> -                __func__);
> +        error_report("%s: bad EN_54M_PLL or bad EN_96M_PLL",
> +                     __func__);
>   }
>   
>   static void omap_prcm_dpll_update(struct omap_prcm_s *s)
> @@ -1331,7 +1332,7 @@ static void omap_prcm_dpll_update(struct omap_prcm_s *s)
>       s->dpll_lock = 0;
>       switch (mode) {
>       case 0:
> -        fprintf(stderr, "%s: bad EN_DPLL\n", __func__);
> +        error_report("%s: bad EN_DPLL", __func__);
>           break;
>       case 1:	/* Low-power bypass mode (Default) */
>       case 2:	/* Fast-relock bypass mode */
> @@ -1358,7 +1359,7 @@ static void omap_prcm_dpll_update(struct omap_prcm_s *s)
>           omap_clk_reparent(core, dpll_x2);
>           break;
>       case 3:
> -        fprintf(stderr, "%s: bad CORE_CLK_SRC\n", __func__);
> +        error_report("%s: bad CORE_CLK_SRC", __func__);
>           break;
>       }
>   }
> @@ -1627,8 +1628,8 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
>   
>       case 0x500:	/* CM_CLKEN_PLL */
>           if (value & 0xffffff30)
> -            fprintf(stderr, "%s: write 0s in CM_CLKEN_PLL for "
> -                            "future compatibility\n", __func__);
> +            error_report("%s: write 0s in CM_CLKEN_PLL for "
> +                         "future compatibility", __func__);
>           if ((s->clken[9] ^ value) & 0xcc) {
>               s->clken[9] &= ~0xcc;
>               s->clken[9] |= value & 0xcc;
> @@ -1646,8 +1647,8 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
>           break;
>       case 0x540:	/* CM_CLKSEL1_PLL */
>           if (value & 0xfc4000d7)
> -            fprintf(stderr, "%s: write 0s in CM_CLKSEL1_PLL for "
> -                            "future compatibility\n", __func__);
> +            error_report("%s: write 0s in CM_CLKSEL1_PLL for "
> +                         "future compatibility", __func__);
>           if ((s->clksel[5] ^ value) & 0x003fff00) {
>               s->clksel[5] = value & 0x03bfff28;
>               omap_prcm_dpll_update(s);
> @@ -1658,8 +1659,8 @@ static void omap_prcm_write(void *opaque, hwaddr addr,
>           break;
>       case 0x544:	/* CM_CLKSEL2_PLL */
>           if (value & ~3)
> -            fprintf(stderr, "%s: write 0s in CM_CLKSEL2_PLL[31:2] for "
> -                            "future compatibility\n", __func__);
> +            error_report("%s: write 0s in CM_CLKSEL2_PLL[31:2] for "
> +                         "future compatibility", __func__);
>           if (s->clksel[6] != (value & 3)) {
>               s->clksel[6] = value & 3;
>               omap_prcm_dpll_update(s);
> @@ -2486,7 +2487,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>   
>       dinfo = drive_get(IF_SD, 0, 0);
>       if (!dinfo) {
> -        fprintf(stderr, "qemu: missing SecureDigital device\n");
> +        error_report("qemu: missing SecureDigital device");
>           exit(1);
>       }
>       s->mmc = omap2_mmc_init(omap_l4tao(s->l4, 9),
> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
> index 9a14270795..6eb56ae744 100644
> --- a/hw/arm/omap_sx1.c
> +++ b/hw/arm/omap_sx1.c
> @@ -158,7 +158,7 @@ static void sx1_init(MachineState *machine, const int version)
>                                      blk_by_legacy_dinfo(dinfo),
>                                      sector_size, flash_size / sector_size,
>                                      4, 0, 0, 0, 0, be)) {
> -            fprintf(stderr, "qemu: Error registering flash memory %d.\n",
> +            error_report("qemu: Error registering flash memory %d.",
>                              fl_idx);
>           }
>           fl_idx++;
> @@ -182,7 +182,7 @@ static void sx1_init(MachineState *machine, const int version)
>                                      blk_by_legacy_dinfo(dinfo),
>                                      sector_size, flash1_size / sector_size,
>                                      4, 0, 0, 0, 0, be)) {
> -            fprintf(stderr, "qemu: Error registering flash memory %d.\n",
> +            error_report("qemu: Error registering flash memory %d.",
>                              fl_idx);
>           }
>           fl_idx++;
> @@ -194,7 +194,7 @@ static void sx1_init(MachineState *machine, const int version)
>       }
>   
>       if (!machine->kernel_filename && !fl_idx && !qtest_enabled()) {
> -        fprintf(stderr, "Kernel or Flash image must be specified\n");
> +        error_report("Kernel or Flash image must be specified");
>           exit(1);
>       }
>   
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 285f43709d..7f3637041a 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -233,8 +233,8 @@ static void palmte_init(MachineState *machine)
>       if (nb_option_roms) {
>           rom_size = get_image_size(option_rom[0].name);
>           if (rom_size > flash_size) {
> -            fprintf(stderr, "%s: ROM image too big (%x > %x)\n",
> -                            __func__, rom_size, flash_size);
> +            error_report("%s: ROM image too big (%x > %x)",
> +                         __func__, rom_size, flash_size);
>               rom_size = 0;
>           }
>           if (rom_size > 0) {
> @@ -243,13 +243,13 @@ static void palmte_init(MachineState *machine)
>               rom_loaded = 1;
>           }
>           if (rom_size < 0) {
> -            fprintf(stderr, "%s: error loading '%s'\n",
> -                            __func__, option_rom[0].name);
> +            error_report("%s: error loading '%s'",
> +                         __func__, option_rom[0].name);
>           }
>       }
>   
>       if (!rom_loaded && !kernel_filename && !qtest_enabled()) {
> -        fprintf(stderr, "Kernel or ROM image must be specified\n");
> +        fprintf(stderr, "Kernel or ROM image must be specified");
>           exit(1);
>       }
>   
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index db860c238e..ffcb83d1a3 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
> @@ -2062,7 +2063,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
>       s = g_new0(PXA2xxState, 1);
>   
>       if (strncmp(cpu_type, "pxa27", 5)) {
> -        fprintf(stderr, "Machine requires a PXA27x processor.\n");
> +        error_report("Machine requires a PXA27x processor.");
>           exit(1);
>       }
>   
> @@ -2095,7 +2096,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
>   
>       dinfo = drive_get(IF_SD, 0, 0);
>       if (!dinfo) {
> -        fprintf(stderr, "qemu: missing SecureDigital device\n");
> +        error_report("qemu: missing SecureDigital device");
>           exit(1);
>       }
>       s->mmc = pxa2xx_mmci_init(address_space, 0x41100000,
> @@ -2220,7 +2221,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
>   
>       dinfo = drive_get(IF_SD, 0, 0);
>       if (!dinfo) {
> -        fprintf(stderr, "qemu: missing SecureDigital device\n");
> +        error_report("qemu: missing SecureDigital device");
>           exit(1);
>       }
>       s->mmc = pxa2xx_mmci_init(address_space, 0x41100000,
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index de7c0fc4a6..f6f295b363 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "hw/sysbus.h"
>   #include "hw/ssi/ssi.h"
> @@ -559,7 +560,7 @@ static void ssys_write(void *opaque, hwaddr offset,
>       case 0x040: /* SRCR0 */
>       case 0x044: /* SRCR1 */
>       case 0x048: /* SRCR2 */
> -        fprintf(stderr, "Peripheral reset not implemented\n");
> +        error_report("Peripheral reset not implemented");
>           break;
>       case 0x054: /* IMC */
>           s->int_mask = value & 0x7f;
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index a55b1a369c..a069c95f1c 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -12,6 +12,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "hw/hw.h"
>   #include "hw/arm/pxa.h"
> @@ -70,19 +71,19 @@ static void tosa_out_switch(void *opaque, int line, int level)
>   {
>       switch (line) {
>           case 0:
> -            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
> +            error_report("blue LED %s.", level ? "on" : "off");
>               break;
>           case 1:
> -            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
> +            error_report("green LED %s.", level ? "on" : "off");
>               break;
>           case 2:
> -            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
> +            error_report("amber LED %s.", level ? "on" : "off");
>               break;
>           case 3:
> -            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
> +            fprintf(stderr, "wlan LED %s.", level ? "on" : "off");
>               break;
>           default:
> -            fprintf(stderr, "Uhandled out event: %d = %d\n", line, level);
> +            fprintf(stderr, "Uhandled out event: %d = %d", line, level);
>               break;
>       }
>   }
> @@ -133,7 +134,7 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>   
>   static uint32_t tosa_ssp_tansfer(SSISlave *dev, uint32_t value)
>   {
> -    fprintf(stderr, "TG: %d %02x\n", value >> 5, value & 0x1f);
> +    error_report("TG: %d %02x", value >> 5, value & 0x1f);
>       return 0;
>   }
>   
> @@ -159,13 +160,13 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
>       s->buf[s->len] = data;
>       if (s->len ++ > 2) {
>   #ifdef VERBOSE
> -        fprintf(stderr, "%s: message too long (%i bytes)\n", __func__, s->len);
> +        error_report("%s: message too long (%i bytes)", __func__, s->len);
>   #endif
>           return 1;
>       }
>   
>       if (s->len == 2) {
> -        fprintf(stderr, "dac: channel %d value 0x%02x\n",
> +        error_report("dac: channel %d value 0x%02x",
>                   s->buf[0], s->buf[1]);
>       }
>   
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index 418792cd02..f0ae069172 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -364,7 +364,7 @@ static void versatile_init(MachineState *machine, int board_id)
>                             VERSATILE_FLASH_SECT_SIZE,
>                             VERSATILE_FLASH_SIZE / VERSATILE_FLASH_SECT_SIZE,
>                             4, 0x0089, 0x0018, 0x0000, 0x0, 0)) {
> -        fprintf(stderr, "qemu: Error registering flash memory.\n");
> +        error_report("qemu: Error registering flash memory.");
>       }
>   
>       versatile_binfo.ram_size = machine->ram_size;
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index efb5a29475..508629dfe9 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -266,7 +266,7 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
>   
>       if (ram_size > 0x40000000) {
>           /* 1GB is the maximum the address space permits */
> -        fprintf(stderr, "vexpress-a9: cannot model more than 1GB RAM\n");
> +        error_report("vexpress-a9: cannot model more than 1GB RAM");
>           exit(1);
>       }
>   
> @@ -355,7 +355,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
>            */
>           uint64_t rsz = ram_size;
>           if (rsz > (30ULL * 1024 * 1024 * 1024)) {
> -            fprintf(stderr, "vexpress-a15: cannot model more than 30GB RAM\n");
> +            error_report("vexpress-a15: cannot model more than 30GB RAM");
>               exit(1);
>           }
>       }
> @@ -640,7 +640,7 @@ static void vexpress_common_init(MachineState *machine)
>       pflash0 = ve_pflash_cfi01_register(map[VE_NORFLASH0], "vexpress.flash0",
>                                          dinfo);
>       if (!pflash0) {
> -        fprintf(stderr, "vexpress: error registering flash 0.\n");
> +        error_report("vexpress: error registering flash 0.");
>           exit(1);
>       }
>   
> @@ -655,7 +655,7 @@ static void vexpress_common_init(MachineState *machine)
>       dinfo = drive_get_next(IF_PFLASH);
>       if (!ve_pflash_cfi01_register(map[VE_NORFLASH1], "vexpress.flash1",
>                                     dinfo)) {
> -        fprintf(stderr, "vexpress: error registering flash 1.\n");
> +        error_report("vexpress: error registering flash 1.");
>           exit(1);
>       }
>   
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index 60561c7b7c..5048439799 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -319,8 +319,8 @@ static void z2_init(MachineState *machine)
>   #endif
>       dinfo = drive_get(IF_PFLASH, 0, 0);
>       if (!dinfo && !qtest_enabled()) {
> -        fprintf(stderr, "Flash image must be given with the "
> -                "'pflash' parameter\n");
> +        error_report("Flash image must be given with the "
> +                     "'pflash' parameter");
>           exit(1);
>       }
>   
> @@ -329,7 +329,7 @@ static void z2_init(MachineState *machine)
>                                  dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                  sector_len, Z2_FLASH_SIZE / sector_len,
>                                  4, 0, 0, 0, 0, be)) {
> -        fprintf(stderr, "qemu: Error registering flash memory.\n");
> +        error_report("qemu: Error registering flash memory.");
>           exit(1);
>       }
>   
> 
