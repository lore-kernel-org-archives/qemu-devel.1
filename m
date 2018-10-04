Received: from eggs.gnu.org ([2001:4830:134:3::10]:54074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g82s3-0005KE-Tw
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g82s3-0007pB-9n
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:36:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35545 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g82s3-0006Ki-0Z
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:36:47 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  4 Oct 2018 14:34:50 +0200
Message-Id: <1538656491-22950-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1538656491-22950-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1538656491-22950-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/4] target/mips: Add opcodes for nanoMIPS EVA
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, dnikolic@wavecomp.com, pjovanovic@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add opcodes for nanoMIPS EVA instructions: CACHEE, LBE, LBUE, LHE,
LHUE, LLE, LLWPE, LWE, PREFE, SBE, SCE, SCWPE, SHE, SWE.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d64a1da..b0b2f40 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16499,6 +16499,22 @@ enum {
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
 /* P.LS.WM instruction pool */
 enum {
     NM_LWM       = 0x00,
-- 
2.7.4
