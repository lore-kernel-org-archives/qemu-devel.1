Received: from eggs.gnu.org ([2001:4830:134:3::10]:45289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwJ-0000vl-UQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwI-0007Ms-OM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  9 Mar 2018 13:19:42 +0000
Message-Id: <20180309131949.18640-1-stefanha@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

The following changes since commit 0ab4537f08e09b13788db67efd760592fb7db7=
69:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-0=
3-07-1' into staging (2018-03-08 12:56:39 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268:

  vl: introduce vm_shutdown() (2018-03-08 17:38:51 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Deepa Srinivasan (1):
  block: Fix qemu crash when using scsi-block

Fam Zheng (1):
  README: Fix typo 'git-publish'

Sergio Lopez (1):
  virtio-blk: dataplane: Don't batch notifications if EVENT_IDX is
    present

Stefan Hajnoczi (4):
  block: add aio_wait_bh_oneshot()
  virtio-blk: fix race between .ioeventfd_stop() and vq handler
  virtio-scsi: fix race between .ioeventfd_stop() and vq handler
  vl: introduce vm_shutdown()

 include/block/aio-wait.h        | 13 +++++++++++
 include/sysemu/iothread.h       |  1 -
 include/sysemu/sysemu.h         |  1 +
 block/block-backend.c           | 51 ++++++++++++++++++++---------------=
------
 cpus.c                          | 16 ++++++++++---
 hw/block/dataplane/virtio-blk.c | 39 +++++++++++++++++++++++--------
 hw/scsi/virtio-scsi-dataplane.c |  9 ++++----
 iothread.c                      | 31 -------------------------
 util/aio-wait.c                 | 31 +++++++++++++++++++++++++
 vl.c                            | 13 +++--------
 README                          |  2 +-
 11 files changed, 122 insertions(+), 85 deletions(-)

--=20
2.14.3
