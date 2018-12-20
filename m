Received: from eggs.gnu.org ([2001:4830:134:3::10]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6g-0004MP-3L
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6e-0007xV-BZ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:37 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:47 -0500
Message-Id: <20181220022952.20493-7-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 06/11] iotests: add filter_generated_node_ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

To mimic the common filter of the same name, but for the python tests.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
