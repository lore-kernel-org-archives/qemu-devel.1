Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH39-0005Q1-Gj
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH34-00075Z-IR
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55760 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH34-00072z-0n
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:45 +0200
Message-Id: <1534182832-554-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 20/87] target/mips: Add preprocessor
 constants for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add ISA_NANOMIPS32 and CPU_NANOMIPS32 preprocessor constants.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/mips-defs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index d239069..c8e9979 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -39,6 +39,7 @@
 #define   ISA_MIPS64R5  0x00001000
 #define   ISA_MIPS32R6  0x00002000
 #define   ISA_MIPS64R6  0x00004000
+#define   ISA_NANOMIPS32  0x00008000
 
 /* MIPS ASEs. */
 #define   ASE_MIPS16    0x00010000
@@ -87,6 +88,9 @@
 #define CPU_MIPS32R6 (CPU_MIPS32R5 | ISA_MIPS32R6)
 #define CPU_MIPS64R6 (CPU_MIPS64R5 | CPU_MIPS32R6 | ISA_MIPS64R6)
 
+/* Wave Computing: "nanoMIPS" */
+#define CPU_NANOMIPS32 (CPU_MIPS32R6 | ISA_NANOMIPS32)
+
 /* Strictly follow the architecture standard:
    - Disallow "special" instruction handling for PMON/SPIM.
    Note that we still maintain Count/Compare to match the host clock. */
-- 
2.7.4
