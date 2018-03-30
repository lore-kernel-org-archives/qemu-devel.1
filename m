Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlt-0005Uq-MR
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1vlr-0006QS-1E
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:16:53 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Mar 2018 18:16:35 +0300
Message-Id: <1522422996-14235-3-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] iotests.py: support unsupported_fmts in
 main()
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 83c454d..89fe446 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -553,7 +553,8 @@ def verify_quorum():
     if not supports_quorum():
         notrun('quorum support missing')
 
-def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[]):
+def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
+         unsupported_fmts=[]):
     '''Run tests'''
 
     global debug
@@ -568,7 +569,7 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[]):
 
     debug = '-d' in sys.argv
     verbosity = 1
-    verify_image_format(supported_fmts)
+    verify_image_format(supported_fmts, unsupported_fmts)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
 
-- 
2.7.4
