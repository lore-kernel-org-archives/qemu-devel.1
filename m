Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utg-0007l7-Lz
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utc-00075p-Bb
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:32 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utc-00071G-4Z
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:28 -0400
Received: by mail-wm0-x242.google.com with SMTP id r82so4636653wme.0
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:02 +0200
Message-Id: <1523034681-33787-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/20] sys_membarrier: fix up include directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bruce Rogers <brogers@suse.com>

From: Bruce Rogers <brogers@suse.com>

Our rule right now is to use <> for external headers only.
util/sys_membarrier.c violates that. Fix it up.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-Id: <20180329151018.15319-1-brogers@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/sys_membarrier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/sys_membarrier.c b/util/sys_membarrier.c
index 8dcb53e..1362c0c 100644
--- a/util/sys_membarrier.c
+++ b/util/sys_membarrier.c
@@ -6,9 +6,9 @@
  * Author: Paolo Bonzini <pbonzini@redhat.com>
  */
 
-#include <qemu/osdep.h>
-#include <qemu/sys_membarrier.h>
-#include <qemu/error-report.h>
+#include "qemu/osdep.h"
+#include "qemu/sys_membarrier.h"
+#include "qemu/error-report.h"
 
 #ifdef CONFIG_LINUX
 #include <linux/membarrier.h>
-- 
1.8.3.1
