Received: from eggs.gnu.org ([2001:4830:134:3::10]:43786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F94-0008RC-5V
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F92-00089X-Jo
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F92-00085i-8b
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8t-0006vI-PA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:55 +0100
Message-Id: <1492706470-10921-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/24] arm/kvm: Remove trailing newlines from
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 1491629987-6826-1-git-send-email-chugh.ishani@research.iiit.ac.in
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
