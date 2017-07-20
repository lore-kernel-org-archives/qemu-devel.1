Received: from eggs.gnu.org ([2001:4830:134:3::10]:51381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYET0-0005Bn-8C
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESx-0002f2-1v
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYESw-0002et-Rm
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11107796FE
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:29:41 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Thu, 20 Jul 2017 18:28:14 +0200
Message-Id: <20170720162815.19802-11-ldoktor@redhat.com>
In-Reply-To: <20170720162815.19802-1-ldoktor@redhat.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/11] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ldoktor@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

No actual code changes, just few pylint/style fixes.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 scripts/qtest.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index d5aecb5..e4b5788 100644
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
@@ -83,8 +80,11 @@ class QEMUQtestMachine(qemu.QEMUMachine):
                  socket_scm_helper=3DNone):
         if name is None:
             name =3D "qemu-%d" % os.getpid()
-        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dname=
, test_dir=3Dtest_dir,
-                                               socket_scm_helper=3Dsocke=
t_scm_helper)
+        scm_helper =3D socket_scm_helper
+        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dname=
,
+                                               test_dir=3Dtest_dir,
+                                               socket_scm_helper=3Dscm_h=
elper)
+        self._qtest =3D None
         self._qtest_path =3D os.path.join(test_dir, name + "-qtest.sock"=
)
=20
     def _base_args(self):
--=20
2.9.4
