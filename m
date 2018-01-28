Received: from eggs.gnu.org ([2001:4830:134:3::10]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBe-0003Eb-AM
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBZ-0000Y8-S2
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:34 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBZ-0000X3-LX
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:29 -0500
Received: by mail-pf0-x244.google.com with SMTP id k19so3261897pfj.5
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:23 -0800
Message-Id: <20180128231528.22719-39-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 38/43] target/hppa: Enable MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 6 ++++++
 configure         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 70af823a15..7640c81221 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -42,6 +42,12 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #endif
 
+/* PA-RISC 1.x processors have a strong memory model.  */
+/* ??? While we do not yet implement PA-RISC 2.0, those processors have
+   a weak memory model, but with TLB bits that force ordering on a per-page
+   basis.  It's probably easier to fall back to a strong memory model.  */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #define CPUArchState struct CPUHPPAState
 
 #include "exec/cpu-defs.h"
diff --git a/configure b/configure
index 96dee6572c..302fdc92ff 100755
--- a/configure
+++ b/configure
@@ -6555,6 +6555,7 @@ case "$target_name" in
   cris)
   ;;
   hppa)
+    mttcg="yes"
   ;;
   lm32)
   ;;
-- 
2.14.3
