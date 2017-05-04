Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHc-0000Z2-JQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6GHb-0006Jy-UF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6GHb-0006Jn-Oq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:54:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A140B7D4E1
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:54:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 16:54:32 +0400
Message-Id: <20170504125432.21653-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-1-marcandre.lureau@redhat.com>
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] qmp-shell: improve help
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

Describe the arguments & fix the tool name.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qmp/qmp-shell | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index db24c87cdd..fce1ab6c49 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -375,7 +375,11 @@ def die(msg):
 def fail_cmdline(option=3DNone):
     if option:
         sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % opt=
ion)
-    sys.stderr.write('qemu-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX sock=
et path> | < TCP address:port >\n')
+    sys.stderr.write('qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX socke=
t path> | < TCP address:port >\n')
+    sys.stderr.write('    -v     Verbose (echo command sent and received=
)\n')
+    sys.stderr.write('    -p     Pretty-print JSON\n')
+    sys.stderr.write('    -H     Use HMP interface\n')
+    sys.stderr.write('    -N     Skip negotiate (for qemu-ga)\n')
     sys.exit(1)
=20
 def main():
--=20
2.12.0.191.gc5d8de91d
