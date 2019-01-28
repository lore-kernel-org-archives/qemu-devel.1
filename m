Received: from eggs.gnu.org ([209.51.188.92]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwPo-0004zY-HC
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwN7-0005cs-AM
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:10:01 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gnwN6-0005c1-Pr
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:10:01 -0500
Received: by mail-lf1-x144.google.com with SMTP id f5so10645660lfc.13
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 18:10:00 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 27 Jan 2019 18:09:33 -0800
Message-Id: <20190128020937.22775-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/4] target/xtensa: add SMP linux capable
 hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds SMP-capable interrupt controller model amd instantiates
it on the XTFPGA boards when more than one CPU is specified in command
line. It also adds an MMUv2 SMP-capable xtensa core.

Max Filippov (4):
  target/xtensa: expose core runstall as an IRQ line
  target/xtensa: add MX interrupt controller
  hw/xtensa: xtfpga: use MX PIC for SMP
  target-xtensa: add test_mmuhifi_c3 core

 hw/xtensa/Makefile.objs                            |     1 +
 hw/xtensa/mx_pic.c                                 |   354 +
 hw/xtensa/pic_cpu.c                                |    12 +
 hw/xtensa/xtfpga.c                                 |    22 +-
 include/hw/xtensa/mx_pic.h                         |    44 +
 target/xtensa/Makefile.objs                        |     1 +
 target/xtensa/core-test_mmuhifi_c3.c               |    53 +
 target/xtensa/core-test_mmuhifi_c3/core-isa.h      |   384 +
 .../xtensa/core-test_mmuhifi_c3/gdb-config.inc.c   |   140 +
 .../core-test_mmuhifi_c3/xtensa-modules.inc.c      | 36403 +++++++++++++++++++
 target/xtensa/cpu.h                                |     2 +
 11 files changed, 37415 insertions(+), 1 deletion(-)
 create mode 100644 hw/xtensa/mx_pic.c
 create mode 100644 include/hw/xtensa/mx_pic.h
 create mode 100644 target/xtensa/core-test_mmuhifi_c3.c
 create mode 100644 target/xtensa/core-test_mmuhifi_c3/core-isa.h
 create mode 100644 target/xtensa/core-test_mmuhifi_c3/gdb-config.inc.c
 create mode 100644 target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c

-- 
2.11.0
