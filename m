Received: from eggs.gnu.org ([2001:4830:134:3::10]:42700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCL-0000k2-PY
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCK-00029a-PZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:30 +0100
Message-Id: <20171117181653.20651-3-kwolf@redhat.com>
In-Reply-To: <20171117181653.20651-1-kwolf@redhat.com>
References: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/25] qemu-iotests: Use -nographic in 182
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

This avoids that random UI frontend error messages end up in the output.
In particular, we were seeing this line in CI error logs:

+Unable to init server: Could not connect: Connection refused

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/182 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 2e078ceed8..4b31592fb8 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -62,7 +62,7 @@ _launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
 
 echo
 echo "Starting a second QEMU using the same image should fail"
-echo 'quit' | $QEMU -monitor stdio \
+echo 'quit' | $QEMU -nographic -monitor stdio \
     -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
     -device $virtioblk,drive=drive0 2>&1 | _filter_testdir 2>&1 |
     _filter_qemu |
-- 
2.13.6
