Received: from eggs.gnu.org ([2001:4830:134:3::10]:37335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHX-0000V4-GW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHW-0006It-Q3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6GHW-0006Il-Ji
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CBDC61D38
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:54:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 16:54:31 +0400
Message-Id: <20170504125432.21653-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-1-marcandre.lureau@redhat.com>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] qmp-shell: don't show version greeting if
 unavailable
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

qemu-ga doesn't have greeting.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qmp/qmp-shell | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 04b8fa3eae..db24c87cdd 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -265,6 +265,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
=20
     def show_banner(self, msg=3D'Welcome to the QMP low-level shell!'):
         print msg
+        if not self._greeting:
+            print 'Connected'
+            return
         version =3D self._greeting['QMP']['version']['qemu']
         print 'Connected to QEMU %d.%d.%d\n' % (version['major'],version=
['minor'],version['micro'])
=20
--=20
2.12.0.191.gc5d8de91d
