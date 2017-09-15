Received: from eggs.gnu.org ([2001:4830:134:3::10]:56444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bl-0005N1-9Q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0Bk-0001md-EQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0Bk-0001mM-8D
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:32 -0300
Message-Id: <20170915233739.26860-9-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/15] qmp.py: Avoid "has_key" usage
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

The "has_key" is deprecated in favor of "__in__" operator.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170818142613.32394-9-ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qmp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 95ff5cc39a..f2f5a9b296 100644
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
2.13.5
