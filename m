Received: from eggs.gnu.org ([2001:4830:134:3::10]:48131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eHBxv-0008D3-Jx
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eHBxr-0005ep-Iy
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:04:07 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Nov 2017 12:03:46 -0500
Message-Id: <20171121170350.31290-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Late blockjob / coroutine patches for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

The following changes since commit 7c3d1917fd7a3de906170fa3d6d3d4c5918b1e49:

  build: disarm the TCG unit test trap (2017-11-21 15:42:47 +0000)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to d975301dc8ae56fb3154348878e47a6211843c0b:

  qemu-iotest: add test for blockjob coroutine race condition (2017-11-21 11:58:12 -0500)

----------------------------------------------------------------
Late fix for blockjob / coroutine segfaults w/iothreads
----------------------------------------------------------------

Jeff Cody (4):
  blockjob: do not allow coroutine double entry or
    entry-after-completion
  coroutine: abort if we try to schedule or enter a pending coroutine
  qemu-iotests: add option in common.qemu for mismatch only
  qemu-iotest: add test for blockjob coroutine race condition

 blockjob.c                     |  7 ++-
 include/block/blockjob_int.h   |  3 +-
 include/qemu/coroutine_int.h   | 13 ++++--
 tests/qemu-iotests/200         | 99 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/200.out     | 14 ++++++
 tests/qemu-iotests/common.qemu |  8 +++-
 tests/qemu-iotests/group       |  1 +
 util/async.c                   | 13 ++++++
 util/qemu-coroutine-sleep.c    | 12 +++++
 util/qemu-coroutine.c          | 14 ++++++
 10 files changed, 177 insertions(+), 7 deletions(-)
 create mode 100755 tests/qemu-iotests/200
 create mode 100644 tests/qemu-iotests/200.out

-- 
2.9.5
