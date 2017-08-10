Received: from eggs.gnu.org ([2001:4830:134:3::10]:55885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfrbD-00089s-Mv
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfrbC-0004Zx-Ma
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dfrbC-0004Ye-Gr
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 10 Aug 2017 18:48:21 +0100
Message-Id: <20170810174824.9580-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 0/3] Block patches
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

The following changes since commit b38df311c174c98ef8cce7dec9f46603b083018e:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170809' into staging (2017-08-10 11:12:36 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 17d0bc01bfcce0ad4fb5105d4502595224569ff0:

  virtio-blk: handle blk_getlength() errors (2017-08-10 14:33:43 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Kevin Wolf (1):
  IDE: test flush on empty CDROM

Stefan Hajnoczi (2):
  IDE: Do not flush empty CDROM drives
  virtio-blk: handle blk_getlength() errors

 hw/block/virtio-blk.c |  4 +++-
 hw/ide/core.c         | 10 +++++++++-
 tests/ide-test.c      | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.13.4
