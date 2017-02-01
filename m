Received: from eggs.gnu.org ([2001:4830:134:3::10]:46357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDW-0006Ic-Ge
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDT-0004f7-T0
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:44:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYvDT-0004ey-L1
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:44:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Feb 2017 13:44:43 +0000
Message-Id: <20170201134453.11963-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 7f4076c1bb16d0d6f81a085ecc9c9d0b9da74c7d:

  trace: clean up trace-events files (2017-01-31 17:12:15 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (8):
  make: move top level dir to end of include search path
  trace: move hw/block/dataplane events to correct subdir
  trace: move hw/xen events to correct subdir
  trace: move hw/i386/xen events to correct subdir
  trace: move setting of group name into Makefiles
  trace: switch to modular code generation for sub-directories
  trace: update docs to reflect new code generation approach
  trace: improve error reporting when parsing simpletrace header

Stefan Hajnoczi (2):
  qapi: add missing trace_visit_type_enum() call
  trace: clean up trace-events files

 docs/tracing.txt                          |  51 ++++++++--
 Makefile                                  | 156 ++++++++++++++++++++++++++----
 Makefile.objs                             |  99 ++++++++++---------
 Makefile.target                           |  10 +-
 tests/Makefile.include                    |   2 +-
 trace/Makefile.objs                       |  93 ++----------------
 include/exec/cpu_ldst_template.h          |   2 +-
 include/exec/cpu_ldst_useronly_template.h |   2 +-
 include/hw/xen/xen_common.h               |   2 +-
 include/trace.h                           |   6 --
 aio-posix.c                               |   2 +-
 balloon.c                                 |   2 +-
 block.c                                   |   2 +-
 blockdev-nbd.c                            |   1 -
 blockdev.c                                |   2 +-
 blockjob.c                                |   1 -
 cpu-exec.c                                |   2 +-
 dma-helpers.c                             |   2 +-
 exec.c                                    |   2 +-
 hw/net/fsl_etsec/etsec.c                  |   1 -
 ioport.c                                  |   2 +-
 kvm-all.c                                 |   2 +-
 memory.c                                  |   2 +-
 monitor.c                                 |   2 +-
 qapi/qapi-visit-core.c                    |   1 +
 qom/cpu.c                                 |   2 +-
 spice-qemu-char.c                         |   2 +-
 thread-pool.c                             |   2 +-
 trace/control-target.c                    |   2 +-
 trace/control.c                           |   2 +-
 trace/ftrace.c                            |   2 +-
 trace/simple.c                            |   1 -
 translate-all.c                           |   2 +-
 vl.c                                      |   2 +-
 xen-hvm.c                                 |   2 +-
 xen-mapcache.c                            |   2 +-
 .gitignore                                |  22 +++--
 block/trace-events                        |   2 -
 hw/block/dataplane/trace-events           |   5 +
 hw/block/trace-events                     |   5 -
 hw/display/trace-events                   |   1 -
 hw/i386/trace-events                      |   8 --
 hw/i386/xen/trace-events                  |   6 ++
 hw/input/trace-events                     |   2 -
 hw/intc/trace-events                      |   1 -
 hw/net/trace-events                       |   8 --
 hw/usb/trace-events                       |   1 -
 hw/vfio/trace-events                      |   2 +-
 hw/xen/trace-events                       |  13 +++
 migration/trace-events                    |   3 -
 qapi/trace-events                         |   2 +-
 rules.mak                                 |  30 ++++--
 scripts/simpletrace.py                    |  10 +-
 scripts/tracetool.py                      |  31 +++---
 scripts/tracetool/backend/dtrace.py       |   7 +-
 scripts/tracetool/backend/simple.py       |   1 -
 scripts/tracetool/backend/ust.py          |   7 +-
 scripts/tracetool/format/c.py             |   7 +-
 scripts/tracetool/format/tcg_h.py         |   6 +-
 scripts/tracetool/format/tcg_helper_c.py  |   6 +-
 scripts/tracetool/format/ust_events_c.py  |   2 +-
 scripts/tracetool/format/ust_events_h.py  |   7 +-
 trace-events                              |  11 ---
 63 files changed, 398 insertions(+), 278 deletions(-)
 delete mode 100644 include/trace.h
 create mode 100644 hw/block/dataplane/trace-events
 create mode 100644 hw/i386/xen/trace-events
 create mode 100644 hw/xen/trace-events

-- 
2.9.3
