Received: from eggs.gnu.org ([2001:4830:134:3::10]:57365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV30A-00065M-JT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV309-0005lR-Pm
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV309-0005kw-Jt
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 18 Jun 2018 19:51:31 -0300
Message-Id: <20180618225131.13113-4-ehabkost@redhat.com>
In-Reply-To: <20180618225131.13113-1-ehabkost@redhat.com>
References: <20180618225131.13113-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] Revert "tests: migration/guestperf Python
 2.6 argparse compatibility"
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

This reverts commit 0ea47d0f36112f0f38661e2e430edf32737c7f43.

scripts/argparse.py was removed from the tree, so we don't
need this hack anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/migration/guestperf/shell.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index a6b8cec1e0..61d2abbaad 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -19,14 +19,12 @@ from __future__ import print_function
 #
 
 
-import os
-import os.path
-import sys
-sys.path.append(os.path.join(os.path.dirname(__file__),
-                             '..', '..', '..', 'scripts'))
 import argparse
 import fnmatch
+import os
+import os.path
 import platform
+import sys
 import logging
 
 from guestperf.hardware import Hardware
-- 
2.18.0.rc1.1.g3f1ff2140
