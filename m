Received: from eggs.gnu.org ([2001:4830:134:3::10]:49658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbv-0002J7-Vq
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbv-0007c6-0r
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzbu-0007bM-QC
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:18 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbs-0002yf-Qt
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:16 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:02 +0000
Message-Id: <20180319183415.1976-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/13] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm patch queue -- these are all bug fix patches but we might
as well put them in to rc0...

thanks
-- PMM

The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805be:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-03-19 11:44:26 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180319

for you to fetch changes up to ff72cb6b46b95bb530787add5277c211af3d31c6:

  hw/arm/raspi: Provide spin-loop code for AArch64 CPUs (2018-03-19 18:23:24 +0000)

----------------------------------------------------------------
target-arm queue:
 * fsl-imx6: Fix incorrect Ethernet interrupt defines
 * dump: Update correct kdump phys_base field for AArch64
 * char: i.MX: Add support for "TX complete" interrupt
 * bcm2836/raspi: Fix various bugs resulting in panics trying
   to boot a Debian Linux kernel on raspi3

----------------------------------------------------------------
Andrey Smirnov (2):
      char: i.MX: Simplify imx_update()
      char: i.MX: Add support for "TX complete" interrupt

Guenter Roeck (1):
      fsl-imx6: Swap Ethernet interrupt defines

Peter Maydell (9):
      hw/arm/raspi: Don't do board-setup or secure-boot for raspi3
      hw/arm/boot: assert that secure_boot and secure_board_setup are false for AArch64
      hw/arm/boot: If booting a kernel in EL2, set SCR_EL3.HCE
      hw/arm/bcm2386: Fix parent type of bcm2386
      hw/arm/bcm2836: Rename bcm2836 type/struct to bcm283x
      hw/arm/bcm2836: Create proper bcm2837 device
      hw/arm/bcm2836: Use correct affinity values for BCM2837
      hw/arm/bcm2836: Hardcode correct CPU type
      hw/arm/raspi: Provide spin-loop code for AArch64 CPUs

Wei Huang (1):
      dump: Update correct kdump phys_base field for AArch64

 include/hw/arm/bcm2836.h     | 31 +++++++++++++---
 include/hw/arm/fsl-imx6.h    |  4 +-
 include/hw/char/imx_serial.h |  3 ++
 dump.c                       | 14 +++++--
 hw/arm/bcm2836.c             | 87 +++++++++++++++++++++++++++++++-------------
 hw/arm/boot.c                | 12 ++++++
 hw/arm/raspi.c               | 77 +++++++++++++++++++++++++++++++--------
 hw/char/imx_serial.c         | 44 ++++++++++++++++------
 hw/net/imx_fec.c             | 28 +++++++++++++-
 9 files changed, 237 insertions(+), 63 deletions(-)
