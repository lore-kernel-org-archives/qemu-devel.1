Received: from eggs.gnu.org ([209.51.188.92]:58393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gyznv-00055H-1Q
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gyzng-0001Mu-1A
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:03:22 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43586 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gyzne-0000l0-I7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:03:07 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Feb 2019 15:00:44 +0100
Message-Id: <1551276045-19143-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551276045-19143-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551276045-19143-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 7/8] tests/tcg: target/mips: Add tests for MSA
 integer max/min instructions
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

Add tests for MSA integer max/min instructions. This includes
following instructions:

  * MAX_A.B - maximum of absolute of two signed values (bytes)
  * MAX_A.H - maximum of absolute of two signed values (halfwords)
  * MAX_A.W - maximum of absolute of two signed values (words)
  * MAX_A.D - maximum of absolute of two signed values (doublewords)
  * MIN_A.B - minimum of absolute of two signed values (bytes)
  * MIN_A.H - minimum of absolute of two signed values (halfwords)
  * MIN_A.W - minimum of absolute of two signed values (words)
  * MIN_A.D - minimum of absolute of two signed values (doublewords)
  * MAX_S.B - maximum of two signed values (bytes)
  * MAX_S.H - maximum of two signed values (halfwords)
  * MAX_S.W - maximum of two signed values (words)
  * MAX_S.D - maximum of two signed values (doublewords)
  * MIN_S.B - minimum of two signed values (bytes)
  * MIN_S.H - minimum of two signed values (halfwords)
  * MIN_S.W - minimum of two signed values (words)
  * MIN_S.D - minimum of two signed values (doublewords)
  * MAX_U.B - maximum of two unsigned values (bytes)
  * MAX_U.H - maximum of two unsigned values (halfwords)
  * MAX_U.W - maximum of two unsigned values (words)
  * MAX_U.D - maximum of two unsigned values (doublewords)
  * MIN_U.B - minimum of two unsigned values (bytes)
  * MIN_U.H - minimum of two unsigned values (halfwords)
  * MIN_U.W - minimum of two unsigned values (words)
  * MIN_U.D - minimum of two unsigned values (doublewords)

Each test consists of 80 test cases, so altogether there are 1920
test cases.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1551185735-17154-8-git-send-email-aleksandar.markovic@rt-rk.com>
---
 .../user/ase/msa/int-max-min/test_msa_max_a_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_w.c    | 153 +++++++++++++++++++++
 24 files changed, 3672 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
