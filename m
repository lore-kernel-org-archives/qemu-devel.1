Received: from eggs.gnu.org ([2001:4830:134:3::10]:56481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdX2-0004lu-CB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdWg-00004s-B9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:15:24 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 25 Sep 2017 17:08:52 -0700
Message-ID: <bf3dd056ce55cbea81ca762c3c40d22683a542e7.1506384414.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506384414.git.alistair.francis@xilinx.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 3/8] hw: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Michael Walle <michael@walle.cc>, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Anthony Green <green@moxielogic.com>, Jason Wang <jasowang@redhat.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <huth@tuxfamily.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Michael Walle <michael@walle.cc>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
Cc: Anthony Green <green@moxielogic.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Jia Liu <proljc@gmail.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-arm@nongnu.org
Cc: qemu-block@nongnu.org
Cc: xen-devel@lists.xenproject.org
Cc: qemu-ppc@nongnu.org
---

 hw/arm/armv7m.c                 |  2 +-
 hw/arm/boot.c                   | 34 +++++++++----------
 hw/arm/gumstix.c                | 13 ++++----
 hw/arm/mainstone.c              |  7 ++--
 hw/arm/musicpal.c               |  2 +-
 hw/arm/omap1.c                  |  5 +--
 hw/arm/omap2.c                  | 21 ++++++------
 hw/arm/omap_sx1.c               |  6 ++--
 hw/arm/palm.c                   | 10 +++---
 hw/arm/pxa2xx.c                 |  7 ++--
 hw/arm/stellaris.c              |  3 +-
 hw/arm/tosa.c                   | 17 +++++-----
 hw/arm/versatilepb.c            |  2 +-
 hw/arm/vexpress.c               |  8 ++---
 hw/arm/z2.c                     |  6 ++--
 hw/block/dataplane/virtio-blk.c |  6 ++--
 hw/block/onenand.c              |  8 ++---
 hw/block/tc58128.c              | 44 ++++++++++++-------------
 hw/bt/core.c                    | 15 +++++----
 hw/bt/hci-csr.c                 | 17 +++++-----
 hw/bt/hci.c                     | 30 ++++++++---------
 hw/bt/hid.c                     |  2 +-
 hw/bt/l2cap.c                   | 47 ++++++++++++++-------------
 hw/bt/sdp.c                     |  7 ++--
 hw/char/exynos4210_uart.c       |  6 ++--
 hw/char/mcf_uart.c              |  5 +--
 hw/char/sh_serial.c             |  9 +++---
 hw/core/loader.c                | 31 +++++++++---------
 hw/core/ptimer.c                |  7 ++--
 hw/cris/axis_dev88.c            |  3 +-
 hw/cris/boot.c                  |  5 +--
 hw/display/blizzard.c           | 20 ++++++------
 hw/display/omap_dss.c           | 14 ++++----
 hw/display/pl110.c              |  2 +-
 hw/display/pxa2xx_lcd.c         |  2 +-
 hw/display/qxl-render.c         |  7 ++--
 hw/display/qxl.c                | 10 +++---
 hw/display/tc6393xb.c           | 36 ++++++++++++---------
 hw/display/virtio-gpu-3d.c      |  4 +--
 hw/display/vmware_vga.c         | 22 ++++++-------
 hw/dma/omap_dma.c               | 26 ++++++++-------
 hw/dma/soc_dma.c                | 37 ++++++++++-----------
 hw/gpio/omap_gpio.c             |  2 +-
 hw/i2c/omap_i2c.c               | 10 +++---
 hw/i386/kvm/apic.c              |  9 +++---
 hw/i386/kvm/clock.c             |  7 ++--
 hw/i386/kvm/i8254.c             |  7 ++--
 hw/i386/kvm/i8259.c             |  5 +--
 hw/i386/kvm/ioapic.c            |  5 +--
 hw/i386/multiboot.c             | 21 ++++++------
 hw/i386/pc.c                    | 18 +++++------
 hw/i386/pc_piix.c               |  2 +-
 hw/i386/pc_sysfw.c              |  5 +--
 hw/i386/xen/xen-hvm.c           | 32 +++++++++---------
 hw/i386/xen/xen-mapcache.c      | 12 +++----
 hw/i386/xen/xen_apic.c          |  2 +-
 hw/ide/ahci.c                   |  6 ++--
 hw/ide/core.c                   |  2 +-
 hw/input/lm832x.c               |  6 ++--
 hw/input/pckbd.c                |  3 +-
 hw/input/pxa2xx_keypad.c        |  2 +-
 hw/input/tsc2005.c              | 17 +++++-----
 hw/input/tsc210x.c              | 72 ++++++++++++++++++++-----------------=
----
 hw/input/virtio-input-hid.c     | 14 ++++----
 hw/input/virtio-input.c         |  5 +--
 hw/intc/arm_gic_kvm.c           | 12 +++----
 hw/intc/omap_intc.c             |  4 +--
 hw/intc/openpic.c               |  7 ++--
 hw/intc/openpic_kvm.c           |  8 ++---
 hw/intc/s390_flic_kvm.c         |  4 +--
 hw/ipmi/ipmi.c                  |  1 +
 hw/ipmi/ipmi_bmc_extern.c       |  5 +--
 hw/isa/isa-bus.c                |  7 ++--
 hw/lm32/lm32_boards.c           |  5 +--
 hw/lm32/milkymist.c             |  5 +--
 hw/m68k/an5206.c                |  4 +--
 hw/m68k/mcf5206.c               |  3 +-
 hw/m68k/mcf5208.c               |  7 ++--
 hw/microblaze/boot.c            |  2 +-
 hw/mips/boston.c                |  4 +--
 hw/mips/mips_fulong2e.c         |  4 +--
 hw/mips/mips_jazz.c             |  4 +--
 hw/mips/mips_malta.c            |  4 +--
 hw/mips/mips_mipssim.c          |  4 +--
 hw/mips/mips_r4k.c              |  6 ++--
 hw/misc/a9scu.c                 |  3 +-
 hw/misc/omap_gpmc.c             | 11 ++++---
 hw/misc/omap_l4.c               |  5 +--
 hw/misc/omap_sdrc.c             |  3 +-
 hw/misc/vmport.c                |  2 +-
 hw/moxie/moxiesim.c             |  7 ++--
 hw/net/fsl_etsec/etsec.c        |  2 +-
 hw/net/pcnet.c                  |  2 +-
 hw/net/smc91c111.c              |  5 +--
 hw/net/vhost_net.c              | 16 ++++-----
 hw/nios2/boot.c                 |  2 +-
 hw/nvram/eeprom93xx.c           |  5 +--
 hw/nvram/fw_cfg.c               |  4 +--
 hw/openrisc/openrisc_sim.c      |  3 +-
 hw/pci-host/bonito.c            |  6 ++--
 hw/pci/pci.c                    | 10 +++---
 hw/ppc/e500.c                   | 20 ++++++------
 hw/ppc/mac_newworld.c           |  2 +-
 hw/ppc/mac_oldworld.c           |  2 +-
 hw/ppc/mpc8544_guts.c           |  5 +--
 hw/ppc/ppc405_boards.c          |  8 ++---
 hw/ppc/ppc440_bamboo.c          | 19 +++++------
 hw/ppc/ppc4xx_pci.c             |  3 +-
 hw/ppc/prep.c                   |  4 +--
 hw/ppc/virtex_ml507.c           |  4 +--
 hw/s390x/virtio-ccw.c           |  2 +-
 hw/scsi/lsi53c895a.c            |  4 +--
 hw/scsi/spapr_vscsi.c           | 49 ++++++++++++++--------------
 hw/scsi/virtio-scsi-dataplane.c |  6 ++--
 hw/sd/pl181.c                   |  5 +--
 hw/sd/sd.c                      | 14 ++++----
 hw/sh4/r2d.c                    |  9 +++---
 hw/sh4/sh7750.c                 | 64 ++++++++++++++++++------------------
 hw/sparc/leon3.c                |  9 +++---
 hw/sparc/sun4m.c                |  8 ++---
 hw/sparc64/niagara.c            |  2 +-
 hw/sparc64/sun4u.c              |  9 +++---
 hw/ssi/omap_spi.c               |  5 +--
 hw/timer/omap_gptimer.c         | 11 ++++---
 hw/timer/twl92230.c             |  2 +-
 hw/timer/xilinx_timer.c         |  8 ++---
 hw/usb/core.c                   | 15 +++++----
 hw/usb/desc.c                   |  4 +--
 hw/usb/dev-audio.c              | 29 +++++++++--------
 hw/usb/dev-bluetooth.c          |  4 +--
 hw/usb/dev-mtp.c                |  9 +++---
 hw/usb/dev-network.c            | 20 ++++++------
 hw/usb/hcd-ehci.c               | 32 +++++++++---------
 hw/usb/hcd-musb.c               |  4 +--
 hw/usb/hcd-xhci.c               |  3 +-
 hw/usb/host-legacy.c            |  2 +-
 hw/watchdog/watchdog.c          |  9 +++---
 hw/watchdog/wdt_i6300esb.c      |  8 +++--
 hw/xen/xen-common.c             | 10 +++---
 hw/xen/xen_pt.c                 |  4 +--
 hw/xenpv/xen_domainbuild.c      | 24 +++++++-------
 hw/xenpv/xen_machine_pv.c       |  8 ++---
 142 files changed, 769 insertions(+), 705 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index bb2dfc942b..56770a7048 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -278,7 +278,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel=
_filename, int mem_size)
 #endif
=20
     if (!kernel_filename && !qtest_enabled()) {
-        fprintf(stderr, "Guest image must be specified (using -kernel)\n")=
;
+        error_report("Guest image must be specified (using -kernel)");
         exit(1);
     }
=20
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c2720c8046..5b2d17f08a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <libfdt.h>
 #include "hw/hw.h"
@@ -418,13 +419,13 @@ static int load_dtb(hwaddr addr, const struct arm_boo=
t_info *binfo,
         char *filename;
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, binfo->dtb_filena=
me);
         if (!filename) {
-            fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_file=
name);
+            error_report("Couldn't open dtb file %s", binfo->dtb_filename)=
;
             goto fail;
         }
=20
         fdt =3D load_device_tree(filename, &size);
         if (!fdt) {
-            fprintf(stderr, "Couldn't open dtb file %s\n", filename);
+            error_report("Couldn't open dtb file %s", filename);
             g_free(filename);
             goto fail;
         }
@@ -432,7 +433,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
     } else {
         fdt =3D binfo->get_dtb(binfo, &size);
         if (!fdt) {
-            fprintf(stderr, "Board was unable to create a dtb blob\n");
+            error_report("Board was unable to create a dtb blob");
             goto fail;
         }
     }
@@ -451,7 +452,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
     scells =3D qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                    NULL, &error_fatal);
     if (acells =3D=3D 0 || scells =3D=3D 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0=
)\n");
+        error_report("dtb file invalid (#address-cells or #size-cells 0)")=
;
         goto fail;
     }
=20
@@ -459,8 +460,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
         /* This is user error so deserves a friendlier error message
          * than the failure of setprop_sized_cells would provide
          */
-        fprintf(stderr, "qemu: dtb file not compatible with "
-                "RAM size > 4GB\n");
+        error_report("qemu: dtb file not compatible with RAM size > 4GB");
         goto fail;
     }
=20
@@ -480,7 +480,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
                                               acells, mem_base,
                                               scells, mem_len);
             if (rc < 0) {
-                fprintf(stderr, "couldn't set %s/reg for node %d\n", noden=
ame,
+                error_report("couldn't set %s/reg for node %d", nodename,
                         i);
                 goto fail;
             }
@@ -505,7 +505,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
                                           acells, binfo->loader_start,
                                           scells, binfo->ram_size);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /memory/reg\n");
+            error_report("couldn't set /memory/reg");
             goto fail;
         }
     }
@@ -519,7 +519,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_=
info *binfo,
         rc =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                      binfo->kernel_cmdline);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/bootargs\n");
+            error_report("couldn't set /chosen/bootargs");
             goto fail;
         }
     }
@@ -528,14 +528,14 @@ static int load_dtb(hwaddr addr, const struct arm_boo=
t_info *binfo,
         rc =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
                                    binfo->initrd_start);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+            error_report("couldn't set /chosen/linux,initrd-start");
             goto fail;
         }
=20
         rc =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
                                    binfo->initrd_start + binfo->initrd_siz=
e);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+            error_report("couldn't set /chosen/linux,initrd-end");
             goto fail;
         }
     }
@@ -690,7 +690,7 @@ static void load_image_to_fw_cfg(FWCfgState *fw_cfg, ui=
nt16_t size_key,
         gsize length;
=20
         if (!g_file_get_contents(image_name, &contents, &length, NULL)) {
-            fprintf(stderr, "failed to load \"%s\"\n", image_name);
+            error_report("failed to load \"%s\"", image_name);
             exit(1);
         }
         size =3D length;
@@ -956,7 +956,7 @@ static void arm_load_kernel_notify(Notifier *notifier, =
void *data)
         is_linux =3D 1;
     }
     if (kernel_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
+        error_report("qemu: could not load kernel '%s'",
                 info->kernel_filename);
         exit(1);
     }
@@ -976,7 +976,7 @@ static void arm_load_kernel_notify(Notifier *notifier, =
void *data)
                                                   info->initrd_start);
             }
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initrd '%s'\n",
+                error_report("qemu: could not load initrd '%s'",
                         info->initrd_filename);
                 exit(1);
             }
@@ -1021,9 +1021,9 @@ static void arm_load_kernel_notify(Notifier *notifier=
, void *data)
         } else {
             fixupcontext[FIXUP_ARGPTR] =3D info->loader_start + KERNEL_ARG=
S_ADDR;
             if (info->ram_size >=3D (1ULL << 32)) {
-                fprintf(stderr, "qemu: RAM size must be less than 4GB to b=
oot"
-                        " Linux kernel using ATAGS (try passing a device t=
ree"
-                        " using -dtb)\n");
+                error_report("qemu: RAM size must be less than 4GB to boot=
"
+                            " Linux kernel using ATAGS (try passing a devi=
ce tree"
+                            " using -dtb)");
                 exit(1);
             }
         }
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index bba9e9f57a..8bd34956b7 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -35,6 +35,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "net/net.h"
@@ -62,8 +63,8 @@ static void connex_init(MachineState *machine)
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
-        fprintf(stderr, "A flash image must be given with the "
-                "'pflash' parameter\n");
+        error_report("A flash image must be given with the "
+                     "'pflash' parameter");
         exit(1);
     }
=20
@@ -76,7 +77,7 @@ static void connex_init(MachineState *machine)
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, connex_rom / sector_len,
                                2, 0, 0, 0, 0, be)) {
-        fprintf(stderr, "qemu: Error registering flash memory.\n");
+        error_report("qemu: Error registering flash memory.");
         exit(1);
     }
=20
@@ -99,8 +100,8 @@ static void verdex_init(MachineState *machine)
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
-        fprintf(stderr, "A flash image must be given with the "
-                "'pflash' parameter\n");
+        error_report("A flash image must be given with the "
+                     "'pflash' parameter");
         exit(1);
     }
=20
@@ -113,7 +114,7 @@ static void verdex_init(MachineState *machine)
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, verdex_rom / sector_len,
                                2, 0, 0, 0, 0, be)) {
-        fprintf(stderr, "qemu: Error registering flash memory.\n");
+        error_report("qemu: Error registering flash memory.");
         exit(1);
     }
=20
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index d07972a966..5c454c7109 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -12,6 +12,7 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
@@ -143,8 +144,8 @@ static void mainstone_common_init(MemoryRegion *address=
_space_mem,
             if (qtest_enabled()) {
                 break;
             }
-            fprintf(stderr, "Two flash images must be given with the "
-                    "'pflash' parameter\n");
+            error_report("Two flash images must be given with the "
+                         "'pflash' parameter");
             exit(1);
         }
=20
@@ -154,7 +155,7 @@ static void mainstone_common_init(MemoryRegion *address=
_space_mem,
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_len, MAINSTONE_FLASH / sector_le=
n,
                                    4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory.\n");
+            error_report("qemu: Error registering flash memory.");
             exit(1);
         }
     }
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b648770882..06127a873d 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1626,7 +1626,7 @@ static void musicpal_init(MachineState *machine)
         flash_size =3D blk_getlength(blk);
         if (flash_size !=3D 8*1024*1024 && flash_size !=3D 16*1024*1024 &&
             flash_size !=3D 32*1024*1024) {
-            fprintf(stderr, "Invalid flash image size\n");
+            error_report("Invalid flash image size");
             exit(1);
         }
=20
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 1388200191..821ee69441 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -2313,7 +2314,7 @@ void omap_uwire_attach(struct omap_uwire_s *s,
                 uWireSlave *slave, int chipselect)
 {
     if (chipselect < 0 || chipselect > 3) {
-        fprintf(stderr, "%s: Bad chipselect %i\n", __func__, chipselect);
+        error_report("%s: Bad chipselect %i", __func__, chipselect);
         exit(-1);
     }
=20
@@ -3989,7 +3990,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegio=
n *system_memory,
=20
     dinfo =3D drive_get(IF_SD, 0, 0);
     if (!dinfo) {
-        fprintf(stderr, "qemu: missing SecureDigital device\n");
+        error_report("qemu: missing SecureDigital device");
         exit(1);
     }
     s->mmc =3D omap_mmc_init(0xfffb7800, system_memory,
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index b53878b8b9..cbbb3ec05f 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -1311,7 +1312,7 @@ static void omap_prcm_apll_update(struct omap_prcm_s =
*s)
     /* TODO: update clocks */
=20
     if (mode[0] =3D=3D 1 || mode[0] =3D=3D 2 || mode[1] =3D=3D 1 || mode[1=
] =3D=3D 2)
-        fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
+        error_report("%s: bad EN_54M_PLL or bad EN_96M_PLL",
                         __func__);
 }
=20
@@ -1331,7 +1332,7 @@ static void omap_prcm_dpll_update(struct omap_prcm_s =
*s)
     s->dpll_lock =3D 0;
     switch (mode) {
     case 0:
-        fprintf(stderr, "%s: bad EN_DPLL\n", __func__);
+        error_report("%s: bad EN_DPLL", __func__);
         break;
     case 1:	/* Low-power bypass mode (Default) */
     case 2:	/* Fast-relock bypass mode */
@@ -1358,7 +1359,7 @@ static void omap_prcm_dpll_update(struct omap_prcm_s =
*s)
         omap_clk_reparent(core, dpll_x2);
         break;
     case 3:
-        fprintf(stderr, "%s: bad CORE_CLK_SRC\n", __func__);
+        error_report("%s: bad CORE_CLK_SRC", __func__);
         break;
     }
 }
