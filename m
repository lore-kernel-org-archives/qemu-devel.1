Received: from eggs.gnu.org ([2001:4830:134:3::10]:57142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXgF-0003Fp-MP
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXgF-0006xz-0n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dhXgE-0006wy-RG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:30 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Tue, 15 Aug 2017 10:57:32 +0200
Message-Id: <20170815085732.9794-11-ldoktor@redhat.com>
In-Reply-To: <20170815085732.9794-1-ldoktor@redhat.com>
References: <20170815085732.9794-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 10/10] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

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
