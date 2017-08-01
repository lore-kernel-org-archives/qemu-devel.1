Received: from eggs.gnu.org ([2001:4830:134:3::10]:54840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRp-0000RW-O7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRp-0005c0-5v
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:47:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:28 +0200
Message-Id: <20170801144632.3831-12-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] qemu-iotests/153: Fix leaked scratch
 images
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

qemu-iotests 153 left t.qcow2.c behind in the scratch directory. Make
sure to clean it up after completing the tests.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/153 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 0b45d78ea3..fa25eb24bd 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -35,6 +35,7 @@ _cleanup()
     rm -f "${TEST_IMG}.convert"
     rm -f "${TEST_IMG}.a"
     rm -f "${TEST_IMG}.b"
+    rm -f "${TEST_IMG}.c"
     rm -f "${TEST_IMG}.lnk"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
-- 
2.13.3
