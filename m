Received: from eggs.gnu.org ([2001:4830:134:3::10]:50259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbW-0003UK-Jl
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbT-0001cW-Jt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evSbT-0001bF-8H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 15:55:01 -0300
Message-Id: <20180312185503.5746-2-ehabkost@redhat.com>
In-Reply-To: <20180312185503.5746-1-ehabkost@redhat.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] qemu.py: Use items() instead of iteritems()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

items() is less efficient on Python 2.x, but makes the code work
on both Python 2 and Python 3.

Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 305a946562..08a3e9af5a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -277,7 +277,7 @@ class QEMUMachine(object):
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args =3D dict()
-        for key, value in args.iteritems():
+        for key, value in args.items():
             if conv_keys:
                 qmp_args[key.replace('_', '-')] =3D value
             else:
--=20
2.14.3