@@ -1627,8 +1628,8 @@ static void omap_prcm_write(void *opaque, hwaddr addr=
,
=20
     case 0x500:	/* CM_CLKEN_PLL */
         if (value & 0xffffff30)
-            fprintf(stderr, "%s: write 0s in CM_CLKEN_PLL for "
-                            "future compatibility\n", __func__);
+            error_report("%s: write 0s in CM_CLKEN_PLL for "
+                         "future compatibility", __func__);
         if ((s->clken[9] ^ value) & 0xcc) {
             s->clken[9] &=3D ~0xcc;
             s->clken[9] |=3D value & 0xcc;
@@ -1646,8 +1647,8 @@ static void omap_prcm_write(void *opaque, hwaddr addr=
,
         break;
     case 0x540:	/* CM_CLKSEL1_PLL */
         if (value & 0xfc4000d7)
-            fprintf(stderr, "%s: write 0s in CM_CLKSEL1_PLL for "
-                            "future compatibility\n", __func__);
+            error_report("%s: write 0s in CM_CLKSEL1_PLL for "
+                         "future compatibility", __func__);
         if ((s->clksel[5] ^ value) & 0x003fff00) {
             s->clksel[5] =3D value & 0x03bfff28;
             omap_prcm_dpll_update(s);
@@ -1658,8 +1659,8 @@ static void omap_prcm_write(void *opaque, hwaddr addr=
,
         break;
     case 0x544:	/* CM_CLKSEL2_PLL */
         if (value & ~3)
-            fprintf(stderr, "%s: write 0s in CM_CLKSEL2_PLL[31:2] for "
-                            "future compatibility\n", __func__);
+            error_report("%s: write 0s in CM_CLKSEL2_PLL[31:2] for "
+                         "future compatibility", __func__);
         if (s->clksel[6] !=3D (value & 3)) {
             s->clksel[6] =3D value & 3;
             omap_prcm_dpll_update(s);
@@ -2486,7 +2487,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sysmem,
=20
     dinfo =3D drive_get(IF_SD, 0, 0);
     if (!dinfo) {
-        fprintf(stderr, "qemu: missing SecureDigital device\n");
+        error_report("qemu: missing SecureDigital device");
         exit(1);
     }
     s->mmc =3D omap2_mmc_init(omap_l4tao(s->l4, 9),
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 9a14270795..6eb56ae744 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -158,7 +158,7 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_size, flash_size / sector_size,
                                    4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory %d.\n",
+            error_report("qemu: Error registering flash memory %d.",
                            fl_idx);
         }
         fl_idx++;
@@ -182,7 +182,7 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_size, flash1_size / sector_size,
                                    4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory %d.\n",
+            error_report("qemu: Error registering flash memory %d.",
                            fl_idx);
         }
         fl_idx++;
@@ -194,7 +194,7 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
     }
=20
     if (!machine->kernel_filename && !fl_idx && !qtest_enabled()) {
-        fprintf(stderr, "Kernel or Flash image must be specified\n");
+        error_report("Kernel or Flash image must be specified");
         exit(1);
     }
=20
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 285f43709d..7f3637041a 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -233,8 +233,8 @@ static void palmte_init(MachineState *machine)
     if (nb_option_roms) {
         rom_size =3D get_image_size(option_rom[0].name);
         if (rom_size > flash_size) {
-            fprintf(stderr, "%s: ROM image too big (%x > %x)\n",
-                            __func__, rom_size, flash_size);
+            error_report("%s: ROM image too big (%x > %x)",
+                         __func__, rom_size, flash_size);
             rom_size =3D 0;
         }
         if (rom_size > 0) {
@@ -243,13 +243,13 @@ static void palmte_init(MachineState *machine)
             rom_loaded =3D 1;
         }
         if (rom_size < 0) {
-            fprintf(stderr, "%s: error loading '%s'\n",
-                            __func__, option_rom[0].name);
+            error_report("%s: error loading '%s'",
+                         __func__, option_rom[0].name);
         }
     }
=20
     if (!rom_loaded && !kernel_filename && !qtest_enabled()) {
-        fprintf(stderr, "Kernel or ROM image must be specified\n");
+        fprintf(stderr, "Kernel or ROM image must be specified");
         exit(1);
     }
=20
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 078006f390..c46b65d5d2 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -2060,7 +2061,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
     s =3D g_new0(PXA2xxState, 1);
=20
     if (strncmp(cpu_type, "pxa27", 5)) {
-        fprintf(stderr, "Machine requires a PXA27x processor.\n");
+        error_report("Machine requires a PXA27x processor.");
         exit(1);
     }
=20
@@ -2093,7 +2094,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
=20
     dinfo =3D drive_get(IF_SD, 0, 0);
     if (!dinfo) {
-        fprintf(stderr, "qemu: missing SecureDigital device\n");
+        error_report("qemu: missing SecureDigital device");
         exit(1);
     }
     s->mmc =3D pxa2xx_mmci_init(address_space, 0x41100000,
@@ -2218,7 +2219,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space,=
 unsigned int sdram_size)
=20
     dinfo =3D drive_get(IF_SD, 0, 0);
     if (!dinfo) {
-        fprintf(stderr, "qemu: missing SecureDigital device\n");
+        error_report("qemu: missing SecureDigital device");
         exit(1);
     }
     s->mmc =3D pxa2xx_mmci_init(address_space, 0x41100000,
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index de7c0fc4a6..f6f295b363 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/ssi/ssi.h"
@@ -559,7 +560,7 @@ static void ssys_write(void *opaque, hwaddr offset,
     case 0x040: /* SRCR0 */
     case 0x044: /* SRCR1 */
     case 0x048: /* SRCR2 */
-        fprintf(stderr, "Peripheral reset not implemented\n");
+        error_report("Peripheral reset not implemented");
         break;
     case 0x054: /* IMC */
         s->int_mask =3D value & 0x7f;
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index a55b1a369c..a069c95f1c 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
@@ -70,19 +71,19 @@ static void tosa_out_switch(void *opaque, int line, int=
 level)
 {
     switch (line) {
         case 0:
-            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
+            error_report("blue LED %s.", level ? "on" : "off");
             break;
         case 1:
-            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
+            error_report("green LED %s.", level ? "on" : "off");
             break;
         case 2:
-            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
+            error_report("amber LED %s.", level ? "on" : "off");
             break;
         case 3:
-            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
+            fprintf(stderr, "wlan LED %s.", level ? "on" : "off");
             break;
         default:
-            fprintf(stderr, "Uhandled out event: %d =3D %d\n", line, level=
);
+            fprintf(stderr, "Uhandled out event: %d =3D %d", line, level);
             break;
     }
 }
@@ -133,7 +134,7 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
=20
 static uint32_t tosa_ssp_tansfer(SSISlave *dev, uint32_t value)
 {
-    fprintf(stderr, "TG: %d %02x\n", value >> 5, value & 0x1f);
+    error_report("TG: %d %02x", value >> 5, value & 0x1f);
     return 0;
 }
=20
@@ -159,13 +160,13 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
     s->buf[s->len] =3D data;
     if (s->len ++ > 2) {
 #ifdef VERBOSE
-        fprintf(stderr, "%s: message too long (%i bytes)\n", __func__, s->=
len);
+        error_report("%s: message too long (%i bytes)", __func__, s->len);
 #endif
         return 1;
     }
=20
     if (s->len =3D=3D 2) {
-        fprintf(stderr, "dac: channel %d value 0x%02x\n",
+        error_report("dac: channel %d value 0x%02x",
                 s->buf[0], s->buf[1]);
     }
=20
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 418792cd02..f0ae069172 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -364,7 +364,7 @@ static void versatile_init(MachineState *machine, int b=
oard_id)
                           VERSATILE_FLASH_SECT_SIZE,
                           VERSATILE_FLASH_SIZE / VERSATILE_FLASH_SECT_SIZE=
,
                           4, 0x0089, 0x0018, 0x0000, 0x0, 0)) {
-        fprintf(stderr, "qemu: Error registering flash memory.\n");
+        error_report("qemu: Error registering flash memory.");
     }
=20
     versatile_binfo.ram_size =3D machine->ram_size;
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index efb5a29475..508629dfe9 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -266,7 +266,7 @@ static void a9_daughterboard_init(const VexpressMachine=
State *vms,
=20
     if (ram_size > 0x40000000) {
         /* 1GB is the maximum the address space permits */
-        fprintf(stderr, "vexpress-a9: cannot model more than 1GB RAM\n");
+        error_report("vexpress-a9: cannot model more than 1GB RAM");
         exit(1);
     }
=20
@@ -355,7 +355,7 @@ static void a15_daughterboard_init(const VexpressMachin=
eState *vms,
          */
         uint64_t rsz =3D ram_size;
         if (rsz > (30ULL * 1024 * 1024 * 1024)) {
-            fprintf(stderr, "vexpress-a15: cannot model more than 30GB RAM=
\n");
+            error_report("vexpress-a15: cannot model more than 30GB RAM");
             exit(1);
         }
     }
@@ -640,7 +640,7 @@ static void vexpress_common_init(MachineState *machine)
     pflash0 =3D ve_pflash_cfi01_register(map[VE_NORFLASH0], "vexpress.flas=
h0",
                                        dinfo);
     if (!pflash0) {
-        fprintf(stderr, "vexpress: error registering flash 0.\n");
+        error_report("vexpress: error registering flash 0.");
         exit(1);
     }
=20
@@ -655,7 +655,7 @@ static void vexpress_common_init(MachineState *machine)
     dinfo =3D drive_get_next(IF_PFLASH);
     if (!ve_pflash_cfi01_register(map[VE_NORFLASH1], "vexpress.flash1",
                                   dinfo)) {
-        fprintf(stderr, "vexpress: error registering flash 1.\n");
+        error_report("vexpress: error registering flash 1.");
         exit(1);
     }
=20
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 60561c7b7c..5048439799 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -319,8 +319,8 @@ static void z2_init(MachineState *machine)
 #endif
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
-        fprintf(stderr, "Flash image must be given with the "
-                "'pflash' parameter\n");
+        error_report("Flash image must be given with the "
+                     "'pflash' parameter");
         exit(1);
     }
=20
@@ -329,7 +329,7 @@ static void z2_init(MachineState *machine)
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, Z2_FLASH_SIZE / sector_len,
                                4, 0, 0, 0, 0, be)) {
-        fprintf(stderr, "qemu: Error registering flash memory.\n");
+        error_report("qemu: Error registering flash memory.");
         exit(1);
     }
=20
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-bl=
k.c
index 5556f0e64e..69dfd49191 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -178,8 +178,8 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     /* Set up guest notifier (irq) */
     r =3D k->set_guest_notifiers(qbus->parent, nvqs, true);
     if (r !=3D 0) {
-        fprintf(stderr, "virtio-blk failed to set guest notifier (%d), "
-                "ensure -enable-kvm is set\n", r);
+        error_report("virtio-blk failed to set guest notifier (%d), "
+                "ensure -enable-kvm is set", r);
         goto fail_guest_notifiers;
     }
=20
@@ -187,7 +187,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     for (i =3D 0; i < nvqs; i++) {
         r =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, true);
         if (r !=3D 0) {
-            fprintf(stderr, "virtio-blk failed to set host notifier (%d)\n=
", r);
+            error_report("virtio-blk failed to set host notifier (%d)", r)=
;
             while (i--) {
                 virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
             }
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 224daf7ccf..8bcd67688b 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -598,7 +598,7 @@ static void onenand_command(OneNANDState *s)
     default:
         s->status |=3D ONEN_ERR_CMD;
         s->intstatus |=3D ONEN_INT;
-        fprintf(stderr, "%s: unknown OneNAND command %x\n",
+        error_report("%s: unknown OneNAND command %x",
                         __func__, s->command);
     }
=20
@@ -665,7 +665,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
         return 0x0000;
     }
=20
-    fprintf(stderr, "%s: unknown OneNAND register %x\n",
+    error_report("%s: unknown OneNAND register %x",
                     __func__, offset);
     return 0;
 }
@@ -710,7 +710,7 @@ static void onenand_write(void *opaque, hwaddr addr,
             break;
=20
         default:
-            fprintf(stderr, "%s: unknown OneNAND boot command %"PRIx64"\n"=
,
+            error_report("%s: unknown OneNAND boot command %"PRIx64"",
                             __func__, value);
         }
         break;
@@ -761,7 +761,7 @@ static void onenand_write(void *opaque, hwaddr addr,
         break;
=20
     default:
-        fprintf(stderr, "%s: unknown OneNAND register %x\n",
+        error_report("%s: unknown OneNAND register %x",
                         __func__, offset);
     }
 }
diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index 1d9f7ee000..d274c9aafe 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -50,8 +50,8 @@ static void init_dev(tc58128_dev * dev, const char *filen=
ame)
 	    dev->flash_contents[1] =3D (blocks >> 8) & 0xff;
 	    dev->flash_contents[2] =3D (blocks >> 16) & 0xff;
 	    dev->flash_contents[3] =3D (blocks >> 24) & 0xff;
-	    fprintf(stderr, "loaded %d bytes for %s into flash\n", ret,
-		    filename);
+        error_report("loaded %d bytes for %s into flash", ret,
+                     filename);
 	}
     }
 }
@@ -60,26 +60,26 @@ static void handle_command(tc58128_dev * dev, uint8_t c=
ommand)
 {
     switch (command) {
     case 0xff:
-	fprintf(stderr, "reset flash device\n");
-	dev->state =3D WAIT;
-	break;
+        error_report("reset flash device");
+        dev->state =3D WAIT;
+        break;
     case 0x00:
-	fprintf(stderr, "read mode 1\n");
-	dev->state =3D READ1;
-	dev->address_cycle =3D 0;
-	break;
+        error_report("read mode 1");
+        dev->state =3D READ1;
+        dev->address_cycle =3D 0;
+        break;
     case 0x01:
-	fprintf(stderr, "read mode 2\n");
-	dev->state =3D READ2;
-	dev->address_cycle =3D 0;
-	break;
+        error_report("read mode 2");
+        dev->state =3D READ2;
+        dev->address_cycle =3D 0;
+        break;
     case 0x50:
-	fprintf(stderr, "read mode 3\n");
-	dev->state =3D READ3;
-	dev->address_cycle =3D 0;
-	break;
+        error_report("read mode 3");
+        dev->state =3D READ3;
+        dev->address_cycle =3D 0;
+        break;
     default:
-	fprintf(stderr, "unknown flash command 0x%02x\n", command);
+        error_report("unknown flash command 0x%02x", command);
         abort();
     }
 }
@@ -103,8 +103,8 @@ static void handle_address(tc58128_dev * dev, uint8_t d=
ata)
 	    break;
 	case 2:
 	    dev->address +=3D data * 528;
-	    fprintf(stderr, "address pointer in flash: 0x%08x\n",
-		    dev->address);
+        error_report("address pointer in flash: 0x%08x",
+                     dev->address);
 	    break;
 	default:
 	    /* Invalid data */
@@ -119,10 +119,6 @@ static void handle_address(tc58128_dev * dev, uint8_t =
data)
=20
 static uint8_t handle_read(tc58128_dev * dev)
 {
-#if 0
-    if (dev->address % 0x100000 =3D=3D 0)
-	fprintf(stderr, "reading flash at address 0x%08x\n", dev->address);
-#endif
     return dev->flash_contents[dev->address++];
 }
=20
diff --git a/hw/bt/core.c b/hw/bt/core.c
index c1806b71a3..a6e9bf2a3e 100644
--- a/hw/bt/core.c
+++ b/hw/bt/core.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
@@ -31,24 +32,24 @@ static void bt_dummy_lmp_mode_change(struct bt_link_s *=
link)
 static void bt_dummy_lmp_connection_complete(struct bt_link_s *link)
 {
     if (link->slave->reject_reason)
-        fprintf(stderr, "%s: stray LMP_not_accepted received, fixme\n",
-                        __func__);
+        error_report("%s: stray LMP_not_accepted received, fixme",
+                     __func__);
     else
-        fprintf(stderr, "%s: stray LMP_accepted received, fixme\n",
-                        __func__);
+        error_report("%s: stray LMP_accepted received, fixme",
+                     __func__);
     exit(-1);
 }
=20
 static void bt_dummy_lmp_disconnect_master(struct bt_link_s *link)
 {
-    fprintf(stderr, "%s: stray LMP_detach received, fixme\n", __func__);
+    fprintf(stderr, "%s: stray LMP_detach received, fixme", __func__);
     exit(-1);
 }
=20
 static void bt_dummy_lmp_acl_resp(struct bt_link_s *link,
                 const uint8_t *data, int start, int len)
 {
-    fprintf(stderr, "%s: stray ACL response PDU, fixme\n", __func__);
+    error_report("%s: stray ACL response PDU, fixme", __func__);
     exit(-1);
 }
=20
@@ -113,7 +114,7 @@ void bt_device_done(struct bt_device_s *dev)
     while (*p && *p !=3D dev)
         p =3D &(*p)->next;
     if (*p !=3D dev) {
-        fprintf(stderr, "%s: bad bt device \"%s\"\n", __func__,
+        error_report("%s: bad bt device \"%s\"", __func__,
                         dev->lmp_name ?: "(null)");
         exit(-1);
     }
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index ac067b81f6..6a171a54b7 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
@@ -111,14 +112,14 @@ static uint8_t *csrhci_out_packet(struct csrhci_s *s,=
 int len)
=20
     if (off < FIFO_LEN) {
         if (off + len > FIFO_LEN && (s->out_size =3D off + len) > FIFO_LEN=
 * 2) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
+            error_report("%s: can't alloc %i bytes", __func__, len);
             exit(-1);
         }
         return s->outfifo + off;
     }
=20
     if (s->out_len > s->out_size) {
-        fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
+        error_report("%s: can't alloc %i bytes", __func__, len);
         exit(-1);
     }
=20
@@ -168,8 +169,8 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s,=
 int ocf,
             s->bd_addr.b[5] =3D data[offset + 2];
=20
             s->hci->bdaddr_set(s->hci, s->bd_addr.b);
-            fprintf(stderr, "%s: bd_address loaded from firmware: "
-                            "%02x:%02x:%02x:%02x:%02x:%02x\n", __func__,
+            error_report("%s: bd_address loaded from firmware: "
+                            "%02x:%02x:%02x:%02x:%02x:%02x", __func__,
                             s->bd_addr.b[0], s->bd_addr.b[1], s->bd_addr.b=
[2],
                             s->bd_addr.b[3], s->bd_addr.b[4], s->bd_addr.b=
[5]);
         }
@@ -181,7 +182,7 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s,=
 int ocf,
         break;
=20
     default:
-        fprintf(stderr, "%s: got a bad CMD packet\n", __func__);
+        error_report("%s: got a bad CMD packet", __func__);
         return;
     }
=20
@@ -226,7 +227,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_=
t *pkt)
     case H4_NEG_PKT:
         if (s->in_hdr !=3D sizeof(csrhci_neg_packet) ||
                         memcmp(pkt - 1, csrhci_neg_packet, s->in_hdr)) {
-            fprintf(stderr, "%s: got a bad NEG packet\n", __func__);
+            error_report("%s: got a bad NEG packet", __func__);
             return;
         }
         pkt +=3D 2;
@@ -241,7 +242,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_=
t *pkt)
=20
     case H4_ALIVE_PKT:
         if (s->in_hdr !=3D 4 || pkt[1] !=3D 0x55 || pkt[2] !=3D 0x00) {
-            fprintf(stderr, "%s: got a bad ALIVE packet\n", __func__);
+            error_report("%s: got a bad ALIVE packet", __func__);
             return;
         }
=20
@@ -254,7 +255,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_=
t *pkt)
     default:
     bad_pkt:
         /* TODO: error out */
-        fprintf(stderr, "%s: got a bad packet\n", __func__);
+        error_report("%s: got a bad packet", __func__);
         break;
     }
