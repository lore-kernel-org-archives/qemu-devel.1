Received: from eggs.gnu.org ([209.51.188.92]:60085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Iks-0003GB-S1
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Iks-0005oF-5A
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:53:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  8 Mar 2019 16:53:37 +0000
Message-Id: <20190308165344.10685-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2=
a6:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-requ=
est' into staging (2019-03-07 16:16:02 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 6ca206204fa773c8626d59caf2a5676d6cc35f52:

  iothread: document about why we need explicit aio_poll() (2019-03-08 10=
:20:57 +0000)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Anastasiia Rusakova (1):
  hw/block/virtio-blk: Clean req->dev repetitions

Peter Xu (5):
  iothread: replace init_done_cond with a semaphore
  iothread: create the gcontext unconditionally
  iothread: create main loop unconditionally
  iothread: push gcontext earlier in the thread_fn
  iothread: document about why we need explicit aio_poll()

Stefan Hajnoczi (1):
  MAINTAINERS: add missing support status fields

 MAINTAINERS               |  3 ++
 include/sysemu/iothread.h |  5 +--
 hw/block/virtio-blk.c     | 16 ++++---
 iothread.c                | 90 +++++++++++++++++++--------------------
 4 files changed, 57 insertions(+), 57 deletions(-)

--=20
2.20.1
