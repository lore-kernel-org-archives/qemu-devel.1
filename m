Received: from eggs.gnu.org ([209.51.188.92]:48527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwG4-0004yB-8Y
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwFy-0000So-W9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:32 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52937 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtwFq-0000LZ-E6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:20 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 13 Feb 2019 16:14:52 +0100
Message-Id: <1550070897-5013-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 2/7] tests/tcg: target/mips: Add a header
 with test inputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The file tests/tcg/mips/include/test_inputs.h is planned to
contain various test inputs. For now, it contains 64 128-bit
pattern inputs (alternating groups od ones and zeroes) and
16 128-bit random inputs.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/test_inputs.h | 122 +++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 tests/tcg/mips/include/test_inputs.h

diff --git a/tests/tcg/mips/include/test_inputs.h b/tests/tcg/mips/include/test_inputs.h
new file mode 100644
index 0000000..c173d58
--- /dev/null
+++ b/tests/tcg/mips/include/test_inputs.h
@@ -0,0 +1,122 @@
+/*
+ *  Header file for pattern and random test inputs
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef TEST_INPUTS_H
+#define TEST_INPUTS_H
+
+#include <stdint.h>
+
+
+#define PATTERN_INPUTS_COUNT          64
+#define PATTERN_INPUTS_SHORT_COUNT     8
+
+uint64_t b128_pattern[PATTERN_INPUTS_COUNT][2] = {
+    { 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFFULL, },   /*   0 */
+    { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    { 0xAAAAAAAAAAAAAAAAULL, 0xAAAAAAAAAAAAAAAAULL, },
+    { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+    { 0xCCCCCCCCCCCCCCCCULL, 0xCCCCCCCCCCCCCCCCULL, },
+    { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+    { 0xE38E38E38E38E38EULL, 0x38E38E38E38E38E3ULL, },
+    { 0x1C71C71C71C71C71ULL, 0xC71C71C71C71C71CULL, },
+    { 0xF0F0F0F0F0F0F0F0ULL, 0xF0F0F0F0F0F0F0F0ULL, },   /*   8 */
+    { 0x0F0F0F0F0F0F0F0FULL, 0x0F0F0F0F0F0F0F0FULL, },
+    { 0xF83E0F83E0F83E0FULL, 0x83E0F83E0F83E0F8ULL, },
+    { 0x07C1F07C1F07C1F0ULL, 0x7C1F07C1F07C1F07ULL, },
+    { 0xFC0FC0FC0FC0FC0FULL, 0xC0FC0FC0FC0FC0FCULL, },
+    { 0x03F03F03F03F03F0ULL, 0x3F03F03F03F03F03ULL, },
+    { 0xFE03F80FE03F80FEULL, 0x03F80FE03F80FE03ULL, },
+    { 0x01FC07F01FC07F01ULL, 0xFC07F01FC07F01FCULL, },
+    { 0xFF00FF00FF00FF00ULL, 0xFF00FF00FF00FF00ULL, },   /*  16 */
+    { 0x00FF00FF00FF00FFULL, 0x00FF00FF00FF00FFULL, },
+    { 0xFF803FE00FF803FEULL, 0x00FF803FE00FF803ULL, },
+    { 0x007FC01FF007FC01ULL, 0xFF007FC01FF007FCULL, },
+    { 0xFFC00FFC00FFC00FULL, 0xFC00FFC00FFC00FFULL, },
+    { 0x003FF003FF003FF0ULL, 0x03FF003FF003FF00ULL, },
+    { 0xFFE003FF800FFE00ULL, 0x3FF800FFE003FF80ULL, },
+    { 0x001FFC007FF001FFULL, 0xC007FF001FFC007FULL, },
+    { 0xFFF000FFF000FFF0ULL, 0x00FFF000FFF000FFULL, },   /*  24 */
+    { 0x000FFF000FFF000FULL, 0xFF000FFF000FFF00ULL, },
+    { 0xFFF8003FFE000FFFULL, 0x8003FFE000FFF800ULL, },
+    { 0x0007FFC001FFF000ULL, 0x7FFC001FFF0007FFULL, },
+    { 0xFFFC000FFFC000FFULL, 0xFC000FFFC000FFFCULL, },
+    { 0x0003FFF0003FFF00ULL, 0x03FFF0003FFF0003ULL, },
+    { 0xFFFE0003FFF8000FULL, 0xFFE0003FFF8000FFULL, },
+    { 0x0001FFFC0007FFF0ULL, 0x001FFFC0007FFF00ULL, },
+    { 0xFFFF0000FFFF0000ULL, 0xFFFF0000FFFF0000ULL, },   /*  32 */
+    { 0x0000FFFF0000FFFFULL, 0x0000FFFF0000FFFFULL, },
+    { 0xFFFF80003FFFE000ULL, 0x0FFFF80003FFFE00ULL, },
+    { 0x00007FFFC0001FFFULL, 0xF00007FFFC0001FFULL, },
+    { 0xFFFFC0000FFFFC00ULL, 0x00FFFFC0000FFFFCULL, },
+    { 0x00003FFFF00003FFULL, 0xFF00003FFFF00003ULL, },
+    { 0xFFFFE00003FFFF80ULL, 0x000FFFFE00003FFFULL, },
+    { 0x00001FFFFC00007FULL, 0xFFF00001FFFFC000ULL, },
+    { 0xFFFFF00000FFFFF0ULL, 0x0000FFFFF00000FFULL, },   /*  40 */
+    { 0x00000FFFFF00000FULL, 0xFFFF00000FFFFF00ULL, },
+    { 0xFFFFF800003FFFFEULL, 0x00000FFFFF800003ULL, },
+    { 0x000007FFFFC00001ULL, 0xFFFFF000007FFFFCULL, },
+    { 0xFFFFFC00000FFFFFULL, 0xC00000FFFFFC0000ULL, },
+    { 0x000003FFFFF00000ULL, 0x3FFFFF000003FFFFULL, },
+    { 0xFFFFFE000003FFFFULL, 0xF800000FFFFFE000ULL, },
+    { 0x000001FFFFFC0000ULL, 0x07FFFFF000001FFFULL, },
+    { 0xFFFFFF000000FFFFULL, 0xFF000000FFFFFF00ULL, },   /*  48 */
+    { 0x000000FFFFFF0000ULL, 0x00FFFFFF000000FFULL, },
+    { 0xFFFFFF8000003FFFULL, 0xFFE000000FFFFFF8ULL, },
+    { 0x0000007FFFFFC000ULL, 0x001FFFFFF0000007ULL, },
+    { 0xFFFFFFC000000FFFULL, 0xFFFC000000FFFFFFULL, },
+    { 0x0000003FFFFFF000ULL, 0x0003FFFFFF000000ULL, },
+    { 0xFFFFFFE0000003FFULL, 0xFFFF8000000FFFFFULL, },
+    { 0x0000001FFFFFFC00ULL, 0x00007FFFFFF00000ULL, },
+    { 0xFFFFFFF0000000FFULL, 0xFFFFF0000000FFFFULL, },   /*  56 */
+    { 0x0000000FFFFFFF00ULL, 0x00000FFFFFFF0000ULL, },
+    { 0xFFFFFFF80000003FULL, 0xFFFFFE0000000FFFULL, },
+    { 0x00000007FFFFFFC0ULL, 0x000001FFFFFFF000ULL, },
+    { 0xFFFFFFFC0000000FULL, 0xFFFFFFC0000000FFULL, },
+    { 0x00000003FFFFFFF0ULL, 0x0000003FFFFFFF00ULL, },
+    { 0xFFFFFFFE00000003ULL, 0xFFFFFFF80000000FULL, },
+    { 0x00000001FFFFFFFCULL, 0x00000007FFFFFFF0ULL, },
+};
+
+
+#define RANDOM_INPUTS_COUNT           16
+#define RANDOM_INPUTS_SHORT_COUNT      4
+
+uint64_t b128_random[RANDOM_INPUTS_COUNT][2] = {
+    { 0x886AE6CC28625540ULL, 0x4B670B5EFE7BB00CULL, },   /*   0 */
+    { 0xFBBE00634D93C708ULL, 0x12F7BB1A153F52FCULL, },
+    { 0xAC5AAEAAB9CF8B80ULL, 0x27D8C6FFAB2B2514ULL, },
+    { 0x704F164D5E31E24EULL, 0x8DF188D8A942E2A0ULL, },
+    { 0xB9926B7C7DAF4258ULL, 0xA1227CADDCCE65B6ULL, },
+    { 0xD027BE89FF0A2EF9ULL, 0x170B5050FEA53078ULL, },
+    { 0xB83B580665CABC4AULL, 0x91230822BFF0BA62ULL, },
+    { 0xFC8F23F09AA6B782ULL, 0x93FD6637124275AEULL, },
+    { 0x201E09CD56AEE649ULL, 0xEF5DE039A6A52758ULL, },   /*   8 */
+    { 0xA57CD91365D9E5D7ULL, 0x9321BC9881ECBA5CULL, },
+    { 0xA2E8F6F5C9CBC61BULL, 0xB2C471545E0D7A12ULL, },
+    { 0xA89CF2F131A864AEULL, 0xD2A3E87A5DB986E7ULL, },
+    { 0xE61438E9A652EA0AULL, 0xA85483D97879D41CULL, },
+    { 0x944A35FD192361A8ULL, 0xF3912DA36A0B2D6BULL, },
+    { 0x4630426322BEF79CULL, 0xEB5686F7CB19304EULL, },
+    { 0x8B5AA7A2F259DEADULL, 0xD278CBCD696417E3ULL, },
+};
+
+
+#endif
-- 
2.7.4
