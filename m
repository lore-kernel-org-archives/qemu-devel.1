Received: from eggs.gnu.org ([209.51.188.92]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gt4a2-0006Q7-KT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gt4a1-0005Cs-Ea
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:56:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 11 Feb 2019 13:50:31 +0800
Message-Id: <20190211055040.13528-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

The following changes since commit e47f81b617684c4546af286d307b69014a8353=
8a:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2019-02-07 18:53:25 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 55140166667bb555c5d05165b93b25557d2e6397:

  tests/virtio-blk: add test for WRITE_ZEROES command (2019-02-11 11:58:1=
7 +0800)

----------------------------------------------------------------
Pull request

User-visible changes:

 * virtio-blk: DISCARD and WRITE_ZEROES support

----------------------------------------------------------------

Peter Xu (1):
  iothread: fix iothread hang when stop too soon

Stefano Garzarella (7):
  virtio-blk: cleanup using VirtIOBlock *s and VirtIODevice *vdev
  virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
  virtio-blk: add host_features field in VirtIOBlock
  virtio-blk: add "discard" and "write-zeroes" properties
  virtio-blk: add DISCARD and WRITE_ZEROES features
  tests/virtio-blk: change assert on data_size in virtio_blk_request()
  tests/virtio-blk: add test for WRITE_ZEROES command

Vladimir Sementsov-Ogievskiy (1):
  qemugdb/coroutine: fix arch_prctl has unknown return type

 include/hw/virtio/virtio-blk.h |   5 +-
 hw/block/virtio-blk.c          | 236 +++++++++++++++++++++++++++++----
 hw/core/machine.c              |   2 +
 iothread.c                     |   6 +-
 tests/virtio-blk-test.c        |  75 ++++++++++-
 scripts/qemugdb/coroutine.py   |   2 +-
 6 files changed, 297 insertions(+), 29 deletions(-)

--=20
2.20.1
