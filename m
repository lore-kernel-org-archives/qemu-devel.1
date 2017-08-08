Received: from eggs.gnu.org ([2001:4830:134:3::10]:58082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Jg-00063T-9O
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Jf-0002RM-83
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 14:32:57 -0400
Message-Id: <20170808183306.27474-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] IDE: replace printfs with tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Wherever possible, replace all printfs with proper tracing.
In most places I've tried to do a straight replacement, but
forthcoming patches may calibrate the tracing to be a little nicer.

For now, it's nice to just remove the all-or-nothing tracing.

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
 hw/ide/trace-events       | 108 +++++++++++++++++++
 hw/ide/via.c              |  10 +-
 include/hw/ide/internal.h |   9 +-
 11 files changed, 454 insertions(+), 272 deletions(-)
 create mode 100644 hw/ide/trace-events

-- 
2.9.4
