Received: from eggs.gnu.org ([209.51.188.92]:43834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gqjlO-00068p-5t
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gqjX4-0003HI-Bt
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:03:54 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:42898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gqjWz-000301-53
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:03:46 -0500
Received: by mail-lf1-x129.google.com with SMTP id l10so727687lfh.9
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 11:03:29 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  4 Feb 2019 11:03:14 -0800
Message-Id: <20190204190314.25373-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] target/xtensa: SMP updates and various
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following series that enables SMP linux support for
xtensa-softmmu.

The following changes since commit 8b7a3e1e5434b55d7710071b00af97c7086cab7a:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-24 15:04:47 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20190204-xtensa

for you to fetch changes up to 174e09b73ab1c47408dd29fb36c4dd9fbda54f97:

  hw/xtensa: xtfpga: raise CPU number limit (2019-01-28 11:55:20 -0800)

----------------------------------------------------------------
target/xtensa: SMP updates and various fixes

- fix CPU wakeup on runstall changes; expose runstall as an IRQ line;
- place mini-bootloader at the BSP reset vector;
- expose CPU core frequency in XTFPGA board FPGA register;
- rearrange access to external interrupts of xtensa cores;
- add MX interrupt distributor and use it on SMP XTFPGA boards;
- add test_mmuhifi_c3 xtensa core variant;
- raise number of CPUs that can be instantiated on XTFPGA boards.

----------------------------------------------------------------
Max Filippov (11):
      target/xtensa: add qemu_cpu_kick to xtensa_runstall
      hw/xtensa: xtfpga: fix bootloader placement in SMP
      hw/xtensa: xtfpga: use core frequency
      target/xtensa: fix access to the INTERRUPT SR
      target/xtensa: drop function xtensa_timer_irq
      target/xtensa: rearrange access to external interrupts
      target/xtensa: expose core runstall as an IRQ line
      target/xtensa: add MX interrupt controller
      hw/xtensa: xtfpga: use MX PIC for SMP
      target/xtensa: add test_mmuhifi_c3 core
      hw/xtensa: xtfpga: raise CPU number limit

 hw/xtensa/Makefile.objs                            |     1 +
 hw/xtensa/mx_pic.c                                 |   354 +
 hw/xtensa/pic_cpu.c                                |    47 +-
 hw/xtensa/xtfpga.c                                 |    65 +-
 include/hw/xtensa/mx_pic.h                         |    44 +
 target/xtensa/Makefile.objs                        |     1 +
 target/xtensa/core-test_mmuhifi_c3.c               |    53 +
 target/xtensa/core-test_mmuhifi_c3/core-isa.h      |   384 +
 .../xtensa/core-test_mmuhifi_c3/gdb-config.inc.c   |   140 +
 .../core-test_mmuhifi_c3/xtensa-modules.inc.c      | 36403 +++++++++++++++++++
 target/xtensa/cpu.h                                |     8 +-
 target/xtensa/exc_helper.c                         |    13 +
 target/xtensa/helper.c                             |     2 +-
 target/xtensa/helper.h                             |     2 +
 target/xtensa/op_helper.c                          |     2 +
 target/xtensa/translate.c                          |    14 +-
 16 files changed, 37479 insertions(+), 54 deletions(-)
 create mode 100644 hw/xtensa/mx_pic.c
 create mode 100644 include/hw/xtensa/mx_pic.h
 create mode 100644 target/xtensa/core-test_mmuhifi_c3.c
 create mode 100644 target/xtensa/core-test_mmuhifi_c3/core-isa.h
 create mode 100644 target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c
 create mode 100644 target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c

-- 
Thanks.
-- Max
