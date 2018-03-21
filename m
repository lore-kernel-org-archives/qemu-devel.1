Received: from eggs.gnu.org ([2001:4830:134:3::10]:37455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyevc-0006qL-UR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyevZ-0002CM-Rg
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eyevZ-0002CG-NI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:41:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Mar 2018 15:41:02 +0100
Message-Id: <20180321144107.22770-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Multiboot patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:

  Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to e2679395d598bd40770c22a793c0152576ac211f:

  tests/multiboot: Add .gitignore (2018-03-21 15:13:40 +0100)

----------------------------------------------------------------
Multiboot patches

----------------------------------------------------------------
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
