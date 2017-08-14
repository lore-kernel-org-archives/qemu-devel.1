Received: from eggs.gnu.org ([2001:4830:134:3::10]:53760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJE-0007Ve-CY
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJD-0007Yx-EE
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:24 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:41 +0300
Message-Id: <657c572afe8dae393f2321db8866c02b4bf7bc77.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 4/7] qemu-iotests: get rid of
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Cleber Rosa <crosa@redhat.com>

Although this function is used, its implementation does nothing
besides echoing a variable name.  There's no need to wrap this
functionality in a function, and based on the one usage it has, it's
not even required to adhere to a convention or code style.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/qemu-iotests/check     | 3 +--
 tests/qemu-iotests/common.rc | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 2a55ec9ada..7a2e0d0119 100755
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
index bfbc80e5f6..8d486dbeb4 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -482,11 +482,6 @@ _full_imgfmt_details()
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
2.11.0
