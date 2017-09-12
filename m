Received: from eggs.gnu.org ([2001:4830:134:3::10]:51674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRD-0003pB-1V
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmR8-0001l6-5r
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:19 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:49 +0200
Message-Id: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

The purpose of this series is to separate the "check" sources from
the tests.  After these patches, common.config is reduced to simple
shell initialization, and common.rc is only included by the tests.

Along the way, a lot of dead code is removed too.

In v2, the following patches:

  qemu-iotests: do not do useless search for QEMU_*_PROG
  qemu-iotests: do not search for binaries in the current directory
  qemu-iotests: include common.env and common.config early

have been replaced by "qemu-iotests: cleanup and fix search for programs",
which also preserves the behavior of searching for programs as symlinks
in the current directory.

Paolo

Paolo Bonzini (10):
  qemu-iotests: remove dead code
  qemu-iotests: get rid of AWK_PROG
  qemu-iotests: move "check" code out of common.rc
  qemu-iotests: cleanup and fix search for programs
  qemu-iotests: limit non-_PROG-suffixed variables to common.rc
  qemu-iotests: do not include common.rc in "check"
  qemu-iotests: disintegrate more parts of common.config
  qemu-iotests: fix uninitialized variable
  qemu-iotests: get rid of $iam
  qemu-iotests: merge "check" and "common"

 tests/qemu-iotests/039.out       |  10 +-
 tests/qemu-iotests/061.out       |   4 +-
 tests/qemu-iotests/137.out       |   2 +-
 tests/qemu-iotests/check         | 575 ++++++++++++++++++++++++++++++++++-----
 tests/qemu-iotests/common        | 459 -------------------------------
 tests/qemu-iotests/common.config | 206 +-------------
 tests/qemu-iotests/common.qemu   |   1 +
 tests/qemu-iotests/common.rc     | 205 +++++++-------
 8 files changed, 621 insertions(+), 841 deletions(-)
 delete mode 100644 tests/qemu-iotests/common

-- 
2.13.5
