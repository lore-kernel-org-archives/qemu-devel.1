Received: from eggs.gnu.org ([2001:4830:134:3::10]:42280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYX42-0007nE-Hd
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYX41-0007fl-QV
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:57:34 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 31 Jan 2017 14:57:28 +0300
Message-ID: <20170131115728.5244.21690.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] block devices record/replay update
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

---

Pavel Dovgalyuk (3):
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices
      replay: disable default snapshot for record/replay


 block/blkreplay.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 stubs/replay.c    |    1 +
 vl.c              |   10 +++++-
 3 files changed, 93 insertions(+), 2 deletions(-)

-- 
Pavel Dovgalyuk
