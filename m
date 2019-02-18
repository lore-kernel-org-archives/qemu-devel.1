Received: from eggs.gnu.org ([209.51.188.92]:54298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuy-0005EM-Js
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuk-0001zp-8W
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:16 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43895 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gvkuj-0001xV-2E
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:02 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 18 Feb 2019 16:31:35 +0100
Message-Id: <1550503897-31141-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 5/7] tests/tcg: target/mips: Add tests for MSA
 integer compare instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add tests for MSA integer compare instructions. This includes
following instructions:

  * CEQ.B - integer compare equal (bytes)
  * CEQ.H - integer compare equal (halfwords)
  * CEQ.W - integer compare equal (words)
  * CEQ.D - integer compare equal (doublewords)
  * CLE_S.B - signed integer compare less or equal (bytes)
  * CLE_S.H - signed integer compare less or equal (halfwords)
  * CLE_S.W - signed integer compare less or equal (words)
  * CLE_S.D - signed integer compare less or equal (doublewords)
  * CLE_U.B - unsigned integer compare less or equal (bytes)
  * CLE_U.H - unsigned integer compare less or equal (halfwords)
  * CLE_U.W - unsigned integer compare less or equal (words)
  * CLE_U.D - unsigned integer compare less or equal (doublewords)
  * CLT_S.B - signed integer compare less or equal (bytes)
  * CLT_S.H - signed integer compare less or equal (halfwords)
  * CLT_S.W - signed integer compare less or equal (words)
  * CLT_S.D - signed integer compare less or equal (doublewords)
  * CLT_U.B - unsigned integer compare less or equal (bytes)
  * CLT_U.H - unsigned integer compare less or equal (halfwords)
  * CLT_U.W - unsigned integer compare less or equal (words)
  * CLT_U.D - unsigned integer compare less or equal (doublewords)

Each test consists of 80 test cases, so altogether there are 1600 test
cases.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    | 153 +++++++++++++++++++++
 20 files changed, 3060 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
