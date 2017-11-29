Received: from eggs.gnu.org ([2001:4830:134:3::10]:36784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eK4m9-0003FV-8H
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eK4m8-0007kg-Hn
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:59:53 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 29 Nov 2017 16:59:42 +0100
Message-Id: <20171129155942.5646-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] iotests: Make 200 run on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

200 currently fails on tmpfs because it sets cache=none.  However,
without that (and aio=native), the test still works now and it fails
before Jeff's series (on fc7dbc119e0852a70dc9fa68bb41a318e49e4cd6).  So
we can probably remove it safely.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/200 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index d8787ddb46..0e814c9b6c 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -60,7 +60,7 @@ qemu_comm_method="qmp"
 _launch_qemu -device pci-bridge,id=bridge1,chassis_nr=1,bus=pci.0 \
              -object iothread,id=iothread0 \
              -device virtio-scsi-pci,bus=bridge1,addr=0x1f,id=scsi0,iothread=iothread0 \
-             -drive file="${TEST_IMG}",media=disk,if=none,cache=none,id=drive_sysdisk,aio=native,format=$IMGFMT \
+             -drive file="${TEST_IMG}",media=disk,if=none,id=drive_sysdisk,format=$IMGFMT \
              -device scsi-hd,drive=drive_sysdisk,bus=scsi0.0,id=sysdisk,bootindex=0
 h1=$QEMU_HANDLE
 
-- 
2.13.6
