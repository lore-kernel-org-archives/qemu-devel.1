Received: from eggs.gnu.org ([2001:4830:134:3::10]:48631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxb-0002zg-Fp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxX-0002SX-UL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:23:03 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxX-0002RN-JM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:59 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:16 +0100
Message-Id: <20170216142227.27448-4-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 03/14] linux-user: Fix s390x safe-syscall for
 z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@linaro.org>

From: Richard Henderson <rth@twiddle.net>

The LT instruction was added in the extended immediate facility
introduced with the z9-109 processor.

Cc: Riku Voipio <riku.voipio@iki.fi>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: c9bc3437a905b660561a26cd4ecc64579843267b
Suggested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/host/s390x/safe-syscall.inc.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/host/s390x/safe-syscall.inc.S b/linux-user/host/s390x/safe-syscall.inc.S
index f1b446a..414b44a 100644
--- a/linux-user/host/s390x/safe-syscall.inc.S
+++ b/linux-user/host/s390x/safe-syscall.inc.S
@@ -72,7 +72,7 @@ safe_syscall_base:
 	 */
 safe_syscall_start:
 	/* if signal_pending is non-zero, don't do the call */
-	lt	%r0,0(%r8)
+	icm	%r0,15,0(%r8)
 	jne	2f
 	svc	0
 safe_syscall_end:
-- 
2.9.3
