Received: from eggs.gnu.org ([2001:4830:134:3::10]:40316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIB-0006Oh-C4
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIA-0006XJ-An
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:34 -0400
Message-Id: <20180512012537.22478-10-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 09/12] qapi/block-core: add BitmapMapping
 and BitmapEntry structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

Add two new structures for detailing the marked regions of bitmaps as
saved in e.g. qcow2 files.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8f33f41ce7..de8ad73a78 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -298,6 +298,38 @@
            'zero': 'bool', 'depth': 'int', '*offset': 'int',
            '*filename': 'str' } }
 
+##
+# @BitmapEntry:
+#
+# Dirty Bitmap region information for a virtual block range
+#
+# @offset: the start byte of the dirty virtual range
+#
+# @length: the number of bytes of the dirty virtual range
+#
+# Since: 2.13
+#
+##
+{ 'struct': 'BitmapEntry',
+  'data': { 'offset': 'int', 'length': 'int' } }
+
+##
+# @BitmapMapping:
+#
+# List of described regions correlated to a named bitmap.
+#
+# @name: The name of the bitmap whose range is described here
+#
+# @entries: A list of zero or more @BitmapEntry elements representing
+#           the range(s) described by the bitmap.
+#
+# Since: 2.13
+#
+##
+{ 'struct': 'BitmapMapping',
+  'data': { 'name': 'str',
+            'entries': [ 'BitmapEntry' ] } }
+
 ##
 # @BlockdevCacheInfo:
 #
-- 
2.14.3