new file mode 100644
index 0000000..b7a9a61
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_A.B
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
+    char *instruction_name = "MAX_A.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa8eaaaa8eaaaa8eULL, 0xaaaa8eaaaa8eaaaaULL, },
+        { 0xaa71aaaa71aaaa71ULL, 0xaaaa71aaaa71aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x558e55558e55558eULL, 0x55558e55558e5555ULL, },
+        { 0x5571555571555571ULL, 0x5555715555715555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcc8e38cc8e38cc8eULL, 0x38cc8e38cc8e38ccULL, },
+        { 0xcc71c7cc71c7cc71ULL, 0xc7cc71c7cc71c7ccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x338e38338e38338eULL, 0x38338e38338e3833ULL, },
+        { 0x3371c73371c73371ULL, 0xc73371c73371c733ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaa8eaaaa8eaaaa8eULL, 0xaaaa8eaaaa8eaaaaULL, },
+        { 0x558e55558e55558eULL, 0x55558e55558e5555ULL, },
+        { 0xcc8e38cc8e38cc8eULL, 0x38cc8e38cc8e38ccULL, },
+        { 0x338e38338e38338eULL, 0x38338e38338e3833ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38ec7e38ec7e38eULL, 0xc7e38ec7e38ec7e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaa71aaaa71aaaa71ULL, 0xaaaa71aaaa71aaaaULL, },
+        { 0x5571555571555571ULL, 0x5555715555715555ULL, },
+        { 0xcc71c7cc71c7cc71ULL, 0xc7cc71c7cc71c7ccULL, },
+        { 0x3371c73371c73371ULL, 0xc73371c73371c733ULL, },
+        { 0xe38ec7e38ec7e38eULL, 0xc7e38ec7e38ec7e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6634d935540ULL, 0x4b67bb5e157b520cULL, },
+        { 0x886aaeaab9628b80ULL, 0x4b67c65eab7bb014ULL, },
+        { 0x886ae64d5e62554eULL, 0x8d67885ea97bb0a0ULL, },
+        { 0x886ae6634d935540ULL, 0x4b67bb5e157b520cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aae634d938b80ULL, 0x27d8bb1aab3f5214ULL, },
+        { 0x704f16635e93c74eULL, 0x8df188d8a94252a0ULL, },
+        { 0x886aaeaab9628b80ULL, 0x4b67c65eab7bb014ULL, },    /*  72  */
+        { 0xac5aae634d938b80ULL, 0x27d8bb1aab3f5214ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x705aaeaa5e318b80ULL, 0x8dd888d8a94225a0ULL, },
+        { 0x886ae64d5e62554eULL, 0x8d67885ea97bb0a0ULL, },
+        { 0x704f16635e93c74eULL, 0x8df188d8a94252a0ULL, },
+        { 0x705aaeaa5ecf8b80ULL, 0x8dd888d8a94225a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
new file mode 100644
index 0000000..dfffaf5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_A.D
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
+    char *instruction_name = "MAX_A.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
new file mode 100644
index 0000000..e0c1bd4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_A.H
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
+    char *instruction_name = "MAX_A.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa8e38aaaaULL, 0xaaaa8e38aaaaaaaaULL, },
+        { 0xaaaaaaaa71c7aaaaULL, 0xaaaa71c7aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x555555558e385555ULL, 0x55558e3855555555ULL, },
+        { 0x5555555571c75555ULL, 0x555571c755555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccc38e38e38ccccULL, 0x38e38e38cccc38e3ULL, },
+        { 0xccccc71c71c7ccccULL, 0xc71c71c7ccccc71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333338e38e383333ULL, 0x38e38e38333338e3ULL, },
+        { 0x3333c71c71c73333ULL, 0xc71c71c73333c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaa8e38aaaaULL, 0xaaaa8e38aaaaaaaaULL, },
+        { 0x555555558e385555ULL, 0x55558e3855555555ULL, },
+        { 0xcccc38e38e38ccccULL, 0x38e38e38cccc38e3ULL, },
+        { 0x333338e38e383333ULL, 0x38e38e38333338e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38ec71c8e38e38eULL, 0xc71c8e38e38ec71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaa71c7aaaaULL, 0xaaaa71c7aaaaaaaaULL, },
+        { 0x5555555571c75555ULL, 0x555571c755555555ULL, },
+        { 0xccccc71c71c7ccccULL, 0xc71c71c7ccccc71cULL, },
+        { 0x3333c71c71c73333ULL, 0xc71c71c73333c71cULL, },
+        { 0xe38ec71c8e38e38eULL, 0xc71c8e38e38ec71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc4d935540ULL, 0x4b67bb1a153f52fcULL, },
+        { 0x886aaeaab9cf8b80ULL, 0x4b67c6ffab2bb00cULL, },
+        { 0x886ae6cc5e315540ULL, 0x8df188d8a942b00cULL, },
+        { 0x886ae6cc4d935540ULL, 0x4b67bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaa4d938b80ULL, 0x27d8bb1aab2b52fcULL, },
+        { 0x704f164d5e31c708ULL, 0x8df188d8a94252fcULL, },
+        { 0x886aaeaab9cf8b80ULL, 0x4b67c6ffab2bb00cULL, },    /*  72  */
+        { 0xac5aaeaa4d938b80ULL, 0x27d8bb1aab2b52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704faeaa5e318b80ULL, 0x8df188d8a9422514ULL, },
+        { 0x886ae6cc5e315540ULL, 0x8df188d8a942b00cULL, },
+        { 0x704f164d5e31c708ULL, 0x8df188d8a94252fcULL, },
+        { 0x704faeaa5e318b80ULL, 0x8df188d8a9422514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
new file mode 100644
index 0000000..40c30c5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_A.W
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
+    char *instruction_name = "MAX_A.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x555555558e38e38eULL, 0x5555555555555555ULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0xcccccccc71c71c71ULL, 0xc71c71c7ccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333333338e38e38eULL, 0x38e38e3833333333ULL, },
+        { 0x3333333371c71c71ULL, 0xc71c71c733333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x555555558e38e38eULL, 0x5555555555555555ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x333333338e38e38eULL, 0x38e38e3833333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaa71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0xcccccccc71c71c71ULL, 0xc71c71c7ccccccccULL, },
+        { 0x3333333371c71c71ULL, 0xc71c71c733333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc4d93c708ULL, 0x4b670b5e153f52fcULL, },
+        { 0x886ae6ccb9cf8b80ULL, 0x4b670b5eab2b2514ULL, },
+        { 0x886ae6cc5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc4d93c708ULL, 0x4b670b5e153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaa4d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6ccb9cf8b80ULL, 0x4b670b5eab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaa4d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_A_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
new file mode 100644
index 0000000..ab50eee
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_S.B
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
+    char *instruction_name = "MAX_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xffff38ffff38ffffULL, 0x38ffff38ffff38ffULL, },
+        { 0x1c71ff1c71ff1c71ULL, 0xff1c71ff1c71ff1cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000380000380000ULL, 0x3800003800003800ULL, },
+        { 0x1c71001c71001c71ULL, 0x001c71001c71001cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe3aa38e3aa38e3aaULL, 0x38e3aa38e3aa38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5571555571555571ULL, 0x5555715555715555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe3cc38e3cc38e3ccULL, 0x38e3cc38e3cc38e3ULL, },
+        { 0x1c71cc1c71cc1c71ULL, 0xcc1c71cc1c71cc1cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333383333383333ULL, 0x3833333833333833ULL, },
+        { 0x3371333371333371ULL, 0x3333713333713333ULL, },
+        { 0xffff38ffff38ffffULL, 0x38ffff38ffff38ffULL, },    /*  48  */
+        { 0x0000380000380000ULL, 0x3800003800003800ULL, },
+        { 0xe3aa38e3aa38e3aaULL, 0x38e3aa38e3aa38e3ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe3cc38e3cc38e3ccULL, 0x38e3cc38e3cc38e3ULL, },
+        { 0x3333383333383333ULL, 0x3833333833333833ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71381c71381c71ULL, 0x381c71381c71381cULL, },
+        { 0x1c71ff1c71ff1c71ULL, 0xff1c71ff1c71ff1cULL, },    /*  56  */
+        { 0x1c71001c71001c71ULL, 0x001c71001c71001cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5571555571555571ULL, 0x5555715555715555ULL, },
+        { 0x1c71cc1c71cc1c71ULL, 0xcc1c71cc1c71cc1cULL, },
+        { 0x3371333371333371ULL, 0x3333713333713333ULL, },
+        { 0x1c71381c71381c71ULL, 0x381c71381c71381cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfb6a00634d625540ULL, 0x4b670b5e157b520cULL, },
+        { 0xac6ae6cc28625540ULL, 0x4b670b5efe7b2514ULL, },
+        { 0x706a164d5e62554eULL, 0x4b670b5efe7be20cULL, },
+        { 0xfb6a00634d625540ULL, 0x4b670b5e157b520cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfb5a00634dcfc708ULL, 0x27f7c61a153f5214ULL, },
+        { 0x704f16635e31e24eULL, 0x12f7bb1a154252fcULL, },
+        { 0xac6ae6cc28625540ULL, 0x4b670b5efe7b2514ULL, },    /*  72  */
+        { 0xfb5a00634dcfc708ULL, 0x27f7c61a153f5214ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x705a164d5e31e24eULL, 0x27f1c6ffab422514ULL, },
+        { 0x706a164d5e62554eULL, 0x4b670b5efe7be20cULL, },
+        { 0x704f16635e31e24eULL, 0x12f7bb1a154252fcULL, },
+        { 0x705a164d5e31e24eULL, 0x27f1c6ffab422514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
new file mode 100644
index 0000000..2957db4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_S.D
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
+    char *instruction_name = "MAX_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
new file mode 100644
index 0000000..e101764
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_S.H
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
+    char *instruction_name = "MAX_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xffff38e3ffffffffULL, 0x38e3ffffffff38e3ULL, },
+        { 0x1c71ffff71c71c71ULL, 0xffff71c71c71ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000038e300000000ULL, 0x38e30000000038e3ULL, },
+        { 0x1c71000071c71c71ULL, 0x000071c71c710000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3aaaae38eULL, 0x38e3aaaae38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555571c75555ULL, 0x555571c755555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3cccce38eULL, 0x38e3cccce38e38e3ULL, },
+        { 0x1c71cccc71c71c71ULL, 0xcccc71c71c71ccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333338e333333333ULL, 0x38e33333333338e3ULL, },
+        { 0x3333333371c73333ULL, 0x333371c733333333ULL, },
+        { 0xffff38e3ffffffffULL, 0x38e3ffffffff38e3ULL, },    /*  48  */
+        { 0x000038e300000000ULL, 0x38e30000000038e3ULL, },
+        { 0xe38e38e3aaaae38eULL, 0x38e3aaaae38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e3cccce38eULL, 0x38e3cccce38e38e3ULL, },
+        { 0x333338e333333333ULL, 0x38e33333333338e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c7138e371c71c71ULL, 0x38e371c71c7138e3ULL, },
+        { 0x1c71ffff71c71c71ULL, 0xffff71c71c71ffffULL, },    /*  56  */
+        { 0x1c71000071c71c71ULL, 0x000071c71c710000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555571c75555ULL, 0x555571c755555555ULL, },
+        { 0x1c71cccc71c71c71ULL, 0xcccc71c71c71ccccULL, },
+        { 0x3333333371c73333ULL, 0x333371c733333333ULL, },
+        { 0x1c7138e371c71c71ULL, 0x38e371c71c7138e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d935540ULL, 0x4b670b5e153f52fcULL, },
+        { 0xac5ae6cc28625540ULL, 0x4b670b5efe7b2514ULL, },
+        { 0x704f164d5e315540ULL, 0x4b670b5efe7be2a0ULL, },
+        { 0xfbbe00634d935540ULL, 0x4b670b5e153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ff153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5ae6cc28625540ULL, 0x4b670b5efe7b2514ULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ff153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e315540ULL, 0x4b670b5efe7be2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
new file mode 100644
index 0000000..119f03f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_S.W
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
+    char *instruction_name = "MAX_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38ffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffff1c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x38e38e3800000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3ccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xcccccccc1c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x38e38e3833333333ULL, },
+        { 0x3333333371c71c71ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e38e38ffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e38e3800000000ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e3ccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x38e38e3833333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xffffffff1c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x000000001c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xcccccccc1c71c71cULL, },
+        { 0x3333333371c71c71ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x4b670b5e153f52fcULL, },
+        { 0xac5aaeaa28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x4b670b5e153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ff153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaa28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ff153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
new file mode 100644
index 0000000..d18b6bf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_U.B
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
+    char *instruction_name = "MAX_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe3aaaae3aaaae3aaULL, 0xaae3aaaae3aaaae3ULL, },
+        { 0xaaaac7aaaac7aaaaULL, 0xc7aaaac7aaaac7aaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e55e38e55e38eULL, 0x55e38e55e38e55e3ULL, },
+        { 0x5571c75571c75571ULL, 0xc75571c75571c755ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe3cccce3cccce3ccULL, 0xcce3cccce3cccce3ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3371c73371c73371ULL, 0xc73371c73371c733ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe3aaaae3aaaae3aaULL, 0xaae3aaaae3aaaae3ULL, },
+        { 0xe38e55e38e55e38eULL, 0x55e38e55e38e55e3ULL, },
+        { 0xe3cccce3cccce3ccULL, 0xcce3cccce3cccce3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38ec7e38ec7e38eULL, 0xc7e38ec7e38ec7e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaac7aaaac7aaaaULL, 0xc7aaaac7aaaac7aaULL, },
+        { 0x5571c75571c75571ULL, 0xc75571c75571c755ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3371c73371c73371ULL, 0xc73371c73371c733ULL, },
+        { 0xe38ec7e38ec7e38eULL, 0xc7e38ec7e38ec7e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbee6cc4d93c740ULL, 0x4bf7bb5efe7bb0fcULL, },
+        { 0xac6ae6ccb9cf8b80ULL, 0x4bd8c6fffe7bb014ULL, },
+        { 0x886ae6cc5e62e24eULL, 0x8df188d8fe7be2a0ULL, },
+        { 0xfbbee6cc4d93c740ULL, 0x4bf7bb5efe7bb0fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbeaeaab9cfc780ULL, 0x27f7c6ffab3f52fcULL, },
+        { 0xfbbe16635e93e24eULL, 0x8df7bbd8a942e2fcULL, },
+        { 0xac6ae6ccb9cf8b80ULL, 0x4bd8c6fffe7bb014ULL, },    /*  72  */
+        { 0xfbbeaeaab9cfc780ULL, 0x27f7c6ffab3f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cfe280ULL, 0x8df1c6ffab42e2a0ULL, },
+        { 0x886ae6cc5e62e24eULL, 0x8df188d8fe7be2a0ULL, },
+        { 0xfbbe16635e93e24eULL, 0x8df7bbd8a942e2fcULL, },
+        { 0xac5aaeaab9cfe280ULL, 0x8df1c6ffab42e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
new file mode 100644
index 0000000..1396e74
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_U.D
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
+    char *instruction_name = "MAX_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
new file mode 100644
index 0000000..c7dff10
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_U.H
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
+    char *instruction_name = "MAX_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38eaaaaaaaae38eULL, 0xaaaaaaaae38eaaaaULL, },
+        { 0xaaaac71caaaaaaaaULL, 0xc71caaaaaaaac71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e55558e38e38eULL, 0x55558e38e38e5555ULL, },
+        { 0x5555c71c71c75555ULL, 0xc71c71c75555c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38ecccccccce38eULL, 0xcccccccce38eccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333c71c71c73333ULL, 0xc71c71c73333c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38eaaaaaaaae38eULL, 0xaaaaaaaae38eaaaaULL, },
+        { 0xe38e55558e38e38eULL, 0x55558e38e38e5555ULL, },
+        { 0xe38ecccccccce38eULL, 0xcccccccce38eccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38ec71c8e38e38eULL, 0xc71c8e38e38ec71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaac71caaaaaaaaULL, 0xc71caaaaaaaac71cULL, },
+        { 0x5555c71c71c75555ULL, 0xc71c71c75555c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333c71c71c73333ULL, 0xc71c71c73333c71cULL, },
+        { 0xe38ec71c8e38e38eULL, 0xc71c8e38e38ec71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbee6cc4d93c708ULL, 0x4b67bb1afe7bb00cULL, },
+        { 0xac5ae6ccb9cf8b80ULL, 0x4b67c6fffe7bb00cULL, },
+        { 0x886ae6cc5e31e24eULL, 0x8df188d8fe7be2a0ULL, },
+        { 0xfbbee6cc4d93c708ULL, 0x4b67bb1afe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbeaeaab9cfc708ULL, 0x27d8c6ffab2b52fcULL, },
+        { 0xfbbe164d5e31e24eULL, 0x8df1bb1aa942e2a0ULL, },
+        { 0xac5ae6ccb9cf8b80ULL, 0x4b67c6fffe7bb00cULL, },    /*  72  */
+        { 0xfbbeaeaab9cfc708ULL, 0x27d8c6ffab2b52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cfe24eULL, 0x8df1c6ffab2be2a0ULL, },
+        { 0x886ae6cc5e31e24eULL, 0x8df188d8fe7be2a0ULL, },
+        { 0xfbbe164d5e31e24eULL, 0x8df1bb1aa942e2a0ULL, },
+        { 0xac5aaeaab9cfe24eULL, 0x8df1c6ffab2be2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
new file mode 100644
index 0000000..910dbfc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MAX_U.W
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
+    char *instruction_name = "MAX_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0xaaaaaaaae38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0x55555555e38e38e3ULL, },
+        { 0x5555555571c71c71ULL, 0xc71c71c755555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333371c71c71ULL, 0xc71c71c733333333ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0xaaaaaaaae38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x55555555e38e38e3ULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x5555555571c71c71ULL, 0xc71c71c755555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333371c71c71ULL, 0xc71c71c733333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc5e31e24eULL, 0x8df188d8fe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe0063b9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xfbbe00635e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xfbbe0063b9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8ab2b2514ULL, },
+        { 0x886ae6cc5e31e24eULL, 0x8df188d8fe7bb00cULL, },
+        { 0xfbbe00635e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8ab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MAX_U_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
new file mode 100644
index 0000000..c632fe9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_A.B
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
+    char *instruction_name = "MIN_A.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe3aa38e3aa38e3aaULL, 0x38e3aa38e3aa38e3ULL, },
+        { 0x1caac71caac71caaULL, 0xc71caac71caac71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe35538e35538e355ULL, 0x38e35538e35538e3ULL, },
+        { 0x1c55c71c55c71c55ULL, 0xc71c55c71c55c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe3cccce3cccce3ccULL, 0xcce3cccce3cccce3ULL, },
+        { 0x1ccccc1ccccc1cccULL, 0xcc1ccccc1ccccc1cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe33333e33333e333ULL, 0x33e33333e33333e3ULL, },
+        { 0x1c33331c33331c33ULL, 0x331c33331c33331cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe3aa38e3aa38e3aaULL, 0x38e3aa38e3aa38e3ULL, },
+        { 0xe35538e35538e355ULL, 0x38e35538e35538e3ULL, },
+        { 0xe3cccce3cccce3ccULL, 0xcce3cccce3cccce3ULL, },
+        { 0xe33333e33333e333ULL, 0x33e33333e33333e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71381c71381c71ULL, 0x381c71381c71381cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1caac71caac71caaULL, 0xc71caac71caac71cULL, },
+        { 0x1c55c71c55c71c55ULL, 0xc71c55c71c55c71cULL, },
+        { 0x1ccccc1ccccc1cccULL, 0xcc1ccccc1ccccc1cULL, },
+        { 0x1c33331c33331c33ULL, 0x331c33331c33331cULL, },
+        { 0x1c71381c71381c71ULL, 0x381c71381c71381cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00cc2862c708ULL, 0x12f70b1afe3fb0fcULL, },
+        { 0xac5ae6cc28cf5540ULL, 0x27d80bfffe2b250cULL, },
+        { 0x704f16cc2831e240ULL, 0x4bf10bd8fe42e20cULL, },
+        { 0xfbbe00cc2862c708ULL, 0x12f70b1afe3fb0fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00aab9cfc708ULL, 0x12f7c6ff152b25fcULL, },
+        { 0xfbbe004d4d31e208ULL, 0x12f7bb1a153fe2fcULL, },
+        { 0xac5ae6cc28cf5540ULL, 0x27d80bfffe2b250cULL, },    /*  72  */
+        { 0xfbbe00aab9cfc708ULL, 0x12f7c6ff152b25fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac4f164db931e24eULL, 0x27f1c6ffab2be214ULL, },
+        { 0x704f16cc2831e240ULL, 0x4bf10bd8fe42e20cULL, },
+        { 0xfbbe004d4d31e208ULL, 0x12f7bb1a153fe2fcULL, },
+        { 0xac4f164db9cfe24eULL, 0x27f1c6ffab2be214ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
new file mode 100644
index 0000000..5f9a9d4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_A.D
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
+    char *instruction_name = "MIN_A.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
new file mode 100644
index 0000000..dc73927
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_A.H
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
+    char *instruction_name = "MIN_A.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3aaaae38eULL, 0x38e3aaaae38e38e3ULL, },
+        { 0x1c71c71caaaa1c71ULL, 0xc71caaaa1c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e35555e38eULL, 0x38e35555e38e38e3ULL, },
+        { 0x1c71c71c55551c71ULL, 0xc71c55551c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38ecccccccce38eULL, 0xcccccccce38eccccULL, },
+        { 0x1c71cccccccc1c71ULL, 0xcccccccc1c71ccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e33333333e38eULL, 0x33333333e38e3333ULL, },
+        { 0x1c71333333331c71ULL, 0x333333331c713333ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e3aaaae38eULL, 0x38e3aaaae38e38e3ULL, },
+        { 0xe38e38e35555e38eULL, 0x38e35555e38e38e3ULL, },
+        { 0xe38ecccccccce38eULL, 0xcccccccce38eccccULL, },
+        { 0xe38e33333333e38eULL, 0x33333333e38e3333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c7138e371c71c71ULL, 0x38e371c71c7138e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71caaaa1c71ULL, 0xc71caaaa1c71c71cULL, },
+        { 0x1c71c71c55551c71ULL, 0xc71c55551c71c71cULL, },
+        { 0x1c71cccccccc1c71ULL, 0xcccccccc1c71ccccULL, },
+        { 0x1c71333333331c71ULL, 0x333333331c713333ULL, },
+        { 0x1c7138e371c71c71ULL, 0x38e371c71c7138e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00632862c708ULL, 0x12f70b5efe7bb00cULL, },
+        { 0xac5ae6cc28625540ULL, 0x27d80b5efe7b2514ULL, },
+        { 0x704f164d2862e24eULL, 0x4b670b5efe7be2a0ULL, },
+        { 0xfbbe00632862c708ULL, 0x12f70b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe0063b9cfc708ULL, 0x12f7c6ff153f2514ULL, },
+        { 0xfbbe00634d93e24eULL, 0x12f7bb1a153fe2a0ULL, },
+        { 0xac5ae6cc28625540ULL, 0x27d80b5efe7b2514ULL, },    /*  72  */
+        { 0xfbbe0063b9cfc708ULL, 0x12f7c6ff153f2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5a164db9cfe24eULL, 0x27d8c6ffab2be2a0ULL, },
+        { 0x704f164d2862e24eULL, 0x4b670b5efe7be2a0ULL, },
+        { 0xfbbe00634d93e24eULL, 0x12f7bb1a153fe2a0ULL, },
+        { 0xac5a164db9cfe24eULL, 0x27d8c6ffab2be2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
new file mode 100644
index 0000000..67b33f3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_A.W
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
+    char *instruction_name = "MIN_A.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71caaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e355555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0x1c71c71cccccccccULL, 0xcccccccc1c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e333333333ULL, 0x33333333e38e38e3ULL, },
+        { 0x1c71c71c33333333ULL, 0x333333331c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e355555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xe38e38e333333333ULL, 0x33333333e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71caaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71cccccccccULL, 0xcccccccc1c71c71cULL, },
+        { 0x1c71c71c33333333ULL, 0x333333331c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe006328625540ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0xac5aaeaa28625540ULL, 0x27d8c6fffe7bb00cULL, },
+        { 0x704f164d28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe006328625540ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe0063b9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaa28625540ULL, 0x27d8c6fffe7bb00cULL, },    /*  72  */
+        { 0xfbbe0063b9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_A_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
new file mode 100644
index 0000000..76bb133
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_S.B
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
+    char *instruction_name = "MIN_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe38effe38effe38eULL, 0xffe38effe38effe3ULL, },
+        { 0xffffc7ffffc7ffffULL, 0xc7ffffc7ffffc7ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e00e38e00e38eULL, 0x00e38e00e38e00e3ULL, },
+        { 0x0000c70000c70000ULL, 0xc70000c70000c700ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa8eaaaa8eaaaa8eULL, 0xaaaa8eaaaa8eaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c55c71c55c71c55ULL, 0xc71c55c71c55c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcc8ecccc8ecccc8eULL, 0xcccc8ecccc8eccccULL, },
+        { 0xccccc7ccccc7ccccULL, 0xc7ccccc7ccccc7ccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e33e38e33e38eULL, 0x33e38e33e38e33e3ULL, },
+        { 0x1c33c71c33c71c33ULL, 0xc71c33c71c33c71cULL, },
+        { 0xe38effe38effe38eULL, 0xffe38effe38effe3ULL, },    /*  48  */
+        { 0xe38e00e38e00e38eULL, 0x00e38e00e38e00e3ULL, },
+        { 0xaa8eaaaa8eaaaa8eULL, 0xaaaa8eaaaa8eaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xcc8ecccc8ecccc8eULL, 0xcccc8ecccc8eccccULL, },
+        { 0xe38e33e38e33e38eULL, 0x33e38e33e38e33e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38ec7e38ec7e38eULL, 0xc7e38ec7e38ec7e3ULL, },
+        { 0xffffc7ffffc7ffffULL, 0xc7ffffc7ffffc7ffULL, },    /*  56  */
+        { 0x0000c70000c70000ULL, 0xc70000c70000c700ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c55c71c55c71c55ULL, 0xc71c55c71c55c71cULL, },
+        { 0xccccc7ccccc7ccccULL, 0xc7ccccc7ccccc7ccULL, },
+        { 0x1c33c71c33c71c33ULL, 0xc71c33c71c33c71cULL, },
+        { 0xe38ec7e38ec7e38eULL, 0xc7e38ec7e38ec7e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x88bee6cc2893c708ULL, 0x12f7bb1afe3fb0fcULL, },
+        { 0x885aaeaab9cf8b80ULL, 0x27d8c6ffab2bb00cULL, },
+        { 0x884fe6cc2831e240ULL, 0x8df188d8a942b0a0ULL, },
+        { 0x88bee6cc2893c708ULL, 0x12f7bb1afe3fb0fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xacbeaeaab9938b80ULL, 0x12d8bbffab2b25fcULL, },
+        { 0xfbbe004d4d93c708ULL, 0x8df188d8a93fe2a0ULL, },
+        { 0x885aaeaab9cf8b80ULL, 0x27d8c6ffab2bb00cULL, },    /*  72  */
+        { 0xacbeaeaab9938b80ULL, 0x12d8bbffab2b25fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac4faeaab9cf8b80ULL, 0x8dd888d8a92be2a0ULL, },
+        { 0x884fe6cc2831e240ULL, 0x8df188d8a942b0a0ULL, },
+        { 0xfbbe004d4d93c708ULL, 0x8df188d8a93fe2a0ULL, },
+        { 0xac4faeaab9cf8b80ULL, 0x8dd888d8a92be2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
new file mode 100644
index 0000000..8ef57a9
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_S.D
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
+    char *instruction_name = "MIN_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
new file mode 100644
index 0000000..e206040
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_S.H
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
+    char *instruction_name = "MIN_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe38effff8e38e38eULL, 0xffff8e38e38effffULL, },
+        { 0xffffc71cffffffffULL, 0xc71cffffffffc71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e00008e38e38eULL, 0x00008e38e38e0000ULL, },
+        { 0x0000c71c00000000ULL, 0xc71c00000000c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa8e38aaaaULL, 0xaaaa8e38aaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c55551c71ULL, 0xc71c55551c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc8e38ccccULL, 0xcccc8e38ccccccccULL, },
+        { 0xccccc71cccccccccULL, 0xc71cccccccccc71cULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e33338e38e38eULL, 0x33338e38e38e3333ULL, },
+        { 0x1c71c71c33331c71ULL, 0xc71c33331c71c71cULL, },
+        { 0xe38effff8e38e38eULL, 0xffff8e38e38effffULL, },    /*  48  */
+        { 0xe38e00008e38e38eULL, 0x00008e38e38e0000ULL, },
+        { 0xaaaaaaaa8e38aaaaULL, 0xaaaa8e38aaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xcccccccc8e38ccccULL, 0xcccc8e38ccccccccULL, },
+        { 0xe38e33338e38e38eULL, 0x33338e38e38e3333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38ec71c8e38e38eULL, 0xc71c8e38e38ec71cULL, },
+        { 0xffffc71cffffffffULL, 0xc71cffffffffc71cULL, },    /*  56  */
+        { 0x0000c71c00000000ULL, 0xc71c00000000c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c55551c71ULL, 0xc71c55551c71c71cULL, },
+        { 0xccccc71cccccccccULL, 0xc71cccccccccc71cULL, },
+        { 0x1c71c71c33331c71ULL, 0xc71c33331c71c71cULL, },
+        { 0xe38ec71c8e38e38eULL, 0xc71c8e38e38ec71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc2862c708ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0x886aaeaab9cf8b80ULL, 0x27d8c6ffab2bb00cULL, },
+        { 0x886ae6cc2862e24eULL, 0x8df188d8a942b00cULL, },
+        { 0x886ae6cc2862c708ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1aab2b2514ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886aaeaab9cf8b80ULL, 0x27d8c6ffab2bb00cULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1aab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc2862e24eULL, 0x8df188d8a942b00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
new file mode 100644
index 0000000..7532bce
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_S.W
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
+    char *instruction_name = "MIN_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c7ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0xc71c71c700000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccc8e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c7ccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x33333333e38e38e3ULL, },
+        { 0x1c71c71c33333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffe38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xcccccccc8e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x33333333e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c7ffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c71c700000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xc71c71c7ccccccccULL, },
+        { 0x1c71c71c33333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0x886ae6ccb9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1aab2b2514ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6ccb9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1aab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
new file mode 100644
index 0000000..1f61145
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_U.B
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
+    char *instruction_name = "MIN_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaa8e38aa8e38aa8eULL, 0x38aa8e38aa8e38aaULL, },
+        { 0x1c71aa1c71aa1c71ULL, 0xaa1c71aa1c71aa1cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555385555385555ULL, 0x3855553855553855ULL, },
+        { 0x1c55551c55551c55ULL, 0x551c55551c55551cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcc8e38cc8e38cc8eULL, 0x38cc8e38cc8e38ccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c33331c33331c33ULL, 0x331c33331c33331cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaa8e38aa8e38aa8eULL, 0x38aa8e38aa8e38aaULL, },
+        { 0x5555385555385555ULL, 0x3855553855553855ULL, },
+        { 0xcc8e38cc8e38cc8eULL, 0x38cc8e38cc8e38ccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71381c71381c71ULL, 0x381c71381c71381cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71aa1c71aa1c71ULL, 0xaa1c71aa1c71aa1cULL, },
+        { 0x1c55551c55551c55ULL, 0x551c55551c55551cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c33331c33331c33ULL, 0x331c33331c33331cULL, },
+        { 0x1c71381c71381c71ULL, 0x381c71381c71381cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886a006328625508ULL, 0x12670b1a153f520cULL, },
+        { 0x885aaeaa28625540ULL, 0x27670b5eab2b250cULL, },
+        { 0x704f164d28315540ULL, 0x4b670b5ea942b00cULL, },
+        { 0x886a006328625508ULL, 0x12670b1a153f520cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5a00634d938b08ULL, 0x12d8bb1a152b2514ULL, },
+        { 0x704f004d4d31c708ULL, 0x12f1881a153f52a0ULL, },
+        { 0x885aaeaa28625540ULL, 0x27670b5eab2b250cULL, },    /*  72  */
+        { 0xac5a00634d938b08ULL, 0x12d8bb1a152b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e318b4eULL, 0x27d888d8a92b2514ULL, },
+        { 0x704f164d28315540ULL, 0x4b670b5ea942b00cULL, },
+        { 0x704f004d4d31c708ULL, 0x12f1881a153f52a0ULL, },
+        { 0x704f164d5e318b4eULL, 0x27d888d8a92b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
new file mode 100644
index 0000000..4626c62
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_U.D
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
+    char *instruction_name = "MIN_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
new file mode 100644
index 0000000..5eeb8d0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_U.H
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
+    char *instruction_name = "MIN_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaa38e38e38aaaaULL, 0x38e38e38aaaa38e3ULL, },
+        { 0x1c71aaaa71c71c71ULL, 0xaaaa71c71c71aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x555538e355555555ULL, 0x38e35555555538e3ULL, },
+        { 0x1c71555555551c71ULL, 0x555555551c715555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcccc38e38e38ccccULL, 0x38e38e38cccc38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71333333331c71ULL, 0x333333331c713333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaa38e38e38aaaaULL, 0x38e38e38aaaa38e3ULL, },
+        { 0x555538e355555555ULL, 0x38e35555555538e3ULL, },
+        { 0xcccc38e38e38ccccULL, 0x38e38e38cccc38e3ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c7138e371c71c71ULL, 0x38e371c71c7138e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71aaaa71c71c71ULL, 0xaaaa71c71c71aaaaULL, },
+        { 0x1c71555555551c71ULL, 0x555555551c715555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71333333331c71ULL, 0x333333331c713333ULL, },
+        { 0x1c7138e371c71c71ULL, 0x38e371c71c7138e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886a006328625540ULL, 0x12f70b5e153f52fcULL, },
+        { 0x886aaeaa28625540ULL, 0x27d80b5eab2b2514ULL, },
+        { 0x704f164d28625540ULL, 0x4b670b5ea942b00cULL, },
+        { 0x886a006328625540ULL, 0x12f70b5e153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5a00634d938b80ULL, 0x12f7bb1a153f2514ULL, },
+        { 0x704f00634d93c708ULL, 0x12f788d8153f52fcULL, },
+        { 0x886aaeaa28625540ULL, 0x27d80b5eab2b2514ULL, },    /*  72  */
+        { 0xac5a00634d938b80ULL, 0x12f7bb1a153f2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e318b80ULL, 0x27d888d8a9422514ULL, },
+        { 0x704f164d28625540ULL, 0x4b670b5ea942b00cULL, },
+        { 0x704f00634d93c708ULL, 0x12f788d8153f52fcULL, },
+        { 0x704f164d5e318b80ULL, 0x27d888d8a9422514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
new file mode 100644
index 0000000..e70964a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction MIN_U.W
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
+    char *instruction_name = "MIN_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0x38e38e38aaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x38e38e3855555555ULL, },
+        { 0x1c71c71c55555555ULL, 0x555555551c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c33333333ULL, 0x333333331c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0x38e38e38aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x38e38e3855555555ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x1c71c71c55555555ULL, 0x555555551c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c33333333ULL, 0x333333331c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d28625540ULL, 0x4b670b5ea942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaa4d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d4d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaa4d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffa942e2a0ULL, },
+        { 0x704f164d28625540ULL, 0x4b670b5ea942e2a0ULL, },
+        { 0x704f164d4d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffa942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MIN_U_W(b128_random[i], b128_random[j],
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
-- 
2.7.4
