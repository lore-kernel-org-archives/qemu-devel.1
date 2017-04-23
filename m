Received: from eggs.gnu.org ([2001:4830:134:3::10]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d2QBw-0000PN-2d
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d2QBt-0000Ir-0U
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:41:16 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d2QBs-0000IY-Qt
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:41:12 -0400
Received: by mail-io0-x244.google.com with SMTP id k87so43164346ioi.0
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 15:41:12 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:48 +0900
Message-Id: <cover.1492986468.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/9] Openrisc misc features / fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Openrisc <openrisc@lists.librecores.org>, "Tim \\'mithro\\' Ansell" <mithro@mithis.com>, Stafford Horne <shorne@gmail.com>

Hello,

I have got a few response on the last series and have fixed them up.  Also
I have dropped the shutdown patch.

These patches I added while working on upcoming openrisc smp support.  This
does not allow for SMP openrisc on qemu "yet" but it does help to allow
booting of an SMP kernel on the uni-processor qemu system which I was using
as a sanity check before testing on fpga hardware.

Changes Since v1:

 o Added Tim's patches to this series (since the vmstate patch depends on
   in)
 o Changed vmstate patch to bump version numbers + support evbar saving
 o Changed Shadow Register patch to use accessor functions
 o Added reviewed-by's
 o Added a patch to remote the `features` field and enums
 o Dropped shutdown on `l.nop 1` patch

-Stafford

Stafford Horne (7):
  target/openrisc: Fixes for memory debugging
  target/openrisc: add numcores and coreid support
  migration: Add VMSTATE_UINTTL_2DARRAY()
  target/openrisc: implement shadow registers
  migration: Add VMSTATE_STRUCT_2DARRAY()
  target/openrisc: Implement full vmstate serialization
  target/openrisc: Remove duplicate features property

Tim 'mithro' Ansell (2):
  target/openrisc: Implement EVBAR register
  target/openrisc: Implement EPH bit

 include/migration/cpu.h             |  7 ++++
 include/migration/vmstate.h         | 15 ++++++++
 linux-user/elfload.c                |  2 +-
 linux-user/main.c                   | 18 ++++-----
 linux-user/openrisc/target_cpu.h    |  6 +--
 linux-user/openrisc/target_signal.h |  2 +-
 linux-user/signal.c                 | 16 ++++----
 target/openrisc/cpu.c               | 13 ++-----
 target/openrisc/cpu.h               | 36 ++++++++++--------
 target/openrisc/gdbstub.c           |  4 +-
 target/openrisc/interrupt.c         |  9 ++++-
 target/openrisc/machine.c           | 75 +++++++++++++++++++++++++++++++++++--
 target/openrisc/mmu.c               | 23 ++++++++++--
 target/openrisc/sys_helper.c        | 22 +++++++++++
 target/openrisc/translate.c         |  5 ++-
 15 files changed, 194 insertions(+), 59 deletions(-)

-- 
2.9.3
