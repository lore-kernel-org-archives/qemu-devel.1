Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjdC-0003HO-O1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd7-0000hK-Ny
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:55 +0300
Message-Id: <20180426161958.2872-15-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 14/17] iotest 124: skip testcases using
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
 tests/qemu-iotests/124 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 8e76e62f93..f26c9170fb 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -401,6 +401,8 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
 
 
     def do_transaction_failure_test(self, race=False):
+        if not iotests.supports_format('blkdebug'):
+            return
         # Create a second drive, with pattern:
         drive1 = self.add_node('drive1')
         self.img_create(drive1['file'], drive1['fmt'])
@@ -581,6 +583,9 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         afterwards and verify that the backup created is correct.
         '''
 
+        if not iotests.supports_format('blkdebug'):
+            return
+
         drive0 = self.drives[0]
         result = self.vm.qmp('blockdev-add',
             node_name=drive0['id'],
-- 
2.14.3
