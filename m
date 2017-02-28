Received: from eggs.gnu.org ([2001:4830:134:3::10]:41967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVwZ-0005UU-Rl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVwY-0000JH-9N
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:47:07 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciVwY-0000Ig-6A
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:47:06 -0500
Received: by mail-qk0-x242.google.com with SMTP id r90so21175051qki.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:47:06 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 28 Feb 2017 11:46:51 +1100
Message-Id: <20170228004651.20674-2-rth@twiddle.net>
In-Reply-To: <20170228004651.20674-1-rth@twiddle.net>
References: <20170228004651.20674-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL] target/alpha: Enable MTTCG by default
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

Alpha has a weak memory ordering and issues all of the required barriers.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 configure          | 1 +
 target/alpha/cpu.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/configure b/configure
index df58e91..6c21975 100755
--- a/configure
+++ b/configure
@@ -5894,6 +5894,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=i386
   ;;
   alpha)
+    mttcg="yes"
   ;;
   arm|armeb)
     TARGET_ARCH=arm
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index b08d160..691ac00 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -28,6 +28,9 @@
 
 #define CPUArchState struct CPUAlphaState
 
+/* Alpha processors have a weak memory model */
+#define TCG_GUEST_DEFAULT_MO      (0)
+
 #include "exec/cpu-defs.h"
 
 #include "fpu/softfloat.h"
-- 
2.9.3
