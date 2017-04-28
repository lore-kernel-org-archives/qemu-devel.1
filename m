Received: from eggs.gnu.org ([2001:4830:134:3::10]:55645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Caw-0001mc-Fk
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cav-0001I5-GU
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:24 +0200
Message-Id: <1493411622-5343-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/34] iotests: Fix typo in 026
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

s/refcout/refcount/

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/026             | 2 +-
 tests/qemu-iotests/026.out         | 2 +-
 tests/qemu-iotests/026.out.nocache | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index f5a7f02..7fadfba 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -119,7 +119,7 @@ done
 
 
 echo
-echo === Refcout table growth tests ===
+echo === Refcount table growth tests ===
 echo
 CLUSTER_SIZE=512
 
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 59b8f74..86a50a2 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -462,7 +462,7 @@ Event: cluster_alloc; errno: 28; imm: off; once: off; write -b
 write failed: No space left on device
 No errors were found on the image.
 
-=== Refcout table growth tests ===
+=== Refcount table growth tests ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index b4aeebc..ea2e166 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -470,7 +470,7 @@ Event: cluster_alloc; errno: 28; imm: off; once: off; write -b
 write failed: No space left on device
 No errors were found on the image.
 
-=== Refcout table growth tests ===
+=== Refcount table growth tests ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
-- 
1.8.3.1
