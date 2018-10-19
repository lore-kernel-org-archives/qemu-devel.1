Received: from eggs.gnu.org ([2001:4830:134:3::10]:39022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkO-00061M-QR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkM-00011G-OR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58301 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXkM-0000vV-AT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:41 +0200
Message-Id: <1539966828-20947-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 07/14] target/mips: Add bit encoding for MXU
 operand getting patterns 'optn3'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Craig Janeczek <jancraig@amazon.com>

Add bit encoding for MXU operand getting patterns 'optn3'.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 60bba15..5b7e6f3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23323,6 +23323,16 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #define MXU_OPTN2_HW    2
 #define MXU_OPTN2_XW    3
 
+/* MXU operand getting patterns 'optn3' */
+#define MXU_OPTN3_PTN0  0
+#define MXU_OPTN3_PTN1  1
+#define MXU_OPTN3_PTN2  2
+#define MXU_OPTN3_PTN3  3
+#define MXU_OPTN3_PTN4  4
+#define MXU_OPTN3_PTN5  5
+#define MXU_OPTN3_PTN6  6
+#define MXU_OPTN3_PTN7  7
+
 
 /*
  *
-- 
2.7.4
