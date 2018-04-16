Received: from eggs.gnu.org ([2001:4830:134:3::10]:60730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87TM-0007hZ-1F
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87TL-0003Ph-Ey
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Apr 2018 18:58:47 +0200
Message-Id: <20180416165849.28864-8-mreitz@redhat.com>
In-Reply-To: <20180416165849.28864-1-mreitz@redhat.com>
References: <20180416165849.28864-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] iotests: Clean up wrap image in 197
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

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
2.14.3
