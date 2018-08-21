Received: from eggs.gnu.org ([2001:4830:134:3::10]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1fsAOp-0006kw-Gd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1fsANe-00040V-1n
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:23:50 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:36240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1fsANd-0003wS-NO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:23:45 -0400
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Tue, 21 Aug 2018 20:23:24 +0300
Message-ID: <20180821172324.29331-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] char: Enable build of pty on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

For some reason __APPLE__ was not checked in pty code. pty chardev
should be available on macOS, according to man page.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 chardev/char-pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 68fd4e20c3..cb00257ebe 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -33,7 +33,7 @@
 
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
-    || defined(__GLIBC__)
+    || defined(__GLIBC__) || defined(__APPLE__)
 
 typedef struct {
     Chardev parent;
-- 
2.15.2 (Apple Git-101.1)
