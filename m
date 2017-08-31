Received: from eggs.gnu.org ([2001:4830:134:3::10]:42691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkj-0005hZ-LU
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKki-0005zs-Qa
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKki-0005zj-KV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:23:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:22:08 +0100
Message-Id: <20170831082210.8362-14-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 13/15] tests: migration/guestperf
 Python 2.6 argparse compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Add the scripts/ directory to sys.path so Python 2.6 will be able to
import argparse.

Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Message-id: 20170825155732.15665-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/migration/guestperf/shell.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index 185c5697a6..7992459a97 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -18,12 +18,14 @@
 #
 
 
-import argparse
-import fnmatch
 import os
 import os.path
-import platform
 import sys
+sys.path.append(os.path.join(os.path.dirname(__file__),
+                             '..', '..', '..', 'scripts'))
+import argparse
+import fnmatch
+import platform
 
 from guestperf.hardware import Hardware
 from guestperf.engine import Engine
-- 
2.13.5
