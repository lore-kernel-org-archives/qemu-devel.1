Received: from eggs.gnu.org ([2001:4830:134:3::10]:52424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-0006Lm-2S
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYJ-0007xb-2K
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:54:53 -0400
Message-Id: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 00/16] AHCI: tracing improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

There's a bug I'm hunting down in AHCI at the moment,
so I made the AHCI tracing a little nicer again.

The bug is still at large, but no reason to hold up
tracing improvements.

In general, this set just adds register names so that
the read/write traces make more sense on their own without
having to memorize register offsets. It also splits read/write
traces into supported/unsupported subsets, so you can just
monitor for things that QEMU is likely doing wrong.

If nobody yells at me within, say, two weeks I'll just
merge these as a large trivial set.

John Snow (16):
  ahci: add port register enumeration
  ahci: modify ahci_port_read to use register numbers
  ahci: make port read traces more descriptive
  ahci: fix spacing damage on ahci_port_write
  ahci: combine identical clauses in port write
  ahci: modify ahci_port_write to use register numbers
  ahci: make port write traces more descriptive
  ahci: delete old port register address definitions
  ahci: add host register enumeration
  ahci: fix host register max address
  ahci: modify ahci_mem_read_32 to work on register numbers
  ahci: make mem_read_32 traces more descriptive
  ahci: fix spacing damage on ahci_mem_write
  ahci: adjust ahci_mem_write to work on registers
  ahci: delete old host register address definitions
  ahci: make ahci_mem_write traces more descriptive

 hw/ide/ahci.c          | 304 +++++++++++++++++++++++++++++--------------------
 hw/ide/ahci_internal.h |  63 ++++++----
 hw/ide/trace-events    |  13 ++-
 3 files changed, 231 insertions(+), 149 deletions(-)

-- 
2.14.3
