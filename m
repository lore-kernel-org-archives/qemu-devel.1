Received: from eggs.gnu.org ([2001:4830:134:3::10]:46206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tFV-0003zp-QB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g7tFI-0004fk-DW
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g7tFB-0004D5-6C
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 22:20:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 Oct 2018 23:19:42 -0300
Message-Id: <20181004021943.22724-4-ehabkost@redhat.com>
In-Reply-To: <20181004021943.22724-1-ehabkost@redhat.com>
References: <20181004021943.22724-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] Revert "tests: migration/guestperf Python
 2.6 argparse compatibility"
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

This reverts commit 0ea47d0f36112f0f38661e2e430edf32737c7f43.

scripts/argparse.py was removed from the tree, so we don't
need this hack anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180618225131.13113-4-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/migration/guestperf/shell.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestpe=
rf/shell.py
index a6b8cec1e0..61d2abbaad 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -19,14 +19,12 @@ from __future__ import print_function
 #
=20
=20
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
=20
 from guestperf.hardware import Hardware
--=20
2.18.0.rc1.1.g3f1ff2140
