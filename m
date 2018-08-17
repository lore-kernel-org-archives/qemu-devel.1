Received: from eggs.gnu.org ([2001:4830:134:3::10]:52389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMS-0004fC-Ja
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMR-0007PX-R8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43556 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMR-0007OZ-Ha
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:02:53 +0200
Message-Id: <1534514633-13725-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 05/65] target/mips: Add nanoMIPS decoding
 and extraction utilities
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
index b71d3fe..76d18fa 100644
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
