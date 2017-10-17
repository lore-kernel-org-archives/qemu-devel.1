Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZ1-0000uD-Ab
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZ0-00058m-IZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:11 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 00:32:37 -0400
Message-Id: <399631b6632f0a605339391ff76c90468ebd54ee.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/10] qemu-iotests: refuse to run if
 TEST_DIR contains spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Currently, not all qemu-iotests work if TEST_DIR has spaces, and they
also might not be safe.  Refuse to run if TEST_DIR in this case, at
least until all tests are fixed sometime in the future.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/check | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e6b6ff7..e2163cc 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -102,6 +102,14 @@ if [ -z "$TEST_DIR" ]; then
         TEST_DIR=`pwd`/scratch
 fi
 
+case $TEST_DIR in
+    *[[:blank:]]*)
+        echo "The TEST_DIR pathname '$TEST_DIR' contains whitespace. "
+        echo "This is currently unsupported by qemu-iotests"
+        exit 1
+        ;;
+esac
+
 if [ ! -e "$TEST_DIR" ]; then
         mkdir "$TEST_DIR"
 fi
-- 
2.9.5