=20
diff --git a/hw/bt/hci.c b/hw/bt/hci.c
index df05f07887..ac9394daf0 100644
--- a/hw/bt/hci.c
+++ b/hw/bt/hci.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
@@ -457,7 +458,7 @@ static inline uint8_t *bt_hci_event_start(struct bt_hci=
_s *hci,
     int mask_byte;
=20
     if (len > 255) {
-        fprintf(stderr, "%s: HCI event params too long (%ib)\n",
+        error_report("%s: HCI event params too long (%ib)",
                         __func__, len);
         exit(-1);
     }
@@ -589,7 +590,7 @@ static void bt_hci_inquiry_result(struct bt_hci_s *hci,
         bt_hci_inquiry_result_with_rssi(hci, slave);
         return;
     default:
-        fprintf(stderr, "%s: bad inquiry mode %02x\n", __func__,
+        error_report("%s: bad inquiry mode %02x", __func__,
                         hci->lm.inquiry_mode);
         exit(-1);
     }
@@ -1971,7 +1972,7 @@ static void bt_submit_hci(struct HCIInfo *info,
         break;
=20
     short_hci:
-        fprintf(stderr, "%s: HCI packet too short (%iB)\n",
+        error_report("%s: HCI packet too short (%iB)",
                         __func__, length);
         bt_hci_event_status(hci, HCI_INVALID_PARAMETERS);
         break;
@@ -1991,7 +1992,7 @@ static inline void bt_hci_lmp_acl_data(struct bt_hci_=
s *hci, uint16_t handle,
     /* TODO: avoid memcpy'ing */
=20
     if (len + HCI_ACL_HDR_SIZE > sizeof(hci->acl_buf)) {
-        fprintf(stderr, "%s: can't take ACL packets %i bytes long\n",
+        error_report("%s: can't take ACL packets %i bytes long",
                         __func__, len);
         return;
     }
@@ -2029,7 +2030,7 @@ static void bt_submit_acl(struct HCIInfo *info,
     struct bt_link_s *link;
=20
     if (length < HCI_ACL_HDR_SIZE) {
-        fprintf(stderr, "%s: ACL packet too short (%iB)\n",
+        error_report("%s: ACL packet too short (%iB)",
                         __func__, length);
         return;
     }
@@ -2041,15 +2042,15 @@ static void bt_submit_acl(struct HCIInfo *info,
     length -=3D HCI_ACL_HDR_SIZE;
=20
     if (bt_hci_handle_bad(hci, handle)) {
-        fprintf(stderr, "%s: invalid ACL handle %03x\n",
-                        __func__, handle);
+        error_report("%s: invalid ACL handle %03x",
+                     __func__, handle);
         /* TODO: signal an error */
         return;
     }
     handle &=3D ~HCI_HANDLE_OFFSET;
=20
     if (datalen > length) {
-        fprintf(stderr, "%s: ACL packet too short (%iB < %iB)\n",
+        fprintf(stderr, "%s: ACL packet too short (%iB < %iB)",
                         __func__, length, datalen);
         return;
     }
@@ -2060,7 +2061,7 @@ static void bt_submit_acl(struct HCIInfo *info,
         if (!hci->asb_handle)
             hci->asb_handle =3D handle;
         else if (handle !=3D hci->asb_handle) {
-            fprintf(stderr, "%s: Bad handle %03x in Active Slave Broadcast=
\n",
+            error_report("%s: Bad handle %03x in Active Slave Broadcast",
                             __func__, handle);
             /* TODO: signal an error */
             return;
@@ -2073,7 +2074,7 @@ static void bt_submit_acl(struct HCIInfo *info,
         if (!hci->psb_handle)
             hci->psb_handle =3D handle;
         else if (handle !=3D hci->psb_handle) {
-            fprintf(stderr, "%s: Bad handle %03x in Parked Slave Broadcast=
\n",
+            error_report("%s: Bad handle %03x in Parked Slave Broadcast",
                             __func__, handle);
             /* TODO: signal an error */
             return;
@@ -2105,14 +2106,13 @@ static void bt_submit_sco(struct HCIInfo *info,
     length -=3D 3;
=20
     if (bt_hci_handle_bad(hci, handle)) {
-        fprintf(stderr, "%s: invalid SCO handle %03x\n",
-                        __func__, handle);
+        error_report("%s: invalid SCO handle %03x", __func__, handle);
         return;
     }
=20
     if (datalen > length) {
-        fprintf(stderr, "%s: SCO packet too short (%iB < %iB)\n",
-                        __func__, length, datalen);
+        error_report("%s: SCO packet too short (%iB < %iB)",
+                     __func__, length, datalen);
         return;
     }
=20
@@ -2223,7 +2223,7 @@ struct HCIInfo *hci_init(const char *str)
            return bt_new_hci(vlan);
     }
=20
-    fprintf(stderr, "qemu: Unknown bluetooth HCI `%s'.\n", str);
+    error_report("qemu: Unknown bluetooth HCI `%s'.", str);
=20
     return 0;
 }
diff --git a/hw/bt/hid.c b/hw/bt/hid.c
index 09d17322e4..056291f9b5 100644
--- a/hw/bt/hid.c
+++ b/hw/bt/hid.c
@@ -419,7 +419,7 @@ static void bt_hid_interrupt_sdu(void *opaque, const ui=
nt8_t *data, int len)
=20
     return;
 bad:
-    fprintf(stderr, "%s: bad transaction on Interrupt channel.\n",
+    error_report("%s: bad transaction on Interrupt channel.",
                     __func__);
 }
=20
diff --git a/hw/bt/l2cap.c b/hw/bt/l2cap.c
index 3e53dd082d..9cf27f0df6 100644
--- a/hw/bt/l2cap.c
+++ b/hw/bt/l2cap.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
@@ -467,8 +468,8 @@ static void l2cap_channel_close(struct l2cap_instance_s=
 *l2cap,
=20
     if (likely(ch)) {
         if (ch->remote_cid !=3D source_cid) {
-            fprintf(stderr, "%s: Ignoring a Disconnection Request with the=
 "
-                            "invalid SCID %04x.\n", __func__, source_cid);
+            error_report("%s: Ignoring a Disconnection Request with the "
+                            "invalid SCID %04x.", __func__, source_cid);
             return;
         }
=20
@@ -790,7 +791,7 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
 #if 0
     /* TODO: do the IDs really have to be in sequence?  */
     if (!id || (id !=3D l2cap->last_id && id !=3D l2cap->next_id)) {
-        fprintf(stderr, "%s: out of sequence command packet ignored.\n",
+        error_report("%s: out of sequence command packet ignored.",
                         __func__);
         return;
     }
@@ -813,9 +814,9 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
         }
=20
         /* We never issue commands other than Command Reject currently.  *=
/
-        fprintf(stderr, "%s: stray Command Reject (%02x, %04x) "
-                        "packet, ignoring.\n", __func__, id,
-                        le16_to_cpu(((l2cap_cmd_rej *) params)->reason));
+        error_report("%s: stray Command Reject (%02x, %04x) "
+                     "packet, ignoring.", __func__, id,
+                     le16_to_cpu(((l2cap_cmd_rej *) params)->reason));
         break;
=20
     case L2CAP_CONN_REQ:
@@ -836,8 +837,8 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
         }
=20
         /* We never issue Connection Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Connection Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Connection Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
=20
     case L2CAP_CONF_REQ:
@@ -865,8 +866,8 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
                         le16_to_cpu(((l2cap_conf_rsp *) params)->scid),
                         ((l2cap_conf_rsp *) params)->data,
                         len - L2CAP_CONF_RSP_SIZE(0)))
-            fprintf(stderr, "%s: unexpected Configure Response (%02x) "
-                            "packet, ignoring.\n", __func__, id);
+            error_report("%s: unexpected Configure Response (%02x) "
+                         "packet, ignoring.", __func__, id);
         break;
=20
     case L2CAP_DISCONN_REQ:
@@ -887,8 +888,8 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
         }
=20
         /* We never issue Disconnection Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Disconnection Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Disconnection Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
=20
     case L2CAP_ECHO_REQ:
@@ -897,8 +898,8 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
=20
     case L2CAP_ECHO_RSP:
         /* We never issue Echo Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Echo Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Echo Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
=20
     case L2CAP_INFO_REQ:
@@ -917,8 +918,8 @@ static void l2cap_command(struct l2cap_instance_s *l2ca=
p, int code, int id,
         }
=20
         /* We never issue Information Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Information Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Information Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
=20
     default:
@@ -1066,8 +1067,8 @@ static void l2cap_frame_in(struct l2cap_instance_s *l=
2cap,
     uint16_t len =3D le16_to_cpu(frame->len);
=20
     if (unlikely(cid >=3D L2CAP_CID_MAX || !l2cap->cid[cid])) {
-        fprintf(stderr, "%s: frame addressed to a non-existent L2CAP "
-                        "channel %04x received.\n", __func__, cid);
+        error_report("%s: frame addressed to a non-existent L2CAP "
+                     "channel %04x received.", __func__, cid);
         return;
     }
=20
@@ -1128,9 +1129,9 @@ static uint8_t *l2cap_bframe_out(struct bt_l2cap_conn=
_params_s *parm, int len)
     struct l2cap_chan_s *chan =3D (struct l2cap_chan_s *) parm;
=20
     if (len > chan->params.remote_mtu) {
-        fprintf(stderr, "%s: B-Frame for CID %04x longer than %i octets.\n=
",
-                        __func__,
-                        chan->remote_cid, chan->params.remote_mtu);
+        error_report("%s: B-Frame for CID %04x longer than %i octets.",
+                     __func__,
+                     chan->remote_cid, chan->params.remote_mtu);
         exit(-1);
     }
=20
@@ -1353,8 +1354,8 @@ void bt_l2cap_psm_register(struct bt_l2cap_device_s *=
dev, int psm, int min_mtu,
     struct bt_l2cap_psm_s *new_psm =3D l2cap_psm(dev, psm);
=20
     if (new_psm) {
-        fprintf(stderr, "%s: PSM %04x already registered for device `%s'.\=
n",
-                        __func__, psm, dev->device.lmp_name);
+        error_report("%s: PSM %04x already registered for device `%s'.",
+                     __func__, psm, dev->device.lmp_name);
         exit(-1);
     }
=20
diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index 7c0d38b504..f4aba9d74f 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "hw/bt.h"
@@ -506,7 +507,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uin=
t8_t *data, int len)
     int rsp_len =3D 0;
=20
     if (len < 5) {
-        fprintf(stderr, "%s: short SDP PDU (%iB).\n", __func__, len);
+        error_report("%s: short SDP PDU (%iB).", __func__, len);
         return;
     }
=20
@@ -517,7 +518,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uin=
t8_t *data, int len)
     len -=3D 5;
=20
     if (len !=3D plen) {
-        fprintf(stderr, "%s: wrong SDP PDU length (%iB !=3D %iB).\n",
+        error_report("%s: wrong SDP PDU length (%iB !=3D %iB).",
                         __func__, plen, len);
         err =3D SDP_INVALID_PDU_SIZE;
         goto respond;
@@ -544,7 +545,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uin=
t8_t *data, int len)
     case SDP_SVC_SEARCH_RSP:
     case SDP_SVC_SEARCH_ATTR_RSP:
     default:
-        fprintf(stderr, "%s: unexpected SDP PDU ID %02x.\n",
+        error_report("%s: unexpected SDP PDU ID %02x.",
                         __func__, pdu_id);
         err =3D SDP_INVALID_SYNTAX;
         break;
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 3957e78abf..a388f01a23 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -296,7 +296,7 @@ static void exynos4210_uart_update_irq(Exynos4210UartSt=
ate *s)
         qemu_irq_raise(s->irq);
=20
 #if DEBUG_IRQ
-        fprintf(stderr, "UART%d: IRQ has been raised: %08x\n",
+        error_report("UART%d: IRQ has been raised: %08x",
                 s->channel, s->reg[I_(UINTP)]);
 #endif
=20
@@ -388,7 +388,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr =
offset,
              * qemu_chr_fe_write and background I/O callbacks */
             qemu_chr_fe_write_all(&s->chr, &ch, 1);
 #if DEBUG_Tx_DATA
-            fprintf(stderr, "%c", ch);
+            error_report("%c", ch);
 #endif
             s->reg[I_(UTRSTAT)] |=3D UTRSTAT_TRANSMITTER_EMPTY |
                     UTRSTAT_Tx_BUFFER_EMPTY;
@@ -400,7 +400,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr =
offset,
     case UINTP:
         s->reg[I_(UINTP)] &=3D ~val;
         s->reg[I_(UINTSP)] &=3D ~val;
-        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x\n",
+        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x",
                     s->channel, offset, s->reg[I_(UINTP)]);
         exynos4210_uart_update_irq(s);
         break;
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 56fa402b58..14cb051be9 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
@@ -174,7 +175,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t c=
md)
         mcf_uart_do_tx(s);
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad TX command\n");
+        error_report("mcf_uart: Bad TX command");
         break;
     }
=20
@@ -189,7 +190,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t c=
md)
         s->rx_enabled =3D 0;
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad RX command\n");
+        error_report("mcf_uart: Bad RX command");
         break;
     }
 }
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 835b5378a0..7bb3f3c70b 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
@@ -190,8 +191,8 @@ static void sh_serial_write(void *opaque, hwaddr offs,
         }
     }
=20
-    fprintf(stderr, "sh_serial: unsupported write to 0x%02"
-            HWADDR_PRIx "\n", offs);
+    error_report("sh_serial: unsupported write to 0x%02"
+                 HWADDR_PRIx "", offs);
     abort();
 }
=20
@@ -290,8 +291,8 @@ static uint64_t sh_serial_read(void *opaque, hwaddr off=
s,
 #endif
=20
     if (ret & ~((1 << 16) - 1)) {
-        fprintf(stderr, "sh_serial: unsupported read from 0x%02"
-                HWADDR_PRIx "\n", offs);
+        error_report("sh_serial: unsupported read from 0x%02"
+                     HWADDR_PRIx "", offs);
         abort();
     }
=20
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4593061445..95bdcbbe36 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -43,6 +43,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
@@ -82,7 +83,7 @@ int load_image(const char *filename, uint8_t *addr)
         return -1;
     size =3D lseek(fd, 0, SEEK_END);
     if (size =3D=3D -1) {
-        fprintf(stderr, "file %-20s: get size error: %s\n",
+        error_report("file %-20s: get size error: %s",
                 filename, strerror(errno));
         close(fd);
         return -1;
@@ -623,7 +624,7 @@ static int load_uboot_image(const char *filename, hwadd=
r *ep, hwaddr *loadaddr,
         goto out;
=20
     if (hdr->ih_type !=3D image_type) {
-        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type=
,
+        error_report("Wrong image type %d, expected %d", hdr->ih_type,
                 image_type);
         goto out;
     }
@@ -670,14 +671,14 @@ static int load_uboot_image(const char *filename, hwa=
ddr *ep, hwaddr *loadaddr,
         address =3D *loadaddr;
         break;
     default:
-        fprintf(stderr, "Unsupported u-boot image type %d\n", hdr->ih_type=
);
+        error_report("Unsupported u-boot image type %d", hdr->ih_type);
         goto out;
     }
=20
     data =3D g_malloc(hdr->ih_size);
=20
     if (read(fd, data, hdr->ih_size) !=3D hdr->ih_size) {
-        fprintf(stderr, "Error reading file\n");
+        error_report("Error reading file");
         goto out;
     }
=20
@@ -693,7 +694,7 @@ static int load_uboot_image(const char *filename, hwadd=
r *ep, hwaddr *loadaddr,
         bytes =3D gunzip(data, max_bytes, compressed_data, hdr->ih_size);
         g_free(compressed_data);
         if (bytes < 0) {
-            fprintf(stderr, "Unable to decompress gzipped image!\n");
+            error_report("Unable to decompress gzipped image!");
             goto out;
         }
         hdr->ih_size =3D bytes;
@@ -763,7 +764,7 @@ int load_image_gzipped_buffer(const char *filename, uin=
t64_t max_sz,
     data =3D g_malloc(max_sz);
     bytes =3D gunzip(data, max_sz, compressed_data, len);
     if (bytes < 0) {
-        fprintf(stderr, "%s: unable to decompress gzipped kernel file\n",
+        error_report("%s: unable to decompress gzipped kernel file",
                 filename);
         goto out;
     }
@@ -893,8 +894,8 @@ int rom_add_file(const char *file, const char *fw_dir,
     char devpath[100];
=20
     if (as && mr) {
-        fprintf(stderr, "Specifying an Address Space and Memory Region is =
" \
-                "not valid when loading a rom\n");
+        error_report("Specifying an Address Space and Memory Region is " \
+                     "not valid when loading a rom");
         /* We haven't allocated anything so we don't need any cleanup */
         return -1;
     }
@@ -909,7 +910,7 @@ int rom_add_file(const char *file, const char *fw_dir,
=20
     fd =3D open(rom->path, O_RDONLY | O_BINARY);
     if (fd =3D=3D -1) {
-        fprintf(stderr, "Could not open option rom '%s': %s\n",
+        error_report("Could not open option rom '%s': %s",
                 rom->path, strerror(errno));
         goto err;
     }
@@ -921,7 +922,7 @@ int rom_add_file(const char *file, const char *fw_dir,
     rom->addr     =3D addr;
     rom->romsize  =3D lseek(fd, 0, SEEK_END);
     if (rom->romsize =3D=3D -1) {
-        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
+        error_report("rom: file %-20s: get size error: %s",
                 rom->name, strerror(errno));
         goto err;
     }
@@ -931,7 +932,7 @@ int rom_add_file(const char *file, const char *fw_dir,
     lseek(fd, 0, SEEK_SET);
     rc =3D read(fd, rom->data, rom->datasize);
     if (rc !=3D rom->datasize) {
-        fprintf(stderr, "rom: file %-20s: read error: rc=3D%d (expected %z=
d)\n",
+        error_report("rom: file %-20s: read error: rc=3D%d (expected %zd)"=
,
                 rom->name, rc, rom->datasize);
         goto err;
     }
@@ -1105,10 +1106,10 @@ int rom_check_and_register_reset(void)
             continue;
         }
         if ((addr > rom->addr) && (as =3D=3D rom->as)) {
-            fprintf(stderr, "rom: requested regions overlap "
-                    "(rom %s. free=3D0x" TARGET_FMT_plx
-                    ", addr=3D0x" TARGET_FMT_plx ")\n",
-                    rom->name, addr, rom->addr);
+            error_report("rom: requested regions overlap "
+                         "(rom %s. free=3D0x" TARGET_FMT_plx
+                         ", addr=3D0x" TARGET_FMT_plx ")",
+                         rom->name, addr, rom->addr);
             return -1;
         }
         addr  =3D rom->addr;
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7221c68a98..514e177de2 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GNU LGPL.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
@@ -56,7 +57,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adju=
st)
=20
     if (s->period =3D=3D 0) {
         if (!qtest_enabled()) {
-            fprintf(stderr, "Timer with period zero, disabling\n");
+            error_report("Timer with period zero, disabling");
         }
         timer_del(s->timer);
         s->enabled =3D 0;
@@ -89,7 +90,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adju=
st)
=20
     if (delta =3D=3D 0) {
         if (!qtest_enabled()) {
-            fprintf(stderr, "Timer with delta zero, disabling\n");
+            error_report("Timer with delta zero, disabling");
         }
         timer_del(s->timer);
         s->enabled =3D 0;
@@ -263,7 +264,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
=20
     if (was_disabled && s->period =3D=3D 0) {
         if (!qtest_enabled()) {
-            fprintf(stderr, "Timer with period zero, disabling\n");
+            error_report("Timer with period zero, disabling");
         }
         return;
     }
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 5eb552bce2..d121836b69 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -349,7 +350,7 @@ void axisdev88_init(MachineState *machine)
         li.cmdline =3D kernel_cmdline;
         cris_load_image(cpu, &li);
     } else if (!qtest_enabled()) {
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
 }
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index f896ed7f86..f199a13a82 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -86,14 +87,14 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_inf=
o *li)
     }
=20
     if (image_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
+        error_report("qemu: could not load kernel '%s'",
                 li->image_filename);
         exit(1);
     }
=20
     if (li->cmdline && (kcmdline_len =3D strlen(li->cmdline))) {
         if (kcmdline_len > 256) {
-            fprintf(stderr, "Too long CRIS kernel cmdline (max 256)\n");
+            error_report("Too long CRIS kernel cmdline (max 256)");
             exit(1);
         }
         pstrcpy_targphys("cmdline", 0x40000000, 256, li->cmdline);
diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 291abe6fca..0d12e078c4 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -474,7 +474,7 @@ static uint16_t blizzard_reg_read(void *opaque, uint8_t=
 reg)
         return s->gpio_pdown;
=20
     default:
-        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
+        error_report("%s: unknown register %02x", __func__, reg);
         return 0;
     }
 }
@@ -501,7 +501,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
     case 0x0c:	/* PLL Mode Control 0 */
         s->pll_mode =3D value & 0x77;
         if ((value & 3) =3D=3D 0 || (value & 3) =3D=3D 3)
-            fprintf(stderr, "%s: wrong PLL Control bits (%i)\n",
+            error_report("%s: wrong PLL Control bits (%i)",
                     __func__, value & 3);
         break;
=20
@@ -541,7 +541,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
     case 0x28:	/* LCD Panel Configuration */
         s->lcd_config =3D value & 0xff;
         if (value & (1 << 7))
-            fprintf(stderr, "%s: data swap not supported!\n", __func__);
+            error_report("%s: data swap not supported!", __func__);
         break;
=20
     case 0x2a:	/* LCD Horizontal Display Width */
@@ -585,7 +585,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
     case 0x40:	/* High-speed Serial Interface Tx Configuration Port 1 */
         s->hssi_config[1] =3D value;
         if (((value >> 4) & 3) =3D=3D 3)
-            fprintf(stderr, "%s: Illegal active-data-links value\n",
+            error_report("%s: Illegal active-data-links value",
                             __func__);
         break;
     case 0x42:	/* High-speed Serial Interface Tx Mode */
@@ -641,7 +641,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
         s->enable =3D value & 1;
         s->blank =3D (value >> 1) & 1;
         if (value & (1 << 4))
-            fprintf(stderr, "%s: Macrovision enable attempt!\n", __func__)=
;
+            error_report("%s: Macrovision enable attempt!", __func__);
         break;
=20
     case 0x6a:	/* Special Effects */
@@ -717,7 +717,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
         s->iformat =3D value & 0xf;
         s->bpp =3D blizzard_iformat_bpp[s->iformat];
         if (!s->bpp)
-            fprintf(stderr, "%s: Illegal or unsupported input format %x\n"=
,
+            error_report("%s: Illegal or unsupported input format %x",
                             __func__, s->iformat);
         break;
     case 0x8e:	/* Data Source Select */
@@ -729,7 +729,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
                                         s->iy[1] !=3D s->oy[1])) ||
                         !((s->ix[1] - s->ix[0]) & (s->iy[1] - s->iy[0]) &
                           (s->ox[1] - s->ox[0]) & (s->oy[1] - s->oy[0]) & =
1))
-            fprintf(stderr, "%s: Illegal input/output window positions\n",
+            error_report("%s: Illegal input/output window positions",
                             __func__);
=20
         blizzard_transfer_setup(s);
@@ -783,8 +783,8 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
     case 0xe6:	/* Power-save */
         s->pm =3D value & 0x83;
         if (value & s->mode & 1)
-            fprintf(stderr, "%s: The display must be disabled before enter=
ing "
-                            "Standby Mode\n", __func__);
+            error_report("%s: The display must be disabled before entering=
 "
+                         "Standby Mode", __func__);
         break;
     case 0xe8:	/* Non-display Period Control / Status */
         s->status =3D value & 0x1b;
@@ -815,7 +815,7 @@ static void blizzard_reg_write(void *opaque, uint8_t re=
g, uint16_t value)
         break;
=20
     default:
-        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
+        error_report("%s: unknown register %02x", __func__, reg);
         break;
     }
 }
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 601f178fdd..52d6e753d3 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -406,10 +406,10 @@ static void omap_disc_write(void *opaque, hwaddr addr=
,
         s->lcd.enable =3D (value >> 0) & 1;
         if (value & (1 << 12))			/* OVERLAY_OPTIMIZATION */
             if (!((s->dispc.l[1].attr | s->dispc.l[2].attr) & 1)) {
-                fprintf(stderr, "%s: Overlay Optimization when no overlay =
"
-                        "region effectively exists leads to "
-                        "unpredictable behaviour!\n", __func__);
-            }
+                error_report("%s: Overlay Optimization when no overlay "
+                             "region effectively exists leads to "
+                             "unpredictable behaviour!", __func__);
+           }
         if (value & (1 << 6)) {				/* GODIGITAL */
             /* XXX: Shadowed fields are:
              * s->dispc.config
@@ -525,8 +525,8 @@ static void omap_disc_write(void *opaque, hwaddr addr,
     case 0x0a0:	/* DISPC_GFX_ATTRIBUTES */
         s->dispc.l[0].attr =3D value & 0x7ff;
         if (value & (3 << 9))
-            fprintf(stderr, "%s: Big-endian pixel format not supported\n",
-                            __func__);
+            error_report("%s: Big-endian pixel format not supported",
+                         __func__);
         s->dispc.l[0].enable =3D value & 1;
         s->dispc.l[0].bpp =3D (value >> 1) & 0xf;
         s->dispc.invalidate =3D 1;
@@ -617,7 +617,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s =
*s)
     if (s->rfbi.control & (1 << 1)) {				/* BYPASS */
         /* TODO: in non-Bypass mode we probably need to just assert the
          * DRQ and wait for DMA to write the pixels.  */
-        fprintf(stderr, "%s: Bypass mode unimplemented\n", __func__);
+        error_report("%s: Bypass mode unimplemented", __func__);
         return;
     }
=20
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 8c7dcc6f0a..b8b7903d36 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -174,7 +174,7 @@ static void pl110_update_display(void *opaque)
         dest_width =3D 4;
         break;
     default:
-        fprintf(stderr, "pl110: Bad color depth\n");
+        error_report("pl110: Bad color depth");
         exit(1);
     }
     if (s->cr & PL110_CR_BGR)
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index b83f80753a..ae3a365849 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -1050,7 +1050,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem=
,
         s->dest_width =3D 4;
         break;
     default:
-        fprintf(stderr, "%s: Bad color depth\n", __func__);
+        error_report("%s: Bad color depth", __func__);
         exit(1);
     }
=20
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8789..0cd07028a4 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -78,7 +78,7 @@ void qxl_render_resize(PCIQXLDevice *qxl)
         qxl->guest_primary.bits_pp =3D 32;
         break;
     default:
-        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
+        error_report("%s: unhandled format: %x", __func__,
                 qxl->guest_primary.surface.format);
         qxl->guest_primary.bytes_pp =3D 4;
         qxl->guest_primary.bits_pp =3D 32;
@@ -247,7 +247,7 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCur=
sor *cursor,
         }
         break;
     default:
-        fprintf(stderr, "%s: not implemented: type %d\n",
+        error_report("%s: not implemented: type %d",
                 __func__, cursor->header.type);
         goto fail;
     }
@@ -275,9 +275,8 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt =
*ext)
     }
=20
     if (qxl->debug > 1 && cmd->type !=3D QXL_CURSOR_MOVE) {
-        fprintf(stderr, "%s", __func__);
+        error_report("%s", __func__);
         qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
-        fprintf(stderr, "\n");
     }
     switch (cmd->type) {
     case QXL_CURSOR_SET:
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ae3677fd1e..0163a18bbb 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -875,7 +875,7 @@ static void interface_notify_update(QXLInstance *sin, u=
int32_t update_id)
      * Probably was at some earlier version that is prior to git start (20=
09),
      * and is still guest trigerrable.
      */
-    fprintf(stderr, "%s: deprecated\n", __func__);
+    error_report("%s: deprecated", __func__);
 }
=20
 /* called from spice server thread context only */
@@ -905,7 +905,7 @@ static void interface_async_complete_io(PCIQXLDevice *q=
xl, QXLCookie *cookie)
=20
     trace_qxl_interface_async_complete_io(qxl->id, current_async, cookie);
     if (!cookie) {
-        fprintf(stderr, "qxl: %s: error, cookie is NULL\n", __func__);
+        error_report("qxl: %s: error, cookie is NULL", __func__);
         return;
     }
     if (cookie && current_async !=3D cookie->io) {
@@ -930,7 +930,7 @@ static void interface_async_complete_io(PCIQXLDevice *q=
xl, QXLCookie *cookie)
         qxl_spice_destroy_surface_wait_complete(qxl, cookie->u.surface_id)=
;
         break;
     default:
-        fprintf(stderr, "qxl: %s: unexpected current_async %d\n", __func__=
,
+        error_report("qxl: %s: unexpected current_async %d", __func__,
                 current_async);
     }
     qxl_send_events(qxl, QXL_INTERRUPT_IO_CMD);
@@ -998,7 +998,7 @@ static void interface_async_complete(QXLInstance *sin, =
uint64_t cookie_token)
     case QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG:
         break;
     default:
-        fprintf(stderr, "qxl: %s: unexpected cookie type %d\n",
+        error_report("qxl: %s: unexpected cookie type %d",
                 __func__, cookie->type);
         g_free(cookie);
     }
@@ -1875,7 +1875,7 @@ static void qxl_send_events(PCIQXLDevice *d, uint32_t=
 events)
     trace_qxl_send_events(d->id, events);
     if (!qemu_spice_display_is_running(&d->ssd)) {
         /* spice-server tracks guest running state and should not do this =
*/
-        fprintf(stderr, "%s: spice-server bug: guest stopped, ignoring\n",
+        error_report("%s: spice-server bug: guest stopped, ignoring",
                 __func__);
         trace_qxl_send_events_vm_stopped(d->id, events);
         return;
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 79f161740a..8b708a858b 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -159,7 +159,7 @@ void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
                     qemu_irq handler)
 {
     if (line >=3D TC6393XB_GPIOS) {
-        fprintf(stderr, "TC6393xb: no GPIO pin %d\n", line);
+        error_report("TC6393xb: no GPIO pin %d", line);
         return;
     }
=20
@@ -190,7 +190,7 @@ static void tc6393xb_l3v(void *opaque, int line, int le=
vel)
 {
     TC6393xbState *s =3D opaque;
     s->blank =3D !level;
-    fprintf(stderr, "L3V: %d\n", level);
+    error_report("L3V: %d", level);
 }
=20
 static void tc6393xb_sub_irq(void *opaque, int line, int level) {
@@ -257,7 +257,7 @@ static uint32_t tc6393xb_scr_readb(TC6393xbState *s, hw=
addr addr)
         SCR_REG_B(CONFIG);
         SCR_REG_B(DEBUG);
     }
-    fprintf(stderr, "tc6393xb_scr: unhandled read at %08x\n", (uint32_t) a=
ddr);
+    error_report("tc6393xb_scr: unhandled read at %08x", (uint32_t) addr);
     return 0;
 }
 #undef SCR_REG_B
@@ -318,8 +318,8 @@ static void tc6393xb_scr_writeb(TC6393xbState *s, hwadd=
r addr, uint32_t value)
         SCR_REG_B(CONFIG);
         SCR_REG_B(DEBUG);
     }
-    fprintf(stderr, "tc6393xb_scr: unhandled write at %08x: %02x\n",
-					(uint32_t) addr, value & 0xff);
+    error_report("tc6393xb_scr: unhandled write at %08x: %02x",
+                 (uint32_t) addr, value & 0xff);
 }
 #undef SCR_REG_B
 #undef SCR_REG_W
@@ -341,7 +341,7 @@ static uint32_t tc6393xb_nand_cfg_readb(TC6393xbState *=
s, hwaddr addr) {
         case NAND_CFG_BASE + 3:
             return s->nand_phys >> (addr - NAND_CFG_BASE);
     }
-    fprintf(stderr, "tc6393xb_nand_cfg: unhandled read at %08x\n", (uint32=
_t) addr);
+    error_report("tc6393xb_nand_cfg: unhandled read at %08x", (uint32_t) a=
ddr);
     return 0;
 }
 static void tc6393xb_nand_cfg_writeb(TC6393xbState *s, hwaddr addr, uint32=
_t value) {
@@ -357,7 +357,7 @@ static void tc6393xb_nand_cfg_writeb(TC6393xbState *s, =
hwaddr addr, uint32_t val
             s->nand_phys |=3D (value & 0xff) << ((addr - NAND_CFG_BASE) * =
8);
             return;
     }
-    fprintf(stderr, "tc6393xb_nand_cfg: unhandled write at %08x: %02x\n",
+    error_report("tc6393xb_nand_cfg: unhandled write at %08x: %02x",
 					(uint32_t) addr, value & 0xff);
 }
=20
@@ -377,12 +377,14 @@ static uint32_t tc6393xb_nand_readb(TC6393xbState *s,=
 hwaddr addr) {
         case NAND_IMR:
             return s->nand.imr;
     }
-    fprintf(stderr, "tc6393xb_nand: unhandled read at %08x\n", (uint32_t) =
addr);
+    error_report("tc6393xb_nand: unhandled read at %08x", (uint32_t) addr)=
;
     return 0;
 }
-static void tc6393xb_nand_writeb(TC6393xbState *s, hwaddr addr, uint32_t v=
alue) {
-//    fprintf(stderr, "tc6393xb_nand: write at %08x: %02x\n",
-//					(uint32_t) addr, value & 0xff);
+static void tc6393xb_nand_writeb(TC6393xbState *s, hwaddr addr, uint32_t v=
alue)
+{
+    /* error_report("tc6393xb_nand: write at %08x: %02x",
+     *              (uint32_t) addr, value & 0xff);
+     */
     switch (addr) {
         case NAND_DATA + 0:
         case NAND_DATA + 1:
@@ -420,7 +422,7 @@ static void tc6393xb_nand_writeb(TC6393xbState *s, hwad=
dr addr, uint32_t value)
             tc6393xb_nand_irq(s);
             return;
     }
-    fprintf(stderr, "tc6393xb_nand: unhandled write at %08x: %02x\n",
+    error_report("tc6393xb_nand: unhandled write at %08x: %02x",
 					(uint32_t) addr, value & 0xff);
 }
=20
@@ -522,13 +524,15 @@ static uint64_t tc6393xb_readb(void *opaque, hwaddr a=
ddr,
     };
=20
     if ((addr &~0xff) =3D=3D s->nand_phys && s->nand_enable) {
-//        return tc6393xb_nand_readb(s, addr & 0xff);
+        /* return tc6393xb_nand_readb(s, addr & 0xff); */
         uint8_t d =3D tc6393xb_nand_readb(s, addr & 0xff);
-//        fprintf(stderr, "tc6393xb_nand: read at %08x: %02hhx\n", (uint32=
_t) addr, d);
+        /* error_report("tc6393xb_nand: read at %08x: %02hhx",
+         *              (uint32_t) addr, d);
+         */
         return d;
     }
=20
-//    fprintf(stderr, "tc6393xb: unhandled read at %08x\n", (uint32_t) add=
r);
+    /* error_report("tc6393xb: unhandled read at %08x", (uint32_t) addr); =
*/
     return 0;
 }
=20
@@ -548,7 +552,7 @@ static void tc6393xb_writeb(void *opaque, hwaddr addr,
     if ((addr &~0xff) =3D=3D s->nand_phys && s->nand_enable)
         tc6393xb_nand_writeb(s, addr & 0xff, value);
     else
-        fprintf(stderr, "tc6393xb: unhandled write at %08x: %02x\n",
+        error_report("tc6393xb: unhandled write at %08x: %02x",
                 (uint32_t) addr, (int)value & 0xff);
 }
=20
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 8c106a662d..88bc1c84a6 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -473,7 +473,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         return;
     }
     if (cmd->error) {
-        fprintf(stderr, "%s: ctrl 0x%x, error 0x%x\n", __func__,
+        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
                 cmd->cmd_hdr.type, cmd->error);
         virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
         return;
@@ -556,7 +556,7 @@ static void virtio_gpu_print_stats(void *opaque)
     VirtIOGPU *g =3D opaque;
=20
     if (g->stats.requests) {
-        fprintf(stderr, "stats: vq req %4d, %3d -- 3D %4d (%5d)\n",
+        error_report("stats: vq req %4d, %3d -- 3D %4d (%5d)",
                 g->stats.requests,
                 g->stats.max_inflight,
                 g->stats.req_3d,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 4a64b41259..44d425e1f6 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -293,45 +293,45 @@ static inline bool vmsvga_verify_rect(DisplaySurface =
*surface,
                                       int x, int y, int w, int h)
 {
     if (x < 0) {
-        fprintf(stderr, "%s: x was < 0 (%d)\n", name, x);
+        error_report("%s: x was < 0 (%d)", name, x);
         return false;
     }
     if (x > SVGA_MAX_WIDTH) {
-        fprintf(stderr, "%s: x was > %d (%d)\n", name, SVGA_MAX_WIDTH, x);
+        error_report("%s: x was > %d (%d)", name, SVGA_MAX_WIDTH, x);
         return false;
     }
     if (w < 0) {
-        fprintf(stderr, "%s: w was < 0 (%d)\n", name, w);
+        error_report("%s: w was < 0 (%d)", name, w);
         return false;
     }
     if (w > SVGA_MAX_WIDTH) {
-        fprintf(stderr, "%s: w was > %d (%d)\n", name, SVGA_MAX_WIDTH, w);
+        error_report("%s: w was > %d (%d)", name, SVGA_MAX_WIDTH, w);
         return false;
     }
     if (x + w > surface_width(surface)) {
-        fprintf(stderr, "%s: width was > %d (x: %d, w: %d)\n",
+        error_report("%s: width was > %d (x: %d, w: %d)",
                 name, surface_width(surface), x, w);
         return false;
     }
=20
     if (y < 0) {
-        fprintf(stderr, "%s: y was < 0 (%d)\n", name, y);
+        error_report("%s: y was < 0 (%d)", name, y);
         return false;
     }
     if (y > SVGA_MAX_HEIGHT) {
-        fprintf(stderr, "%s: y was > %d (%d)\n", name, SVGA_MAX_HEIGHT, y)=
;
+        error_report("%s: y was > %d (%d)", name, SVGA_MAX_HEIGHT, y);
         return false;
     }
     if (h < 0) {
-        fprintf(stderr, "%s: h was < 0 (%d)\n", name, h);
+        error_report("%s: h was < 0 (%d)", name, h);
         return false;
     }
     if (h > SVGA_MAX_HEIGHT) {
-        fprintf(stderr, "%s: h was > %d (%d)\n", name, SVGA_MAX_HEIGHT, h)=
;
+        error_report("%s: h was > %d (%d)", name, SVGA_MAX_HEIGHT, h);
         return false;
     }
     if (y + h > surface_height(surface)) {
-        fprintf(stderr, "%s: update height > %d (y: %d, h: %d)\n",
+        error_report("%s: update height > %d (y: %d, h: %d)",
                 name, surface_height(surface), y, h);
         return false;
     }
@@ -529,7 +529,7 @@ static inline void vmsvga_cursor_define(struct vmsvga_s=
tate_s *s,
 #endif
         break;
     default:
-        fprintf(stderr, "%s: unhandled bpp %d, using fallback cursor\n",
+        error_report("%s: unhandled bpp %d, using fallback cursor",
                 __func__, c->bpp);
         cursor_put(qc);
         qc =3D cursor_builtin_left_ptr();
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index abd18c67ea..5d7fe06d98 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
@@ -1898,13 +1899,13 @@ static void omap_dma4_write(void *opaque, hwaddr ad=
dr,
             omap_dma_reset(s->dma);
         s->ocp =3D value & 0x3321;
         if (((s->ocp >> 12) & 3) =3D=3D 3)				/* MIDLEMODE */
-            fprintf(stderr, "%s: invalid DMA power mode\n", __func__);
+            error_report("%s: invalid DMA power mode", __func__);
         return;
=20
     case 0x78:	/* DMA4_GCR */
         s->gcr =3D value & 0x00ff00ff;
 	if ((value & 0xff) =3D=3D 0x00)		/* MAX_CHANNEL_FIFO_DEPTH */
-            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __func__);
+            error_report("%s: wrong FIFO depth in GCR", __func__);
         return;
=20
     case 0x80 ... 0xfff:
@@ -1934,8 +1935,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr=
,
         ch->buf_disable =3D (value >> 25) & 1;
         ch->src_sync =3D (value >> 24) & 1;	/* XXX For CamDMA must be 1 */
         if (ch->buf_disable && !ch->src_sync)
-            fprintf(stderr, "%s: Buffering disable is not allowed in "
-                            "destination synchronised mode\n", __func__);
+            error_report("%s: Buffering disable is not allowed in "
+                         "destination synchronised mode", __func__);
         ch->prefetch =3D (value >> 23) & 1;
         ch->bs =3D (value >> 18) & 1;
         ch->transparent_copy =3D (value >> 17) & 1;
@@ -1946,8 +1947,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr=
,
         ch->priority =3D (value & 0x0040) >> 6;
         ch->fs =3D (value & 0x0020) >> 5;
         if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1])
-            fprintf(stderr, "%s: For a packet transfer at least one port "
-                            "must be constant-addressed\n", __func__);
+            error_report("%s: For a packet transfer at least one port "
+                         "must be constant-addressed", __func__);
         ch->sync =3D (value & 0x001f) | ((value >> 14) & 0x0060);
         /* XXX must be 0x01 for CamDMA */
=20
@@ -1977,8 +1978,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr=
,
         ch->endian[1] =3D(value >> 19) & 1;
         ch->endian_lock[1] =3D(value >> 18) & 1;
         if (ch->endian[0] !=3D ch->endian[1])
-            fprintf(stderr, "%s: DMA endianness conversion enable attempt\=
n",
-                            __func__);
+            error_report("%s: DMA endianness conversion enable attempt",
+                          __func__);
         ch->write_mode =3D (value >> 16) & 3;
         ch->burst[1] =3D (value & 0xc000) >> 14;
         ch->pack[1] =3D (value & 0x2000) >> 13;
@@ -1986,12 +1987,13 @@ static void omap_dma4_write(void *opaque, hwaddr ad=
dr,
         ch->burst[0] =3D (value & 0x0180) >> 7;
         ch->pack[0] =3D (value & 0x0040) >> 6;
         ch->translate[0] =3D (value & 0x003c) >> 2;
-        if (ch->translate[0] | ch->translate[1])
-            fprintf(stderr, "%s: bad MReqAddressTranslate sideband signal\=
n",
-                            __func__);
+        if (ch->translate[0] | ch->translate[1]) {
+            error_report("%s: bad MReqAddressTranslate sideband signal",
+                         __func__);
+        }
         ch->data_type =3D 1 << (value & 3);
         if ((value & 3) =3D=3D 3) {
-            printf("%s: bad data_type for DMA channel\n", __func__);
+            error_report("%s: bad data_type for DMA channel", __func__);
             ch->data_type >>=3D 1;
         }
         break;
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 9bb499bf9c..7339a3ec95 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/soc_dma.h"
@@ -270,11 +271,11 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwa=
ddr virt_base,
         if (entry->type =3D=3D soc_dma_port_mem) {
             if (entry->addr <=3D virt_base &&
                             entry->addr + entry->u.mem.size > virt_base) {
-                fprintf(stderr, "%s: FIFO at %"PRIx64
-                                " collides with RAM region at %"PRIx64
-                                "-%"PRIx64 "\n", __func__,
-                                virt_base, entry->addr,
-                                (entry->addr + entry->u.mem.size));
+                error_report("%s: FIFO at %"PRIx64
+                             " collides with RAM region at %"PRIx64
+                             "-%"PRIx64 "", __func__,
+                             virt_base, entry->addr,
+                             (entry->addr + entry->u.mem.size));
                 exit(-1);
             }
=20
@@ -284,9 +285,9 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwadd=
r virt_base,
             while (entry < dma->memmap + dma->memmap_size &&
                             entry->addr <=3D virt_base) {
                 if (entry->addr =3D=3D virt_base && entry->u.fifo.out =3D=
=3D out) {
-                    fprintf(stderr, "%s: FIFO at %"PRIx64
-                                    " collides FIFO at %"PRIx64 "\n",
-                                    __func__, virt_base, entry->addr);
+                    error_report("%s: FIFO at %"PRIx64
+                                 " collides FIFO at %"PRIx64 "",
+                                 __func__, virt_base, entry->addr);
                     exit(-1);
                 }
=20
@@ -321,11 +322,11 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint=
8_t *phys_base,
             if ((entry->addr >=3D virt_base && entry->addr < virt_base + s=
ize) ||
                             (entry->addr <=3D virt_base &&
                              entry->addr + entry->u.mem.size > virt_base))=
 {
-                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
-                                " collides with RAM region at %"PRIx64
-                                "-%"PRIx64 "\n", __func__,
-                                virt_base, virt_base + size,
-                                entry->addr, entry->addr + entry->u.mem.si=
ze);
+                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
+                             " collides with RAM region at %"PRIx64
+                             "-%"PRIx64 "", __func__,
+                             virt_base, virt_base + size,
+                             entry->addr, entry->addr + entry->u.mem.size)=
;
                 exit(-1);
             }
=20
@@ -334,11 +335,11 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint=
8_t *phys_base,
         } else {
             if (entry->addr >=3D virt_base &&
                             entry->addr < virt_base + size) {
-                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
-                                " collides with FIFO at %"PRIx64
-                                "\n", __func__,
-                                virt_base, virt_base + size,
-                                entry->addr);
+                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
+                             " collides with FIFO at %"PRIx64
+                             "", __func__,
+                             virt_base, virt_base + size,
+                             entry->addr);
                 exit(-1);
             }
=20
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 08472193b5..57aa2e54f5 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -399,7 +399,7 @@ static void omap2_gpio_module_write(void *opaque, hwadd=
r addr,
=20
     case 0x10:	/* GPIO_SYSCONFIG */
         if (((value >> 3) & 3) =3D=3D 3)
-            fprintf(stderr, "%s: bad IDLEMODE value\n", __func__);
+            error_report("%s: bad IDLEMODE value", __func__);
         if (value & 2)
             omap2_gpio_module_reset(s);
         s->config[0] =3D value & 0x1d;
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 26e3e5ebf6..c89664f342 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -340,13 +340,13 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
             break;
         }
         if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
-            fprintf(stderr, "%s: I^2C slave mode not supported\n",
-                            __func__);
+            error_report("%s: I^2C slave mode not supported",
+                         __func__);
             break;
         }
         if ((value & (1 << 15)) && value & (1 << 8)) {		/* XA */
-            fprintf(stderr, "%s: 10-bit addressing mode not supported\n",
-                            __func__);
+            error_report("%s: 10-bit addressing mode not supported",
+                         __func__);
             break;
         }
         if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
@@ -393,7 +393,7 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
                 omap_i2c_interrupts_update(s);
             }
         if (value & (1 << 15))					/* ST_EN */
-            fprintf(stderr, "%s: System Test not supported\n", __func__);
+            error_report("%s: System Test not supported", __func__);
         break;
=20
     default:
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1df6d26816..e90a1b9b3b 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -10,6 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/i386/apic_internal.h"
@@ -128,7 +129,7 @@ static void kvm_apic_vapic_base_update(APICCommonState =
*s)
=20
     ret =3D kvm_vcpu_ioctl(CPU(s->cpu), KVM_SET_VAPIC_ADDR, &vapid_addr);
     if (ret < 0) {
-        fprintf(stderr, "KVM: setting VAPIC address failed (%s)\n",
+        error_report("KVM: setting VAPIC address failed (%s)",
                 strerror(-ret));
         abort();
     }
@@ -145,7 +146,7 @@ static void kvm_apic_put(CPUState *cs, run_on_cpu_data =
data)
=20
     ret =3D kvm_vcpu_ioctl(CPU(s->cpu), KVM_SET_LAPIC, &kapic);
     if (ret < 0) {
-        fprintf(stderr, "KVM_SET_LAPIC failed: %s\n", strerror(ret));
+        error_report("KVM_SET_LAPIC failed: %s", strerror(ret));
         abort();
     }
 }
@@ -167,7 +168,7 @@ static void do_inject_external_nmi(CPUState *cpu, run_o=
n_cpu_data data)
     if (!(lvt & APIC_LVT_MASKED) && ((lvt >> 8) & 7) =3D=3D APIC_DM_NMI) {
         ret =3D kvm_vcpu_ioctl(cpu, KVM_NMI);
         if (ret < 0) {
-            fprintf(stderr, "KVM: injection failed, NMI lost (%s)\n",
+            error_report("KVM: injection failed, NMI lost (%s)",
                     strerror(-ret));
         }
     }
@@ -184,7 +185,7 @@ static void kvm_send_msi(MSIMessage *msg)
=20
     ret =3D kvm_irqchip_send_msi(kvm_state, *msg);
     if (ret < 0) {
-        fprintf(stderr, "KVM: injection failed, MSI lost (%s)\n",
+        error_report("KVM: injection failed, MSI lost (%s)",
                 strerror(-ret));
     }
 }
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 363d1b5743..e05c1587ce 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -14,6 +14,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
@@ -99,7 +100,7 @@ static void kvm_update_clock(KVMClockState *s)
=20
     ret =3D kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
     if (ret < 0) {
-        fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
+        error_report("KVM_GET_CLOCK failed: %s", strerror(ret));
                 abort();
     }
     s->clock =3D data.clock;
@@ -174,7 +175,7 @@ static void kvmclock_vm_state_change(void *opaque, int =
running,
         data.clock =3D s->clock;
         ret =3D kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
         if (ret < 0) {
-            fprintf(stderr, "KVM_SET_CLOCK failed: %s\n", strerror(ret));
+            error_report("KVM_SET_CLOCK failed: %s", strerror(ret));
             abort();
         }
=20
@@ -185,7 +186,7 @@ static void kvmclock_vm_state_change(void *opaque, int =
running,
             ret =3D kvm_vcpu_ioctl(cpu, KVM_KVMCLOCK_CTRL, 0);
             if (ret) {
                 if (ret !=3D -EINVAL) {
-                    fprintf(stderr, "%s: %s\n", __func__, strerror(-ret));
+                    error_report("%s: %s", __func__, strerror(-ret));
                 }
                 return;
             }
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 521a58498a..27f24b1090 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include <linux/kvm.h>
 #include "qapi/error.h"
 #include "qemu/timer.h"
@@ -101,7 +102,7 @@ static void kvm_pit_get(PITCommonState *pit)
     if (kvm_has_pit_state2()) {
         ret =3D kvm_vm_ioctl(kvm_state, KVM_GET_PIT2, &kpit);
         if (ret < 0) {
-            fprintf(stderr, "KVM_GET_PIT2 failed: %s\n", strerror(ret));
+            error_report("KVM_GET_PIT2 failed: %s", strerror(ret));
             abort();
         }
         pit->channels[0].irq_disabled =3D kpit.flags & KVM_PIT_FLAGS_HPET_=
LEGACY;
@@ -112,7 +113,7 @@ static void kvm_pit_get(PITCommonState *pit)
          */
         ret =3D kvm_vm_ioctl(kvm_state, KVM_GET_PIT, &kpit);
         if (ret < 0) {
-            fprintf(stderr, "KVM_GET_PIT failed: %s\n", strerror(ret));
+            error_report("KVM_GET_PIT failed: %s", strerror(ret));
             abort();
         }
     }
@@ -175,7 +176,7 @@ static void kvm_pit_put(PITCommonState *pit)
                        kvm_has_pit_state2() ? KVM_SET_PIT2 : KVM_SET_PIT,
                        &kpit);
     if (ret < 0) {
-        fprintf(stderr, "%s failed: %s\n",
+        error_report("%s failed: %s",
                 kvm_has_pit_state2() ? "KVM_SET_PIT2" : "KVM_SET_PIT",
                 strerror(ret));
         abort();
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 11d1b726b6..770a934552 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -10,6 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/isa/i8259_internal.h"
 #include "hw/i386/apic_internal.h"
 #include "sysemu/kvm.h"
@@ -39,7 +40,7 @@ static void kvm_pic_get(PICCommonState *s)
     chip.chip_id =3D s->master ? KVM_IRQCHIP_PIC_MASTER : KVM_IRQCHIP_PIC_=
SLAVE;
     ret =3D kvm_vm_ioctl(kvm_state, KVM_GET_IRQCHIP, &chip);
     if (ret < 0) {
-        fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(ret));
+        error_report("KVM_GET_IRQCHIP failed: %s", strerror(ret));
         abort();
     }
=20
@@ -92,7 +93,7 @@ static void kvm_pic_put(PICCommonState *s)
=20
     ret =3D kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
     if (ret < 0) {
-        fprintf(stderr, "KVM_SET_IRQCHIP failed: %s\n", strerror(ret));
+        error_report("KVM_SET_IRQCHIP failed: %s", strerror(ret));
         abort();
     }
 }
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 98ca480792..a31bcd2658 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "monitor/monitor.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/ioapic_internal.h"
@@ -74,7 +75,7 @@ static void kvm_ioapic_get(IOAPICCommonState *s)
     chip.chip_id =3D KVM_IRQCHIP_IOAPIC;
     ret =3D kvm_vm_ioctl(kvm_state, KVM_GET_IRQCHIP, &chip);
     if (ret < 0) {
-        fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(ret));
+        error_report("KVM_GET_IRQCHIP failed: %s", strerror(ret));
         abort();
     }
=20
@@ -107,7 +108,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
=20
     ret =3D kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
     if (ret < 0) {
-        fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(ret));
+        error_report("KVM_GET_IRQCHIP failed: %s", strerror(ret));
         abort();
     }
 }
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index c7b70c91d5..d297a88f9d 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -184,7 +185,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     memset(&mbs, 0, sizeof(mbs));
=20
     if (flags & 0x00000004) { /* MULTIBOOT_HEADER_HAS_VBE */
-        fprintf(stderr, "qemu: multiboot knows VBE. we don't.\n");
+        error_report("qemu: multiboot knows VBE. we don't.");
     }
     if (!(flags & 0x00010000)) { /* MULTIBOOT_HEADER_HAS_ADDR */
         uint64_t elf_entry;
@@ -193,7 +194,7 @@ int load_multiboot(FWCfgState *fw_cfg,
         fclose(f);
=20
         if (((struct elf64_hdr*)header)->e_machine =3D=3D EM_X86_64) {
-            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n=
");
+            error_report("Cannot load x86-64 image, give a 32bit one.");
             exit(1);
         }
=20
@@ -201,7 +202,7 @@ int load_multiboot(FWCfgState *fw_cfg,
                                &elf_low, &elf_high, 0, I386_ELF_MACHINE,
                                0, 0);
         if (kernel_size < 0) {
-            fprintf(stderr, "Error while loading elf kernel\n");
+            error_report("Error while loading elf kernel");
             exit(1);
         }
         mh_load_addr =3D elf_low;
@@ -210,7 +211,7 @@ int load_multiboot(FWCfgState *fw_cfg,
=20
         mbs.mb_buf =3D g_malloc(mb_kernel_size);
         if (rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size) !=3D mb_ker=
nel_size) {
-            fprintf(stderr, "Error while fetching elf kernel from rom\n");
+            error_report("Error while fetching elf kernel from rom");
             exit(1);
         }
=20
@@ -224,7 +225,7 @@ int load_multiboot(FWCfgState *fw_cfg,
=20
         mh_load_addr =3D ldl_p(header+i+16);
         if (mh_header_addr < mh_load_addr) {
-            fprintf(stderr, "invalid mh_load_addr address\n");
+            error_report("invalid mh_load_addr address");
             exit(1);
         }
=20
@@ -234,19 +235,19 @@ int load_multiboot(FWCfgState *fw_cfg,
=20
         if (mh_load_end_addr) {
             if (mh_bss_end_addr < mh_load_addr) {
-                fprintf(stderr, "invalid mh_bss_end_addr address\n");
+                error_report("invalid mh_bss_end_addr address");
                 exit(1);
             }
             mb_kernel_size =3D mh_bss_end_addr - mh_load_addr;
=20
             if (mh_load_end_addr < mh_load_addr) {
-                fprintf(stderr, "invalid mh_load_end_addr address\n");
+                error_report("invalid mh_load_end_addr address");
                 exit(1);
             }
             mb_load_size =3D mh_load_end_addr - mh_load_addr;
         } else {
             if (kernel_file_size < mb_kernel_text_offset) {
-                fprintf(stderr, "invalid kernel_file_size\n");
+                error_report("invalid kernel_file_size");
                 exit(1);
             }
             mb_kernel_size =3D kernel_file_size - mb_kernel_text_offset;
@@ -269,7 +270,7 @@ int load_multiboot(FWCfgState *fw_cfg,
         mbs.mb_buf =3D g_malloc(mb_kernel_size);
         fseek(f, mb_kernel_text_offset, SEEK_SET);
         if (fread(mbs.mb_buf, 1, mb_load_size, f) !=3D mb_load_size) {
-            fprintf(stderr, "fread() failed\n");
+            error_report("fread() failed");
             exit(1);
         }
         memset(mbs.mb_buf + mb_load_size, 0, mb_kernel_size - mb_load_size=
);
@@ -326,7 +327,7 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_debug("multiboot loading module: %s\n", tmpbuf);
             mb_mod_length =3D get_image_size(tmpbuf);
             if (mb_mod_length < 0) {
-                fprintf(stderr, "Failed to open file '%s'\n", tmpbuf);
+                error_report("Failed to open file '%s'", tmpbuf);
                 exit(1);
             }
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..ca25424c09 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -856,14 +856,14 @@ static void load_linux(PCMachineState *pcms,
     if (!f || !(kernel_size =3D get_file_size(f)) ||
         fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=3D
         MIN(ARRAY_SIZE(header), kernel_size)) {
-        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
+        error_report("qemu: could not load kernel '%s': %s",
                 kernel_filename, strerror(errno));
         exit(1);
     }
=20
     /* kernel protocol version */
 #if 0
-    fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
+    error_report("header magic: %#x", ldl_p(header + 0x202));
 #endif
     if (ldl_p(header+0x202) =3D=3D 0x53726448) {
         protocol =3D lduw_p(header+0x206);
@@ -960,13 +960,13 @@ static void load_linux(PCMachineState *pcms,
     /* load initrd */
     if (initrd_filename) {
         if (protocol < 0x200) {
-            fprintf(stderr, "qemu: linux kernel too old to load a ram disk=
\n");
+            error_report("qemu: linux kernel too old to load a ram disk");
             exit(1);
         }
=20
         initrd_size =3D get_image_size(initrd_filename);
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
+            error_report("qemu: error reading initrd %s: %s",
                     initrd_filename, strerror(errno));
             exit(1);
         }
@@ -991,7 +991,7 @@ static void load_linux(PCMachineState *pcms,
     }
     setup_size =3D (setup_size+1)*512;
     if (setup_size > kernel_size) {
-        fprintf(stderr, "qemu: invalid kernel header\n");
+        error_report("qemu: invalid kernel header");
         exit(1);
     }
     kernel_size -=3D setup_size;
@@ -1000,11 +1000,11 @@ static void load_linux(PCMachineState *pcms,
     kernel =3D g_malloc(kernel_size);
     fseek(f, 0, SEEK_SET);
     if (fread(setup, 1, setup_size, f) !=3D setup_size) {
-        fprintf(stderr, "fread() failed\n");
+        error_report("fread() failed");
         exit(1);
     }
     if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
-        fprintf(stderr, "fread() failed\n");
+        error_report("fread() failed");
         exit(1);
     }
     fclose(f);
@@ -1012,13 +1012,13 @@ static void load_linux(PCMachineState *pcms,
     /* append dtb to kernel */
     if (dtb_filename) {
         if (protocol < 0x209) {
-            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
+            error_report("qemu: Linux kernel too old to load a dtb");
             exit(1);
         }
=20
         dtb_size =3D get_image_size(dtb_filename);
         if (dtb_size <=3D 0) {
-            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
+            error_report("qemu: error reading dtb %s: %s",
                     dtb_filename, strerror(errno));
             exit(1);
         }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9ff79b1fd9..1796db1e36 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -1090,7 +1090,7 @@ void igd_passthrough_isa_bridge_create(PCIBus *bus, u=
int16_t gpu_dev_id)
      * Note that vendor id is always PCI_VENDOR_ID_INTEL.
      */
     if (!bridge_dev) {
-        fprintf(stderr, "set igd-passthrough-isa-bridge failed!\n");
+        error_report("set igd-passthrough-isa-bridge failed!");
         return;
     }
     pci_config_set_device_id(bridge_dev->config, pch_dev_id);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 6b183747fc..b6c10a509f 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -201,7 +201,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_me=
mory, bool isapc_ram_fw)
     ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
     if (ret !=3D 0) {
     bios_error:
-        fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+        error_report("qemu: could not load PC BIOS '%s'", bios_name);
         exit(1);
     }
     g_free(filename);
@@ -243,7 +243,8 @@ void pc_system_firmware_init(MemoryRegion *rom_memory, =
bool isapc_ram_fw)
     if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
         /* Older KVM cannot execute from device memory. So, flash memory
          * cannot be used unless the readonly memory kvm capability is pre=
sent. */
-        fprintf(stderr, "qemu: pflash with kvm requires KVM readonly memor=
y support\n");
+        error_report("qemu: pflash with kvm requires KVM readonly memory"
+                     " support");
         exit(1);
     }
=20
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d9ccd5d0d6..f8e3e0507b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -246,9 +246,10 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t siz=
e, MemoryRegion *mr,
=20
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         /* RAM already populated in Xen */
-        fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
-                " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRAT=
E\n",
-                __func__, size, ram_addr);=20
+        error_report("%s: do not alloc "RAM_ADDR_FMT
+                     " bytes of ram at "RAM_ADDR_FMT" when runstate is "
+                     " INMIGRATE",
+                     __func__, size, ram_addr);
         return;
     }
=20
@@ -444,8 +445,9 @@ static int xen_remove_from_physmap(XenIOState *state,
=20
         rc =3D xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE=
_gmfn, idx, gpfn);
         if (rc) {
-            fprintf(stderr, "add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
-                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc,=
 errno);
+            error_report("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
+                         PRI_xen_pfn" failed: %d (errno: %d)", idx,
+                         gpfn, rc, errno);
             return -rc;
         }
     }
@@ -1090,11 +1092,11 @@ static void cpu_handle_ioreq(void *opaque)
         req->data =3D copy.data;
=20
         if (req->state !=3D STATE_IOREQ_INPROCESS) {
-            fprintf(stderr, "Badness in I/O request ... not in service?!: =
"
-                    "%x, ptr: %x, port: %"PRIx64", "
-                    "data: %"PRIx64", count: %u, size: %u, type: %u\n",
-                    req->state, req->data_is_ptr, req->addr,
-                    req->data, req->count, req->size, req->type);
+            error_report("Badness in I/O request ... not in service?!: "
+                         "%x, ptr: %x, port: %"PRIx64", "
+                         "data: %"PRIx64", count: %u, size: %u, type: %u",
+                         req->state, req->data_is_ptr, req->addr,
+                         req->data, req->count, req->size, req->type);
             destroy_hvm_domain(false);
             return;
         }
@@ -1397,16 +1399,16 @@ void destroy_hvm_domain(bool reboot)
=20
     xc_handle =3D xc_interface_open(0, 0, 0);
     if (xc_handle =3D=3D NULL) {
-        fprintf(stderr, "Cannot acquire xenctrl handle\n");
+        error_report("Cannot acquire xenctrl handle");
     } else {
         sts =3D xc_domain_shutdown(xc_handle, xen_domid,
                                  reboot ? SHUTDOWN_reboot : SHUTDOWN_power=
off);
         if (sts !=3D 0) {
-            fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
-                    "sts %d, %s\n", reboot ? "reboot" : "poweroff",
+            error_report("xc_domain_shutdown failed to issue %s, "
+                    "sts %d, %s", reboot ? "reboot" : "poweroff",
                     sts, strerror(errno));
         } else {
-            fprintf(stderr, "Issued domain %d %s\n", xen_domid,
+            error_report("Issued domain %d %s", xen_domid,
                     reboot ? "reboot" : "poweroff");
         }
         xc_interface_close(xc_handle);
@@ -1425,7 +1427,7 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
     va_start(ap, fmt);
     vfprintf(stderr, fmt, ap);
     va_end(ap);
-    fprintf(stderr, "Will destroy the domain.\n");
+    error_report("Will destroy the domain.");
     /* destroy the domain */
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
 }
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index baab93b614..4062af0900 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -377,7 +377,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
+        error_report("%s, could not find %p", __func__, ptr);
         QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
             DPRINTF("   "TARGET_FMT_plx" -> %p is present\n", reventry->pa=
ddr_index,
                     reventry->vaddr_req);
@@ -477,9 +477,9 @@ void xen_invalidate_map_cache(void)
         if (!reventry->dma) {
             continue;
         }
-        fprintf(stderr, "Locked DMA mapping while invalidating mapcache!"
-                " "TARGET_FMT_plx" -> %p is present\n",
-                reventry->paddr_index, reventry->vaddr_req);
+        error_report("Locked DMA mapping while invalidating mapcache!"
+                     " "TARGET_FMT_plx" -> %p is present",
+                     reventry->paddr_index, reventry->vaddr_req);
     }
=20
     for (i =3D 0; i < mapcache->nr_buckets; i++) {
@@ -545,8 +545,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr=
 old_phys_addr,
     address_index  =3D new_phys_addr >> MCACHE_BUCKET_SHIFT;
     address_offset =3D new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
=20
-    fprintf(stderr, "Replacing a dummy mapcache entry for "TARGET_FMT_plx =
\
-            " with "TARGET_FMT_plx"\n", old_phys_addr, new_phys_addr);
+    error_report("Replacing a dummy mapcache entry for "TARGET_FMT_plx \
+                 " with "TARGET_FMT_plx"", old_phys_addr, new_phys_addr);
=20
     xen_remap_bucket(entry, entry->vaddr_base,
                      cache_size, address_index, false);
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 55769eba7e..9e19ef94a2 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -24,7 +24,7 @@ static void xen_apic_mem_write(void *opaque, hwaddr addr,
                                uint64_t data, unsigned size)
 {
     if (size !=3D sizeof(uint32_t)) {
-        fprintf(stderr, "Xen: APIC write data size =3D %d, invalid\n", siz=
e);
+        error_report("Xen: APIC write data size =3D %d, invalid", size);
         return;
     }
=20
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index c25e293d88..2ed015285a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -410,8 +410,8 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
=20
     /* Only aligned reads are allowed on AHCI */
     if (addr & 3) {
-        fprintf(stderr, "ahci: Mis-aligned write to addr 0x"
-                TARGET_FMT_plx "\n", addr);
+        error_report("ahci: Mis-aligned write to addr 0x"
+                     TARGET_FMT_plx "", addr);
         return;
     }
=20
@@ -1053,7 +1053,7 @@ static void process_ncq_command(AHCIState *s, int por=
t, uint8_t *cmd_fis,
     g_assert(is_ncq(ncq_fis->command));
     if (ncq_tfs->used) {
         /* error - already in use */
-        fprintf(stderr, "%s: tag %d already used\n", __func__, tag);
+        error_report("%s: tag %d already used", __func__, tag);
         return;
     }
=20
diff --git a/hw/ide/core.c b/hw/ide/core.c
index d63eb4a72e..d46936193a 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2762,7 +2762,7 @@ static void ide_drive_pio_pre_save(void *opaque)
=20
     idx =3D transfer_end_table_idx(s->end_transfer_func);
     if (idx =3D=3D -1) {
-        fprintf(stderr, "%s: invalid end_transfer_func for DRQ_STAT\n",
+        error_report("%s: invalid end_transfer_func for DRQ_STAT",
                         __func__);
         s->end_transfer_fn_idx =3D 2;
     } else {
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index d39953126b..caeeda47f2 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -239,7 +239,7 @@ static uint8_t lm_kbd_read(LM823KbdState *s, int reg, i=
nt byte)
=20
     default:
         lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
+        error_report("%s: unknown command %02x", __func__, reg);
         return 0x00;
     }
=20
@@ -330,7 +330,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int=
 byte, uint8_t value)
         s->reg =3D LM832x_GENERAL_ERROR;
         if ((value & 3) && (value & 3) !=3D 3) {
             lm_kbd_error(s, ERR_BADPAR);
-            fprintf(stderr, "%s: invalid clock setting in RCPWM\n",
+            error_report("%s: invalid clock setting in RCPWM",
                             __func__);
         }
         /* TODO: Validate that the command is only issued once */
@@ -378,7 +378,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int=
 byte, uint8_t value)
         break;
     default:
         lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
+        error_report("%s: unknown command %02x", __func__, reg);
         break;
     }
 }
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f827b6..ff4f03e4c3 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
@@ -307,7 +308,7 @@ static void kbd_write_command(void *opaque, hwaddr addr=
,
         /* ignore that */
         break;
     default:
-        fprintf(stderr, "qemu: unsupported keyboard cmd=3D0x%02x\n", (int)=
val);
+        error_report("qemu: unsupported keyboard cmd=3D0x%02x", (int)val);
         break;
     }
 }
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 93db9ed25b..0a594c30fc 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -326,7 +326,7 @@ void pxa27x_register_keypad(PXA2xxKeyPadState *kp,
                             const struct keymap *map, int size)
 {
     if(!map || size < 0x80) {
-        fprintf(stderr, "%s - No PXA keypad map defined\n", __func__);
+        error_report("%s - No PXA keypad map defined", __func__);
         exit(-1);
     }
=20
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 7990954b6c..f5057e8eeb 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -200,17 +200,17 @@ static void tsc2005_write(TSC2005State *s, int reg, u=
int16_t data)
         s->host_mode =3D (data >> 15) !=3D 0;
         if (s->enabled !=3D !(data & 0x4000)) {
             s->enabled =3D !(data & 0x4000);
-            fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                            __func__, s->enabled ? "en" : "dis");
+            error_report("%s: touchscreen sense %sabled",
+                         __func__, s->enabled ? "en" : "dis");
             if (s->busy && !s->enabled)
                 timer_del(s->timer);
             s->busy =3D s->busy && s->enabled;
         }
         s->nextprecision =3D (data >> 13) & 1;
         s->timing[0] =3D data & 0x1fff;
-        if ((s->timing[0] >> 11) =3D=3D 3)
-            fprintf(stderr, "%s: illegal conversion clock setting\n",
-                            __func__);
+        if ((s->timing[0] >> 11) =3D=3D 3) {
+            error_report("%s: illegal conversion clock setting", __func__)=
;
+        }
         break;
     case 0xd:	/* CFR1 */
         s->timing[1] =3D data & 0xf07;
@@ -221,8 +221,7 @@ static void tsc2005_write(TSC2005State *s, int reg, uin=
t16_t data)
         break;
=20
     default:
-        fprintf(stderr, "%s: write into read-only register %x\n",
-                        __func__, reg);
+        error_report("%s: write into read-only register %x", __func__, reg=
);
     }
 }
=20
@@ -337,8 +336,8 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t =
value)
                 s->nextprecision =3D (value >> 2) & 1;
                 if (s->enabled !=3D !(value & 1)) {
                     s->enabled =3D !(value & 1);
-                    fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                                    __func__, s->enabled ? "en" : "dis");
+                    error_report("%s: touchscreen sense %sabled",
+                                 __func__, s->enabled ? "en" : "dis");
                     if (s->busy && !s->enabled)
                         timer_del(s->timer);
                     s->busy =3D s->busy && s->enabled;
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index d4b19c1825..c685221842 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -396,8 +396,8 @@ static uint16_t tsc2102_data_register_read(TSC210xState=
 *s, int reg)
=20
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_data_register_read: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_data_register_read: "
+                     "no such register: 0x%02x", reg);
 #endif
         return 0xffff;
     }
@@ -447,8 +447,8 @@ static uint16_t tsc2102_control_register_read(
     default:
     bad_reg:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_control_register_read: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_control_register_read: "
+                     "no such register: 0x%02x", reg);
 #endif
         return 0xffff;
     }
@@ -528,8 +528,8 @@ static uint16_t tsc2102_audio_register_read(TSC210xStat=
e *s, int reg)
=20
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_audio_register_read: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_audio_register_read: "
+                     "no such register: 0x%02x", reg);
 #endif
         return 0xffff;
     }
@@ -553,8 +553,8 @@ static void tsc2102_data_register_write(
=20
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_data_register_write: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_data_register_write: "
+                     "no such register: 0x%02x", reg);
 #endif
     }
 }
@@ -606,8 +606,8 @@ static void tsc2102_control_register_write(
             tsc210x_reset(s);
 #ifdef TSC_VERBOSE
         } else {
-            fprintf(stderr, "tsc2102_control_register_write: "
-                            "wrong value written into RESET\n");
+            error_report("tsc2102_control_register_write: "
+                         "wrong value written into RESET");
 #endif
         }
         return;
@@ -616,8 +616,8 @@ static void tsc2102_control_register_write(
         s->timing =3D value & 0x3f;
 #ifdef TSC_VERBOSE
         if (value & ~0x3f)
-            fprintf(stderr, "tsc2102_control_register_write: "
-                            "wrong value written into CONFIG\n");
+            error_report("tsc2102_control_register_write: "
+                         "wrong value written into CONFIG");
 #endif
         return;
=20
@@ -637,8 +637,8 @@ static void tsc2102_control_register_write(
     default:
     bad_reg:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_control_register_write: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_control_register_write: "
+                     "no such register: 0x%02x", reg);
 #endif
     }
 }
@@ -651,8 +651,8 @@ static void tsc2102_audio_register_write(
         s->audio_ctrl1 =3D value & 0x0f3f;
 #ifdef TSC_VERBOSE
         if ((value & ~0x0f3f) || ((value & 7) !=3D ((value >> 3) & 7)))
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 1\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 1");
 #endif
         tsc2102_audio_rate_update(s);
         tsc2102_audio_output_update(s);
@@ -661,8 +661,8 @@ static void tsc2102_audio_register_write(
     case 0x01:
 #ifdef TSC_VERBOSE
         if (value !=3D 0xff00)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into reg 0x01\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into reg 0x01");
 #endif
         return;
=20
@@ -674,8 +674,8 @@ static void tsc2102_audio_register_write(
     case 0x03:
 #ifdef TSC_VERBOSE
         if (value !=3D 0x8b00)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into reg 0x03\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into reg 0x03");
 #endif
         return;
=20
@@ -683,8 +683,8 @@ static void tsc2102_audio_register_write(
         s->audio_ctrl2 =3D value & 0xf7f2;
 #ifdef TSC_VERBOSE
         if (value & ~0xf7fd)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 2\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 2");
 #endif
         return;
=20
@@ -695,8 +695,8 @@ static void tsc2102_audio_register_write(
         s->dac_power =3D value & 0x9543;
 #ifdef TSC_VERBOSE
         if ((value & ~0x9543) !=3D 0x2aa0)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Power\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Power");
 #endif
         tsc2102_audio_rate_update(s);
         tsc2102_audio_output_update(s);
@@ -707,8 +707,8 @@ static void tsc2102_audio_register_write(
         s->audio_ctrl3 |=3D value & 0xf800;
 #ifdef TSC_VERBOSE
         if (value & ~0xf8c7)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 3\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 3");
 #endif
         tsc2102_audio_output_update(s);
         return;
@@ -740,8 +740,8 @@ static void tsc2102_audio_register_write(
         s->pll[0] =3D value & 0xfffc;
 #ifdef TSC_VERBOSE
         if (value & ~0xfffc)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into PLL 1\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into PLL 1");
 #endif
         return;
=20
@@ -749,8 +749,8 @@ static void tsc2102_audio_register_write(
         s->pll[1] =3D value & 0xfffc;
 #ifdef TSC_VERBOSE
         if (value & ~0xfffc)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into PLL 2\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into PLL 2");
 #endif
         return;
=20
@@ -758,15 +758,15 @@ static void tsc2102_audio_register_write(
         s->softstep =3D !(value & 0x4000);
 #ifdef TSC_VERBOSE
         if (value & ~0x4000)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 4\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 4");
 #endif
         return;
=20
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_audio_register_write: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_audio_register_write: "
+                     "no such register: 0x%02x", reg);
 #endif
     }
 }
@@ -847,7 +847,7 @@ static uint16_t tsc210x_read(TSC210xState *s)
     uint16_t ret =3D 0x0000;
=20
     if (!s->command)
-        fprintf(stderr, "tsc210x_read: SPI underrun!\n");
+        error_report("tsc210x_read: SPI underrun!");
=20
     switch (s->page) {
     case TSC_DATA_REGISTERS_PAGE:
@@ -886,7 +886,7 @@ static void tsc210x_write(TSC210xState *s, uint16_t val=
ue)
         s->state =3D true;
     } else {
         if (s->command)
-            fprintf(stderr, "tsc210x_write: SPI overrun!\n");
+            error_report("tsc210x_write: SPI overrun!");
         else
             switch (s->page) {
             case TSC_DATA_REGISTERS_PAGE:
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 4d3afc1b14..bf1ed7b18e 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -208,8 +208,8 @@ static void virtio_input_handle_event(DeviceState *dev,=
 QemuConsole *src,
             virtio_input_send(vinput, &event);
         } else {
             if (key->down) {
-                fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
-                        qcode, QKeyCode_str(qcode));
+                error_report("%s: unmapped key: %d [%s]", __func__,
+                             qcode, QKeyCode_str(qcode));
             }
         }
         break;
@@ -222,9 +222,9 @@ static void virtio_input_handle_event(DeviceState *dev,=
 QemuConsole *src,
             virtio_input_send(vinput, &event);
         } else {
             if (btn->down) {
-                fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func__=
,
-                        btn->button,
-                        InputButton_str(btn->button));
+                error_report("%s: unmapped button: %d [%s]", __func__,
+                             btn->button,
+                             InputButton_str(btn->button));
             }
         }
         break;
@@ -310,8 +310,8 @@ static void virtio_input_hid_handle_status(VirtIOInput =
*vinput,
         kbd_put_ledstate(vhid->ledstate);
         break;
     default:
-        fprintf(stderr, "%s: unknown type %d\n", __func__,
-                le16_to_cpu(event->type));
+        error_report("%s: unknown type %d", __func__,
+                     le16_to_cpu(event->type));
         break;
     }
 }
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d02c..fb5fa0a280 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -5,6 +5,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "trace.h"
@@ -121,8 +122,8 @@ void virtio_input_add_config(VirtIOInput *vinput,
=20
     if (virtio_input_find_config(vinput, config->select, config->subsel)) =
{
         /* should not happen */
-        fprintf(stderr, "%s: duplicate config: %d/%d\n",
-                __func__, config->select, config->subsel);
+        error_report("%s: duplicate config: %d/%d",
+                     __func__, config->select, config->subsel);
         abort();
     }
=20
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index ae095d08a3..a5478d3e20 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -316,12 +316,12 @@ static void kvm_arm_gic_put(GICState *s)
     num_cpu =3D ((reg & 0xe0) >> 5) + 1;
=20
     if (num_irq < s->num_irq) {
-            fprintf(stderr, "Restoring %u IRQs, but kernel supports max %d=
\n",
-                    s->num_irq, num_irq);
+            error_report("Restoring %u IRQs, but kernel supports max %d",
+                         s->num_irq, num_irq);
             abort();
     } else if (num_cpu !=3D s->num_cpu) {
-            fprintf(stderr, "Restoring %u CPU interfaces, kernel only has =
%d\n",
-                    s->num_cpu, num_cpu);
+            error_report("Restoring %u CPU interfaces, kernel only has %d"=
,
+                         s->num_cpu, num_cpu);
             /* Did we not create the VCPUs in the kernel yet? */
             abort();
     }
@@ -411,8 +411,8 @@ static void kvm_arm_gic_get(GICState *s)
     s->num_cpu =3D ((reg & 0xe0) >> 5) + 1;
=20
     if (s->num_irq > GIC_MAXIRQ) {
-            fprintf(stderr, "Too many IRQs reported from the kernel: %d\n"=
,
-                    s->num_irq);
+            error_report("Too many IRQs reported from the kernel: %d",
+                         s->num_irq);
             abort();
     }
=20
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 6844c1aa83..7fc239715a 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -539,8 +539,8 @@ static void omap2_inth_write(void *opaque, hwaddr addr,
         /* TODO: Make a bitmap (or sizeof(char)map) of access privileges
          * for every register, see Chapter 3 and 4 for privileged mode.  *=
/
         if (value & 1)
-            fprintf(stderr, "%s: protection mode enable attempt\n",
-                            __func__);
+            error_report("%s: protection mode enable attempt",
+                          __func__);
         return;
=20
     case 0x50:	/* INTC_IDLE */
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9dd285b923..dfaefbf575 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -34,6 +34,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
@@ -162,7 +163,7 @@ static int inttgt_to_output(int inttgt)
         }
     }
=20
-    fprintf(stderr, "%s: unsupported inttgt %d\n", __func__, inttgt);
+    error_report("%s: unsupported inttgt %d", __func__, inttgt);
     return OPENPIC_OUTPUT_INT;
 }
=20
@@ -534,7 +535,7 @@ static void openpic_set_irq(void *opaque, int n_IRQ, in=
t level)
     IRQSource *src;
=20
     if (n_IRQ >=3D OPENPIC_MAX_IRQ) {
-        fprintf(stderr, "%s: IRQ %d out of range\n", __func__, n_IRQ);
+        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
         abort();
     }
=20
@@ -1208,7 +1209,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDe=
st *dst, int cpu)
     src =3D &opp->src[irq];
     if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
             !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
-        fprintf(stderr, "%s: bad raised IRQ %d ctpr %d ivpr 0x%08x\n",
+        error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
                 __func__, irq, dst->ctpr, src->ivpr);
         openpic_update_irq(opp, irq);
         retval =3D opp->spve;
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index fa83420254..60c784ae86 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -150,8 +150,8 @@ static void kvm_openpic_region_add(MemoryListener *list=
ener,
=20
     ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
-        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
-                strerror(errno), reg_base);
+        error_report("%s: %s %" PRIx64 "", __func__,
+                     strerror(errno), reg_base);
     }
 }
=20
@@ -184,8 +184,8 @@ static void kvm_openpic_region_del(MemoryListener *list=
ener,
=20
     ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
-        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
-                strerror(errno), reg_base);
+        error_report("%s: %s %" PRIx64 "", __func__,
+                     strerror(errno), reg_base);
     }
 }
=20
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 7ead17ac3e..3774b1a2f0 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -83,7 +83,7 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
     rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     if (rc) {
-        fprintf(stderr, "flic: couldn't enable pfault\n");
+        error_report("flic: couldn't enable pfault");
     }
 }
=20
@@ -97,7 +97,7 @@ static void flic_disable_wait_pfault(KVMS390FLICState *fl=
ic)
     rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     if (rc) {
-        fprintf(stderr, "flic: couldn't disable pfault\n");
+        error_report("flic: couldn't disable pfault");
     }
 }
=20
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index b27babd504..81c62920de 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index abab3bba4f..8c0535d3dd 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -28,6 +28,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
@@ -194,8 +195,8 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
=20
     if (ibe->outlen) {
         /* We already have a command queued.  Shouldn't ever happen. */
-        fprintf(stderr, "IPMI KCS: Got command when not finished with the"
-                " previous command\n");
+        error_report("IPMI KCS: Got command when not finished with the"
+                     " previous command");
         abort();
     }
=20
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 348e0eab9d..0f2e426d02 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "monitor/monitor.h"
@@ -186,15 +187,15 @@ ISADevice *isa_vga_init(ISABus *bus)
     case VGA_CIRRUS:
         return isa_create_simple(bus, "isa-cirrus-vga");
     case VGA_QXL:
-        fprintf(stderr, "%s: qxl: no PCI bus\n", __func__);
+        error_report("%s: qxl: no PCI bus", __func__);
         return NULL;
     case VGA_STD:
         return isa_create_simple(bus, "isa-vga");
     case VGA_VMWARE:
-        fprintf(stderr, "%s: vmware_vga: no PCI bus\n", __func__);
+        error_report("%s: vmware_vga: no PCI bus", __func__);
         return NULL;
     case VGA_VIRTIO:
-        fprintf(stderr, "%s: virtio-vga: no PCI bus\n", __func__);
+        error_report("%s: virtio-vga: no PCI bus", __func__);
         return NULL;
     case VGA_NONE:
     default:
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b0bb3ef58a..d739acf476 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -152,7 +153,7 @@ static void lm32_evr_init(MachineState *machine)
         }
=20
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
@@ -250,7 +251,7 @@ static void lm32_uclinux_init(MachineState *machine)
         }
=20
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 4db4d2d533..caa6cf4e0f 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -149,7 +150,7 @@ milkymist_init(MachineState *machine)
=20
     /* if no kernel is given no valid bios rom is a fatal error */
     if (!kernel_filename && !dinfo && !bios_filename && !qtest_enabled()) =
{
-        fprintf(stderr, "qemu: could not load Milkymist One bios '%s'\n",
+        error_report("qemu: could not load Milkymist One bios '%s'",
                 bios_name);
         exit(1);
     }
@@ -188,7 +189,7 @@ milkymist_init(MachineState *machine)
         }
=20
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 9002c460e5..bdab620a02 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -66,7 +66,7 @@ static void an5206_init(MachineState *machine)
         if (qtest_enabled()) {
             return;
         }
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
=20
@@ -83,7 +83,7 @@ static void an5206_init(MachineState *machine)
         entry =3D KERNEL_LOAD_ADDR;
     }
     if (kernel_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filen=
ame);
+        error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
=20
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b81901fdfd..fbf3f0f074 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -220,7 +221,7 @@ static void m5206_mbar_update(m5206_mbar_state *s)
                 break;
             default:
                 /* Unknown vector.  */
-                fprintf(stderr, "Unhandled vector for IRQ %d\n", irq);
+                error_report("Unhandled vector for IRQ %d", irq);
                 vector =3D 0xf;
                 break;
             }
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b9dde75106..2fb5037b72 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -257,7 +258,7 @@ static void mcf5208evb_init(MachineState *machine)
     mcf5208_sys_init(address_space_mem, pic);
=20
     if (nb_nics > 1) {
-        fprintf(stderr, "Too many NICs\n");
+        error_report("Too many NICs");
         exit(1);
     }
     if (nd_table[0].used) {
@@ -292,7 +293,7 @@ static void mcf5208evb_init(MachineState *machine)
         if (qtest_enabled()) {
             return;
         }
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
=20
@@ -309,7 +310,7 @@ static void mcf5208evb_init(MachineState *machine)
         entry =3D 0x40000000;
     }
     if (kernel_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filen=
ame);
+        error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
=20
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 457a08a2fe..31466050de 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -86,7 +86,7 @@ static int microblaze_load_dtb(hwaddr addr,
         r =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                     kernel_cmdline);
         if (r < 0) {
-            fprintf(stderr, "couldn't set /chosen/bootargs\n");
+            error_report("couldn't set /chosen/bootargs");
         }
     }
=20
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 776ee283e1..ee82968ea7 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -353,7 +353,7 @@ static const void *boston_fdt_filter(void *opaque, cons=
t void *fdt_orig,
=20
     err =3D fdt_open_into(fdt_orig, fdt, fdt_sz);
     if (err) {
-        fprintf(stderr, "unable to open FDT\n");
+        error_report("unable to open FDT");
         return NULL;
     }
=20
@@ -361,7 +361,7 @@ static const void *boston_fdt_filter(void *opaque, cons=
t void *fdt_orig,
             ? machine->kernel_cmdline : " ";
     err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     if (err < 0) {
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
         return NULL;
     }
=20
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 75318680e1..34710a466c 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -143,7 +143,7 @@ static int64_t load_kernel (CPUMIPSState *env)
                                      initrd_offset, ram_size - initrd_offs=
et);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
+            error_report("qemu: could not load initial ram disk '%s'",
                     loaderparams.initrd_filename);
             exit(1);
         }
@@ -342,7 +342,7 @@ static void mips_fulong2e_init(MachineState *machine)
=20
     isa_bus =3D vt82c686b_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 0));
     if (!isa_bus) {
-        fprintf(stderr, "vt82c686b_init error\n");
+        error_report("vt82c686b_init error");
         exit(1);
     }
