Received: from eggs.gnu.org ([2001:4830:134:3::10]:45232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF28-000419-6I
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-0002Hf-FO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF27-0002Gz-71
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:49 -0400
Message-Id: <20181029212501.5897-8-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 07/19] iotests: 169: drop deprecated 'autoload'
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.14.5
