Received: from eggs.gnu.org ([2001:4830:134:3::10]:39165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9ZR-0005Bk-Qw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9ZN-00047o-3P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gH9ZM-0003rj-Q6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9Yp-0008W6-Vz
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:34:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:34:26 +0000
Message-Id: <20181029153432.23273-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Last lot of patches for arm before softfreeze tomorrow...

thanks
-- PMM

The following changes since commit ef3a6af5e789ff078d1fef880f9dfb6adf18e8f1:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20181029-pull-request' into staging (2018-10-29 12:59:15 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181029

for you to fetch changes up to 20cf5663734310a282e27b7389bc9f53ffe227e6:

  tests/boot-serial-test: Add microbit board testcase (2018-10-29 15:19:48 +0000)

----------------------------------------------------------------
target-arm queue:
 * microbit: Add the UART to our nRF51 SoC model
 * Add a virtual Xilinx Versal board "xlnx-versal-virt"
 * hw/arm/virt: Set VIRT_COMPAT_3_0 compat

----------------------------------------------------------------
Edgar E. Iglesias (2):
      hw/arm: versal: Add a model of Xilinx Versal SoC
      hw/arm: versal: Add a virtual Xilinx Versal board

Eric Auger (1):
      hw/arm/virt: Set VIRT_COMPAT_3_0 compat

Julia Suvorova (3):
      hw/char: Implement nRF51 SoC UART
      hw/arm/nrf51_soc: Connect UART to nRF51 SoC
      tests/boot-serial-test: Add microbit board testcase

 hw/arm/Makefile.objs                |   1 +
 hw/char/Makefile.objs               |   1 +
 include/hw/arm/nrf51_soc.h          |   3 +
 include/hw/arm/xlnx-versal.h        | 122 +++++++++
 include/hw/char/nrf51_uart.h        |  78 ++++++
 hw/arm/microbit.c                   |   2 +
 hw/arm/nrf51_soc.c                  |  20 ++
 hw/arm/virt.c                       |   4 +
 hw/arm/xlnx-versal-virt.c           | 493 ++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c                | 323 +++++++++++++++++++++++
 hw/char/nrf51_uart.c                | 330 ++++++++++++++++++++++++
 tests/boot-serial-test.c            |  19 ++
 default-configs/aarch64-softmmu.mak |   1 +
 hw/char/trace-events                |   4 +
 14 files changed, 1401 insertions(+)
 create mode 100644 include/hw/arm/xlnx-versal.h
 create mode 100644 include/hw/char/nrf51_uart.h
 create mode 100644 hw/arm/xlnx-versal-virt.c
 create mode 100644 hw/arm/xlnx-versal.c
 create mode 100644 hw/char/nrf51_uart.c
