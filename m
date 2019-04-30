Received: from eggs.gnu.org ([209.51.188.92]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMyK-0005QW-2x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLMyI-00043t-FP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:14:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 30 Apr 2019 09:13:35 +0200
Message-Id: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/30] Kconfig dependencies for ARM machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Cedric Le Goater <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, qemu-block@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Andrey Smirnov <andrew.smirnov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

This series reworks the default-configs/arm-softmmu.mak and
default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
dependencies instead.

Some of the patches are slightly based on the work by =C3=81kos Kov=C3=A1=
cs:

 https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html

The other patches have been created by looking at the sources and finding
out the dependencies the hard way via trial-and-error (i.e. by enabling
only one machine at a time and checking whether it can be compiled and
started).

v6:
 - Addressed the review feedback from Phillipe in v5
 - Added Reviewed-bys and Tested-bys
 - Use the "split" ohci patches instead of the single big one

v5:
 - Rebased the series to the current master branch
 - Added "hw/usb/hcd-ohci: Move PCI-related code into a separate file"
   patch and got rid of unneeded dependencies to CONFIG_PCI in the
   ARM machines that do not have a PCI bus

v4:
 - Rebased the series to Paolo's latest kconfig tree

v3:
 - Addressed review feedback from v2
 - Included patches to clean up the PCI dependencies of AHCI and SDHCI
   (so CONFIG_AHCI and CONFIG_SDHCI do not depend on CONFIG_PCI anymore)
 - Added an additional patch for the new "musca" machines

v2: Adressed review-feedback from v1
 - CONFIG_SDHCI and CONFIG_AHCI now select CONFIG_PCI
 - Added switches for MICROBIT and EMCRAFT_SF2

Thomas Huth (30):
  hw/pci/pci-stub: Add msi_enabled() and msi_notify() to the pci stubs
  hw/ide/ahci: Add a Kconfig switch for the AHCI-ICH9 device
  hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
    ohci_die()
  hw/usb/hcd-ohci: Move PCI-related code into a separate file
  hw/arm: Express dependencies of the exynos machines with Kconfig
  hw/arm: Express dependencies of the highbank machines with Kconfig
  hw/arm: Express dependencies of integratorcp with Kconfig
  hw/arm: Express dependencies of the fsl-imx31 machine with Kconfig
  hw/arm: Express dependencies of musicpal with Kconfig
  hw/arm: Express dependencies of the OMAP machines with Kconfig
  hw/arm: Express dependencies of stellaris with Kconfig
  hw/arm: Express dependencies of realview, versatile and vexpress with
    Kconfig
  hw/arm: Express dependencies of the PXA2xx machines with Kconfig
  hw/arm: Express dependencies of xilinx-zynq with Kconfig
  hw/arm: Express dependencies of collie with Kconfig
  hw/arm: Express dependencies of the aspeed boards with Kconfig
  hw/arm: Express dependencies of the virt machine with Kconfig
  hw/arm: Express dependencies of netduino / stm32f2xx with Kconfig
  hw/arm: Express dependencies of allwinner / cubieboard with Kconfig
  hw/arm: Express dependencies of the MPS2 boards with Kconfig
  hw/arm: Express dependencies of the raspi machines with Kconfig
  hw/arm: Express dependencies of canon-a1100 with Kconfig
  hw/arm: Express dependencies of sabrelite with Kconfig
  hw/arm: Express dependencies of the MSF2 / EMCRAFT_SF2 machine with
    Kconfig
  hw/arm: Express dependencies of the remaining IMX boards with Kconfig
  hw/arm: Express dependencies of the microbit / nrf51 machine with
    Kconfig
  hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kconfig
  hw/arm: Express dependencies of the xlnx-versal-virt machine with
    Kconfig
  hw/arm: Express dependencies of the musca machines with Kconfig
  hw/arm: Remove hard-enablement of the remaining PCI devices

 default-configs/aarch64-softmmu.mak |   5 -
 default-configs/arm-softmmu.mak     | 179 +++-------------
 hw/arm/Kconfig                      | 317 +++++++++++++++++++++++++++-
 hw/arm/Makefile.objs                |  25 ++-
 hw/display/Kconfig                  |   3 +
 hw/i2c/Kconfig                      |   2 +-
 hw/ide/Kconfig                      |   6 +-
 hw/ide/Makefile.objs                |   2 +-
 hw/misc/Kconfig                     |   2 +
 hw/pci/pci-stub.c                   |  11 +
 hw/sh4/Kconfig                      |   2 +-
 hw/usb/Kconfig                      |   6 +-
 hw/usb/Makefile.objs                |   1 +
 hw/usb/hcd-ohci-pci.c               | 163 ++++++++++++++
 hw/usb/hcd-ohci.c                   | 219 ++-----------------
 hw/usb/hcd-ohci.h                   | 104 +++++++++
 16 files changed, 676 insertions(+), 371 deletions(-)
 create mode 100644 hw/usb/hcd-ohci-pci.c
 create mode 100644 hw/usb/hcd-ohci.h

--=20
2.21.0
