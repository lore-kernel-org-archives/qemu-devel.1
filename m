Received: from eggs.gnu.org ([209.51.188.92]:53099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBU-00082l-8h
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBH-00041G-9j
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:24 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50150 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkCBG-0002Si-VJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:19 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 17 Jan 2019 19:12:55 +0100
Message-Id: <1547748785-14030-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 02/12] target/mips: Add preprocessor constants
 for 32 major CP0 registers
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

Add preprocessor constants for 32 major CP0 registers.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6c2a7e4..b095422 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -233,6 +233,38 @@ typedef struct mips_def_t mips_def_t;
  * 7   TagLo             TagHi                               KScratch<n>
  *
  */
+#define CPO_REGISTER_00     0
+#define CPO_REGISTER_01     1
+#define CPO_REGISTER_02     2
+#define CPO_REGISTER_03     3
+#define CPO_REGISTER_04     4
+#define CPO_REGISTER_05     5
+#define CPO_REGISTER_06     6
+#define CPO_REGISTER_07     7
+#define CPO_REGISTER_08     8
+#define CPO_REGISTER_09     9
+#define CPO_REGISTER_10    10
+#define CPO_REGISTER_11    11
+#define CPO_REGISTER_12    12
+#define CPO_REGISTER_13    13
+#define CPO_REGISTER_14    14
+#define CPO_REGISTER_15    15
+#define CPO_REGISTER_16    16
+#define CPO_REGISTER_17    17
+#define CPO_REGISTER_18    18
+#define CPO_REGISTER_19    19
+#define CPO_REGISTER_20    20
+#define CPO_REGISTER_21    21
+#define CPO_REGISTER_22    22
+#define CPO_REGISTER_23    23
+#define CPO_REGISTER_24    24
+#define CPO_REGISTER_25    25
+#define CPO_REGISTER_26    26
+#define CPO_REGISTER_27    27
+#define CPO_REGISTER_28    28
+#define CPO_REGISTER_29    29
+#define CPO_REGISTER_30    30
+#define CPO_REGISTER_31    31
 
 
 typedef struct TCState TCState;
-- 
2.7.4
