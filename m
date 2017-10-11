Received: from eggs.gnu.org ([2001:4830:134:3::10]:50081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M67-0006Ka-Ve
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e2M66-0000kV-V5
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:51:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 11 Oct 2017 15:50:59 -0300
Message-Id: <20171011185103.26259-2-ehabkost@redhat.com>
In-Reply-To: <20171011185103.26259-1-ehabkost@redhat.com>
References: <20171011185103.26259-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] iotests: Set up Python logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Set up Python logging module instead of relying on
QEMUMachine._debug to enable debugging messages.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170927130339.21444-3-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 1af117e37d..36a7757aaf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,6 +28,7 @@ import qtest
 import struct
 import json
 import signal
+import logging
=20
=20
 # This will not work if arguments contain spaces but is necessary if we
@@ -467,6 +468,8 @@ def main(supported_fmts=3D[], supported_oses=3D['linu=
x']):
     else:
         output =3D StringIO.StringIO()
=20
+    logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
+
     class MyTestRunner(unittest.TextTestRunner):
         def __init__(self, stream=3Doutput, descriptions=3DTrue, verbosi=
ty=3Dverbosity):
             unittest.TextTestRunner.__init__(self, stream, descriptions,=
 verbosity)
--=20
2.13.6
