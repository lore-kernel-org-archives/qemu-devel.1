Received: from eggs.gnu.org ([209.51.188.92]:55612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHds-00041s-5W
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHdr-0004Xw-00
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun,  5 May 2019 15:56:46 +0200
Message-Id: <20190505135714.11277-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/28] Kconfig for Arm machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

 Hi Peter,

the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04=
f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-05

for you to fetch changes up to 55e5578fabf744e62038f7357369a68e460fe205:

  hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-03=
 17:06:20 +0200)

----------------------------------------------------------------
Kconfig settings for the Arm machines
----------------------------------------------------------------

Thomas Huth (28):
      hw/pci/pci-stub: Add msi_enabled() and msi_notify() to the pci stub=
s
      hw/ide/ahci: Add a Kconfig switch for the AHCI-ICH9 device
      hw/arm: Express dependencies of the exynos machines with Kconfig
      hw/arm: Express dependencies of the highbank machines with Kconfig
      hw/arm: Express dependencies of integratorcp with Kconfig
      hw/arm: Express dependencies of the fsl-imx31 machine with Kconfig
      hw/arm: Express dependencies of musicpal with Kconfig
      hw/arm: Express dependencies of the OMAP machines with Kconfig
      hw/arm: Express dependencies of stellaris with Kconfig
      hw/arm: Express dependencies of realview, versatile and vexpress wi=
th Kconfig
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
      hw/arm: Express dependencies of the MSF2 / EMCRAFT_SF2 machine with=
 Kconfig
      hw/arm: Express dependencies of the remaining IMX boards with Kconf=
ig
      hw/arm: Express dependencies of the microbit / nrf51 machine with K=
config
      hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kcon=
fig
      hw/arm: Express dependencies of the xlnx-versal-virt machine with K=
config
      hw/arm: Express dependencies of the musca machines with Kconfig
      hw/arm: Remove hard-enablement of the remaining PCI devices

 default-configs/aarch64-softmmu.mak |   5 -
 default-configs/arm-softmmu.mak     | 179 ++++----------------
 hw/arm/Kconfig                      | 317 ++++++++++++++++++++++++++++++=
+++++-
 hw/arm/Makefile.objs                |  25 ++-
 hw/display/Kconfig                  |   3 +
 hw/i2c/Kconfig                      |   2 +-
 hw/ide/Kconfig                      |   6 +-
 hw/ide/Makefile.objs                |   2 +-
 hw/misc/Kconfig                     |   2 +
 hw/pci/pci-stub.c                   |  11 ++
 10 files changed, 383 insertions(+), 169 deletions(-)