=20
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7e6626dc88..6c91a940be 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -271,10 +271,10 @@ static void mips_jazz_init(MachineState *machine,
             sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
             break;
         } else if (is_help_option(nd->model)) {
-            fprintf(stderr, "qemu: Supported NICs: dp83932\n");
+            error_report("qemu: Supported NICs: dp83932");
             exit(1);
         } else {
-            fprintf(stderr, "qemu: Unsupported NIC: %s\n", nd->model);
+            error_report("qemu: Unsupported NIC: %s", nd->model);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 2adb9bcf89..d457adfa69 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -856,8 +856,8 @@ static int64_t load_kernel (void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index a092072e2a..a3d9406610 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -101,8 +101,8 @@ static int64_t load_kernel(void)
                 initrd_offset, loaderparams.ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1272d4ef9d..e54ce918a7 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -121,8 +121,8 @@ static int64_t load_kernel(void)
                                               ram_size - initrd_offset);
         }
         if (initrd_size =3D=3D (target_ulong) -1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loaderparams.initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
             exit(1);
         }
     }
@@ -246,7 +246,7 @@ void mips_r4k_init(MachineState *machine)
                                    blk_by_legacy_dinfo(dinfo),
                                    sector_len, mips_rom / sector_len,
                                    4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory.\n");
