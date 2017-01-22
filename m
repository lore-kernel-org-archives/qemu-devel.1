Received: from eggs.gnu.org ([2001:4830:134:3::10]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cVILw-0004KZ-Bf
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 08:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cVILt-0000Wm-8n
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 08:38:40 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Sun, 22 Jan 2017 14:38:31 +0100
Message-Id: <20170122133831.26150-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] qapi2texi: Suppress unwanted commas in
 generated output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>

Parts of the code use #optional followed by a comma.

We don't want that comma to be part of the generated documentation,
so remove it, too.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

I added the generated documentation to https://qemu.weilnetz.de/doc/.

See https://qemu.weilnetz.de/doc/qemu-qmp-ref.html for an
example of the output without this patch (look for ", net").

We could also remove the commas from the code, but I think
that removing them programmatically is more robust (and also
allows people placing commas as they like).

Regards
Stefan

 scripts/qapi2texi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 83ded95c2d..65c4aecfaf 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -146,7 +146,7 @@ def texi_body(doc):
             desc = str(section)
             opt = ''
             if "#optional" in desc:
-                desc = desc.replace("#optional", "")
+                desc = re.sub("#optional,?", "", desc)
                 opt = ' (optional)'
             body += "@item @code{'%s'}%s\n%s\n" % (arg, opt,
                                                    texi_format(desc))
-- 
2.11.0
