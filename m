Received: from eggs.gnu.org ([2001:4830:134:3::10]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVh-0004rQ-KX
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVZ-0001m4-CJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:17 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2017 08:02:08 -0400
Message-Id: <20170727120210.6943-4-crosa@redhat.com>
In-Reply-To: <20170727120210.6943-1-crosa@redhat.com>
References: <20170727120210.6943-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] qemu-iotests: remove commented out
 variables
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

The variables FULL_MKFS_OPTIONS and FULL_MOUNT_OPTIONS are commented
out, never used, and even refer to functions that do exist.  The last
time these were touched was around 8 years ago, so I guess it's safe
to assume outputting such information on test execution is still on the
radar.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/check | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 7a2e0d0..437ef65 100755
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
2.9.4
