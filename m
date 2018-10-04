Received: from eggs.gnu.org ([2001:4830:134:3::10]:46147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tFB-0003kP-4M
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tF6-0004Oa-TT
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g7tF4-0004CQ-P6
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:19:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 Oct 2018 23:19:41 -0300
Message-Id: <20181004021943.22724-3-ehabkost@redhat.com>
In-Reply-To: <20181004021943.22724-1-ehabkost@redhat.com>
References: <20181004021943.22724-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] Revert "docker.py: Python 2.6 argparse
 compatibility"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This reverts commit c2d3189667409561772e8c1e5615c5166cd8aa2c.

scripts/argparse.py was removed from the tree, so we don't need
this hack anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180618225131.13113-3-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d3006d4dae..44d5f7493b 100755
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
--=20
2.18.0.rc1.1.g3f1ff2140
