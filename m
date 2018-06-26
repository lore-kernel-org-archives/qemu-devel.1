Received: from eggs.gnu.org ([2001:4830:134:3::10]:34169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMo-00042v-GH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXoMl-0006Gg-Ap
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:50:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 26 Jun 2018 16:50:30 +0300
Message-Id: <20180626135035.133432-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180626135035.133432-1-vsementsov@virtuozzo.com>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/6] iotests: 169: drop deprecated 'autoload'
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/169 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index f243db9955..df408f8367 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -58,7 +58,6 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
                   'granularity': granularity}
         if persistent:
             params['persistent'] = True
-            params['autoload'] = True
 
         result = vm.qmp('block-dirty-bitmap-add', **params)
         self.assert_qmp(result, 'return', {});
-- 
2.11.1
