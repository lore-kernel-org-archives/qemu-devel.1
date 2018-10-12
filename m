Received: from eggs.gnu.org ([2001:4830:134:3::10]:55109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Xk-0001KY-UR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Xg-0005Nm-Pi
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:44:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46891 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0Xg-00059F-F6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:44:00 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:29 +0200
Message-Id: <1539362376-12010-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 21/28] target/mips: Add opcodes for nanoMIPS
 EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add opcodes for nanoMIPS EVA instructions: CACHEE, LBE, LBUE, LHE,
LHUE, LLE, LLWPE, LWE, PREFE, SBE, SCE, SCWPE, SHE, SWE.

Signed-off-by: Dimitrije Nikolic <dnikolic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f76dfda..e7bc3d4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16686,6 +16686,40 @@ enum {
     NM_P_SC      = 0x0b,
 };
 
+/* P.LS.E0 instruction pool */
+enum {
+    NM_LBE      = 0x00,
+    NM_SBE      = 0x01,
+    NM_LBUE     = 0x02,
+    NM_P_PREFE  = 0x03,
+    NM_LHE      = 0x04,
+    NM_SHE      = 0x05,
+    NM_LHUE     = 0x06,
+    NM_CACHEE   = 0x07,
+    NM_LWE      = 0x08,
+    NM_SWE      = 0x09,
+    NM_P_LLE    = 0x0a,
+    NM_P_SCE    = 0x0b,
+};
+
+/* P.PREFE instruction pool */
+enum {
+    NM_SYNCIE   = 0x00,
+    NM_PREFE    = 0x01,
+};
+
+/* P.LLE instruction pool */
+enum {
+    NM_LLE      = 0x00,
+    NM_LLWPE    = 0x01,
+};
+
+/* P.SCE instruction pool */
+enum {
+    NM_SCE      = 0x00,
+    NM_SCWPE    = 0x01,
+};
+
 /* P.LS.WM instruction pool */
 enum {
     NM_LWM       = 0x00,
-- 
2.7.4
