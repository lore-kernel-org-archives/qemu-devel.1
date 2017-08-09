Received: from eggs.gnu.org ([2001:4830:134:3::10]:51441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwi-0002Pg-9d
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwe-0006Rh-9t
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:20 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:54:58 +0200
Message-Id: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 00/12] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

The purpose of this series is to separate the "check" sources from
the tests.  After these patches, common.config is reduced to simple
shell initialization, and common.rc is only included by the tests.

Along the way, a lot of dead code is removed too.

Paolo

Paolo Bonzini (12):
  qemu-iotests: remove dead code
  qemu-iotests: get rid of AWK_PROG
  qemu-iotests: move "check" code out of common.rc
  qemu-iotests: limit non-_PROG-suffixed variables to common.rc
  qemu-iotests: do not include common.rc in "check"
  qemu-iotests: do not do useless search for QEMU_*_PROG
  qemu-iotests: disintegrate more parts of common.config
  qemu-iotests: fix uninitialized variable
  qemu-iotests: do not search for binaries in the current directory
  qemu-iotests: get rid of $iam
  qemu-iotests: include common.env and common.config early
  qemu-iotests: merge "check" and "common"

 tests/qemu-iotests/039.out       |  10 +-
 tests/qemu-iotests/061.out       |   4 +-
 tests/qemu-iotests/137.out       |   2 +-
 tests/qemu-iotests/check         | 551 ++++++++++++++++++++++++++++++++++-----
 tests/qemu-iotests/common        | 459 --------------------------------
 tests/qemu-iotests/common.config | 205 +--------------
 tests/qemu-iotests/common.qemu   |   1 +
 tests/qemu-iotests/common.rc     | 225 ++++++++--------
 8 files changed, 615 insertions(+), 842 deletions(-)
 delete mode 100644 tests/qemu-iotests/common

-- 
2.13.3
