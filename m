Received: from eggs.gnu.org ([2001:4830:134:3::10]:57660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9i-0003Qn-IQ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9e-0005oI-Pw
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:35 +0100
Message-Id: <20180123140201.31163-4-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/29] tests/.gitignore: Add test-bdrv-drain
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

Commit 881cfd17 added a new test binary, include it in .gitignore.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
