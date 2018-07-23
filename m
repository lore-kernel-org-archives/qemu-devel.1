Received: from eggs.gnu.org ([2001:4830:134:3::10]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDf-00026D-D9
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fhjDe-0007vb-K4
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:22:19 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 23 Jul 2018 18:22:07 -0400
Message-Id: <20180723222210.11077-5-jsnow@redhat.com>
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
References: <20180723222210.11077-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 4/7] iotests: 169: actually test block
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

Presently, we emulate a block migration by just using a different
target file. Update the test to actually request a block migration.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/169 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index df408f8367..87edc85f43 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -89,6 +89,9 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         mig_caps = [{'capability': 'events', 'state': True}]
         if migrate_bitmaps:
             mig_caps.append({'capability': 'dirty-bitmaps', 'state': True})
+        if not shared_storage:
+            mig_caps.append({'capability': 'block', 'state': True})
+
 
         result = self.vm_a.qmp('migrate-set-capabilities',
                                capabilities=mig_caps)
-- 
2.14.4
