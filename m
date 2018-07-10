Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcp6C-0004jB-3x
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcp6B-0003tS-CA
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:38:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 17:38:02 +0800
Message-Id: <20180710093802.28308-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: 222: Don't run with luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Luks needs special parameters to operate the image. Since this test is
focusing on image fleecing, skip skip that format.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/222 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index ff3bfc1470..0ead56d574 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -25,6 +25,8 @@ import iotests
 from iotests import log, qemu_img, qemu_io, qemu_io_silent
 
 iotests.verify_platform(['linux'])
+iotests.verify_image_format(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk',
+                                            'vhdx', 'raw'])
 
 patterns = [("0x5d", "0",         "64k"),
             ("0xd5", "1M",        "64k"),
-- 
2.17.1
