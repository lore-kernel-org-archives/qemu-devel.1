Received: from eggs.gnu.org ([2001:4830:134:3::10]:51548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGa1R-0008Kh-Bh
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 18:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGa1Q-00071i-OK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 18:28:41 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 13 Dec 2016 00:28:32 +0100
Message-Id: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] qtest: enable several tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

This series enables some tests existing for i386 and which
can also work on ppc64.

VGA tests and netfilter tests are trivial, but ivshmem test
needs to enable the SPAPR PCI framework. We also fix a bug
in qpci_map() for SPAPR, where the PCI base is not correctly
set in the CPU address space.

Laurent Vivier (4):
  qtest: add netfilter tests for ppc64
  qtest: add display-vga-test to ppc64
  libqos: fix spapr qpci_map()
  qtest: add ivshmem-test for ppc64

 tests/Makefile.include   |  7 ++++++-
 tests/display-vga-test.c |  7 ++++++-
 tests/ivshmem-test.c     | 46 +++++++++++++++++++++++++++++-----------------
 tests/libqos/pci-spapr.c |  4 ++--
 4 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.7.4
