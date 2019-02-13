Received: from eggs.gnu.org ([209.51.188.92]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqG6-00021O-TX
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq3o-0004tq-8j
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:38:29 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:37:53 +0100
Message-Id: <1550047098-1210-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/25] Kconfig dependencies for ARM machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

This series reworks the default-configs/arm-softmmu.mak and
default-configs/aarch64-softmmu.mak files to use the new Kconfig-style
dependencies instead.

Based-on: 1549562254-41157-1-git-send-email-pbonzini@redhat.com
          ("Support Kconfig in QEMU")

The first half of the patches is slightly based on the work by =C3=81kos =
Kov=C3=A1cs:

https://lists.nongnu.org/archive/html/qemu-devel/2013-08/msg03730.html

The second part has been created by looking at the sources and finding
out the dependencies the hard way via trial-and-error (i.e. by enabling
only one machine at a time and checking whether it can be compiled and
started).

NB: One thing I noticed while working on these patches: We should
tidy up the dependencies of AHCI and SDHCI. Both currently depend
on PCI, but some boards that do not have PCI also want to use them
(via sysbus devices)... but that's a clean-up for the future, this
series here is already big enough.

v2: Adressed review-feedback from v1
 - CONFIG_SDHCI and CONFIG_AHCI now select CONFIG_PCI
 - Added switches for MICROBIT and EMCRAFT_SF2

Thomas Huth (25):
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
  hw/arm: Express dependencies of the MSF2 machine with Kconfig
  hw/arm: Express dependencies for remaining IMX boards with Kconfig
  hw/arm: Express dependencies of the microbit / nrf51 machine with
    Kconfig
  hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kconfig
  hw/arm: Express dependencies of the xlnx-versal-virt machine with
    Kconfig
  hw/arm: Remove hard-enablement of the remaining PCI devices

 default-configs/aarch64-softmmu.mak |   4 -
 default-configs/arm-softmmu.mak     | 177 +++-----------------
 hw/arm/Kconfig                      | 313 ++++++++++++++++++++++++++++++=
++++++
 hw/arm/Makefile.objs                |  25 ++-
 hw/display/Kconfig                  |   3 +
 hw/i2c/Kconfig                      |   2 +-
 hw/ide/Kconfig                      |   2 +-
 hw/misc/Kconfig                     |   2 +
 hw/sd/Kconfig                       |   2 +-
 9 files changed, 364 insertions(+), 166 deletions(-)

--=20
1.8.3.1
