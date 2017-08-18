Received: from eggs.gnu.org ([2001:4830:134:3::10]:58224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diiEq-0000GJ-39
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diiEm-0007kQ-SV
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:27:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1diiEm-0007hq-Ls
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:27:00 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Fri, 18 Aug 2017 16:26:06 +0200
Message-Id: <20170818142613.32394-4-ldoktor@redhat.com>
In-Reply-To: <20170818142613.32394-1-ldoktor@redhat.com>
References: <20170818142613.32394-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 03/10] qemu.py: Use iteritems rather than
 keys()
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

Let's avoid creating an in-memory list of keys and query for each value
and use `iteritems` which is an iterator of key-value pairs.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 scripts/qemu.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 5d09de4..db21407 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -186,11 +186,11 @@ class QEMUMachine(object):
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args =3D dict()
-        for key in args.keys():
+        for key, value in args.iteritems():
             if conv_keys:
-                qmp_args[key.translate(self.underscore_to_dash)] =3D arg=
s[key]
+                qmp_args[key.translate(self.underscore_to_dash)] =3D val=
ue
             else:
-                qmp_args[key] =3D args[key]
+                qmp_args[key] =3D value
=20
         return self._qmp.cmd(cmd, args=3Dqmp_args)
=20
--=20
2.9.4
