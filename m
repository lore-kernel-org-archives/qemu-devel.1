Received: from eggs.gnu.org ([208.118.235.92]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0w-0005Sa-P4
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0v-0003o7-2O
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:58 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60599 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz0u-0003mi-PH
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:03 +0100
Message-Id: <1546268200-26966-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 07/44] target/mips: MXU: Add generic naming
 for optn2 constants
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

Add generic naming involving generig suffixes OPTN0, OPTN1, OPTN2,
OPTN3 for four optn2 constants. Existing suffixes WW, LW, HW, XW
are not quite appropriate for some instructions using optn2.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e0c8d8c..74d16ce 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24238,6 +24238,11 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #define MXU_EPTN2_SS    3
 
 /* MXU operand getting pattern 'optn2' */
+#define MXU_OPTN2_PTN0  0
+#define MXU_OPTN2_PTN1  1
+#define MXU_OPTN2_PTN2  2
+#define MXU_OPTN2_PTN3  3
+/* alternative naming scheme for 'optn2' */
 #define MXU_OPTN2_WW    0
 #define MXU_OPTN2_LW    1
 #define MXU_OPTN2_HW    2
-- 
2.7.4
