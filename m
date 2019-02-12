Received: from eggs.gnu.org ([209.51.188.92]:53874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtYoD-0007WM-07
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtYoB-0005ot-Sb
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 12 Feb 2019 22:12:28 +0800
Message-Id: <20190212141234.2814-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PULL 0/6] Block sgarzare test patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: sgarzare@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85=
fa:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into =
staging (2019-02-11 17:04:57 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-sgarzare-test-pull-reques=
t

for you to fetch changes up to bcfdf3d6971e2fd3d424d0c2ea80fdccc35d3dda:

  tests/virtio-blk: add test for WRITE_ZEROES command (2019-02-12 22:00:0=
9 +0800)

----------------------------------------------------------------
Block pull request for testing

Peter hit a virtio-blk-test failure caused by the new DISCARD/WRITE_ZEROE=
S
patches that Stefano and I have been unable to reproduce.  Here are the p=
atches
so they can be tested again in Peter's environment.

----------------------------------------------------------------

Stefano Garzarella (6):
  virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
  virtio-blk: add host_features field in VirtIOBlock
  virtio-blk: add "discard" and "write-zeroes" properties
  virtio-blk: add DISCARD and WRITE_ZEROES features
  tests/virtio-blk: change assert on data_size in virtio_blk_request()
  tests/virtio-blk: add test for WRITE_ZEROES command

 include/hw/virtio/virtio-blk.h |   5 +-
 hw/block/virtio-blk.c          | 214 +++++++++++++++++++++++++++++++--
 hw/core/machine.c              |   2 +
 tests/virtio-blk-test.c        |  75 +++++++++++-
 4 files changed, 282 insertions(+), 14 deletions(-)

--=20
2.20.1
