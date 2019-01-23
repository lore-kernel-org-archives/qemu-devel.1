Received: from eggs.gnu.org ([209.51.188.92]:36604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmJDC-0004IA-S6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmJDC-0003yS-51
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:09:02 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 23 Jan 2019 15:08:52 +0100
Message-Id: <1548252536-6242-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Clarify the LGPL version in some files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

The GNU project published the "GNU Library Public License, version 2"
and the "GNU Lesser Public License, version 2.1" in the past, but
there never was a "GNU Lesser Public License, version 2" (like 2.0).
We've got that wrong in many files, let's start fixing this!

Thomas Huth (4):
  COPYING.LIB: Synchronize the LGPL 2.1 with the version from gnu.org
  target/openrisc: Fix LGPL version number
  target/tricore: Fix LGPL version number
  tcg: Fix LGPL version number

 COPYING.LIB                        | 22 ++++++++++------------
 accel/tcg/atomic_template.h        |  2 +-
 accel/tcg/cpu-exec-common.c        |  2 +-
 accel/tcg/cpu-exec.c               |  2 +-
 accel/tcg/cputlb.c                 |  2 +-
 accel/tcg/softmmu_template.h       |  2 +-
 accel/tcg/tcg-runtime-gvec.c       |  2 +-
 accel/tcg/translate-all.c          |  2 +-
 accel/tcg/translate-all.h          |  2 +-
 accel/tcg/user-exec.c              |  2 +-
 target/openrisc/cpu.c              |  2 +-
 target/openrisc/exception.h        |  2 +-
 target/openrisc/gdbstub.c          |  2 +-
 target/openrisc/helper.h           |  2 +-
 target/openrisc/interrupt_helper.c |  2 +-
 target/openrisc/sys_helper.c       |  2 +-
 target/openrisc/translate.c        |  2 +-
 target/tricore/cpu-qom.h           |  2 +-
 target/tricore/cpu.c               |  2 +-
 target/tricore/cpu.h               |  2 +-
 target/tricore/fpu_helper.c        |  2 +-
 target/tricore/helper.c            |  2 +-
 target/tricore/helper.h            |  2 +-
 target/tricore/op_helper.c         |  2 +-
 target/tricore/translate.c         |  2 +-
 target/tricore/tricore-defs.h      |  2 +-
 target/tricore/tricore-opcodes.h   |  2 +-
 tcg/tcg-gvec-desc.h                |  2 +-
 tcg/tcg-op-gvec.c                  |  2 +-
 tcg/tcg-op-gvec.h                  |  2 +-
 tcg/tcg-op-vec.c                   |  2 +-
 31 files changed, 40 insertions(+), 42 deletions(-)

-- 
1.8.3.1
