Received: from eggs.gnu.org ([2001:4830:134:3::10]:60309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3I-0001oR-NS
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3E-0006Oo-OC
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:52 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3E-0006O4-II
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:48 -0400
Received: by mail-pf0-x243.google.com with SMTP id o68so6703257pfj.2
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:14:48 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:14 +0900
Message-Id: <cover.1493593744.git.shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/11] Fixes and features for OpenRISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

Hello,

This are the openrisc patches I have been circulating on the mailing list
of the last few months.  We have had help from a few new people and added
the following:
 * Fixes for gdb memory debugging
 * Added support for Shadow Registers, EVBAR, EPH
 * Added support for idle state, no more 100% pegged cpu's
 * Fixed VM state persisting

Please consider for pull.

The following changes since commit 359c41abe32638adad503e386969fa428cecff52:

  Update version for v2.9.0 release (2017-04-20 15:31:34 +0100)

are available in the git repository at:

  git://github.com/stffrdhrn/qemu.git tags/pull-or-20170429

for you to fetch changes up to 700a330fbf023429a82222449a3f9bf0a884c767:

  target/openrisc: Support non-busy idle state using PMR SPR (2017-04-29 19:12:28 +0900)

----------------------------------------------------------------
QEMU fixes and features for openrisc.

----------------------------------------------------------------
Stafford Horne (9):
      MAINTAINERS: Add myself as openrisc maintainer
      target/openrisc: Fixes for memory debugging
      target/openrisc: add numcores and coreid support
      migration: Add VMSTATE_UINTTL_2DARRAY()
      target/openrisc: implement shadow registers
      migration: Add VMSTATE_STRUCT_2DARRAY()
      target/openrisc: Implement full vmstate serialization
      target/openrisc: Remove duplicate features property
      target/openrisc: Support non-busy idle state using PMR SPR

Tim 'mithro' Ansell (2):
      target/openrisc: Implement EVBAR register
      target/openrisc: Implement EPH bit

 MAINTAINERS                         |  4 +-
 hw/openrisc/cputimer.c              |  1 +
 include/migration/cpu.h             |  7 ++++
 include/migration/vmstate.h         | 15 ++++++++
 linux-user/elfload.c                |  2 +-
 linux-user/main.c                   | 18 ++++-----
 linux-user/openrisc/target_cpu.h    |  6 +--
 linux-user/openrisc/target_signal.h |  2 +-
 linux-user/signal.c                 | 16 ++++----
 target/openrisc/cpu.c               | 16 +++-----
 target/openrisc/cpu.h               | 46 ++++++++++++++--------
 target/openrisc/gdbstub.c           |  4 +-
 target/openrisc/interrupt.c         | 11 +++++-
 target/openrisc/machine.c           | 76 +++++++++++++++++++++++++++++++++++--
 target/openrisc/mmu.c               | 23 +++++++++--
 target/openrisc/sys_helper.c        | 35 +++++++++++++++++
 target/openrisc/translate.c         |  5 ++-
 17 files changed, 225 insertions(+), 62 deletions(-)
-- 
2.9.3
