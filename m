Received: from eggs.gnu.org ([2001:4830:134:3::10]:36844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNRb-0004Im-5G
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNRX-0002vu-1y
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daNRW-0002vK-RF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:42 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Wed, 26 Jul 2017 16:35:43 +0200
Message-Id: <20170726143543.2530-15-ldoktor@redhat.com>
In-Reply-To: <20170726143543.2530-1-ldoktor@redhat.com>
References: <20170726143543.2530-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 14/14] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, jsnow@redhat.com

No actual code changes, just few pylint/style fixes.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 scripts/qtest.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index ab183c0..df0daf2 100644
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
2.9.4
