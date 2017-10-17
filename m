Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4RzR-0006DX-Cy
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4RzN-0003Ta-DT
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:33:01 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Oct 2017 15:32:24 +0200
Message-Id: <1508247148-25240-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Improve the CPU hot plug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, david@redhat.com

So far the CPU hot-plug qtest was only checking "cpu-add" on x86. With
these patches, we now test "device_add" for hot-plugging CPUs on x86,
and enable the test on ppc64 and s390x, too.

Thomas Huth (4):
  tests: Rename pc-cpu-test.c to cpu-plug-test.c
  tests/cpu-plug-test: Check the CPU hot-plugging with device_add, too
  tests/cpu-plug-test: Check CPU hot-plugging on ppc64, too
  tests/cpu-plug-test: Test CPU hot-plugging on s390x

 tests/Makefile.include |   6 +-
 tests/cpu-plug-test.c  | 261 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/pc-cpu-test.c    | 135 -------------------------
 3 files changed, 265 insertions(+), 137 deletions(-)
 create mode 100644 tests/cpu-plug-test.c
 delete mode 100644 tests/pc-cpu-test.c

-- 
1.8.3.1
