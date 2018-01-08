Received: from eggs.gnu.org ([2001:4830:134:3::10]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYZQR-0003hk-F4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYZQQ-0000Rk-QT
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:33:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Jan 2018 16:33:11 +0100
Message-Id: <20180108153311.21949-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/.gitignore: Add test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Commit 881cfd17 added a new test binary, include it in .gitignore.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index 74e55d7264..e5c744b7ed 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -18,6 +18,7 @@ test-aio
 test-aio-multithread
 test-arm-mptimer
 test-base64
+test-bdrv-drain
 test-bitops
 test-bitcnt
 test-blockjob
-- 
2.13.6
