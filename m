Received: from eggs.gnu.org ([2001:4830:134:3::10]:41272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edeWv-0006A6-98
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edeWq-0002EJ-JU
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:01:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edeWq-0002De-Cy
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:01:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 22 Jan 2018 16:00:42 +0000
Message-Id: <20180122160048.29571-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/6] Block patches
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

for you to fetch changes up to bcbb3866da19cce4360c828b6ec1c2a137757927:

  block/parallels: add backing support to readv/writev (2018-01-22 14:02:33 +0000)

----------------------------------------------------------------
Pull request

v2:
 * Drop merge failure from a previous pull request that broke virtio-blk on ARM
   guests
 * Add Parallels XML patch series

----------------------------------------------------------------

Edgar Kaziakhmedov (1):
  block/parallels: add backing support to readv/writev

Klim Kireev (4):
  docs/interop/prl-xml: description of Parallels Disk format
  configure: add dependency
  block/parallels: move some structures into header
  block/parallels: replace some magic numbers

Stefan Hajnoczi (1):
  block: add block_set_io_throttle virtio-blk-pci QMP example

 docs/interop/prl-xml.txt | 158 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json     |  18 ++++++
 configure                |  27 ++++++++
 block/Makefile.objs      |   2 +
 block/parallels.h        |  88 ++++++++++++++++++++++++++
 block/parallels.c        | 108 ++++++++++++++------------------
 scripts/checkpatch.pl    |   1 +
 7 files changed, 342 insertions(+), 60 deletions(-)
 create mode 100644 docs/interop/prl-xml.txt
 create mode 100644 block/parallels.h

-- 
2.14.3
