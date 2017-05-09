Received: from eggs.gnu.org ([2001:4830:134:3::10]:44182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Ac-00086G-Fj
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AX-0007bT-P3
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AX-0007af-Jb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6F5E7F6A4
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:45 +0200
Message-Id: <1494317205-2211-29-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 28/28] qmp-shell: improve help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Describe the arguments & fix the tool name.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170504125432.21653-5-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qmp-shell | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 5986e37..860ffb2 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -396,7 +396,11 @@ def die(msg):
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
2.7.4
