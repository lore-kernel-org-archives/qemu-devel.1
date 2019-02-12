Received: from eggs.gnu.org ([209.51.188.92]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtPGi-0005Qy-0c
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtPGg-0002VB-MH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:01:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 12 Feb 2019 12:01:33 +0800
Message-Id: <20190212040136.30371-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85=
fa:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into =
staging (2019-02-11 17:04:57 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 9a6719d572e99a4e79f589d0b73f7475b86f982d:

  virtio-blk: cleanup using VirtIOBlock *s and VirtIODevice *vdev (2019-0=
2-12 11:49:17 +0800)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Peter Xu (1):
  iothread: fix iothread hang when stop too soon

Stefano Garzarella (1):
  virtio-blk: cleanup using VirtIOBlock *s and VirtIODevice *vdev

Vladimir Sementsov-Ogievskiy (1):
  qemugdb/coroutine: fix arch_prctl has unknown return type

 hw/block/virtio-blk.c        | 22 +++++++++-------------
 iothread.c                   |  6 +++++-
 scripts/qemugdb/coroutine.py |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

--=20
2.20.1
