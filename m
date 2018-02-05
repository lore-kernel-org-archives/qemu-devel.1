Received: from eggs.gnu.org ([2001:4830:134:3::10]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipst-0001XY-Ud
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipss-0006l1-Vh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipss-0006h6-R1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:10 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:43 -0200
Message-Id: <20180205230900.11344-5-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/21] qapi: adapt to moved location of StringIO
 module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-5-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 514b7bb5a4..514cca44bf 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -22,6 +22,10 @@ try:
     from collections import OrderedDict
 except:
     from ordereddict import OrderedDict
+try:
+    from StringIO import StringIO
+except ImportError:
+    from io import StringIO
=20
 builtin_types =3D {
     'null':     'QTYPE_QNULL',
@@ -1995,8 +1999,7 @@ def open_output(output_dir, do_c, do_h, prefix, c_f=
ile, h_file,
         if really:
             return open(name, opt)
         else:
-            import StringIO
-            return StringIO.StringIO()
+            return StringIO()
=20
     fdef =3D maybe_open(do_c, c_file, 'w')
     fdecl =3D maybe_open(do_h, h_file, 'w')
--=20
2.14.3
