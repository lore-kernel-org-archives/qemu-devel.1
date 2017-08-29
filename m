Received: from eggs.gnu.org ([2001:4830:134:3::10]:50052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmnSF-0003av-GZ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmnSE-0001uB-E7
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:49:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Aug 2017 16:49:25 -0400
Message-Id: <20170829204934.9039-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/9] IDE: replace printfs with tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org, John Snow <jsnow@redhat.com>

Wherever possible, replace all printfs with proper tracing.
In most places I've tried to do a straight replacement, but
forthcoming patches may calibrate the tracing to be a little nicer.

For now, it's nice to just remove the all-or-nothing tracing.

For V2, I opted to leave in the nearly redundant tracers for now
with their individual names so that they can be targeted individually.

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[0020] [FC] 'IDE: replace DEBUG_IDE with tracing system'
002/9:[0004] [FC] 'IDE: Add register hints to tracing'
003/9:[0005] [FC] 'IDE: add tracing for data ports'
004/9:[0004] [FC] 'ATAPI: Replace DEBUG_IDE_ATAPI with tracing events'
005/9:[0013] [FC] 'IDE: replace DEBUG_AIO with trace events'
006/9:[0007] [FC] 'AHCI: Replace DPRINTF with trace-events'
007/9:[----] [--] 'AHCI: Rework IRQ constants'
008/9:[0001] [FC] 'AHCI: pretty-print FIS to buffer instead of stderr'
009/9:[----] [--] 'AHCI: remove DPRINTF macro'

===
v2:
===

01: Rehabilitate commit message.
    Fix switch () statement spacing. (Eric)
    Adjust spacing in ide-tracing file to maintain columns.
    Change filename orderings in trace-events. (Eric)
    Fixed newline issue in trace-events. (Eric)

02: Context / Added R-B.

03: Added trace-events items to appropriate patch (removed from 04) (Eric)
    Added a verbose warning for data tracers (Eric)

04: Shifted items to 03 (Eric)
    Fixed newline issue (Eric)

05: Changed __END to __COUNT (Philippe)
    Removed __BEGIN enumerator (Philippe)

06: Added more information to unknown write (Philippe)

08: Context (Entropy)

John Snow (9):
  IDE: replace DEBUG_IDE with tracing system
  IDE: Add register hints to tracing
  IDE: add tracing for data ports
  ATAPI: Replace DEBUG_IDE_ATAPI with tracing events
  IDE: replace DEBUG_AIO with trace events
  AHCI: Replace DPRINTF with trace-events
  AHCI: Rework IRQ constants
  AHCI: pretty-print FIS to buffer instead of stderr
  AHCI: remove DPRINTF macro

 Makefile.objs             |   1 +
 hw/ide/ahci.c             | 269 ++++++++++++++++++++++++++--------------------
 hw/ide/ahci_internal.h    |  44 ++++++--
 hw/ide/atapi.c            |  69 +++++-------
 hw/ide/cmd646.c           |  10 +-
 hw/ide/core.c             | 178 +++++++++++++++++++-----------
 hw/ide/pci.c              |  17 +--
 hw/ide/piix.c             |  11 +-
 hw/ide/trace-events       | 111 +++++++++++++++++++
 hw/ide/via.c              |  10 +-
 include/hw/ide/internal.h |   8 +-
 11 files changed, 456 insertions(+), 272 deletions(-)
 create mode 100644 hw/ide/trace-events

-- 
2.9.5
