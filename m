Received: from eggs.gnu.org ([209.51.188.92]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2wm1-00077S-Fk
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2wip-0006dq-Gm
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:34:28 -0400
Received: from m12-16.163.com ([220.181.12.16]:38713)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2win-0006d3-EH
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:34:27 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sun, 10 Mar 2019 04:34:08 -0700
Message-Id: <20190310113408.59912-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] tests: test-bdrv-graph-mod: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vsementsov@virtuozzo.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Fixes: 2dbfadf
Spotted by ASAN when 'make check'.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/test-bdrv-graph-mod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 458dfa6661..8bf0fe735d 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -117,6 +117,7 @@ static void test_update_perm_tree(void)
 
     bdrv_unref(bs);
     blk_unref(root);
+    error_free(local_err);
 }
 
 /*
-- 
2.17.1
