Received: from eggs.gnu.org ([2001:4830:134:3::10]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzA4-0003mS-1J
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9z-000618-DU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:53 +0100
Message-Id: <20180123140201.31163-22-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/29] iotests: Fix 059's reference output
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

From: Max Reitz <mreitz@redhat.com>

As of commit 9877860e7bd1e26ee70ab9bb5ebc34c92bf23bf5, vmdk fails
differently when opening the sample image.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-13-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/059.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f6dce7947c..1ac5d56233 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2358,5 +2358,5 @@ Offset          Length          Mapped to       File
 0x140000000     0x10000         0x50000         TEST_DIR/t-s003.vmdk
 
 === Testing afl image with a very large capacity ===
-qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
+qemu-img: Could not open 'TEST_DIR/afl9.IMGFMT': Could not open 'TEST_DIR/afl9.IMGFMT': Invalid argument
 *** done
-- 
2.13.6
