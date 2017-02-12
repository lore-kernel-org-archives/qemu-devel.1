Received: from eggs.gnu.org ([2001:4830:134:3::10]:46579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj3z-0003KQ-DA
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj3y-0006fd-DE
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:34:51 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:34:20 +0100
Message-Id: <20170212013440.5919-2-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 01/21] iotests: Fix a problem in common.filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

If TEST_DIR is set to /tmp, test case 144 will fail. The reason is that
TEST_DIR resembles 144's test image name tmp.qcow2.
When 144 is testing $TEST_DIR/tmp.qcow2, it wants to replace
$TEST_DIR/tmp.qcow2 to TEST_DIR/tmp.qcow2, but actually it will fail
and get TEST_DIRTEST_DIR.qcow2 in this case.
The fix is just to modify the code to replace $TEST_DIR/ with TEST_DIR/.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Message-id: 20161216054723.96055-2-haoqf@linux.vnet.ibm.com
Reviewed-by: Eric Blake <eblake@redhat.com>
[mreitz: Fixed commit message and dropped superfluous escaping]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 240ed0697a..4befd865f4 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -35,7 +35,7 @@ _filter_generated_node_ids()
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
-    sed -e "s#$TEST_DIR#TEST_DIR#g"
+    sed -e "s#$TEST_DIR/#TEST_DIR/#g"
 }
 
 # replace occurrences of the actual IMGFMT value with IMGFMT
-- 
2.11.0
