Received: from eggs.gnu.org ([2001:4830:134:3::10]:48234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTzt-0007Qc-DN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTzp-0006Bb-7D
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:23:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gHTzo-00069K-Ep
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:23:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTzm-00016G-Cd
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:23:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:23:43 +0000
Message-Id: <20181030132343.22658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 0/6] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Respin to fix some accidental wrong Author lines, no content
changes.

-- PMM

The following changes since commit 0bbba1665ca2e7f1c80d4797077fe57bad58898e:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-october-2018-part-4' into staging (2018-10-30 10:45:49 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181030

for you to fetch changes up to 1f5a65a188210509bfb0c025fc91635c8436b98a:

  tests/boot-serial-test: Add microbit board testcase (2018-10-30 13:20:18 +0000)

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
