Received: from eggs.gnu.org ([2001:4830:134:3::10]:51490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUS1-00059q-Rp
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUS0-0002Fi-VP
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:29 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeUS0-0002Es-Pt
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:28 -0500
Received: by mail-pf0-x241.google.com with SMTP id c6so4360608pfi.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:28 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:20 -0800
Message-Id: <20180124232625.30105-41-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 40/45] target/hppa: Enable MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
index 044c6fafe2..0046135db6 100755
--- a/configure
+++ b/configure
@@ -6549,6 +6549,7 @@ case "$target_name" in
   cris)
   ;;
   hppa)
+    mttcg="yes"
   ;;
   lm32)
   ;;
-- 
2.14.3
