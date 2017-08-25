Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dlH29-0000iu-8P
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dlH27-0005T7-Cj
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dlH27-0005Sc-7A
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 25 Aug 2017 16:57:32 +0100
Message-Id: <20170825155732.15665-4-stefanha@redhat.com>
In-Reply-To: <20170825155732.15665-1-stefanha@redhat.com>
References: <20170825155732.15665-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] tests: migration/guestperf Python 2.6
 argparse compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chugh.ishani@research.iiit.ac.in, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Add the scripts/ directory to sys.path so Python 2.6 will be able to
import argparse.

Cc: Daniel P. Berrange <berrange@redhat.com>
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
