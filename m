Received: from eggs.gnu.org ([2001:4830:134:3::10]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHS-0000RY-8x
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHR-0006Hl-Ik
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6GHR-0006Hc-CD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B87BC04B948
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:54:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 16:54:30 +0400
Message-Id: <20170504125432.21653-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-1-marcandre.lureau@redhat.com>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] qmp-shell: ignore query-commands error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

qemu-ga doesn't implement it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qmp/qmp-shell | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index f80d02312a..04b8fa3eae 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -126,7 +126,10 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         return arg
=20
     def _fill_completion(self):
-        for cmd in self.cmd('query-commands')['return']:
+        cmds =3D self.cmd('query-commands')
+        if cmds.has_key('error'):
+            return
+        for cmd in cmds['return']:
             self._completer.append(cmd['name'])
=20
     def __completer_setup(self):
--=20
2.12.0.191.gc5d8de91d
