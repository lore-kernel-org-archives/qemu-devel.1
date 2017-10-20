Received: from eggs.gnu.org ([2001:4830:134:3::10]:35329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e5fQO-0001oy-T1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e5fQK-0003mE-3O
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:05:52 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:46327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e5fQJ-0003m4-T9
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:05:48 -0400
Received: by mail-pf0-x241.google.com with SMTP id p87so12874924pfj.3
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:05:47 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Sat, 21 Oct 2017 07:05:28 +0900
Message-Id: <20171020220533.29186-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 0/5] OpenRISC SMP Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>

Hello Again,

Please consider for pull.

The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)

are available in the git repository at:

  git://github.com/stffrdhrn/qemu.git tags/openrisc-20171021-smp-pr

for you to fetch changes up to 373b259b660a8ff0960a979481c19b78d51e023a:

  openrisc: Only kick cpu on timeout, not on update (2017-10-21 06:37:06 +0900)

----------------------------------------------------------------
OpenRISC SMP patchset 20171021

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
 hw/openrisc/openrisc_sim.c       |  88 ++++++++++++++-----
 target/openrisc/cpu.c            |   1 -
 target/openrisc/cpu.h            |   4 +-
 target/openrisc/machine.c        |   1 -
 target/openrisc/sys_helper.c     |   9 +-
 9 files changed, 302 insertions(+), 46 deletions(-)
 create mode 100644 hw/intc/ompic.c

-- 
2.13.6
