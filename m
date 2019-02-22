Received: from eggs.gnu.org ([209.51.188.92]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV2-000296-Pf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBV0-0001aE-OB
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:29 +0000
Message-Id: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] Block patches
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

The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4=
a9:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-02-21 13:09:33 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9a9f4b74fa547b68edb38fa414999836770a4735:

  tests/virtio-blk: add test for DISCARD command (2019-02-22 09:42:17 +00=
00)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Stefano Garzarella (10):
  virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
  virtio-blk: add host_features field in VirtIOBlock
  virtio-blk: add "discard" and "write-zeroes" properties
  virtio-net: make VirtIOFeature usable for other virtio devices
  virtio-blk: set config size depending on the features enabled
  virtio-blk: add DISCARD and WRITE_ZEROES features
  tests/virtio-blk: change assert on data_size in virtio_blk_request()
  tests/virtio-blk: add virtio_blk_fix_dwz_hdr() function
  tests/virtio-blk: add test for WRITE_ZEROES command
  tests/virtio-blk: add test for DISCARD command

Vladimir Sementsov-Ogievskiy (17):
  block: enhance QEMUIOVector structure
  block/io: use qemu_iovec_init_buf
  block/block-backend: use QEMU_IOVEC_INIT_BUF
  block/backup: use qemu_iovec_init_buf
  block/commit: use QEMU_IOVEC_INIT_BUF
  block/stream: use QEMU_IOVEC_INIT_BUF
  block/parallels: use QEMU_IOVEC_INIT_BUF
  block/qcow: use qemu_iovec_init_buf
  block/qcow2: use qemu_iovec_init_buf
  block/qed: use qemu_iovec_init_buf
  block/vmdk: use qemu_iovec_init_buf
  qemu-img: use qemu_iovec_init_buf
  migration/block: use qemu_iovec_init_buf
  tests/test-bdrv-drain: use QEMU_IOVEC_INIT_BUF
  hw/ide: drop iov field from IDEState
  hw/ide: drop iov field from IDEBufferedRequest
  hw/ide: drop iov field from IDEDMA

 include/hw/ide/internal.h      |   3 -
 include/hw/virtio/virtio-blk.h |   6 +-
 include/hw/virtio/virtio.h     |  15 ++
 include/qemu/iov.h             |  64 ++++++++-
 block/backup.c                 |   5 +-
 block/block-backend.c          |  13 +-
 block/commit.c                 |   7 +-
 block/io.c                     |  89 +++---------
 block/parallels.c              |  13 +-
 block/qcow.c                   |  21 +--
 block/qcow2.c                  |  12 +-
 block/qed-table.c              |  16 +--
 block/qed.c                    |  31 ++---
 block/stream.c                 |   7 +-
 block/vmdk.c                   |   7 +-
 hw/block/virtio-blk.c          | 245 ++++++++++++++++++++++++++++++---
 hw/core/machine.c              |   2 +
 hw/ide/atapi.c                 |  14 +-
 hw/ide/core.c                  |  19 ++-
 hw/net/virtio-net.c            |  31 +----
 hw/virtio/virtio.c             |  15 ++
 migration/block.c              |  10 +-
 qemu-img.c                     |  10 +-
 tests/test-bdrv-drain.c        |  29 +---
 tests/virtio-blk-test.c        | 127 ++++++++++++++++-
 25 files changed, 525 insertions(+), 286 deletions(-)

--=20
2.20.1
