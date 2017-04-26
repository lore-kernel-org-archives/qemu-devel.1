Received: from eggs.gnu.org ([2001:4830:134:3::10]:58785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3V9J-0000cv-QT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 18:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3V9I-0004D9-SH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 18:11:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 17:10:46 -0500
Message-Id: <20170426221046.4596-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Fix typo in 026
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

s/refcout/refcount/

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
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
2.9.3
