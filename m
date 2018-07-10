Received: from eggs.gnu.org ([2001:4830:134:3::10]:44193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunT-00051R-Tx
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunT-0001ab-6M
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:44 +0200
Message-Id: <20180710154304.18304-5-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/24] iotests: 222: Don't run with luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Luks needs special parameters to operate the image. Since this test is
focusing on image fleecing, skip skip that format.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.6
