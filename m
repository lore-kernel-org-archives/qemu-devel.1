Received: from eggs.gnu.org ([209.51.188.92]:51195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtYhK-0001cZ-O3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtYhJ-0006I5-SS
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 12 Feb 2019 22:03:24 +0800
Message-Id: <20190212140330.1467-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PULL 0/6] Block pull request for testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, sgarzare@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

Peter hit a virtio-blk-test failure caused by the new DISCARD/WRITE_ZEROE=
S
patches that Stefano and I have been unable to reproduce.  Here are the p=
atches
so they can be tested again in Peter's environment.

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
