Received: from eggs.gnu.org ([2001:4830:134:3::10]:37548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1cwj6o-0004xr-9W
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1cwj6l-0000mZ-6z
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:40:26 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:58502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1cwj6k-0000lu-JD
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:40:23 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Sat,  8 Apr 2017 11:09:47 +0530
Message-Id: <1491629987-6826-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH] Removed trailing newline from error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 target/arm/kvm64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6111109..a16abc8 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -940,7 +940,7 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
              * single step at this point so something has gone wrong.
              */
             error_report("%s: guest single-step while debugging unsupported"
-                         " (%"PRIx64", %"PRIx32")\n",
+                         " (%"PRIx64", %"PRIx32")",
                          __func__, env->pc, debug_exit->hsr);
             return false;
         }
@@ -965,7 +965,7 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
         break;
     }
     default:
-        error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")\n",
+        error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")",
                      __func__, debug_exit->hsr, env->pc);
     }
 
-- 
2.7.4