new file mode 100644
index 0000000..b47b42e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CEQ.B
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
+    char *instruction_name = "CEQ.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_B(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_B(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
new file mode 100644
index 0000000..e169bdc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CEQ.D
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
+    char *instruction_name = "CEQ.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_D(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_D(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
new file mode 100644
index 0000000..9f03cb0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CEQ.H
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
+    char *instruction_name = "CEQ.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_H(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_H(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
new file mode 100644
index 0000000..a927d96
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CEQ.W
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
+    char *instruction_name = "CEQ.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  72  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_W(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CEQ_W(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
new file mode 100644
index 0000000..1c1cb3b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_S.B
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
+    char *instruction_name = "CLE_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },    /*  48  */
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },    /*  56  */
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xff00ffffff000000ULL, 0x00000000ff00ff00ULL, },
+        { 0xff00000000000000ULL, 0x000000000000ffffULL, },
+        { 0xff00ffffff0000ffULL, 0x000000000000ff00ULL, },
+        { 0x00ff000000ffffffULL, 0xffffffff00ff00ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00ff000000ff0000ULL, 0xff00ff00000000ffULL, },
+        { 0xffffff00ffffffffULL, 0x0000000000ff0000ULL, },
+        { 0x00ffffffffffffffULL, 0xffffffffffff0000ULL, },    /*  72  */
+        { 0xff00ffffff00ffffULL, 0x00ff00ffffffff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff00ffffffffffffULL, 0x00ff000000ff0000ULL, },
+        { 0x00ff000000ffff00ULL, 0xffffffffffff00ffULL, },
+        { 0x000000ff00000000ULL, 0xffffffffff00ffffULL, },
+        { 0x00ff000000000000ULL, 0xff00ffffff00ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
new file mode 100644
index 0000000..b51907c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_S.D
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
+    char *instruction_name = "CLE_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
new file mode 100644
index 0000000..20ebbfb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_S.H
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
+    char *instruction_name = "CLE_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },    /*  48  */
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },    /*  56  */
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffffffffffff0000ULL, 0x00000000ffffffffULL, },
+        { 0xffff000000000000ULL, 0x000000000000ffffULL, },
+        { 0xffffffffffff0000ULL, 0x000000000000ffffULL, },
+        { 0x000000000000ffffULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000ffffffffffffULL, 0xffffffffffff0000ULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x000000000000ffffULL, 0xffffffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
new file mode 100644
index 0000000..4a78cce
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_S.W
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
+    char *instruction_name = "CLE_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
new file mode 100644
index 0000000..9990a5b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_U.B
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
+    char *instruction_name = "CLE_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffff0000ffffff00ULL, 0x00ffff00000000ffULL, },
+        { 0xff000000ffffffffULL, 0x00ffffff000000ffULL, },
+        { 0x00000000ff00ffffULL, 0xffffffff0000ffffULL, },
+        { 0x0000ffff000000ffULL, 0xff0000ffffffff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffffffff00ffULL, 0xff00ffffff000000ULL, },
+        { 0x0000ff00ff00ffffULL, 0xff0000ffffffff00ULL, },
+        { 0x00ffffff00000000ULL, 0xff000000ffffff00ULL, },    /*  72  */
+        { 0xffff00000000ff00ULL, 0x00ff000000ffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x000000000000ff00ULL, 0xffff000000ffffffULL, },
+        { 0xffffffff00ff0000ULL, 0x00000000ffff0000ULL, },
+        { 0xffff00ff00ff0000ULL, 0x00ffff00000000ffULL, },
+        { 0xffffffffffff00ffULL, 0x0000ffffff000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
new file mode 100644
index 0000000..cde86d8
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_U.D
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
+    char *instruction_name = "CLE_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
new file mode 100644
index 0000000..70e4b48
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_U.H
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
+    char *instruction_name = "CLE_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffff0000ffffffffULL, 0x0000ffff00000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffff00000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff0000ffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff0000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffffffff0000ULL, },
+        { 0x0000ffffffffffffULL, 0xffff0000ffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff0000ffffffffULL, },    /*  72  */
+        { 0xffff00000000ffffULL, 0x000000000000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x000000000000ffffULL, 0xffff00000000ffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffff0000ULL, },
+        { 0xffff000000000000ULL, 0x0000ffff00000000ULL, },
+        { 0xffffffffffff0000ULL, 0x0000ffffffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
new file mode 100644
index 0000000..f38feac
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLE_U.W
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
+    char *instruction_name = "CLE_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLE_U_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
new file mode 100644
index 0000000..b81b569
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_S.B
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
+    char *instruction_name = "CLT_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },    /*  48  */
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },    /*  56  */
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xff00ffff00ffff00ULL, 0xffff00ffff00ffffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xff00ffffff000000ULL, 0x00000000ff00ff00ULL, },
+        { 0xff00000000000000ULL, 0x000000000000ffffULL, },
+        { 0xff00ffffff0000ffULL, 0x000000000000ff00ULL, },
+        { 0x00ff000000ffffffULL, 0xffffffff00ff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ff000000ff0000ULL, 0xff00ff00000000ffULL, },
+        { 0xffffff00ffffffffULL, 0x0000000000ff0000ULL, },
+        { 0x00ffffffffffffffULL, 0xffffffffffff0000ULL, },    /*  72  */
+        { 0xff00ffffff00ffffULL, 0x00ff00ffffffff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff00ffffffffffffULL, 0x00ff000000ff0000ULL, },
+        { 0x00ff000000ffff00ULL, 0xffffffffffff00ffULL, },
+        { 0x000000ff00000000ULL, 0xffffffffff00ffffULL, },
+        { 0x00ff000000000000ULL, 0xff00ffffff00ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
new file mode 100644
index 0000000..393457a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_S.D
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
+    char *instruction_name = "CLT_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
new file mode 100644
index 0000000..56860d7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_S.H
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
+    char *instruction_name = "CLT_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },    /*  48  */
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },    /*  56  */
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffffffffffff0000ULL, 0x00000000ffffffffULL, },
+        { 0xffff000000000000ULL, 0x000000000000ffffULL, },
+        { 0xffffffffffff0000ULL, 0x000000000000ffffULL, },
+        { 0x000000000000ffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000ffffffffffffULL, 0xffffffffffff0000ULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x000000000000ffffULL, 0xffffffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
new file mode 100644
index 0000000..346b293
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_S.W
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
+    char *instruction_name = "CLT_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },    /*  48  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffff00000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
new file mode 100644
index 0000000..be79646
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_U.B
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
+    char *instruction_name = "CLT_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x00ffff00ffff00ffULL, 0xff00ffff00ffff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff0000ff0000ff00ULL, 0x00ff0000ff0000ffULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffff0000ffffff00ULL, 0x00ffff00000000ffULL, },
+        { 0xff000000ffffffffULL, 0x00ffffff000000ffULL, },
+        { 0x00000000ff00ffffULL, 0xffffffff0000ffffULL, },
+        { 0x0000ffff000000ffULL, 0xff0000ffffffff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ffffffff00ffULL, 0xff00ffffff000000ULL, },
+        { 0x0000ff00ff00ffffULL, 0xff0000ffffffff00ULL, },
+        { 0x00ffffff00000000ULL, 0xff000000ffffff00ULL, },    /*  72  */
+        { 0xffff00000000ff00ULL, 0x00ff000000ffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000ff00ULL, 0xffff000000ffffffULL, },
+        { 0xffffffff00ff0000ULL, 0x00000000ffff0000ULL, },
+        { 0xffff00ff00ff0000ULL, 0x00ffff00000000ffULL, },
+        { 0xffffffffffff00ffULL, 0x0000ffffff000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
new file mode 100644
index 0000000..afbe490
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_U.D
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
+    char *instruction_name = "CLT_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
new file mode 100644
index 0000000..126597a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_U.H
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
+    char *instruction_name = "CLT_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffff0000ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffff0000ffffffffULL, 0x0000ffff00000000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffff00000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff0000ffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff0000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ffffffff0000ULL, 0xffffffffffff0000ULL, },
+        { 0x0000ffffffffffffULL, 0xffff0000ffffffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff0000ffffffffULL, },    /*  72  */
+        { 0xffff00000000ffffULL, 0x000000000000ffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000000ffffULL, 0xffff00000000ffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffff0000ULL, },
+        { 0xffff000000000000ULL, 0x0000ffff00000000ULL, },
+        { 0xffffffffffff0000ULL, 0x0000ffffffff0000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
new file mode 100644
index 0000000..b405929
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction CLT_U.W
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
+    char *instruction_name = "CLT_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000ffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  72  */
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },
+        { 0xffffffff00000000ULL, 0x00000000ffffffffULL, },
+        { 0xffffffff00000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_CLT_U_W(b128_random[i], b128_random[j],
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
