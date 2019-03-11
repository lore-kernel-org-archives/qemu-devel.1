Received: from eggs.gnu.org ([209.51.188.92]:57684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LuY-0006a9-33
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LuG-0002K1-Cz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:28:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52617 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h3Lsh-0001QL-9P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:27:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Mar 2019 15:24:50 +0100
Message-Id: <1552314290-28709-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 7/7] target/mips: Add tests for a variety of MSA
 integer subtract instructions
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

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Add tests for a variety of MSA integer subtract instructions.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1551964929-17845-6-git-send-email-mateja.marjanovic@rt-rk.com>
---
 .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_b.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_d.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_h.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_w.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_b.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_d.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_h.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_w.c    | 153 +++++++++++++++++++++
 20 files changed, 3022 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
new file mode 100644
index 0000000..04e6159
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_S.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xc71c80c71c80c71cULL, 0x80c71c80c71c80c7ULL, },
+        { 0x8e80e38e80e38e80ULL, 0xe38e80e38e80e38eULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x727f1d727f1d727fULL, 0x1d727f1d727f1d72ULL, },
+        { 0x39e47f39e47f39e4ULL, 0x7f39e47f39e47f39ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e94e93e94e93eULL, 0x94e93e94e93e94e9ULL, },
+        { 0xb08005b08005b080ULL, 0x05b08005b08005b0ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x507ffb507ffb507fULL, 0xfb507ffb507ffb50ULL, },
+        { 0x17c26c17c26c17c2ULL, 0x6c17c26c17c26c17ULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x39e47f39e47f39e4ULL, 0x7f39e47f39e47f39ULL, },
+        { 0x8e80e38e80e38e80ULL, 0xe38e80e38e80e38eULL, },
+        { 0x17c26c17c26c17c2ULL, 0x6c17c26c17c26c17ULL, },
+        { 0xb08005b08005b080ULL, 0x05b08005b08005b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc78071c78071c780ULL, 0x71c78071c78071c7ULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x727f1d727f1d727fULL, 0x1d727f1d727f1d72ULL, },
+        { 0xc71c80c71c80c71cULL, 0x80c71c80c71c80c7ULL, },
+        { 0x507ffb507ffb507fULL, 0xfb507ffb507ffb50ULL, },
+        { 0xe93e94e93e94e93eULL, 0x94e93e94e93e94e9ULL, },
+        { 0x397f8f397f8f397fULL, 0x8f397f8f397f8f39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8d7fe680db7f7f38ULL, 0x39705044e93c8010ULL, },
+        { 0xdc1038226f7f7f7fULL, 0x247f455f53508bf8ULL, },
+        { 0x801bd080ca3173f2ULL, 0x7f767f7f5539ce6cULL, },
+        { 0x73801a7f258080c8ULL, 0xc790b0bc17c47ff0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f80527f7fc43c7fULL, 0xeb1ff51b6a142de8ULL, },
+        { 0x8b80ea16ef80e5baULL, 0x7f0633426cfd705cULL, },
+        { 0x24f0c8de91808080ULL, 0xdc80bba1adb07508ULL, },    /*  72  */
+        { 0xb17fae80803cc480ULL, 0x15e10be596ecd318ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x800b9880809ea980ULL, 0x7fe73e2702e94374ULL, },
+        { 0x7fe5307f36cf8d0eULL, 0x808a8080abc73294ULL, },
+        { 0x757f16ea117f1b46ULL, 0x80facdbe940390a4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
new file mode 100644
index 0000000..195137f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_S.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xc71c71c71c71c71cULL, 0x8000000000000000ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x7fffffffffffffffULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e93e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x7fffffffffffffffULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0x8000000000000000ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e93e93e93e9ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace668dace8e38ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038216e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0x8000000000000000ULL, 0x7fffffffffffffffULL, },
+        { 0x73531997253171c8ULL, 0xc790afbb16c3a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0xeb1ef41a6a142de8ULL, },
+        { 0x8b6eea15ef61e4baULL, 0x7fffffffffffffffULL, },
+        { 0x23efc7de916d3640ULL, 0xdc71bba0acaf7508ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000000000000ULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x8000000000000000ULL, },
+        { 0x749115ea109e1b46ULL, 0x8000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
new file mode 100644
index 0000000..c57238d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_S.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xc71c80001c72c71cULL, 0x80001c72c71c8000ULL, },
+        { 0x8e39e38e80008e39ULL, 0xe38e80008e39e38eULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c727fff71c7ULL, 0x1c727fff71c71c72ULL, },
+        { 0x38e47fffe38e38e4ULL, 0x7fffe38e38e47fffULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e94e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0xb05b05b08000b05bULL, 0x05b08000b05b05b0ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa5fa507fff4fa5ULL, 0xfa507fff4fa5fa50ULL, },
+        { 0x16c26c17c16c16c2ULL, 0x6c17c16c16c26c17ULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e47fffe38e38e4ULL, 0x7fffe38e38e47fffULL, },
+        { 0x8e39e38e80008e39ULL, 0xe38e80008e39e38eULL, },
+        { 0x16c26c17c16c16c2ULL, 0x6c17c16c16c26c17ULL, },
+        { 0xb05b05b08000b05bULL, 0x05b08000b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d71c78000c71dULL, 0x71c78000c71d71c7ULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c727fff71c7ULL, 0x1c727fff71c71c72ULL, },
+        { 0xc71c80001c72c71cULL, 0x80001c72c71c8000ULL, },
+        { 0x4fa5fa507fff4fa5ULL, 0xfa507fff4fa5fa50ULL, },
+        { 0xe93e93e93e94e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0x38e38e397fff38e3ULL, 0x8e397fff38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace669dacf7fffULL, 0x38705044e93c8000ULL, },
+        { 0xdc1038226e937fffULL, 0x238f445f53508af8ULL, },
+        { 0x8000d07fca3172f2ULL, 0x7fff7fff5539cd6cULL, },
+        { 0x7354199725318000ULL, 0xc790afbc16c47fffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6451b97fff3b88ULL, 0xeb1ff41b6a142de8ULL, },
+        { 0x8b6fea16ef62e4baULL, 0x7fff32426bfd705cULL, },
+        { 0x23f0c7de916d8000ULL, 0xdc71bba1acb07508ULL, },    /*  72  */
+        { 0xb09cae478000c478ULL, 0x14e10be595ecd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000985d8000a932ULL, 0x7fff3e2701e94274ULL, },
+        { 0x7fff2f8135cf8d0eULL, 0x80008000aac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x8000cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
new file mode 100644
index 0000000..1cded65
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_S.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xc71c71c71c71c71cULL, 0x80000000c71c71c7ULL, },
+        { 0x8e38e38e80000000ULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c727fffffffULL, 0x1c71c71d71c71c72ULL, },
+        { 0x38e38e39e38e38e4ULL, 0x7fffffff38e38e39ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0xb05b05b080000000ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa507fffffffULL, 0xfa4fa4fb4fa4fa50ULL, },
+        { 0x16c16c17c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e39e38e38e4ULL, 0x7fffffff38e38e39ULL, },
+        { 0x8e38e38e80000000ULL, 0xe38e38e38e38e38eULL, },
+        { 0x16c16c17c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xb05b05b080000000ULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c780000000ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c727fffffffULL, 0x1c71c71d71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0x80000000c71c71c7ULL, },
+        { 0x4fa4fa507fffffffULL, 0xfa4fa4fb4fa4fa50ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0x38e38e397fffffffULL, 0x8e38e38f38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace669dace8e38ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038226e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0x80000000ca3072f2ULL, 0x7fffffff5538cd6cULL, },
+        { 0x73531997253171c8ULL, 0xc790afbc16c3a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b97fffffffULL, 0xeb1ef41b6a142de8ULL, },
+        { 0x8b6eea16ef61e4baULL, 0x7fffffff6bfc705cULL, },
+        { 0x23efc7de916d3640ULL, 0xdc71bba1acaf7508ULL, },    /*  72  */
+        { 0xb09cae4780000000ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000080000000ULL, 0x7fffffff01e84274ULL, },
+        { 0x7fffffff35cf8d0eULL, 0x80000000aac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x8000000094038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
new file mode 100644
index 0000000..cb38f03
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_U.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x001c72001c72001cULL, 0x72001c72001c7200ULL, },
+        { 0x8e39008e39008e39ULL, 0x008e39008e39008eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x00001d00001d0000ULL, 0x1d00001d00001d00ULL, },
+        { 0x3900003900003900ULL, 0x0039000039000039ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x003e94003e94003eULL, 0x94003e94003e9400ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1700001700001700ULL, 0x0017000017000017ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3900003900003900ULL, 0x0039000039000039ULL, },
+        { 0x8e39008e39008e39ULL, 0x008e39008e39008eULL, },
+        { 0x1700001700001700ULL, 0x0017000017000017ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d00c71d00c71dULL, 0x00c71d00c71d00c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00001d00001d0000ULL, 0x1d00001d00001d00ULL, },
+        { 0x001c72001c72001cULL, 0x72001c72001c7200ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x003e94003e94003eULL, 0x94003e94003e9400ULL, },
+        { 0x00008f00008f0000ULL, 0x8f00008f00008f00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x0000e66900000038ULL, 0x39000044e93c5e00ULL, },
+        { 0x0010382200000000ULL, 0x2400000053508b00ULL, },
+        { 0x181bd07f00310000ULL, 0x0000000055390000ULL, },
+        { 0x7354000025317200ULL, 0x0090b000000000f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f64000000003c00ULL, 0x001f000000142de8ULL, },
+        { 0x8b6f001600620000ULL, 0x000633000000005cULL, },
+        { 0x24000000916d3640ULL, 0x0071bba100000008ULL, },    /*  72  */
+        { 0x0000ae476c3c0078ULL, 0x15000be596000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9e0032ULL, 0x00003e2702000000ULL, },
+        { 0x0000000036008d0eULL, 0x428a7d7a00003294ULL, },
+        { 0x0000160011001b46ULL, 0x7b0000be94039000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
new file mode 100644
index 0000000..2685b2f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_U.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x0000000000000000ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x0000000000000000ULL, 0x93e93e93e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x0000000000000000ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x0000000000000000ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x0000000000000000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x0000000000000000ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x93e93e93e93e93e9ULL, },
+        { 0x0000000000000000ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x386f5044e93c5d10ULL, },
+        { 0x0000000000000000ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07eca3072f2ULL, 0x0000000000000000ULL, },
+        { 0x73531997253171c8ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0x0000000000000000ULL, },
+        { 0x8b6eea15ef61e4baULL, 0x0000000000000000ULL, },
+        { 0x23efc7de916d3640ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x428a7d79aac73294ULL, },
+        { 0x0000000000000000ULL, 0x7af9cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
new file mode 100644
index 0000000..ca6dd38
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_U.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x000071c71c720000ULL, 0x71c71c72000071c7ULL, },
+        { 0x8e39000038e38e39ULL, 0x000038e38e390000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x00001c7200000000ULL, 0x1c72000000001c72ULL, },
+        { 0x38e40000000038e4ULL, 0x0000000038e40000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x000093e93e940000ULL, 0x93e93e94000093e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x16c20000000016c2ULL, 0x0000000016c20000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e40000000038e4ULL, 0x0000000038e40000ULL, },
+        { 0x8e39000038e38e39ULL, 0x000038e38e390000ULL, },
+        { 0x16c20000000016c2ULL, 0x0000000016c20000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d00001c71c71dULL, 0x00001c71c71d0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00001c7200000000ULL, 0x1c72000000001c72ULL, },
+        { 0x000071c71c720000ULL, 0x71c71c72000071c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000093e93e940000ULL, 0x93e93e94000093e9ULL, },
+        { 0x00008e3900000000ULL, 0x8e39000000008e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x0000e66900000000ULL, 0x38700000e93c5d10ULL, },
+        { 0x0000382200000000ULL, 0x238f000053508af8ULL, },
+        { 0x181bd07f00000000ULL, 0x0000000055390000ULL, },
+        { 0x73540000253171c8ULL, 0x0000afbc00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f64000000003b88ULL, 0x0000000000002de8ULL, },
+        { 0x8b6f000000000000ULL, 0x0000324200000000ULL, },
+        { 0x23f00000916d3640ULL, 0x0000bba100000000ULL, },    /*  72  */
+        { 0x0000ae476c3c0000ULL, 0x14e10be595ec0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9e0000ULL, 0x00003e2701e90000ULL, },
+        { 0x0000000035cf8d0eULL, 0x428a7d7a00003294ULL, },
+        { 0x000015ea109e1b46ULL, 0x7afa000094038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
new file mode 100644
index 0000000..42ebddb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBS_U.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBS_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x000000001c71c71cULL, 0x71c71c7200000000ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x000000008e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x0000000000000000ULL, 0x1c71c71d00000000ULL, },
+        { 0x38e38e3900000000ULL, 0x0000000038e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0x000000003e93e93eULL, 0x93e93e9400000000ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x16c16c1700000000ULL, 0x0000000016c16c17ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e3900000000ULL, 0x0000000038e38e39ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x000000008e38e38eULL, },
+        { 0x16c16c1700000000ULL, 0x0000000016c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x00000000c71c71c7ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000000000ULL, 0x1c71c71d00000000ULL, },
+        { 0x000000001c71c71cULL, 0x71c71c7200000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000003e93e93eULL, 0x93e93e9400000000ULL, },
+        { 0x0000000000000000ULL, 0x8e38e38f00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x386f5044e93c5d10ULL, },
+        { 0x0000000000000000ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07f00000000ULL, 0x000000005538cd6cULL, },
+        { 0x73531997253171c8ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b900000000ULL, 0x0000000000000000ULL, },
+        { 0x8b6eea1600000000ULL, 0x0000000000000000ULL, },
+        { 0x23efc7de916d3640ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x000000006c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x0000000001e84274ULL, },
+        { 0x0000000035cf8d0eULL, 0x428a7d7a00000000ULL, },
+        { 0x00000000109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBS_U_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
new file mode 100644
index 0000000..dac20cc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUS_U.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUS_U.B";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffc7ffffc7ffffULL, 0xc7ffffc7ffffc7ffULL, },
+        { 0xe38effe38effe38eULL, 0xffe38effe38effe3ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1d72001d72001d72ULL, 0x001d72001d72001dULL, },
+        { 0x0000390000390000ULL, 0x3900003900003900ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc7ff72c7ff72c7ffULL, 0x72c7ff72c7ff72c7ULL, },
+        { 0x8e39e38e39e38e39ULL, 0xe38e39e38e39e38eULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0x39008e39008e3900ULL, 0x8e39008e39008e39ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe9ff94e9ff94e9ffULL, 0x94e9ff94e9ff94e9ULL, },
+        { 0xb05bffb05bffb05bULL, 0xffb05bffb05bffb0ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x50a50050a50050a5ULL, 0x0050a50050a50050ULL, },
+        { 0x17006c17006c1700ULL, 0x6c17006c17006c17ULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffe48effe48effe4ULL, 0x8effe48effe48effULL, },
+        { 0x8e39008e39008e39ULL, 0x008e39008e39008eULL, },
+        { 0xffc26cffc26cffc2ULL, 0x6cffc26cffc26cffULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xc71d71c71d71c71dULL, 0x71c71d71c71d71c7ULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x72c7ff72c7ff72c7ULL, 0xff72c7ff72c7ff72ULL, },
+        { 0x001c72001c72001cULL, 0x72001c72001c7200ULL, },
+        { 0x50a5fb50a5fb50a5ULL, 0xfb50a5fb50a5fb50ULL, },
+        { 0x003e94003e94003eULL, 0x94003e94003e9400ULL, },
+        { 0x39e38f39e38f39e3ULL, 0x8f39e38f39e38f39ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xff00ffff00000000ULL, 0x00000000ff00ff00ULL, },    /*  64  */
+        { 0x8dace66900cf8e38ULL, 0x39705044e93c5e10ULL, },
+        { 0xdc10ffff6f93cac0ULL, 0x248f455fff508b00ULL, },
+        { 0x181bd07f00317300ULL, 0xbe768386ff39ce6cULL, },
+        { 0xff541a9725317200ULL, 0x0090b0001700a2f0ULL, },
+        { 0xffff000000ffff00ULL, 0x00ffff00000000ffULL, },
+        { 0xff6452b994c4ff88ULL, 0x00fff51b6a142de8ULL, },
+        { 0x8b6f00160062e500ULL, 0x85ffff426c0070ffULL, },
+        { 0xff00c8de916d3640ULL, 0x0071bba1ad007508ULL, },    /*  72  */
+        { 0xb19cae476cffc478ULL, 0x15e1ffe596000018ULL, },
+        { 0xff00ffffffffffffULL, 0x00ffffffff000000ULL, },
+        { 0x3c0b985d5b9ea932ULL, 0x9ae7ffffff004374ULL, },
+        { 0xe800308136008d0eULL, 0x428a7d7aab00ff94ULL, },
+        { 0x75911600119eff46ULL, 0x7bfacdbe940390a4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
new file mode 100644
index 0000000..4485502
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUS_U.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUS_U.D";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e4ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e93e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x0000000000000000ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0x8e38e38e38e38e39ULL, },
+        { 0x8e38e38e38e38e39ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x6c16c16c16c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c71c71c71c7ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0x0000000000000000ULL, 0x93e93e93e93e93e9ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace668dace8e38ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038216e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07eca3072f2ULL, 0xbd7582865538cd6cULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x8b6eea15ef61e4baULL, 0x850632416bfc705cULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0x428a7d79aac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
new file mode 100644
index 0000000..9e99aee
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUS_U.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUS_U.H";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffc71cffffffffULL, 0xc71cffffffffc71cULL, },
+        { 0xe38effff8e38e38eULL, 0xffff8e38e38effffULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c72000071c81c72ULL, 0x000071c81c720000ULL, },
+        { 0x000038e400000000ULL, 0x38e40000000038e4ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c7ffffc71cULL, 0x71c7ffffc71c71c7ULL, },
+        { 0x8e39e38e38e38e39ULL, 0xe38e38e38e39e38eULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0x38e48e39000038e4ULL, 0x8e39000038e48e39ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e9ffffe93eULL, 0x93e9ffffe93e93e9ULL, },
+        { 0xb05bffff5b05b05bULL, 0xffff5b05b05bffffULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa50000a4fb4fa5ULL, 0x0000a4fb4fa50000ULL, },
+        { 0x16c26c17000016c2ULL, 0x6c17000016c26c17ULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffff8e39e38effffULL, 0x8e39e38effff8e39ULL, },
+        { 0x8e39000038e38e39ULL, 0x000038e38e390000ULL, },
+        { 0xffff6c17c16cffffULL, 0x6c17c16cffff6c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xc71d71c71c71c71dULL, 0x71c71c71c71d71c7ULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c7ffffc71d71c7ULL, 0xffffc71d71c7ffffULL, },
+        { 0x000071c71c720000ULL, 0x71c71c72000071c7ULL, },
+        { 0x4fa5fa50a4fb4fa5ULL, 0xfa50a4fb4fa5fa50ULL, },
+        { 0x000093e93e940000ULL, 0x93e93e94000093e9ULL, },
+        { 0x38e38e39e38f38e3ULL, 0x8e39e38f38e38e39ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },    /*  64  */
+        { 0x8cace66900008e38ULL, 0x38705044e93c5d10ULL, },
+        { 0xdc10ffff6e93c9c0ULL, 0x238f445fffff8af8ULL, },
+        { 0x181bd07f000072f2ULL, 0xbd768286ffffcd6cULL, },
+        { 0xffff1997253171c8ULL, 0x0000afbc16c4a2f0ULL, },
+        { 0xffff00000000ffffULL, 0x0000ffff00000000ULL, },
+        { 0xffff51b993c4ffffULL, 0x0000f41b6a142de8ULL, },
+        { 0x8b6f00000000e4baULL, 0x8506ffff6bfd705cULL, },
+        { 0xffffc7de916d3640ULL, 0x0000bba1acb07508ULL, },    /*  72  */
+        { 0xb09cae476c3cc478ULL, 0x14e1ffff95ec0000ULL, },
+        { 0xffffffffffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x3c0b985d5b9ea932ULL, 0x99e7ffffffff4274ULL, },
+        { 0xe7e52f8135cf8d0eULL, 0x428a7d7aaac7ffffULL, },
+        { 0x749115ea109effffULL, 0x7afacdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
new file mode 100644
index 0000000..53a9aca
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUS_U.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUS_U.W";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xc71c71c7ffffffffULL, },
+        { 0xe38e38e38e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x000000001c71c71dULL, },
+        { 0x0000000000000000ULL, 0x38e38e3900000000ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c7ffffffffULL, 0x71c71c72c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0x38e38e3900000000ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e9ffffffffULL, 0x93e93e94e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0xffffffffb05b05b0ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x000000004fa4fa50ULL, },
+        { 0x16c16c1700000000ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffe38e38e4ULL, 0x8e38e38effffffffULL, },
+        { 0x8e38e38e38e38e39ULL, 0x000000008e38e38eULL, },
+        { 0xffffffffc16c16c2ULL, 0x6c16c16cffffffffULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xc71c71c71c71c71dULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c72c71c71c7ULL, 0xffffffff71c71c72ULL, },
+        { 0x000000001c71c71cULL, 0x71c71c7200000000ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0xfa4fa4fb4fa4fa50ULL, },
+        { 0x000000003e93e93eULL, 0x93e93e9400000000ULL, },
+        { 0x38e38e39e38e38e3ULL, 0x8e38e38f38e38e39ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },    /*  64  */
+        { 0x8cace66900000000ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038226e92c9c0ULL, 0x238e445fffffffffULL, },
+        { 0x181bd07f00000000ULL, 0xbd758286ffffffffULL, },
+        { 0xffffffff253171c8ULL, 0x0000000016c3a2f0ULL, },
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff93c43b88ULL, 0x000000006a142de8ULL, },
+        { 0x8b6eea1600000000ULL, 0x850632426bfc705cULL, },
+        { 0xffffffff916d3640ULL, 0x00000000acaf7508ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x3c0b985d5b9da932ULL, 0x99e73e27ffffffffULL, },
+        { 0xe7e42f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUS_U_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
new file mode 100644
index 0000000..86fb4f3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUU_S.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUU_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x1c717f1c717f1c71ULL, 0x7f1c717f1c717f1cULL, },
+        { 0x7f7f387f7f387f7fULL, 0x387f7f387f7f387fULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },
+        { 0x8080c88080c88080ULL, 0xc88080c88080c880ULL, },
+        { 0xe48f80e48f80e48fULL, 0x80e48f80e48f80e4ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },    /*  16  */
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c72c71c72c71cULL, 0x72c71c72c71c72c7ULL, },
+        { 0x7f39e37f39e37f39ULL, 0xe37f39e37f39e37fULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x80c71d80c71d80c7ULL, 0x1d80c71d80c71d80ULL, },
+        { 0x39e48e39e48e39e4ULL, 0x8e39e48e39e48e39ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },    /*  32  */
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0xe93e7fe93e7fe93eULL, 0x7fe93e7fe93e7fe9ULL, },
+        { 0x7f5b057f5b057f5bULL, 0x057f5b057f5b057fULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x80a5fb80a5fb80a5ULL, 0xfb80a5fb80a5fb80ULL, },
+        { 0x17c28017c28017c2ULL, 0x8017c28017c28017ULL, },
+        { 0xe48f80e48f80e48fULL, 0x80e48f80e48f80e4ULL, },    /*  48  */
+        { 0x7f7f387f7f387f7fULL, 0x387f7f387f7f387fULL, },
+        { 0x39e48e39e48e39e4ULL, 0x8e39e48e39e48e39ULL, },
+        { 0x7f39e37f39e37f39ULL, 0xe37f39e37f39e37fULL, },
+        { 0x17c28017c28017c2ULL, 0x8017c28017c28017ULL, },
+        { 0x7f5b057f5b057f5bULL, 0x057f5b057f5b057fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7f1d807f1d807f1dULL, 0x807f1d807f1d807fULL, },
+        { 0x8080c88080c88080ULL, 0xc88080c88080c880ULL, },    /*  56  */
+        { 0x1c717f1c717f1c71ULL, 0x7f1c717f1c717f1cULL, },
+        { 0x80c71d80c71d80c7ULL, 0x1d80c71d80c71d80ULL, },
+        { 0xc71c72c71c72c71cULL, 0x72c71c72c71c72c7ULL, },
+        { 0x80a5fb80a5fb80a5ULL, 0xfb80a5fb80a5fb80ULL, },
+        { 0xe93e7fe93e7fe93eULL, 0x7fe93e7fe93e7fe9ULL, },
+        { 0x80e37f80e37f80e3ULL, 0x7f80e37f80e37f80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8dac7f69dbcf8e38ULL, 0x398080447f3c5e80ULL, },
+        { 0xdc1038228093cac0ULL, 0x248f808053507ff8ULL, },
+        { 0x181b7f7fca3180f2ULL, 0xbe8083865539ce80ULL, },
+        { 0x73548097253172c8ULL, 0xc77f7fbc80c4a27fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6480b994c43c88ULL, 0xeb1ff58080142d7fULL, },
+        { 0x7f6fea16ef62e5baULL, 0x8506338080fd805cULL, },
+        { 0x24f0c8de7f6d3640ULL, 0xdc717f7fadb08008ULL, },    /*  72  */
+        { 0xb19c7f476c3cc478ULL, 0x15e10b7f7fecd380ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b7f5d5b7fa932ULL, 0x9ae73e2702e98080ULL, },
+        { 0xe8e5808136cf7f0eULL, 0x427f7d7aabc7327fULL, },
+        { 0x809116ea119e1b46ULL, 0x7bfacd7f7f037fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
new file mode 100644
index 0000000..45a1eb3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUU_S.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUU_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },
+        { 0x8000000000000000ULL, 0xc71c71c71c71c71dULL, },
+        { 0xe38e38e38e38e38fULL, 0x8000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },    /*  16  */
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x7fffffffffffffffULL, 0xe38e38e38e38e38eULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x8000000000000000ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },    /*  32  */
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0xe93e93e93e93e93eULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x05b05b05b05b05b0ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000000000000ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x8000000000000000ULL, },
+        { 0xe38e38e38e38e38fULL, 0x8000000000000000ULL, },    /*  48  */
+        { 0x7fffffffffffffffULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x7fffffffffffffffULL, 0xe38e38e38e38e38eULL, },
+        { 0x16c16c16c16c16c2ULL, 0x8000000000000000ULL, },
+        { 0x7fffffffffffffffULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fffffffffffffffULL, 0x8000000000000000ULL, },
+        { 0x8000000000000000ULL, 0xc71c71c71c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x7fffffffffffffffULL, },
+        { 0x8000000000000000ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x8000000000000000ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0xe93e93e93e93e93eULL, 0x7fffffffffffffffULL, },
+        { 0x8000000000000000ULL, 0x7fffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace668dace8e38ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038216e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07eca3072f2ULL, 0xbd7582865538cd6cULL, },
+        { 0x73531997253171c8ULL, 0xc790afbb16c3a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0xeb1ef41a6a142de8ULL, },
+        { 0x7fffffffffffffffULL, 0x850632416bfc705cULL, },
+        { 0x23efc7de916d3640ULL, 0xdc71bba0acaf7508ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0x428a7d79aac73294ULL, },
+        { 0x8000000000000000ULL, 0x7af9cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
new file mode 100644
index 0000000..14ac7de
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUU_S.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUU_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x1c717fff71c71c71ULL, 0x7fff71c71c717fffULL, },
+        { 0x7fff38e37fff7fffULL, 0x38e37fff7fff38e3ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },
+        { 0x8000c71d80008000ULL, 0xc71d80008000c71dULL, },
+        { 0xe38f80008e39e38fULL, 0x80008e39e38f8000ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },    /*  16  */
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c72c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x7fffe38e38e37fffULL, 0xe38e38e37fffe38eULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x80001c72c71d8000ULL, 0x1c72c71d80001c72ULL, },
+        { 0x38e48e39e38e38e4ULL, 0x8e39e38e38e48e39ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },    /*  32  */
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0xe93e7fff3e94e93eULL, 0x7fff3e94e93e7fffULL, },
+        { 0x7fff05b05b057fffULL, 0x05b05b057fff05b0ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000fa50a4fb8000ULL, 0xfa50a4fb8000fa50ULL, },
+        { 0x16c28000c16c16c2ULL, 0x8000c16c16c28000ULL, },
+        { 0xe38f80008e39e38fULL, 0x80008e39e38f8000ULL, },    /*  48  */
+        { 0x7fff38e37fff7fffULL, 0x38e37fff7fff38e3ULL, },
+        { 0x38e48e39e38e38e4ULL, 0x8e39e38e38e48e39ULL, },
+        { 0x7fffe38e38e37fffULL, 0xe38e38e37fffe38eULL, },
+        { 0x16c28000c16c16c2ULL, 0x8000c16c16c28000ULL, },
+        { 0x7fff05b05b057fffULL, 0x05b05b057fff05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fff80001c717fffULL, 0x80001c717fff8000ULL, },
+        { 0x8000c71d80008000ULL, 0xc71d80008000c71dULL, },    /*  56  */
+        { 0x1c717fff71c71c71ULL, 0x7fff71c71c717fffULL, },
+        { 0x80001c72c71d8000ULL, 0x1c72c71d80001c72ULL, },
+        { 0xc71c71c71c72c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x8000fa50a4fb8000ULL, 0xfa50a4fb8000fa50ULL, },
+        { 0xe93e7fff3e94e93eULL, 0x7fff3e94e93e7fffULL, },
+        { 0x80007fffe38f8000ULL, 0x7fffe38f80007fffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cac7fffdacf8e38ULL, 0x387080007fff5d10ULL, },
+        { 0xdc1038228000c9c0ULL, 0x238f800053507fffULL, },
+        { 0x181b7fffca318000ULL, 0xbd7682865539cd6cULL, },
+        { 0x73548000253171c8ULL, 0xc7907fff8000a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f64800093c43b88ULL, 0xeb1ff41b80002de8ULL, },
+        { 0x7fffea16ef62e4baULL, 0x8506324280008000ULL, },
+        { 0x23f0c7de7fff3640ULL, 0xdc717fffacb08000ULL, },    /*  72  */
+        { 0xb09c7fff6c3cc478ULL, 0x14e10be57fffd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b7fff5b9ea932ULL, 0x99e73e2701e98000ULL, },
+        { 0xe7e5800035cf7fffULL, 0x428a7d7aaac73294ULL, },
+        { 0x800015ea109e1b46ULL, 0x7afacdbe7fff7fffULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
new file mode 100644
index 0000000..688f469
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBSUU_S.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBSUU_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0x7fffffff1c71c71cULL, },
+        { 0x7fffffff7fffffffULL, 0x38e38e387fffffffULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },
+        { 0x8000000080000000ULL, 0xc71c71c880000000ULL, },
+        { 0xe38e38e48e38e38fULL, 0x80000000e38e38e4ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },    /*  16  */
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x7fffffff38e38e39ULL, 0xe38e38e37fffffffULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x80000000c71c71c7ULL, 0x1c71c71d80000000ULL, },
+        { 0x38e38e39e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },    /*  32  */
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0xe93e93e93e93e93eULL, 0x7fffffffe93e93e9ULL, },
+        { 0x7fffffff5b05b05bULL, 0x05b05b057fffffffULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x80000000a4fa4fa5ULL, 0xfa4fa4fb80000000ULL, },
+        { 0x16c16c17c16c16c2ULL, 0x8000000016c16c17ULL, },
+        { 0xe38e38e48e38e38fULL, 0x80000000e38e38e4ULL, },    /*  48  */
+        { 0x7fffffff7fffffffULL, 0x38e38e387fffffffULL, },
+        { 0x38e38e39e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x7fffffff38e38e39ULL, 0xe38e38e37fffffffULL, },
+        { 0x16c16c17c16c16c2ULL, 0x8000000016c16c17ULL, },
+        { 0x7fffffff5b05b05bULL, 0x05b05b057fffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x7fffffff1c71c71dULL, 0x800000007fffffffULL, },
+        { 0x8000000080000000ULL, 0xc71c71c880000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x7fffffff1c71c71cULL, },
+        { 0x80000000c71c71c7ULL, 0x1c71c71d80000000ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x80000000a4fa4fa5ULL, 0xfa4fa4fb80000000ULL, },
+        { 0xe93e93e93e93e93eULL, 0x7fffffffe93e93e9ULL, },
+        { 0x80000000e38e38e3ULL, 0x7fffffff80000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace669dace8e38ULL, 0x386f50447fffffffULL, },
+        { 0xdc10382280000000ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07fca3072f2ULL, 0xbd7582865538cd6cULL, },
+        { 0x73531997253171c8ULL, 0xc790afbc80000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b993c43b88ULL, 0xeb1ef41b80000000ULL, },
+        { 0x7fffffffef61e4baULL, 0x8506324280000000ULL, },
+        { 0x23efc7de7fffffffULL, 0xdc71bba1acaf7508ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be57fffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
+        { 0x80000000109e1b46ULL, 0x7af9cdbe7fffffffULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBSUU_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
new file mode 100644
index 0000000..d0964dc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBV.B
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBV.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c72c71c72c71cULL, 0x72c71c72c71c72c7ULL, },
+        { 0x8e39e38e39e38e39ULL, 0xe38e39e38e39e38eULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0x39e48e39e48e39e4ULL, 0x8e39e48e39e48e39ULL, },
+        { 0xcdcdcdcdcdcdcdcdULL, 0xcdcdcdcdcdcdcdcdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e94e93e94e93eULL, 0x94e93e94e93e94e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0xdedededededededeULL, 0xdedededededededeULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x50a5fb50a5fb50a5ULL, 0xfb50a5fb50a5fb50ULL, },
+        { 0x17c26c17c26c17c2ULL, 0x6c17c26c17c26c17ULL, },
+        { 0xe48f39e48f39e48fULL, 0x39e48f39e48f39e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x39e48e39e48e39e4ULL, 0x8e39e48e39e48e39ULL, },
+        { 0x8e39e38e39e38e39ULL, 0xe38e39e38e39e38eULL, },
+        { 0x17c26c17c26c17c2ULL, 0x6c17c26c17c26c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d71c71d71c71dULL, 0x71c71d71c71d71c7ULL, },
+        { 0x1d72c81d72c81d72ULL, 0xc81d72c81d72c81dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x72c71d72c71d72c7ULL, 0x1d72c71d72c71d72ULL, },
+        { 0xc71c72c71c72c71cULL, 0x72c71c72c71c72c7ULL, },
+        { 0x50a5fb50a5fb50a5ULL, 0xfb50a5fb50a5fb50ULL, },
+        { 0xe93e94e93e94e93eULL, 0x94e93e94e93e94e9ULL, },
+        { 0x39e38f39e38f39e3ULL, 0x8f39e38f39e38f39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8dace669dbcf8e38ULL, 0x39705044e93c5e10ULL, },
+        { 0xdc1038226f93cac0ULL, 0x248f455f53508bf8ULL, },
+        { 0x181bd07fca3173f2ULL, 0xbe7683865539ce6cULL, },
+        { 0x73541a97253172c8ULL, 0xc790b0bc17c4a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6452b994c43c88ULL, 0xeb1ff51b6a142de8ULL, },
+        { 0x8b6fea16ef62e5baULL, 0x850633426cfd705cULL, },
+        { 0x24f0c8de916d3640ULL, 0xdc71bba1adb07508ULL, },    /*  72  */
+        { 0xb19cae476c3cc478ULL, 0x15e10be596ecd318ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9ea932ULL, 0x9ae73e2702e94374ULL, },
+        { 0xe8e5308136cf8d0eULL, 0x428a7d7aabc73294ULL, },
+        { 0x759116ea119e1b46ULL, 0x7bfacdbe940390a4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
new file mode 100644
index 0000000..ec26a8e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBV.D
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBV.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xcccccccccccccccdULL, 0xcccccccccccccccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e93e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0xdddddddddddddddeULL, 0xdddddddddddddddeULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xe38e38e38e38e38fULL, 0x38e38e38e38e38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x16c16c16c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0xc71c71c71c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0xfa4fa4fa4fa4fa50ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e93e93e93e9ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace668dace8e38ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038216e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07eca3072f2ULL, 0xbd7582865538cd6cULL, },
+        { 0x73531997253171c8ULL, 0xc790afbb16c3a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b893c43b88ULL, 0xeb1ef41a6a142de8ULL, },
+        { 0x8b6eea15ef61e4baULL, 0x850632416bfc705cULL, },
+        { 0x23efc7de916d3640ULL, 0xdc71bba0acaf7508ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0x428a7d79aac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
new file mode 100644
index 0000000..420422e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction SUBV.H
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBV.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c72c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x8e39e38e38e38e39ULL, 0xe38e38e38e39e38eULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0x38e48e39e38e38e4ULL, 0x8e39e38e38e48e39ULL, },
+        { 0xcccdcccdcccdcccdULL, 0xcccdcccdcccdcccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e94e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0xdddedddedddedddeULL, 0xdddedddedddedddeULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa5fa50a4fb4fa5ULL, 0xfa50a4fb4fa5fa50ULL, },
+        { 0x16c26c17c16c16c2ULL, 0x6c17c16c16c26c17ULL, },
+        { 0xe38f38e48e39e38fULL, 0x38e48e39e38f38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e48e39e38e38e4ULL, 0x8e39e38e38e48e39ULL, },
+        { 0x8e39e38e38e38e39ULL, 0xe38e38e38e39e38eULL, },
+        { 0x16c26c17c16c16c2ULL, 0x6c17c16c16c26c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71d71c71c71c71dULL, 0x71c71c71c71d71c7ULL, },
+        { 0x1c72c71d71c81c72ULL, 0xc71d71c81c72c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c72c71d71c7ULL, 0x1c72c71d71c71c72ULL, },
+        { 0xc71c71c71c72c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x4fa5fa50a4fb4fa5ULL, 0xfa50a4fb4fa5fa50ULL, },
+        { 0xe93e93e93e94e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0x38e38e39e38f38e3ULL, 0x8e39e38f38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace669dacf8e38ULL, 0x38705044e93c5d10ULL, },
+        { 0xdc1038226e93c9c0ULL, 0x238f445f53508af8ULL, },
+        { 0x181bd07fca3172f2ULL, 0xbd7682865539cd6cULL, },
+        { 0x73541997253171c8ULL, 0xc790afbc16c4a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6451b993c43b88ULL, 0xeb1ff41b6a142de8ULL, },
+        { 0x8b6fea16ef62e4baULL, 0x850632426bfd705cULL, },
+        { 0x23f0c7de916d3640ULL, 0xdc71bba1acb07508ULL, },    /*  72  */
+        { 0xb09cae476c3cc478ULL, 0x14e10be595ecd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9ea932ULL, 0x99e73e2701e94274ULL, },
+        { 0xe7e52f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x7afacdbe94038fa4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
new file mode 100644
index 0000000..3e97005
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SUBV.W
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+    char *instruction_name = "SUBV.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0x38e38e39e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xcccccccdcccccccdULL, 0xcccccccdcccccccdULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x7777777777777777ULL, 0x7777777777777777ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0xdddddddedddddddeULL, 0xdddddddedddddddeULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0xfa4fa4fb4fa4fa50ULL, },
+        { 0x16c16c17c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xe38e38e48e38e38fULL, 0x38e38e39e38e38e4ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38e39e38e38e4ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x8e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0x16c16c17c16c16c2ULL, 0x6c16c16c16c16c17ULL, },
+        { 0xb05b05b05b05b05bULL, 0x05b05b05b05b05b0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xc71c71c71c71c71dULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71d71c71c72ULL, 0xc71c71c81c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x71c71c72c71c71c7ULL, 0x1c71c71d71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c72c71c71c7ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0xfa4fa4fb4fa4fa50ULL, },
+        { 0xe93e93e93e93e93eULL, 0x93e93e94e93e93e9ULL, },
+        { 0x38e38e39e38e38e3ULL, 0x8e38e38f38e38e39ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0x8cace669dace8e38ULL, 0x386f5044e93c5d10ULL, },
+        { 0xdc1038226e92c9c0ULL, 0x238e445f53508af8ULL, },
+        { 0x181bd07fca3072f2ULL, 0xbd7582865538cd6cULL, },
+        { 0x73531997253171c8ULL, 0xc790afbc16c3a2f0ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4f6351b993c43b88ULL, 0xeb1ef41b6a142de8ULL, },
+        { 0x8b6eea16ef61e4baULL, 0x850632426bfc705cULL, },
+        { 0x23efc7de916d3640ULL, 0xdc71bba1acaf7508ULL, },    /*  72  */
+        { 0xb09cae476c3bc478ULL, 0x14e10be595ebd218ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3c0b985d5b9da932ULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0x428a7d7aaac73294ULL, },
+        { 0x749115ea109e1b46ULL, 0x7af9cdbe94038fa4ULL, },
+        { 0xc3f467a3a46256ceULL, 0x6618c1d9fe17bd8cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SUBV_W(b128_random[i], b128_random[j],
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