+            error_report("qemu: Error registering flash memory.");
 	}
     } else if (!qtest_enabled()) {
         /* not fatal */
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 3e8ad8cd73..21b8e49b6c 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/misc/a9scu.h"
=20
 static uint64_t a9_scu_read(void *opaque, hwaddr offset,
@@ -59,7 +60,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
         mask =3D 0xffffffff;
         break;
     default:
-        fprintf(stderr, "Invalid size %u in write to a9 scu register %x\n"=
,
+        error_report("Invalid size %u in write to a9 scu register %x",
                 size, (unsigned)offset);
         return;
     }
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 84f9e4c612..e3b30e90ea 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -19,6 +19,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/block/flash.h"
 #include "hw/arm/omap.h"
@@ -408,7 +409,7 @@ static void omap_gpmc_cs_map(struct omap_gpmc_s *s, int=
 cs)
     /* TODO: check for overlapping regions and report access errors */
     if (mask !=3D 0x8 && mask !=3D 0xc && mask !=3D 0xe && mask !=3D 0xf
          && !(s->accept_256 && !mask)) {
-        fprintf(stderr, "%s: invalid chip-select mask address (0x%x)\n",
+        error_report("%s: invalid chip-select mask address (0x%x)",
                  __func__, mask);
     }
=20
@@ -642,7 +643,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
=20
     case 0x010:	/* GPMC_SYSCONFIG */
         if ((value >> 3) =3D=3D 0x3)
-            fprintf(stderr, "%s: bad SDRAM idle mode %"PRIi64"\n",
+            error_report("%s: bad SDRAM idle mode %"PRIi64"",
                             __func__, value >> 3);
         if (value & 2)
             omap_gpmc_reset(s);
@@ -806,7 +807,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
         break;
     case 0x230:	/* GPMC_TESTMODE_CTRL */
         if (value & 7)
-            fprintf(stderr, "%s: test mode enable attempt\n", __func__);
+            error_report("%s: test mode enable attempt", __func__);
         break;
=20
     default:
@@ -864,7 +865,7 @@ void omap_gpmc_attach(struct omap_gpmc_s *s, int cs, Me=
moryRegion *iomem)
     assert(iomem);
=20
     if (cs < 0 || cs >=3D 8) {
-        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
+        error_report("%s: bad chip-select %i", __func__, cs);
         exit(-1);
     }
     f =3D &s->cs_file[cs];
@@ -881,7 +882,7 @@ void omap_gpmc_attach_nand(struct omap_gpmc_s *s, int c=
s, DeviceState *nand)
     assert(nand);
=20
     if (cs < 0 || cs >=3D 8) {
-        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
+        error_report("%s: bad chip-select %i", __func__, cs);
         exit(-1);
     }
     f =3D &s->cs_file[cs];
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index 96fc057b4e..47d9c10aeb 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
=20
@@ -126,7 +127,7 @@ struct omap_target_agent_s *omap_l4ta_get(struct omap_l=
4_s *bus,
             break;
         }
     if (!ta) {
-        fprintf(stderr, "%s: bad target agent (%i)\n", __func__, cs);
+        error_report("%s: bad target agent (%i)", __func__, cs);
         exit(-1);
     }
=20
@@ -151,7 +152,7 @@ hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
     hwaddr base;
=20
     if (region < 0 || region >=3D ta->regions) {
-        fprintf(stderr, "%s: bad io region (%i)\n", __func__, region);
+        error_report("%s: bad io region (%i)", __func__, region);
         exit(-1);
     }
=20
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index 7b38c5568c..3dcabc1e00 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
=20
@@ -108,7 +109,7 @@ static void omap_sdrc_write(void *opaque, hwaddr addr,
=20
     case 0x10:	/* SDRC_SYSCONFIG */
         if ((value >> 3) !=3D 0x2)
-            fprintf(stderr, "%s: bad SDRAM idle mode %i\n",
+            error_report("%s: bad SDRAM idle mode %i",
                     __func__, (unsigned)value >> 3);
         if (value & 2)
             omap_sdrc_reset(s);
diff --git a/hw/misc/vmport.c b/hw/misc/vmport.c
index 165500223f..55369bd180 100644
--- a/hw/misc/vmport.c
+++ b/hw/misc/vmport.c
@@ -80,7 +80,7 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr a=
ddr,
     if (!s->func[command])
     {
 #ifdef VMPORT_DEBUG
-        fprintf(stderr, "vmport: unknown command %x\n", command);
+        error_report("vmport: unknown command %x", command);
 #endif
         return eax;
     }
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 5ea8dd3a93..5916f86c68 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -61,7 +62,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *load=
er_params)
                            0, 0);
=20
     if (kernel_size <=3D 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
+        error_report("qemu: could not load kernel '%s'",
                 loader_params->kernel_filename);
         exit(1);
     }
@@ -85,8 +86,8 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *load=
er_params)
                                               ram_size);
         }
         if (initrd_size =3D=3D (target_ulong)-1) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    loader_params->initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         loader_params->initrd_filename);
             exit(1);
         }
     }
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 9da1932970..965effa314 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -347,7 +347,7 @@ static ssize_t etsec_receive(NetClientState *nc,
     eTSEC *etsec =3D qemu_get_nic_opaque(nc);
=20
 #if defined(HEX_DUMP)
-    fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
+    error_report("%s receive size:%zd", nc->name, size);
     qemu_hexdump((void *)buf, stderr, "", size);
 #endif
     /* Flush is unnecessary as are already in receiving path */
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 654455355f..5f2b5fe046 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1070,7 +1070,7 @@ ssize_t pcnet_receive(NetClientState *nc, const uint8=
_t *buf, size_t size_)
             if (!s->looptest) {
                 if (size > 4092) {
 #ifdef PCNET_DEBUG_RMD
-                    fprintf(stderr, "pcnet: truncates rx packet.\n");
+                    error_report("pcnet: truncates rx packet.");
 #endif
                     size =3D 4092;
                 }
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3b16dcf5a1..ae40fd6e6e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/devices.h"
@@ -362,9 +363,9 @@ static void smc91c111_writeb(void *opaque, hwaddr offse=
t,
             return;
         case 12: /* Control */
             if (value & 1)
-                fprintf(stderr, "smc91c111:EEPROM store not implemented\n"=
);
+                error_report("smc91c111:EEPROM store not implemented");
             if (value & 2)
-                fprintf(stderr, "smc91c111:EEPROM reload not implemented\n=
");
+                error_report("smc91c111:EEPROM reload not implemented");
             value &=3D ~3;
             SET_LOW(ctr, value);
             return;
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63a3..37d0cce560 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -135,7 +135,7 @@ static int vhost_net_get_fd(NetClientState *backend)
     case NET_CLIENT_DRIVER_TAP:
         return tap_get_fd(backend);
     default:
-        fprintf(stderr, "vhost-net requires tap backend\n");
+        error_report("vhost-net requires tap backend");
         return -EBADFD;
     }
 }
@@ -148,7 +148,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *optio=
ns)
     uint64_t features =3D 0;
=20
     if (!options->net_backend) {
-        fprintf(stderr, "vhost-net requires net backend to be setup\n");
+        error_report("vhost-net requires net backend to be setup");
         goto fail;
     }
     net->nc =3D options->net_backend;
@@ -186,8 +186,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *optio=
ns)
             net->dev.features &=3D ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
         }
         if (~net->dev.features & net->dev.backend_features) {
-            fprintf(stderr, "vhost lacks feature mask %" PRIu64
-                   " for backend\n",
+            error_report("vhost lacks feature mask %" PRIu64
+                   " for backend",
                    (uint64_t)(~net->dev.features & net->dev.backend_featur=
es));
             goto fail;
         }
@@ -197,8 +197,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *optio=
ns)
     if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) {
         features =3D vhost_user_get_acked_features(net->nc);
         if (~net->dev.features & features) {
-            fprintf(stderr, "vhost lacks feature mask %" PRIu64
-                    " for backend\n",
+            error_report("vhost lacks feature mask %" PRIu64
+                    " for backend",
                     (uint64_t)(~net->dev.features & features));
             goto fail;
         }
@@ -349,7 +349,7 @@ err_start:
     }
     e =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (e < 0) {
-        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
+        error_report("vhost guest notifier cleanup failed: %d", e);
         fflush(stderr);
     }
 err:
@@ -370,7 +370,7 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *=
ncs,
=20
     r =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (r < 0) {
-        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
+        error_report("vhost guest notifier cleanup failed: %d", r);
         fflush(stderr);
     }
     assert(r >=3D 0);
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 2b31f5b844..c896e8007b 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -96,7 +96,7 @@ static int nios2_load_dtb(struct nios2_boot_info bi, cons=
t uint32_t ramsize,
         r =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                     kernel_cmdline);
         if (r < 0) {
-            fprintf(stderr, "couldn't set /chosen/bootargs\n");
+            error_report("couldn't set /chosen/bootargs");
         }
     }
