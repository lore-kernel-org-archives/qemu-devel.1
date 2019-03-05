Received: from eggs.gnu.org ([209.51.188.92]:47119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESs-0001GM-30
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESk-0002Bu-7g
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:53 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51697 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1ESi-00028r-Qa
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:45 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 19:05:26 +0100
Message-Id: <1551809127-3658-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 14/15] tests/tcg: target/mips: Add tests for MSA
 pack instructions
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

Add tests for MSA pack instructions. This includes following
instructions:

  * PCKEV.B - pack even (bytes)
  * PCKEV.H - pack even (halfwords)
  * PCKEV.W - pack even (words)
  * PCKEV.D - pack even (doublewords)
  * PCKOD.B - pack odd (bytes)
  * PCKOD.H - pack odd (halfwords)
  * PCKOD.W - pack odd (words)
  * PCKOD.D - pack odd (doublewords)
  * VSHF.B - data preserving shuffle (bytes)
  * VSHF.H - data preserving shuffle (halfwords)
  * VSHF.W - data preserving shuffle (words)
  * VSHF.D - data preserving shuffle (doublewords)

Each test consists of 80 test cases, so altogether there are 960
test cases.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1551800076-8104-15-git-send-email-aleksandar.markovic@rt-rk.com>
---
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 153 +++++++++++++++++++++
 12 files changed, 1836 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c

diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
new file mode 100644
index 0000000..d98dd22
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKEV.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKEV.B";
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
+        { 0xe3388ee38ee3388eULL, 0xffffffffffffffffULL, },
+        { 0x1cc7711c711cc771ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0xe3388ee38ee3388eULL, 0x0000000000000000ULL, },
+        { 0x1cc7711c711cc771ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe3388ee38ee3388eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1cc7711c711cc771ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0xe3388ee38ee3388eULL, 0x5555555555555555ULL, },
+        { 0x1cc7711c711cc771ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0xe3388ee38ee3388eULL, 0xccccccccccccccccULL, },
+        { 0x1cc7711c711cc771ULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe3388ee38ee3388eULL, 0x3333333333333333ULL, },
+        { 0x1cc7711c711cc771ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0xe3388ee38ee3388eULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0xe3388ee38ee3388eULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xe3388ee38ee3388eULL, },
+        { 0x5555555555555555ULL, 0xe3388ee38ee3388eULL, },
+        { 0xccccccccccccccccULL, 0xe3388ee38ee3388eULL, },
+        { 0x3333333333333333ULL, 0xe3388ee38ee3388eULL, },
+        { 0xe3388ee38ee3388eULL, 0xe3388ee38ee3388eULL, },
+        { 0x1cc7711c711cc771ULL, 0xe3388ee38ee3388eULL, },
+        { 0xffffffffffffffffULL, 0x1cc7711c711cc771ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x1cc7711c711cc771ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x1cc7711c711cc771ULL, },
+        { 0x5555555555555555ULL, 0x1cc7711c711cc771ULL, },
+        { 0xccccccccccccccccULL, 0x1cc7711c711cc771ULL, },
+        { 0x3333333333333333ULL, 0x1cc7711c711cc771ULL, },
+        { 0xe3388ee38ee3388eULL, 0x1cc7711c711cc771ULL, },
+        { 0x1cc7711c711cc771ULL, 0x1cc7711c711cc771ULL, },
+        { 0x675e7b0c6acc6240ULL, 0x675e7b0c6acc6240ULL, },    /*  64  */
+        { 0xf71a3ffcbe639308ULL, 0x675e7b0c6acc6240ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0x675e7b0c6acc6240ULL, },
+        { 0xf1d842a04f4d314eULL, 0x675e7b0c6acc6240ULL, },
+        { 0x675e7b0c6acc6240ULL, 0xf71a3ffcbe639308ULL, },
+        { 0xf71a3ffcbe639308ULL, 0xf71a3ffcbe639308ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0xf71a3ffcbe639308ULL, },
+        { 0xf1d842a04f4d314eULL, 0xf71a3ffcbe639308ULL, },
+        { 0x675e7b0c6acc6240ULL, 0xd8ff2b145aaacf80ULL, },    /*  72  */
+        { 0xf71a3ffcbe639308ULL, 0xd8ff2b145aaacf80ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0xd8ff2b145aaacf80ULL, },
+        { 0xf1d842a04f4d314eULL, 0xd8ff2b145aaacf80ULL, },
+        { 0x675e7b0c6acc6240ULL, 0xf1d842a04f4d314eULL, },
+        { 0xf71a3ffcbe639308ULL, 0xf1d842a04f4d314eULL, },
+        { 0xd8ff2b145aaacf80ULL, 0xf1d842a04f4d314eULL, },
+        { 0xf1d842a04f4d314eULL, 0xf1d842a04f4d314eULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
new file mode 100644
index 0000000..543fb6a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKEV.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKEV.D";
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
+            do_msa_PCKEV_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
new file mode 100644
index 0000000..64a18c0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKEV.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKEV.H";
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
+        { 0x8e3838e338e3e38eULL, 0xffffffffffffffffULL, },
+        { 0x71c7c71cc71c1c71ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0x8e3838e338e3e38eULL, 0x0000000000000000ULL, },
+        { 0x71c7c71cc71c1c71ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8e3838e338e3e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x71c7c71cc71c1c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0x8e3838e338e3e38eULL, 0x5555555555555555ULL, },
+        { 0x71c7c71cc71c1c71ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0x8e3838e338e3e38eULL, 0xccccccccccccccccULL, },
+        { 0x71c7c71cc71c1c71ULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8e3838e338e3e38eULL, 0x3333333333333333ULL, },
+        { 0x71c7c71cc71c1c71ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x8e3838e338e3e38eULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x8e3838e338e3e38eULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x8e3838e338e3e38eULL, },
+        { 0x5555555555555555ULL, 0x8e3838e338e3e38eULL, },
+        { 0xccccccccccccccccULL, 0x8e3838e338e3e38eULL, },
+        { 0x3333333333333333ULL, 0x8e3838e338e3e38eULL, },
+        { 0x8e3838e338e3e38eULL, 0x8e3838e338e3e38eULL, },
+        { 0x71c7c71cc71c1c71ULL, 0x8e3838e338e3e38eULL, },
+        { 0xffffffffffffffffULL, 0x71c7c71cc71c1c71ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x71c7c71cc71c1c71ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x71c7c71cc71c1c71ULL, },
+        { 0x5555555555555555ULL, 0x71c7c71cc71c1c71ULL, },
+        { 0xccccccccccccccccULL, 0x71c7c71cc71c1c71ULL, },
+        { 0x3333333333333333ULL, 0x71c7c71cc71c1c71ULL, },
+        { 0x8e3838e338e3e38eULL, 0x71c7c71cc71c1c71ULL, },
+        { 0x71c7c71cc71c1c71ULL, 0x71c7c71cc71c1c71ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0x0b5eb00ce6cc5540ULL, },    /*  64  */
+        { 0xbb1a52fc0063c708ULL, 0x0b5eb00ce6cc5540ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0x0b5eb00ce6cc5540ULL, },
+        { 0x88d8e2a0164de24eULL, 0x0b5eb00ce6cc5540ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0xbb1a52fc0063c708ULL, },
+        { 0xbb1a52fc0063c708ULL, 0xbb1a52fc0063c708ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0xbb1a52fc0063c708ULL, },
+        { 0x88d8e2a0164de24eULL, 0xbb1a52fc0063c708ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0xc6ff2514aeaa8b80ULL, },    /*  72  */
+        { 0xbb1a52fc0063c708ULL, 0xc6ff2514aeaa8b80ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0xc6ff2514aeaa8b80ULL, },
+        { 0x88d8e2a0164de24eULL, 0xc6ff2514aeaa8b80ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0x88d8e2a0164de24eULL, },
+        { 0xbb1a52fc0063c708ULL, 0x88d8e2a0164de24eULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0x88d8e2a0164de24eULL, },
+        { 0x88d8e2a0164de24eULL, 0x88d8e2a0164de24eULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
new file mode 100644
index 0000000..a0acacd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKEV.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKEV.W";
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
+        { 0xfe7bb00c28625540ULL, 0xfe7bb00c28625540ULL, },    /*  64  */
+        { 0x153f52fc4d93c708ULL, 0xfe7bb00c28625540ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0xfe7bb00c28625540ULL, },
+        { 0xa942e2a05e31e24eULL, 0xfe7bb00c28625540ULL, },
+        { 0xfe7bb00c28625540ULL, 0x153f52fc4d93c708ULL, },
+        { 0x153f52fc4d93c708ULL, 0x153f52fc4d93c708ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0x153f52fc4d93c708ULL, },
+        { 0xa942e2a05e31e24eULL, 0x153f52fc4d93c708ULL, },
+        { 0xfe7bb00c28625540ULL, 0xab2b2514b9cf8b80ULL, },    /*  72  */
+        { 0x153f52fc4d93c708ULL, 0xab2b2514b9cf8b80ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0xab2b2514b9cf8b80ULL, },
+        { 0xa942e2a05e31e24eULL, 0xab2b2514b9cf8b80ULL, },
+        { 0xfe7bb00c28625540ULL, 0xa942e2a05e31e24eULL, },
+        { 0x153f52fc4d93c708ULL, 0xa942e2a05e31e24eULL, },
+        { 0xab2b2514b9cf8b80ULL, 0xa942e2a05e31e24eULL, },
+        { 0xa942e2a05e31e24eULL, 0xa942e2a05e31e24eULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
new file mode 100644
index 0000000..7bf86fc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKOD.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKOD.B";
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
+        { 0x388ee338e3388ee3ULL, 0xffffffffffffffffULL, },
+        { 0xc7711cc71cc7711cULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0x388ee338e3388ee3ULL, 0x0000000000000000ULL, },
+        { 0xc7711cc71cc7711cULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x388ee338e3388ee3ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xc7711cc71cc7711cULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0x388ee338e3388ee3ULL, 0x5555555555555555ULL, },
+        { 0xc7711cc71cc7711cULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0x388ee338e3388ee3ULL, 0xccccccccccccccccULL, },
+        { 0xc7711cc71cc7711cULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x388ee338e3388ee3ULL, 0x3333333333333333ULL, },
+        { 0xc7711cc71cc7711cULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x388ee338e3388ee3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x388ee338e3388ee3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x388ee338e3388ee3ULL, },
+        { 0x5555555555555555ULL, 0x388ee338e3388ee3ULL, },
+        { 0xccccccccccccccccULL, 0x388ee338e3388ee3ULL, },
+        { 0x3333333333333333ULL, 0x388ee338e3388ee3ULL, },
+        { 0x388ee338e3388ee3ULL, 0x388ee338e3388ee3ULL, },
+        { 0xc7711cc71cc7711cULL, 0x388ee338e3388ee3ULL, },
+        { 0xffffffffffffffffULL, 0xc7711cc71cc7711cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc7711cc71cc7711cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc7711cc71cc7711cULL, },
+        { 0x5555555555555555ULL, 0xc7711cc71cc7711cULL, },
+        { 0xccccccccccccccccULL, 0xc7711cc71cc7711cULL, },
+        { 0x3333333333333333ULL, 0xc7711cc71cc7711cULL, },
+        { 0x388ee338e3388ee3ULL, 0xc7711cc71cc7711cULL, },
+        { 0xc7711cc71cc7711cULL, 0xc7711cc71cc7711cULL, },
+        { 0x4b0bfeb088e62855ULL, 0x4b0bfeb088e62855ULL, },    /*  64  */
+        { 0x12bb1552fb004dc7ULL, 0x4b0bfeb088e62855ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x4b0bfeb088e62855ULL, },
+        { 0x8d88a9e270165ee2ULL, 0x4b0bfeb088e62855ULL, },
+        { 0x4b0bfeb088e62855ULL, 0x12bb1552fb004dc7ULL, },
+        { 0x12bb1552fb004dc7ULL, 0x12bb1552fb004dc7ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x12bb1552fb004dc7ULL, },
+        { 0x8d88a9e270165ee2ULL, 0x12bb1552fb004dc7ULL, },
+        { 0x4b0bfeb088e62855ULL, 0x27c6ab25acaeb98bULL, },    /*  72  */
+        { 0x12bb1552fb004dc7ULL, 0x27c6ab25acaeb98bULL, },
+        { 0x27c6ab25acaeb98bULL, 0x27c6ab25acaeb98bULL, },
+        { 0x8d88a9e270165ee2ULL, 0x27c6ab25acaeb98bULL, },
+        { 0x4b0bfeb088e62855ULL, 0x8d88a9e270165ee2ULL, },
+        { 0x12bb1552fb004dc7ULL, 0x8d88a9e270165ee2ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x8d88a9e270165ee2ULL, },
+        { 0x8d88a9e270165ee2ULL, 0x8d88a9e270165ee2ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
new file mode 100644
index 0000000..3c4d55b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKOD.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKOD.D";
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
+            do_msa_PCKOD_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
new file mode 100644
index 0000000..5c3c529
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKOD.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKOD.H";
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
+        { 0x38e3e38ee38e8e38ULL, 0xffffffffffffffffULL, },
+        { 0xc71c1c711c7171c7ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x0000000000000000ULL, },
+        { 0x38e3e38ee38e8e38ULL, 0x0000000000000000ULL, },
+        { 0xc71c1c711c7171c7ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x38e3e38ee38e8e38ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xc71c1c711c7171c7ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x5555555555555555ULL, },
+        { 0x38e3e38ee38e8e38ULL, 0x5555555555555555ULL, },
+        { 0xc71c1c711c7171c7ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xccccccccccccccccULL, },
+        { 0x38e3e38ee38e8e38ULL, 0xccccccccccccccccULL, },
+        { 0xc71c1c711c7171c7ULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x38e3e38ee38e8e38ULL, 0x3333333333333333ULL, },
+        { 0xc71c1c711c7171c7ULL, 0x3333333333333333ULL, },
+        { 0xffffffffffffffffULL, 0x38e3e38ee38e8e38ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e3e38ee38e8e38ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e3e38ee38e8e38ULL, },
+        { 0x5555555555555555ULL, 0x38e3e38ee38e8e38ULL, },
+        { 0xccccccccccccccccULL, 0x38e3e38ee38e8e38ULL, },
+        { 0x3333333333333333ULL, 0x38e3e38ee38e8e38ULL, },
+        { 0x38e3e38ee38e8e38ULL, 0x38e3e38ee38e8e38ULL, },
+        { 0xc71c1c711c7171c7ULL, 0x38e3e38ee38e8e38ULL, },
+        { 0xffffffffffffffffULL, 0xc71c1c711c7171c7ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c1c711c7171c7ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c1c711c7171c7ULL, },
+        { 0x5555555555555555ULL, 0xc71c1c711c7171c7ULL, },
+        { 0xccccccccccccccccULL, 0xc71c1c711c7171c7ULL, },
+        { 0x3333333333333333ULL, 0xc71c1c711c7171c7ULL, },
+        { 0x38e3e38ee38e8e38ULL, 0xc71c1c711c7171c7ULL, },
+        { 0xc71c1c711c7171c7ULL, 0xc71c1c711c7171c7ULL, },
+        { 0x4b67fe7b886a2862ULL, 0x4b67fe7b886a2862ULL, },    /*  64  */
+        { 0x12f7153ffbbe4d93ULL, 0x4b67fe7b886a2862ULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x4b67fe7b886a2862ULL, },
+        { 0x8df1a942704f5e31ULL, 0x4b67fe7b886a2862ULL, },
+        { 0x4b67fe7b886a2862ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x12f7153ffbbe4d93ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x8df1a942704f5e31ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x4b67fe7b886a2862ULL, 0x27d8ab2bac5ab9cfULL, },    /*  72  */
+        { 0x12f7153ffbbe4d93ULL, 0x27d8ab2bac5ab9cfULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x27d8ab2bac5ab9cfULL, },
+        { 0x8df1a942704f5e31ULL, 0x27d8ab2bac5ab9cfULL, },
+        { 0x4b67fe7b886a2862ULL, 0x8df1a942704f5e31ULL, },
+        { 0x12f7153ffbbe4d93ULL, 0x8df1a942704f5e31ULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x8df1a942704f5e31ULL, },
+        { 0x8df1a942704f5e31ULL, 0x8df1a942704f5e31ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
new file mode 100644
index 0000000..9275890
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction PCKOD.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "PCKOD.W";
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
+        { 0x4b670b5e886ae6ccULL, 0x4b670b5e886ae6ccULL, },    /*  64  */
+        { 0x12f7bb1afbbe0063ULL, 0x4b670b5e886ae6ccULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x4b670b5e886ae6ccULL, },
+        { 0x8df188d8704f164dULL, 0x4b670b5e886ae6ccULL, },
+        { 0x4b670b5e886ae6ccULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x12f7bb1afbbe0063ULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x8df188d8704f164dULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x4b670b5e886ae6ccULL, 0x27d8c6ffac5aaeaaULL, },    /*  72  */
+        { 0x12f7bb1afbbe0063ULL, 0x27d8c6ffac5aaeaaULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x27d8c6ffac5aaeaaULL, },
+        { 0x8df188d8704f164dULL, 0x27d8c6ffac5aaeaaULL, },
+        { 0x4b670b5e886ae6ccULL, 0x8df188d8704f164dULL, },
+        { 0x12f7bb1afbbe0063ULL, 0x8df188d8704f164dULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x8df188d8704f164dULL, },
+        { 0x8df188d8704f164dULL, 0x8df188d8704f164dULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
new file mode 100644
index 0000000..fcf857a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction VSHF.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "VSHF.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e8e8e8e8e8e8e8eULL, 0x8e8e8e8e8e8e8e8eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
new file mode 100644
index 0000000..700c159
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction VSHF.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "VSHF.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
new file mode 100644
index 0000000..3d6c1dc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction VSHF.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "VSHF.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38ee38ee38ee38eULL, 0xe38ee38ee38ee38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
new file mode 100644
index 0000000..6030762
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction VSHF.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *`
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
+    char *instruction_name = "VSHF.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e8e38e38eULL, 0x8e38e38e8e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_W(b128_random[i], b128_random[j],
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
