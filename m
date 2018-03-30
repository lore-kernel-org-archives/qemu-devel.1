Received: from eggs.gnu.org ([2001:4830:134:3::10]:41027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlt-0005Un-M8
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlq-0006PP-NN
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:53 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Mar 2018 18:16:34 +0300
Message-Id: <1522422996-14235-2-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] iotests.py: improve verify_image_format
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add an assert (we don't want set both arguments) and remove
duplication.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b5d7945..83c454d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -532,9 +532,9 @@ def notrun(reason):
     sys.exit(0)
 
 def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
-    if supported_fmts and (imgfmt not in supported_fmts):
-        notrun('not suitable for this image format: %s' % imgfmt)
-    if unsupported_fmts and (imgfmt in unsupported_fmts):
+    assert not (supported_fmts and unsupported_fmts)
+    not_sup = supported_fmts and (imgfmt not in supported_fmts)
+    if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
 
 def verify_platform(supported_oses=['linux']):
-- 
2.7.4
