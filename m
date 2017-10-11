Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M6E-0006Pa-Ph
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M6D-0000pj-Ol
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e2M6D-0000pI-Iy
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 11 Oct 2017 15:51:01 -0300
Message-Id: <20171011185103.26259-4-ehabkost@redhat.com>
In-Reply-To: <20171011185103.26259-1-ehabkost@redhat.com>
References: <20171011185103.26259-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] guestperf: Configure logging on all shell
 frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

The logging module will eventually replace the 'debug' parameter
in QEMUMachine and QEMUMonitorProtocol.

Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171005172013.3098-2-ehabkost@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/migration/guestperf/shell.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestpe=
rf/shell.py
index 7992459a97..b272978f47 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -26,6 +26,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__),
 import argparse
 import fnmatch
 import platform
+import logging
=20
 from guestperf.hardware import Hardware
 from guestperf.engine import Engine
@@ -147,6 +148,10 @@ class Shell(BaseShell):
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
+        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
+                                   logging.INFO if args.verbose else
+                                   logging.WARN))
+
=20
         engine =3D self.get_engine(args)
         hardware =3D self.get_hardware(args)
@@ -179,6 +184,10 @@ class BatchShell(BaseShell):
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
+        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
+                                   logging.INFO if args.verbose else
+                                   logging.WARN))
+
=20
         engine =3D self.get_engine(args)
         hardware =3D self.get_hardware(args)
@@ -231,6 +240,10 @@ class PlotShell(object):
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
+        logging.basicConfig(level=3D(logging.DEBUG if args.debug else
+                                   logging.INFO if args.verbose else
+                                   logging.WARN))
+
=20
         if len(args.reports) =3D=3D 0:
             print >>sys.stderr, "At least one report required"
--=20
2.13.6
