Received: from eggs.gnu.org ([2001:4830:134:3::10]:57055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzQ9-0006w0-4K
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzQ6-0001Z9-As
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45541 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEzQ5-0001K9-Vf
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:38 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 18:18:20 +0200
Message-Id: <1540311509-23970-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 09/18] target/mips: Add bit encoding for MXU
 operand getting pattern 'optn2'
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

Add bit encoding for MXU operand getting pattern 'optn2'.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 665a584..f3e87ce 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23861,6 +23861,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #define MXU_EPTN2_SA    2
 #define MXU_EPTN2_SS    3
 
+/* MXU operand getting pattern 'optn2' */
+#define MXU_OPTN2_WW    0
+#define MXU_OPTN2_LW    1
+#define MXU_OPTN2_HW    2
+#define MXU_OPTN2_XW    3
+
 
 /*
  *
-- 
2.7.4
