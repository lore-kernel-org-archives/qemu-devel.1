Received: from eggs.gnu.org ([2001:4830:134:3::10]:39212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4l-000756-AW
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4k-0001tG-CP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:26 +0200
Message-Id: <20180515154033.19899-31-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/37] iotests: Clean up wrap image in 197
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180421132929.21610-8-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/197 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 5e869fe2b7..3ae4975eec 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -44,6 +44,7 @@ esac
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_WRAP"
     rm -f "$BLKDBG_CONF"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
-- 
2.13.6
