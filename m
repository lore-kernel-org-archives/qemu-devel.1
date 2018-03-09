Received: from eggs.gnu.org ([2001:4830:134:3::10]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1euFTl-0002GV-60
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1euFTk-0001Ob-E4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:42:25 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  9 Mar 2018 11:41:50 +0100
Message-Id: <20180309104151.2431-2-apahim@redhat.com>
In-Reply-To: <20180309104151.2431-1-apahim@redhat.com>
References: <20180309104151.2431-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-iotests: skip test 205 for
 unsupported formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Amador Pahim <apahim@redhat.com>

Using bochs or cloop, qemu-img will fail with:

  Format driver 'bochs' does not support image creation

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 tests/qemu-iotests/205 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index e7b2eae51d..fff9be97d2 100644
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -24,6 +24,9 @@ import iotests
 import time
 from iotests import qemu_img_create, qemu_io, filter_qemu_io, QemuIoInteractive
 
+
+iotests.verify_image_format(unsupported_fmts=['bochs', 'cloop'])
+
 nbd_sock = 'nbd_sock'
 nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
 disk = os.path.join(iotests.test_dir, 'disk')
-- 
2.14.3
