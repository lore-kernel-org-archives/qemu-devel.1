Received: from eggs.gnu.org ([2001:4830:134:3::10]:59384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cP9zI-0003uO-9y
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cP9zF-0004lF-6F
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:29:56 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  5 Jan 2017 16:29:43 +0100
Message-Id: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] qtest: enable several tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

This series enables some tests existing for i386 and which
can also work on ppc64.

VGA tests and netfilter tests are trivial, but ivshmem test
needs to enable the SPAPR PCI framework. We also fix a bug
in qpci_map() for SPAPR, where the PCI base is not correctly
set in the CPU address space.

v2:
- extract ivshmem conversion to libqos and
  update log message

Laurent Vivier (5):
  qtest: add netfilter tests for ppc64
  qtest: add display-vga-test to ppc64
  libqos: fix spapr qpci_map()
  qtest: convert ivshmem-test to use libqos
  qtest: add ivshmem-test for ppc64

 tests/Makefile.include   |  7 ++++++-
 tests/display-vga-test.c |  7 ++++++-
 tests/ivshmem-test.c     | 46 +++++++++++++++++++++++++++++-----------------
 tests/libqos/pci-spapr.c |  4 ++--
 4 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.7.4
