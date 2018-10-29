Received: from eggs.gnu.org ([2001:4830:134:3::10]:34203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LR-0008JH-Ib
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LL-0003Hz-NB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39387 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9LL-0003GX-Bi
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:20:01 +0100
Message-Id: <1540826418-5501-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 10/27] target/mips: Add bit encoding for MXU
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Craig Janeczek <jancraig@amazon.com>

Add bit encoding for MXU operand getting pattern 'optn2'.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e790fb4..16bb9e0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23995,6 +23995,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
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
