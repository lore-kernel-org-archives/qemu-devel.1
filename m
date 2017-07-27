Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVZ-0004oz-Ul
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVY-0001lJ-Bh
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:14 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2017 08:02:07 -0400
Message-Id: <20170727120210.6943-3-crosa@redhat.com>
In-Reply-To: <20170727120210.6943-1-crosa@redhat.com>
References: <20170727120210.6943-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] qemu-iotests: get rid of
 _full_imgproto_details()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Cleber Rosa <crosa@redhat.com>

Although this function is used, its implementation does nothing
besides echoing a variable name.  There's no need to wrap this
functionality in a function, and based on the one usage it has, it's
not even required to adhere to a convention or code style.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/check     | 3 +--
 tests/qemu-iotests/common.rc | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 2a55ec9..7a2e0d0 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -228,7 +228,6 @@ rm -f check.full
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
 FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
-FULL_IMGPROTO_DETAILS=`_full_imgproto_details`
 FULL_HOST_DETAILS=`_full_platform_details`
 #FULL_MKFS_OPTIONS=`_scratch_mkfs_options`
 #FULL_MOUNT_OPTIONS=`_scratch_mount_options`
@@ -239,7 +238,7 @@ QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
 QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
 QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
 IMGFMT        -- $FULL_IMGFMT_DETAILS
-IMGPROTO      -- $FULL_IMGPROTO_DETAILS
+IMGPROTO      -- $IMGPROTO
 PLATFORM      -- $FULL_HOST_DETAILS
 TEST_DIR      -- $TEST_DIR
 SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 2548e58..e4d30ad 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -479,11 +479,6 @@ _full_imgfmt_details()
     fi
 }
 
-_full_imgproto_details()
-{
-    echo "$IMGPROTO"
-}
-
 _full_platform_details()
 {
     os=`uname -s`
-- 
2.9.4
