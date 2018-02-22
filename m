Received: from eggs.gnu.org ([2001:4830:134:3::10]:49299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfW-0004eO-RN
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfU-0005up-IW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36826 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1eovfU-0005sp-9q
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:32 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 22 Feb 2018 19:31:43 +0100
Message-Id: <1519324303-5674-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 6/6] target/mips: introduce MTTCG-enabled
 builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

Introduce MTTCG-enabled QEMU builds for mips32, mipsn32, and mips64.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 configure         | 3 +++
 target/mips/cpu.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/configure b/configure
index ed45a3c..9b338dd 100755
--- a/configure
+++ b/configure
@@ -6735,16 +6735,19 @@ case "$target_name" in
     bflt="yes"
   ;;
   mips|mipsel)
+    mttcg="yes"
     TARGET_ARCH=mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
   ;;
   mipsn32|mipsn32el)
+    mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips64|mips64el)
+    mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3fa85b0..8f41952 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,8 @@
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
 
+#define TCG_GUEST_DEFAULT_MO (0)
+
 struct CPUMIPSState;
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
-- 
2.7.4