=20
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 2fd0e3c29f..5cad031eba 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -36,6 +36,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/nvram/eeprom93xx.h"
=20
@@ -105,8 +106,8 @@ static int get_uint16_from_uint8(QEMUFile *f, void *pv,=
 size_t size,
 static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
                       QJSON *vmdesc)
 {
-    fprintf(stderr, "uint16_from_uint8 is used only for backwards compatib=
ility.\n");
-    fprintf(stderr, "Never should be used to write a new state.\n");
+    error_report("uint16_from_uint8 is used only for backwards compatibili=
ty.");
+    error_report("Never should be used to write a new state.");
     exit(0);
=20
     return 0;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e3bd626b8c..cf9a816c0e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -515,8 +515,8 @@ static int get_uint32_as_uint16(QEMUFile *f, void *pv, =
size_t size,
 static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
                       QJSON *vmdesc)
 {
-    fprintf(stderr, "uint32_as_uint16 is only used for backward compatibil=
ity.\n");
-    fprintf(stderr, "This functions shouldn't be called.\n");
+    error_report("uint32_as_uint16 is only used for backward compatibility=
.");
+    error_report("This functions shouldn't be called.");
=20
     return 0;
 }
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 86bf2849c4..44a6d115dd 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -87,7 +88,7 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
         }
=20
         if (kernel_size < 0) {
-            fprintf(stderr, "QEMU: couldn't load the kernel '%s'\n",
+            error_report("QEMU: couldn't load the kernel '%s'",
                     kernel_filename);
             exit(1);
         }
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1767d2af61..48fef86c05 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -38,7 +38,7 @@
  */
=20
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
@@ -449,8 +449,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque, hw=
addr addr)
     regno =3D (cfgaddr & BONITO_PCICONF_REG_MASK) >> BONITO_PCICONF_REG_OF=
FSET;
=20
     if (idsel =3D=3D 0) {
-        fprintf(stderr, "error in bonito pci config address " TARGET_FMT_p=
lx
-            ",pcimap_cfg=3D%x\n", addr, s->regs[BONITO_PCIMAP_CFG]);
+        error_report("error in bonito pci config address " TARGET_FMT_plx
+            ",pcimap_cfg=3D%x", addr, s->regs[BONITO_PCIMAP_CFG]);
         exit(1);
     }
     pciaddr =3D PCI_ADDR(pci_bus_num(phb->bus), devno, funno, regno);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88eba..1c8395d319 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -515,7 +515,7 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, siz=
e_t size,
     for (i =3D 0; i < PCI_NUM_PINS; ++i) {
         irq_state[i] =3D qemu_get_be32(f);
         if (irq_state[i] !=3D 0x1 && irq_state[i] !=3D 0) {
-            fprintf(stderr, "irq state %d: must be 0 or 1.\n",
+            error_report("irq state %d: must be 0 or 1.",
                     irq_state[i]);
             return -EINVAL;
         }
@@ -678,7 +678,7 @@ static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *r=
oot,
     unsigned slot;
=20
     if (!root) {
-        fprintf(stderr, "No primary PCI bus\n");
+        error_report("No primary PCI bus");
         return NULL;
     }
=20
@@ -694,7 +694,7 @@ static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *r=
oot,
     }
=20
     if (dom !=3D 0) {
-        fprintf(stderr, "No support for non-zero PCI domains\n");
+        error_report("No support for non-zero PCI domains");
         return NULL;
     }
=20
@@ -1118,8 +1118,8 @@ void pci_register_bar(PCIDevice *pci_dev, int region_=
num,
     assert(region_num >=3D 0);
     assert(region_num < PCI_NUM_REGIONS);
     if (size & (size-1)) {
-        fprintf(stderr, "ERROR: PCI region size must be pow2 "
-                    "type=3D0x%x, size=3D0x%"FMT_PCIBUS"\n", type, size);
+        error_report("ERROR: PCI region size must be pow2 "
+                    "type=3D0x%x, size=3D0x%"FMT_PCIBUS"", type, size);
         exit(1);
     }
=20
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index db0e49ab8f..8a5350161f 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -333,13 +333,13 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
         ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start"=
,
                                     initrd_base);
         if (ret < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+            error_report("couldn't set /chosen/linux,initrd-start");
         }
=20
         ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
                                     (initrd_base + initrd_size));
         if (ret < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+            error_report("couldn't set /chosen/linux,initrd-end");
         }
=20
     }
@@ -353,7 +353,7 @@ static int ppce500_load_device_tree(MachineState *machi=
ne,
     ret =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                       machine->kernel_cmdline);
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
=20
     if (kvm_enabled()) {
         /* Read out host's frequencies */
@@ -720,7 +720,7 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Params=
 *params,
=20
     CPU_FOREACH(cs) {
         if (kvm_openpic_connect_vcpu(dev, cs)) {
-            fprintf(stderr, "%s: failed to connect vcpu to irqchip\n",
+            error_report("%s: failed to connect vcpu to irqchip",
                     __func__);
             abort();
         }
@@ -821,7 +821,7 @@ void ppce500_init(MachineState *machine, PPCE500Params =
*params)
         cs =3D CPU(cpu);
=20
         if (env->mmu_model !=3D POWERPC_MMU_BOOKE206) {
-            fprintf(stderr, "MMU model %i not supported by this machine.\n=
",
+            error_report("MMU model %i not supported by this machine.",
                 env->mmu_model);
             exit(1);
         }
@@ -967,7 +967,7 @@ void ppce500_init(MachineState *machine, PPCE500Params =
*params)
                                           cur_base,
                                           ram_size - cur_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     machine->kernel_filename);
             exit(1);
         }
@@ -982,8 +982,8 @@ void ppce500_init(MachineState *machine, PPCE500Params =
*params)
                                           ram_size - initrd_base);
=20
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n"=
,
-                    machine->initrd_filename);
+            error_report("qemu: could not load initial ram disk '%s'",
+                         machine->initrd_filename);
             exit(1);
         }
=20
@@ -1024,7 +1024,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
         kernel_size =3D load_uimage(filename, &bios_entry, &loadaddr, NULL=
,
                                   NULL, NULL);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load firmware '%s'\n", filena=
me);
+            error_report("qemu: could not load firmware '%s'", filename);
             exit(1);
         }
     }
@@ -1037,7 +1037,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
                                        initrd_base, initrd_size,
                                        kernel_base, kernel_size);
     if (dt_size < 0) {
-        fprintf(stderr, "couldn't load device tree\n");
+        error_report("couldn't load device tree");
         exit(1);
     }
     assert(dt_size < DTB_MAX_SIZE);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 33b46cb50b..c0edf22352 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -283,7 +283,7 @@ static void ppc_core99_init(MachineState *machine)
             }
         }
         if (ppc_boot_device =3D=3D '\0') {
-            fprintf(stderr, "No valid boot device for Mac99 machine\n");
+            error_report("No valid boot device for Mac99 machine");
             exit(1);
         }
     }
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 193b9047d9..02f03650af 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -226,7 +226,7 @@ static void ppc_heathrow_init(MachineState *machine)
 #endif
         }
         if (ppc_boot_device =3D=3D '\0') {
-            fprintf(stderr, "No valid boot device for G3 Beige machine\n")=
;
+            error_report("No valid boot device for G3 Beige machine");
             exit(1);
         }
     }
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index ce1254b5d4..3a2c49e3fd 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -83,7 +84,7 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr ad=
dr,
         value =3D env->spr[SPR_E500_SVR];
         break;
     default:
-        fprintf(stderr, "guts: Unknown register read: %x\n", (int)addr);
+        error_report("guts: Unknown register read: %x", (int)addr);
         break;
     }
=20
@@ -102,7 +103,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr add=
r,
         }
         break;
     default:
-        fprintf(stderr, "guts: Unknown register write: %x =3D %x\n",
+        error_report("guts: Unknown register write: %x =3D %x",
                 (int)addr, (unsigned)value);
         break;
     }
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c66a..0a31a1c116 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -324,7 +324,7 @@ static void ref405ep_init(MachineState *machine)
         kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
                                           ram_size - kernel_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
@@ -336,8 +336,8 @@ static void ref405ep_init(MachineState *machine)
             initrd_size =3D load_image_targphys(initrd_filename, initrd_ba=
se,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("qemu: could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         } else {
@@ -607,7 +607,7 @@ static void taihu_405ep_init(MachineState *machine)
         kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
                                           ram_size - kernel_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f92d47f28d..77b74dfe9e 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "net/net.h"
 #include "hw/hw.h"
@@ -80,22 +81,22 @@ static int bamboo_load_device_tree(hwaddr addr,
     ret =3D qemu_fdt_setprop(fdt, "/memory", "reg", mem_reg_property,
                            sizeof(mem_reg_property));
     if (ret < 0)
-        fprintf(stderr, "couldn't set /memory/reg\n");
+        error_report("couldn't set /memory/reg");
=20
     ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
                                 initrd_base);
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+        error_report("couldn't set /chosen/linux,initrd-start");
=20
     ret =3D qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
                                 (initrd_base + initrd_size));
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+        error_report("couldn't set /chosen/linux,initrd-end");
=20
     ret =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                   kernel_cmdline);
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
=20
     /* Copy data from the host device tree into the guest. Since the guest=
 can
      * directly access the timebase without host involvement, we must expo=
se
@@ -190,7 +191,7 @@ static void bamboo_init(MachineState *machine)
     env =3D &cpu->env;
=20
     if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
-        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+        error_report("MMU model %i not supported by this machine.",
             env->mmu_model);
         exit(1);
     }
@@ -224,7 +225,7 @@ static void bamboo_init(MachineState *machine)
                                 NULL);
     pcibus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pcibus) {
-        fprintf(stderr, "couldn't create PCI controller!\n");
+        error_report("couldn't create PCI controller!");
         exit(1);
     }
=20
@@ -265,7 +266,7 @@ static void bamboo_init(MachineState *machine)
         }
         /* XXX try again as binary */
         if (success < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
@@ -277,7 +278,7 @@ static void bamboo_init(MachineState *machine)
                                           ram_size - RAMDISK_ADDR);
=20
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load ram disk '%s' at %x\n",
+            error_report("qemu: could not load ram disk '%s' at %x",
                     initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
@@ -287,7 +288,7 @@ static void bamboo_init(MachineState *machine)
     if (kernel_filename) {
         if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
                                     initrd_size, kernel_cmdline) < 0) {
-            fprintf(stderr, "couldn't load device tree\n");
+            error_report("couldn't load device tree");
             exit(1);
         }
     }
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 6953f8b9ac..0b91d22253 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -20,6 +20,7 @@
  * 4xx SoCs, such as the 440EP. */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
@@ -254,7 +255,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq_nu=
m, int level)
=20
     trace_ppc4xx_pci_set_irq(irq_num);
     if (irq_num < 0) {
-        fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
+        error_report("%s: PCI irq %d", __func__, irq_num);
         return;
     }
     qemu_set_irq(pci_irqs[irq_num], level);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 94138a4e8c..7551d53fa5 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -576,7 +576,7 @@ static void ppc_prep_init(MachineState *machine)
             }
         }
         if (ppc_boot_device =3D=3D '\0') {
-            fprintf(stderr, "No valid boot device for Mac99 machine\n");
+            error_report("No valid boot device for Mac99 machine");
             exit(1);
         }
     }
@@ -597,7 +597,7 @@ static void ppc_prep_init(MachineState *machine)
     qdev_init_nofail(dev);
     pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (pci_bus =3D=3D NULL) {
-        fprintf(stderr, "Couldn't create PCI host controller.\n");
+        error_report("Couldn't create PCI host controller.");
         exit(1);
     }
     sysctrl->contiguous_map_irq =3D qdev_get_gpio_in(dev, 0);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index ed9b406fd3..7641737f81 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -187,7 +187,7 @@ static int xilinx_load_device_tree(hwaddr addr,
=20
     r =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", kernel_cmdli=
ne);
     if (r < 0)
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
     cpu_physical_memory_write(addr, fdt, fdt_size);
     return fdt_size;
 }
@@ -219,7 +219,7 @@ static void virtex_init(MachineState *machine)
     env =3D &cpu->env;
=20
     if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
-        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+        error_report("MMU model %i not supported by this machine.",
             env->mmu_model);
         exit(1);
     }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index ff1bb1534c..d3c46bc01f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -466,7 +466,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                  * passes us zeroes for those we don't support.
                  */
                 if (features.features) {
-                    fprintf(stderr, "Guest bug: features[%i]=3D%x (expecte=
d 0)\n",
+                    error_report("Guest bug: features[%i]=3D%x (expected 0=
)",
                             features.index, features.features);
                     /* XXX: do a unit check here? */
                 }
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 3e56ab267c..3e2b24e67d 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -14,7 +14,7 @@
  */
=20
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
@@ -1501,7 +1501,7 @@ again:
            This is apparently sufficient to beat the drivers into submissi=
on.
          */
         if (!(s->sien0 & LSI_SIST0_UDC))
-            fprintf(stderr, "inf. loop with UDC masked\n");
+            error_report("inf. loop with UDC masked");
         lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
         lsi_disconnect(s);
     } else if (s->istat1 & LSI_ISTAT1_SRUN && !s->waiting) {
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 360db53ac8..8c4eabcf3d 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -32,6 +32,7 @@
  *  - Maybe do autosense (PAPR seems to mandate it, linux doesn't care)
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -179,7 +180,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *req,
     rc =3D spapr_vio_dma_write(&s->vdev, req->crq.s.IU_data_ptr,
                              &req->iu, length);
     if (rc) {
-        fprintf(stderr, "vscsi_send_iu: DMA write failure !\n");
+        error_report("vscsi_send_iu: DMA write failure !");
     }
=20
     req->crq.s.valid =3D 0x80;
@@ -197,7 +198,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *req,
=20
     rc1 =3D spapr_vio_send_crq(&s->vdev, req->crq.raw);
     if (rc1) {
-        fprintf(stderr, "vscsi_send_iu: Error sending response\n");
+        error_report("vscsi_send_iu: Error sending response");
         return rc1;
     }
=20
@@ -330,7 +331,7 @@ static int vscsi_fetch_desc(VSCSIState *s, struct vscsi=
_req *req,
         break;
     }
     default:
-        fprintf(stderr, "VSCSI:   Unknown format %x\n", req->dma_fmt);
+        error_report("VSCSI:   Unknown format %x", req->dma_fmt);
         return -1;
     }
=20
@@ -518,7 +519,7 @@ static void vscsi_transfer_data(SCSIRequest *sreq, uint=
32_t len)
=20
     trace_spapr_vscsi_transfer_data(sreq->tag, len, req);
     if (req =3D=3D NULL) {
-        fprintf(stderr, "VSCSI: Can't find request for tag 0x%x\n", sreq->=
tag);
+        error_report("VSCSI: Can't find request for tag 0x%x", sreq->tag);
         return;
     }
=20
@@ -527,7 +528,7 @@ static void vscsi_transfer_data(SCSIRequest *sreq, uint=
32_t len)
         rc =3D vscsi_srp_transfer_data(s, req, req->writing, buf, len);
     }
     if (rc < 0) {
-        fprintf(stderr, "VSCSI: RDMA error rc=3D%d!\n", rc);
+        error_report("VSCSI: RDMA error rc=3D%d!", rc);
         req->dma_error =3D true;
         scsi_req_cancel(req->sreq);
         return;
@@ -547,7 +548,7 @@ static void vscsi_command_complete(SCSIRequest *sreq, u=
int32_t status, size_t re
=20
     trace_spapr_vscsi_command_complete(sreq->tag, status, req);
     if (req =3D=3D NULL) {
-        fprintf(stderr, "VSCSI: Can't find request for tag 0x%x\n", sreq->=
tag);
+        error_report("VSCSI: Can't find request for tag 0x%x", sreq->tag);
         return;
     }
=20
@@ -639,7 +640,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIReques=
t *sreq)
     memset(req, 0, sizeof(*req));
     rc =3D vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
     if (rc) {
-        fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->ta=
g);
+        error_report("VSCSI: failed loading request tag#%u", sreq->tag);
         return NULL;
     }
     assert(req->active);
