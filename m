Received: from eggs.gnu.org ([2001:4830:134:3::10]:36646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dXJwh-00083T-Iq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dXJwg-0002k5-SL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:17:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 18 Jul 2017 00:17:03 -0400
Message-Id: <20170718041705.17614-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 8508eee740c78d1465e25dad7c3e06137485dfbc:

  live-block-ops.txt: Rename, rewrite, and improve it (2017-07-18 00:11:01 -0400)

----------------------------------------------------------------
Block patches (documentation)
----------------------------------------------------------------

Kashyap Chamarthy (2):
  bitmaps.md: Convert to rST; move it into 'interop' dir
  live-block-ops.txt: Rename, rewrite, and improve it

 docs/devel/bitmaps.md                  |  505 ---------------
 docs/interop/bitmaps.rst               |  555 ++++++++++++++++
 docs/interop/live-block-operations.rst | 1088 ++++++++++++++++++++++++++++++++
 docs/live-block-ops.txt                |   72 ---
 4 files changed, 1643 insertions(+), 577 deletions(-)
 delete mode 100644 docs/devel/bitmaps.md
 create mode 100644 docs/interop/bitmaps.rst
 create mode 100644 docs/interop/live-block-operations.rst
 delete mode 100644 docs/live-block-ops.txt

-- 
2.9.4
