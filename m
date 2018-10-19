Received: from eggs.gnu.org ([2001:4830:134:3::10]:39012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkO-000618-N1
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkM-00011S-Mg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58291 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXkM-0000oj-BQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:40 +0200
Message-Id: <1539966828-20947-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 06/14] target/mips: Add bit encoding for MXU
 operand getting patterns 'optn2'
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

Add bit encoding for MXU operand getting patterns 'optn2'.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f465635..60bba15 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23317,6 +23317,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #define MXU_APTN2_SA    2
 #define MXU_APTN2_SS    3
 
+/* MXU operand getting patterns 'optn2' */
+#define MXU_OPTN2_WW    0
+#define MXU_OPTN2_LW    1
+#define MXU_OPTN2_HW    2
+#define MXU_OPTN2_XW    3
+
 
 /*
  *
-- 
2.7.4
