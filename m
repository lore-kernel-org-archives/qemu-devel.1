Received: from eggs.gnu.org ([209.51.188.92]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0uuJ-00034X-1d
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0uq5-0002kC-NL
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:09:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41358 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h0uq3-0002gF-R3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:09:33 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  4 Mar 2019 22:09:00 +0100
Message-Id: <1551733750-4902-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 04/14] tests/tcg: target/mips: Add test
 utilities for 32-bit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add test utilities for 32-bit tests.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/test_inputs_32.h | 122 ++++++++++++++++++++++++++++++++
 tests/tcg/mips/include/test_utils_32.h  |  78 ++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tests/tcg/mips/include/test_inputs_32.h
 create mode 100644 tests/tcg/mips/include/test_utils_32.h

diff --git a/tests/tcg/mips/include/test_inputs_32.h b/tests/tcg/mips/include/test_inputs_32.h
new file mode 100644
index 0000000..a3b7e54
--- /dev/null
+++ b/tests/tcg/mips/include/test_inputs_32.h
@@ -0,0 +1,122 @@
+/*
+ *  Header file for pattern and random test inputs
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
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
+#ifndef TEST_INPUTS_32_H
+#define TEST_INPUTS_32_H
+
+#include <stdint.h>
+
+
+#define PATTERN_INPUTS_32_COUNT          64
+#define PATTERN_INPUTS_32_SHORT_COUNT     8
+
+static const uint32_t b32_pattern[PATTERN_INPUTS_32_COUNT] = {
+    0xFFFFFFFF,                                          /*   0 */
+    0x00000000,
+    0xAAAAAAAA,
+    0x55555555,
+    0xCCCCCCCC,
+    0x33333333,
+    0xE38E38E3,
+    0x1C71C71C,
+    0xF0F0F0F0,                                          /*   8 */
+    0x0F0F0F0F,
+    0xF83E0F83,
+    0x07C1F07C,
+    0xFC0FC0FC,
+    0x03F03F03,
+    0xFE03F80F,
+    0x01FC07F0,
+    0xFF00FF00,                                          /*  16 */
+    0x00FF00FF,
+    0xFF803FE0,
+    0x007FC01F,
+    0xFFC00FFC,
+    0x003FF003,
+    0xFFE003FF,
+    0x001FFC00,
+    0xFFF000FF,                                          /*  24 */
+    0x000FFF00,
+    0xFFF8003F,
+    0x0007FFC0,
+    0xFFFC000F,
+    0x0003FFF0,
+    0xFFFE0003,
+    0x0001FFFC,
+    0xFFFF0000,                                          /*  32 */
+    0x0000FFFF,
+    0xFFFF8000,
+    0x00007FFF,
+    0xFFFFC000,
+    0x00003FFF,
+    0xFFFFE000,
+    0x00001FFF,
+    0xFFFFF000,                                          /*  40 */
+    0x00000FFF,
+    0xFFFFF800,
+    0x000007FF,
+    0xFFFFFC00,
+    0x000003FF,
+    0xFFFFFE00,
+    0x000001FF,
+    0xFFFFFF00,                                          /*  48 */
+    0x000000FF,
+    0xFFFFFF80,
+    0x0000007F,
+    0xFFFFFFC0,
+    0x0000003F,
+    0xFFFFFFE0,
+    0x0000001F,
+    0xFFFFFFF0,                                          /*  56 */
+    0x0000000F,
+    0xFFFFFFF8,
+    0x00000007,
+    0xFFFFFFFC,
+    0x00000003,
+    0xFFFFFFFE,
+    0x00000001,
+};
+
+
+#define RANDOM_INPUTS_32_COUNT           16
+#define RANDOM_INPUTS_32_SHORT_COUNT      4
+
+static const uint32_t b32_random[RANDOM_INPUTS_32_COUNT] = {
+    0x886AE6CC,                                          /*   0 */
+    0xFBBE0063,
+    0xAC5AAEAA,
+    0x704F164D,
+    0xB9926B7C,
+    0xD027BE89,
+    0xB83B5806,
+    0xFC8F23F0,
+    0x201E09CD,                                          /*   8 */
+    0xA57CD913,
+    0xA2E8F6F5,
+    0xA89CF2F1,
+    0xE61438E9,
+    0x944A35FD,
+    0x46304263,
+    0x8B5AA7A2,
+};
+
+
+#endif
diff --git a/tests/tcg/mips/include/test_utils_32.h b/tests/tcg/mips/include/test_utils_32.h
new file mode 100644
index 0000000..c33990c
--- /dev/null
+++ b/tests/tcg/mips/include/test_utils_32.h
@@ -0,0 +1,78 @@
+/*
+ *  Header file for test utilities
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
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
+#ifndef TEST_UTILS_32_H
+#define TEST_UTILS_32_H
+
+#include <stdio.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <string.h>
+
+#define PRINT_RESULTS 0
+
+
+static inline int32_t check_results_32(const char *instruction_name,
+                                       const uint32_t test_count,
+                                       const double elapsed_time,
+                                       const uint32_t *b32_result,
+                                       const uint32_t *b32_expect)
+{
+#if PRINT_RESULTS
+    uint32_t ii;
+    printf("\n");
+    for (ii = 0; ii < test_count; ii++) {
+        uint64_t a;
+        memcpy(&a, (b32_result + ii), 8);
+        if (ii % 8 != 0) {
+            printf("        0x%08lxULL,\n", a);
+        } else {
+            printf("        0x%08lxULL,                   /* %3d  */\n",
+                   a, ii);
+        }
+    }
+    printf("\n");
+#endif
+    uint32_t i;
+    uint32_t pass_count = 0;
+    uint32_t fail_count = 0;
+
+    printf("%s:   ", instruction_name);
+    for (i = 0; i < test_count; i++) {
+        if (b32_result[i] == b32_expect[i]) {
+            pass_count++;
+        } else {
+            fail_count++;
+        }
+    }
+
+    printf("PASS: %3d   FAIL: %3d   elapsed time: %5.2f ms\n",
+           pass_count, fail_count, elapsed_time);
+
+    if (fail_count > 0) {
+        return -1;
+    } else {
+        return 0;
+    }
+}
+
+
+#endif
-- 
2.7.4
