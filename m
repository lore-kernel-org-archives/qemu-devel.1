Received: from eggs.gnu.org ([2001:4830:134:3::10]:46620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJc-000892-TX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJb-00085m-W7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJb-0007yZ-LT
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJM-0005ms-Ie
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:35 +0100
Message-Id: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/18] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queue: nothing particularly exciting, but 18 patches
is enough to send out.

thanks
-- PMM

The following changes since commit 3dabde1128b671f36ac6cb36b97b273139964420:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' into staging (2017-09-14 16:33:02 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170914

for you to fetch changes up to ce3bc112cdb1d462e2d52eaa17a7314e7f3af504:

  mps2-an511: Fix wiring of UART overflow interrupt lines (2017-09-14 18:43:19 +0100)

----------------------------------------------------------------
target-arm queue:
 * v7M: various code cleanups
 * v7M: set correct BFSR bits on bus fault
 * v7M: clear exclusive monitor on reset and exception entry/exit
 * v7M: don't apply priority mask to negative priorities
 * zcu102: support 'secure' and 'virtualization' machine properties
 * aarch64: fix ERET single stepping
 * gpex: implement PCI INTx routing
 * mps2-an511: fix UART overflow interrupt line wiring

----------------------------------------------------------------
Alistair Francis (5):
      xlnx-ep108: Rename to ZCU102
      xlnx-zcu102: Manually create the machines
      xlnx-zcu102: Add a machine level secure property
      xlnx-zcu102: Add a machine level virtualization property
      xlnx-zcu102: Mark the EP108 machine as deprecated

Jaroslaw Pelczar (1):
      AArch64: Fix single stepping of ERET instruction

Peter Maydell (8):
      target/arm: Use M_REG_NUM_BANKS rather than hardcoding 2
      target/arm: Clear exclusive monitor on v7M reset, exception entry/exit
      target/arm: Get PRECISERR and IBUSERR the right way round
      nvic: Don't apply group priority mask to negative priorities
      target/arm: Remove unnecessary '| 0xf0000000' from do_v7m_exception_exit()
      target/arm: Add and use defines for EXCRET constants
      target/arm: Rename 'type' to 'excret' in do_v7m_exception_exit()
      mps2-an511: Fix wiring of UART overflow interrupt lines

Pranavkumar Sawargaonkar (3):
      hw/pci-host/gpex: Set INTx index/gsi mapping
      hw/arm/virt: Set INTx/gsi mapping
      hw/pci-host/gpex: Implement PCI INTx routing

Richard Henderson (1):
      target/arm: Avoid an extra temporary for store_exclusive

 hw/arm/Makefile.objs         |   2 +-
 include/hw/arm/xlnx-zynqmp.h |   2 +
 include/hw/pci-host/gpex.h   |   3 +
 target/arm/cpu.h             |  35 +++---
 target/arm/internals.h       |  20 ++++
 hw/arm/mps2.c                |   4 +-
 hw/arm/virt.c                |   1 +
 hw/arm/xlnx-ep108.c          | 139 -----------------------
 hw/arm/xlnx-zcu102.c         | 259 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-zynqmp.c         |   3 +-
 hw/intc/armv7m_nvic.c        |  11 +-
 hw/pci-host/gpex.c           |  22 ++++
 target/arm/cpu.c             |   6 +
 target/arm/helper.c          |  43 ++++---
 target/arm/op_helper.c       |   2 +-
 target/arm/translate-a64.c   |  27 ++---
 16 files changed, 382 insertions(+), 197 deletions(-)
 delete mode 100644 hw/arm/xlnx-ep108.c
 create mode 100644 hw/arm/xlnx-zcu102.c
