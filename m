Received: from eggs.gnu.org ([2001:4830:134:3::10]:52707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foCYQ-0003As-FJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 14:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foCYN-0004Yb-C5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 14:54:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1foCYN-0004Xu-2b
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 14:54:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 10 Aug 2018 20:53:20 +0200
Message-Id: <20180810185321.20017-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: cleanup msync output in strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index ff8bb19f5f..c4a0e3510a 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -624,7 +624,7 @@
 { TARGET_NR_msgsnd, "msgsnd" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_msync
-{ TARGET_NR_msync, "msync" , NULL, NULL, NULL },
+{ TARGET_NR_msync, "msync" , "%s(%#x,%d,%x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_multiplexer
 { TARGET_NR_multiplexer, "multiplexer" , NULL, NULL, NULL },
-- 
2.17.1
