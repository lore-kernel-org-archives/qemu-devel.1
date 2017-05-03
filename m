Received: from eggs.gnu.org ([2001:4830:134:3::10]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5sw8-0001qx-S6
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5sw5-0004rW-Qp
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:59:16 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 13:59:09 +0200
Message-Id: <20170503115909.4490-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Update paths for main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, lvivier@redhat.com

Moved by c2b38b2 ("block: move AioContext, QEMUTimer, main-loop to
libqemuutil"), let's update MAINTAINERS too.

Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62d62a6675..b54c0568c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1307,8 +1307,8 @@ Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: cpus.c
-F: main-loop.c
-F: qemu-timer.c
+F: util/main-loop.c
+F: util/qemu-timer.c
 F: vl.c
 
 Human Monitor (HMP)
-- 
2.12.2
