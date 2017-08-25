Received: from eggs.gnu.org ([2001:4830:134:3::10]:39638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dlH29-0000iw-93
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dlH25-0005S6-Bg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dlH25-0005Rc-6M
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 25 Aug 2017 16:57:31 +0100
Message-Id: <20170825155732.15665-3-stefanha@redhat.com>
In-Reply-To: <20170825155732.15665-1-stefanha@redhat.com>
References: <20170825155732.15665-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] docker.py: Python 2.6 argparse
 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chugh.ishani@research.iiit.ac.in, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Add the scripts/ directory to sys.path so Python 2.6 will be able to
import argparse.

Cc: Fam Zheng <famz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/docker/docker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ee40ca04d9..81c87ee329 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -13,12 +13,14 @@
 
 import os
 import sys
+sys.path.append(os.path.join(os.path.dirname(__file__),
+                             '..', '..', 'scripts'))
+import argparse
 import subprocess
 import json
 import hashlib
 import atexit
 import uuid
-import argparse
 import tempfile
 import re
 import signal
-- 
2.13.5
