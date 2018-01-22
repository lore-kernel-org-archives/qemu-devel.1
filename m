Received: from eggs.gnu.org ([2001:4830:134:3::10]:54232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ediNg-0005n8-0Z
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ediNe-00008t-Qi
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:07:47 -0500
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:39418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ediNe-00008E-JA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:07:46 -0500
Received: by mail-lf0-x22a.google.com with SMTP id m8so12141104lfc.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 12:07:46 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 22 Jan 2018 12:07:29 -0800
Message-Id: <1516651649-28514-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL v2 00/10] target/xtensa updates
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

please pull the following batch of updates for the target/xtensa.

Changes v1->v2:
- use fsf core for both MMU and noMMU in qemu-system-xtensaeb.

The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180122-xtensa

for you to fetch changes up to 847a6473206607bc6c84f6c537a0fe603ff7aaa6:

  target/xtensa: disas/xtensa: fix coverity warnings (2018-01-22 11:54:58 -0800)

----------------------------------------------------------------
target/xtensa updates:

- make mini-bootloader independent of the initial CPU state;
- add noMMU XTFPGA variants;
- add two noMMU cores: de212 and sample_controller;
- fix issues reported by coverity against xtensa translator and disassembler.

----------------------------------------------------------------
Max Filippov (10):
      hw/xtensa/xtfpga: rewrite mini bootloader
      hw/xtensa/xtfpga: clean up function/structure names
      target/xtensa: fix default sysrom/sysram addresses
      hw/xtensa: extract xtensa_create_memory_regions
      hw/xtensa/xtfpga: extract flash configuration
      hw/xtensa/xtfpga: support noMMU cores
      target/xtensa: add de212 core
      target/xtensa: allow different default CPU for MMU/noMMU
      target/xtensa: add sample_controller core
      target/xtensa: disas/xtensa: fix coverity warnings

 disas/xtensa.c                                     |     4 +-
 hw/xtensa/Makefile.objs                            |     1 +
 hw/xtensa/sim.c                                    |    38 +-
 hw/xtensa/xtensa_memory.c                          |    55 +
 hw/xtensa/xtensa_memory.h                          |    40 +
 hw/xtensa/xtfpga.c                                 |   414 +-
 target/xtensa/Makefile.objs                        |     2 +
 target/xtensa/core-de212.c                         |    53 +
 target/xtensa/core-de212/core-isa.h                |   622 +
 target/xtensa/core-de212/gdb-config.c              |   198 +
 target/xtensa/core-de212/xtensa-modules.c          | 14566 +++++++++++++++++++
 target/xtensa/core-sample_controller.c             |    53 +
 target/xtensa/core-sample_controller/core-isa.h    |   644 +
 target/xtensa/core-sample_controller/gdb-config.c  |   141 +
 .../xtensa/core-sample_controller/xtensa-modules.c | 11377 +++++++++++++++
 target/xtensa/cpu.h                                |     7 +-
 target/xtensa/overlay_tool.h                       |     8 +-
 target/xtensa/translate.c                          |     4 +-
 18 files changed, 28081 insertions(+), 146 deletions(-)
 create mode 100644 hw/xtensa/xtensa_memory.c
 create mode 100644 hw/xtensa/xtensa_memory.h
 create mode 100644 target/xtensa/core-de212.c
 create mode 100644 target/xtensa/core-de212/core-isa.h
 create mode 100644 target/xtensa/core-de212/gdb-config.c
 create mode 100644 target/xtensa/core-de212/xtensa-modules.c
 create mode 100644 target/xtensa/core-sample_controller.c
 create mode 100644 target/xtensa/core-sample_controller/core-isa.h
 create mode 100644 target/xtensa/core-sample_controller/gdb-config.c
 create mode 100644 target/xtensa/core-sample_controller/xtensa-modules.c

-- 
Thanks.
-- Max
