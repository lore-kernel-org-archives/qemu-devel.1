Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cjsjP-0002la-Ra
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cjsjM-0006pN-Mw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:19:11 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1cjsjM-0006os-GC
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:19:08 -0500
Received: by mail-pg0-x243.google.com with SMTP id 77so758971pgc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:19:07 -0800 (PST)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Sat,  4 Mar 2017 00:48:05 +0530
Message-Id: <20170303191805.1204-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH] Removed header qemu-common.h from path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, armbru@redhat.com, Suramya Shah <shah.suramya@gmail.com>

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
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
