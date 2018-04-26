Received: from eggs.gnu.org ([2001:4830:134:3::10]:43079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd7-0003DM-9Y
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd5-0000f1-EI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:21 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:49 +0300
Message-Id: <20180426161958.2872-9-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 08/17] iotest 056: skip testcases using
 blkdebug if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/qemu-iotests/056 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 223292175a..ff40313851 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -230,6 +230,9 @@ class BackupTest(iotests.QMPTestCase):
                                  auto_dismiss=False)
 
     def dismissal_failure(self, dismissal_opt):
+        if not iotests.supports_format('blkdebug'):
+            return
+
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
         # Give blkdebug something to chew on
-- 
2.14.3
