Received: from eggs.gnu.org ([2001:4830:134:3::10]:49871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cmNah-0001HY-MC
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cmNae-0002cN-JP
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:40:31 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1cmNae-0002bO-CW
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:40:28 -0500
Received: by mail-pg0-x243.google.com with SMTP id b5so10825669pgg.1
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 08:40:26 -0800 (PST)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Fri, 10 Mar 2017 22:09:48 +0530
Message-Id: <20170310163948.7567-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH v4] util: Removed unneeded header from path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, shah.suramya@gmail.com

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
--- 
qemu-common.h is no longer necessary as of refactoring done in commit f348b6d.
 util/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/path.c b/util/path.c
index 5479f76..7f9fc27 100644
--- a/util/path.c
+++ b/util/path.c
@@ -6,7 +6,6 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 #include <dirent.h>
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 
-- 
2.9.3
