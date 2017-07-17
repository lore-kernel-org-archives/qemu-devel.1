Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oa-0007qg-4w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OZ-0002CU-7V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5OY-00029H-Vc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OR-0003RB-6b
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:55 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:36 +0100
Message-Id: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
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

ARM queue for 2.10 soft freeze...

thanks
-- PMM

The following changes since commit 6632f6ff96f0537fc34cdc00c760656fc62e23c5:

  Merge remote-tracking branch 'remotes/famz/tags/block-and-testing-pull-request' into staging (2017-07-17 11:46:36 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170717

for you to fetch changes up to e5a6a6e64e82a132cebef023d867085b0a2993d7:

  MAINTAINERS: Add entries for MPS2 board (2017-07-17 13:36:09 +0100)

----------------------------------------------------------------
target-arm queue:
 * new model of the ARM MPS2/MPS2+ FPGA based development board
 * clean up DISAS_* exit conditions and fix various regressions
   since commits e75449a346 8a6b28c7b5 (in particular including
   ones which broke OP-TEE guests)
 * make Cortex-M3 and M4 correctly default to 8 PMSA regions

----------------------------------------------------------------
Alex Bennée (6):
      include/exec/exec-all: document common exit conditions
      target/arm/translate: make DISAS_UPDATE match declared semantics
      target/arm/translate.h: expand comment on DISAS_EXIT
      target/arm/translate: ensure gen_goto_tb sets exit flags
      target/arm: use gen_goto_tb for ISB handling
      target/arm: use DISAS_EXIT for eret handling

Peter Maydell (12):
      qdev-properties.h: Explicitly set the default value for arraylen properties
      qdev: support properties which don't set a default value
      target/arm: Make Cortex-M3 and M4 default to 8 PMSA regions
      hw/arm/mps2: Implement skeleton mps2-an385 and mps2-an511 board models
      hw/char/cmsdk-apb-uart.c: Implement CMSDK APB UART
      hw/arm/mps2: Add UARTs
      hw/char/cmsdk-apb-timer: Implement CMSDK APB timer device
      hw/arm/mps2: Add timers
      hw/misc/mps2_scc: Implement MPS2 Serial Communication Controller
      hw/arm/mps2: Add SCC
      hw/arm/mps2: Add ethernet
      MAINTAINERS: Add entries for MPS2 board

 hw/arm/Makefile.objs               |   1 +
 hw/char/Makefile.objs              |   1 +
 hw/misc/Makefile.objs              |   1 +
 hw/timer/Makefile.objs             |   1 +
 include/exec/exec-all.h            |  29 ++-
 include/hw/char/cmsdk-apb-uart.h   |  78 +++++++
 include/hw/misc/mps2-scc.h         |  43 ++++
 include/hw/qdev-core.h             |  10 +
 include/hw/qdev-properties.h       |  21 ++
 include/hw/timer/cmsdk-apb-timer.h |  59 ++++++
 target/arm/translate.h             |   5 +-
 hw/arm/mps2.c                      | 385 +++++++++++++++++++++++++++++++++++
 hw/char/cmsdk-apb-uart.c           | 403 +++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c                     |   2 +-
 hw/misc/mps2-scc.c                 | 310 ++++++++++++++++++++++++++++
 hw/timer/cmsdk-apb-timer.c         | 253 +++++++++++++++++++++++
 target/arm/cpu.c                   |  12 +-
 target/arm/translate-a64.c         |  19 +-
 target/arm/translate.c             |  22 +-
 MAINTAINERS                        |  14 +-
 default-configs/arm-softmmu.mak    |   6 +
 hw/char/trace-events               |   9 +
 hw/misc/trace-events               |   8 +
 hw/timer/trace-events              |   5 +
 24 files changed, 1673 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/char/cmsdk-apb-uart.h
 create mode 100644 include/hw/misc/mps2-scc.h
 create mode 100644 include/hw/timer/cmsdk-apb-timer.h
 create mode 100644 hw/arm/mps2.c
 create mode 100644 hw/char/cmsdk-apb-uart.c
 create mode 100644 hw/misc/mps2-scc.c
 create mode 100644 hw/timer/cmsdk-apb-timer.c