@@ -827,7 +828,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_=
req *req)
     uint64_t tag =3D iu->srp.rsp.tag;
     uint8_t sol_not =3D iu->srp.cmd.sol_not;
=20
-    fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
+    error_report("vscsi_process_tsk_mgmt %02x",
             iu->srp.tsk_mgmt.tsk_mgmt_func);
=20
     d =3D vscsi_device_find(&s->bus, be64_to_cpu(req->iu.srp.tsk_mgmt.lun)=
, &lun);
@@ -932,10 +933,10 @@ static int vscsi_handle_srp_req(VSCSIState *s, vscsi_=
req *req)
     case SRP_CRED_RSP:
     case SRP_AER_REQ:
     case SRP_AER_RSP:
-        fprintf(stderr, "VSCSI: Unsupported opcode %02x\n", opcode);
+        error_report("VSCSI: Unsupported opcode %02x", opcode);
         break;
     default:
-        fprintf(stderr, "VSCSI: Unknown type %02x\n", opcode);
+        error_report("VSCSI: Unknown type %02x", opcode);
     }
=20
     return done;
@@ -953,7 +954,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi=
_req *req)
     rc =3D spapr_vio_dma_read(&s->vdev, be64_to_cpu(sinfo->buffer),
                             &info, be16_to_cpu(sinfo->common.length));
     if (rc) {
-        fprintf(stderr, "vscsi_send_adapter_info: DMA read failure !\n");
+        error_report("vscsi_send_adapter_info: DMA read failure !");
     }
 #endif
     memset(&info, 0, sizeof(info));
@@ -967,7 +968,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi=
_req *req)
     rc =3D spapr_vio_dma_write(&s->vdev, be64_to_cpu(sinfo->buffer),
                              &info, be16_to_cpu(sinfo->common.length));
     if (rc)  {
-        fprintf(stderr, "vscsi_send_adapter_info: DMA write failure !\n");
+        error_report("vscsi_send_adapter_info: DMA write failure !");
     }
=20
     sinfo->common.status =3D rc ? cpu_to_be32(1) : 0;
@@ -987,7 +988,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vscsi=
_req *req)
     req_len =3D len =3D be16_to_cpu(vcap->common.length);
     buffer =3D be64_to_cpu(vcap->buffer);
     if (len > sizeof(cap)) {
-        fprintf(stderr, "vscsi_send_capabilities: capabilities size mismat=
ch !\n");
+        error_report("vscsi_send_capabilities: capabilities size mismatch =
!");
=20
         /*
          * Just read and populate the structure that is known.
@@ -997,7 +998,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vscsi=
_req *req)
     }
     rc =3D spapr_vio_dma_read(&s->vdev, buffer, &cap, len);
     if (rc)  {
-        fprintf(stderr, "vscsi_send_capabilities: DMA read failure !\n");
+        error_report("vscsi_send_capabilities: DMA read failure !");
     }
=20
     /*
@@ -1013,7 +1014,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vsc=
si_req *req)
=20
     rc =3D spapr_vio_dma_write(&s->vdev, buffer, &cap, len);
     if (rc)  {
-        fprintf(stderr, "vscsi_send_capabilities: DMA write failure !\n");
+        error_report("vscsi_send_capabilities: DMA write failure !");
     }
     if (req_len > len) {
         /*
@@ -1034,11 +1035,11 @@ static int vscsi_handle_mad_req(VSCSIState *s, vscs=
i_req *req)
=20
     switch (be32_to_cpu(mad->empty_iu.common.type)) {
     case VIOSRP_EMPTY_IU_TYPE:
-        fprintf(stderr, "Unsupported EMPTY MAD IU\n");
+        error_report("Unsupported EMPTY MAD IU");
         retlen =3D sizeof(mad->empty_iu);
         break;
     case VIOSRP_ERROR_LOG_TYPE:
-        fprintf(stderr, "Unsupported ERROR LOG MAD IU\n");
+        error_report("Unsupported ERROR LOG MAD IU");
         retlen =3D sizeof(mad->error_log);
         break;
     case VIOSRP_ADAPTER_INFO_TYPE:
@@ -1053,7 +1054,7 @@ static int vscsi_handle_mad_req(VSCSIState *s, vscsi_=
req *req)
         request_handled =3D true;
         break;
     default:
-        fprintf(stderr, "VSCSI: Unknown MAD type %02x\n",
+        error_report("VSCSI: Unknown MAD type %02x",
                 be32_to_cpu(mad->empty_iu.common.type));
         /*
          * PAPR+ says that "The length field is set to the length
@@ -1078,7 +1079,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
q *crq)
=20
     req =3D vscsi_get_req(s);
     if (req =3D=3D NULL) {
-        fprintf(stderr, "VSCSI: Failed to get a request !\n");
+        error_report("VSCSI: Failed to get a request !");
         return;
     }
=20
@@ -1088,7 +1089,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
q *crq)
      * of the structure.
      */
     if (crq->s.IU_length > sizeof(union viosrp_iu)) {
-        fprintf(stderr, "VSCSI: SRP IU too long (%d bytes) !\n",
+        error_report("VSCSI: SRP IU too long (%d bytes) !",
                 crq->s.IU_length);
         vscsi_put_req(req);
         return;
@@ -1097,7 +1098,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_cr=
q *crq)
     /* XXX Handle failure differently ? */
     if (spapr_vio_dma_read(&s->vdev, crq->s.IU_data_ptr, &req->iu,
                            crq->s.IU_length)) {
-        fprintf(stderr, "vscsi_got_payload: DMA read failure !\n");
+        error_report("vscsi_got_payload: DMA read failure !");
         vscsi_put_req(req);
         return;
     }
@@ -1158,16 +1159,16 @@ static int vscsi_do_crq(struct VIOsPAPRDevice *dev,=
 uint8_t *crq_data)
         case VIOSRP_AIX_FORMAT:
         case VIOSRP_LINUX_FORMAT:
         case VIOSRP_INLINE_FORMAT:
-            fprintf(stderr, "vscsi_do_srq: Unsupported payload format %02x=
\n",
+            error_report("vscsi_do_srq: Unsupported payload format %02x",
                     crq.s.format);
             break;
         default:
-            fprintf(stderr, "vscsi_do_srq: Unknown payload format %02x\n",
+            error_report("vscsi_do_srq: Unknown payload format %02x",
                     crq.s.format);
         }
         break;
     default:
-        fprintf(stderr, "vscsi_do_crq: unknown CRQ %02x %02x ...\n",
+        error_report("vscsi_do_crq: unknown CRQ %02x %02x ...",
                 crq.raw[0], crq.raw[1]);
     };
=20
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplan=
e.c
index add4b3f4a4..e047361310 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -97,7 +97,7 @@ static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQueu=
e *vq, int n,
     /* Set up virtqueue notify */
     rc =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), n, true);
     if (rc !=3D 0) {
-        fprintf(stderr, "virtio-scsi: Failed to set host notifier (%d)\n",
+        error_report("virtio-scsi: Failed to set host notifier (%d)",
                 rc);
         s->dataplane_fenced =3D true;
         return rc;
@@ -141,8 +141,8 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
     /* Set up guest notifier (irq) */
     rc =3D k->set_guest_notifiers(qbus->parent, vs->conf.num_queues + 2, t=
rue);
     if (rc !=3D 0) {
-        fprintf(stderr, "virtio-scsi: Failed to set guest notifiers (%d), =
"
-                "ensure -enable-kvm is set\n", rc);
+        error_report("virtio-scsi: Failed to set guest notifiers (%d), "
+                "ensure -enable-kvm is set", rc);
         goto fail_guest_notifiers;
     }
=20
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 55c8098ecd..2b878a0c5e 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/sysbus.h"
@@ -146,7 +147,7 @@ static void pl181_fifo_push(PL181State *s, uint32_t val=
ue)
     int n;
=20
     if (s->fifo_len =3D=3D PL181_FIFO_LEN) {
-        fprintf(stderr, "pl181: FIFO overflow\n");
+        error_report("pl181: FIFO overflow");
         return;
     }
     n =3D (s->fifo_pos + s->fifo_len) & (PL181_FIFO_LEN - 1);
@@ -160,7 +161,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
     uint32_t value;
=20
     if (s->fifo_len =3D=3D 0) {
-        fprintf(stderr, "pl181: FIFO underflow\n");
+        error_report("pl181: FIFO underflow");
         return 0;
     }
     value =3D s->fifo[s->fifo_pos];
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff4db..e467d74fc8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -700,7 +700,7 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &=3D ~CARD_IS_LOCKED;
         sd->pwd_len =3D 0;
         /* Erasing the entire card here! */
-        fprintf(stderr, "SD: Card force-erased by CMD42\n");
+        error_report("SD: Card force-erased by CMD42");
         return;
     }
=20
@@ -1282,7 +1282,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_r1;
=20
     case 56:	/* CMD56:  GEN_CMD */
-        fprintf(stderr, "SD: GEN_CMD 0x%08x\n", req.arg);
+        error_report("SD: GEN_CMD 0x%08x", req.arg);
=20
         switch (sd->state) {
         case sd_transfer_state:
@@ -1565,10 +1565,10 @@ send_response:
         int i;
         DPRINTF("Response:");
         for (i =3D 0; i < rsplen; i++)
-            fprintf(stderr, " %02x", response[i]);
-        fprintf(stderr, " state %d\n", sd->state);
+            error_report(" %02x", response[i]);
+        error_report(" state %d", sd->state);
     } else {
-        DPRINTF("No response %d\n", sd->state);
+        DPRINTF("No response %d", sd->state);
     }
 #endif
=20
@@ -1580,14 +1580,14 @@ static void sd_blk_read(SDState *sd, uint64_t addr,=
 uint32_t len)
     DPRINTF("sd_blk_read: addr =3D 0x%08llx, len =3D %d\n",
             (unsigned long long) addr, len);
     if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
-        fprintf(stderr, "sd_blk_read: read error on host side\n");
+        error_report("sd_blk_read: read error on host side");
     }
 }
=20
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
     if (!sd->blk || blk_pwrite(sd->blk, addr, sd->data, len, 0) < 0) {
-        fprintf(stderr, "sd_blk_write: write error on host side\n");
+        error_report("sd_blk_write: write error on host side");
     }
 }
=20
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 16b9ed2db2..a010f559e2 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -319,8 +320,8 @@ static void r2d_init(MachineState *machine)
                                           SDRAM_BASE + LINUX_LOAD_OFFSET,
                                           INITRD_LOAD_OFFSET - LINUX_LOAD_=
OFFSET);
         if (kernel_size < 0) {
-          fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_fil=
ename);
-          exit(1);
+            error_report("qemu: could not load kernel '%s'", kernel_filena=
me);
+            exit(1);
         }
=20
         /* initialization which should be done by firmware */
@@ -339,8 +340,8 @@ static void r2d_init(MachineState *machine)
                                           SDRAM_SIZE - INITRD_LOAD_OFFSET)=
;
=20
         if (initrd_size < 0) {
-          fprintf(stderr, "qemu: could not load initrd '%s'\n", initrd_fil=
ename);
-          exit(1);
+            error_report("qemu: could not load initrd '%s'", initrd_filena=
me);
+            exit(1);
         }
=20
         /* initialization which should be done by firmware */
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 166e4bd947..64ffc4c1d2 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -23,6 +23,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/sysemu.h"
@@ -147,9 +148,9 @@ static void porta_changed(SH7750State * s, uint16_t pre=
v)
     int i, r =3D 0;
=20
 #if 0
-    fprintf(stderr, "porta changed from 0x%04x to 0x%04x\n",
+    error_report("porta changed from 0x%04x to 0x%04x",
 	    prev, porta_lines(s));
-    fprintf(stderr, "pdtra=3D0x%04x, pctra=3D0x%08x\n", s->pdtra, s->pctra=
);
+    error_report("pdtra=3D0x%04x, pctra=3D0x%08x", s->pdtra, s->pctra);
 #endif
     currenta =3D porta_lines(s);
     if (currenta =3D=3D prev)
@@ -200,13 +201,13 @@ static void portb_changed(SH7750State * s, uint16_t p=
rev)
=20
 static void error_access(const char *kind, hwaddr addr)
 {
-    fprintf(stderr, "%s to %s (0x" TARGET_FMT_plx ") not supported\n",
+    error_report("%s to %s (0x" TARGET_FMT_plx ") not supported",
 	    kind, regname(addr), addr);
 }
=20
 static void ignore_access(const char *kind, hwaddr addr)
 {
-    fprintf(stderr, "%s to %s (0x" TARGET_FMT_plx ") ignored\n",
+    error_report("%s to %s (0x" TARGET_FMT_plx ") ignored",
 	    kind, regname(addr), addr);
 }
=20
@@ -326,47 +327,48 @@ static void sh7750_mem_writew(void *opaque, hwaddr ad=
dr,
     uint16_t temp;
=20
     switch (addr) {
-	/* SDRAM controller */
+    /* SDRAM controller */
     case SH7750_BCR2_A7:
         s->bcr2 =3D mem_value;
         return;
     case SH7750_BCR3_A7:
-	if(!has_bcr3_and_bcr4(s))
-	    error_access("word write", addr);
-	s->bcr3 =3D mem_value;
-	return;
+        if (!has_bcr3_and_bcr4(s)) {
+            error_access("word write", addr);
+        }
+        s->bcr3 =3D mem_value;
+        return;
     case SH7750_PCR_A7:
-	s->pcr =3D mem_value;
-	return;
+        s->pcr =3D mem_value;
+        return;
     case SH7750_RTCNT_A7:
     case SH7750_RTCOR_A7:
     case SH7750_RTCSR_A7:
-	ignore_access("word write", addr);
-	return;
-	/* IO ports */
+        ignore_access("word write", addr);
+        return;
+        /* IO ports */
     case SH7750_PDTRA_A7:
-	temp =3D porta_lines(s);
-	s->pdtra =3D mem_value;
-	porta_changed(s, temp);
-	return;
+        temp =3D porta_lines(s);
+        s->pdtra =3D mem_value;
+        porta_changed(s, temp);
+        return;
     case SH7750_PDTRB_A7:
-	temp =3D portb_lines(s);
-	s->pdtrb =3D mem_value;
-	portb_changed(s, temp);
-	return;
+        temp =3D portb_lines(s);
+        s->pdtrb =3D mem_value;
+        portb_changed(s, temp);
+        return;
     case SH7750_RFCR_A7:
-	fprintf(stderr, "Write access to refresh count register\n");
-	s->rfcr =3D mem_value;
-	return;
+        error_report("Write access to refresh count register");
+        s->rfcr =3D mem_value;
+        return;
     case SH7750_GPIOIC_A7:
-	s->gpioic =3D mem_value;
-	if (mem_value !=3D 0) {
-	    fprintf(stderr, "I/O interrupts not implemented\n");
+        s->gpioic =3D mem_value;
+        if (mem_value !=3D 0) {
+            error_report("I/O interrupts not implemented");
             abort();
-	}
-	return;
+        }
+        return;
     default:
-	error_access("word write", addr);
+        error_access("word write", addr);
         abort();
     }
 }
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec2816bf94..d434edec92 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -172,7 +173,7 @@ static void leon3_generic_hw_init(MachineState *machine=
)
     }
=20
     if (bios_size > prom_size) {
-        fprintf(stderr, "qemu: could not load prom '%s': file too big\n",
+        error_report("qemu: could not load prom '%s': file too big",
                 filename);
         exit(1);
     }
@@ -180,11 +181,11 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
     if (bios_size > 0) {
         ret =3D load_image_targphys(filename, 0x00000000, bios_size);
         if (ret < 0 || ret > prom_size) {
-            fprintf(stderr, "qemu: could not load prom '%s'\n", filename);
+            error_report("qemu: could not load prom '%s'", filename);
             exit(1);
         }
     } else if (kernel_filename =3D=3D NULL && !qtest_enabled()) {
-        fprintf(stderr, "Can't read bios image %s\n", filename);
+        error_report("Can't read bios image %s", filename);
         exit(1);
     }
     g_free(filename);
@@ -197,7 +198,7 @@ static void leon3_generic_hw_init(MachineState *machine=
)
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, &entry, NULL=
, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e1bdd4828d..7a2812aaa4 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -261,7 +261,7 @@ static unsigned long sun4m_load_kernel(const char *kern=
el_filename,
                                               KERNEL_LOAD_ADDR,
                                               RAM_size - KERNEL_LOAD_ADDR)=
;
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
@@ -273,8 +273,8 @@ static unsigned long sun4m_load_kernel(const char *kern=
el_filename,
                                               INITRD_LOAD_ADDR,
                                               RAM_size - INITRD_LOAD_ADDR)=
;
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("qemu: could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         }
@@ -688,7 +688,7 @@ static void prom_init(hwaddr addr, const char *bios_nam=
e)
         ret =3D -1;
     }
     if (ret < 0 || ret > PROM_SIZE_MAX) {
-        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
+        error_report("qemu: could not load prom '%s'", bios_name);
         exit(1);
     }
 }
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 9a8d6109d4..60799220f3 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -153,7 +153,7 @@ static void niagara_init(MachineState *machine)
             dinfo->is_default =3D 1;
             rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, =
-1);
         } else {
-            fprintf(stderr, "qemu: could not load ram disk '%s'\n",
+            error_report("qemu: could not load ram disk '%s'",
                     blk_bs(blk)->filename);
             exit(1);
         }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c3280aaf38..070d9b94f9 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -165,7 +166,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_fi=
lename,
                                               RAM_size - KERNEL_LOAD_ADDR)=
;
         }
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
+            error_report("qemu: could not load kernel '%s'",
                     kernel_filename);
             exit(1);
         }
@@ -178,8 +179,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_fi=
lename,
                                                *initrd_addr,
                                                RAM_size - *initrd_addr);
             if ((int)*initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s=
'\n",
-                        initrd_filename);
+                error_report("qemu: could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         }
@@ -322,7 +323,7 @@ static void prom_init(hwaddr addr, const char *bios_nam=
e)
         ret =3D -1;
     }
     if (ret < 0 || ret > PROM_SIZE_MAX) {
-        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
+        error_report("qemu: could not load prom '%s'", bios_name);
         exit(1);
     }
 }
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 34163e5646..98242d1e8b 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -20,6 +20,7 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
=20
@@ -295,9 +296,9 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
         if ((value ^ s->ch[ch].config) & (3 << 14))	/* DMAR | DMAW */
             omap_mcspi_dmarequest_update(s->ch + ch);
         if (((value >> 12) & 3) =3D=3D 3)			/* TRM */
-            fprintf(stderr, "%s: invalid TRM value (3)\n", __func__);
+            error_report("%s: invalid TRM value (3)", __func__);
         if (((value >> 7) & 0x1f) < 3)			/* WL */
