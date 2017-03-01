Received: from eggs.gnu.org ([2001:4830:134:3::10]:34102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cj5BD-0005Fx-7y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cj5B9-0006lu-9w
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:24:35 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1cj5B9-0006ki-3U
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:24:31 -0500
Received: by mail-pg0-x243.google.com with SMTP id x17so6012130pgi.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 06:24:29 -0800 (PST)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Wed,  1 Mar 2017 19:53:20 +0530
Message-Id: <20170301142320.8328-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH]  Removed header qemu-common.h from path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Suramya Shah <shah.suramya@gmail.com>

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
 util/path.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/util/path.c b/util/path.c
index 5479f76..46a6098 100644
--- a/util/path.c
+++ b/util/path.c
@@ -6,8 +6,7 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 #include <dirent.h>
-#include "qemu-common.h"
-#include "qemu/cutils.h"
+:#include "qemu/cutils.h"
 #include "qemu/path.h"
 
 struct pathelem
-- 
2.9.3
