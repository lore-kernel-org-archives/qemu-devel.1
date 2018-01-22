Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edbP0-0007x8-13
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edbOv-0002NX-Nm
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:40:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edbOv-0002Mm-IG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:40:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 22 Jan 2018 12:40:31 +0000
Message-Id: <20180122124033.21440-1-stefanha@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-01-19 16:35:25 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 91661dbdff76d526d22bc7ddf9df3d41e80cdbbf:

  block: add block_set_io_throttle virtio-blk-pci QMP example (2018-01-22 12:19:14 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Mao Zhongyi (1):
  hw/block: Use errp directly rather than local_err

Stefan Hajnoczi (1):
  block: add block_set_io_throttle virtio-blk-pci QMP example

 qapi/block-core.json  | 18 ++++++++++++++++++
 hw/block/virtio-blk.c |  5 +----
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.14.3
