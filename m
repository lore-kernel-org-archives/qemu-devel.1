Received: from eggs.gnu.org ([2001:4830:134:3::10]:48903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1cc4RJ-0006UI-14
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1cc4RF-0008Gy-TK
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:12:12 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:58606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vapier@gentoo.org>) id 1cc4RF-0008Gl-Mi
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:12:09 -0500
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 10 Feb 2017 01:12:00 -0500
Message-Id: <20170210061200.15373-1-vapier@gentoo.org>
Subject: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Linux C libs are moving away from implicit header pollution with
sys/types.h

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/qemu/osdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 56c9e22405ec..6aaace6cf37f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -85,6 +85,10 @@ extern int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
+#ifdef __linux__
+#include <sys/sysmacros.h>
+#endif
+
 #ifdef __OpenBSD__
 #include <sys/signal.h>
 #endif
-- 
2.11.0
