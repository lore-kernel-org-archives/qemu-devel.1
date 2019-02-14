Received: from eggs.gnu.org ([209.51.188.92]:35847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL7P-0004rA-Cb
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL7F-0004Ym-D5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:15 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52330 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL7E-0004Jz-EY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:48:05 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:22 +0100
Message-Id: <1550166444-22882-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 13/15] tests/tcg: target/mips: Add tests for MSA
 interleave instructions
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

Add tests for MSA interleave instructions. This includes following
instructions:

  * ILVEV.B - interleave even (bytes)
  * ILVEV.H - interleave even (halfwords)
  * ILVEV.W - interleave even (words)
  * ILVEV.D - interleave even (doublewords)
  * ILVOD.B - interleave odd (bytes)
  * ILVOD.H - interleave odd (halfwords)
  * ILVOD.W - interleave odd (words)
  * ILVOD.D - interleave odd (doublewords)
  * ILVL.B - interleave left (bytes)
  * ILVL.H - interleave left (halfwords)
  * ILVL.W - interleave left (words)
  * ILVL.D - interleave left (doublewords)
  * ILVR.B - interleave right (bytes)
  * ILVR.H - interleave right (halfwords)
  * ILVR.W - interleave right (words)
  * ILVR.D - interleave right (doublewords)

Each test consists of 80 test cases, so altogether there are 1280
test cases.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../user/ase/msa/interleave/test_msa_ilvev_b.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_d.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_h.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_w.c     | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_b.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_d.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_h.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_w.c | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_b.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_d.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_h.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_w.c     | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_b.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_d.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_h.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_w.c | 153 +++++++++++++++++++++
 16 files changed, 2448 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c

diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
new file mode 100644
index 0000000..5cf8627
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVEV.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "*ILVEV.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xff00ff00ff00ff00ULL, 0xff00ff00ff00ff00ULL, },
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0xff55ff55ff55ff55ULL, 0xff55ff55ff55ff55ULL, },
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0xff33ff33ff33ff33ULL, 0xff33ff33ff33ff33ULL, },
+        { 0xff8effe3ff38ff8eULL, 0xffe3ff38ff8effe3ULL, },
+        { 0xff71ff1cffc7ff71ULL, 0xff1cffc7ff71ff1cULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x008e00e30038008eULL, 0x00e30038008e00e3ULL, },
+        { 0x0071001c00c70071ULL, 0x001c00c70071001cULL, },
+        { 0xaaffaaffaaffaaffULL, 0xaaffaaffaaffaaffULL, },    /*  16  */
+        { 0xaa00aa00aa00aa00ULL, 0xaa00aa00aa00aa00ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa55aa55aa55aa55ULL, 0xaa55aa55aa55aa55ULL, },
+        { 0xaaccaaccaaccaaccULL, 0xaaccaaccaaccaaccULL, },
+        { 0xaa33aa33aa33aa33ULL, 0xaa33aa33aa33aa33ULL, },
+        { 0xaa8eaae3aa38aa8eULL, 0xaae3aa38aa8eaae3ULL, },
+        { 0xaa71aa1caac7aa71ULL, 0xaa1caac7aa71aa1cULL, },
+        { 0x55ff55ff55ff55ffULL, 0x55ff55ff55ff55ffULL, },    /*  24  */
+        { 0x5500550055005500ULL, 0x5500550055005500ULL, },
+        { 0x55aa55aa55aa55aaULL, 0x55aa55aa55aa55aaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55cc55cc55cc55ccULL, 0x55cc55cc55cc55ccULL, },
+        { 0x5533553355335533ULL, 0x5533553355335533ULL, },
+        { 0x558e55e35538558eULL, 0x55e35538558e55e3ULL, },
+        { 0x5571551c55c75571ULL, 0x551c55c75571551cULL, },
+        { 0xccffccffccffccffULL, 0xccffccffccffccffULL, },    /*  32  */
+        { 0xcc00cc00cc00cc00ULL, 0xcc00cc00cc00cc00ULL, },
+        { 0xccaaccaaccaaccaaULL, 0xccaaccaaccaaccaaULL, },
+        { 0xcc55cc55cc55cc55ULL, 0xcc55cc55cc55cc55ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcc33cc33cc33cc33ULL, 0xcc33cc33cc33cc33ULL, },
+        { 0xcc8ecce3cc38cc8eULL, 0xcce3cc38cc8ecce3ULL, },
+        { 0xcc71cc1cccc7cc71ULL, 0xcc1cccc7cc71cc1cULL, },
+        { 0x33ff33ff33ff33ffULL, 0x33ff33ff33ff33ffULL, },    /*  40  */
+        { 0x3300330033003300ULL, 0x3300330033003300ULL, },
+        { 0x33aa33aa33aa33aaULL, 0x33aa33aa33aa33aaULL, },
+        { 0x3355335533553355ULL, 0x3355335533553355ULL, },
+        { 0x33cc33cc33cc33ccULL, 0x33cc33cc33cc33ccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x338e33e33338338eULL, 0x33e33338338e33e3ULL, },
+        { 0x3371331c33c73371ULL, 0x331c33c73371331cULL, },
+        { 0x8effe3ff38ff8effULL, 0xe3ff38ff8effe3ffULL, },    /*  48  */
+        { 0x8e00e30038008e00ULL, 0xe30038008e00e300ULL, },
+        { 0x8eaae3aa38aa8eaaULL, 0xe3aa38aa8eaae3aaULL, },
+        { 0x8e55e35538558e55ULL, 0xe35538558e55e355ULL, },
+        { 0x8ecce3cc38cc8eccULL, 0xe3cc38cc8ecce3ccULL, },
+        { 0x8e33e33338338e33ULL, 0xe33338338e33e333ULL, },
+        { 0x8e8ee3e338388e8eULL, 0xe3e338388e8ee3e3ULL, },
+        { 0x8e71e31c38c78e71ULL, 0xe31c38c78e71e31cULL, },
+        { 0x71ff1cffc7ff71ffULL, 0x1cffc7ff71ff1cffULL, },    /*  56  */
+        { 0x71001c00c7007100ULL, 0x1c00c70071001c00ULL, },
+        { 0x71aa1caac7aa71aaULL, 0x1caac7aa71aa1caaULL, },
+        { 0x71551c55c7557155ULL, 0x1c55c75571551c55ULL, },
+        { 0x71cc1cccc7cc71ccULL, 0x1cccc7cc71cc1cccULL, },
+        { 0x71331c33c7337133ULL, 0x1c33c73371331c33ULL, },
+        { 0x718e1ce3c738718eULL, 0x1ce3c738718e1ce3ULL, },
+        { 0x71711c1cc7c77171ULL, 0x1c1cc7c771711c1cULL, },
+        { 0x6a6acccc62624040ULL, 0x67675e5e7b7b0c0cULL, },    /*  64  */
+        { 0x6abecc6362934008ULL, 0x67f75e1a7b3f0cfcULL, },
+        { 0x6a5accaa62cf4080ULL, 0x67d85eff7b2b0c14ULL, },
+        { 0x6a4fcc4d6231404eULL, 0x67f15ed87b420ca0ULL, },
+        { 0xbe6a63cc93620840ULL, 0xf7671a5e3f7bfc0cULL, },
+        { 0xbebe636393930808ULL, 0xf7f71a1a3f3ffcfcULL, },
+        { 0xbe5a63aa93cf0880ULL, 0xf7d81aff3f2bfc14ULL, },
+        { 0xbe4f634d9331084eULL, 0xf7f11ad83f42fca0ULL, },
+        { 0x5a6aaacccf628040ULL, 0xd867ff5e2b7b140cULL, },    /*  72  */
+        { 0x5abeaa63cf938008ULL, 0xd8f7ff1a2b3f14fcULL, },
+        { 0x5a5aaaaacfcf8080ULL, 0xd8d8ffff2b2b1414ULL, },
+        { 0x5a4faa4dcf31804eULL, 0xd8f1ffd82b4214a0ULL, },
+        { 0x4f6a4dcc31624e40ULL, 0xf167d85e427ba00cULL, },
+        { 0x4fbe4d6331934e08ULL, 0xf1f7d81a423fa0fcULL, },
+        { 0x4f5a4daa31cf4e80ULL, 0xf1d8d8ff422ba014ULL, },
+        { 0x4f4f4d4d31314e4eULL, 0xf1f1d8d84242a0a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
new file mode 100644
index 0000000..d3600e9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVEV.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "*ILVEV.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0xffffffffffffffffULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0xe38e38e38e38e38eULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0xe38e38e38e38e38eULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555555555555ULL, 0xe38e38e38e38e38eULL, },
+        { 0xccccccccccccccccULL, 0xe38e38e38e38e38eULL, },
+        { 0x3333333333333333ULL, 0xe38e38e38e38e38eULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x1c71c71c71c71c71ULL, 0xe38e38e38e38e38eULL, },
+        { 0xffffffffffffffffULL, 0x1c71c71c71c71c71ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x1c71c71c71c71c71ULL, },
+        { 0x5555555555555555ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xccccccccccccccccULL, 0x1c71c71c71c71c71ULL, },
+        { 0x3333333333333333ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xe38e38e38e38e38eULL, 0x1c71c71c71c71c71ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x886ae6cc28625540ULL, },
+        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
+        { 0x886ae6cc28625540ULL, 0xfbbe00634d93c708ULL, },
+        { 0xfbbe00634d93c708ULL, 0xfbbe00634d93c708ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
+        { 0x886ae6cc28625540ULL, 0xac5aaeaab9cf8b80ULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },
+        { 0xfbbe00634d93c708ULL, 0x704f164d5e31e24eULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x704f164d5e31e24eULL, },
+        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
new file mode 100644
index 0000000..9a80fac
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVEV.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "*ILVEV.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffff0000ffff0000ULL, 0xffff0000ffff0000ULL, },
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0xffff5555ffff5555ULL, 0xffff5555ffff5555ULL, },
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0xffff3333ffff3333ULL, 0xffff3333ffff3333ULL, },
+        { 0xffff38e3ffffe38eULL, 0xffff8e38ffff38e3ULL, },
+        { 0xffffc71cffff1c71ULL, 0xffff71c7ffffc71cULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x000038e30000e38eULL, 0x00008e38000038e3ULL, },
+        { 0x0000c71c00001c71ULL, 0x000071c70000c71cULL, },
+        { 0xaaaaffffaaaaffffULL, 0xaaaaffffaaaaffffULL, },    /*  16  */
+        { 0xaaaa0000aaaa0000ULL, 0xaaaa0000aaaa0000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaa5555aaaa5555ULL, 0xaaaa5555aaaa5555ULL, },
+        { 0xaaaaccccaaaaccccULL, 0xaaaaccccaaaaccccULL, },
+        { 0xaaaa3333aaaa3333ULL, 0xaaaa3333aaaa3333ULL, },
+        { 0xaaaa38e3aaaae38eULL, 0xaaaa8e38aaaa38e3ULL, },
+        { 0xaaaac71caaaa1c71ULL, 0xaaaa71c7aaaac71cULL, },
+        { 0x5555ffff5555ffffULL, 0x5555ffff5555ffffULL, },    /*  24  */
+        { 0x5555000055550000ULL, 0x5555000055550000ULL, },
+        { 0x5555aaaa5555aaaaULL, 0x5555aaaa5555aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555cccc5555ccccULL, 0x5555cccc5555ccccULL, },
+        { 0x5555333355553333ULL, 0x5555333355553333ULL, },
+        { 0x555538e35555e38eULL, 0x55558e38555538e3ULL, },
+        { 0x5555c71c55551c71ULL, 0x555571c75555c71cULL, },
+        { 0xccccffffccccffffULL, 0xccccffffccccffffULL, },    /*  32  */
+        { 0xcccc0000cccc0000ULL, 0xcccc0000cccc0000ULL, },
+        { 0xccccaaaaccccaaaaULL, 0xccccaaaaccccaaaaULL, },
+        { 0xcccc5555cccc5555ULL, 0xcccc5555cccc5555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccc3333cccc3333ULL, 0xcccc3333cccc3333ULL, },
+        { 0xcccc38e3cccce38eULL, 0xcccc8e38cccc38e3ULL, },
+        { 0xccccc71ccccc1c71ULL, 0xcccc71c7ccccc71cULL, },
+        { 0x3333ffff3333ffffULL, 0x3333ffff3333ffffULL, },    /*  40  */
+        { 0x3333000033330000ULL, 0x3333000033330000ULL, },
+        { 0x3333aaaa3333aaaaULL, 0x3333aaaa3333aaaaULL, },
+        { 0x3333555533335555ULL, 0x3333555533335555ULL, },
+        { 0x3333cccc3333ccccULL, 0x3333cccc3333ccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333338e33333e38eULL, 0x33338e38333338e3ULL, },
+        { 0x3333c71c33331c71ULL, 0x333371c73333c71cULL, },
+        { 0x38e3ffffe38effffULL, 0x8e38ffff38e3ffffULL, },    /*  48  */
+        { 0x38e30000e38e0000ULL, 0x8e38000038e30000ULL, },
+        { 0x38e3aaaae38eaaaaULL, 0x8e38aaaa38e3aaaaULL, },
+        { 0x38e35555e38e5555ULL, 0x8e38555538e35555ULL, },
+        { 0x38e3cccce38eccccULL, 0x8e38cccc38e3ccccULL, },
+        { 0x38e33333e38e3333ULL, 0x8e38333338e33333ULL, },
+        { 0x38e338e3e38ee38eULL, 0x8e388e3838e338e3ULL, },
+        { 0x38e3c71ce38e1c71ULL, 0x8e3871c738e3c71cULL, },
+        { 0xc71cffff1c71ffffULL, 0x71c7ffffc71cffffULL, },    /*  56  */
+        { 0xc71c00001c710000ULL, 0x71c70000c71c0000ULL, },
+        { 0xc71caaaa1c71aaaaULL, 0x71c7aaaac71caaaaULL, },
+        { 0xc71c55551c715555ULL, 0x71c75555c71c5555ULL, },
+        { 0xc71ccccc1c71ccccULL, 0x71c7ccccc71cccccULL, },
+        { 0xc71c33331c713333ULL, 0x71c73333c71c3333ULL, },
+        { 0xc71c38e31c71e38eULL, 0x71c78e38c71c38e3ULL, },
+        { 0xc71cc71c1c711c71ULL, 0x71c771c7c71cc71cULL, },
+        { 0xe6cce6cc55405540ULL, 0x0b5e0b5eb00cb00cULL, },    /*  64  */
+        { 0xe6cc00635540c708ULL, 0x0b5ebb1ab00c52fcULL, },
+        { 0xe6ccaeaa55408b80ULL, 0x0b5ec6ffb00c2514ULL, },
+        { 0xe6cc164d5540e24eULL, 0x0b5e88d8b00ce2a0ULL, },
+        { 0x0063e6ccc7085540ULL, 0xbb1a0b5e52fcb00cULL, },
+        { 0x00630063c708c708ULL, 0xbb1abb1a52fc52fcULL, },
+        { 0x0063aeaac7088b80ULL, 0xbb1ac6ff52fc2514ULL, },
+        { 0x0063164dc708e24eULL, 0xbb1a88d852fce2a0ULL, },
+        { 0xaeaae6cc8b805540ULL, 0xc6ff0b5e2514b00cULL, },    /*  72  */
+        { 0xaeaa00638b80c708ULL, 0xc6ffbb1a251452fcULL, },
+        { 0xaeaaaeaa8b808b80ULL, 0xc6ffc6ff25142514ULL, },
+        { 0xaeaa164d8b80e24eULL, 0xc6ff88d82514e2a0ULL, },
+        { 0x164de6cce24e5540ULL, 0x88d80b5ee2a0b00cULL, },
+        { 0x164d0063e24ec708ULL, 0x88d8bb1ae2a052fcULL, },
+        { 0x164daeaae24e8b80ULL, 0x88d8c6ffe2a02514ULL, },
+        { 0x164d164de24ee24eULL, 0x88d888d8e2a0e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
new file mode 100644
index 0000000..8f62d47
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVEV.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVEV.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffff00000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0xffffffff55555555ULL, 0xffffffff55555555ULL, },
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0xffffffff33333333ULL, 0xffffffff33333333ULL, },
+        { 0xffffffff8e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0xffffffff71c71c71ULL, 0xffffffff1c71c71cULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x000000008e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xaaaaaaaaffffffffULL, 0xaaaaaaaaffffffffULL, },    /*  16  */
+        { 0xaaaaaaaa00000000ULL, 0xaaaaaaaa00000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa55555555ULL, 0xaaaaaaaa55555555ULL, },
+        { 0xaaaaaaaaccccccccULL, 0xaaaaaaaaccccccccULL, },
+        { 0xaaaaaaaa33333333ULL, 0xaaaaaaaa33333333ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaae38e38e3ULL, },
+        { 0xaaaaaaaa71c71c71ULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x55555555ffffffffULL, 0x55555555ffffffffULL, },    /*  24  */
+        { 0x5555555500000000ULL, 0x5555555500000000ULL, },
+        { 0x55555555aaaaaaaaULL, 0x55555555aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55555555ccccccccULL, 0x55555555ccccccccULL, },
+        { 0x5555555533333333ULL, 0x5555555533333333ULL, },
+        { 0x555555558e38e38eULL, 0x55555555e38e38e3ULL, },
+        { 0x5555555571c71c71ULL, 0x555555551c71c71cULL, },
+        { 0xccccccccffffffffULL, 0xccccccccffffffffULL, },    /*  32  */
+        { 0xcccccccc00000000ULL, 0xcccccccc00000000ULL, },
+        { 0xccccccccaaaaaaaaULL, 0xccccccccaaaaaaaaULL, },
+        { 0xcccccccc55555555ULL, 0xcccccccc55555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc33333333ULL, 0xcccccccc33333333ULL, },
+        { 0xcccccccc8e38e38eULL, 0xcccccccce38e38e3ULL, },
+        { 0xcccccccc71c71c71ULL, 0xcccccccc1c71c71cULL, },
+        { 0x33333333ffffffffULL, 0x33333333ffffffffULL, },    /*  40  */
+        { 0x3333333300000000ULL, 0x3333333300000000ULL, },
+        { 0x33333333aaaaaaaaULL, 0x33333333aaaaaaaaULL, },
+        { 0x3333333355555555ULL, 0x3333333355555555ULL, },
+        { 0x33333333ccccccccULL, 0x33333333ccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333333338e38e38eULL, 0x33333333e38e38e3ULL, },
+        { 0x3333333371c71c71ULL, 0x333333331c71c71cULL, },
+        { 0x8e38e38effffffffULL, 0xe38e38e3ffffffffULL, },    /*  48  */
+        { 0x8e38e38e00000000ULL, 0xe38e38e300000000ULL, },
+        { 0x8e38e38eaaaaaaaaULL, 0xe38e38e3aaaaaaaaULL, },
+        { 0x8e38e38e55555555ULL, 0xe38e38e355555555ULL, },
+        { 0x8e38e38eccccccccULL, 0xe38e38e3ccccccccULL, },
+        { 0x8e38e38e33333333ULL, 0xe38e38e333333333ULL, },
+        { 0x8e38e38e8e38e38eULL, 0xe38e38e3e38e38e3ULL, },
+        { 0x8e38e38e71c71c71ULL, 0xe38e38e31c71c71cULL, },
+        { 0x71c71c71ffffffffULL, 0x1c71c71cffffffffULL, },    /*  56  */
+        { 0x71c71c7100000000ULL, 0x1c71c71c00000000ULL, },
+        { 0x71c71c71aaaaaaaaULL, 0x1c71c71caaaaaaaaULL, },
+        { 0x71c71c7155555555ULL, 0x1c71c71c55555555ULL, },
+        { 0x71c71c71ccccccccULL, 0x1c71c71cccccccccULL, },
+        { 0x71c71c7133333333ULL, 0x1c71c71c33333333ULL, },
+        { 0x71c71c718e38e38eULL, 0x1c71c71ce38e38e3ULL, },
+        { 0x71c71c7171c71c71ULL, 0x1c71c71c1c71c71cULL, },
+        { 0x2862554028625540ULL, 0xfe7bb00cfe7bb00cULL, },    /*  64  */
+        { 0x286255404d93c708ULL, 0xfe7bb00c153f52fcULL, },
+        { 0x28625540b9cf8b80ULL, 0xfe7bb00cab2b2514ULL, },
+        { 0x286255405e31e24eULL, 0xfe7bb00ca942e2a0ULL, },
+        { 0x4d93c70828625540ULL, 0x153f52fcfe7bb00cULL, },
+        { 0x4d93c7084d93c708ULL, 0x153f52fc153f52fcULL, },
+        { 0x4d93c708b9cf8b80ULL, 0x153f52fcab2b2514ULL, },
+        { 0x4d93c7085e31e24eULL, 0x153f52fca942e2a0ULL, },
+        { 0xb9cf8b8028625540ULL, 0xab2b2514fe7bb00cULL, },    /*  72  */
+        { 0xb9cf8b804d93c708ULL, 0xab2b2514153f52fcULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xab2b2514ab2b2514ULL, },
+        { 0xb9cf8b805e31e24eULL, 0xab2b2514a942e2a0ULL, },
+        { 0x5e31e24e28625540ULL, 0xa942e2a0fe7bb00cULL, },
+        { 0x5e31e24e4d93c708ULL, 0xa942e2a0153f52fcULL, },
+        { 0x5e31e24eb9cf8b80ULL, 0xa942e2a0ab2b2514ULL, },
+        { 0x5e31e24e5e31e24eULL, 0xa942e2a0a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVEV_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
new file mode 100644
index 0000000..f7e6dc0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVL.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVL.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xff00ff00ff00ff00ULL, 0xff00ff00ff00ff00ULL, },
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0xff55ff55ff55ff55ULL, 0xff55ff55ff55ff55ULL, },
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0xff33ff33ff33ff33ULL, 0xff33ff33ff33ff33ULL, },
+        { 0xffe3ff8eff38ffe3ULL, 0xff38ffe3ff8eff38ULL, },
+        { 0xff1cff71ffc7ff1cULL, 0xffc7ff1cff71ffc7ULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x00e3008e003800e3ULL, 0x003800e3008e0038ULL, },
+        { 0x001c007100c7001cULL, 0x00c7001c007100c7ULL, },
+        { 0xaaffaaffaaffaaffULL, 0xaaffaaffaaffaaffULL, },    /*  16  */
+        { 0xaa00aa00aa00aa00ULL, 0xaa00aa00aa00aa00ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa55aa55aa55aa55ULL, 0xaa55aa55aa55aa55ULL, },
+        { 0xaaccaaccaaccaaccULL, 0xaaccaaccaaccaaccULL, },
+        { 0xaa33aa33aa33aa33ULL, 0xaa33aa33aa33aa33ULL, },
+        { 0xaae3aa8eaa38aae3ULL, 0xaa38aae3aa8eaa38ULL, },
+        { 0xaa1caa71aac7aa1cULL, 0xaac7aa1caa71aac7ULL, },
+        { 0x55ff55ff55ff55ffULL, 0x55ff55ff55ff55ffULL, },    /*  24  */
+        { 0x5500550055005500ULL, 0x5500550055005500ULL, },
+        { 0x55aa55aa55aa55aaULL, 0x55aa55aa55aa55aaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55cc55cc55cc55ccULL, 0x55cc55cc55cc55ccULL, },
+        { 0x5533553355335533ULL, 0x5533553355335533ULL, },
+        { 0x55e3558e553855e3ULL, 0x553855e3558e5538ULL, },
+        { 0x551c557155c7551cULL, 0x55c7551c557155c7ULL, },
+        { 0xccffccffccffccffULL, 0xccffccffccffccffULL, },    /*  32  */
+        { 0xcc00cc00cc00cc00ULL, 0xcc00cc00cc00cc00ULL, },
+        { 0xccaaccaaccaaccaaULL, 0xccaaccaaccaaccaaULL, },
+        { 0xcc55cc55cc55cc55ULL, 0xcc55cc55cc55cc55ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcc33cc33cc33cc33ULL, 0xcc33cc33cc33cc33ULL, },
+        { 0xcce3cc8ecc38cce3ULL, 0xcc38cce3cc8ecc38ULL, },
+        { 0xcc1ccc71ccc7cc1cULL, 0xccc7cc1ccc71ccc7ULL, },
+        { 0x33ff33ff33ff33ffULL, 0x33ff33ff33ff33ffULL, },    /*  40  */
+        { 0x3300330033003300ULL, 0x3300330033003300ULL, },
+        { 0x33aa33aa33aa33aaULL, 0x33aa33aa33aa33aaULL, },
+        { 0x3355335533553355ULL, 0x3355335533553355ULL, },
+        { 0x33cc33cc33cc33ccULL, 0x33cc33cc33cc33ccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x33e3338e333833e3ULL, 0x333833e3338e3338ULL, },
+        { 0x331c337133c7331cULL, 0x33c7331c337133c7ULL, },
+        { 0xe3ff8eff38ffe3ffULL, 0x38ffe3ff8eff38ffULL, },    /*  48  */
+        { 0xe3008e003800e300ULL, 0x3800e3008e003800ULL, },
+        { 0xe3aa8eaa38aae3aaULL, 0x38aae3aa8eaa38aaULL, },
+        { 0xe3558e553855e355ULL, 0x3855e3558e553855ULL, },
+        { 0xe3cc8ecc38cce3ccULL, 0x38cce3cc8ecc38ccULL, },
+        { 0xe3338e333833e333ULL, 0x3833e3338e333833ULL, },
+        { 0xe3e38e8e3838e3e3ULL, 0x3838e3e38e8e3838ULL, },
+        { 0xe31c8e7138c7e31cULL, 0x38c7e31c8e7138c7ULL, },
+        { 0x1cff71ffc7ff1cffULL, 0xc7ff1cff71ffc7ffULL, },    /*  56  */
+        { 0x1c007100c7001c00ULL, 0xc7001c007100c700ULL, },
+        { 0x1caa71aac7aa1caaULL, 0xc7aa1caa71aac7aaULL, },
+        { 0x1c557155c7551c55ULL, 0xc7551c557155c755ULL, },
+        { 0x1ccc71ccc7cc1cccULL, 0xc7cc1ccc71ccc7ccULL, },
+        { 0x1c337133c7331c33ULL, 0xc7331c337133c733ULL, },
+        { 0x1ce3718ec7381ce3ULL, 0xc7381ce3718ec738ULL, },
+        { 0x1c1c7171c7c71c1cULL, 0xc7c71c1c7171c7c7ULL, },
+        { 0xfefe7b7bb0b00c0cULL, 0x4b4b67670b0b5e5eULL, },    /*  64  */
+        { 0xfe157b3fb0520cfcULL, 0x4b1267f70bbb5e1aULL, },
+        { 0xfeab7b2bb0250c14ULL, 0x4b2767d80bc65effULL, },
+        { 0xfea97b42b0e20ca0ULL, 0x4b8d67f10b885ed8ULL, },
+        { 0x15fe3f7b52b0fc0cULL, 0x124bf767bb0b1a5eULL, },
+        { 0x15153f3f5252fcfcULL, 0x1212f7f7bbbb1a1aULL, },
+        { 0x15ab3f2b5225fc14ULL, 0x1227f7d8bbc61affULL, },
+        { 0x15a93f4252e2fca0ULL, 0x128df7f1bb881ad8ULL, },
+        { 0xabfe2b7b25b0140cULL, 0x274bd867c60bff5eULL, },    /*  72  */
+        { 0xab152b3f255214fcULL, 0x2712d8f7c6bbff1aULL, },
+        { 0xabab2b2b25251414ULL, 0x2727d8d8c6c6ffffULL, },
+        { 0xaba92b4225e214a0ULL, 0x278dd8f1c688ffd8ULL, },
+        { 0xa9fe427be2b0a00cULL, 0x8d4bf167880bd85eULL, },
+        { 0xa915423fe252a0fcULL, 0x8d12f1f788bbd81aULL, },
+        { 0xa9ab422be225a014ULL, 0x8d27f1d888c6d8ffULL, },
+        { 0xa9a94242e2e2a0a0ULL, 0x8d8df1f18888d8d8ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_B(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
new file mode 100644
index 0000000..0f4c048
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVL.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVL.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e3ULL, 0xffffffffffffffffULL, },
+        { 0xc71c71c71c71c71cULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71cULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x38e38e38e38e38e3ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xc71c71c71c71c71cULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x5555555555555555ULL, },
+        { 0xc71c71c71c71c71cULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0x38e38e38e38e38e3ULL, 0xccccccccccccccccULL, },
+        { 0xc71c71c71c71c71cULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x3333333333333333ULL, },
+        { 0xc71c71c71c71c71cULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xc71c71c71c71c71cULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0x38e38e38e38e38e3ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c71c71c71cULL, 0xc71c71c71c71c71cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x12f7bb1a153f52fcULL, 0x4b670b5efe7bb00cULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x8df188d8a942e2a0ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x12f7bb1a153f52fcULL, },
+        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x8df188d8a942e2a0ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x4b670b5efe7bb00cULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0x12f7bb1a153f52fcULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },
+        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_D(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
new file mode 100644
index 0000000..6c1c6d9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVL.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVL.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffff0000ffff0000ULL, 0xffff0000ffff0000ULL, },
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0xffff5555ffff5555ULL, 0xffff5555ffff5555ULL, },
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0xffff3333ffff3333ULL, 0xffff3333ffff3333ULL, },
+        { 0xffffe38effff38e3ULL, 0xffff38e3ffff8e38ULL, },
+        { 0xffff1c71ffffc71cULL, 0xffffc71cffff71c7ULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x0000e38e000038e3ULL, 0x000038e300008e38ULL, },
+        { 0x00001c710000c71cULL, 0x0000c71c000071c7ULL, },
+        { 0xaaaaffffaaaaffffULL, 0xaaaaffffaaaaffffULL, },    /*  16  */
+        { 0xaaaa0000aaaa0000ULL, 0xaaaa0000aaaa0000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaa5555aaaa5555ULL, 0xaaaa5555aaaa5555ULL, },
+        { 0xaaaaccccaaaaccccULL, 0xaaaaccccaaaaccccULL, },
+        { 0xaaaa3333aaaa3333ULL, 0xaaaa3333aaaa3333ULL, },
+        { 0xaaaae38eaaaa38e3ULL, 0xaaaa38e3aaaa8e38ULL, },
+        { 0xaaaa1c71aaaac71cULL, 0xaaaac71caaaa71c7ULL, },
+        { 0x5555ffff5555ffffULL, 0x5555ffff5555ffffULL, },    /*  24  */
+        { 0x5555000055550000ULL, 0x5555000055550000ULL, },
+        { 0x5555aaaa5555aaaaULL, 0x5555aaaa5555aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555cccc5555ccccULL, 0x5555cccc5555ccccULL, },
+        { 0x5555333355553333ULL, 0x5555333355553333ULL, },
+        { 0x5555e38e555538e3ULL, 0x555538e355558e38ULL, },
+        { 0x55551c715555c71cULL, 0x5555c71c555571c7ULL, },
+        { 0xccccffffccccffffULL, 0xccccffffccccffffULL, },    /*  32  */
+        { 0xcccc0000cccc0000ULL, 0xcccc0000cccc0000ULL, },
+        { 0xccccaaaaccccaaaaULL, 0xccccaaaaccccaaaaULL, },
+        { 0xcccc5555cccc5555ULL, 0xcccc5555cccc5555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccc3333cccc3333ULL, 0xcccc3333cccc3333ULL, },
+        { 0xcccce38ecccc38e3ULL, 0xcccc38e3cccc8e38ULL, },
+        { 0xcccc1c71ccccc71cULL, 0xccccc71ccccc71c7ULL, },
+        { 0x3333ffff3333ffffULL, 0x3333ffff3333ffffULL, },    /*  40  */
+        { 0x3333000033330000ULL, 0x3333000033330000ULL, },
+        { 0x3333aaaa3333aaaaULL, 0x3333aaaa3333aaaaULL, },
+        { 0x3333555533335555ULL, 0x3333555533335555ULL, },
+        { 0x3333cccc3333ccccULL, 0x3333cccc3333ccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333e38e333338e3ULL, 0x333338e333338e38ULL, },
+        { 0x33331c713333c71cULL, 0x3333c71c333371c7ULL, },
+        { 0xe38effff38e3ffffULL, 0x38e3ffff8e38ffffULL, },    /*  48  */
+        { 0xe38e000038e30000ULL, 0x38e300008e380000ULL, },
+        { 0xe38eaaaa38e3aaaaULL, 0x38e3aaaa8e38aaaaULL, },
+        { 0xe38e555538e35555ULL, 0x38e355558e385555ULL, },
+        { 0xe38ecccc38e3ccccULL, 0x38e3cccc8e38ccccULL, },
+        { 0xe38e333338e33333ULL, 0x38e333338e383333ULL, },
+        { 0xe38ee38e38e338e3ULL, 0x38e338e38e388e38ULL, },
+        { 0xe38e1c7138e3c71cULL, 0x38e3c71c8e3871c7ULL, },
+        { 0x1c71ffffc71cffffULL, 0xc71cffff71c7ffffULL, },    /*  56  */
+        { 0x1c710000c71c0000ULL, 0xc71c000071c70000ULL, },
+        { 0x1c71aaaac71caaaaULL, 0xc71caaaa71c7aaaaULL, },
+        { 0x1c715555c71c5555ULL, 0xc71c555571c75555ULL, },
+        { 0x1c71ccccc71cccccULL, 0xc71ccccc71c7ccccULL, },
+        { 0x1c713333c71c3333ULL, 0xc71c333371c73333ULL, },
+        { 0x1c71e38ec71c38e3ULL, 0xc71c38e371c78e38ULL, },
+        { 0x1c711c71c71cc71cULL, 0xc71cc71c71c771c7ULL, },
+        { 0xfe7bfe7bb00cb00cULL, 0x4b674b670b5e0b5eULL, },    /*  64  */
+        { 0xfe7b153fb00c52fcULL, 0x4b6712f70b5ebb1aULL, },
+        { 0xfe7bab2bb00c2514ULL, 0x4b6727d80b5ec6ffULL, },
+        { 0xfe7ba942b00ce2a0ULL, 0x4b678df10b5e88d8ULL, },
+        { 0x153ffe7b52fcb00cULL, 0x12f74b67bb1a0b5eULL, },
+        { 0x153f153f52fc52fcULL, 0x12f712f7bb1abb1aULL, },
+        { 0x153fab2b52fc2514ULL, 0x12f727d8bb1ac6ffULL, },
+        { 0x153fa94252fce2a0ULL, 0x12f78df1bb1a88d8ULL, },
+        { 0xab2bfe7b2514b00cULL, 0x27d84b67c6ff0b5eULL, },    /*  72  */
+        { 0xab2b153f251452fcULL, 0x27d812f7c6ffbb1aULL, },
+        { 0xab2bab2b25142514ULL, 0x27d827d8c6ffc6ffULL, },
+        { 0xab2ba9422514e2a0ULL, 0x27d88df1c6ff88d8ULL, },
+        { 0xa942fe7be2a0b00cULL, 0x8df14b6788d80b5eULL, },
+        { 0xa942153fe2a052fcULL, 0x8df112f788d8bb1aULL, },
+        { 0xa942ab2be2a02514ULL, 0x8df127d888d8c6ffULL, },
+        { 0xa942a942e2a0e2a0ULL, 0x8df18df188d888d8ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_H(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
new file mode 100644
index 0000000..d22d965
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVL.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVL.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffff00000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0xffffffff55555555ULL, 0xffffffff55555555ULL, },
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0xffffffff33333333ULL, 0xffffffff33333333ULL, },
+        { 0xffffffffe38e38e3ULL, 0xffffffff38e38e38ULL, },
+        { 0xffffffff1c71c71cULL, 0xffffffffc71c71c7ULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x00000000e38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0x000000001c71c71cULL, 0x00000000c71c71c7ULL, },
+        { 0xaaaaaaaaffffffffULL, 0xaaaaaaaaffffffffULL, },    /*  16  */
+        { 0xaaaaaaaa00000000ULL, 0xaaaaaaaa00000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa55555555ULL, 0xaaaaaaaa55555555ULL, },
+        { 0xaaaaaaaaccccccccULL, 0xaaaaaaaaccccccccULL, },
+        { 0xaaaaaaaa33333333ULL, 0xaaaaaaaa33333333ULL, },
+        { 0xaaaaaaaae38e38e3ULL, 0xaaaaaaaa38e38e38ULL, },
+        { 0xaaaaaaaa1c71c71cULL, 0xaaaaaaaac71c71c7ULL, },
+        { 0x55555555ffffffffULL, 0x55555555ffffffffULL, },    /*  24  */
+        { 0x5555555500000000ULL, 0x5555555500000000ULL, },
+        { 0x55555555aaaaaaaaULL, 0x55555555aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55555555ccccccccULL, 0x55555555ccccccccULL, },
+        { 0x5555555533333333ULL, 0x5555555533333333ULL, },
+        { 0x55555555e38e38e3ULL, 0x5555555538e38e38ULL, },
+        { 0x555555551c71c71cULL, 0x55555555c71c71c7ULL, },
+        { 0xccccccccffffffffULL, 0xccccccccffffffffULL, },    /*  32  */
+        { 0xcccccccc00000000ULL, 0xcccccccc00000000ULL, },
+        { 0xccccccccaaaaaaaaULL, 0xccccccccaaaaaaaaULL, },
+        { 0xcccccccc55555555ULL, 0xcccccccc55555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc33333333ULL, 0xcccccccc33333333ULL, },
+        { 0xcccccccce38e38e3ULL, 0xcccccccc38e38e38ULL, },
+        { 0xcccccccc1c71c71cULL, 0xccccccccc71c71c7ULL, },
+        { 0x33333333ffffffffULL, 0x33333333ffffffffULL, },    /*  40  */
+        { 0x3333333300000000ULL, 0x3333333300000000ULL, },
+        { 0x33333333aaaaaaaaULL, 0x33333333aaaaaaaaULL, },
+        { 0x3333333355555555ULL, 0x3333333355555555ULL, },
+        { 0x33333333ccccccccULL, 0x33333333ccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x33333333e38e38e3ULL, 0x3333333338e38e38ULL, },
+        { 0x333333331c71c71cULL, 0x33333333c71c71c7ULL, },
+        { 0xe38e38e3ffffffffULL, 0x38e38e38ffffffffULL, },    /*  48  */
+        { 0xe38e38e300000000ULL, 0x38e38e3800000000ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38aaaaaaaaULL, },
+        { 0xe38e38e355555555ULL, 0x38e38e3855555555ULL, },
+        { 0xe38e38e3ccccccccULL, 0x38e38e38ccccccccULL, },
+        { 0xe38e38e333333333ULL, 0x38e38e3833333333ULL, },
+        { 0xe38e38e3e38e38e3ULL, 0x38e38e3838e38e38ULL, },
+        { 0xe38e38e31c71c71cULL, 0x38e38e38c71c71c7ULL, },
+        { 0x1c71c71cffffffffULL, 0xc71c71c7ffffffffULL, },    /*  56  */
+        { 0x1c71c71c00000000ULL, 0xc71c71c700000000ULL, },
+        { 0x1c71c71caaaaaaaaULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c755555555ULL, },
+        { 0x1c71c71cccccccccULL, 0xc71c71c7ccccccccULL, },
+        { 0x1c71c71c33333333ULL, 0xc71c71c733333333ULL, },
+        { 0x1c71c71ce38e38e3ULL, 0xc71c71c738e38e38ULL, },
+        { 0x1c71c71c1c71c71cULL, 0xc71c71c7c71c71c7ULL, },
+        { 0xfe7bb00cfe7bb00cULL, 0x4b670b5e4b670b5eULL, },    /*  64  */
+        { 0xfe7bb00c153f52fcULL, 0x4b670b5e12f7bb1aULL, },
+        { 0xfe7bb00cab2b2514ULL, 0x4b670b5e27d8c6ffULL, },
+        { 0xfe7bb00ca942e2a0ULL, 0x4b670b5e8df188d8ULL, },
+        { 0x153f52fcfe7bb00cULL, 0x12f7bb1a4b670b5eULL, },
+        { 0x153f52fc153f52fcULL, 0x12f7bb1a12f7bb1aULL, },
+        { 0x153f52fcab2b2514ULL, 0x12f7bb1a27d8c6ffULL, },
+        { 0x153f52fca942e2a0ULL, 0x12f7bb1a8df188d8ULL, },
+        { 0xab2b2514fe7bb00cULL, 0x27d8c6ff4b670b5eULL, },    /*  72  */
+        { 0xab2b2514153f52fcULL, 0x27d8c6ff12f7bb1aULL, },
+        { 0xab2b2514ab2b2514ULL, 0x27d8c6ff27d8c6ffULL, },
+        { 0xab2b2514a942e2a0ULL, 0x27d8c6ff8df188d8ULL, },
+        { 0xa942e2a0fe7bb00cULL, 0x8df188d84b670b5eULL, },
+        { 0xa942e2a0153f52fcULL, 0x8df188d812f7bb1aULL, },
+        { 0xa942e2a0ab2b2514ULL, 0x8df188d827d8c6ffULL, },
+        { 0xa942e2a0a942e2a0ULL, 0x8df188d88df188d8ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVL_W(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
new file mode 100644
index 0000000..c55f3a4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVOD.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVOD.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xff00ff00ff00ff00ULL, 0xff00ff00ff00ff00ULL, },
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0xff55ff55ff55ff55ULL, 0xff55ff55ff55ff55ULL, },
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0xff33ff33ff33ff33ULL, 0xff33ff33ff33ff33ULL, },
+        { 0xffe3ff38ff8effe3ULL, 0xff38ff8effe3ff38ULL, },
+        { 0xff1cffc7ff71ff1cULL, 0xffc7ff71ff1cffc7ULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x00e30038008e00e3ULL, 0x0038008e00e30038ULL, },
+        { 0x001c00c70071001cULL, 0x00c70071001c00c7ULL, },
+        { 0xaaffaaffaaffaaffULL, 0xaaffaaffaaffaaffULL, },    /*  16  */
+        { 0xaa00aa00aa00aa00ULL, 0xaa00aa00aa00aa00ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa55aa55aa55aa55ULL, 0xaa55aa55aa55aa55ULL, },
+        { 0xaaccaaccaaccaaccULL, 0xaaccaaccaaccaaccULL, },
+        { 0xaa33aa33aa33aa33ULL, 0xaa33aa33aa33aa33ULL, },
+        { 0xaae3aa38aa8eaae3ULL, 0xaa38aa8eaae3aa38ULL, },
+        { 0xaa1caac7aa71aa1cULL, 0xaac7aa71aa1caac7ULL, },
+        { 0x55ff55ff55ff55ffULL, 0x55ff55ff55ff55ffULL, },    /*  24  */
+        { 0x5500550055005500ULL, 0x5500550055005500ULL, },
+        { 0x55aa55aa55aa55aaULL, 0x55aa55aa55aa55aaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55cc55cc55cc55ccULL, 0x55cc55cc55cc55ccULL, },
+        { 0x5533553355335533ULL, 0x5533553355335533ULL, },
+        { 0x55e35538558e55e3ULL, 0x5538558e55e35538ULL, },
+        { 0x551c55c75571551cULL, 0x55c75571551c55c7ULL, },
+        { 0xccffccffccffccffULL, 0xccffccffccffccffULL, },    /*  32  */
+        { 0xcc00cc00cc00cc00ULL, 0xcc00cc00cc00cc00ULL, },
+        { 0xccaaccaaccaaccaaULL, 0xccaaccaaccaaccaaULL, },
+        { 0xcc55cc55cc55cc55ULL, 0xcc55cc55cc55cc55ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcc33cc33cc33cc33ULL, 0xcc33cc33cc33cc33ULL, },
+        { 0xcce3cc38cc8ecce3ULL, 0xcc38cc8ecce3cc38ULL, },
+        { 0xcc1cccc7cc71cc1cULL, 0xccc7cc71cc1cccc7ULL, },
+        { 0x33ff33ff33ff33ffULL, 0x33ff33ff33ff33ffULL, },    /*  40  */
+        { 0x3300330033003300ULL, 0x3300330033003300ULL, },
+        { 0x33aa33aa33aa33aaULL, 0x33aa33aa33aa33aaULL, },
+        { 0x3355335533553355ULL, 0x3355335533553355ULL, },
+        { 0x33cc33cc33cc33ccULL, 0x33cc33cc33cc33ccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x33e33338338e33e3ULL, 0x3338338e33e33338ULL, },
+        { 0x331c33c73371331cULL, 0x33c73371331c33c7ULL, },
+        { 0xe3ff38ff8effe3ffULL, 0x38ff8effe3ff38ffULL, },    /*  48  */
+        { 0xe30038008e00e300ULL, 0x38008e00e3003800ULL, },
+        { 0xe3aa38aa8eaae3aaULL, 0x38aa8eaae3aa38aaULL, },
+        { 0xe35538558e55e355ULL, 0x38558e55e3553855ULL, },
+        { 0xe3cc38cc8ecce3ccULL, 0x38cc8ecce3cc38ccULL, },
+        { 0xe33338338e33e333ULL, 0x38338e33e3333833ULL, },
+        { 0xe3e338388e8ee3e3ULL, 0x38388e8ee3e33838ULL, },
+        { 0xe31c38c78e71e31cULL, 0x38c78e71e31c38c7ULL, },
+        { 0x1cffc7ff71ff1cffULL, 0xc7ff71ff1cffc7ffULL, },    /*  56  */
+        { 0x1c00c70071001c00ULL, 0xc70071001c00c700ULL, },
+        { 0x1caac7aa71aa1caaULL, 0xc7aa71aa1caac7aaULL, },
+        { 0x1c55c75571551c55ULL, 0xc75571551c55c755ULL, },
+        { 0x1cccc7cc71cc1cccULL, 0xc7cc71cc1cccc7ccULL, },
+        { 0x1c33c73371331c33ULL, 0xc73371331c33c733ULL, },
+        { 0x1ce3c738718e1ce3ULL, 0xc738718e1ce3c738ULL, },
+        { 0x1c1cc7c771711c1cULL, 0xc7c771711c1cc7c7ULL, },
+        { 0x8888e6e628285555ULL, 0x4b4b0b0bfefeb0b0ULL, },    /*  64  */
+        { 0x88fbe600284d55c7ULL, 0x4b120bbbfe15b052ULL, },
+        { 0x88ace6ae28b9558bULL, 0x4b270bc6feabb025ULL, },
+        { 0x8870e616285e55e2ULL, 0x4b8d0b88fea9b0e2ULL, },
+        { 0xfb8800e64d28c755ULL, 0x124bbb0b15fe52b0ULL, },
+        { 0xfbfb00004d4dc7c7ULL, 0x1212bbbb15155252ULL, },
+        { 0xfbac00ae4db9c78bULL, 0x1227bbc615ab5225ULL, },
+        { 0xfb7000164d5ec7e2ULL, 0x128dbb8815a952e2ULL, },
+        { 0xac88aee6b9288b55ULL, 0x274bc60babfe25b0ULL, },    /*  72  */
+        { 0xacfbae00b94d8bc7ULL, 0x2712c6bbab152552ULL, },
+        { 0xacacaeaeb9b98b8bULL, 0x2727c6c6abab2525ULL, },
+        { 0xac70ae16b95e8be2ULL, 0x278dc688aba925e2ULL, },
+        { 0x708816e65e28e255ULL, 0x8d4b880ba9fee2b0ULL, },
+        { 0x70fb16005e4de2c7ULL, 0x8d1288bba915e252ULL, },
+        { 0x70ac16ae5eb9e28bULL, 0x8d2788c6a9abe225ULL, },
+        { 0x707016165e5ee2e2ULL, 0x8d8d8888a9a9e2e2ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
new file mode 100644
index 0000000..d03e7b4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVOD.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVOD.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e3ULL, 0xffffffffffffffffULL, },
+        { 0xc71c71c71c71c71cULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71cULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x38e38e38e38e38e3ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xc71c71c71c71c71cULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x5555555555555555ULL, },
+        { 0xc71c71c71c71c71cULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0x38e38e38e38e38e3ULL, 0xccccccccccccccccULL, },
+        { 0xc71c71c71c71c71cULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x3333333333333333ULL, },
+        { 0xc71c71c71c71c71cULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xc71c71c71c71c71cULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0x38e38e38e38e38e3ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c71c71c71cULL, 0xc71c71c71c71c71cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x12f7bb1a153f52fcULL, 0x4b670b5efe7bb00cULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x8df188d8a942e2a0ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x12f7bb1a153f52fcULL, },
+        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x8df188d8a942e2a0ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x4b670b5efe7bb00cULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0x12f7bb1a153f52fcULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },
+        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
new file mode 100644
index 0000000..f64d8b5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVOD.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVOD.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffff0000ffff0000ULL, 0xffff0000ffff0000ULL, },
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0xffff5555ffff5555ULL, 0xffff5555ffff5555ULL, },
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0xffff3333ffff3333ULL, 0xffff3333ffff3333ULL, },
+        { 0xffffe38effff8e38ULL, 0xffff38e3ffffe38eULL, },
+        { 0xffff1c71ffff71c7ULL, 0xffffc71cffff1c71ULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x0000e38e00008e38ULL, 0x000038e30000e38eULL, },
+        { 0x00001c71000071c7ULL, 0x0000c71c00001c71ULL, },
+        { 0xaaaaffffaaaaffffULL, 0xaaaaffffaaaaffffULL, },    /*  16  */
+        { 0xaaaa0000aaaa0000ULL, 0xaaaa0000aaaa0000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaa5555aaaa5555ULL, 0xaaaa5555aaaa5555ULL, },
+        { 0xaaaaccccaaaaccccULL, 0xaaaaccccaaaaccccULL, },
+        { 0xaaaa3333aaaa3333ULL, 0xaaaa3333aaaa3333ULL, },
+        { 0xaaaae38eaaaa8e38ULL, 0xaaaa38e3aaaae38eULL, },
+        { 0xaaaa1c71aaaa71c7ULL, 0xaaaac71caaaa1c71ULL, },
+        { 0x5555ffff5555ffffULL, 0x5555ffff5555ffffULL, },    /*  24  */
+        { 0x5555000055550000ULL, 0x5555000055550000ULL, },
+        { 0x5555aaaa5555aaaaULL, 0x5555aaaa5555aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555cccc5555ccccULL, 0x5555cccc5555ccccULL, },
+        { 0x5555333355553333ULL, 0x5555333355553333ULL, },
+        { 0x5555e38e55558e38ULL, 0x555538e35555e38eULL, },
+        { 0x55551c71555571c7ULL, 0x5555c71c55551c71ULL, },
+        { 0xccccffffccccffffULL, 0xccccffffccccffffULL, },    /*  32  */
+        { 0xcccc0000cccc0000ULL, 0xcccc0000cccc0000ULL, },
+        { 0xccccaaaaccccaaaaULL, 0xccccaaaaccccaaaaULL, },
+        { 0xcccc5555cccc5555ULL, 0xcccc5555cccc5555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccc3333cccc3333ULL, 0xcccc3333cccc3333ULL, },
+        { 0xcccce38ecccc8e38ULL, 0xcccc38e3cccce38eULL, },
+        { 0xcccc1c71cccc71c7ULL, 0xccccc71ccccc1c71ULL, },
+        { 0x3333ffff3333ffffULL, 0x3333ffff3333ffffULL, },    /*  40  */
+        { 0x3333000033330000ULL, 0x3333000033330000ULL, },
+        { 0x3333aaaa3333aaaaULL, 0x3333aaaa3333aaaaULL, },
+        { 0x3333555533335555ULL, 0x3333555533335555ULL, },
+        { 0x3333cccc3333ccccULL, 0x3333cccc3333ccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333e38e33338e38ULL, 0x333338e33333e38eULL, },
+        { 0x33331c71333371c7ULL, 0x3333c71c33331c71ULL, },
+        { 0xe38effff8e38ffffULL, 0x38e3ffffe38effffULL, },    /*  48  */
+        { 0xe38e00008e380000ULL, 0x38e30000e38e0000ULL, },
+        { 0xe38eaaaa8e38aaaaULL, 0x38e3aaaae38eaaaaULL, },
+        { 0xe38e55558e385555ULL, 0x38e35555e38e5555ULL, },
+        { 0xe38ecccc8e38ccccULL, 0x38e3cccce38eccccULL, },
+        { 0xe38e33338e383333ULL, 0x38e33333e38e3333ULL, },
+        { 0xe38ee38e8e388e38ULL, 0x38e338e3e38ee38eULL, },
+        { 0xe38e1c718e3871c7ULL, 0x38e3c71ce38e1c71ULL, },
+        { 0x1c71ffff71c7ffffULL, 0xc71cffff1c71ffffULL, },    /*  56  */
+        { 0x1c71000071c70000ULL, 0xc71c00001c710000ULL, },
+        { 0x1c71aaaa71c7aaaaULL, 0xc71caaaa1c71aaaaULL, },
+        { 0x1c71555571c75555ULL, 0xc71c55551c715555ULL, },
+        { 0x1c71cccc71c7ccccULL, 0xc71ccccc1c71ccccULL, },
+        { 0x1c71333371c73333ULL, 0xc71c33331c713333ULL, },
+        { 0x1c71e38e71c78e38ULL, 0xc71c38e31c71e38eULL, },
+        { 0x1c711c7171c771c7ULL, 0xc71cc71c1c711c71ULL, },
+        { 0x886a886a28622862ULL, 0x4b674b67fe7bfe7bULL, },    /*  64  */
+        { 0x886afbbe28624d93ULL, 0x4b6712f7fe7b153fULL, },
+        { 0x886aac5a2862b9cfULL, 0x4b6727d8fe7bab2bULL, },
+        { 0x886a704f28625e31ULL, 0x4b678df1fe7ba942ULL, },
+        { 0xfbbe886a4d932862ULL, 0x12f74b67153ffe7bULL, },
+        { 0xfbbefbbe4d934d93ULL, 0x12f712f7153f153fULL, },
+        { 0xfbbeac5a4d93b9cfULL, 0x12f727d8153fab2bULL, },
+        { 0xfbbe704f4d935e31ULL, 0x12f78df1153fa942ULL, },
+        { 0xac5a886ab9cf2862ULL, 0x27d84b67ab2bfe7bULL, },    /*  72  */
+        { 0xac5afbbeb9cf4d93ULL, 0x27d812f7ab2b153fULL, },
+        { 0xac5aac5ab9cfb9cfULL, 0x27d827d8ab2bab2bULL, },
+        { 0xac5a704fb9cf5e31ULL, 0x27d88df1ab2ba942ULL, },
+        { 0x704f886a5e312862ULL, 0x8df14b67a942fe7bULL, },
+        { 0x704ffbbe5e314d93ULL, 0x8df112f7a942153fULL, },
+        { 0x704fac5a5e31b9cfULL, 0x8df127d8a942ab2bULL, },
+        { 0x704f704f5e315e31ULL, 0x8df18df1a942a942ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
new file mode 100644
index 0000000..4ae75f8
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVOD.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVOD.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffff00000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0xffffffff55555555ULL, 0xffffffff55555555ULL, },
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0xffffffff33333333ULL, 0xffffffff33333333ULL, },
+        { 0xffffffffe38e38e3ULL, 0xffffffff38e38e38ULL, },
+        { 0xffffffff1c71c71cULL, 0xffffffffc71c71c7ULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x00000000e38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0x000000001c71c71cULL, 0x00000000c71c71c7ULL, },
+        { 0xaaaaaaaaffffffffULL, 0xaaaaaaaaffffffffULL, },    /*  16  */
+        { 0xaaaaaaaa00000000ULL, 0xaaaaaaaa00000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa55555555ULL, 0xaaaaaaaa55555555ULL, },
+        { 0xaaaaaaaaccccccccULL, 0xaaaaaaaaccccccccULL, },
+        { 0xaaaaaaaa33333333ULL, 0xaaaaaaaa33333333ULL, },
+        { 0xaaaaaaaae38e38e3ULL, 0xaaaaaaaa38e38e38ULL, },
+        { 0xaaaaaaaa1c71c71cULL, 0xaaaaaaaac71c71c7ULL, },
+        { 0x55555555ffffffffULL, 0x55555555ffffffffULL, },    /*  24  */
+        { 0x5555555500000000ULL, 0x5555555500000000ULL, },
+        { 0x55555555aaaaaaaaULL, 0x55555555aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55555555ccccccccULL, 0x55555555ccccccccULL, },
+        { 0x5555555533333333ULL, 0x5555555533333333ULL, },
+        { 0x55555555e38e38e3ULL, 0x5555555538e38e38ULL, },
+        { 0x555555551c71c71cULL, 0x55555555c71c71c7ULL, },
+        { 0xccccccccffffffffULL, 0xccccccccffffffffULL, },    /*  32  */
+        { 0xcccccccc00000000ULL, 0xcccccccc00000000ULL, },
+        { 0xccccccccaaaaaaaaULL, 0xccccccccaaaaaaaaULL, },
+        { 0xcccccccc55555555ULL, 0xcccccccc55555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc33333333ULL, 0xcccccccc33333333ULL, },
+        { 0xcccccccce38e38e3ULL, 0xcccccccc38e38e38ULL, },
+        { 0xcccccccc1c71c71cULL, 0xccccccccc71c71c7ULL, },
+        { 0x33333333ffffffffULL, 0x33333333ffffffffULL, },    /*  40  */
+        { 0x3333333300000000ULL, 0x3333333300000000ULL, },
+        { 0x33333333aaaaaaaaULL, 0x33333333aaaaaaaaULL, },
+        { 0x3333333355555555ULL, 0x3333333355555555ULL, },
+        { 0x33333333ccccccccULL, 0x33333333ccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x33333333e38e38e3ULL, 0x3333333338e38e38ULL, },
+        { 0x333333331c71c71cULL, 0x33333333c71c71c7ULL, },
+        { 0xe38e38e3ffffffffULL, 0x38e38e38ffffffffULL, },    /*  48  */
+        { 0xe38e38e300000000ULL, 0x38e38e3800000000ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38aaaaaaaaULL, },
+        { 0xe38e38e355555555ULL, 0x38e38e3855555555ULL, },
+        { 0xe38e38e3ccccccccULL, 0x38e38e38ccccccccULL, },
+        { 0xe38e38e333333333ULL, 0x38e38e3833333333ULL, },
+        { 0xe38e38e3e38e38e3ULL, 0x38e38e3838e38e38ULL, },
+        { 0xe38e38e31c71c71cULL, 0x38e38e38c71c71c7ULL, },
+        { 0x1c71c71cffffffffULL, 0xc71c71c7ffffffffULL, },    /*  56  */
+        { 0x1c71c71c00000000ULL, 0xc71c71c700000000ULL, },
+        { 0x1c71c71caaaaaaaaULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c755555555ULL, },
+        { 0x1c71c71cccccccccULL, 0xc71c71c7ccccccccULL, },
+        { 0x1c71c71c33333333ULL, 0xc71c71c733333333ULL, },
+        { 0x1c71c71ce38e38e3ULL, 0xc71c71c738e38e38ULL, },
+        { 0x1c71c71c1c71c71cULL, 0xc71c71c7c71c71c7ULL, },
+        { 0x886ae6cc886ae6ccULL, 0x4b670b5e4b670b5eULL, },    /*  64  */
+        { 0x886ae6ccfbbe0063ULL, 0x4b670b5e12f7bb1aULL, },
+        { 0x886ae6ccac5aaeaaULL, 0x4b670b5e27d8c6ffULL, },
+        { 0x886ae6cc704f164dULL, 0x4b670b5e8df188d8ULL, },
+        { 0xfbbe0063886ae6ccULL, 0x12f7bb1a4b670b5eULL, },
+        { 0xfbbe0063fbbe0063ULL, 0x12f7bb1a12f7bb1aULL, },
+        { 0xfbbe0063ac5aaeaaULL, 0x12f7bb1a27d8c6ffULL, },
+        { 0xfbbe0063704f164dULL, 0x12f7bb1a8df188d8ULL, },
+        { 0xac5aaeaa886ae6ccULL, 0x27d8c6ff4b670b5eULL, },    /*  72  */
+        { 0xac5aaeaafbbe0063ULL, 0x27d8c6ff12f7bb1aULL, },
+        { 0xac5aaeaaac5aaeaaULL, 0x27d8c6ff27d8c6ffULL, },
+        { 0xac5aaeaa704f164dULL, 0x27d8c6ff8df188d8ULL, },
+        { 0x704f164d886ae6ccULL, 0x8df188d84b670b5eULL, },
+        { 0x704f164dfbbe0063ULL, 0x8df188d812f7bb1aULL, },
+        { 0x704f164dac5aaeaaULL, 0x8df188d827d8c6ffULL, },
+        { 0x704f164d704f164dULL, 0x8df188d88df188d8ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVOD_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
new file mode 100644
index 0000000..f2cc7bf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVR.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVR.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xff00ff00ff00ff00ULL, 0xff00ff00ff00ff00ULL, },
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0xff55ff55ff55ff55ULL, 0xff55ff55ff55ff55ULL, },
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0xff33ff33ff33ff33ULL, 0xff33ff33ff33ff33ULL, },
+        { 0xff8eff38ffe3ff8eULL, 0xffe3ff8eff38ffe3ULL, },
+        { 0xff71ffc7ff1cff71ULL, 0xff1cff71ffc7ff1cULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x008e003800e3008eULL, 0x00e3008e003800e3ULL, },
+        { 0x007100c7001c0071ULL, 0x001c007100c7001cULL, },
+        { 0xaaffaaffaaffaaffULL, 0xaaffaaffaaffaaffULL, },    /*  16  */
+        { 0xaa00aa00aa00aa00ULL, 0xaa00aa00aa00aa00ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa55aa55aa55aa55ULL, 0xaa55aa55aa55aa55ULL, },
+        { 0xaaccaaccaaccaaccULL, 0xaaccaaccaaccaaccULL, },
+        { 0xaa33aa33aa33aa33ULL, 0xaa33aa33aa33aa33ULL, },
+        { 0xaa8eaa38aae3aa8eULL, 0xaae3aa8eaa38aae3ULL, },
+        { 0xaa71aac7aa1caa71ULL, 0xaa1caa71aac7aa1cULL, },
+        { 0x55ff55ff55ff55ffULL, 0x55ff55ff55ff55ffULL, },    /*  24  */
+        { 0x5500550055005500ULL, 0x5500550055005500ULL, },
+        { 0x55aa55aa55aa55aaULL, 0x55aa55aa55aa55aaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55cc55cc55cc55ccULL, 0x55cc55cc55cc55ccULL, },
+        { 0x5533553355335533ULL, 0x5533553355335533ULL, },
+        { 0x558e553855e3558eULL, 0x55e3558e553855e3ULL, },
+        { 0x557155c7551c5571ULL, 0x551c557155c7551cULL, },
+        { 0xccffccffccffccffULL, 0xccffccffccffccffULL, },    /*  32  */
+        { 0xcc00cc00cc00cc00ULL, 0xcc00cc00cc00cc00ULL, },
+        { 0xccaaccaaccaaccaaULL, 0xccaaccaaccaaccaaULL, },
+        { 0xcc55cc55cc55cc55ULL, 0xcc55cc55cc55cc55ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcc33cc33cc33cc33ULL, 0xcc33cc33cc33cc33ULL, },
+        { 0xcc8ecc38cce3cc8eULL, 0xcce3cc8ecc38cce3ULL, },
+        { 0xcc71ccc7cc1ccc71ULL, 0xcc1ccc71ccc7cc1cULL, },
+        { 0x33ff33ff33ff33ffULL, 0x33ff33ff33ff33ffULL, },    /*  40  */
+        { 0x3300330033003300ULL, 0x3300330033003300ULL, },
+        { 0x33aa33aa33aa33aaULL, 0x33aa33aa33aa33aaULL, },
+        { 0x3355335533553355ULL, 0x3355335533553355ULL, },
+        { 0x33cc33cc33cc33ccULL, 0x33cc33cc33cc33ccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x338e333833e3338eULL, 0x33e3338e333833e3ULL, },
+        { 0x337133c7331c3371ULL, 0x331c337133c7331cULL, },
+        { 0x8eff38ffe3ff8effULL, 0xe3ff8eff38ffe3ffULL, },    /*  48  */
+        { 0x8e003800e3008e00ULL, 0xe3008e003800e300ULL, },
+        { 0x8eaa38aae3aa8eaaULL, 0xe3aa8eaa38aae3aaULL, },
+        { 0x8e553855e3558e55ULL, 0xe3558e553855e355ULL, },
+        { 0x8ecc38cce3cc8eccULL, 0xe3cc8ecc38cce3ccULL, },
+        { 0x8e333833e3338e33ULL, 0xe3338e333833e333ULL, },
+        { 0x8e8e3838e3e38e8eULL, 0xe3e38e8e3838e3e3ULL, },
+        { 0x8e7138c7e31c8e71ULL, 0xe31c8e7138c7e31cULL, },
+        { 0x71ffc7ff1cff71ffULL, 0x1cff71ffc7ff1cffULL, },    /*  56  */
+        { 0x7100c7001c007100ULL, 0x1c007100c7001c00ULL, },
+        { 0x71aac7aa1caa71aaULL, 0x1caa71aac7aa1caaULL, },
+        { 0x7155c7551c557155ULL, 0x1c557155c7551c55ULL, },
+        { 0x71ccc7cc1ccc71ccULL, 0x1ccc71ccc7cc1cccULL, },
+        { 0x7133c7331c337133ULL, 0x1c337133c7331c33ULL, },
+        { 0x718ec7381ce3718eULL, 0x1ce3718ec7381ce3ULL, },
+        { 0x7171c7c71c1c7171ULL, 0x1c1c7171c7c71c1cULL, },
+        { 0x2828626255554040ULL, 0x88886a6ae6e6ccccULL, },    /*  64  */
+        { 0x284d629355c74008ULL, 0x88fb6abee600cc63ULL, },
+        { 0x28b962cf558b4080ULL, 0x88ac6a5ae6aeccaaULL, },
+        { 0x285e623155e2404eULL, 0x88706a4fe616cc4dULL, },
+        { 0x4d289362c7550840ULL, 0xfb88be6a00e663ccULL, },
+        { 0x4d4d9393c7c70808ULL, 0xfbfbbebe00006363ULL, },
+        { 0x4db993cfc78b0880ULL, 0xfbacbe5a00ae63aaULL, },
+        { 0x4d5e9331c7e2084eULL, 0xfb70be4f0016634dULL, },
+        { 0xb928cf628b558040ULL, 0xac885a6aaee6aaccULL, },    /*  72  */
+        { 0xb94dcf938bc78008ULL, 0xacfb5abeae00aa63ULL, },
+        { 0xb9b9cfcf8b8b8080ULL, 0xacac5a5aaeaeaaaaULL, },
+        { 0xb95ecf318be2804eULL, 0xac705a4fae16aa4dULL, },
+        { 0x5e283162e2554e40ULL, 0x70884f6a16e64dccULL, },
+        { 0x5e4d3193e2c74e08ULL, 0x70fb4fbe16004d63ULL, },
+        { 0x5eb931cfe28b4e80ULL, 0x70ac4f5a16ae4daaULL, },
+        { 0x5e5e3131e2e24e4eULL, 0x70704f4f16164d4dULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_B(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
new file mode 100644
index 0000000..f5ff947
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVR.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVR.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0xffffffffffffffffULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0xe38e38e38e38e38eULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0xe38e38e38e38e38eULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555555555555ULL, 0xe38e38e38e38e38eULL, },
+        { 0xccccccccccccccccULL, 0xe38e38e38e38e38eULL, },
+        { 0x3333333333333333ULL, 0xe38e38e38e38e38eULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x1c71c71c71c71c71ULL, 0xe38e38e38e38e38eULL, },
+        { 0xffffffffffffffffULL, 0x1c71c71c71c71c71ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x1c71c71c71c71c71ULL, },
+        { 0x5555555555555555ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xccccccccccccccccULL, 0x1c71c71c71c71c71ULL, },
+        { 0x3333333333333333ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xe38e38e38e38e38eULL, 0x1c71c71c71c71c71ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x886ae6cc28625540ULL, },
+        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
+        { 0x886ae6cc28625540ULL, 0xfbbe00634d93c708ULL, },
+        { 0xfbbe00634d93c708ULL, 0xfbbe00634d93c708ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
+        { 0x886ae6cc28625540ULL, 0xac5aaeaab9cf8b80ULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },
+        { 0xfbbe00634d93c708ULL, 0x704f164d5e31e24eULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x704f164d5e31e24eULL, },
+        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_D(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
new file mode 100644
index 0000000..5a2986d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVR.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVR.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffff0000ffff0000ULL, 0xffff0000ffff0000ULL, },
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0xffff5555ffff5555ULL, 0xffff5555ffff5555ULL, },
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0xffff3333ffff3333ULL, 0xffff3333ffff3333ULL, },
+        { 0xffff8e38ffffe38eULL, 0xffffe38effff38e3ULL, },
+        { 0xffff71c7ffff1c71ULL, 0xffff1c71ffffc71cULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x00008e380000e38eULL, 0x0000e38e000038e3ULL, },
+        { 0x000071c700001c71ULL, 0x00001c710000c71cULL, },
+        { 0xaaaaffffaaaaffffULL, 0xaaaaffffaaaaffffULL, },    /*  16  */
+        { 0xaaaa0000aaaa0000ULL, 0xaaaa0000aaaa0000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaa5555aaaa5555ULL, 0xaaaa5555aaaa5555ULL, },
+        { 0xaaaaccccaaaaccccULL, 0xaaaaccccaaaaccccULL, },
+        { 0xaaaa3333aaaa3333ULL, 0xaaaa3333aaaa3333ULL, },
+        { 0xaaaa8e38aaaae38eULL, 0xaaaae38eaaaa38e3ULL, },
+        { 0xaaaa71c7aaaa1c71ULL, 0xaaaa1c71aaaac71cULL, },
+        { 0x5555ffff5555ffffULL, 0x5555ffff5555ffffULL, },    /*  24  */
+        { 0x5555000055550000ULL, 0x5555000055550000ULL, },
+        { 0x5555aaaa5555aaaaULL, 0x5555aaaa5555aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555cccc5555ccccULL, 0x5555cccc5555ccccULL, },
+        { 0x5555333355553333ULL, 0x5555333355553333ULL, },
+        { 0x55558e385555e38eULL, 0x5555e38e555538e3ULL, },
+        { 0x555571c755551c71ULL, 0x55551c715555c71cULL, },
+        { 0xccccffffccccffffULL, 0xccccffffccccffffULL, },    /*  32  */
+        { 0xcccc0000cccc0000ULL, 0xcccc0000cccc0000ULL, },
+        { 0xccccaaaaccccaaaaULL, 0xccccaaaaccccaaaaULL, },
+        { 0xcccc5555cccc5555ULL, 0xcccc5555cccc5555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccc3333cccc3333ULL, 0xcccc3333cccc3333ULL, },
+        { 0xcccc8e38cccce38eULL, 0xcccce38ecccc38e3ULL, },
+        { 0xcccc71c7cccc1c71ULL, 0xcccc1c71ccccc71cULL, },
+        { 0x3333ffff3333ffffULL, 0x3333ffff3333ffffULL, },    /*  40  */
+        { 0x3333000033330000ULL, 0x3333000033330000ULL, },
+        { 0x3333aaaa3333aaaaULL, 0x3333aaaa3333aaaaULL, },
+        { 0x3333555533335555ULL, 0x3333555533335555ULL, },
+        { 0x3333cccc3333ccccULL, 0x3333cccc3333ccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x33338e383333e38eULL, 0x3333e38e333338e3ULL, },
+        { 0x333371c733331c71ULL, 0x33331c713333c71cULL, },
+        { 0x8e38ffffe38effffULL, 0xe38effff38e3ffffULL, },    /*  48  */
+        { 0x8e380000e38e0000ULL, 0xe38e000038e30000ULL, },
+        { 0x8e38aaaae38eaaaaULL, 0xe38eaaaa38e3aaaaULL, },
+        { 0x8e385555e38e5555ULL, 0xe38e555538e35555ULL, },
+        { 0x8e38cccce38eccccULL, 0xe38ecccc38e3ccccULL, },
+        { 0x8e383333e38e3333ULL, 0xe38e333338e33333ULL, },
+        { 0x8e388e38e38ee38eULL, 0xe38ee38e38e338e3ULL, },
+        { 0x8e3871c7e38e1c71ULL, 0xe38e1c7138e3c71cULL, },
+        { 0x71c7ffff1c71ffffULL, 0x1c71ffffc71cffffULL, },    /*  56  */
+        { 0x71c700001c710000ULL, 0x1c710000c71c0000ULL, },
+        { 0x71c7aaaa1c71aaaaULL, 0x1c71aaaac71caaaaULL, },
+        { 0x71c755551c715555ULL, 0x1c715555c71c5555ULL, },
+        { 0x71c7cccc1c71ccccULL, 0x1c71ccccc71cccccULL, },
+        { 0x71c733331c713333ULL, 0x1c713333c71c3333ULL, },
+        { 0x71c78e381c71e38eULL, 0x1c71e38ec71c38e3ULL, },
+        { 0x71c771c71c711c71ULL, 0x1c711c71c71cc71cULL, },
+        { 0x2862286255405540ULL, 0x886a886ae6cce6ccULL, },    /*  64  */
+        { 0x28624d935540c708ULL, 0x886afbbee6cc0063ULL, },
+        { 0x2862b9cf55408b80ULL, 0x886aac5ae6ccaeaaULL, },
+        { 0x28625e315540e24eULL, 0x886a704fe6cc164dULL, },
+        { 0x4d932862c7085540ULL, 0xfbbe886a0063e6ccULL, },
+        { 0x4d934d93c708c708ULL, 0xfbbefbbe00630063ULL, },
+        { 0x4d93b9cfc7088b80ULL, 0xfbbeac5a0063aeaaULL, },
+        { 0x4d935e31c708e24eULL, 0xfbbe704f0063164dULL, },
+        { 0xb9cf28628b805540ULL, 0xac5a886aaeaae6ccULL, },    /*  72  */
+        { 0xb9cf4d938b80c708ULL, 0xac5afbbeaeaa0063ULL, },
+        { 0xb9cfb9cf8b808b80ULL, 0xac5aac5aaeaaaeaaULL, },
+        { 0xb9cf5e318b80e24eULL, 0xac5a704faeaa164dULL, },
+        { 0x5e312862e24e5540ULL, 0x704f886a164de6ccULL, },
+        { 0x5e314d93e24ec708ULL, 0x704ffbbe164d0063ULL, },
+        { 0x5e31b9cfe24e8b80ULL, 0x704fac5a164daeaaULL, },
+        { 0x5e315e31e24ee24eULL, 0x704f704f164d164dULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_H(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
new file mode 100644
index 0000000..fa0d6ea
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction ILVR.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "ILVR.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffff00000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0xffffffff55555555ULL, 0xffffffff55555555ULL, },
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0xffffffff33333333ULL, 0xffffffff33333333ULL, },
+        { 0xffffffff8e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0xffffffff71c71c71ULL, 0xffffffff1c71c71cULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x000000008e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xaaaaaaaaffffffffULL, 0xaaaaaaaaffffffffULL, },    /*  16  */
+        { 0xaaaaaaaa00000000ULL, 0xaaaaaaaa00000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa55555555ULL, 0xaaaaaaaa55555555ULL, },
+        { 0xaaaaaaaaccccccccULL, 0xaaaaaaaaccccccccULL, },
+        { 0xaaaaaaaa33333333ULL, 0xaaaaaaaa33333333ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaae38e38e3ULL, },
+        { 0xaaaaaaaa71c71c71ULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x55555555ffffffffULL, 0x55555555ffffffffULL, },    /*  24  */
+        { 0x5555555500000000ULL, 0x5555555500000000ULL, },
+        { 0x55555555aaaaaaaaULL, 0x55555555aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x55555555ccccccccULL, 0x55555555ccccccccULL, },
+        { 0x5555555533333333ULL, 0x5555555533333333ULL, },
+        { 0x555555558e38e38eULL, 0x55555555e38e38e3ULL, },
+        { 0x5555555571c71c71ULL, 0x555555551c71c71cULL, },
+        { 0xccccccccffffffffULL, 0xccccccccffffffffULL, },    /*  32  */
+        { 0xcccccccc00000000ULL, 0xcccccccc00000000ULL, },
+        { 0xccccccccaaaaaaaaULL, 0xccccccccaaaaaaaaULL, },
+        { 0xcccccccc55555555ULL, 0xcccccccc55555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc33333333ULL, 0xcccccccc33333333ULL, },
+        { 0xcccccccc8e38e38eULL, 0xcccccccce38e38e3ULL, },
+        { 0xcccccccc71c71c71ULL, 0xcccccccc1c71c71cULL, },
+        { 0x33333333ffffffffULL, 0x33333333ffffffffULL, },    /*  40  */
+        { 0x3333333300000000ULL, 0x3333333300000000ULL, },
+        { 0x33333333aaaaaaaaULL, 0x33333333aaaaaaaaULL, },
+        { 0x3333333355555555ULL, 0x3333333355555555ULL, },
+        { 0x33333333ccccccccULL, 0x33333333ccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333333338e38e38eULL, 0x33333333e38e38e3ULL, },
+        { 0x3333333371c71c71ULL, 0x333333331c71c71cULL, },
+        { 0x8e38e38effffffffULL, 0xe38e38e3ffffffffULL, },    /*  48  */
+        { 0x8e38e38e00000000ULL, 0xe38e38e300000000ULL, },
+        { 0x8e38e38eaaaaaaaaULL, 0xe38e38e3aaaaaaaaULL, },
+        { 0x8e38e38e55555555ULL, 0xe38e38e355555555ULL, },
+        { 0x8e38e38eccccccccULL, 0xe38e38e3ccccccccULL, },
+        { 0x8e38e38e33333333ULL, 0xe38e38e333333333ULL, },
+        { 0x8e38e38e8e38e38eULL, 0xe38e38e3e38e38e3ULL, },
+        { 0x8e38e38e71c71c71ULL, 0xe38e38e31c71c71cULL, },
+        { 0x71c71c71ffffffffULL, 0x1c71c71cffffffffULL, },    /*  56  */
+        { 0x71c71c7100000000ULL, 0x1c71c71c00000000ULL, },
+        { 0x71c71c71aaaaaaaaULL, 0x1c71c71caaaaaaaaULL, },
+        { 0x71c71c7155555555ULL, 0x1c71c71c55555555ULL, },
+        { 0x71c71c71ccccccccULL, 0x1c71c71cccccccccULL, },
+        { 0x71c71c7133333333ULL, 0x1c71c71c33333333ULL, },
+        { 0x71c71c718e38e38eULL, 0x1c71c71ce38e38e3ULL, },
+        { 0x71c71c7171c71c71ULL, 0x1c71c71c1c71c71cULL, },
+        { 0x2862554028625540ULL, 0x886ae6cc886ae6ccULL, },    /*  64  */
+        { 0x286255404d93c708ULL, 0x886ae6ccfbbe0063ULL, },
+        { 0x28625540b9cf8b80ULL, 0x886ae6ccac5aaeaaULL, },
+        { 0x286255405e31e24eULL, 0x886ae6cc704f164dULL, },
+        { 0x4d93c70828625540ULL, 0xfbbe0063886ae6ccULL, },
+        { 0x4d93c7084d93c708ULL, 0xfbbe0063fbbe0063ULL, },
+        { 0x4d93c708b9cf8b80ULL, 0xfbbe0063ac5aaeaaULL, },
+        { 0x4d93c7085e31e24eULL, 0xfbbe0063704f164dULL, },
+        { 0xb9cf8b8028625540ULL, 0xac5aaeaa886ae6ccULL, },    /*  72  */
+        { 0xb9cf8b804d93c708ULL, 0xac5aaeaafbbe0063ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xac5aaeaaac5aaeaaULL, },
+        { 0xb9cf8b805e31e24eULL, 0xac5aaeaa704f164dULL, },
+        { 0x5e31e24e28625540ULL, 0x704f164d886ae6ccULL, },
+        { 0x5e31e24e4d93c708ULL, 0x704f164dfbbe0063ULL, },
+        { 0x5e31e24eb9cf8b80ULL, 0x704f164dac5aaeaaULL, },
+        { 0x5e31e24e5e31e24eULL, 0x704f164d704f164dULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ILVR_W(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
-- 
2.7.4
