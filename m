Received: from eggs.gnu.org ([209.51.188.92]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LtA-0005MC-Eu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3Lsx-0001Z9-RQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54238 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h3LsO-0000fh-GV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:35 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Mar 2019 15:24:46 +0100
Message-Id: <1552314290-28709-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 3/7] target/mips: Add tests for a variety of MSA
 integer average instructions
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

Add tests for a variety of MSA integer average instructions.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1551964929-17845-2-git-send-email-mateja.marjanovic@rt-rk.com>
---
 .../user/ase/msa/int-average/test_msa_ave_s_b.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_s_d.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_s_h.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_s_w.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_b.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_d.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_h.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_w.c    | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_b.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_d.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_h.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_w.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_b.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_d.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_h.c   | 151 +++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_w.c   | 151 +++++++++++++++++++++
 16 files changed, 2416 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
new file mode 100644
index 0000000..675fb90
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_S.B
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
+    char *instruction_name = "AVE_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd4d4d4d4d4d4d4d4ULL, 0xd4d4d4d4d4d4d4d4ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0xe5e5e5e5e5e5e5e5ULL, 0xe5e5e5e5e5e5e5e5ULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0xf1c61bf1c61bf1c6ULL, 0x1bf1c61bf1c61bf1ULL, },
+        { 0x0d38e30d38e30d38ULL, 0xe30d38e30d38e30dULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0xf1c71cf1c71cf1c7ULL, 0x1cf1c71cf1c71cf1ULL, },
+        { 0x0e38e30e38e30e38ULL, 0xe30e38e30e38e30eULL, },
+        { 0xd4d4d4d4d4d4d4d4ULL, 0xd4d4d4d4d4d4d4d4ULL, },    /*  16  */
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0xc69cf1c69cf1c69cULL, 0xf1c69cf1c69cf1c6ULL, },
+        { 0xe30db8e30db8e30dULL, 0xb8e30db8e30db8e3ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },    /*  24  */
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1010101010101010ULL, 0x1010101010101010ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1cf1461cf1461cf1ULL, 0x461cf1461cf1461cULL, },
+        { 0x38630e38630e3863ULL, 0x0e38630e38630e38ULL, },
+        { 0xe5e5e5e5e5e5e5e5ULL, 0xe5e5e5e5e5e5e5e5ULL, },    /*  32  */
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1010101010101010ULL, 0x1010101010101010ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd7ad02d7ad02d7adULL, 0x02d7ad02d7ad02d7ULL, },
+        { 0xf41ec9f41ec9f41eULL, 0xc9f41ec9f41ec9f4ULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },    /*  40  */
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0be0350be0350be0ULL, 0x350be0350be0350bULL, },
+        { 0x2752fd2752fd2752ULL, 0xfd2752fd2752fd27ULL, },
+        { 0xf1c61bf1c61bf1c6ULL, 0x1bf1c61bf1c61bf1ULL, },    /*  48  */
+        { 0xf1c71cf1c71cf1c7ULL, 0x1cf1c71cf1c71cf1ULL, },
+        { 0xc69cf1c69cf1c69cULL, 0xf1c69cf1c69cf1c6ULL, },
+        { 0x1cf1461cf1461cf1ULL, 0x461cf1461cf1461cULL, },
+        { 0xd7ad02d7ad02d7adULL, 0x02d7ad02d7ad02d7ULL, },
+        { 0x0be0350be0350be0ULL, 0x350be0350be0350bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0d38e30d38e30d38ULL, 0xe30d38e30d38e30dULL, },    /*  56  */
+        { 0x0e38e30e38e30e38ULL, 0xe30e38e30e38e30eULL, },
+        { 0xe30db8e30db8e30dULL, 0xb8e30db8e30db8e3ULL, },
+        { 0x38630e38630e3863ULL, 0x0e38630e38630e38ULL, },
+        { 0xf41ec9f41ec9f41eULL, 0xc9f41ec9f41ec9f4ULL, },
+        { 0x2752fd2752fd2752ULL, 0xfd2752fd2752fd27ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc114f3173afa0e24ULL, 0x2e2fe33c095d0104ULL, },
+        { 0x9a62cabbf018f0e0ULL, 0x391fe82ed453ea10ULL, },
+        { 0xfc5cfe0c43491b47ULL, 0xec2cc91bd35ec9d6ULL, },
+        { 0xc114f3173afa0e24ULL, 0x2e2fe33c095d0104ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd30cd70603b1a9c4ULL, 0x1ce7c00ce0353b08ULL, },
+        { 0x35060b5855e2d42bULL, 0xcff4a1f9df401aceULL, },
+        { 0x9a62cabbf018f0e0ULL, 0x391fe82ed453ea10ULL, },    /*  72  */
+        { 0xd30cd70603b1a9c4ULL, 0x1ce7c00ce0353b08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e54e2fb0b00b6e7ULL, 0xdae4a7ebaa3603daULL, },
+        { 0xfc5cfe0c43491b47ULL, 0xec2cc91bd35ec9d6ULL, },
+        { 0x35060b5855e2d42bULL, 0xcff4a1f9df401aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
new file mode 100644
index 0000000..e87d414
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_S.D
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
+    char *instruction_name = "AVE_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd555555555555554ULL, 0xd555555555555554ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },
+        { 0xe666666666666665ULL, 0xe666666666666665ULL, },
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e38e38e38eULL, },
+        { 0xd555555555555554ULL, 0xd555555555555554ULL, },    /*  16  */
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0xc71c71c71c71c71cULL, 0xf1c71c71c71c71c6ULL, },
+        { 0xe38e38e38e38e38dULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1111111111111110ULL, 0x1111111111111110ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },
+        { 0x38e38e38e38e38e3ULL, 0x0e38e38e38e38e38ULL, },
+        { 0xe666666666666665ULL, 0xe666666666666665ULL, },    /*  32  */
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1111111111111110ULL, 0x1111111111111110ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd82d82d82d82d82dULL, 0x02d82d82d82d82d7ULL, },
+        { 0xf49f49f49f49f49eULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },    /*  40  */
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0b60b60b60b60b60ULL, 0x360b60b60b60b60bULL, },
+        { 0x27d27d27d27d27d2ULL, 0xfd27d27d27d27d27ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },    /*  48  */
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xc71c71c71c71c71cULL, 0xf1c71c71c71c71c6ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },
+        { 0xd82d82d82d82d82dULL, 0x02d82d82d82d82d7ULL, },
+        { 0x0b60b60b60b60b60ULL, 0x360b60b60b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },    /*  56  */
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e38e38e38eULL, },
+        { 0xe38e38e38e38e38dULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x0e38e38e38e38e38ULL, },
+        { 0xf49f49f49f49f49eULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x27d27d27d27d27d2ULL, 0xfd27d27d27d27d27ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },
+        { 0xfc5cfe8cc34a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f95f411aceULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },    /*  72  */
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e54e27c0c00b6e7ULL, 0xdae527ec2a3703daULL, },
+        { 0xfc5cfe8cc34a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f95f411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
new file mode 100644
index 0000000..c850543
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_S.H
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
+    char *instruction_name = "AVE_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd554d554d554d554ULL, 0xd554d554d554d554ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },
+        { 0xe665e665e665e665ULL, 0xe665e665e665e665ULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0xf1c61c71c71bf1c6ULL, 0x1c71c71bf1c61c71ULL, },
+        { 0x0e38e38d38e30e38ULL, 0xe38d38e30e38e38dULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0xf1c71c71c71cf1c7ULL, 0x1c71c71cf1c71c71ULL, },
+        { 0x0e38e38e38e30e38ULL, 0xe38e38e30e38e38eULL, },
+        { 0xd554d554d554d554ULL, 0xd554d554d554d554ULL, },    /*  16  */
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0xc71cf1c69c71c71cULL, 0xf1c69c71c71cf1c6ULL, },
+        { 0xe38db8e30e38e38dULL, 0xb8e30e38e38db8e3ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },    /*  24  */
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1110111011101110ULL, 0x1110111011101110ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1c71471cf1c61c71ULL, 0x471cf1c61c71471cULL, },
+        { 0x38e30e38638e38e3ULL, 0x0e38638e38e30e38ULL, },
+        { 0xe665e665e665e665ULL, 0xe665e665e665e665ULL, },    /*  32  */
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1110111011101110ULL, 0x1110111011101110ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd82d02d7ad82d82dULL, 0x02d7ad82d82d02d7ULL, },
+        { 0xf49ec9f41f49f49eULL, 0xc9f41f49f49ec9f4ULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },    /*  40  */
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0b60360be0b50b60ULL, 0x360be0b50b60360bULL, },
+        { 0x27d2fd27527d27d2ULL, 0xfd27527d27d2fd27ULL, },
+        { 0xf1c61c71c71bf1c6ULL, 0x1c71c71bf1c61c71ULL, },    /*  48  */
+        { 0xf1c71c71c71cf1c7ULL, 0x1c71c71cf1c71c71ULL, },
+        { 0xc71cf1c69c71c71cULL, 0xf1c69c71c71cf1c6ULL, },
+        { 0x1c71471cf1c61c71ULL, 0x471cf1c61c71471cULL, },
+        { 0xd82d02d7ad82d82dULL, 0x02d7ad82d82d02d7ULL, },
+        { 0x0b60360be0b50b60ULL, 0x360be0b50b60360bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0e38e38d38e30e38ULL, 0xe38d38e30e38e38dULL, },    /*  56  */
+        { 0x0e38e38e38e30e38ULL, 0xe38e38e30e38e38eULL, },
+        { 0xe38db8e30e38e38dULL, 0xb8e30e38e38db8e3ULL, },
+        { 0x38e30e38638e38e3ULL, 0x0e38638e38e30e38ULL, },
+        { 0xf49ec9f41f49f49eULL, 0xc9f41f49f49ec9f4ULL, },
+        { 0x27d2fd27527d27d2ULL, 0xfd27527d27d2fd27ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc214f3973afa0e24ULL, 0x2f2fe33c09dd0184ULL, },
+        { 0x9a62cabbf118f060ULL, 0x399fe92ed4d3ea90ULL, },
+        { 0xfc5cfe8c43491bc7ULL, 0xecacca1bd3dec956ULL, },
+        { 0xc214f3973afa0e24ULL, 0x2f2fe33c09dd0184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40cd78603b1a944ULL, 0x1d67c10ce0353c08ULL, },
+        { 0x36060b5855e2d4abULL, 0xd074a1f9df401aceULL, },
+        { 0x9a62cabbf118f060ULL, 0x399fe92ed4d3ea90ULL, },    /*  72  */
+        { 0xd40cd78603b1a944ULL, 0x1d67c10ce0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e54e27b0c00b6e7ULL, 0xdae4a7ebaa3603daULL, },
+        { 0xfc5cfe8c43491bc7ULL, 0xecacca1bd3dec956ULL, },
+        { 0x36060b5855e2d4abULL, 0xd074a1f9df401aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
new file mode 100644
index 0000000..3220574
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_S.W
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
+    char *instruction_name = "AVE_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd5555554d5555554ULL, 0xd5555554d5555554ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },
+        { 0xe6666665e6666665ULL, 0xe6666665e6666665ULL, },
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x1c71c71bf1c71c71ULL, },
+        { 0x0e38e38d38e38e38ULL, 0xe38e38e30e38e38dULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71cf1c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e30e38e38eULL, },
+        { 0xd5555554d5555554ULL, 0xd5555554d5555554ULL, },    /*  16  */
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0xc71c71c69c71c71cULL, 0xf1c71c71c71c71c6ULL, },
+        { 0xe38e38e30e38e38dULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1111111011111110ULL, 0x1111111011111110ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1c71c71cf1c71c71ULL, 0x471c71c61c71c71cULL, },
+        { 0x38e38e38638e38e3ULL, 0x0e38e38e38e38e38ULL, },
+        { 0xe6666665e6666665ULL, 0xe6666665e6666665ULL, },    /*  32  */
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1111111011111110ULL, 0x1111111011111110ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xd82d82d7ad82d82dULL, 0x02d82d82d82d82d7ULL, },
+        { 0xf49f49f41f49f49eULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },    /*  40  */
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0b60b60be0b60b60ULL, 0x360b60b50b60b60bULL, },
+        { 0x27d27d27527d27d2ULL, 0xfd27d27d27d27d27ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x1c71c71bf1c71c71ULL, },    /*  48  */
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71cf1c71c71ULL, },
+        { 0xc71c71c69c71c71cULL, 0xf1c71c71c71c71c6ULL, },
+        { 0x1c71c71cf1c71c71ULL, 0x471c71c61c71c71cULL, },
+        { 0xd82d82d7ad82d82dULL, 0x02d82d82d82d82d7ULL, },
+        { 0x0b60b60be0b60b60ULL, 0x360b60b50b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0e38e38d38e38e38ULL, 0xe38e38e30e38e38dULL, },    /*  56  */
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e30e38e38eULL, },
+        { 0xe38e38e30e38e38dULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x38e38e38638e38e3ULL, 0x0e38e38e38e38e38ULL, },
+        { 0xf49f49f41f49f49eULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x27d27d27527d27d2ULL, 0xfd27d27d27d27d27ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc21473973afb0e24ULL, 0x2f2f633c09dd8184ULL, },
+        { 0x9a62cabbf118f060ULL, 0x399fe92ed4d36a90ULL, },
+        { 0xfc5cfe8c434a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0xc21473973afb0e24ULL, 0x2f2f633c09dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578603b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+        { 0x9a62cabbf118f060ULL, 0x399fe92ed4d36a90ULL, },    /*  72  */
+        { 0xd40c578603b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e54e27b0c00b6e7ULL, 0xdae527ebaa3703daULL, },
+        { 0xfc5cfe8c434a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
new file mode 100644
index 0000000..c3f96a6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_U.B
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
+    char *instruction_name = "AVE_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0xd4d4d4d4d4d4d4d4ULL, 0xd4d4d4d4d4d4d4d4ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe5e5e5e5e5e5e5e5ULL, 0xe5e5e5e5e5e5e5e5ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c69bf1c69bf1c6ULL, 0x9bf1c69bf1c69bf1ULL, },
+        { 0x8db8e38db8e38db8ULL, 0xe38db8e38db8e38dULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0x71471c71471c7147ULL, 0x1c71471c71471c71ULL, },
+        { 0x0e38630e38630e38ULL, 0x630e38630e38630eULL, },
+        { 0xd4d4d4d4d4d4d4d4ULL, 0xd4d4d4d4d4d4d4d4ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6e6e6e6e6e6e6e6eULL, 0x6e6e6e6e6e6e6e6eULL, },
+        { 0xc69c71c69c71c69cULL, 0x71c69c71c69c71c6ULL, },
+        { 0x638db8638db8638dULL, 0xb8638db8638db863ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9090909090909090ULL, 0x9090909090909090ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c71469c71469c71ULL, 0x469c71469c71469cULL, },
+        { 0x38638e38638e3863ULL, 0x8e38638e38638e38ULL, },
+        { 0xe5e5e5e5e5e5e5e5ULL, 0xe5e5e5e5e5e5e5e5ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9090909090909090ULL, 0x9090909090909090ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0xd7ad82d7ad82d7adULL, 0x82d7ad82d7ad82d7ULL, },
+        { 0x749ec9749ec9749eULL, 0xc9749ec9749ec974ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0x6e6e6e6e6e6e6e6eULL, 0x6e6e6e6e6e6e6e6eULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b60358b60358b60ULL, 0x358b60358b60358bULL, },
+        { 0x27527d27527d2752ULL, 0x7d27527d27527d27ULL, },
+        { 0xf1c69bf1c69bf1c6ULL, 0x9bf1c69bf1c69bf1ULL, },    /*  48  */
+        { 0x71471c71471c7147ULL, 0x1c71471c71471c71ULL, },
+        { 0xc69c71c69c71c69cULL, 0x71c69c71c69c71c6ULL, },
+        { 0x9c71469c71469c71ULL, 0x469c71469c71469cULL, },
+        { 0xd7ad82d7ad82d7adULL, 0x82d7ad82d7ad82d7ULL, },
+        { 0x8b60358b60358b60ULL, 0x358b60358b60358bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x8db8e38db8e38db8ULL, 0xe38db8e38db8e38dULL, },    /*  56  */
+        { 0x0e38630e38630e38ULL, 0x630e38630e38630eULL, },
+        { 0x638db8638db8638dULL, 0xb8638db8638db863ULL, },
+        { 0x38638e38638e3863ULL, 0x8e38638e38638e38ULL, },
+        { 0x749ec9749ec9749eULL, 0xc9749ec9749ec974ULL, },
+        { 0x27527d27527d2752ULL, 0x7d27527d27527d27ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc19473973a7a8e24ULL, 0x2eaf633c895d8184ULL, },
+        { 0x9a62cabb70987060ULL, 0x399f68aed4536a10ULL, },
+        { 0x7c5c7e8c43499b47ULL, 0x6cac499bd35ec956ULL, },
+        { 0xc19473973a7a8e24ULL, 0x2eaf633c895d8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd38c578683b1a944ULL, 0x1ce7c08c60353b88ULL, },
+        { 0xb5860b585562d42bULL, 0x4ff4a1795f409aceULL, },
+        { 0x9a62cabb70987060ULL, 0x399f68aed4536a10ULL, },    /*  72  */
+        { 0xd38c578683b1a944ULL, 0x1ce7c08c60353b88ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e54627b8b80b667ULL, 0x5ae4a7ebaa36835aULL, },
+        { 0x7c5c7e8c43499b47ULL, 0x6cac499bd35ec956ULL, },
+        { 0xb5860b585562d42bULL, 0x4ff4a1795f409aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
new file mode 100644
index 0000000..3a78629
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_U.D
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
+    char *instruction_name = "AVE_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0xd555555555555554ULL, 0xd555555555555554ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe666666666666665ULL, 0xe666666666666665ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x9c71c71c71c71c71ULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0x638e38e38e38e38eULL, },
+        { 0xd555555555555554ULL, 0xd555555555555554ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6eeeeeeeeeeeeeeeULL, 0x6eeeeeeeeeeeeeeeULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c6ULL, },
+        { 0x638e38e38e38e38dULL, 0xb8e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9111111111111110ULL, 0x9111111111111110ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e38ULL, },
+        { 0xe666666666666665ULL, 0xe666666666666665ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9111111111111110ULL, 0x9111111111111110ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0xd82d82d82d82d82dULL, 0x82d82d82d82d82d7ULL, },
+        { 0x749f49f49f49f49eULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },
+        { 0x6eeeeeeeeeeeeeeeULL, 0x6eeeeeeeeeeeeeeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b60b60b60b60b60ULL, 0x360b60b60b60b60bULL, },
+        { 0x27d27d27d27d27d2ULL, 0x7d27d27d27d27d27ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x9c71c71c71c71c71ULL, },    /*  48  */
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c6ULL, },
+        { 0x9c71c71c71c71c71ULL, 0x471c71c71c71c71cULL, },
+        { 0xd82d82d82d82d82dULL, 0x82d82d82d82d82d7ULL, },
+        { 0x8b60b60b60b60b60ULL, 0x360b60b60b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },    /*  56  */
+        { 0x0e38e38e38e38e38ULL, 0x638e38e38e38e38eULL, },
+        { 0x638e38e38e38e38dULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x749f49f49f49f49eULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x27d27d27d27d27d2ULL, 0x7d27d27d27d27d27ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },
+        { 0x7c5cfe8cc34a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },    /*  72  */
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e54e27c0c00b6e7ULL, 0x5ae527ec2a3703daULL, },
+        { 0x7c5cfe8cc34a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
new file mode 100644
index 0000000..b7db518
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_U.H
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
+    char *instruction_name = "AVE_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0xd554d554d554d554ULL, 0xd554d554d554d554ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe665e665e665e665ULL, 0xe665e665e665e665ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c69c71c71bf1c6ULL, 0x9c71c71bf1c69c71ULL, },
+        { 0x8e38e38db8e38e38ULL, 0xe38db8e38e38e38dULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0x71c71c71471c71c7ULL, 0x1c71471c71c71c71ULL, },
+        { 0x0e38638e38e30e38ULL, 0x638e38e30e38638eULL, },
+        { 0xd554d554d554d554ULL, 0xd554d554d554d554ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6eee6eee6eee6eeeULL, 0x6eee6eee6eee6eeeULL, },
+        { 0xc71c71c69c71c71cULL, 0x71c69c71c71c71c6ULL, },
+        { 0x638db8e38e38638dULL, 0xb8e38e38638db8e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9110911091109110ULL, 0x9110911091109110ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c71471c71c69c71ULL, 0x471c71c69c71471cULL, },
+        { 0x38e38e38638e38e3ULL, 0x8e38638e38e38e38ULL, },
+        { 0xe665e665e665e665ULL, 0xe665e665e665e665ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9110911091109110ULL, 0x9110911091109110ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0xd82d82d7ad82d82dULL, 0x82d7ad82d82d82d7ULL, },
+        { 0x749ec9f49f49749eULL, 0xc9f49f49749ec9f4ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0x6eee6eee6eee6eeeULL, 0x6eee6eee6eee6eeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b60360b60b58b60ULL, 0x360b60b58b60360bULL, },
+        { 0x27d27d27527d27d2ULL, 0x7d27527d27d27d27ULL, },
+        { 0xf1c69c71c71bf1c6ULL, 0x9c71c71bf1c69c71ULL, },    /*  48  */
+        { 0x71c71c71471c71c7ULL, 0x1c71471c71c71c71ULL, },
+        { 0xc71c71c69c71c71cULL, 0x71c69c71c71c71c6ULL, },
+        { 0x9c71471c71c69c71ULL, 0x471c71c69c71471cULL, },
+        { 0xd82d82d7ad82d82dULL, 0x82d7ad82d82d82d7ULL, },
+        { 0x8b60360b60b58b60ULL, 0x360b60b58b60360bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x8e38e38db8e38e38ULL, 0xe38db8e38e38e38dULL, },    /*  56  */
+        { 0x0e38638e38e30e38ULL, 0x638e38e30e38638eULL, },
+        { 0x638db8e38e38638dULL, 0xb8e38e38638db8e3ULL, },
+        { 0x38e38e38638e38e3ULL, 0x8e38638e38e38e38ULL, },
+        { 0x749ec9f49f49749eULL, 0xc9f49f49749ec9f4ULL, },
+        { 0x27d27d27527d27d2ULL, 0x7d27527d27d27d27ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc21473973afa8e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb71187060ULL, 0x399f692ed4d36a90ULL, },
+        { 0x7c5c7e8c43499bc7ULL, 0x6cac4a1bd3dec956ULL, },
+        { 0xc21473973afa8e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578683b1a944ULL, 0x1d67c10c60353c08ULL, },
+        { 0xb6060b5855e2d4abULL, 0x5074a1f95f409aceULL, },
+        { 0x9a62cabb71187060ULL, 0x399f692ed4d36a90ULL, },    /*  72  */
+        { 0xd40c578683b1a944ULL, 0x1d67c10c60353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e54627b8c00b6e7ULL, 0x5ae4a7ebaa3683daULL, },
+        { 0x7c5c7e8c43499bc7ULL, 0x6cac4a1bd3dec956ULL, },
+        { 0xb6060b5855e2d4abULL, 0x5074a1f95f409aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
new file mode 100644
index 0000000..75e2409
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVE_U.W
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
+    char *instruction_name = "AVE_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0xd5555554d5555554ULL, 0xd5555554d5555554ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe6666665e6666665ULL, 0xe6666665e6666665ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x9c71c71bf1c71c71ULL, },
+        { 0x8e38e38db8e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },
+        { 0x71c71c71471c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0x638e38e30e38e38eULL, },
+        { 0xd5555554d5555554ULL, 0xd5555554d5555554ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6eeeeeee6eeeeeeeULL, 0x6eeeeeee6eeeeeeeULL, },
+        { 0xc71c71c69c71c71cULL, 0x71c71c71c71c71c6ULL, },
+        { 0x638e38e38e38e38dULL, 0xb8e38e38638e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9111111091111110ULL, 0x9111111091111110ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c71c71c71c71c71ULL, 0x471c71c69c71c71cULL, },
+        { 0x38e38e38638e38e3ULL, 0x8e38e38e38e38e38ULL, },
+        { 0xe6666665e6666665ULL, 0xe6666665e6666665ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9111111091111110ULL, 0x9111111091111110ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0xd82d82d7ad82d82dULL, 0x82d82d82d82d82d7ULL, },
+        { 0x749f49f49f49f49eULL, 0xc9f49f49749f49f4ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },
+        { 0x6eeeeeee6eeeeeeeULL, 0x6eeeeeee6eeeeeeeULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b60b60b60b60b60ULL, 0x360b60b58b60b60bULL, },
+        { 0x27d27d27527d27d2ULL, 0x7d27d27d27d27d27ULL, },
+        { 0xf1c71c71c71c71c6ULL, 0x9c71c71bf1c71c71ULL, },    /*  48  */
+        { 0x71c71c71471c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xc71c71c69c71c71cULL, 0x71c71c71c71c71c6ULL, },
+        { 0x9c71c71c71c71c71ULL, 0x471c71c69c71c71cULL, },
+        { 0xd82d82d7ad82d82dULL, 0x82d82d82d82d82d7ULL, },
+        { 0x8b60b60b60b60b60ULL, 0x360b60b58b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x8e38e38db8e38e38ULL, 0xe38e38e38e38e38dULL, },    /*  56  */
+        { 0x0e38e38e38e38e38ULL, 0x638e38e30e38e38eULL, },
+        { 0x638e38e38e38e38dULL, 0xb8e38e38638e38e3ULL, },
+        { 0x38e38e38638e38e3ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x749f49f49f49f49eULL, 0xc9f49f49749f49f4ULL, },
+        { 0x27d27d27527d27d2ULL, 0x7d27d27d27d27d27ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc21473973afb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92ed4d36a90ULL, },
+        { 0x7c5cfe8c434a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xc21473973afb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578683b1a944ULL, 0x1d68410c60353c08ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92ed4d36a90ULL, },    /*  72  */
+        { 0xd40c578683b1a944ULL, 0x1d68410c60353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e54e27b8c00b6e7ULL, 0x5ae527ebaa3703daULL, },
+        { 0x7c5cfe8c434a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVE_U_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
new file mode 100644
index 0000000..59bba28
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_S.B
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
+    char *instruction_name = "AVER_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0xf1c71cf1c71cf1c7ULL, 0x1cf1c71cf1c71cf1ULL, },
+        { 0x0e38e30e38e30e38ULL, 0xe30e38e30e38e30eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },
+        { 0x2b2b2b2b2b2b2b2bULL, 0x2b2b2b2b2b2b2b2bULL, },
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },
+        { 0x1a1a1a1a1a1a1a1aULL, 0x1a1a1a1a1a1a1a1aULL, },
+        { 0xf2c71cf2c71cf2c7ULL, 0x1cf2c71cf2c71cf2ULL, },
+        { 0x0e39e40e39e40e39ULL, 0xe40e39e40e39e40eULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },    /*  16  */
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xefefefefefefefefULL, 0xefefefefefefefefULL, },
+        { 0xc79cf1c79cf1c79cULL, 0xf1c79cf1c79cf1c7ULL, },
+        { 0xe30eb9e30eb9e30eULL, 0xb9e30eb9e30eb9e3ULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },    /*  24  */
+        { 0x2b2b2b2b2b2b2b2bULL, 0x2b2b2b2b2b2b2b2bULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1cf2471cf2471cf2ULL, 0x471cf2471cf2471cULL, },
+        { 0x39630e39630e3963ULL, 0x0e39630e39630e39ULL, },
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },    /*  32  */
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd8ad02d8ad02d8adULL, 0x02d8ad02d8ad02d8ULL, },
+        { 0xf41fcaf41fcaf41fULL, 0xcaf41fcaf41fcaf4ULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },    /*  40  */
+        { 0x1a1a1a1a1a1a1a1aULL, 0x1a1a1a1a1a1a1a1aULL, },
+        { 0xefefefefefefefefULL, 0xefefefefefefefefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0be1360be1360be1ULL, 0x360be1360be1360bULL, },
+        { 0x2852fd2852fd2852ULL, 0xfd2852fd2852fd28ULL, },
+        { 0xf1c71cf1c71cf1c7ULL, 0x1cf1c71cf1c71cf1ULL, },    /*  48  */
+        { 0xf2c71cf2c71cf2c7ULL, 0x1cf2c71cf2c71cf2ULL, },
+        { 0xc79cf1c79cf1c79cULL, 0xf1c79cf1c79cf1c7ULL, },
+        { 0x1cf2471cf2471cf2ULL, 0x471cf2471cf2471cULL, },
+        { 0xd8ad02d8ad02d8adULL, 0x02d8ad02d8ad02d8ULL, },
+        { 0x0be1360be1360be1ULL, 0x360be1360be1360bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0e38e30e38e30e38ULL, 0xe30e38e30e38e30eULL, },    /*  56  */
+        { 0x0e39e40e39e40e39ULL, 0xe40e39e40e39e40eULL, },
+        { 0xe30eb9e30eb9e30eULL, 0xb9e30eb9e30eb9e3ULL, },
+        { 0x39630e39630e3963ULL, 0x0e39630e39630e39ULL, },
+        { 0xf41fcaf41fcaf41fULL, 0xcaf41fcaf41fcaf4ULL, },
+        { 0x2852fd2852fd2852ULL, 0xfd2852fd2852fd28ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc214f3183bfb0e24ULL, 0x2f2fe33c0a5d0104ULL, },
+        { 0x9a62cabbf119f0e0ULL, 0x3920e92fd553eb10ULL, },
+        { 0xfc5dfe0d434a1c47ULL, 0xec2cca1bd45fc9d6ULL, },
+        { 0xc214f3183bfb0e24ULL, 0x2f2fe33c0a5d0104ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40cd70703b1a9c4ULL, 0x1de8c10de0353c08ULL, },
+        { 0x36070b5856e2d52bULL, 0xd0f4a2f9df411aceULL, },
+        { 0x9a62cabbf119f0e0ULL, 0x3920e92fd553eb10ULL, },    /*  72  */
+        { 0xd40cd70703b1a9c4ULL, 0x1de8c10de0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e55e2fc0c00b7e7ULL, 0xdae5a7ecaa3704daULL, },
+        { 0xfc5dfe0d434a1c47ULL, 0xec2cca1bd45fc9d6ULL, },
+        { 0x36070b5856e2d52bULL, 0xd0f4a2f9df411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
new file mode 100644
index 0000000..435c09f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_S.D
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
+    char *instruction_name = "AVER_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71c71c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e38e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },
+        { 0x2aaaaaaaaaaaaaabULL, 0x2aaaaaaaaaaaaaabULL, },
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },
+        { 0x199999999999999aULL, 0x199999999999999aULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x0e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },    /*  16  */
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeeeeeeeeeeeeeefULL, 0xeeeeeeeeeeeeeeefULL, },
+        { 0xc71c71c71c71c71cULL, 0xf1c71c71c71c71c7ULL, },
+        { 0xe38e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x2aaaaaaaaaaaaaaaULL, 0x2aaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaaaaaaaaaabULL, 0x2aaaaaaaaaaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x471c71c71c71c71cULL, },
+        { 0x38e38e38e38e38e3ULL, 0x0e38e38e38e38e39ULL, },
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },    /*  32  */
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd82d82d82d82d82dULL, 0x02d82d82d82d82d8ULL, },
+        { 0xf49f49f49f49f49fULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x1999999999999999ULL, 0x1999999999999999ULL, },    /*  40  */
+        { 0x199999999999999aULL, 0x199999999999999aULL, },
+        { 0xeeeeeeeeeeeeeeefULL, 0xeeeeeeeeeeeeeeefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0b60b60b60b60b61ULL, 0x360b60b60b60b60bULL, },
+        { 0x27d27d27d27d27d2ULL, 0xfd27d27d27d27d28ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71c71c71c71ULL, },    /*  48  */
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0xf1c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x471c71c71c71c71cULL, },
+        { 0xd82d82d82d82d82dULL, 0x02d82d82d82d82d8ULL, },
+        { 0x0b60b60b60b60b61ULL, 0x360b60b60b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e38e38e38eULL, },    /*  56  */
+        { 0x0e38e38e38e38e39ULL, 0xe38e38e38e38e38eULL, },
+        { 0xe38e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x0e38e38e38e38e39ULL, },
+        { 0xf49f49f49f49f49fULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x27d27d27d27d27d2ULL, 0xfd27d27d27d27d28ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },
+        { 0xfc5cfe8cc34a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f95f411aceULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },    /*  72  */
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e54e27c0c00b6e7ULL, 0xdae527ec2a3703daULL, },
+        { 0xfc5cfe8cc34a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f95f411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
new file mode 100644
index 0000000..0902e50
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_S.H
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
+    char *instruction_name = "AVER_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0xf1c71c71c71cf1c7ULL, 0x1c71c71cf1c71c71ULL, },
+        { 0x0e38e38e38e30e38ULL, 0xe38e38e30e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },
+        { 0x2aab2aab2aab2aabULL, 0x2aab2aab2aab2aabULL, },
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },
+        { 0x199a199a199a199aULL, 0x199a199a199a199aULL, },
+        { 0xf1c71c72c71cf1c7ULL, 0x1c72c71cf1c71c72ULL, },
+        { 0x0e39e38e38e40e39ULL, 0xe38e38e40e39e38eULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },    /*  16  */
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeefeeefeeefeeefULL, 0xeeefeeefeeefeeefULL, },
+        { 0xc71cf1c79c71c71cULL, 0xf1c79c71c71cf1c7ULL, },
+        { 0xe38eb8e30e39e38eULL, 0xb8e30e39e38eb8e3ULL, },
+        { 0x2aaa2aaa2aaa2aaaULL, 0x2aaa2aaa2aaa2aaaULL, },    /*  24  */
+        { 0x2aab2aab2aab2aabULL, 0x2aab2aab2aab2aabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1c72471cf1c71c72ULL, 0x471cf1c71c72471cULL, },
+        { 0x38e30e39638e38e3ULL, 0x0e39638e38e30e39ULL, },
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },    /*  32  */
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd82d02d8ad82d82dULL, 0x02d8ad82d82d02d8ULL, },
+        { 0xf49fc9f41f4af49fULL, 0xc9f41f4af49fc9f4ULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },    /*  40  */
+        { 0x199a199a199a199aULL, 0x199a199a199a199aULL, },
+        { 0xeeefeeefeeefeeefULL, 0xeeefeeefeeefeeefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0b61360be0b60b61ULL, 0x360be0b60b61360bULL, },
+        { 0x27d2fd28527d27d2ULL, 0xfd28527d27d2fd28ULL, },
+        { 0xf1c71c71c71cf1c7ULL, 0x1c71c71cf1c71c71ULL, },    /*  48  */
+        { 0xf1c71c72c71cf1c7ULL, 0x1c72c71cf1c71c72ULL, },
+        { 0xc71cf1c79c71c71cULL, 0xf1c79c71c71cf1c7ULL, },
+        { 0x1c72471cf1c71c72ULL, 0x471cf1c71c72471cULL, },
+        { 0xd82d02d8ad82d82dULL, 0x02d8ad82d82d02d8ULL, },
+        { 0x0b61360be0b60b61ULL, 0x360be0b60b61360bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0e38e38e38e30e38ULL, 0xe38e38e30e38e38eULL, },    /*  56  */
+        { 0x0e39e38e38e40e39ULL, 0xe38e38e40e39e38eULL, },
+        { 0xe38eb8e30e39e38eULL, 0xb8e30e39e38eb8e3ULL, },
+        { 0x38e30e39638e38e3ULL, 0x0e39638e38e30e39ULL, },
+        { 0xf49fc9f41f4af49fULL, 0xc9f41f4af49fc9f4ULL, },
+        { 0x27d2fd28527d27d2ULL, 0xfd28527d27d2fd28ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc214f3983afb0e24ULL, 0x2f2fe33c09dd0184ULL, },
+        { 0x9a62cabbf119f060ULL, 0x39a0e92fd4d3ea90ULL, },
+        { 0xfc5dfe8d434a1bc7ULL, 0xecacca1bd3dfc956ULL, },
+        { 0xc214f3983afb0e24ULL, 0x2f2fe33c09dd0184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40cd78703b1a944ULL, 0x1d68c10de0353c08ULL, },
+        { 0x36070b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+        { 0x9a62cabbf119f060ULL, 0x39a0e92fd4d3ea90ULL, },    /*  72  */
+        { 0xd40cd78703b1a944ULL, 0x1d68c10de0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e55e27c0c00b6e7ULL, 0xdae5a7ecaa3703daULL, },
+        { 0xfc5dfe8d434a1bc7ULL, 0xecacca1bd3dfc956ULL, },
+        { 0x36070b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
new file mode 100644
index 0000000..31f4553
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_S.W
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
+    char *instruction_name = "AVER_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71cf1c71c71ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e30e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },
+        { 0x2aaaaaab2aaaaaabULL, 0x2aaaaaab2aaaaaabULL, },
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },
+        { 0x1999999a1999999aULL, 0x1999999a1999999aULL, },
+        { 0xf1c71c72c71c71c7ULL, 0x1c71c71cf1c71c72ULL, },
+        { 0x0e38e38e38e38e39ULL, 0xe38e38e40e38e38eULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },    /*  16  */
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0xeeeeeeefeeeeeeefULL, 0xeeeeeeefeeeeeeefULL, },
+        { 0xc71c71c79c71c71cULL, 0xf1c71c71c71c71c7ULL, },
+        { 0xe38e38e30e38e38eULL, 0xb8e38e39e38e38e3ULL, },
+        { 0x2aaaaaaa2aaaaaaaULL, 0x2aaaaaaa2aaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaab2aaaaaabULL, 0x2aaaaaab2aaaaaabULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1c71c71cf1c71c72ULL, 0x471c71c71c71c71cULL, },
+        { 0x38e38e39638e38e3ULL, 0x0e38e38e38e38e39ULL, },
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },    /*  32  */
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xd82d82d8ad82d82dULL, 0x02d82d82d82d82d8ULL, },
+        { 0xf49f49f41f49f49fULL, 0xc9f49f4af49f49f4ULL, },
+        { 0x1999999919999999ULL, 0x1999999919999999ULL, },    /*  40  */
+        { 0x1999999a1999999aULL, 0x1999999a1999999aULL, },
+        { 0xeeeeeeefeeeeeeefULL, 0xeeeeeeefeeeeeeefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0b60b60be0b60b61ULL, 0x360b60b60b60b60bULL, },
+        { 0x27d27d28527d27d2ULL, 0xfd27d27d27d27d28ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x1c71c71cf1c71c71ULL, },    /*  48  */
+        { 0xf1c71c72c71c71c7ULL, 0x1c71c71cf1c71c72ULL, },
+        { 0xc71c71c79c71c71cULL, 0xf1c71c71c71c71c7ULL, },
+        { 0x1c71c71cf1c71c72ULL, 0x471c71c71c71c71cULL, },
+        { 0xd82d82d8ad82d82dULL, 0x02d82d82d82d82d8ULL, },
+        { 0x0b60b60be0b60b61ULL, 0x360b60b60b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0e38e38e38e38e38ULL, 0xe38e38e30e38e38eULL, },    /*  56  */
+        { 0x0e38e38e38e38e39ULL, 0xe38e38e40e38e38eULL, },
+        { 0xe38e38e30e38e38eULL, 0xb8e38e39e38e38e3ULL, },
+        { 0x38e38e39638e38e3ULL, 0x0e38e38e38e38e39ULL, },
+        { 0xf49f49f41f49f49fULL, 0xc9f49f4af49f49f4ULL, },
+        { 0x27d27d28527d27d2ULL, 0xfd27d27d27d27d28ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc21473983afb0e24ULL, 0x2f2f633c09dd8184ULL, },
+        { 0x9a62cabbf118f060ULL, 0x399fe92fd4d36a90ULL, },
+        { 0xfc5cfe8d434a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0xc21473983afb0e24ULL, 0x2f2f633c09dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578703b1a944ULL, 0x1d68410de0353c08ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+        { 0x9a62cabbf118f060ULL, 0x399fe92fd4d36a90ULL, },    /*  72  */
+        { 0xd40c578703b1a944ULL, 0x1d68410de0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x0e54e27c0c00b6e7ULL, 0xdae527ecaa3703daULL, },
+        { 0xfc5cfe8d434a1bc7ULL, 0xecac4a1bd3df4956ULL, },
+        { 0x36068b5855e2d4abULL, 0xd074a1f9df411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_S_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
new file mode 100644
index 0000000..8aa7ec6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_U.B
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
+    char *instruction_name = "AVER_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c79cf1c79cf1c7ULL, 0x9cf1c79cf1c79cf1ULL, },
+        { 0x8eb8e38eb8e38eb8ULL, 0xe38eb8e38eb8e38eULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2b2b2b2b2b2b2b2bULL, 0x2b2b2b2b2b2b2b2bULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x1a1a1a1a1a1a1a1aULL, 0x1a1a1a1a1a1a1a1aULL, },
+        { 0x72471c72471c7247ULL, 0x1c72471c72471c72ULL, },
+        { 0x0e39640e39640e39ULL, 0x640e39640e39640eULL, },
+        { 0xd5d5d5d5d5d5d5d5ULL, 0xd5d5d5d5d5d5d5d5ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6f6f6f6f6f6f6f6fULL, 0x6f6f6f6f6f6f6f6fULL, },
+        { 0xc79c71c79c71c79cULL, 0x71c79c71c79c71c7ULL, },
+        { 0x638eb9638eb9638eULL, 0xb9638eb9638eb963ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2b2b2b2b2b2b2b2bULL, 0x2b2b2b2b2b2b2b2bULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9191919191919191ULL, 0x9191919191919191ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c72479c72479c72ULL, 0x479c72479c72479cULL, },
+        { 0x39638e39638e3963ULL, 0x8e39638e39638e39ULL, },
+        { 0xe6e6e6e6e6e6e6e6ULL, 0xe6e6e6e6e6e6e6e6ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9191919191919191ULL, 0x9191919191919191ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xd8ad82d8ad82d8adULL, 0x82d8ad82d8ad82d8ULL, },
+        { 0x749fca749fca749fULL, 0xca749fca749fca74ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x1a1a1a1a1a1a1a1aULL, 0x1a1a1a1a1a1a1a1aULL, },
+        { 0x6f6f6f6f6f6f6f6fULL, 0x6f6f6f6f6f6f6f6fULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b61368b61368b61ULL, 0x368b61368b61368bULL, },
+        { 0x28527d28527d2852ULL, 0x7d28527d28527d28ULL, },
+        { 0xf1c79cf1c79cf1c7ULL, 0x9cf1c79cf1c79cf1ULL, },    /*  48  */
+        { 0x72471c72471c7247ULL, 0x1c72471c72471c72ULL, },
+        { 0xc79c71c79c71c79cULL, 0x71c79c71c79c71c7ULL, },
+        { 0x9c72479c72479c72ULL, 0x479c72479c72479cULL, },
+        { 0xd8ad82d8ad82d8adULL, 0x82d8ad82d8ad82d8ULL, },
+        { 0x8b61368b61368b61ULL, 0x368b61368b61368bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x8eb8e38eb8e38eb8ULL, 0xe38eb8e38eb8e38eULL, },    /*  56  */
+        { 0x0e39640e39640e39ULL, 0x640e39640e39640eULL, },
+        { 0x638eb9638eb9638eULL, 0xb9638eb9638eb963ULL, },
+        { 0x39638e39638e3963ULL, 0x8e39638e39638e39ULL, },
+        { 0x749fca749fca749fULL, 0xca749fca749fca74ULL, },
+        { 0x28527d28527d2852ULL, 0x7d28527d28527d28ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc29473983b7b8e24ULL, 0x2faf633c8a5d8184ULL, },
+        { 0x9a62cabb71997060ULL, 0x39a069afd5536b10ULL, },
+        { 0x7c5d7e8d434a9c47ULL, 0x6cac4a9bd45fc956ULL, },
+        { 0xc29473983b7b8e24ULL, 0x2faf633c8a5d8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd48c578783b1a944ULL, 0x1de8c18d60353c88ULL, },
+        { 0xb6870b585662d52bULL, 0x50f4a2795f419aceULL, },
+        { 0x9a62cabb71997060ULL, 0x39a069afd5536b10ULL, },    /*  72  */
+        { 0xd48c578783b1a944ULL, 0x1de8c18d60353c88ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e55627c8c80b767ULL, 0x5ae5a7ecaa37845aULL, },
+        { 0x7c5d7e8d434a9c47ULL, 0x6cac4a9bd45fc956ULL, },
+        { 0xb6870b585662d52bULL, 0x50f4a2795f419aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
new file mode 100644
index 0000000..9b16e12
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_U.D
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
+    char *instruction_name = "AVER_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x9c71c71c71c71c71ULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38eULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2aaaaaaaaaaaaaabULL, 0x2aaaaaaaaaaaaaabULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x199999999999999aULL, 0x199999999999999aULL, },
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x0e38e38e38e38e39ULL, 0x638e38e38e38e38eULL, },
+        { 0xd555555555555555ULL, 0xd555555555555555ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6eeeeeeeeeeeeeefULL, 0x6eeeeeeeeeeeeeefULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x638e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaaaaaaaaaabULL, 0x2aaaaaaaaaaaaaabULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9111111111111111ULL, 0x9111111111111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c71c71c71c71c72ULL, 0x471c71c71c71c71cULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xe666666666666666ULL, 0xe666666666666666ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9111111111111111ULL, 0x9111111111111111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xd82d82d82d82d82dULL, 0x82d82d82d82d82d8ULL, },
+        { 0x749f49f49f49f49fULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x199999999999999aULL, 0x199999999999999aULL, },
+        { 0x6eeeeeeeeeeeeeefULL, 0x6eeeeeeeeeeeeeefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b60b60b60b60b61ULL, 0x360b60b60b60b60bULL, },
+        { 0x27d27d27d27d27d2ULL, 0x7d27d27d27d27d28ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x9c71c71c71c71c71ULL, },    /*  48  */
+        { 0x71c71c71c71c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x9c71c71c71c71c72ULL, 0x471c71c71c71c71cULL, },
+        { 0xd82d82d82d82d82dULL, 0x82d82d82d82d82d8ULL, },
+        { 0x8b60b60b60b60b61ULL, 0x360b60b60b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38eULL, },    /*  56  */
+        { 0x0e38e38e38e38e39ULL, 0x638e38e38e38e38eULL, },
+        { 0x638e38e38e38e38eULL, 0xb8e38e38e38e38e3ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x749f49f49f49f49fULL, 0xc9f49f49f49f49f4ULL, },
+        { 0x27d27d27d27d27d2ULL, 0x7d27d27d27d27d28ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },
+        { 0x7c5cfe8cc34a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xc2147397bafb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92f54d36a90ULL, },    /*  72  */
+        { 0xd40c578703b1a944ULL, 0x1d68410ce0353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e54e27c0c00b6e7ULL, 0x5ae527ec2a3703daULL, },
+        { 0x7c5cfe8cc34a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
new file mode 100644
index 0000000..191e4ac
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_U.H
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
+    char *instruction_name = "AVER_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c79c71c71cf1c7ULL, 0x9c71c71cf1c79c71ULL, },
+        { 0x8e38e38eb8e38e38ULL, 0xe38eb8e38e38e38eULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2aab2aab2aab2aabULL, 0x2aab2aab2aab2aabULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x199a199a199a199aULL, 0x199a199a199a199aULL, },
+        { 0x71c71c72471c71c7ULL, 0x1c72471c71c71c72ULL, },
+        { 0x0e39638e38e40e39ULL, 0x638e38e40e39638eULL, },
+        { 0xd555d555d555d555ULL, 0xd555d555d555d555ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6eef6eef6eef6eefULL, 0x6eef6eef6eef6eefULL, },
+        { 0xc71c71c79c71c71cULL, 0x71c79c71c71c71c7ULL, },
+        { 0x638eb8e38e39638eULL, 0xb8e38e39638eb8e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aab2aab2aab2aabULL, 0x2aab2aab2aab2aabULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9111911191119111ULL, 0x9111911191119111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c72471c71c79c72ULL, 0x471c71c79c72471cULL, },
+        { 0x38e38e39638e38e3ULL, 0x8e39638e38e38e39ULL, },
+        { 0xe666e666e666e666ULL, 0xe666e666e666e666ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9111911191119111ULL, 0x9111911191119111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xd82d82d8ad82d82dULL, 0x82d8ad82d82d82d8ULL, },
+        { 0x749fc9f49f4a749fULL, 0xc9f49f4a749fc9f4ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x199a199a199a199aULL, 0x199a199a199a199aULL, },
+        { 0x6eef6eef6eef6eefULL, 0x6eef6eef6eef6eefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b61360b60b68b61ULL, 0x360b60b68b61360bULL, },
+        { 0x27d27d28527d27d2ULL, 0x7d28527d27d27d28ULL, },
+        { 0xf1c79c71c71cf1c7ULL, 0x9c71c71cf1c79c71ULL, },    /*  48  */
+        { 0x71c71c72471c71c7ULL, 0x1c72471c71c71c72ULL, },
+        { 0xc71c71c79c71c71cULL, 0x71c79c71c71c71c7ULL, },
+        { 0x9c72471c71c79c72ULL, 0x471c71c79c72471cULL, },
+        { 0xd82d82d8ad82d82dULL, 0x82d8ad82d82d82d8ULL, },
+        { 0x8b61360b60b68b61ULL, 0x360b60b68b61360bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x8e38e38eb8e38e38ULL, 0xe38eb8e38e38e38eULL, },    /*  56  */
+        { 0x0e39638e38e40e39ULL, 0x638e38e40e39638eULL, },
+        { 0x638eb8e38e39638eULL, 0xb8e38e39638eb8e3ULL, },
+        { 0x38e38e39638e38e3ULL, 0x8e39638e38e38e39ULL, },
+        { 0x749fc9f49f4a749fULL, 0xc9f49f4a749fc9f4ULL, },
+        { 0x27d27d28527d27d2ULL, 0x7d28527d27d27d28ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc21473983afb8e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb71197060ULL, 0x39a0692fd4d36a90ULL, },
+        { 0x7c5d7e8d434a9bc7ULL, 0x6cac4a1bd3dfc956ULL, },
+        { 0xc21473983afb8e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578783b1a944ULL, 0x1d68c10d60353c08ULL, },
+        { 0xb6070b5855e2d4abULL, 0x5074a1f95f419aceULL, },
+        { 0x9a62cabb71197060ULL, 0x39a0692fd4d36a90ULL, },    /*  72  */
+        { 0xd40c578783b1a944ULL, 0x1d68c10d60353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e55627c8c00b6e7ULL, 0x5ae5a7ecaa3783daULL, },
+        { 0x7c5d7e8d434a9bc7ULL, 0x6cac4a1bd3dfc956ULL, },
+        { 0xb6070b5855e2d4abULL, 0x5074a1f95f419aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
new file mode 100644
index 0000000..e0d6b17
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction AVER_U.W
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
+    char *instruction_name = "AVER_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x9c71c71cf1c71c71ULL, },
+        { 0x8e38e38eb8e38e38ULL, 0xe38e38e38e38e38eULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x2aaaaaab2aaaaaabULL, 0x2aaaaaab2aaaaaabULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x1999999a1999999aULL, 0x1999999a1999999aULL, },
+        { 0x71c71c72471c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0x0e38e38e38e38e39ULL, 0x638e38e40e38e38eULL, },
+        { 0xd5555555d5555555ULL, 0xd5555555d5555555ULL, },    /*  16  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x6eeeeeef6eeeeeefULL, 0x6eeeeeef6eeeeeefULL, },
+        { 0xc71c71c79c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x638e38e38e38e38eULL, 0xb8e38e39638e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x2aaaaaab2aaaaaabULL, 0x2aaaaaab2aaaaaabULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x9111111191111111ULL, 0x9111111191111111ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x9c71c71c71c71c72ULL, 0x471c71c79c71c71cULL, },
+        { 0x38e38e39638e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0xe6666666e6666666ULL, 0xe6666666e6666666ULL, },    /*  32  */
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xbbbbbbbbbbbbbbbbULL, 0xbbbbbbbbbbbbbbbbULL, },
+        { 0x9111111191111111ULL, 0x9111111191111111ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xd82d82d8ad82d82dULL, 0x82d82d82d82d82d8ULL, },
+        { 0x749f49f49f49f49fULL, 0xc9f49f4a749f49f4ULL, },
+        { 0x9999999999999999ULL, 0x9999999999999999ULL, },    /*  40  */
+        { 0x1999999a1999999aULL, 0x1999999a1999999aULL, },
+        { 0x6eeeeeef6eeeeeefULL, 0x6eeeeeef6eeeeeefULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8b60b60b60b60b61ULL, 0x360b60b68b60b60bULL, },
+        { 0x27d27d28527d27d2ULL, 0x7d27d27d27d27d28ULL, },
+        { 0xf1c71c71c71c71c7ULL, 0x9c71c71cf1c71c71ULL, },    /*  48  */
+        { 0x71c71c72471c71c7ULL, 0x1c71c71c71c71c72ULL, },
+        { 0xc71c71c79c71c71cULL, 0x71c71c71c71c71c7ULL, },
+        { 0x9c71c71c71c71c72ULL, 0x471c71c79c71c71cULL, },
+        { 0xd82d82d8ad82d82dULL, 0x82d82d82d82d82d8ULL, },
+        { 0x8b60b60b60b60b61ULL, 0x360b60b68b60b60bULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x8e38e38eb8e38e38ULL, 0xe38e38e38e38e38eULL, },    /*  56  */
+        { 0x0e38e38e38e38e39ULL, 0x638e38e40e38e38eULL, },
+        { 0x638e38e38e38e38eULL, 0xb8e38e39638e38e3ULL, },
+        { 0x38e38e39638e38e3ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x749f49f49f49f49fULL, 0xc9f49f4a749f49f4ULL, },
+        { 0x27d27d28527d27d2ULL, 0x7d27d27d27d27d28ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xc21473983afb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92fd4d36a90ULL, },
+        { 0x7c5cfe8d434a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xc21473983afb0e24ULL, 0x2f2f633c89dd8184ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xd40c578783b1a944ULL, 0x1d68410d60353c08ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+        { 0x9a62cabb7118f060ULL, 0x399fe92fd4d36a90ULL, },    /*  72  */
+        { 0xd40c578783b1a944ULL, 0x1d68410d60353c08ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x8e54e27c8c00b6e7ULL, 0x5ae527ecaa3703daULL, },
+        { 0x7c5cfe8d434a1bc7ULL, 0x6cac4a1bd3df4956ULL, },
+        { 0xb6068b5855e2d4abULL, 0x5074a1f95f411aceULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_AVER_U_W(b128_random[i], b128_random[j],
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
