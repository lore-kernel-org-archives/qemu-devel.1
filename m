Received: from eggs.gnu.org ([2001:4830:134:3::10]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSCTh-0000ft-AQ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSCTf-0005qd-P8
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:22:41 -0400
Date: Mon, 11 Jun 2018 05:22:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611052040-mutt-send-email-mst@kernel.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/40] Use the IEC binary prefix
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
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>, Alistair Francis <alistair@alistair23.me>, Aurelien Jarno <aurelien@aurel32.net>, Anthony Perard <anthony.perard@citrix.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marek Vasut <marex@denx.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Gibson <david@gibson.dropbear.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Chris Wulff <crwulff@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alberto Garcia <berto@igalia.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Walle <michael@walle.cc>, Jan Kiszka <jan.kiszka@web.de>

On Sun, Jun 10, 2018 at 10:14:21PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi,
>=20
> This series:
>=20
> - split the byte-based definitions from "qemu/cutils.h" to "qemu/units.=
h"
>   (this now triggers WARNING: 1 added file, does MAINTAINERS need updat=
ing?)
> - clean hw/ includes;
> - replace different constants used for byte size with their correspondi=
ng
>   IEC binary prefix definitions.
>=20
> Since v3:
> - use IEC binary prefix definitions (Stefan Weil)
> - rebased
> - added R-b tags

It violates our coding style which requires KIB for macros.
But strangely, I like how this looks anyway.

So series

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


but I think you need to update the coding style explaining
that there's an exception.

