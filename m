Received: from eggs.gnu.org ([2001:4830:134:3::10]:42894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRK-0005AC-Ee
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cifRJ-0006aF-Oh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:55:30 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 28 Feb 2017 13:55:21 +0300
Message-ID: <20170228105521.1284.11059.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/3] block devices record/replay update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, dovgaluk@ispras.ru, qemu-block@nongnu.org, mreitz@redhat.com

This set of patches includes several fixes for preserving
the state of the block device images while recording and replaying
virtual machine execution.

blkreplay driver now creates temporary overlay for underlaying devices
This patch implicitly enables '-snapshot' behavior in record/replay mode.
blkreplay layer creates temporary overlays on top of underlaying
disk images. It is needed, because creating an overlay over blkreplay
with explicit '-snapshot' option breaks the determinism.

v2 changes:
 - removed useless bdrv_ref/unref calls (as suggested by Kevin Wolf)
 - updated commit messages
 - minor changes

---

Pavel Dovgalyuk (3):
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices
      replay: disable default snapshot for record/replay


 block/blkreplay.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/replay.c    |    1 +
 vl.c              |   10 ++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

-- 
Pavel Dovgalyuk
