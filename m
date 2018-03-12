Received: from eggs.gnu.org ([2001:4830:134:3::10]:32799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evV17-0002ID-VO
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evV17-0004Nt-9j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:30:01 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 12 Mar 2018 17:29:32 -0400
Message-Id: <22815ed651022a08563b60219a5dd9dd81f92ae5.1520890118.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] block: fix iotest 146 output expectations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

Commit bff5554843 added "force_size" into the common.filter for
_filter_img_create(), but test 146 still expects it in the output.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/146.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
index db6b296b9e..1332189d87 100644
--- a/tests/qemu-iotests/146.out
+++ b/tests/qemu-iotests/146.out
@@ -54,7 +54,7 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
 
 === Testing Image create, force_size ===
 
-Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296 force_size=on
+Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
 
 === Read created image, default opts ====
 
-- 
2.13.6
