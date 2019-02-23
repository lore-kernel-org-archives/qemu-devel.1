Received: from eggs.gnu.org ([209.51.188.92]:57017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS44-0004SF-4d
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS42-0001nu-1B
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:49:40 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:48:52 +0100
Message-Id: <1550908162-22644-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/30] Kconfig dependencies for ARM machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This series reworks the default-configs/arm-softmmu.mak and
default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
dependencies instead.

Based-on: 1549562254-41157-1-git-send-email-pbonzini@redhat.com
          ("Support Kconfig in QEMU")

Some of the patches are slightly based on the work by =C3=81kos Kov=C3=A1=
cs:

https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html

The other patches have been created by looking at the sources and finding
out the dependencies the hard way via trial-and-error (i.e. by enabling
only one machine at a time and checking whether it can be compiled and
started).

v3:
 - Addressed review feedback from v2
 - Included patches to clean up the PCI dependencies of AHCI and SDHCI
   (so CONFIG_AHCI and CONFIG_SDHCI do not depend on CONFIG_PCI anymore)
 - Added an additional patch for the new "musca" machines

v2: Adressed review-feedback from v1
 - CONFIG_SDHCI and CONFIG_AHCI now select CONFIG_PCI
 - Added switches for MICROBIT and EMCRAFT_SF2

Thomas Huth (30):
  hw/arm/Kconfig: Add a config switch for MUSCA
  hw/pci/pci-stub: Add msi_enabled() and msi_notify() to the pci stubs
  hw/ide/ahci: Add a Kconfig switch for the AHDI-ICH9 device
  hw/sd/sdhci: Move PCI-related code into a separate file
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
  hw/arm: Express dependencies for remaining IMX boards with Kconfig
  hw/arm: Express dependencies of the microbit / nrf51 machine with
    Kconfig
  hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kconfig
  hw/arm: Express dependencies of the xlnx-versal-virt machine with
    Kconfig
  hw/arm: Express dependencies of the musca machines with Kconfig
  hw/arm: Remove hard-enablement of the remaining PCI devices

 default-configs/aarch64-softmmu.mak |   4 -
 default-configs/arm-softmmu.mak     | 177 +++-----------------
 hw/arm/Kconfig                      | 316 ++++++++++++++++++++++++++++++=
++++++
 hw/arm/Makefile.objs                |  25 ++-
 hw/display/Kconfig                  |   3 +
 hw/i2c/Kconfig                      |   2 +-
 hw/ide/Kconfig                      |   6 +-
 hw/ide/Makefile.objs                |   2 +-
 hw/misc/Kconfig                     |   2 +
 hw/pci/pci-stub.c                   |  11 ++
 hw/sd/Kconfig                       |   6 +-
 hw/sd/Makefile.objs                 |   1 +
 hw/sd/sdhci-internal.h              |  34 ++++
 hw/sd/sdhci-pci.c                   |  87 ++++++++++
 hw/sd/sdhci.c                       |  98 +----------
 15 files changed, 514 insertions(+), 260 deletions(-)
 create mode 100644 hw/sd/sdhci-pci.c

--=20
1.8.3.1
