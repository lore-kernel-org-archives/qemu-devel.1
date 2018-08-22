Received: from eggs.gnu.org ([2001:4830:134:3::10]:45682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsQcU-0000ZJ-58
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsQX8-0000y8-TL
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:38:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fsQX8-0000xT-OA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:38:38 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Aug 2018 12:38:35 +0200
Message-Id: <20180822103835.26129-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] char-pty: remove unnecessary #ifdef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: r.bolshakov@yadro.com

For some reason __APPLE__ was not checked in pty code.  However, the #ifdef
is redundant: this file is already compiled only if CONFIG_POSIX, same as
util/qemu-openpty.c which it uses.

Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-pty.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 68fd4e20c3..e8d9a53476 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -31,10 +31,6 @@
 
 #include "chardev/char-io.h"
 
-#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
-    || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
-    || defined(__GLIBC__)
-
 typedef struct {
     Chardev parent;
     QIOChannel *ioc;
@@ -299,5 +295,3 @@ static void register_types(void)
 }
 
 type_init(register_types);
-
-#endif
-- 
2.17.1
