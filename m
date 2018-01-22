Received: from eggs.gnu.org ([2001:4830:134:3::10]:60552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT11-00066V-Rs
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0x-0006tP-R4
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:23 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0x-0006sl-LD
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:19 -0500
Received: by mail-pg0-x243.google.com with SMTP id r19so6096579pgn.1
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:43:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:14 -0800
Message-Id: <20180122034217.19593-41-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 40/43] target/hppa: Enable MTTCG
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
index 79763b254c..3df3ebd19d 100644
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
index 6d8c996c62..420d50a47d 100755
--- a/configure
+++ b/configure
@@ -6522,6 +6522,7 @@ case "$target_name" in
   cris)
   ;;
   hppa)
+    mttcg="yes"
   ;;
   lm32)
   ;;
-- 
2.14.3
