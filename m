Received: from eggs.gnu.org ([2001:4830:134:3::10]:57326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV307-00063E-Pq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV304-0005hf-LD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV304-0005h2-Eq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 18 Jun 2018 19:51:30 -0300
Message-Id: <20180618225131.13113-3-ehabkost@redhat.com>
In-Reply-To: <20180618225131.13113-1-ehabkost@redhat.com>
References: <20180618225131.13113-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] Revert "docker.py: Python 2.6 argparse
 compatibility"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit c2d3189667409561772e8c1e5615c5166cd8aa2c.

scripts/argparse.py was removed from the tree, so we don't need
this hack anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 306e14cf69..39f4f318f8 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -14,14 +14,12 @@
 from __future__ import print_function
 import os
 import sys
-sys.path.append(os.path.join(os.path.dirname(__file__),
-                             '..', '..', 'scripts'))
-import argparse
 import subprocess
 import json
 import hashlib
 import atexit
 import uuid
+import argparse
 import tempfile
 import re
 import signal
-- 
2.18.0.rc1.1.g3f1ff2140