-            fprintf(stderr, "%s: invalid WL value (%" PRIx64 ")\n",
+            error_report("%s: invalid WL value (%" PRIx64 ")",
                             __func__, (value >> 7) & 0x1f);
         s->ch[ch].config =3D value & 0x7fffff;
         break;
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index ae2dc99832..0f064241d3 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
@@ -356,7 +357,7 @@ static void omap_gp_timer_write(void *opaque, hwaddr ad=
dr,
     case 0x10:	/* TIOCP_CFG */
         s->config =3D value & 0x33d;
         if (((value >> 3) & 3) =3D=3D 3)				/* IDLEMODE */
-            fprintf(stderr, "%s: illegal IDLEMODE value in TIOCP_CFG\n",
+            error_report("%s: illegal IDLEMODE value in TIOCP_CFG",
                             __func__);
         if (value & 2)						/* SOFTRESET */
             omap_gp_timer_reset(s);
@@ -394,11 +395,11 @@ static void omap_gp_timer_write(void *opaque, hwaddr =
addr,
         s->ar =3D (value >> 1) & 1;
         s->st =3D (value >> 0) & 1;
         if (s->inout && s->trigger !=3D gpt_trigger_none)
-            fprintf(stderr, "%s: GP timer pin must be an output "
-                            "for this trigger mode\n", __func__);
+            error_report("%s: GP timer pin must be an output "
+                         "for this trigger mode", __func__);
         if (!s->inout && s->capture !=3D gpt_capture_none)
-            fprintf(stderr, "%s: GP timer pin must be an input "
-                            "for this capture mode\n", __func__);
+            error_report("%s: GP timer pin must be an input "
+                         "for this capture mode", __func__);
         if (s->trigger =3D=3D gpt_trigger_none)
             omap_gp_timer_out(s, s->scpwm);
         /* TODO: make sure this doesn't overflow 32-bits */
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 87e334af24..3ade0ba929 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -614,7 +614,7 @@ static void menelaus_write(void *opaque, uint8_t addr, =
uint8_t value)
             break;
         rtc_badness:
         default:
-            fprintf(stderr, "%s: bad RTC_UPDATE value %02x\n",
+            error_report("%s: bad RTC_UPDATE value %02x",
                             __func__, value);
             s->status |=3D 1 << 10;				/* RTCERR */
             menelaus_update(s);
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 59439c05be..a80bba846b 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -127,7 +127,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size=
)
             break;
=20
     }
-    D(fprintf(stderr, "%s timer=3D%d %x=3D%x\n", __func__, timer, addr * 4=
, r));
+    D(error_report("%s timer=3D%d %x=3D%x", __func__, timer, addr * 4, r))=
;
     return r;
 }
=20
@@ -135,7 +135,7 @@ static void timer_enable(struct xlx_timer *xt)
 {
     uint64_t count;
=20
-    D(fprintf(stderr, "%s timer=3D%d down=3D%d\n", __func__,
+    D(error_report("%s timer=3D%d down=3D%d", __func__,
               xt->nr, xt->regs[R_TCSR] & TCSR_UDT));
=20
     ptimer_stop(xt->ptimer);
@@ -160,7 +160,7 @@ timer_write(void *opaque, hwaddr addr,
     addr >>=3D 2;
     timer =3D timer_from_addr(addr);
     xt =3D &t->timers[timer];
-    D(fprintf(stderr, "%s addr=3D%x val=3D%x (timer=3D%d off=3D%d)\n",
+    D(error_report("%s addr=3D%x val=3D%x (timer=3D%d off=3D%d)",
              __func__, addr * 4, value, timer, addr & 3));
     /* Further decoding to address a specific timers reg.  */
     addr &=3D 3;
@@ -197,7 +197,7 @@ static void timer_hit(void *opaque)
 {
     struct xlx_timer *xt =3D opaque;
     struct timerblock *t =3D xt->parent;
-    D(fprintf(stderr, "%s %d\n", __func__, xt->nr));
+    D(error_report("%s %d", __func__, xt->nr));
     xt->regs[R_TCSR] |=3D TCSR_TINT;
=20
     if (xt->regs[R_TCSR] & TCSR_ARHT)
diff --git a/hw/usb/core.c b/hw/usb/core.c
index 241ae66b15..9ffdef055c 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -24,6 +24,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
@@ -599,7 +600,7 @@ void usb_packet_copy(USBPacket *p, void *ptr, size_t by=
tes)
         iov_from_buf(iov->iov, iov->niov, p->actual_length, ptr, bytes);
         break;
     default:
-        fprintf(stderr, "%s: invalid pid: %x\n", __func__, p->pid);
+        error_report("%s: invalid pid: %x", __func__, p->pid);
         abort();
     }
     p->actual_length +=3D bytes;
@@ -681,7 +682,7 @@ void usb_ep_dump(USBDevice *dev)
     };
     int ifnum, ep, first;
=20
-    fprintf(stderr, "Device \"%s\", config %d\n",
+    error_report("Device \"%s\", config %d",
             dev->product_desc, dev->configuration);
     for (ifnum =3D 0; ifnum < 16; ifnum++) {
         first =3D 1;
@@ -690,10 +691,10 @@ void usb_ep_dump(USBDevice *dev)
                 dev->ep_in[ep].ifnum =3D=3D ifnum) {
                 if (first) {
                     first =3D 0;
-                    fprintf(stderr, "  Interface %d, alternative %d\n",
+                    error_report("  Interface %d, alternative %d",
                             ifnum, dev->altsetting[ifnum]);
                 }
-                fprintf(stderr, "    Endpoint %d, IN, %s, %d max\n", ep,
+                error_report("    Endpoint %d, IN, %s, %d max", ep,
                         tname[dev->ep_in[ep].type],
                         dev->ep_in[ep].max_packet_size);
             }
@@ -701,16 +702,16 @@ void usb_ep_dump(USBDevice *dev)
                 dev->ep_out[ep].ifnum =3D=3D ifnum) {
                 if (first) {
                     first =3D 0;
-                    fprintf(stderr, "  Interface %d, alternative %d\n",
+                    error_report("  Interface %d, alternative %d",
                             ifnum, dev->altsetting[ifnum]);
                 }
-                fprintf(stderr, "    Endpoint %d, OUT, %s, %d max\n", ep,
+                error_report("    Endpoint %d, OUT, %s, %d max", ep,
                         tname[dev->ep_out[ep].type],
                         dev->ep_out[ep].max_packet_size);
             }
         }
     }
-    fprintf(stderr, "--\n");
+    error_report("--");
 }
=20
 struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 85c15addc5..afae910f8e 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "trace.h"
@@ -688,7 +688,7 @@ int usb_desc_get_descriptor(USBDevice *dev, USBPacket *=
p,
         break;
=20
     default:
-        fprintf(stderr, "%s: %d unknown type %d (len %zd)\n", __func__,
+        error_report("%s: %d unknown type %d (len %zd)", __func__,
                 dev->addr, type, len);
         break;
     }
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 343345235c..43fc20469a 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -30,6 +30,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
@@ -398,7 +399,7 @@ static int usb_audio_set_output_altset(USBAudioState *s=
, int altset)
     }
=20
     if (s->debug) {
-        fprintf(stderr, "usb-audio: set interface %d\n", altset);
+        error_report("usb-audio: set interface %d", altset);
     }
     s->out.altset =3D altset;
     return 0;
@@ -478,7 +479,7 @@ static int usb_audio_set_control(USBAudioState *s, uint=
8_t attrib,
             uint16_t vol =3D data[0] + (data[1] << 8);
=20
             if (s->debug) {
-                fprintf(stderr, "usb-audio: vol %04x\n", (uint16_t)vol);
+                error_report("usb-audio: vol %04x", (uint16_t)vol);
             }
=20
             vol -=3D 0x8000;
@@ -496,7 +497,7 @@ static int usb_audio_set_control(USBAudioState *s, uint=
8_t attrib,
=20
     if (set_vol) {
         if (s->debug) {
-            fprintf(stderr, "usb-audio: mute %d, lvol %3d, rvol %3d\n",
+            error_report("usb-audio: mute %d, lvol %3d, rvol %3d",
                     s->out.mute, s->out.vol[0], s->out.vol[1]);
         }
         AUD_set_volume_out(s->out.voice, s->out.mute,
@@ -514,8 +515,8 @@ static void usb_audio_handle_control(USBDevice *dev, US=
BPacket *p,
     int ret =3D 0;
=20
     if (s->debug) {
-        fprintf(stderr, "usb-audio: control transaction: "
-                "request 0x%04x value 0x%04x index 0x%04x length 0x%04x\n"=
,
+        error_report("usb-audio: control transaction: "
+                "request 0x%04x value 0x%04x index 0x%04x length 0x%04x",
                 request, value, index, length);
     }
=20
@@ -533,7 +534,7 @@ static void usb_audio_handle_control(USBDevice *dev, US=
BPacket *p,
                                     length, data);
         if (ret < 0) {
             if (s->debug) {
-                fprintf(stderr, "usb-audio: fail: get control\n");
+                error_report("usb-audio: fail: get control");
             }
             goto fail;
         }
@@ -548,7 +549,7 @@ static void usb_audio_handle_control(USBDevice *dev, US=
BPacket *p,
                                     length, data);
         if (ret < 0) {
             if (s->debug) {
-                fprintf(stderr, "usb-audio: fail: set control\n");
+                error_report("usb-audio: fail: set control");
             }
             goto fail;
         }
@@ -557,8 +558,8 @@ static void usb_audio_handle_control(USBDevice *dev, US=
BPacket *p,
     default:
 fail:
         if (s->debug) {
-            fprintf(stderr, "usb-audio: failed control transaction: "
-                    "request 0x%04x value 0x%04x index 0x%04x length 0x%04=
x\n",
+            error_report("usb-audio: failed control transaction: "
+                    "request 0x%04x value 0x%04x index 0x%04x length 0x%04=
x",
                     request, value, index, length);
         }
         p->status =3D USB_RET_STALL;
@@ -581,7 +582,7 @@ static void usb_audio_handle_reset(USBDevice *dev)
     USBAudioState *s =3D USB_AUDIO(dev);
=20
     if (s->debug) {
-        fprintf(stderr, "usb-audio: reset\n");
+        error_report("usb-audio: reset");
     }
     usb_audio_set_output_altset(s, ALTSET_OFF);
 }
@@ -595,7 +596,7 @@ static void usb_audio_handle_dataout(USBAudioState *s, =
USBPacket *p)
=20
     streambuf_put(&s->out.buf, p);
     if (p->actual_length < p->iov.size && s->debug > 1) {
-        fprintf(stderr, "usb-audio: output overrun (%zd bytes)\n",
+        error_report("usb-audio: output overrun (%zd bytes)",
                 p->iov.size - p->actual_length);
     }
 }
@@ -611,8 +612,8 @@ static void usb_audio_handle_data(USBDevice *dev, USBPa=
cket *p)
=20
     p->status =3D USB_RET_STALL;
     if (s->debug) {
-        fprintf(stderr, "usb-audio: failed data transaction: "
-                        "pid 0x%x ep 0x%x len 0x%zx\n",
+        error_report("usb-audio: failed data transaction: "
+                        "pid 0x%x ep 0x%x len 0x%zx",
                         p->pid, p->ep->nr, p->iov.size);
     }
 }
@@ -622,7 +623,7 @@ static void usb_audio_unrealize(USBDevice *dev, Error *=
*errp)
     USBAudioState *s =3D USB_AUDIO(dev);
=20
     if (s->debug) {
-        fprintf(stderr, "usb-audio: destroy\n");
+        error_report("usb-audio: destroy");
     }
=20
     usb_audio_set_output_altset(s, ALTSET_OFF);
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 0bbceaea0b..dfef258dca 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -274,13 +274,13 @@ static void usb_bt_fifo_enqueue(struct usb_hci_in_fif=
o_s *fifo,
     if (off <=3D DFIFO_LEN_MASK) {
         if (off + len > DFIFO_LEN_MASK + 1 &&
                         (fifo->dsize =3D off + len) > (DFIFO_LEN_MASK + 1)=
 * 2) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
+            error_report("%s: can't alloc %i bytes", __func__, len);
             exit(-1);
         }
         buf =3D fifo->data + off;
     } else {
         if (fifo->dlen > fifo->dsize) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
+            error_report("%s: can't alloc %i bytes", __func__, len);
             exit(-1);
         }
         buf =3D fifo->data + off - fifo->dsize;
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 94c2e94f10..7e1782b8fc 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <wchar.h>
 #include <dirent.h>
@@ -546,7 +547,7 @@ static void inotify_watchfn(void *arg)
                 break;
=20
             default:
-                fprintf(stderr, "usb-mtp: failed to parse inotify event\n"=
);
+                error_report("usb-mtp: failed to parse inotify event");
                 continue;
             }
=20
@@ -617,7 +618,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObje=
ct *o)
 #ifdef CONFIG_INOTIFY1
     int watchfd =3D usb_mtp_add_watch(s->inotifyfd, o->path);
     if (watchfd =3D=3D -1) {
-        fprintf(stderr, "usb-mtp: failed to add watch for %s\n", o->path);
+        error_report("usb-mtp: failed to add watch for %s", o->path);
     } else {
         trace_usb_mtp_inotify_event(s->dev.addr, o->path,
                                     0, "Watch Added");
@@ -1144,7 +1145,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *=
c)
         usb_mtp_object_alloc(s, s->next_handle++, NULL, s->root);
 #ifdef CONFIG_INOTIFY1
         if (usb_mtp_inotify_init(s)) {
-            fprintf(stderr, "usb-mtp: file monitoring init failed\n");
+            error_report("usb-mtp: file monitoring init failed");
         }
 #endif
         break;
@@ -1348,7 +1349,7 @@ static void usb_mtp_handle_control(USBDevice *dev, US=
BPacket *p,
 static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
 {
     /* we don't use async packets, so this should never be called */
-    fprintf(stderr, "%s\n", __func__);
+    error_report("%s", __func__);
 }
=20
 static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 85fc81bf43..9dd4af5e34 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -815,7 +815,7 @@ static int ndis_query(USBNetState *s, uint32_t oid,
         return sizeof(le32);
=20
     default:
-        fprintf(stderr, "usbnet: unknown OID 0x%08x\n", oid);
+        error_report("usbnet: unknown OID 0x%08x", oid);
         return 0;
     }
     return -1;
@@ -1084,9 +1084,9 @@ static void usb_net_handle_control(USBDevice *dev, US=
BPacket *p,
             for (i =3D 0; i < length; i++) {
                 if (!(i & 15))
                     fprintf(stderr, "\n%04x:", i);
-                fprintf(stderr, " %02x", data[i]);
+                error_report(" %02x", data[i]);
             }
-            fprintf(stderr, "\n\n");
+            fprintf(stderr, "\n");
         }
 #endif
         ret =3D rndis_parse(s, data, length);
@@ -1111,17 +1111,17 @@ static void usb_net_handle_control(USBDevice *dev, =
USBPacket *p,
             for (i =3D 0; i < p->actual_length; i++) {
                 if (!(i & 15))
                     fprintf(stderr, "\n%04x:", i);
-                fprintf(stderr, " %02x", data[i]);
+                error_report(" %02x", data[i]);
             }
-            fprintf(stderr, "\n\n");
+            fprintf(stderr, "\n");
         }
 #endif
         break;
=20
     default:
     fail:
-        fprintf(stderr, "usbnet: failed control transaction: "
-                        "request 0x%x value 0x%x index 0x%x length 0x%x\n"=
,
+        error_report("usbnet: failed control transaction: "
+                        "request 0x%x value 0x%x index 0x%x length 0x%x",
                         request, value, index, length);
         p->status =3D USB_RET_STALL;
         break;
@@ -1190,7 +1190,7 @@ static void usb_net_handle_dataout(USBNetState *s, US=
BPacket *p)
     uint32_t len;
=20
 #ifdef TRAFFIC_DEBUG
-    fprintf(stderr, "usbnet: data out len %zu\n", p->iov.size);
+    error_report("usbnet: data out len %zu", p->iov.size);
     iov_hexdump(p->iov.iov, p->iov.niov, stderr, "usbnet", p->iov.size);
 #endif
=20
@@ -1260,8 +1260,8 @@ static void usb_net_handle_data(USBDevice *dev, USBPa=
cket *p)
     }
=20
     if (p->status =3D=3D USB_RET_STALL) {
-        fprintf(stderr, "usbnet: failed data transaction: "
-                        "pid 0x%x ep 0x%x len 0x%zx\n",
+        error_report("usbnet: failed data transaction: "
+                        "pid 0x%x ep 0x%x len 0x%zx",
                         p->pid, p->ep->nr, p->iov.size);
     }
 }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 46fd30b075..d6c8a56aec 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -419,7 +419,7 @@ static int ehci_get_pid(EHCIqtd *qtd)
     case 2:
         return USB_TOKEN_SETUP;
     default:
-        fprintf(stderr, "bad token\n");
+        error_report("bad token");
         return 0;
     }
 }
@@ -1033,7 +1033,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
=20
         /* not supporting dynamic frame list size at the moment */
         if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {
-            fprintf(stderr, "attempt to set frame list size -- value %d\n"=
,
+            error_report("attempt to set frame list size -- value %d",
                     (int)val & USBCMD_FLS);
             val &=3D ~USBCMD_FLS;
         }
@@ -1190,7 +1190,7 @@ static int ehci_init_transfer(EHCIPacket *p)
=20
     while (bytes > 0) {
         if (cpage > 4) {
-            fprintf(stderr, "cpage out of range (%d)\n", cpage);
+            error_report("cpage out of range (%d)", cpage);
             qemu_sglist_destroy(&p->sgl);
             return -1;
         }
@@ -1296,7 +1296,7 @@ static void ehci_execute_complete(EHCIQueue *q)
         break;
     default:
         /* should not be triggerable */
-        fprintf(stderr, "USB invalid response %d\n", p->packet.status);
+        error_report("USB invalid response %d", p->packet.status);
         g_assert_not_reached();
         break;
     }
@@ -1345,7 +1345,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)
            p->async =3D=3D EHCI_ASYNC_INITIALIZED);
=20
     if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {
-        fprintf(stderr, "Attempting to execute inactive qtd\n");
+        error_report("Attempting to execute inactive qtd");
         return -1;
     }
=20
@@ -1383,7 +1383,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)
             p->packet.actual_length);
=20
     if (p->packet.actual_length > BUFF_SIZE) {
-        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");
+        error_report("ret from usb_handle_packet > BUFF_SIZE");
         return -1;
     }
=20
@@ -1461,7 +1461,7 @@ static int ehci_process_itd(EHCIState *ehci,
             case USB_RET_SUCCESS:
                 break;
             default:
-                fprintf(stderr, "Unexpected iso usb result: %d\n",
+                error_report("Unexpected iso usb result: %d",
                         ehci->ipacket.status);
                 /* Fall through */
             case USB_RET_IOERROR:
@@ -1564,7 +1564,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)
=20
     /* section 4.8, only QH in async schedule */
     if (async && (NLPTR_TYPE_GET(entry) !=3D NLPTR_TYPE_QH)) {
-        fprintf(stderr, "non queue head request in async schedule\n");
+        error_report("non queue head request in async schedule");
         return -1;
     }
=20
@@ -1586,8 +1586,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)
=20
     default:
         /* TODO: handle FSTN type */
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %d "
-                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));
+        error_report("FETCHENTRY: entry at %X is of type %d "
+                "which is not supported yet", entry, NLPTR_TYPE_GET(entry)=
);
         return -1;
     }
=20
@@ -2086,7 +2086,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)
             break;
=20
         default:
-            fprintf(stderr, "Bad state!\n");
+            error_report("Bad state!");
             again =3D -1;
             g_assert_not_reached();
             break;
@@ -2094,7 +2094,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)
=20
         if (again < 0 || itd_count > 16) {
             /* TODO: notify guest (raise HSE irq?) */
-            fprintf(stderr, "processing error - resetting ehci HC\n");
+            error_report("processing error - resetting ehci HC");
             ehci_reset(ehci);
             again =3D 0;
         }
@@ -2151,8 +2151,8 @@ static void ehci_advance_async_state(EHCIState *ehci)
=20
     default:
         /* this should only be due to a developer mistake */
-        fprintf(stderr, "ehci: Bad asynchronous state %d. "
-                "Resetting to active\n", ehci->astate);
+        error_report("ehci: Bad asynchronous state %d. "
+                "Resetting to active", ehci->astate);
         g_assert_not_reached();
     }
 }
@@ -2201,8 +2201,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)
=20
     default:
         /* this should only be due to a developer mistake */
-        fprintf(stderr, "ehci: Bad periodic state %d. "
-                "Resetting to active\n", ehci->pstate);
+        error_report("ehci: Bad periodic state %d. "
+                "Resetting to active", ehci->pstate);
         g_assert_not_reached();
     }
 }
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index d70a91a58c..4729926124 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -253,8 +253,8 @@
 /* #define MUSB_DEBUG */
=20
 #ifdef MUSB_DEBUG
-#define TRACE(fmt, ...) fprintf(stderr, "%s@%d: " fmt "\n", __func__, \
-                                __LINE__, ##__VA_ARGS__)
+#define TRACE(fmt, ...) error_report("%s@%d: " fmt "", __func__, \
+                                     __LINE__, ##__VA_ARGS__)
 #else
 #define TRACE(...)
 #endif
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d75c085d94..6cc1be09a2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -19,6 +19,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "qemu/queue.h"
@@ -39,7 +40,7 @@
 #else
 #define DPRINTF(...) do {} while (0)
 #endif
-#define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
+#define FIXME(_msg) do { error_report("FIXME %s:%d %s", \
                                  __func__, __LINE__, _msg); abort(); } whi=
le (0)
=20
 #define TRB_LINK_LIMIT  32
diff --git a/hw/usb/host-legacy.c b/hw/usb/host-legacy.c
index 3b57e21b52..f0c81e5309 100644
--- a/hw/usb/host-legacy.c
+++ b/hw/usb/host-legacy.c
@@ -86,7 +86,7 @@ static int parse_filter(const char *spec, struct USBAutoF=
ilter *f)
     }
=20
     if (i < DEV) {
-        fprintf(stderr, "husb: invalid auto filter spec %s\n", spec);
+        error_report("husb: invalid auto filter spec %s", spec);
         return -1;
     }
=20
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0c5c9cde1c..76ae5d2fe5 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -20,6 +20,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
@@ -51,7 +52,7 @@ int select_watchdog(const char *p)
     /* -watchdog ? lists available devices and exits cleanly. */
     if (is_help_option(p)) {
         QLIST_FOREACH(model, &watchdog_list, entry) {
-            fprintf(stderr, "\t%s\t%s\n",
+            error_report("\t%s\t%s",
                      model->wdt_name, model->wdt_description);
         }
         return 2;
@@ -67,9 +68,9 @@ int select_watchdog(const char *p)
         }
     }
=20
-    fprintf(stderr, "Unknown -watchdog device. Supported devices are:\n");
+    error_report("Unknown -watchdog device. Supported devices are:");
     QLIST_FOREACH(model, &watchdog_list, entry) {
-        fprintf(stderr, "\t%s\t%s\n",
+        error_report("\t%s\t%s",
                  model->wdt_name, model->wdt_description);
     }
     return 1;
@@ -133,7 +134,7 @@ void watchdog_perform_action(void)
=20
     case WDT_DEBUG:
         qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_DEBUG, &error_=
abort);
-        fprintf(stderr, "watchdog: timer fired\n");
+        error_report("watchdog: timer fired");
         break;
=20
     case WDT_NONE:
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 49b3cd188a..f596f70a3b 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -20,7 +20,7 @@
  */
=20
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
@@ -186,10 +186,12 @@ static void i6300esb_timer_expired(void *vp)
         /* What to do at the end of stage 1? */
         switch (d->int_type) {
         case INT_TYPE_IRQ:
-            fprintf(stderr, "i6300esb_timer_expired: I would send APIC 1 I=
NT 10 here if I knew how (XXX)\n");
+            error_report("i6300esb_timer_expired: I would send APIC 1 INT =
10"
+                          "here if I knew how (XXX)");
             break;
         case INT_TYPE_SMI:
-            fprintf(stderr, "i6300esb_timer_expired: I would send SMI here=
 if I knew how (XXX)\n");
+            error_report("i6300esb_timer_expired: I would send SMI here if=
 I"
+                         "knew how (XXX)");
             break;
         }
=20
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 632a938dcc..a7c821cfcf 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -47,19 +47,19 @@ static int store_dev_info(int domid, Chardev *cs, const=
 char *string)
     /* We now have everything we need to set the xenstore entry. */
     xs =3D xs_open(0);
     if (xs =3D=3D NULL) {
-        fprintf(stderr, "Could not contact XenStore\n");
+        error_report("Could not contact XenStore");
         goto out;
     }
=20
     path =3D xs_get_domain_path(xs, domid);
     if (path =3D=3D NULL) {
-        fprintf(stderr, "xs_get_domain_path() error\n");
+        error_report("xs_get_domain_path() error");
         goto out;
     }
     newpath =3D realloc(path, (strlen(path) + strlen(string) +
                 strlen("/tty") + 1));
     if (newpath =3D=3D NULL) {
-        fprintf(stderr, "realloc error\n");
+        error_report("realloc error");
         goto out;
     }
     path =3D newpath;
@@ -96,13 +96,13 @@ static void xenstore_record_dm_state(struct xs_handle *=
xs, const char *state)
     char path[50];
=20
     if (xs =3D=3D NULL) {
-        fprintf(stderr, "xenstore connection not initialized\n");
+        error_report("xenstore connection not initialized");
         exit(1);
     }
=20
     snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
     if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
-        fprintf(stderr, "error recording dm state\n");
+        error_report("error recording dm state");
         exit(1);
     }
 }
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 375efa68f6..e86d380d02 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -73,7 +73,7 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)
=20
     va_start(ap, f);
     if (d) {
-        fprintf(stderr, "[%02x:%02x.%d] ", pci_bus_num(d->bus),
+        error_report("[%02x:%02x.%d] ", pci_bus_num(d->bus),
                 PCI_SLOT(d->devfn), PCI_FUNC(d->devfn));
     }
     vfprintf(stderr, f, ap);
@@ -87,7 +87,7 @@ static int xen_pt_pci_config_access_check(PCIDevice *d, u=
int32_t addr, int len)
     /* check offset range */
     if (addr > 0xFF) {
         XEN_PT_ERR(d, "Failed to access register with offset exceeding 0xF=
F. "
-                   "(addr: 0x%02x, len: %d)\n", addr, len);
+                   "(addr: 0x%02x, len: %d)", addr, len);
         return -1;
     }
=20
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
index 027f76fad1..f5514ffec2 100644
--- a/hw/xenpv/xen_domainbuild.c
+++ b/hw/xenpv/xen_domainbuild.c
@@ -25,22 +25,22 @@ static int xenstore_domain_mkdir(char *path)
     int i;
=20
     if (!xs_mkdir(xenstore, 0, path)) {
-        fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, path);
-	return -1;
+        error_report("%s: xs_mkdir %s: failed", __func__, path);
+        return -1;
     }
     if (!xs_set_permissions(xenstore, 0, path, perms_ro, 2)) {
-        fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
-	return -1;
+        error_report("%s: xs_set_permissions failed", __func__);
+        return -1;
     }
=20
     for (i =3D 0; writable[i]; i++) {
         snprintf(subpath, sizeof(subpath), "%s/%s", path, writable[i]);
         if (!xs_mkdir(xenstore, 0, subpath)) {
-            fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, subpath=
);
+            error_report("%s: xs_mkdir %s: failed", __func__, subpath);
             return -1;
         }
         if (!xs_set_permissions(xenstore, 0, subpath, perms_rw, 2)) {
-            fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
+            error_report("%s: xs_set_permissions failed", __func__);
             return -1;
         }
     }
@@ -235,7 +235,7 @@ int xen_domain_build_pv(const char *kernel, const char =
*ramdisk,
     memcpy(uuid, &qemu_uuid, sizeof(uuid));
     rc =3D xen_domain_create(xen_xc, ssidref, uuid, flags, &xen_domid);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_create() failed\n");
+        error_report("xen: xc_domain_create() failed");
         goto err;
     }
     qemu_log("xen: created domain %d\n", xen_domid);
@@ -248,21 +248,21 @@ int xen_domain_build_pv(const char *kernel, const cha=
r *ramdisk,
=20
     rc =3D xc_domain_max_vcpus(xen_xc, xen_domid, smp_cpus);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_max_vcpus() failed\n");
+        error_report("xen: xc_domain_max_vcpus() failed");
         goto err;
     }
=20
 #if 0
     rc =3D xc_domain_setcpuweight(xen_xc, xen_domid, 256);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_setcpuweight() failed\n");
+        error_report("xen: xc_domain_setcpuweight() failed");
         goto err;
     }
 #endif
=20
     rc =3D xc_domain_setmaxmem(xen_xc, xen_domid, ram_size >> 10);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_setmaxmem() failed\n");
+        error_report("xen: xc_domain_setmaxmem() failed");
         goto err;
     }
=20
@@ -275,7 +275,7 @@ int xen_domain_build_pv(const char *kernel, const char =
*ramdisk,
                         xenstore_port, &xenstore_mfn,
                         console_port, &console_mfn);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_linux_build() failed\n");
+        error_report("xen: xc_linux_build() failed");
         goto err;
     }
=20
@@ -285,7 +285,7 @@ int xen_domain_build_pv(const char *kernel, const char =
*ramdisk,
     qemu_log("xen: unpausing domain %d\n", xen_domid);
     rc =3D xc_domain_unpause(xen_xc, xen_domid);
     if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_unpause() failed\n");
+        error_report("xen: xc_domain_unpause() failed");
         goto err;
     }
=20
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 69a52a9f93..ac419e164b 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -36,7 +36,7 @@ static void xen_init_pv(MachineState *machine)
=20
     /* Initialize backend core & drivers */
     if (xen_be_init() !=3D 0) {
-        fprintf(stderr, "%s: xen backend core setup failed\n", __func__);
+        error_report("%s: xen backend core setup failed", __func__);
         exit(1);
     }
=20
@@ -51,18 +51,18 @@ static void xen_init_pv(MachineState *machine)
         const char *initrd_filename =3D machine->initrd_filename;
         if (xen_domain_build_pv(kernel_filename, initrd_filename,
                                 kernel_cmdline) < 0) {
-            fprintf(stderr, "xen pv domain creation failed\n");
+            error_report("xen pv domain creation failed");
             exit(1);
         }
         break;
     }
 #endif
     case XEN_EMULATE:
-        fprintf(stderr, "xen emulation not implemented (yet)\n");
+        error_report("xen emulation not implemented (yet)");
         exit(1);
         break;
     default:
-        fprintf(stderr, "unhandled xen_mode %d\n", xen_mode);
+        error_report("unhandled xen_mode %d", xen_mode);
         exit(1);
         break;
     }
--=20
2.11.0
