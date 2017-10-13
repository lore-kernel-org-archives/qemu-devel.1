Received: from eggs.gnu.org ([2001:4830:134:3::10]:48603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e31Ot-0006hM-ST
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e31Oq-000414-RJ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:57:23 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:48150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e31Oq-0003zW-KQ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:57:20 -0400
Received: by mail-pf0-x244.google.com with SMTP id b79so10586466pfk.5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:57:20 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 23:57:09 +0900
Message-Id: <20171013145714.2740-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 0/5] OpenRISC SMP Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>

Hello,

Please consider for pull.

The following changes since commit 7851197b812b383ae1208c5d86391c5179c8209d:

  Update version for 2.10.1 release (2017-10-02 12:42:58 -0500)

are available in the git repository at:

  git://github.com/stffrdhrn/qemu.git tags/openrisc-20171113-smp-pr

for you to fetch changes up to 017a118ebed8757ccdce6fa217640963579aeb13:

  openrisc: Only kick cpu on timeout, not on update (2017-10-13 23:31:22 +0900)

----------------------------------------------------------------
OpenRISC SMP patchset 20171113

----------------------------------------------------------------
Stafford Horne (5):
  openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
  target/openrisc: Make coreid and numcores variable
  openrisc/cputimer: Perparation for Multicore
  openrisc: Initial SMP support
  openrisc: Only kick cpu on timeout, not on update

 default-configs/or1k-softmmu.mak |   1 +
 hw/intc/Makefile.objs            |   1 +
 hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
 hw/openrisc/cputimer.c           |  64 ++++++++++----
 hw/openrisc/openrisc_sim.c       |  84 +++++++++++++-----
 target/openrisc/cpu.c            |   1 -
 target/openrisc/cpu.h            |   4 +-
 target/openrisc/machine.c        |   1 -
 target/openrisc/sys_helper.c     |   9 +-
 9 files changed, 298 insertions(+), 46 deletions(-)
 create mode 100644 hw/intc/ompic.c

-- 
2.13.6
