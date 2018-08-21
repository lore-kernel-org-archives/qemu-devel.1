Received: from eggs.gnu.org ([2001:4830:134:3::10]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Np-00016B-2l
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Nl-0008LN-Dy
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35429 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6Nl-0008Jf-3t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:06:48 +0200
Message-Id: <1534856848-12102-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 06/46] target/mips: Add nanoMIPS decoding and
 extraction utilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add some basic utility functions and macros for nanoMIPS decoding
engine.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4184d91..ab982cf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16593,6 +16593,17 @@ enum {
  *
  */
 
+
+/* extraction utilities */
+
+#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
+#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
+#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
+#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
+#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
+#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
+
+
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     return 2;
-- 
2.7.4
