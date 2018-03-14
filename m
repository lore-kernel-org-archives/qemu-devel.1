Received: from eggs.gnu.org ([2001:4830:134:3::10]:34743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGH-00038i-Ro
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewAGE-0004BS-Pw
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:32:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 14 Mar 2018 18:32:08 +0100
Message-Id: <20180314173213.18563-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] multiboot: Fix buffer overflow on invalid
 kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, jack.schwartz@oracle.com, anatol.pomozov@gmail.com, ppandit@redhat.com

Patch 1 fixes another Multiboot kernel validation bug that could cause
QEMU to load the kernel image file into a too small buffer. Patch 2 adds
another check to harden the code. The rest of the series adds Multiboot
test cases for kernels using the a.out kludge, which is where the recent
bugs were found.

Kevin Wolf (5):
  multiboot: Reject kernels exceeding the address space
  multiboot: Check validity of mh_header_addr
  tests/multiboot: Test exit code for every qemu run
  tests/multiboot: Add tests for the a.out kludge
  tests/multiboot: Add .gitignore

 hw/i386/multiboot.c             |   8 +++
 tests/multiboot/.gitignore      |   3 +
 tests/multiboot/Makefile        |  22 +++++--
 tests/multiboot/aout_kludge.S   | 138 ++++++++++++++++++++++++++++++++++++++++
 tests/multiboot/aout_kludge.out |  42 ++++++++++++
 tests/multiboot/run_test.sh     |  34 ++++++----
 6 files changed, 227 insertions(+), 20 deletions(-)
 create mode 100644 tests/multiboot/.gitignore
 create mode 100644 tests/multiboot/aout_kludge.S
 create mode 100644 tests/multiboot/aout_kludge.out

-- 
2.13.6
