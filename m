Received: from eggs.gnu.org ([2001:4830:134:3::10]:53387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF5-0005vq-Pf
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF2-0007jQ-Kn
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:03 -0400
Received: from mifritscher.de ([188.40.170.105]:32900
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF2-0007ip-EB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:00 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:07 +0200
Message-Id: <20170929111323.6308-3-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 02/18] #include <sys/vfs.h> is not available
 under Windows.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 fsdev/file-op-9p.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 474c79d003..3fc7b0532f 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -16,7 +16,9 @@
 
 #include <dirent.h>
 #include <utime.h>
-#include <sys/vfs.h>
+#ifndef _WIN32
+# include <sys/vfs.h>
+#endif
 #include "qemu-fsdev-throttle.h"
 
 #define SM_LOCAL_MODE_BITS    0600
-- 
2.13.2.windows.1
