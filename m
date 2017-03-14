Received: from eggs.gnu.org ([2001:4830:134:3::10]:36677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9f-0003Te-Ja
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9e-0006dP-Pp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:35 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9e-0006cs-Jk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:34 -0400
Received: by mail-wm0-x242.google.com with SMTP id z63so594581wmg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:11 +0100
Message-Id: <1489508300-48184-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/18] util: Removed unneeded header from path.c
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

From: Suramya Shah <shah.suramya@gmail.com>

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170310163948.7567-1-shah.suramya@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
