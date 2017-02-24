Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxV-0006Hh-OZ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1chJxU-0004uG-Mg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:47:09 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 24 Feb 2017 12:46:57 -0500
Message-Id: <20170224174700.30816-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit fe8ee082db5038a05dbd8872e946049e9a9c550e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-22' into staging (2017-02-24 15:00:51 +0000)

are available in the git repository at:

  https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 1d393bdeae22fde2cb83c1ea719675747c85c40e:

  RBD: Add support readv,writev for rbd (2017-02-24 12:43:01 -0500)

----------------------------------------------------------------
Block patches for 2.9
----------------------------------------------------------------

Peter Lieven (2):
  block/nfs: convert to preadv / pwritev
  block/nfs: try to avoid the bounce buffer in pwritev

tianqing (1):
  RBD: Add support readv,writev for rbd

 block/nfs.c | 62 +++++++++++++++++++++++++----------------------
 block/rbd.c | 80 ++++++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 90 insertions(+), 52 deletions(-)

-- 
2.9.3
