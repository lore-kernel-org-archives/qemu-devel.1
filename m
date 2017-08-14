Received: from eggs.gnu.org ([2001:4830:134:3::10]:53678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJA-0007QY-BK
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDJ7-0007Ux-3n
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:13:20 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:42 +0300
Message-Id: <80758ec57d26bd2751f204ade356db094ce4b08c.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 5/7] qemu-iotests: remove commented out variables
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

The variables FULL_MKFS_OPTIONS and FULL_MOUNT_OPTIONS are commented
out, never used, and even refer to functions that do exist.  The last
time these were touched was around 8 years ago, so I guess it's safe
to assume outputting such information on test execution is still on the
radar.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/qemu-iotests/check | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 7a2e0d0119..437ef65320 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -229,8 +229,6 @@ rm -f check.full
 
 FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
 FULL_HOST_DETAILS=`_full_platform_details`
-#FULL_MKFS_OPTIONS=`_scratch_mkfs_options`
-#FULL_MOUNT_OPTIONS=`_scratch_mount_options`
 
 cat <<EOF
 QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
@@ -244,8 +242,6 @@ TEST_DIR      -- $TEST_DIR
 SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
 
 EOF
-#MKFS_OPTIONS  -- $FULL_MKFS_OPTIONS
-#MOUNT_OPTIONS -- $FULL_MOUNT_OPTIONS
 
 seq="check"
 
-- 
2.11.0
