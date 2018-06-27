Received: from eggs.gnu.org ([2001:4830:134:3::10]:52421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBkY-0005R0-6F
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBkV-00053g-Rr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:48:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 15:48:36 +0100
Message-Id: <20180627144838.26772-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to ed6e2161715c527330f936d44af4c547f25f687e:

  linux-aio: properly bubble up errors from initialization (2018-06-27 13:06:34 +0100)

----------------------------------------------------------------
Pull request

 * Gracefully handle Linux AIO init failure

----------------------------------------------------------------

Nishanth Aravamudan (1):
  linux-aio: properly bubble up errors from initialization

Stefan Hajnoczi (1):
  compiler: add a sizeof_field() macro

 include/block/aio.h           |  3 +++
 include/block/raw-aio.h       |  2 +-
 include/hw/xen/io/ring.h      |  2 +-
 include/qemu/compiler.h       |  2 ++
 accel/tcg/translate-all.c     |  2 +-
 block/file-posix.c            | 33 ++++++++++++++++++++++++++++-----
 block/linux-aio.c             | 12 +++++++++---
 hw/display/xenfb.c            |  4 ++--
 hw/net/rocker/rocker_of_dpa.c |  2 +-
 hw/net/virtio-net.c           |  2 +-
 stubs/linux-aio.c             |  2 +-
 target/i386/kvm.c             |  2 +-
 target/ppc/arch_dump.c        | 10 +++++-----
 target/s390x/arch_dump.c      | 20 ++++++++++----------
 util/async.c                  | 14 +++++++++++---
 15 files changed, 77 insertions(+), 35 deletions(-)

-- 
2.17.1
