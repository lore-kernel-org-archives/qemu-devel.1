Received: from eggs.gnu.org ([2001:4830:134:3::10]:48941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5hj-0000R2-N4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5hW-0004Vu-La
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34525 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5hU-0004P6-FA
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:17 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:18 +0100
Message-Id: <1540812328-16163-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 10/20] target/mips: Add bit encoding for MXU
 operand getting pattern 'optn3'
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

Add bit encoding for MXU operand getting pattern 'optn3'.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2cf0ba5..13e158a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23999,6 +23999,16 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #define MXU_OPTN2_HW    2
 #define MXU_OPTN2_XW    3
 
+/* MXU operand getting pattern 'optn3' */
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
