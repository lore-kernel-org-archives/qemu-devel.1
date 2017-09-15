Received: from eggs.gnu.org ([2001:4830:134:3::10]:56572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0C0-0005Yi-GC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bx-000273-DI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0Bx-000243-7x
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:34 -0300
Message-Id: <20170915233739.26860-11-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/15] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

No actual code changes, just few pylint/style fixes.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20170818142613.32394-11-ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qtest.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index ab183c0635..df0daf26ca 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -11,14 +11,11 @@
 # Based on qmp.py.
 #
=20
-import errno
 import socket
-import string
 import os
-import subprocess
-import qmp.qmp
 import qemu
=20
+
 class QEMUQtestProtocol(object):
     def __init__(self, address, server=3DFalse):
         """
@@ -83,8 +80,10 @@ class QEMUQtestMachine(qemu.QEMUMachine):
                  socket_scm_helper=3DNone):
         if name is None:
             name =3D "qemu-%d" % os.getpid()
-        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dname=
, test_dir=3Dtest_dir,
-                                               socket_scm_helper=3Dsocke=
t_scm_helper)
+        super(QEMUQtestMachine,
+              self).__init__(binary, args, name=3Dname, test_dir=3Dtest_=
dir,
+                             socket_scm_helper=3Dsocket_scm_helper)
+        self._qtest =3D None
         self._qtest_path =3D os.path.join(test_dir, name + "-qtest.sock"=
)
=20
     def _base_args(self):
--=20
2.13.5
