Received: from eggs.gnu.org ([2001:4830:134:3::10]:51905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fe3X8-0002uS-Kf
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 15:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fe3X7-0002NL-PS
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 15:15:14 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jul 2018 21:15:06 +0200
Message-Id: <20180713191506.14484-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Disallow compat=0.10 in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

223 tests persistent dirty bitmaps which are not supported in
compat=0.10, so that option is unsupported for this test.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/223 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index b63b7a4f9e..8b1859c2dd 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file # uses NBD as well
 _supported_os Linux
+# Persistent dirty bitmaps require compat=1.1
+_unsupported_imgopts 'compat=0.10'
 
 function do_run_qemu()
 {
-- 
2.17.1
