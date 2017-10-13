Received: from eggs.gnu.org ([2001:4830:134:3::10]:57668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e30LM-0007nu-7g
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e30LJ-0006NM-62
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e30LI-0006MD-VU
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 13 Oct 2017 14:49:27 +0100
Message-Id: <20171013134930.20200-1-stefanha@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57d6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171012' into staging (2017-10-12 17:06:50 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to b867eaa17b3940760f51134e409cb0580dd3dde3:

  block/throttle.c: add bdrv_co_drain_begin/end callbacks (2017-10-13 12:38:41 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Manos Pitsidianakis (3):
  block: add bdrv_co_drain_end callback
  block: rename bdrv_co_drain to bdrv_co_drain_begin
  block/throttle.c: add bdrv_co_drain_begin/end callbacks

 include/block/block_int.h | 13 ++++++++++---
 block/io.c                | 48 +++++++++++++++++++++++++++++++++--------------
 block/qed.c               |  6 +++---
 block/throttle.c          | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.13.6
