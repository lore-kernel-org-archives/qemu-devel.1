Received: from eggs.gnu.org ([209.51.188.92]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYQ1-0006Si-5a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYPt-0003x9-AM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56062 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hHYPp-0003MH-DM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:15 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Apr 2019 20:38:00 +0200
Message-Id: <1555699081-24577-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/5] tests/tcg: target/mips: Add tests for MSA
 bit set instructions
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

Add tests for MSA bit set instructions. This includes following
instructions:

  * BCLR.B - clear bit (bytes)
  * BCLR.H - clear bit (halfwords)
  * BCLR.W - clear bit (words)
  * BCLR.D - clear bit (doublewords)
  * BNEG.B - negate bit (bytes)
  * BNEG.H - negate bit (halfwords)
  * BNEG.W - negate bit (words)
  * BNEG.D - negate bit (doublewords)
  * BSET.B - set bit (bytes)
  * BSET.H - set bit (halfwords)
  * BSET.W - set bit (words)
  * BSET.D - set bit (doublewords)

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../mips/user/ase/msa/bit-set/test_msa_bclr_b.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_d.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_h.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_w.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_b.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_d.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_h.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_w.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_b.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_d.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_h.c    | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_w.c    | 153 +++++++++++++++++++++
 12 files changed, 1836 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c

diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
new file mode 100644
index 0000000..c5aab14
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BCLR.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BCLR.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },    /*   0  */
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },
+        { 0xfbfbfbfbfbfbfbfbULL, 0xfbfbfbfbfbfbfbfbULL, },
+        { 0xdfdfdfdfdfdfdfdfULL, 0xdfdfdfdfdfdfdfdfULL, },
+        { 0xefefefefefefefefULL, 0xefefefefefefefefULL, },
+        { 0xf7f7f7f7f7f7f7f7ULL, 0xf7f7f7f7f7f7f7f7ULL, },
+        { 0xf7bffef7bffef7bfULL, 0xfef7bffef7bffef7ULL, },
+        { 0xeffd7feffd7feffdULL, 0x7feffd7feffd7fefULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8a8a8a8a8a8a8a8aULL, 0x8a8a8a8a8a8a8a8aULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xa2a2a2a2a2a2a2a2ULL, 0xa2a2a2a2a2a2a2a2ULL, },
+        { 0xa2aaaaa2aaaaa2aaULL, 0xaaa2aaaaa2aaaaa2ULL, },
+        { 0xaaa82aaaa82aaaa8ULL, 0x2aaaa82aaaa82aaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },
+        { 0x5151515151515151ULL, 0x5151515151515151ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x4545454545454545ULL, 0x4545454545454545ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5515545515545515ULL, 0x5455155455155455ULL, },
+        { 0x4555554555554555ULL, 0x5545555545555545ULL, },
+        { 0x4c4c4c4c4c4c4c4cULL, 0x4c4c4c4c4c4c4c4cULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xc8c8c8c8c8c8c8c8ULL, 0xc8c8c8c8c8c8c8c8ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xc4c4c4c4c4c4c4c4ULL, 0xc4c4c4c4c4c4c4c4ULL, },
+        { 0xc48cccc48cccc48cULL, 0xccc48cccc48cccc4ULL, },
+        { 0xcccc4ccccc4cccccULL, 0x4ccccc4ccccc4cccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3232323232323232ULL, 0x3232323232323232ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1313131313131313ULL, 0x1313131313131313ULL, },
+        { 0x2323232323232323ULL, 0x2323232323232323ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333323333323333ULL, 0x3233333233333233ULL, },
+        { 0x2331332331332331ULL, 0x3323313323313323ULL, },
+        { 0x630e38630e38630eULL, 0x38630e38630e3863ULL, },    /*  48  */
+        { 0xe28e38e28e38e28eULL, 0x38e28e38e28e38e2ULL, },
+        { 0xe38a38e38a38e38aULL, 0x38e38a38e38a38e3ULL, },
+        { 0xc38e18c38e18c38eULL, 0x18c38e18c38e18c3ULL, },
+        { 0xe38e28e38e28e38eULL, 0x28e38e28e38e28e3ULL, },
+        { 0xe38630e38630e386ULL, 0x30e38630e38630e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38c38e38c38e38cULL, 0x38e38c38e38c38e3ULL, },
+        { 0x1c71471c71471c71ULL, 0x471c71471c71471cULL, },    /*  56  */
+        { 0x1c70c61c70c61c70ULL, 0xc61c70c61c70c61cULL, },
+        { 0x1871c31871c31871ULL, 0xc31871c31871c318ULL, },
+        { 0x1c51c71c51c71c51ULL, 0xc71c51c71c51c71cULL, },
+        { 0x0c61c70c61c70c61ULL, 0xc70c61c70c61c70cULL, },
+        { 0x1471c71471c71471ULL, 0xc71471c71471c714ULL, },
+        { 0x1431c61431c61431ULL, 0xc61431c61431c614ULL, },
+        { 0x0c71470c71470c71ULL, 0x470c71470c71470cULL, },
+        { 0x886aa6cc28625540ULL, 0x4367031ebe73b00cULL, },    /*  64  */
+        { 0x802ae6c408625540ULL, 0x4b67035ade7bb00cULL, },
+        { 0x886aa6c828625540ULL, 0x4b660b5ef673900cULL, },
+        { 0x886aa6cc28605100ULL, 0x4b650a5efc7bb00cULL, },
+        { 0xfaba00634c93c708ULL, 0x1277b31a153752ecULL, },
+        { 0xf3be00634d934708ULL, 0x1277b31a153f52ecULL, },
+        { 0xebba00634d13c708ULL, 0x12f6bb1a153752ecULL, },
+        { 0xfa3e00430d91c308ULL, 0x12f5ba1a153b52fcULL, },
+        { 0xac5aaeaab8cb8b80ULL, 0x2758c6bfab232404ULL, },    /*  72  */
+        { 0xa41aaea299c70b80ULL, 0x2358c6fb8b2b2104ULL, },
+        { 0xac5aaeaab94f8380ULL, 0x27d8867fa3230504ULL, },
+        { 0xac5aae8ab9cd8b80ULL, 0x07d8c6fea92b2114ULL, },
+        { 0x704b164d5e31c24eULL, 0x85718098a942e2a0ULL, },
+        { 0x700f16455e31624eULL, 0x897180d88942e2a0ULL, },
+        { 0x604b16495c31e24eULL, 0x0df08858a142c2a0ULL, },
+        { 0x704f164d1e31e20eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
new file mode 100644
index 0000000..11e616e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BCLR.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BCLR.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },    /*   0  */
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },
+        { 0xfffffbffffffffffULL, 0xfffffbffffffffffULL, },
+        { 0xffffffffffdfffffULL, 0xffffffffffdfffffULL, },
+        { 0xffffffffffffefffULL, 0xffffffffffffefffULL, },
+        { 0xfff7ffffffffffffULL, 0xfff7ffffffffffffULL, },
+        { 0xffffffffffffbfffULL, 0xfffffff7ffffffffULL, },
+        { 0xfffdffffffffffffULL, 0xffffffffefffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaa8aaaaaULL, 0xaaaaaaaaaa8aaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaa2aaaaaaaaaaaaULL, 0xaaa2aaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaa2aaaaaaaaULL, },
+        { 0xaaa8aaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },
+        { 0x5555515555555555ULL, 0x5555515555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555554555ULL, 0x5555555555554555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555551555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555545555555ULL, },
+        { 0x4cccccccccccccccULL, 0x4cccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccc8ccccccccccULL, 0xccccc8ccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccc4ccccccccccccULL, 0xccc4ccccccccccccULL, },
+        { 0xcccccccccccc8cccULL, 0xccccccc4ccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333332ULL, 0x3333333333333332ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333133333ULL, 0x3333333333133333ULL, },
+        { 0x3333333333332333ULL, 0x3333333333332333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3331333333333333ULL, 0x3333333323333333ULL, },
+        { 0x638e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e2ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38a38e38e38e3ULL, },
+        { 0xe38e38e38e18e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e28e3ULL, },
+        { 0xe38638e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38a38eULL, 0x38e38e30e38e38e3ULL, },
+        { 0xe38c38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c31c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c51c71cULL, },
+        { 0x1c71c71c71c70c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71471c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c70c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7ba00cULL, },    /*  64  */
+        { 0x886ae6cc28625440ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe6bb00cULL, },
+        { 0x886ae6cc28621540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f42fcULL, },
+        { 0xfbbe00634d93c608ULL, 0x02f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a152f52fcULL, },
+        { 0xfbbe00634d938708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8a80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6feab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31a24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
new file mode 100644
index 0000000..dc67b4d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BCLR.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BCLR.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },    /*   0  */
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xfbfffbfffbfffbffULL, 0xfbfffbfffbfffbffULL, },
+        { 0xffdfffdfffdfffdfULL, 0xffdfffdfffdfffdfULL, },
+        { 0xefffefffefffefffULL, 0xefffefffefffefffULL, },
+        { 0xfff7fff7fff7fff7ULL, 0xfff7fff7fff7fff7ULL, },
+        { 0xbffffff7feffbfffULL, 0xfff7feffbffffff7ULL, },
+        { 0xfffdefffff7ffffdULL, 0xefffff7ffffdefffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa8aaa8aaa8aaa8aULL, 0xaa8aaa8aaa8aaa8aULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaa2aaa2aaa2aaa2ULL, 0xaaa2aaa2aaa2aaa2ULL, },
+        { 0xaaaaaaa2aaaaaaaaULL, 0xaaa2aaaaaaaaaaa2ULL, },
+        { 0xaaa8aaaaaa2aaaa8ULL, 0xaaaaaa2aaaa8aaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },
+        { 0x5155515551555155ULL, 0x5155515551555155ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x4555455545554555ULL, 0x4555455545554555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1555555554551555ULL, 0x5555545515555555ULL, },
+        { 0x5555455555555555ULL, 0x4555555555554555ULL, },
+        { 0x4ccc4ccc4ccc4cccULL, 0x4ccc4ccc4ccc4cccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xc8ccc8ccc8ccc8ccULL, 0xc8ccc8ccc8ccc8ccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccc4ccc4ccc4ccc4ULL, 0xccc4ccc4ccc4ccc4ULL, },
+        { 0x8cccccc4cccc8cccULL, 0xccc4cccc8cccccc4ULL, },
+        { 0xcccccccccc4cccccULL, 0xcccccc4cccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3332333233323332ULL, 0x3332333233323332ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3313331333133313ULL, 0x3313331333133313ULL, },
+        { 0x2333233323332333ULL, 0x2333233323332333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333332333333ULL, 0x3333323333333333ULL, },
+        { 0x3331233333333331ULL, 0x2333333333312333ULL, },
+        { 0x638e38e30e38638eULL, 0x38e30e38638e38e3ULL, },    /*  48  */
+        { 0xe38e38e28e38e38eULL, 0x38e28e38e38e38e2ULL, },
+        { 0xe38e38e38a38e38eULL, 0x38e38a38e38e38e3ULL, },
+        { 0xe38e38c38e18e38eULL, 0x38c38e18e38e38c3ULL, },
+        { 0xe38e28e38e38e38eULL, 0x28e38e38e38e28e3ULL, },
+        { 0xe38638e38e30e386ULL, 0x38e38e30e38638e3ULL, },
+        { 0xa38e38e38e38a38eULL, 0x38e38e38a38e38e3ULL, },
+        { 0xe38c28e38e38e38cULL, 0x28e38e38e38c28e3ULL, },
+        { 0x1c71471c71c71c71ULL, 0x471c71c71c71471cULL, },    /*  56  */
+        { 0x1c70c71c71c61c70ULL, 0xc71c71c61c70c71cULL, },
+        { 0x1871c31c71c71871ULL, 0xc31c71c71871c31cULL, },
+        { 0x1c51c71c71c71c51ULL, 0xc71c71c71c51c71cULL, },
+        { 0x0c71c71c61c70c71ULL, 0xc71c61c70c71c71cULL, },
+        { 0x1c71c71471c71c71ULL, 0xc71471c71c71c714ULL, },
+        { 0x1c71c71470c71c71ULL, 0xc71470c71c71c714ULL, },
+        { 0x1c71c71c71471c71ULL, 0xc71c71471c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5ef67ba00cULL, },    /*  64  */
+        { 0x886ae6c428625440ULL, 0x4b670b5e7e7ba00cULL, },
+        { 0x886ae2cc28625540ULL, 0x4a670b5ef67bb00cULL, },
+        { 0x086ac6cc28601540ULL, 0x4b650a5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x1277bb1a153f42fcULL, },
+        { 0xbbbe00634d93c608ULL, 0x1277bb1a153f42fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f73b1a153f52ecULL, },
+        { 0x7bbe00634d918708ULL, 0x12f5ba1a153b52fcULL, },
+        { 0xa85aaeaab9cb8b80ULL, 0x275886ffa32b2514ULL, },    /*  72  */
+        { 0xac5aaea2b9c78a80ULL, 0x2758c2ff2b2b2514ULL, },
+        { 0xa85aaaaa39cf8b80ULL, 0x26d846ffa32b2504ULL, },
+        { 0x2c5a8eaab9cd8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f064d5e31e24eULL, 0x8d7188d8a142e2a0ULL, },
+        { 0x304f16455e31e24eULL, 0x8d7188d82942e2a0ULL, },
+        { 0x704f124d5e31e24eULL, 0x8cf108d8a142e2a0ULL, },
+        { 0x704f164d5e31a24eULL, 0x8df188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
new file mode 100644
index 0000000..ab0cce7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BCLR.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BCLR.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },    /*   0  */
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xfffffbfffffffbffULL, 0xfffffbfffffffbffULL, },
+        { 0xffdfffffffdfffffULL, 0xffdfffffffdfffffULL, },
+        { 0xffffefffffffefffULL, 0xffffefffffffefffULL, },
+        { 0xfff7fffffff7ffffULL, 0xfff7fffffff7ffffULL, },
+        { 0xfffffff7ffffbfffULL, 0xfefffffffffffff7ULL, },
+        { 0xeffffffffffdffffULL, 0xffffff7fefffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaa8aaaaaaa8aaaaaULL, 0xaa8aaaaaaa8aaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaa2aaaaaaa2aaaaULL, 0xaaa2aaaaaaa2aaaaULL, },
+        { 0xaaaaaaa2aaaaaaaaULL, 0xaaaaaaaaaaaaaaa2ULL, },
+        { 0xaaaaaaaaaaa8aaaaULL, 0xaaaaaa2aaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },
+        { 0x5555515555555155ULL, 0x5555515555555155ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555455555554555ULL, 0x5555455555554555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555551555ULL, 0x5455555555555555ULL, },
+        { 0x4555555555555555ULL, 0x5555555545555555ULL, },
+        { 0x4ccccccc4cccccccULL, 0x4ccccccc4cccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccc8ccccccc8ccULL, 0xccccc8ccccccc8ccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccc4ccccccc4ccccULL, 0xccc4ccccccc4ccccULL, },
+        { 0xccccccc4cccc8cccULL, 0xccccccccccccccc4ULL, },
+        { 0xccccccccccccccccULL, 0xcccccc4cccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333233333332ULL, 0x3333333233333332ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3313333333133333ULL, 0x3313333333133333ULL, },
+        { 0x3333233333332333ULL, 0x3333233333332333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3233333333333333ULL, },
+        { 0x2333333333313333ULL, 0x3333333323333333ULL, },
+        { 0x638e38e30e38e38eULL, 0x38e38e38638e38e3ULL, },    /*  48  */
+        { 0xe38e38e28e38e38eULL, 0x38e38e38e38e38e2ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38a38e38e38e3ULL, },
+        { 0xe38e38e38e18e38eULL, 0x38c38e38e38e38e3ULL, },
+        { 0xe38e28e38e38e38eULL, 0x38e38e38e38e28e3ULL, },
+        { 0xe38638e38e30e38eULL, 0x38e38e38e38638e3ULL, },
+        { 0xe38e38e38e38a38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c61c71c71cULL, },
+        { 0x1c71c31c71c71871ULL, 0xc71c71c71c71c31cULL, },
+        { 0x1c51c71c71c71c71ULL, 0xc71c71c71c51c71cULL, },
+        { 0x1c71c71c71c70c71ULL, 0xc71c61c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71471c71c71c71cULL, },
+        { 0x1c71c71471c71c71ULL, 0xc61c71c71c71c714ULL, },
+        { 0x0c71c71c71c51c71ULL, 0xc71c71470c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x0b670b5efe7ba00cULL, },    /*  64  */
+        { 0x886ae6c428625440ULL, 0x4b670b5eee7bb00cULL, },
+        { 0x886ae2cc28625540ULL, 0x4b670b5efe6bb00cULL, },
+        { 0x886ac6cc28621540ULL, 0x4a670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f42fcULL, },
+        { 0xfbbe00634d93c608ULL, 0x12f7bb1a053f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a152f52fcULL, },
+        { 0xfbbe00634d938708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaea2b9cf8a80ULL, 0x23d8c6ffab2b2514ULL, },
+        { 0xac5aaaaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5a8eaab9cf8b80ULL, 0x26d8c6ffab2b2514ULL, },
+        { 0x704f064d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f16455e31e24eULL, 0x89f188d8a942e2a0ULL, },
+        { 0x704f124d5e31e24eULL, 0x0df188d8a942e2a0ULL, },
+        { 0x704f164d5e31a24eULL, 0x8cf188d8a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BCLR_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
new file mode 100644
index 0000000..1939d10
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BNEG.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BNEG.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },    /*   0  */
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },
+        { 0xfbfbfbfbfbfbfbfbULL, 0xfbfbfbfbfbfbfbfbULL, },
+        { 0xdfdfdfdfdfdfdfdfULL, 0xdfdfdfdfdfdfdfdfULL, },
+        { 0xefefefefefefefefULL, 0xefefefefefefefefULL, },
+        { 0xf7f7f7f7f7f7f7f7ULL, 0xf7f7f7f7f7f7f7f7ULL, },
+        { 0xf7bffef7bffef7bfULL, 0xfef7bffef7bffef7ULL, },
+        { 0xeffd7feffd7feffdULL, 0x7feffd7feffd7fefULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*   8  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x2020202020202020ULL, 0x2020202020202020ULL, },
+        { 0x1010101010101010ULL, 0x1010101010101010ULL, },
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },
+        { 0x0840010840010840ULL, 0x0108400108400108ULL, },
+        { 0x1002801002801002ULL, 0x8010028010028010ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },    /*  16  */
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0xaeaeaeaeaeaeaeaeULL, 0xaeaeaeaeaeaeaeaeULL, },
+        { 0x8a8a8a8a8a8a8a8aULL, 0x8a8a8a8a8a8a8a8aULL, },
+        { 0xbabababababababaULL, 0xbabababababababaULL, },
+        { 0xa2a2a2a2a2a2a2a2ULL, 0xa2a2a2a2a2a2a2a2ULL, },
+        { 0xa2eaaba2eaaba2eaULL, 0xaba2eaaba2eaaba2ULL, },
+        { 0xbaa82abaa82abaa8ULL, 0x2abaa82abaa82abaULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },    /*  24  */
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },
+        { 0x5151515151515151ULL, 0x5151515151515151ULL, },
+        { 0x7575757575757575ULL, 0x7575757575757575ULL, },
+        { 0x4545454545454545ULL, 0x4545454545454545ULL, },
+        { 0x5d5d5d5d5d5d5d5dULL, 0x5d5d5d5d5d5d5d5dULL, },
+        { 0x5d15545d15545d15ULL, 0x545d15545d15545dULL, },
+        { 0x4557d54557d54557ULL, 0xd54557d54557d545ULL, },
+        { 0x4c4c4c4c4c4c4c4cULL, 0x4c4c4c4c4c4c4c4cULL, },    /*  32  */
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },
+        { 0xc8c8c8c8c8c8c8c8ULL, 0xc8c8c8c8c8c8c8c8ULL, },
+        { 0xececececececececULL, 0xececececececececULL, },
+        { 0xdcdcdcdcdcdcdcdcULL, 0xdcdcdcdcdcdcdcdcULL, },
+        { 0xc4c4c4c4c4c4c4c4ULL, 0xc4c4c4c4c4c4c4c4ULL, },
+        { 0xc48ccdc48ccdc48cULL, 0xcdc48ccdc48ccdc4ULL, },
+        { 0xdcce4cdcce4cdcceULL, 0x4cdcce4cdcce4cdcULL, },
+        { 0xb3b3b3b3b3b3b3b3ULL, 0xb3b3b3b3b3b3b3b3ULL, },    /*  40  */
+        { 0x3232323232323232ULL, 0x3232323232323232ULL, },
+        { 0x3737373737373737ULL, 0x3737373737373737ULL, },
+        { 0x1313131313131313ULL, 0x1313131313131313ULL, },
+        { 0x2323232323232323ULL, 0x2323232323232323ULL, },
+        { 0x3b3b3b3b3b3b3b3bULL, 0x3b3b3b3b3b3b3b3bULL, },
+        { 0x3b73323b73323b73ULL, 0x323b73323b73323bULL, },
+        { 0x2331b32331b32331ULL, 0xb32331b32331b323ULL, },
+        { 0x630eb8630eb8630eULL, 0xb8630eb8630eb863ULL, },    /*  48  */
+        { 0xe28f39e28f39e28fULL, 0x39e28f39e28f39e2ULL, },
+        { 0xe78a3ce78a3ce78aULL, 0x3ce78a3ce78a3ce7ULL, },
+        { 0xc3ae18c3ae18c3aeULL, 0x18c3ae18c3ae18c3ULL, },
+        { 0xf39e28f39e28f39eULL, 0x28f39e28f39e28f3ULL, },
+        { 0xeb8630eb8630eb86ULL, 0x30eb8630eb8630ebULL, },
+        { 0xebce39ebce39ebceULL, 0x39ebce39ebce39ebULL, },
+        { 0xf38cb8f38cb8f38cULL, 0xb8f38cb8f38cb8f3ULL, },
+        { 0x9cf1479cf1479cf1ULL, 0x479cf1479cf1479cULL, },    /*  56  */
+        { 0x1d70c61d70c61d70ULL, 0xc61d70c61d70c61dULL, },
+        { 0x1875c31875c31875ULL, 0xc31875c31875c318ULL, },
+        { 0x3c51e73c51e73c51ULL, 0xe73c51e73c51e73cULL, },
+        { 0x0c61d70c61d70c61ULL, 0xd70c61d70c61d70cULL, },
+        { 0x1479cf1479cf1479ULL, 0xcf1479cf1479cf14ULL, },
+        { 0x1431c61431c61431ULL, 0xc61431c61431c614ULL, },
+        { 0x0c73470c73470c73ULL, 0x470c73470c73470cULL, },
+        { 0x896ea6dc29667541ULL, 0x43e7031ebe73b11cULL, },    /*  64  */
+        { 0x802ae7c4086ad541ULL, 0x4fe7035adefbb41cULL, },
+        { 0x986ea6c82ae25d41ULL, 0xcb664bdef673901cULL, },
+        { 0x89eaa6ec68605100ULL, 0x6b650a5ffc7fb40dULL, },
+        { 0xfaba40734c97e709ULL, 0x1a77b35a553753ecULL, },
+        { 0xf3fe016b6d9b4709ULL, 0x1677b31e35bf56ecULL, },
+        { 0xebba40674f13cf09ULL, 0x92f6fb9a1d3772ecULL, },
+        { 0xfa3e40430d91c348ULL, 0x32f5ba1b173b56fdULL, },
+        { 0xad5eeebab8cbab81ULL, 0x2f58cebfeb232404ULL, },    /*  72  */
+        { 0xa41aafa299c70b81ULL, 0x2358cefb8bab2104ULL, },
+        { 0xbc5eeeaebb4f8381ULL, 0xa7d9867fa3230504ULL, },
+        { 0xaddaee8af9cd8fc0ULL, 0x07dac7fea92f2115ULL, },
+        { 0x714b565d5f35c24fULL, 0x85718098e94ae3b0ULL, },
+        { 0x780f17457e39624fULL, 0x897180dc89c2e6b0ULL, },
+        { 0x604b56495cb1ea4fULL, 0x0df0c858a14ac2b0ULL, },
+        { 0x71cf566d1e33e60eULL, 0xadf389d9ab46e6a1ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
new file mode 100644
index 0000000..8462bb3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BNEG.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BNEG.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },    /*   0  */
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },
+        { 0xfffffbffffffffffULL, 0xfffffbffffffffffULL, },
+        { 0xffffffffffdfffffULL, 0xffffffffffdfffffULL, },
+        { 0xffffffffffffefffULL, 0xffffffffffffefffULL, },
+        { 0xfff7ffffffffffffULL, 0xfff7ffffffffffffULL, },
+        { 0xffffffffffffbfffULL, 0xfffffff7ffffffffULL, },
+        { 0xfffdffffffffffffULL, 0xffffffffefffffffULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*   8  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000040000000000ULL, 0x0000040000000000ULL, },
+        { 0x0000000000200000ULL, 0x0000000000200000ULL, },
+        { 0x0000000000001000ULL, 0x0000000000001000ULL, },
+        { 0x0008000000000000ULL, 0x0008000000000000ULL, },
+        { 0x0000000000004000ULL, 0x0000000800000000ULL, },
+        { 0x0002000000000000ULL, 0x0000000010000000ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0xaaaaaeaaaaaaaaaaULL, 0xaaaaaeaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaa8aaaaaULL, 0xaaaaaaaaaa8aaaaaULL, },
+        { 0xaaaaaaaaaaaabaaaULL, 0xaaaaaaaaaaaabaaaULL, },
+        { 0xaaa2aaaaaaaaaaaaULL, 0xaaa2aaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaeaaaULL, 0xaaaaaaa2aaaaaaaaULL, },
+        { 0xaaa8aaaaaaaaaaaaULL, 0xaaaaaaaabaaaaaaaULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },    /*  24  */
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },
+        { 0x5555515555555555ULL, 0x5555515555555555ULL, },
+        { 0x5555555555755555ULL, 0x5555555555755555ULL, },
+        { 0x5555555555554555ULL, 0x5555555555554555ULL, },
+        { 0x555d555555555555ULL, 0x555d555555555555ULL, },
+        { 0x5555555555551555ULL, 0x5555555d55555555ULL, },
+        { 0x5557555555555555ULL, 0x5555555545555555ULL, },
+        { 0x4cccccccccccccccULL, 0x4cccccccccccccccULL, },    /*  32  */
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },
+        { 0xccccc8ccccccccccULL, 0xccccc8ccccccccccULL, },
+        { 0xccccccccccecccccULL, 0xccccccccccecccccULL, },
+        { 0xccccccccccccdcccULL, 0xccccccccccccdcccULL, },
+        { 0xccc4ccccccccccccULL, 0xccc4ccccccccccccULL, },
+        { 0xcccccccccccc8cccULL, 0xccccccc4ccccccccULL, },
+        { 0xccceccccccccccccULL, 0xccccccccdcccccccULL, },
+        { 0xb333333333333333ULL, 0xb333333333333333ULL, },    /*  40  */
+        { 0x3333333333333332ULL, 0x3333333333333332ULL, },
+        { 0x3333373333333333ULL, 0x3333373333333333ULL, },
+        { 0x3333333333133333ULL, 0x3333333333133333ULL, },
+        { 0x3333333333332333ULL, 0x3333333333332333ULL, },
+        { 0x333b333333333333ULL, 0x333b333333333333ULL, },
+        { 0x3333333333337333ULL, 0x3333333b33333333ULL, },
+        { 0x3331333333333333ULL, 0x3333333323333333ULL, },
+        { 0x638e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e2ULL, },
+        { 0xe38e3ce38e38e38eULL, 0x38e38a38e38e38e3ULL, },
+        { 0xe38e38e38e18e38eULL, 0x38e38e38e3ae38e3ULL, },
+        { 0xe38e38e38e38f38eULL, 0x38e38e38e38e28e3ULL, },
+        { 0xe38638e38e38e38eULL, 0x38eb8e38e38e38e3ULL, },
+        { 0xe38e38e38e38a38eULL, 0x38e38e30e38e38e3ULL, },
+        { 0xe38c38e38e38e38eULL, 0x38e38e38f38e38e3ULL, },
+        { 0x9c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71c71dULL, },
+        { 0x1c71c31c71c71c71ULL, 0xc71c75c71c71c71cULL, },
+        { 0x1c71c71c71e71c71ULL, 0xc71c71c71c51c71cULL, },
+        { 0x1c71c71c71c70c71ULL, 0xc71c71c71c71d71cULL, },
+        { 0x1c79c71c71c71c71ULL, 0xc71471c71c71c71cULL, },
+        { 0x1c71c71c71c75c71ULL, 0xc71c71cf1c71c71cULL, },
+        { 0x1c73c71c71c71c71ULL, 0xc71c71c70c71c71cULL, },
+        { 0x886ae6cc28625541ULL, 0x4b670b5efe7ba00cULL, },    /*  64  */
+        { 0x886ae6cc28625440ULL, 0x5b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625541ULL, 0x4b670b5efe6bb00cULL, },
+        { 0x886ae6cc28621540ULL, 0x4b670b5ffe7bb00cULL, },
+        { 0xfbbe00634d93c709ULL, 0x12f7bb1a153f42fcULL, },
+        { 0xfbbe00634d93c608ULL, 0x02f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c709ULL, 0x12f7bb1a152f52fcULL, },
+        { 0xfbbe00634d938708ULL, 0x12f7bb1b153f52fcULL, },
+        { 0xac5aaeaab9cf8b81ULL, 0x27d8c6ffab2b3514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8a80ULL, 0x37d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b81ULL, 0x27d8c6ffab3b2514ULL, },
+        { 0xac5aaeaab9cfcb80ULL, 0x27d8c6feab2b2514ULL, },
+        { 0x704f164d5e31e24fULL, 0x8df188d8a942f2a0ULL, },
+        { 0x704f164d5e31e34eULL, 0x9df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24fULL, 0x8df188d8a952e2a0ULL, },
+        { 0x704f164d5e31a24eULL, 0x8df188d9a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
new file mode 100644
index 0000000..172d4c0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BNEG.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BNEG.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },    /*   0  */
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xfbfffbfffbfffbffULL, 0xfbfffbfffbfffbffULL, },
+        { 0xffdfffdfffdfffdfULL, 0xffdfffdfffdfffdfULL, },
+        { 0xefffefffefffefffULL, 0xefffefffefffefffULL, },
+        { 0xfff7fff7fff7fff7ULL, 0xfff7fff7fff7fff7ULL, },
+        { 0xbffffff7feffbfffULL, 0xfff7feffbffffff7ULL, },
+        { 0xfffdefffff7ffffdULL, 0xefffff7ffffdefffULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*   8  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0400040004000400ULL, 0x0400040004000400ULL, },
+        { 0x0020002000200020ULL, 0x0020002000200020ULL, },
+        { 0x1000100010001000ULL, 0x1000100010001000ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x4000000801004000ULL, 0x0008010040000008ULL, },
+        { 0x0002100000800002ULL, 0x1000008000021000ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },    /*  16  */
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0xaeaaaeaaaeaaaeaaULL, 0xaeaaaeaaaeaaaeaaULL, },
+        { 0xaa8aaa8aaa8aaa8aULL, 0xaa8aaa8aaa8aaa8aULL, },
+        { 0xbaaabaaabaaabaaaULL, 0xbaaabaaabaaabaaaULL, },
+        { 0xaaa2aaa2aaa2aaa2ULL, 0xaaa2aaa2aaa2aaa2ULL, },
+        { 0xeaaaaaa2abaaeaaaULL, 0xaaa2abaaeaaaaaa2ULL, },
+        { 0xaaa8baaaaa2aaaa8ULL, 0xbaaaaa2aaaa8baaaULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },    /*  24  */
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },
+        { 0x5155515551555155ULL, 0x5155515551555155ULL, },
+        { 0x5575557555755575ULL, 0x5575557555755575ULL, },
+        { 0x4555455545554555ULL, 0x4555455545554555ULL, },
+        { 0x555d555d555d555dULL, 0x555d555d555d555dULL, },
+        { 0x1555555d54551555ULL, 0x555d54551555555dULL, },
+        { 0x5557455555d55557ULL, 0x455555d555574555ULL, },
+        { 0x4ccc4ccc4ccc4cccULL, 0x4ccc4ccc4ccc4cccULL, },    /*  32  */
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },
+        { 0xc8ccc8ccc8ccc8ccULL, 0xc8ccc8ccc8ccc8ccULL, },
+        { 0xccecccecccecccecULL, 0xccecccecccecccecULL, },
+        { 0xdcccdcccdcccdcccULL, 0xdcccdcccdcccdcccULL, },
+        { 0xccc4ccc4ccc4ccc4ULL, 0xccc4ccc4ccc4ccc4ULL, },
+        { 0x8cccccc4cdcc8cccULL, 0xccc4cdcc8cccccc4ULL, },
+        { 0xcccedccccc4cccceULL, 0xdccccc4ccccedcccULL, },
+        { 0xb333b333b333b333ULL, 0xb333b333b333b333ULL, },    /*  40  */
+        { 0x3332333233323332ULL, 0x3332333233323332ULL, },
+        { 0x3733373337333733ULL, 0x3733373337333733ULL, },
+        { 0x3313331333133313ULL, 0x3313331333133313ULL, },
+        { 0x2333233323332333ULL, 0x2333233323332333ULL, },
+        { 0x333b333b333b333bULL, 0x333b333b333b333bULL, },
+        { 0x7333333b32337333ULL, 0x333b32337333333bULL, },
+        { 0x3331233333b33331ULL, 0x233333b333312333ULL, },
+        { 0x638eb8e30e38638eULL, 0xb8e30e38638eb8e3ULL, },    /*  48  */
+        { 0xe38f38e28e39e38fULL, 0x38e28e39e38f38e2ULL, },
+        { 0xe78e3ce38a38e78eULL, 0x3ce38a38e78e3ce3ULL, },
+        { 0xe3ae38c38e18e3aeULL, 0x38c38e18e3ae38c3ULL, },
+        { 0xf38e28e39e38f38eULL, 0x28e39e38f38e28e3ULL, },
+        { 0xe38638eb8e30e386ULL, 0x38eb8e30e38638ebULL, },
+        { 0xa38e38eb8f38a38eULL, 0x38eb8f38a38e38ebULL, },
+        { 0xe38c28e38eb8e38cULL, 0x28e38eb8e38c28e3ULL, },
+        { 0x9c71471cf1c79c71ULL, 0x471cf1c79c71471cULL, },    /*  56  */
+        { 0x1c70c71d71c61c70ULL, 0xc71d71c61c70c71dULL, },
+        { 0x1871c31c75c71871ULL, 0xc31c75c71871c31cULL, },
+        { 0x1c51c73c71e71c51ULL, 0xc73c71e71c51c73cULL, },
+        { 0x0c71d71c61c70c71ULL, 0xd71c61c70c71d71cULL, },
+        { 0x1c79c71471cf1c79ULL, 0xc71471cf1c79c714ULL, },
+        { 0x5c71c71470c75c71ULL, 0xc71470c75c71c714ULL, },
+        { 0x1c73d71c71471c73ULL, 0xd71c71471c73d71cULL, },
+        { 0x8c6af6cc28665541ULL, 0x4be74b5ef67ba00cULL, },    /*  64  */
+        { 0xc86ae6c4286a5440ULL, 0x4be70f5e7e7ba00cULL, },
+        { 0x8c6ae2cca8625541ULL, 0x4a678b5ef67bb01cULL, },
+        { 0x086ac6cc28601540ULL, 0x4b650a5efe7fb00dULL, },
+        { 0xffbe10634d97c709ULL, 0x1277fb1a1d3f42fcULL, },
+        { 0xbbbe006b4d9bc608ULL, 0x1277bf1a953f42fcULL, },
+        { 0xffbe0463cd93c709ULL, 0x13f73b1a1d3f52ecULL, },
+        { 0x7bbe20634d918708ULL, 0x12f5ba1a153b52fdULL, },
+        { 0xa85abeaab9cb8b81ULL, 0x275886ffa32b3514ULL, },    /*  72  */
+        { 0xec5aaea2b9c78a80ULL, 0x2758c2ff2b2b3514ULL, },
+        { 0xa85aaaaa39cf8b81ULL, 0x26d846ffa32b2504ULL, },
+        { 0x2c5a8eaab9cdcb80ULL, 0x27dac7ffab2f2515ULL, },
+        { 0x744f064d5e35e24fULL, 0x8d71c8d8a142f2a0ULL, },
+        { 0x304f16455e39e34eULL, 0x8d718cd82942f2a0ULL, },
+        { 0x744f124dde31e24fULL, 0x8cf108d8a142e2b0ULL, },
+        { 0xf04f364d5e33a24eULL, 0x8df389d8a946e2a1ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
new file mode 100644
index 0000000..23bc033
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BNEG.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BNEG.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },    /*   0  */
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xfffffbfffffffbffULL, 0xfffffbfffffffbffULL, },
+        { 0xffdfffffffdfffffULL, 0xffdfffffffdfffffULL, },
+        { 0xffffefffffffefffULL, 0xffffefffffffefffULL, },
+        { 0xfff7fffffff7ffffULL, 0xfff7fffffff7ffffULL, },
+        { 0xfffffff7ffffbfffULL, 0xfefffffffffffff7ULL, },
+        { 0xeffffffffffdffffULL, 0xffffff7fefffffffULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*   8  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000040000000400ULL, 0x0000040000000400ULL, },
+        { 0x0020000000200000ULL, 0x0020000000200000ULL, },
+        { 0x0000100000001000ULL, 0x0000100000001000ULL, },
+        { 0x0008000000080000ULL, 0x0008000000080000ULL, },
+        { 0x0000000800004000ULL, 0x0100000000000008ULL, },
+        { 0x1000000000020000ULL, 0x0000008010000000ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0xaaaaaeaaaaaaaeaaULL, 0xaaaaaeaaaaaaaeaaULL, },
+        { 0xaa8aaaaaaa8aaaaaULL, 0xaa8aaaaaaa8aaaaaULL, },
+        { 0xaaaabaaaaaaabaaaULL, 0xaaaabaaaaaaabaaaULL, },
+        { 0xaaa2aaaaaaa2aaaaULL, 0xaaa2aaaaaaa2aaaaULL, },
+        { 0xaaaaaaa2aaaaeaaaULL, 0xabaaaaaaaaaaaaa2ULL, },
+        { 0xbaaaaaaaaaa8aaaaULL, 0xaaaaaa2abaaaaaaaULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },    /*  24  */
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },
+        { 0x5555515555555155ULL, 0x5555515555555155ULL, },
+        { 0x5575555555755555ULL, 0x5575555555755555ULL, },
+        { 0x5555455555554555ULL, 0x5555455555554555ULL, },
+        { 0x555d5555555d5555ULL, 0x555d5555555d5555ULL, },
+        { 0x5555555d55551555ULL, 0x545555555555555dULL, },
+        { 0x4555555555575555ULL, 0x555555d545555555ULL, },
+        { 0x4ccccccc4cccccccULL, 0x4ccccccc4cccccccULL, },    /*  32  */
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },
+        { 0xccccc8ccccccc8ccULL, 0xccccc8ccccccc8ccULL, },
+        { 0xccecccccccecccccULL, 0xccecccccccecccccULL, },
+        { 0xccccdcccccccdcccULL, 0xccccdcccccccdcccULL, },
+        { 0xccc4ccccccc4ccccULL, 0xccc4ccccccc4ccccULL, },
+        { 0xccccccc4cccc8cccULL, 0xcdccccccccccccc4ULL, },
+        { 0xdcccccccccceccccULL, 0xcccccc4cdcccccccULL, },
+        { 0xb3333333b3333333ULL, 0xb3333333b3333333ULL, },    /*  40  */
+        { 0x3333333233333332ULL, 0x3333333233333332ULL, },
+        { 0x3333373333333733ULL, 0x3333373333333733ULL, },
+        { 0x3313333333133333ULL, 0x3313333333133333ULL, },
+        { 0x3333233333332333ULL, 0x3333233333332333ULL, },
+        { 0x333b3333333b3333ULL, 0x333b3333333b3333ULL, },
+        { 0x3333333b33337333ULL, 0x323333333333333bULL, },
+        { 0x2333333333313333ULL, 0x333333b323333333ULL, },
+        { 0x638e38e30e38e38eULL, 0xb8e38e38638e38e3ULL, },    /*  48  */
+        { 0xe38e38e28e38e38fULL, 0x38e38e39e38e38e2ULL, },
+        { 0xe38e3ce38e38e78eULL, 0x38e38a38e38e3ce3ULL, },
+        { 0xe3ae38e38e18e38eULL, 0x38c38e38e3ae38e3ULL, },
+        { 0xe38e28e38e38f38eULL, 0x38e39e38e38e28e3ULL, },
+        { 0xe38638e38e30e38eULL, 0x38eb8e38e38638e3ULL, },
+        { 0xe38e38eb8e38a38eULL, 0x39e38e38e38e38ebULL, },
+        { 0xf38e38e38e3ae38eULL, 0x38e38eb8f38e38e3ULL, },
+        { 0x9c71c71cf1c71c71ULL, 0x471c71c79c71c71cULL, },    /*  56  */
+        { 0x1c71c71d71c71c70ULL, 0xc71c71c61c71c71dULL, },
+        { 0x1c71c31c71c71871ULL, 0xc71c75c71c71c31cULL, },
+        { 0x1c51c71c71e71c71ULL, 0xc73c71c71c51c71cULL, },
+        { 0x1c71d71c71c70c71ULL, 0xc71c61c71c71d71cULL, },
+        { 0x1c79c71c71cf1c71ULL, 0xc71471c71c79c71cULL, },
+        { 0x1c71c71471c75c71ULL, 0xc61c71c71c71c714ULL, },
+        { 0x0c71c71c71c51c71ULL, 0xc71c71470c71c71cULL, },
+        { 0x886af6cc28625541ULL, 0x0b670b5efe7ba00cULL, },    /*  64  */
+        { 0x886ae6c428625440ULL, 0x4f670b5eee7bb00cULL, },
+        { 0x886ae2cc28625541ULL, 0xcb670b5efe6bb00cULL, },
+        { 0x886ac6cc28621540ULL, 0x4a670b5efe7bb00dULL, },
+        { 0xfbbe10634d93c709ULL, 0x52f7bb1a153f42fcULL, },
+        { 0xfbbe006b4d93c608ULL, 0x16f7bb1a053f52fcULL, },
+        { 0xfbbe04634d93c709ULL, 0x92f7bb1a152f52fcULL, },
+        { 0xfbbe20634d938708ULL, 0x13f7bb1a153f52fdULL, },
+        { 0xac5abeaab9cf8b81ULL, 0x67d8c6ffab2b3514ULL, },    /*  72  */
+        { 0xac5aaea2b9cf8a80ULL, 0x23d8c6ffbb2b2514ULL, },
+        { 0xac5aaaaab9cf8b81ULL, 0xa7d8c6ffab3b2514ULL, },
+        { 0xac5a8eaab9cfcb80ULL, 0x26d8c6ffab2b2515ULL, },
+        { 0x704f064d5e31e24fULL, 0xcdf188d8a942f2a0ULL, },
+        { 0x704f16455e31e34eULL, 0x89f188d8b942e2a0ULL, },
+        { 0x704f124d5e31e24fULL, 0x0df188d8a952e2a0ULL, },
+        { 0x704f364d5e31a24eULL, 0x8cf188d8a942e2a1ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BNEG_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
new file mode 100644
index 0000000..f48adbd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BSET.B
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BSET.B";
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
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*   8  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },
+        { 0x2020202020202020ULL, 0x2020202020202020ULL, },
+        { 0x1010101010101010ULL, 0x1010101010101010ULL, },
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },
+        { 0x0840010840010840ULL, 0x0108400108400108ULL, },
+        { 0x1002801002801002ULL, 0x8010028010028010ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0xaeaeaeaeaeaeaeaeULL, 0xaeaeaeaeaeaeaeaeULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xbabababababababaULL, 0xbabababababababaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaeaabaaeaabaaeaULL, 0xabaaeaabaaeaabaaULL, },
+        { 0xbaaaaabaaaaabaaaULL, 0xaabaaaaabaaaaabaULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7575757575757575ULL, 0x7575757575757575ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5d5d5d5d5d5d5d5dULL, 0x5d5d5d5d5d5d5d5dULL, },
+        { 0x5d55555d55555d55ULL, 0x555d55555d55555dULL, },
+        { 0x5557d55557d55557ULL, 0xd55557d55557d555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xececececececececULL, 0xececececececececULL, },
+        { 0xdcdcdcdcdcdcdcdcULL, 0xdcdcdcdcdcdcdcdcULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccdcccccdccccULL, 0xcdcccccdcccccdccULL, },
+        { 0xdcceccdcceccdcceULL, 0xccdcceccdcceccdcULL, },
+        { 0xb3b3b3b3b3b3b3b3ULL, 0xb3b3b3b3b3b3b3b3ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3737373737373737ULL, 0x3737373737373737ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3b3b3b3b3b3b3b3bULL, 0x3b3b3b3b3b3b3b3bULL, },
+        { 0x3b73333b73333b73ULL, 0x333b73333b73333bULL, },
+        { 0x3333b33333b33333ULL, 0xb33333b33333b333ULL, },
+        { 0xe38eb8e38eb8e38eULL, 0xb8e38eb8e38eb8e3ULL, },    /*  48  */
+        { 0xe38f39e38f39e38fULL, 0x39e38f39e38f39e3ULL, },
+        { 0xe78e3ce78e3ce78eULL, 0x3ce78e3ce78e3ce7ULL, },
+        { 0xe3ae38e3ae38e3aeULL, 0x38e3ae38e3ae38e3ULL, },
+        { 0xf39e38f39e38f39eULL, 0x38f39e38f39e38f3ULL, },
+        { 0xeb8e38eb8e38eb8eULL, 0x38eb8e38eb8e38ebULL, },
+        { 0xebce39ebce39ebceULL, 0x39ebce39ebce39ebULL, },
+        { 0xf38eb8f38eb8f38eULL, 0xb8f38eb8f38eb8f3ULL, },
+        { 0x9cf1c79cf1c79cf1ULL, 0xc79cf1c79cf1c79cULL, },    /*  56  */
+        { 0x1d71c71d71c71d71ULL, 0xc71d71c71d71c71dULL, },
+        { 0x1c75c71c75c71c75ULL, 0xc71c75c71c75c71cULL, },
+        { 0x3c71e73c71e73c71ULL, 0xe73c71e73c71e73cULL, },
+        { 0x1c71d71c71d71c71ULL, 0xd71c71d71c71d71cULL, },
+        { 0x1c79cf1c79cf1c79ULL, 0xcf1c79cf1c79cf1cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c73c71c73c71c73ULL, 0xc71c73c71c73c71cULL, },
+        { 0x896ee6dc29667541ULL, 0x4be70b5efe7bb11cULL, },    /*  64  */
+        { 0x886ae7cc286ad541ULL, 0x4fe70b5efefbb41cULL, },
+        { 0x986ee6cc2ae25d41ULL, 0xcb674bdefe7bb01cULL, },
+        { 0x89eae6ec68625540ULL, 0x6b670b5ffe7fb40dULL, },
+        { 0xfbbe40734d97e709ULL, 0x1af7bb5a553f53fcULL, },
+        { 0xfbfe016b6d9bc709ULL, 0x16f7bb1e35bf56fcULL, },
+        { 0xfbbe40674f93cf09ULL, 0x92f7fb9a1d3f72fcULL, },
+        { 0xfbbe40634d93c748ULL, 0x32f7bb1b173f56fdULL, },
+        { 0xad5eeebab9cfab81ULL, 0x2fd8ceffeb2b2514ULL, },    /*  72  */
+        { 0xac5aafaab9cf8b81ULL, 0x27d8ceffabab2514ULL, },
+        { 0xbc5eeeaebbcf8b81ULL, 0xa7d9c6ffab2b2514ULL, },
+        { 0xaddaeeaaf9cf8fc0ULL, 0x27dac7ffab2f2515ULL, },
+        { 0x714f565d5f35e24fULL, 0x8df188d8e94ae3b0ULL, },
+        { 0x784f174d7e39e24fULL, 0x8df188dca9c2e6b0ULL, },
+        { 0x704f564d5eb1ea4fULL, 0x8df1c8d8a94ae2b0ULL, },
+        { 0x71cf566d5e33e64eULL, 0xadf389d9ab46e6a1ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
new file mode 100644
index 0000000..787016a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BSET.D
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BSET.D";
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
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*   8  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x0000040000000000ULL, 0x0000040000000000ULL, },
+        { 0x0000000000200000ULL, 0x0000000000200000ULL, },
+        { 0x0000000000001000ULL, 0x0000000000001000ULL, },
+        { 0x0008000000000000ULL, 0x0008000000000000ULL, },
+        { 0x0000000000004000ULL, 0x0000000800000000ULL, },
+        { 0x0002000000000000ULL, 0x0000000010000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0xaaaaaeaaaaaaaaaaULL, 0xaaaaaeaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaabaaaULL, 0xaaaaaaaaaaaabaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaeaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaabaaaaaaaULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555755555ULL, 0x5555555555755555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x555d555555555555ULL, 0x555d555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555d55555555ULL, },
+        { 0x5557555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccecccccULL, 0xccccccccccecccccULL, },
+        { 0xccccccccccccdcccULL, 0xccccccccccccdcccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccceccccccccccccULL, 0xccccccccdcccccccULL, },
+        { 0xb333333333333333ULL, 0xb333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333373333333333ULL, 0x3333373333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333b333333333333ULL, 0x333b333333333333ULL, },
+        { 0x3333333333337333ULL, 0x3333333b33333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e3ce38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e3ae38e3ULL, },
+        { 0xe38e38e38e38f38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38eb8e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38f38e38e3ULL, },
+        { 0x9c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71dULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c75c71c71c71cULL, },
+        { 0x1c71c71c71e71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71d71cULL, },
+        { 0x1c79c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c75c71ULL, 0xc71c71cf1c71c71cULL, },
+        { 0x1c73c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625541ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x5b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625541ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5ffe7bb00cULL, },
+        { 0xfbbe00634d93c709ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c709ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1b153f52fcULL, },
+        { 0xac5aaeaab9cf8b81ULL, 0x27d8c6ffab2b3514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x37d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b81ULL, 0x27d8c6ffab3b2514ULL, },
+        { 0xac5aaeaab9cfcb80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24fULL, 0x8df188d8a942f2a0ULL, },
+        { 0x704f164d5e31e34eULL, 0x9df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24fULL, 0x8df188d8a952e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d9a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
new file mode 100644
index 0000000..e1ff972
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BSET.H
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BSET.H";
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
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*   8  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0400040004000400ULL, 0x0400040004000400ULL, },
+        { 0x0020002000200020ULL, 0x0020002000200020ULL, },
+        { 0x1000100010001000ULL, 0x1000100010001000ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x4000000801004000ULL, 0x0008010040000008ULL, },
+        { 0x0002100000800002ULL, 0x1000008000021000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0xaeaaaeaaaeaaaeaaULL, 0xaeaaaeaaaeaaaeaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xbaaabaaabaaabaaaULL, 0xbaaabaaabaaabaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xeaaaaaaaabaaeaaaULL, 0xaaaaabaaeaaaaaaaULL, },
+        { 0xaaaabaaaaaaaaaaaULL, 0xbaaaaaaaaaaabaaaULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5575557555755575ULL, 0x5575557555755575ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x555d555d555d555dULL, 0x555d555d555d555dULL, },
+        { 0x5555555d55555555ULL, 0x555d55555555555dULL, },
+        { 0x5557555555d55557ULL, 0x555555d555575555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccecccecccecccecULL, 0xccecccecccecccecULL, },
+        { 0xdcccdcccdcccdcccULL, 0xdcccdcccdcccdcccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xcccccccccdccccccULL, 0xcccccdccccccccccULL, },
+        { 0xcccedcccccccccceULL, 0xdccccccccccedcccULL, },
+        { 0xb333b333b333b333ULL, 0xb333b333b333b333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3733373337333733ULL, 0x3733373337333733ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333b333b333b333bULL, 0x333b333b333b333bULL, },
+        { 0x7333333b33337333ULL, 0x333b33337333333bULL, },
+        { 0x3333333333b33333ULL, 0x333333b333333333ULL, },
+        { 0xe38eb8e38e38e38eULL, 0xb8e38e38e38eb8e3ULL, },    /*  48  */
+        { 0xe38f38e38e39e38fULL, 0x38e38e39e38f38e3ULL, },
+        { 0xe78e3ce38e38e78eULL, 0x3ce38e38e78e3ce3ULL, },
+        { 0xe3ae38e38e38e3aeULL, 0x38e38e38e3ae38e3ULL, },
+        { 0xf38e38e39e38f38eULL, 0x38e39e38f38e38e3ULL, },
+        { 0xe38e38eb8e38e38eULL, 0x38eb8e38e38e38ebULL, },
+        { 0xe38e38eb8f38e38eULL, 0x38eb8f38e38e38ebULL, },
+        { 0xe38e38e38eb8e38eULL, 0x38e38eb8e38e38e3ULL, },
+        { 0x9c71c71cf1c79c71ULL, 0xc71cf1c79c71c71cULL, },    /*  56  */
+        { 0x1c71c71d71c71c71ULL, 0xc71d71c71c71c71dULL, },
+        { 0x1c71c71c75c71c71ULL, 0xc71c75c71c71c71cULL, },
+        { 0x1c71c73c71e71c71ULL, 0xc73c71e71c71c73cULL, },
+        { 0x1c71d71c71c71c71ULL, 0xd71c71c71c71d71cULL, },
+        { 0x1c79c71c71cf1c79ULL, 0xc71c71cf1c79c71cULL, },
+        { 0x5c71c71c71c75c71ULL, 0xc71c71c75c71c71cULL, },
+        { 0x1c73d71c71c71c73ULL, 0xd71c71c71c73d71cULL, },
+        { 0x8c6af6cc28665541ULL, 0x4be74b5efe7bb00cULL, },    /*  64  */
+        { 0xc86ae6cc286a5540ULL, 0x4be70f5efe7bb00cULL, },
+        { 0x8c6ae6cca8625541ULL, 0x4b678b5efe7bb01cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7fb00dULL, },
+        { 0xffbe10634d97c709ULL, 0x12f7fb1a1d3f52fcULL, },
+        { 0xfbbe006b4d9bc708ULL, 0x12f7bf1a953f52fcULL, },
+        { 0xffbe0463cd93c709ULL, 0x13f7bb1a1d3f52fcULL, },
+        { 0xfbbe20634d93c708ULL, 0x12f7bb1a153f52fdULL, },
+        { 0xac5abeaab9cf8b81ULL, 0x27d8c6ffab2b3514ULL, },    /*  72  */
+        { 0xec5aaeaab9cf8b80ULL, 0x27d8c6ffab2b3514ULL, },
+        { 0xac5aaeaab9cf8b81ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cfcb80ULL, 0x27dac7ffab2f2515ULL, },
+        { 0x744f164d5e35e24fULL, 0x8df1c8d8a942f2a0ULL, },
+        { 0x704f164d5e39e34eULL, 0x8df18cd8a942f2a0ULL, },
+        { 0x744f164dde31e24fULL, 0x8df188d8a942e2b0ULL, },
+        { 0xf04f364d5e33e24eULL, 0x8df389d8a946e2a1ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
new file mode 100644
index 0000000..51945b2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction BSET.W
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
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name = "BSET.W";
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
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*   8  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000040000000400ULL, 0x0000040000000400ULL, },
+        { 0x0020000000200000ULL, 0x0020000000200000ULL, },
+        { 0x0000100000001000ULL, 0x0000100000001000ULL, },
+        { 0x0008000000080000ULL, 0x0008000000080000ULL, },
+        { 0x0000000800004000ULL, 0x0100000000000008ULL, },
+        { 0x1000000000020000ULL, 0x0000008010000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0xaaaaaeaaaaaaaeaaULL, 0xaaaaaeaaaaaaaeaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaabaaaaaaabaaaULL, 0xaaaabaaaaaaabaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaeaaaULL, 0xabaaaaaaaaaaaaaaULL, },
+        { 0xbaaaaaaaaaaaaaaaULL, 0xaaaaaaaabaaaaaaaULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5575555555755555ULL, 0x5575555555755555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x555d5555555d5555ULL, 0x555d5555555d5555ULL, },
+        { 0x5555555d55555555ULL, 0x555555555555555dULL, },
+        { 0x5555555555575555ULL, 0x555555d555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccecccccccecccccULL, 0xccecccccccecccccULL, },
+        { 0xccccdcccccccdcccULL, 0xccccdcccccccdcccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xcdccccccccccccccULL, },
+        { 0xdcccccccccceccccULL, 0xccccccccdcccccccULL, },
+        { 0xb3333333b3333333ULL, 0xb3333333b3333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333373333333733ULL, 0x3333373333333733ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333b3333333b3333ULL, 0x333b3333333b3333ULL, },
+        { 0x3333333b33337333ULL, 0x333333333333333bULL, },
+        { 0x3333333333333333ULL, 0x333333b333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38fULL, 0x38e38e39e38e38e3ULL, },
+        { 0xe38e3ce38e38e78eULL, 0x38e38e38e38e3ce3ULL, },
+        { 0xe3ae38e38e38e38eULL, 0x38e38e38e3ae38e3ULL, },
+        { 0xe38e38e38e38f38eULL, 0x38e39e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38eb8e38e38e38e3ULL, },
+        { 0xe38e38eb8e38e38eULL, 0x39e38e38e38e38ebULL, },
+        { 0xf38e38e38e3ae38eULL, 0x38e38eb8f38e38e3ULL, },
+        { 0x9c71c71cf1c71c71ULL, 0xc71c71c79c71c71cULL, },    /*  56  */
+        { 0x1c71c71d71c71c71ULL, 0xc71c71c71c71c71dULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c75c71c71c71cULL, },
+        { 0x1c71c71c71e71c71ULL, 0xc73c71c71c71c71cULL, },
+        { 0x1c71d71c71c71c71ULL, 0xc71c71c71c71d71cULL, },
+        { 0x1c79c71c71cf1c71ULL, 0xc71c71c71c79c71cULL, },
+        { 0x1c71c71c71c75c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886af6cc28625541ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x4f670b5efe7bb00cULL, },
+        { 0x886ae6cc28625541ULL, 0xcb670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00dULL, },
+        { 0xfbbe10634d93c709ULL, 0x52f7bb1a153f52fcULL, },
+        { 0xfbbe006b4d93c708ULL, 0x16f7bb1a153f52fcULL, },
+        { 0xfbbe04634d93c709ULL, 0x92f7bb1a153f52fcULL, },
+        { 0xfbbe20634d93c708ULL, 0x13f7bb1a153f52fdULL, },
+        { 0xac5abeaab9cf8b81ULL, 0x67d8c6ffab2b3514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffbb2b2514ULL, },
+        { 0xac5aaeaab9cf8b81ULL, 0xa7d8c6ffab3b2514ULL, },
+        { 0xac5aaeaab9cfcb80ULL, 0x27d8c6ffab2b2515ULL, },
+        { 0x704f164d5e31e24fULL, 0xcdf188d8a942f2a0ULL, },
+        { 0x704f164d5e31e34eULL, 0x8df188d8b942e2a0ULL, },
+        { 0x704f164d5e31e24fULL, 0x8df188d8a952e2a0ULL, },
+        { 0x704f364d5e31e24eULL, 0x8df188d8a942e2a1ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSET_W(b128_random[i], b128_random[j],
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
