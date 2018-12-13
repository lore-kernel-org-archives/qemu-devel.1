Received: from eggs.gnu.org ([2001:4830:134:3::10]:42575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9D-0002Ry-4S
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9B-0001QS-Q0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:43 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Dec 2018 20:50:11 -0500
Message-Id: <20181213015013.15350-6-jsnow@redhat.com>
In-Reply-To: <20181213015013.15350-1-jsnow@redhat.com>
References: <20181213015013.15350-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/7] iotests: add filter_generated_node_ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

To mimic the common filter of the same name, but for the python tests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a34e66813a..9595429fea 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -239,6 +239,9 @@ def filter_testfiles(msg):
     prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
     return msg.replace(prefix, 'TEST_DIR/PID-')
 
+def filter_generated_node_ids(msg):
+    return re.sub("#block[0-9]+", "NODE_NAME", msg)
+
 def filter_img_info(output, filename):
     lines = []
     for line in output.split('\n'):
-- 
2.17.2
