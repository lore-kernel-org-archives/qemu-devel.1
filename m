Received: from eggs.gnu.org ([2001:4830:134:3::10]:36754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNRH-00041A-JE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNRG-0002pt-RT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daNRG-0002pO-Kw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:37:26 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Wed, 26 Jul 2017 16:35:41 +0200
Message-Id: <20170726143543.2530-13-ldoktor@redhat.com>
In-Reply-To: <20170726143543.2530-1-ldoktor@redhat.com>
References: <20170726143543.2530-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/14] qmp.py: Avoid "has_key" usage
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

The "has_key" is deprecated in favor of "__in__" operator.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 scripts/qmp/qmp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 95ff5cc..f2f5a9b 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -197,7 +197,7 @@ class QEMUMonitorProtocol(object):
         Build and send a QMP command to the monitor, report errors if an=
y
         """
         ret =3D self.cmd(cmd, kwds)
-        if ret.has_key('error'):
+        if "error" in ret:
             raise Exception(ret['error']['desc'])
         return ret['return']
=20
--=20
2.9.4
