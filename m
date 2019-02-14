Received: from eggs.gnu.org ([209.51.188.92]:35530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL73-0004bK-R5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL72-0004Ii-Pj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:53 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52301 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL6z-0004Bq-By
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:51 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:15 +0100
Message-Id: <1550166444-22882-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/15] target/mips: introduce MTTCG-enabled
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Introduce MTTCG-enabled QEMU builds for mips32, mipsn32, and mips64.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 configure         | 3 +++
 target/mips/cpu.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/configure b/configure
index fbd0825..f0f7518 100755
--- a/configure
+++ b/configure
@@ -7192,11 +7192,13 @@ case "$target_name" in
     target_compiler=3D$cross_cc_microblaze
   ;;
   mips|mipsel)
+    mttcg=3D"yes"
     TARGET_ARCH=3Dmips
     target_compiler=3D$cross_cc_mips
     echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
   ;;
   mipsn32|mipsn32el)
+    mttcg=3D"yes"
     TARGET_ARCH=3Dmips64
     TARGET_BASE_ARCH=3Dmips
     target_compiler=3D$cross_cc_mipsn32
@@ -7204,6 +7206,7 @@ case "$target_name" in
     echo "TARGET_ABI32=3Dy" >> $config_target_mak
   ;;
   mips64|mips64el)
+    mttcg=3D"yes"
     TARGET_ARCH=3Dmips64
     TARGET_BASE_ARCH=3Dmips
     target_compiler=3D$cross_cc_mips64
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index eccee37..a10eeb0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,8 @@
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
=20
+#define TCG_GUEST_DEFAULT_MO (0)
+
 struct CPUMIPSState;
=20
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
--=20
2.7.4
