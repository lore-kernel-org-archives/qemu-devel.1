Received: from eggs.gnu.org ([2001:4830:134:3::10]:52788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0e-0000x5-0C
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0a-0006iK-P1
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 10:03:36 -0300
Message-Id: <20170927130339.21444-3-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-1-ehabkost@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] iotests: Set up Python logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Set up Python logging module instead of relying on
QEMUMachine._debug to enable debugging messages.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 1af117e37d..36a7757aaf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,6 +28,7 @@ import qtest
 import struct
 import json
 import signal
+import logging
 
 
 # This will not work if arguments contain spaces but is necessary if we
@@ -467,6 +468,8 @@ def main(supported_fmts=[], supported_oses=['linux']):
     else:
         output = StringIO.StringIO()
 
+    logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
+
     class MyTestRunner(unittest.TextTestRunner):
         def __init__(self, stream=output, descriptions=True, verbosity=verbosity):
             unittest.TextTestRunner.__init__(self, stream, descriptions, verbosity)
-- 
2.13.5
