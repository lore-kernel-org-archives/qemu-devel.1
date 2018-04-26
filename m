Received: from eggs.gnu.org ([2001:4830:134:3::10]:43185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjdC-0003HM-NF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd7-0000hB-KE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:56 +0300
Message-Id: <20180426161958.2872-16-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 15/17] iotest 139: skip testcases using
 disabled drivers
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
 tests/qemu-iotests/139 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index cc7fe337f3..ca932a5c29 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -326,6 +326,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
         #self.delBlockDriverState('mirror0')
 
     def testBlkDebug(self):
+        if not iotests.supports_format('blkdebug'):
+            return
         self.addBlkDebug('debug0', 'node0')
         # 'node0' is used by the blkdebug node
         self.delBlockDriverState('node0', expect_error = True)
@@ -334,6 +336,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState('node0', False)
 
     def testBlkVerify(self):
+        if not iotests.supports_format('blkverify'):
+            return
         self.addBlkVerify('verify0', 'node0', 'node1')
         # We cannot remove the children of a blkverify device
         self.delBlockDriverState('node0', expect_error = True)
-- 
2.14.3
