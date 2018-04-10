Received: from eggs.gnu.org ([2001:4830:134:3::10]:51859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLY-0002Yz-GI
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLU-0006IE-KG
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Apr 2018 17:37:42 +0200
Message-Id: <20180410153748.22505-2-kwolf@redhat.com>
In-Reply-To: <20180410153748.22505-1-kwolf@redhat.com>
References: <20180410153748.22505-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] iotests.py: support unsupported_fmts in
 main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b5d7945af8..1623257e32 100644
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
2.13.6
