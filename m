Received: from eggs.gnu.org ([2001:4830:134:3::10]:47450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7V-0006kD-9P
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7S-0005VS-Kk
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1cEK7S-0005V6-Ao
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:34 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue,  6 Dec 2016 12:05:24 -0600
Message-Id: <1481047528-16180-2-git-send-email-wei@redhat.com>
In-Reply-To: <1481047528-16180-1-git-send-email-wei@redhat.com>
References: <1481047528-16180-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v14 1/5] arm: rename cp15.h to
 sysreg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cov@codeaurora.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, shannon.zhao@linaro.org, alistair.francis@xilinx.com, croberts@codeaurora.org, alindsay@codeaurora.org, drjones@redhat.com, andre.przywara@arm.com

To prepare for future support of ARMv8 system register, rename cp15.h file
to sysreg.h, with _ASMARM_CP15_H_ renamed to _ASMARM_SYSREG_H_ in header
file.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 arm/cstart.S                     | 2 +-
 lib/arm/asm/{cp15.h => sysreg.h} | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename lib/arm/asm/{cp15.h => sysreg.h} (94%)

diff --git a/arm/cstart.S b/arm/cstart.S
index 3943867..9822fb7 100644
--- a/arm/cstart.S
+++ b/arm/cstart.S
@@ -9,7 +9,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
-#include <asm/cp15.h>
+#include <asm/sysreg.h>
 
 #define THREAD_START_SP ((THREAD_SIZE - S_FRAME_SIZE * 8) & ~7)
 
diff --git a/lib/arm/asm/cp15.h b/lib/arm/asm/sysreg.h
similarity index 94%
rename from lib/arm/asm/cp15.h
rename to lib/arm/asm/sysreg.h
index 7690a48..3e1ad3a 100644
--- a/lib/arm/asm/cp15.h
+++ b/lib/arm/asm/sysreg.h
@@ -1,5 +1,5 @@
-#ifndef _ASMARM_CP15_H_
-#define _ASMARM_CP15_H_
+#ifndef _ASMARM_SYSREG_H_
+#define _ASMARM_SYSREG_H_
 /*
  * From the Linux kernel arch/arm/include/asm/cp15.h
  *
@@ -34,4 +34,4 @@
 #define CR_AFE	(1 << 29)	/* Access flag enable			*/
 #define CR_TE	(1 << 30)	/* Thumb exception enable		*/
 
-#endif /* _ASMARM_CP15_H_ */
+#endif /* _ASMARM_SYSREG_H_ */
-- 
1.8.3.1
