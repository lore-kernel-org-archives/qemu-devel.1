Received: from eggs.gnu.org ([2001:4830:134:3::10]:47503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2B-0001Mv-Eo
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX28-0005MV-O6
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcX28-0005M8-Ej
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  1 Aug 2017 14:16:09 +0100
Message-Id: <20170801131618.27332-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Tracing patches
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

The following changes since commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed=
28:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70731' into staging (2017-07-31 14:45:42 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to bd6952a391b6f2083d6597386f457f30044e32a3:

  monitor: Reduce handle_qmp_command() tracing overhead (2017-08-01 12:13=
:07 +0100)

----------------------------------------------------------------
Pull request

Fixes for inconsistencies in the trace event format strings, broken
trace_event_get_state() usage, and handle_qmp_command() fix.

----------------------------------------------------------------

Daniel P. Berrange (2):
  trace: ensure .stp files are rebuilt if trace tool source changes
  trace: ensure unique function / variable names per .stp file

Denis V. Lunev (1):
  monitor: Reduce handle_qmp_command() tracing overhead

Stefan Hajnoczi (2):
  trace: add TRACE_<event>_BACKEND_DSTATE()
  trace: add trace_event_get_state_backends()

Vladimir Sementsov-Ogievskiy (4):
  coding_style: add point about 0x in trace-events
  trace-events: fix code style: %# -> 0x%
  checkpatch: check trace-events code style
  trace-events: fix code style: print 0x before hex numbers

 docs/devel/tracing.txt                       |   2 +-
 Makefile.target                              |   9 +-
 trace/control.h                              |  18 ++-
 hw/usb/hcd-ohci.c                            |  13 +-
 monitor.c                                    |   9 +-
 net/colo-compare.c                           |  11 +-
 net/filter-rewriter.c                        |   4 +-
 CODING_STYLE                                 |  35 ++++++
 accel/tcg/trace-events                       |   2 +-
 audio/trace-events                           |   4 +-
 block/trace-events                           |  28 ++---
 hw/audio/trace-events                        |   4 +-
 hw/char/trace-events                         |  12 +-
 hw/display/trace-events                      |  14 +--
 hw/dma/trace-events                          |  20 +--
 hw/i386/xen/trace-events                     |  26 ++--
 hw/input/trace-events                        |   6 +-
 hw/intc/trace-events                         | 176 +++++++++++++--------=
------
 hw/isa/trace-events                          |   4 +-
 hw/misc/trace-events                         |  78 ++++++------
 hw/net/trace-events                          |  52 ++++----
 hw/nvram/trace-events                        |   2 +-
 hw/pci/trace-events                          |   4 +-
 hw/ppc/trace-events                          |  64 +++++-----
 hw/s390x/trace-events                        |  20 +--
 hw/scsi/trace-events                         | 118 +++++++++---------
 hw/sd/trace-events                           |   4 +-
 hw/timer/trace-events                        |  20 +--
 hw/usb/trace-events                          |  56 ++++-----
 hw/vfio/trace-events                         |  44 +++----
 hw/virtio/trace-events                       |   6 +-
 hw/xen/trace-events                          |   8 +-
 linux-user/trace-events                      |  10 +-
 migration/trace-events                       |  36 +++---
 nbd/trace-events                             |  18 +--
 net/trace-events                             |   4 +-
 scripts/checkpatch.pl                        |  19 +++
 scripts/tracetool/__init__.py                |   1 +
 scripts/tracetool/backend/__init__.py        |   3 +
 scripts/tracetool/backend/dtrace.py          |  12 ++
 scripts/tracetool/backend/ftrace.py          |   5 +
 scripts/tracetool/backend/log.py             |   5 +
 scripts/tracetool/backend/simple.py          |   5 +
 scripts/tracetool/backend/syslog.py          |   5 +
 scripts/tracetool/backend/ust.py             |  10 ++
 scripts/tracetool/format/h.py                |  10 ++
 scripts/tracetool/format/simpletrace_stap.py |  29 +++--
 target/arm/trace-events                      |  10 +-
 target/s390x/trace-events                    |   2 +-
 target/sparc/trace-events                    |  30 ++---
 trace-events                                 |  20 +--
 51 files changed, 622 insertions(+), 485 deletions(-)

--=20
2.13.3