> Since v2:
> - use "qemu/units.h" instead of "qemu/cunits.h" (Daniel P. Berrang=E9)
> - avoid rebuilding the world including "qemu/units.h" in "hw/hw.h" (Tho=
mas Huth)
> - more constant replaced
>=20
> Since v1:
> - corrected Xen mult -> div (Alan Robinson)
> - tagged 'include "qemu/cunits.h" in "hw/hw.h" as RFC
> - fixed mips_r4k 'params_size' (Thomas Huth)
> - added command used to generate patch in each commit (Alistair Francis=
)
> - use G_BYTE for the raspi3 machine
> - added Reviewed-by tags
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=E9 (40):
>   include: Add IEC binary prefixes in "qemu/units.h"
>   vdi: Use definitions from "qemu/units.h"
>   x86/cpu: Use definitions from "qemu/units.h"
>   checkpatch: Recognize IEC binary prefix definitions
>   hw: Use IEC binary prefix definitions from "qemu/units.h"
>   hw: Directly use "qemu/units.h" instead of "qemu/cutils.h"
>   hw/ivshmem: Use the IEC binary prefix definitions
>   hw/ipack: Use the IEC binary prefix definitions
>   hw/scsi: Use the IEC binary prefix definitions
>   hw/smbios: Use the IEC binary prefix definitions
>   hw/xen: Use the IEC binary prefix definitions
>   hw/tpm: Use the IEC binary prefix definitions
>   hw/block: Use the IEC binary prefix definitions
>   hw/display: Use the IEC binary prefix definitions
>   hw/misc: Use the IEC binary prefix definitions
>   hw/riscv: Use the IEC binary prefix definitions
>   hw/m68k: Use the IEC binary prefix definitions
>   hw/sparc: Use the IEC binary prefix definitions
>   hw/s390x: Use the IEC binary prefix definitions
>   hw/hppa: Use the IEC binary prefix definitions
>   hw/xtensa: Use the IEC binary prefix definitions
>   hw/alpha: Use the IEC binary prefix definitions
>   hw/tricore: Use the IEC binary prefix definitions
>   hw/microblaze: Use the IEC binary prefix definitions
>   hw/nios2: Use the IEC binary prefix definitions
>   hw/cris: Use the IEC binary prefix definitions
>   hw/lm32: Use the IEC binary prefix definitions
>   hw/sh4: Use the IEC binary prefix definitions
>   hw/mips/r4k: Constify params_size
>   hw/mips: Use the IEC binary prefix definitions
>   hw/arm: Use the IEC binary prefix definitions
>   hw/ppc: Use the IEC binary prefix definitions
>   hw/i386: Use the IEC binary prefix definitions
>   hw/net: Use the IEC binary prefix definitions
>   hw/usb: Use the IEC binary prefix definitions
>   hw/sd: Use the IEC binary prefix definitions
>   hw/vfio: Use the IEC binary prefix definitions
>   hw/virtio: Use the IEC binary prefix definitions
>   hw/rdma: Use the IEC binary prefix definitions
>   cutils: Do not include "qemu/units.h" directly
>=20
>  hw/net/ne2000.h                          |  5 ++--
>  hw/ppc/mac.h                             |  3 ++-
>  hw/rdma/vmw/pvrdma.h                     |  3 ++-
>  include/hw/acpi/tpm.h                    |  3 ++-
>  include/hw/arm/fsl-imx7.h                |  5 ++--
>  include/hw/arm/stm32f205_soc.h           |  5 ++--
>  include/hw/display/xlnx_dp.h             |  5 ++--
>  include/hw/i386/ich9.h                   |  3 ++-
>  include/hw/intc/mips_gic.h               |  3 ++-
>  include/hw/mips/bios.h                   |  3 ++-
>  include/hw/net/allwinner_emac.h          |  5 ++--
>  include/hw/ppc/spapr.h                   |  5 ++--
>  include/hw/virtio/virtio-net.h           |  3 ++-
>  include/qemu/cutils.h                    |  7 ------
>  include/qemu/units.h                     | 20 ++++++++++++++++
>  block/vdi.c                              |  8 +++----
>  hw/alpha/typhoon.c                       | 17 +++++++-------
>  hw/arm/bcm2835_peripherals.c             |  3 ++-
>  hw/arm/boot.c                            |  7 +++---
>  hw/arm/collie.c                          |  5 ++--
>  hw/arm/digic_boards.c                    |  7 +++---
>  hw/arm/exynos4_boards.c                  |  3 ++-
>  hw/arm/gumstix.c                         |  3 ++-
>  hw/arm/integratorcp.c                    |  3 ++-
>  hw/arm/mainstone.c                       |  3 ++-
>  hw/arm/msf2-soc.c                        |  6 ++---
>  hw/arm/msf2-som.c                        |  8 +++----
>  hw/arm/musicpal.c                        |  9 +++----
>  hw/arm/omap_sx1.c                        | 11 +++++----
>  hw/arm/raspi.c                           |  5 ++--
>  hw/arm/smmu-common.c                     |  3 ++-
>  hw/arm/stellaris.c                       |  5 ++--
>  hw/arm/versatilepb.c                     |  5 ++--
>  hw/arm/vexpress.c                        |  7 +++---
>  hw/arm/virt.c                            |  5 ++--
>  hw/arm/xilinx_zynq.c                     |  7 +++---
>  hw/block/m25p80.c                        |  5 ++--
>  hw/block/nvme.c                          |  3 ++-
>  hw/block/tc58128.c                       |  3 ++-
>  hw/block/xen_disk.c                      |  5 ++--
>  hw/core/loader-fit.c                     |  3 ++-
>  hw/core/machine.c                        |  4 ++--
>  hw/cris/axis_dev88.c                     |  3 ++-
>  hw/display/bochs-display.c               |  9 +++----
>  hw/display/cirrus_vga.c                  | 10 ++++----
>  hw/display/g364fb.c                      |  4 ++--
>  hw/display/qxl.c                         | 28 ++++++++++------------
>  hw/display/sm501.c                       | 16 ++++++-------
>  hw/display/vga-isa-mm.c                  |  5 ++--
>  hw/display/vga.c                         |  5 ++--
>  hw/display/virtio-gpu.c                  |  4 ++--
>  hw/display/vmware_vga.c                  |  3 ++-
>  hw/display/xenfb.c                       |  3 ++-
>  hw/hppa/dino.c                           |  3 ++-
>  hw/hppa/machine.c                        | 12 +++++-----
>  hw/i386/acpi-build.c                     |  5 ++--
>  hw/i386/pc.c                             | 19 ++++++++-------
>  hw/i386/pc_piix.c                        |  4 ++--
>  hw/i386/pc_q35.c                         |  3 ++-
>  hw/i386/pc_sysfw.c                       |  9 +++----
>  hw/i386/xen/xen-mapcache.c               |  3 ++-
>  hw/intc/apic_common.c                    |  3 ++-
>  hw/ipack/tpci200.c                       |  5 ++--
>  hw/lm32/lm32_boards.c                    | 13 +++++-----
>  hw/lm32/milkymist.c                      | 10 ++++----
>  hw/m68k/mcf5208.c                        |  3 ++-
>  hw/microblaze/petalogix_ml605_mmu.c      |  7 +++---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  7 +++---
>  hw/mips/boston.c                         | 30 ++++++++++++------------
>  hw/mips/mips_fulong2e.c                  |  7 +++---
>  hw/mips/mips_malta.c                     | 23 ++++++++++--------
>  hw/mips/mips_r4k.c                       | 15 ++++++------
>  hw/misc/aspeed_sdmc.c                    |  9 +++----
>  hw/misc/auxbus.c                         |  3 ++-
>  hw/misc/edu.c                            |  3 ++-
>  hw/misc/imx7_gpr.c                       |  3 ++-
>  hw/misc/ivshmem.c                        |  3 ++-
>  hw/misc/mips_itu.c                       |  3 ++-
>  hw/misc/omap_gpmc.c                      |  5 ++--
>  hw/net/e1000e.c                          |  7 +++---
>  hw/net/e1000x_common.c                   |  3 ++-
>  hw/net/eepro100.c                        |  3 +--
>  hw/nios2/boot.c                          |  6 ++---
>  hw/nvram/spapr_nvram.c                   | 10 ++++----
>  hw/pci-host/designware.c                 |  3 ++-
>  hw/pci-host/gpex.c                       |  3 ++-
>  hw/pci-host/piix.c                       |  5 ++--
>  hw/pci-host/prep.c                       |  3 ++-
>  hw/pci-host/q35.c                        | 17 +++++++-------
>  hw/pci-host/xilinx-pcie.c                |  5 ++--
>  hw/ppc/e500.c                            | 13 +++++-----
>  hw/ppc/e500plat.c                        |  3 ++-
>  hw/ppc/mac_newworld.c                    |  1 -
>  hw/ppc/mac_oldworld.c                    |  9 ++++---
>  hw/ppc/pnv.c                             |  6 ++---
>  hw/ppc/ppc405_boards.c                   |  9 +++----
>  hw/ppc/ppc405_uc.c                       |  7 +++---
>  hw/ppc/ppc440_bamboo.c                   |  6 +++--
>  hw/ppc/ppc440_uc.c                       | 28 +++++++++++-----------
>  hw/ppc/ppc4xx_devs.c                     | 22 +++++++++--------
>  hw/ppc/ppce500_spin.c                    |  3 ++-
>  hw/ppc/prep.c                            |  6 ++---
>  hw/ppc/rs6000_mc.c                       | 13 +++++-----
>  hw/ppc/sam460ex.c                        | 20 +++++++++-------
>  hw/ppc/spapr.c                           | 12 +++++-----
>  hw/ppc/spapr_rtas.c                      |  2 +-
>  hw/ppc/virtex_ml507.c                    |  7 +++---
>  hw/riscv/virt.c                          |  3 ++-
>  hw/s390x/s390-skeys.c                    |  3 ++-
>  hw/s390x/s390-stattrib.c                 |  3 ++-
>  hw/s390x/sclp.c                          |  4 ++--
>  hw/scsi/scsi-disk.c                      |  9 +++----
>  hw/sd/sd.c                               |  8 +++----
>  hw/sd/sdhci.c                            |  6 ++---
>  hw/sh4/r2d.c                             |  3 ++-
>  hw/smbios/smbios.c                       | 15 +++++-------
>  hw/sparc/leon3.c                         |  9 +++----
>  hw/sparc/sun4m.c                         |  9 ++++---
>  hw/sparc64/niagara.c                     |  3 ++-
>  hw/sparc64/sun4u.c                       |  4 ++--
>  hw/ssi/aspeed_smc.c                      | 29 ++++++++++++-----------
>  hw/tricore/tricore_testboard.c           | 13 +++++-----
>  hw/usb/ccid-card-passthru.c              |  5 ++--
>  hw/usb/combined-packet.c                 |  3 ++-
>  hw/usb/dev-smartcard-reader.c            |  3 ++-
>  hw/usb/redirect.c                        |  3 ++-
>  hw/vfio/pci-quirks.c                     |  9 +++----
>  hw/vfio/pci.c                            |  3 ++-
>  hw/xenpv/xen_domainbuild.c               | 13 +++++-----
>  hw/xtensa/xtfpga.c                       |  5 ++--
>  target/i386/cpu.c                        |  4 +---
>  tests/test-cutils.c                      | 18 +++++++-------
>  tests/test-keyval.c                      |  6 ++---
>  tests/test-qemu-opts.c                   |  7 +++---
>  scripts/checkpatch.pl                    |  1 +
>  135 files changed, 533 insertions(+), 431 deletions(-)
>  create mode 100644 include/qemu/units.h
>=20
> --=20
> 2.17.1
