Received: from eggs.gnu.org ([209.51.188.92]:52841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0sZN-0005RS-Cy
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h0sZ9-0006ip-1q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:44:09 -0500
Received: from mail-eopbgr770134.outbound.protection.outlook.com
	([40.107.77.134]:49424
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h0sZ8-0006az-95
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:43:54 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 4 Mar 2019 18:43:47 +0000
Message-ID: <BN6PR2201MB1251CCD7F4C121FB63C4645BC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1551718283-4487-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1551718283-4487-3-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] target/mips: Tests for binary integer
 MSA instruction (add, adds, hadd...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH 2/2] target/mips: Tests for binary integer MSA instructio=
n (add, adds, hadd...)
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> These are the regression tests for MSA binary operations.
> Various flavors of instruction add.

The commit message should be a little improved, otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

________________________________________
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Sent: Monday, March 4, 2019 5:51:23 PM
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
Subject: [PATCH 2/2] target/mips: Tests for binary integer MSA instruction =
(add, adds, hadd...)

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

These are the regression tests for MSA binary operations.
Various flavors of instruction add.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  | 151 +++++++++++++++++=
++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  | 151 +++++++++++++++++=
++++
 26 files changed, 3926 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c

diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests=
/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
new file mode 100644
index 0000000..325c28c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADD_A.B
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADD_A.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },    /*   0  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x5757575757575757ULL, 0x5757575757575757ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x3535353535353535ULL, 0x3535353535353535ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x1e73391e73391e73ULL, 0x391e73391e73391eULL, },
+        { 0x1d723a1d723a1d72ULL, 0x3a1d723a1d723a1dULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x5757575757575757ULL, 0x5757575757575757ULL, },    /*  16  */
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0xacacacacacacacacULL, 0xacacacacacacacacULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0x8a8a8a8a8a8a8a8aULL, 0x8a8a8a8a8a8a8a8aULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x73c88e73c88e73c8ULL, 0x8e73c88e73c88e73ULL, },
+        { 0x72c78f72c78f72c7ULL, 0x8f72c78f72c78f72ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xababababababababULL, 0xababababababababULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x72c78d72c78d72c7ULL, 0x8d72c78d72c78d72ULL, },
+        { 0x71c68e71c68e71c6ULL, 0x8e71c68e71c68e71ULL, },
+        { 0x3535353535353535ULL, 0x3535353535353535ULL, },    /*  32  */
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x8a8a8a8a8a8a8a8aULL, 0x8a8a8a8a8a8a8a8aULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x6868686868686868ULL, 0x6868686868686868ULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x51a66c51a66c51a6ULL, 0x6c51a66c51a66c51ULL, },
+        { 0x50a56d50a56d50a5ULL, 0x6d50a56d50a56d50ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8989898989898989ULL, 0x8989898989898989ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x50a56b50a56b50a5ULL, 0x6b50a56b50a56b50ULL, },
+        { 0x4fa46c4fa46c4fa4ULL, 0x6c4fa46c4fa46c4fULL, },
+        { 0x1e73391e73391e73ULL, 0x391e73391e73391eULL, },    /*  48  */
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x73c88e73c88e73c8ULL, 0x8e73c88e73c88e73ULL, },
+        { 0x72c78d72c78d72c7ULL, 0x8d72c78d72c78d72ULL, },
+        { 0x51a66c51a66c51a6ULL, 0x6c51a66c51a66c51ULL, },
+        { 0x50a56b50a56b50a5ULL, 0x6b50a56b50a56b50ULL, },
+        { 0x3ae4703ae4703ae4ULL, 0x703ae4703ae4703aULL, },
+        { 0x39e37139e37139e3ULL, 0x7139e37139e37139ULL, },
+        { 0x1d723a1d723a1d72ULL, 0x3a1d723a1d723a1dULL, },    /*  56  */
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x72c78f72c78f72c7ULL, 0x8f72c78f72c78f72ULL, },
+        { 0x71c68e71c68e71c6ULL, 0x8e71c68e71c68e71ULL, },
+        { 0x50a56d50a56d50a5ULL, 0x6d50a56d50a56d50ULL, },
+        { 0x4fa46c4fa46c4fa4ULL, 0x6c4fa46c4fa46c4fULL, },
+        { 0x39e37139e37139e3ULL, 0x7139e37139e37139ULL, },
+        { 0x38e27238e27238e2ULL, 0x7238e27238e27238ULL, },
+        { 0xf0d4346850c4aa80ULL, 0x96ce16bc04f6a018ULL, },    /*  64  */
+        { 0x7dac1a9775cf8e48ULL, 0x5d70507817baa210ULL, },
+        { 0xccc46c8a6f93cac0ULL, 0x728f455f57a67520ULL, },
+        { 0xe8b930818693738eULL, 0xbe76838659bd6e6cULL, },
+        { 0x7dac1a9775cf8e48ULL, 0x5d70507817baa210ULL, },
+        { 0x0a8400c69ada7210ULL, 0x24128a342a7ea408ULL, },
+        { 0x599c52b9949eae88ULL, 0x39317f1b6a6a7718ULL, },
+        { 0x759116b0ab9e5756ULL, 0x8518bd426c817064ULL, },
+        { 0xccc46c8a6f93cac0ULL, 0x728f455f57a67520ULL, },    /*  72  */
+        { 0x599c52b9949eae88ULL, 0x39317f1b6a6a7718ULL, },
+        { 0xa8b4a4ac8e62ea00ULL, 0x4e507402aa564a28ULL, },
+        { 0xc4a968a3a56293ceULL, 0x9a37b229ac6d4374ULL, },
+        { 0xe8b930818693738eULL, 0xbe76838659bd6e6cULL, },
+        { 0x759116b0ab9e5756ULL, 0x8518bd426c817064ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests=
/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
new file mode 100644
index 0000000..7ca73f2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADD_A.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADD_A.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x5555555555555557ULL, 0x5555555555555557ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x3333333333333335ULL, 0x3333333333333335ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x1c71c71c71c71c73ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e5ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x5555555555555557ULL, 0x5555555555555557ULL, },    /*  16  */
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0xaaaaaaaaaaaaaaacULL, 0xaaaaaaaaaaaaaaacULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0x888888888888888aULL, 0x888888888888888aULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x71c71c71c71c71c8ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x8e38e38e38e38e3aULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaabULL, 0xaaaaaaaaaaaaaaabULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x3333333333333335ULL, 0x3333333333333335ULL, },    /*  32  */
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x888888888888888aULL, 0x888888888888888aULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x6666666666666668ULL, 0x6666666666666668ULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x4fa4fa4fa4fa4fa6ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c18ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888888888889ULL, 0x8888888888888889ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x1c71c71c71c71c73ULL, 0x38e38e38e38e38e4ULL, },    /*  48  */
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x71c71c71c71c71c8ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x4fa4fa4fa4fa4fa6ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c16ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x71c71c71c71c71c6ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e5ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x8e38e38e38e38e3aULL, },
+        { 0x71c71c71c71c71c6ULL, 0x8e38e38e38e38e39ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c18ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x38e38e38e38e38e2ULL, 0x71c71c71c71c71c8ULL, },
+        { 0xef2a3267af3b5580ULL, 0x96ce16bdfcf76018ULL, },    /*  64  */
+        { 0x7bd718d08a09e3b8ULL, 0x5e5ec67913bb0308ULL, },
+        { 0xcb3a6a891dce1f40ULL, 0x733fd25ea9a6d520ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
+        { 0x7bd718d08a09e3b8ULL, 0x5e5ec67913bb0308ULL, },
+        { 0x0883ff3964d871f0ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0x57e750f1f89cad78ULL, 0x3ad08219c06a7810ULL, },
+        { 0x749115ea109e1b46ULL, 0x850632416bfc705cULL, },
+        { 0xcb3a6a891dce1f40ULL, 0x733fd25ea9a6d520ULL, },    /*  72  */
+        { 0x57e750f1f89cad78ULL, 0x3ad08219c06a7810ULL, },
+        { 0xa74aa2aa8c60e900ULL, 0x4fb18dff56564a28ULL, },
+        { 0xc3f467a2a46256ceULL, 0x99e73e2701e84274ULL, },
+        { 0xe7e42f8135cf8d0eULL, 0xbd7582865538cd6cULL, },
+        { 0x749115ea109e1b46ULL, 0x850632416bfc705cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests=
/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
new file mode 100644
index 0000000..e35483c
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADD_A.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADD_A.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },    /*   0  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x5557555755575557ULL, 0x5557555755575557ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x3335333533353335ULL, 0x3335333533353335ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x1c7338e471c91c73ULL, 0x38e471c91c7338e4ULL, },
+        { 0x1c7238e571c81c72ULL, 0x38e571c81c7238e5ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x5557555755575557ULL, 0x5557555755575557ULL, },    /*  16  */
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0xaaacaaacaaacaaacULL, 0xaaacaaacaaacaaacULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0x888a888a888a888aULL, 0x888a888a888a888aULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x71c88e39c71e71c8ULL, 0x8e39c71e71c88e39ULL, },
+        { 0x71c78e3ac71d71c7ULL, 0x8e3ac71d71c78e3aULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaabaaabaaabaaabULL, 0xaaabaaabaaabaaabULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x71c78e38c71d71c7ULL, 0x8e38c71d71c78e38ULL, },
+        { 0x71c68e39c71c71c6ULL, 0x8e39c71c71c68e39ULL, },
+        { 0x3335333533353335ULL, 0x3335333533353335ULL, },    /*  32  */
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x888a888a888a888aULL, 0x888a888a888a888aULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x6668666866686668ULL, 0x6668666866686668ULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x4fa66c17a4fc4fa6ULL, 0x6c17a4fc4fa66c17ULL, },
+        { 0x4fa56c18a4fb4fa5ULL, 0x6c18a4fb4fa56c18ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8889888988898889ULL, 0x8889888988898889ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x4fa56c16a4fb4fa5ULL, 0x6c16a4fb4fa56c16ULL, },
+        { 0x4fa46c17a4fa4fa4ULL, 0x6c17a4fa4fa46c17ULL, },
+        { 0x1c7338e471c91c73ULL, 0x38e471c91c7338e4ULL, },    /*  48  */
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x71c88e39c71e71c8ULL, 0x8e39c71e71c88e39ULL, },
+        { 0x71c78e38c71d71c7ULL, 0x8e38c71d71c78e38ULL, },
+        { 0x4fa66c17a4fc4fa6ULL, 0x6c17a4fc4fa66c17ULL, },
+        { 0x4fa56c16a4fb4fa5ULL, 0x6c16a4fb4fa56c16ULL, },
+        { 0x38e471c6e39038e4ULL, 0x71c6e39038e471c6ULL, },
+        { 0x38e371c7e38f38e3ULL, 0x71c7e38f38e371c7ULL, },
+        { 0x1c7238e571c81c72ULL, 0x38e571c81c7238e5ULL, },    /*  56  */
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x71c78e3ac71d71c7ULL, 0x8e3ac71d71c78e3aULL, },
+        { 0x71c68e39c71c71c6ULL, 0x8e39c71c71c68e39ULL, },
+        { 0x4fa56c18a4fb4fa5ULL, 0x6c18a4fb4fa56c18ULL, },
+        { 0x4fa46c17a4fa4fa4ULL, 0x6c17a4fa4fa46c17ULL, },
+        { 0x38e371c7e38f38e3ULL, 0x71c7e38f38e371c7ULL, },
+        { 0x38e271c8e38e38e2ULL, 0x71c8e38e38e271c8ULL, },
+        { 0xef2c326850c4aa80ULL, 0x96ce16bc030a9fe8ULL, },    /*  64  */
+        { 0x7bd8199775f58e38ULL, 0x5e5e504416c4a2f0ULL, },
+        { 0xcb3c6a8a6e93c9c0ULL, 0x733f445f565a7508ULL, },
+        { 0xe7e52f81869372f2ULL, 0xbd76828658436d54ULL, },
+        { 0x7bd8199775f58e38ULL, 0x5e5e504416c4a2f0ULL, },
+        { 0x088400c69b2671f0ULL, 0x25ee89cc2a7ea5f8ULL, },
+        { 0x57e851b993c4ad78ULL, 0x3acf7de76a147810ULL, },
+        { 0x749116b0abc456aaULL, 0x8506bc0e6bfd705cULL, },
+        { 0xcb3c6a8a6e93c9c0ULL, 0x733f445f565a7508ULL, },    /*  72  */
+        { 0x57e851b993c4ad78ULL, 0x3acf7de76a147810ULL, },
+        { 0xa74ca2ac8c62e900ULL, 0x4fb07202a9aa4a28ULL, },
+        { 0xc3f567a3a4629232ULL, 0x99e7b029ab934274ULL, },
+        { 0xe7e52f81869372f2ULL, 0xbd76828658436d54ULL, },
+        { 0x749116b0abc456aaULL, 0x8506bc0e6bfd705cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests=
/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
new file mode 100644
index 0000000..040cadb
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADD_A.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADD_A.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },    /*   0  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x5555555755555557ULL, 0x5555555755555557ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x3333333533333335ULL, 0x3333333533333335ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x1c71c71e71c71c73ULL, 0x38e38e391c71c71eULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e3a1c71c71dULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x5555555755555557ULL, 0x5555555755555557ULL, },    /*  16  */
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0xaaaaaaacaaaaaaacULL, 0xaaaaaaacaaaaaaacULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0x8888888a8888888aULL, 0x8888888a8888888aULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x71c71c73c71c71c8ULL, 0x8e38e38e71c71c73ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x8e38e38f71c71c72ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaabaaaaaaabULL, 0xaaaaaaabaaaaaaabULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x8e38e38d71c71c72ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x8e38e38e71c71c71ULL, },
+        { 0x3333333533333335ULL, 0x3333333533333335ULL, },    /*  32  */
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x8888888a8888888aULL, 0x8888888a8888888aULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x6666666866666668ULL, 0x6666666866666668ULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x4fa4fa51a4fa4fa6ULL, 0x6c16c16c4fa4fa51ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x6c16c16d4fa4fa50ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x8888888988888889ULL, 0x8888888988888889ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x6c16c16b4fa4fa50ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0x6c16c16c4fa4fa4fULL, },
+        { 0x1c71c71e71c71c73ULL, 0x38e38e391c71c71eULL, },    /*  48  */
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x71c71c73c71c71c8ULL, 0x8e38e38e71c71c73ULL, },
+        { 0x71c71c72c71c71c7ULL, 0x8e38e38d71c71c72ULL, },
+        { 0x4fa4fa51a4fa4fa6ULL, 0x6c16c16c4fa4fa51ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x6c16c16b4fa4fa50ULL, },
+        { 0x38e38e3ae38e38e4ULL, 0x71c71c7038e38e3aULL, },
+        { 0x38e38e39e38e38e3ULL, 0x71c71c7138e38e39ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e3a1c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x71c71c72c71c71c7ULL, 0x8e38e38f71c71c72ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x8e38e38e71c71c71ULL, },
+        { 0x4fa4fa50a4fa4fa5ULL, 0x6c16c16d4fa4fa50ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0x6c16c16c4fa4fa4fULL, },
+        { 0x38e38e39e38e38e3ULL, 0x71c71c7138e38e39ULL, },
+        { 0x38e38e38e38e38e2ULL, 0x71c71c7238e38e38ULL, },
+        { 0xef2a326850c4aa80ULL, 0x96ce16bc03089fe8ULL, },    /*  64  */
+        { 0x7bd718d175f61c48ULL, 0x5e5ec67816c3a2f0ULL, },
+        { 0xcb3a6a8a6e92c9c0ULL, 0x733fd25d56592ae0ULL, },
+        { 0xe7e42f818694378eULL, 0xbd75828658416d54ULL, },
+        { 0x7bd718d175f61c48ULL, 0x5e5ec67816c3a2f0ULL, },
+        { 0x0883ff3a9b278e10ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0x57e750f393c43b88ULL, 0x3ad082196a142de8ULL, },
+        { 0x749115eaabc5a956ULL, 0x850632426bfc705cULL, },
+        { 0xcb3a6a8a6e92c9c0ULL, 0x733fd25d56592ae0ULL, },    /*  72  */
+        { 0x57e750f393c43b88ULL, 0x3ad082196a142de8ULL, },
+        { 0xa74aa2ac8c60e900ULL, 0x4fb18dfea9a9b5d8ULL, },
+        { 0xc3f467a3a46256ceULL, 0x99e73e27ab91f84cULL, },
+        { 0xe7e42f818694378eULL, 0xbd75828658416d54ULL, },
+        { 0x749115eaabc5a956ULL, 0x850632426bfc705cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADD_A_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
new file mode 100644
index 0000000..7f8a595
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_A.B
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_A.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },    /*   0  */
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x5757575757575757ULL, 0x5757575757575757ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x3535353535353535ULL, 0x3535353535353535ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x1e73391e73391e73ULL, 0x391e73391e73391eULL, },
+        { 0x1d723a1d723a1d72ULL, 0x3a1d723a1d723a1dULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x5757575757575757ULL, 0x5757575757575757ULL, },    /*  16  */
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x737f7f737f7f737fULL, 0x7f737f7f737f7f73ULL, },
+        { 0x727f7f727f7f727fULL, 0x7f727f7f727f7f72ULL, },
+        { 0x5656565656565656ULL, 0x5656565656565656ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x727f7f727f7f727fULL, 0x7f727f7f727f7f72ULL, },
+        { 0x717f7f717f7f717fULL, 0x7f717f7f717f7f71ULL, },
+        { 0x3535353535353535ULL, 0x3535353535353535ULL, },    /*  32  */
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x6868686868686868ULL, 0x6868686868686868ULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x517f6c517f6c517fULL, 0x6c517f6c517f6c51ULL, },
+        { 0x507f6d507f6d507fULL, 0x6d507f6d507f6d50ULL, },
+        { 0x3434343434343434ULL, 0x3434343434343434ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x6767676767676767ULL, 0x6767676767676767ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x507f6b507f6b507fULL, 0x6b507f6b507f6b50ULL, },
+        { 0x4f7f6c4f7f6c4f7fULL, 0x6c4f7f6c4f7f6c4fULL, },
+        { 0x1e73391e73391e73ULL, 0x391e73391e73391eULL, },    /*  48  */
+        { 0x1d72381d72381d72ULL, 0x381d72381d72381dULL, },
+        { 0x737f7f737f7f737fULL, 0x7f737f7f737f7f73ULL, },
+        { 0x727f7f727f7f727fULL, 0x7f727f7f727f7f72ULL, },
+        { 0x517f6c517f6c517fULL, 0x6c517f6c517f6c51ULL, },
+        { 0x507f6b507f6b507fULL, 0x6b507f6b507f6b50ULL, },
+        { 0x3a7f703a7f703a7fULL, 0x703a7f703a7f703aULL, },
+        { 0x397f71397f71397fULL, 0x71397f71397f7139ULL, },
+        { 0x1d723a1d723a1d72ULL, 0x3a1d723a1d723a1dULL, },    /*  56  */
+        { 0x1c71391c71391c71ULL, 0x391c71391c71391cULL, },
+        { 0x727f7f727f7f727fULL, 0x7f727f7f727f7f72ULL, },
+        { 0x717f7f717f7f717fULL, 0x7f717f7f717f7f71ULL, },
+        { 0x507f6d507f6d507fULL, 0x6d507f6d507f6d50ULL, },
+        { 0x4f7f6c4f7f6c4f7fULL, 0x6c4f7f6c4f7f6c4fULL, },
+        { 0x397f71397f71397fULL, 0x71397f71397f7139ULL, },
+        { 0x387f72387f72387fULL, 0x72387f72387f7238ULL, },
+        { 0x7f7f3468507f7f7fULL, 0x7f7f167f047f7f18ULL, },    /*  64  */
+        { 0x7d7f1a7f757f7f48ULL, 0x5d705078177f7f10ULL, },
+        { 0x7f7f6c7f6f7f7f7fULL, 0x727f455f577f7520ULL, },
+        { 0x7f7f307f7f7f737fULL, 0x7f767f7f597f6e6cULL, },
+        { 0x7d7f1a7f757f7f48ULL, 0x5d705078177f7f10ULL, },
+        { 0x0a7f007f7f7f7210ULL, 0x24127f342a7e7f08ULL, },
+        { 0x597f527f7f7f7f7fULL, 0x39317f1b6a6a7718ULL, },
+        { 0x757f167f7f7f5756ULL, 0x7f187f426c7f7064ULL, },
+        { 0x7f7f6c7f6f7f7f7fULL, 0x727f455f577f7520ULL, },    /*  72  */
+        { 0x597f527f7f7f7f7fULL, 0x39317f1b6a6a7718ULL, },
+        { 0x7f7f7f7f7f627f7fULL, 0x4e5074027f564a28ULL, },
+        { 0x7f7f687f7f627f7fULL, 0x7f377f297f6d4374ULL, },
+        { 0x7f7f307f7f7f737fULL, 0x7f767f7f597f6e6cULL, },
+        { 0x757f167f7f7f5756ULL, 0x7f187f426c7f7064ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
new file mode 100644
index 0000000..2b38b0d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_A.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_A.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },
+        { 0x5555555555555557ULL, 0x5555555555555557ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x3333333333333335ULL, 0x3333333333333335ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x1c71c71c71c71c73ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e5ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x5555555555555557ULL, 0x5555555555555557ULL, },    /*  16  */
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c8ULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c7ULL, 0x7fffffffffffffffULL, },
+        { 0x5555555555555556ULL, 0x5555555555555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c7ULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c6ULL, 0x7fffffffffffffffULL, },
+        { 0x3333333333333335ULL, 0x3333333333333335ULL, },    /*  32  */
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x6666666666666668ULL, 0x6666666666666668ULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x4fa4fa4fa4fa4fa6ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c18ULL, },
+        { 0x3333333333333334ULL, 0x3333333333333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x6666666666666667ULL, 0x6666666666666667ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x1c71c71c71c71c73ULL, 0x38e38e38e38e38e4ULL, },    /*  48  */
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x71c71c71c71c71c8ULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c7ULL, 0x7fffffffffffffffULL, },
+        { 0x4fa4fa4fa4fa4fa6ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c16ULL, },
+        { 0x38e38e38e38e38e4ULL, 0x71c71c71c71c71c6ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x1c71c71c71c71c72ULL, 0x38e38e38e38e38e5ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e4ULL, },
+        { 0x71c71c71c71c71c7ULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c6ULL, 0x7fffffffffffffffULL, },
+        { 0x4fa4fa4fa4fa4fa5ULL, 0x6c16c16c16c16c18ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0x6c16c16c16c16c17ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x71c71c71c71c71c7ULL, },
+        { 0x38e38e38e38e38e2ULL, 0x71c71c71c71c71c8ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },    /*  64  */
+        { 0x7bd718d08a09e3b8ULL, 0x5e5ec67913bb0308ULL, },
+        { 0x7fffffffffffffffULL, 0x733fd25ea9a6d520ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7bd718d08a09e3b8ULL, 0x5e5ec67913bb0308ULL, },
+        { 0x0883ff3964d871f0ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0x57e750f1f89cad78ULL, 0x3ad08219c06a7810ULL, },
+        { 0x749115ea109e1b46ULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x733fd25ea9a6d520ULL, },    /*  72  */
+        { 0x57e750f1f89cad78ULL, 0x3ad08219c06a7810ULL, },
+        { 0x7fffffffffffffffULL, 0x4fb18dff56564a28ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x749115ea109e1b46ULL, 0x7fffffffffffffffULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
new file mode 100644
index 0000000..424f7d3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_A.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_A.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },    /*   0  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x5557555755575557ULL, 0x5557555755575557ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x3335333533353335ULL, 0x3335333533353335ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x1c7338e471c91c73ULL, 0x38e471c91c7338e4ULL, },
+        { 0x1c7238e571c81c72ULL, 0x38e571c81c7238e5ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x5557555755575557ULL, 0x5557555755575557ULL, },    /*  16  */
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x71c87fff7fff71c8ULL, 0x7fff7fff71c87fffULL, },
+        { 0x71c77fff7fff71c7ULL, 0x7fff7fff71c77fffULL, },
+        { 0x5556555655565556ULL, 0x5556555655565556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x71c77fff7fff71c7ULL, 0x7fff7fff71c77fffULL, },
+        { 0x71c67fff7fff71c6ULL, 0x7fff7fff71c67fffULL, },
+        { 0x3335333533353335ULL, 0x3335333533353335ULL, },    /*  32  */
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x6668666866686668ULL, 0x6668666866686668ULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x4fa66c177fff4fa6ULL, 0x6c177fff4fa66c17ULL, },
+        { 0x4fa56c187fff4fa5ULL, 0x6c187fff4fa56c18ULL, },
+        { 0x3334333433343334ULL, 0x3334333433343334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x6667666766676667ULL, 0x6667666766676667ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x4fa56c167fff4fa5ULL, 0x6c167fff4fa56c16ULL, },
+        { 0x4fa46c177fff4fa4ULL, 0x6c177fff4fa46c17ULL, },
+        { 0x1c7338e471c91c73ULL, 0x38e471c91c7338e4ULL, },    /*  48  */
+        { 0x1c7238e371c81c72ULL, 0x38e371c81c7238e3ULL, },
+        { 0x71c87fff7fff71c8ULL, 0x7fff7fff71c87fffULL, },
+        { 0x71c77fff7fff71c7ULL, 0x7fff7fff71c77fffULL, },
+        { 0x4fa66c177fff4fa6ULL, 0x6c177fff4fa66c17ULL, },
+        { 0x4fa56c167fff4fa5ULL, 0x6c167fff4fa56c16ULL, },
+        { 0x38e471c67fff38e4ULL, 0x71c67fff38e471c6ULL, },
+        { 0x38e371c77fff38e3ULL, 0x71c77fff38e371c7ULL, },
+        { 0x1c7238e571c81c72ULL, 0x38e571c81c7238e5ULL, },    /*  56  */
+        { 0x1c7138e471c71c71ULL, 0x38e471c71c7138e4ULL, },
+        { 0x71c77fff7fff71c7ULL, 0x7fff7fff71c77fffULL, },
+        { 0x71c67fff7fff71c6ULL, 0x7fff7fff71c67fffULL, },
+        { 0x4fa56c187fff4fa5ULL, 0x6c187fff4fa56c18ULL, },
+        { 0x4fa46c177fff4fa4ULL, 0x6c177fff4fa46c17ULL, },
+        { 0x38e371c77fff38e3ULL, 0x71c77fff38e371c7ULL, },
+        { 0x38e271c87fff38e2ULL, 0x71c87fff38e271c8ULL, },
+        { 0x7fff326850c47fffULL, 0x7fff16bc030a7fffULL, },    /*  64  */
+        { 0x7bd8199775f57fffULL, 0x5e5e504416c47fffULL, },
+        { 0x7fff6a8a6e937fffULL, 0x733f445f565a7508ULL, },
+        { 0x7fff2f817fff72f2ULL, 0x7fff7fff58436d54ULL, },
+        { 0x7bd8199775f57fffULL, 0x5e5e504416c47fffULL, },
+        { 0x088400c67fff71f0ULL, 0x25ee7fff2a7e7fffULL, },
+        { 0x57e851b97fff7fffULL, 0x3acf7de76a147810ULL, },
+        { 0x749116b07fff56aaULL, 0x7fff7fff6bfd705cULL, },
+        { 0x7fff6a8a6e937fffULL, 0x733f445f565a7508ULL, },    /*  72  */
+        { 0x57e851b97fff7fffULL, 0x3acf7de76a147810ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x4fb072027fff4a28ULL, },
+        { 0x7fff67a37fff7fffULL, 0x7fff7fff7fff4274ULL, },
+        { 0x7fff2f817fff72f2ULL, 0x7fff7fff58436d54ULL, },
+        { 0x749116b07fff56aaULL, 0x7fff7fff6bfd705cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
new file mode 100644
index 0000000..c389e46
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_A.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_A.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },    /*   0  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x5555555755555557ULL, 0x5555555755555557ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x3333333533333335ULL, 0x3333333533333335ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x1c71c71e71c71c73ULL, 0x38e38e391c71c71eULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e3a1c71c71dULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x5555555755555557ULL, 0x5555555755555557ULL, },    /*  16  */
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x71c71c737fffffffULL, 0x7fffffff71c71c73ULL, },
+        { 0x71c71c727fffffffULL, 0x7fffffff71c71c72ULL, },
+        { 0x5555555655555556ULL, 0x5555555655555556ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x71c71c727fffffffULL, 0x7fffffff71c71c72ULL, },
+        { 0x71c71c717fffffffULL, 0x7fffffff71c71c71ULL, },
+        { 0x3333333533333335ULL, 0x3333333533333335ULL, },    /*  32  */
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x6666666866666668ULL, 0x6666666866666668ULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x4fa4fa517fffffffULL, 0x6c16c16c4fa4fa51ULL, },
+        { 0x4fa4fa507fffffffULL, 0x6c16c16d4fa4fa50ULL, },
+        { 0x3333333433333334ULL, 0x3333333433333334ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x6666666766666667ULL, 0x6666666766666667ULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x4fa4fa507fffffffULL, 0x6c16c16b4fa4fa50ULL, },
+        { 0x4fa4fa4f7fffffffULL, 0x6c16c16c4fa4fa4fULL, },
+        { 0x1c71c71e71c71c73ULL, 0x38e38e391c71c71eULL, },    /*  48  */
+        { 0x1c71c71d71c71c72ULL, 0x38e38e381c71c71dULL, },
+        { 0x71c71c737fffffffULL, 0x7fffffff71c71c73ULL, },
+        { 0x71c71c727fffffffULL, 0x7fffffff71c71c72ULL, },
+        { 0x4fa4fa517fffffffULL, 0x6c16c16c4fa4fa51ULL, },
+        { 0x4fa4fa507fffffffULL, 0x6c16c16b4fa4fa50ULL, },
+        { 0x38e38e3a7fffffffULL, 0x71c71c7038e38e3aULL, },
+        { 0x38e38e397fffffffULL, 0x71c71c7138e38e39ULL, },
+        { 0x1c71c71d71c71c72ULL, 0x38e38e3a1c71c71dULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x38e38e391c71c71cULL, },
+        { 0x71c71c727fffffffULL, 0x7fffffff71c71c72ULL, },
+        { 0x71c71c717fffffffULL, 0x7fffffff71c71c71ULL, },
+        { 0x4fa4fa507fffffffULL, 0x6c16c16d4fa4fa50ULL, },
+        { 0x4fa4fa4f7fffffffULL, 0x6c16c16c4fa4fa4fULL, },
+        { 0x38e38e397fffffffULL, 0x71c71c7138e38e39ULL, },
+        { 0x38e38e387fffffffULL, 0x71c71c7238e38e38ULL, },
+        { 0x7fffffff50c4aa80ULL, 0x7fffffff03089fe8ULL, },    /*  64  */
+        { 0x7bd718d175f61c48ULL, 0x5e5ec67816c3a2f0ULL, },
+        { 0x7fffffff6e92c9c0ULL, 0x733fd25d56592ae0ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff58416d54ULL, },
+        { 0x7bd718d175f61c48ULL, 0x5e5ec67816c3a2f0ULL, },
+        { 0x0883ff3a7fffffffULL, 0x25ef76342a7ea5f8ULL, },
+        { 0x57e750f37fffffffULL, 0x3ad082196a142de8ULL, },
+        { 0x749115ea7fffffffULL, 0x7fffffff6bfc705cULL, },
+        { 0x7fffffff6e92c9c0ULL, 0x733fd25d56592ae0ULL, },    /*  72  */
+        { 0x57e750f37fffffffULL, 0x3ad082196a142de8ULL, },
+        { 0x7fffffff7fffffffULL, 0x4fb18dfe7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff58416d54ULL, },
+        { 0x749115ea7fffffffULL, 0x7fffffff6bfc705cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_A_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
new file mode 100644
index 0000000..5b1d9e0
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_S.B
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_S.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xa9a9a9a9a9a9a9a9ULL, 0xa9a9a9a9a9a9a9a9ULL, },
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },
+        { 0xcbcbcbcbcbcbcbcbULL, 0xcbcbcbcbcbcbcbcbULL, },
+        { 0x3232323232323232ULL, 0x3232323232323232ULL, },
+        { 0xe28d37e28d37e28dULL, 0x37e28d37e28d37e2ULL, },
+        { 0x1b70c61b70c61b70ULL, 0xc61b70c61b70c61bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xa9a9a9a9a9a9a9a9ULL, 0xa9a9a9a9a9a9a9a9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8d80e28d80e28d80ULL, 0xe28d80e28d80e28dULL, },
+        { 0xc61b80c61b80c61bULL, 0x80c61b80c61b80c6ULL, },
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x2121212121212121ULL, 0x2121212121212121ULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0x38e37f38e37f38e3ULL, 0x7f38e37f38e37f38ULL, },
+        { 0x717f1c717f1c717fULL, 0x1c717f1c717f1c71ULL, },
+        { 0xcbcbcbcbcbcbcbcbULL, 0xcbcbcbcbcbcbcbcbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x2121212121212121ULL, 0x2121212121212121ULL, },
+        { 0x9898989898989898ULL, 0x9898989898989898ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaf8004af8004af80ULL, 0x04af8004af8004afULL, },
+        { 0xe83d93e83d93e83dULL, 0x93e83d93e83d93e8ULL, },
+        { 0x3232323232323232ULL, 0x3232323232323232ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x7f7f7f7f7f7f7f7fULL, 0x7f7f7f7f7f7f7f7fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16b16c16b16c1ULL, 0x6b16c16b16c16b16ULL, },
+        { 0x4f7ffa4f7ffa4f7fULL, 0xfa4f7ffa4f7ffa4fULL, },
+        { 0xe28d37e28d37e28dULL, 0x37e28d37e28d37e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8d80e28d80e28d80ULL, 0xe28d80e28d80e28dULL, },
+        { 0x38e37f38e37f38e3ULL, 0x7f38e37f38e37f38ULL, },
+        { 0xaf8004af8004af80ULL, 0x04af8004af8004afULL, },
+        { 0x16c16b16c16b16c1ULL, 0x6b16c16b16c16b16ULL, },
+        { 0xc68070c68070c680ULL, 0x70c68070c68070c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1b70c61b70c61b70ULL, 0xc61b70c61b70c61bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc61b80c61b80c61bULL, 0x80c61b80c61b80c6ULL, },
+        { 0x717f1c717f1c717fULL, 0x1c717f1c717f1c71ULL, },
+        { 0xe83d93e83d93e83dULL, 0x93e83d93e83d93e8ULL, },
+        { 0x4f7ffa4f7ffa4f7fULL, 0xfa4f7ffa4f7ffa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x387f8e387f8e387fULL, 0x8e387f8e387f8e38ULL, },
+        { 0x807fcc98507f7f7fULL, 0x7f7f167ffc7f8018ULL, },    /*  64  */
+        { 0x8328e62f75f51c48ULL, 0x5d5ec678137f0208ULL, },
+        { 0x807f9480e131e0c0ULL, 0x723fd15da97fd520ULL, },
+        { 0xf87ffc197f7f377fULL, 0xd8589336a77f92acULL, },
+        { 0x8328e62f75f51c48ULL, 0x5d5ec678137f0208ULL, },
+        { 0xf680007f7f808e10ULL, 0x24ee80342a7e7ff8ULL, },
+        { 0xa718ae0d06808088ULL, 0x39cf8119c06a7710ULL, },
+        { 0x6b0d167f7fc4a956ULL, 0x9fe880f2be7f349cULL, },
+        { 0x807f9480e131e0c0ULL, 0x723fd15da97fd520ULL, },    /*  72  */
+        { 0xa718ae0d06808088ULL, 0x39cf8119c06a7710ULL, },
+        { 0x807f8080809e8080ULL, 0x4eb08cfe80564a28ULL, },
+        { 0x1c7fc4f7170080ceULL, 0xb4c980d7806d07b4ULL, },
+        { 0xf87ffc197f7f377fULL, 0xd8589336a77f92acULL, },
+        { 0x6b0d167f7fc4a956ULL, 0x9fe880f2be7f349cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
new file mode 100644
index 0000000..d37773e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_S.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaa9ULL, 0xaaaaaaaaaaaaaaa9ULL, },
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },
+        { 0xcccccccccccccccbULL, 0xcccccccccccccccbULL, },
+        { 0x3333333333333332ULL, 0x3333333333333332ULL, },
+        { 0xe38e38e38e38e38dULL, 0x38e38e38e38e38e2ULL, },
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaa9ULL, 0xaaaaaaaaaaaaaaa9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0xc71c71c71c71c71bULL, 0x8000000000000000ULL, },
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x2222222222222221ULL, 0x2222222222222221ULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0x38e38e38e38e38e3ULL, 0x7fffffffffffffffULL, },
+        { 0x71c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xcccccccccccccccbULL, 0xcccccccccccccccbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },
+        { 0x2222222222222221ULL, 0x2222222222222221ULL, },
+        { 0x9999999999999998ULL, 0x9999999999999998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xb05b05b05b05b05aULL, 0x05b05b05b05b05afULL, },
+        { 0xe93e93e93e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x3333333333333332ULL, 0x3333333333333332ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x7fffffffffffffffULL, 0x7fffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16c16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xe38e38e38e38e38dULL, 0x38e38e38e38e38e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0x38e38e38e38e38e3ULL, 0x7fffffffffffffffULL, },
+        { 0xb05b05b05b05b05aULL, 0x05b05b05b05b05afULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16c16c16c16ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71c71bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c71c71c71bULL, 0x8000000000000000ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xe93e93e93e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e2ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x8000000000000000ULL, 0x7fffffffffffffffULL, },    /*  64  */
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67913bb0308ULL, },
+        { 0x8000000000000000ULL, 0x733fd25ea9a6d520ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67913bb0308ULL, },
+        { 0xf77c00c69b278e10ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0xa818af0e07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0x8000000000000000ULL, 0x733fd25ea9a6d520ULL, },    /*  72  */
+        { 0xa818af0e07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x8000000000000000ULL, 0x4fb18dff56564a28ULL, },
+        { 0x1ca9c4f818016dceULL, 0xb5ca4fd8546e07b4ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
+        { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
new file mode 100644
index 0000000..eb5afe1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_S.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaa9aaa9aaa9aaa9ULL, 0xaaa9aaa9aaa9aaa9ULL, },
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },
+        { 0xcccbcccbcccbcccbULL, 0xcccbcccbcccbcccbULL, },
+        { 0x3332333233323332ULL, 0x3332333233323332ULL, },
+        { 0xe38d38e28e37e38dULL, 0x38e28e37e38d38e2ULL, },
+        { 0x1c70c71b71c61c70ULL, 0xc71b71c61c70c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaa9aaa9aaa9aaa9ULL, 0xaaa9aaa9aaa9aaa9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8e38e38d80008e38ULL, 0xe38d80008e38e38dULL, },
+        { 0xc71b80001c71c71bULL, 0x80001c71c71b8000ULL, },
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0x38e37fffe38d38e3ULL, 0x7fffe38d38e37fffULL, },
+        { 0x71c61c717fff71c6ULL, 0x1c717fff71c61c71ULL, },
+        { 0xcccbcccbcccbcccbULL, 0xcccbcccbcccbcccbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0x9998999899989998ULL, 0x9998999899989998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xb05a05af8000b05aULL, 0x05af8000b05a05afULL, },
+        { 0xe93d93e83e93e93dULL, 0x93e83e93e93d93e8ULL, },
+        { 0x3332333233323332ULL, 0x3332333233323332ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x7fff7fff7fff7fffULL, 0x7fff7fff7fff7fffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16c16c16b16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0x4fa4fa4f7fff4fa4ULL, 0xfa4f7fff4fa4fa4fULL, },
+        { 0xe38d38e28e37e38dULL, 0x38e28e37e38d38e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8e38e38d80008e38ULL, 0xe38d80008e38e38dULL, },
+        { 0x38e37fffe38d38e3ULL, 0x7fffe38d38e37fffULL, },
+        { 0xb05a05af8000b05aULL, 0x05af8000b05a05afULL, },
+        { 0x16c16c16c16b16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0xc71c71c68000c71cULL, 0x71c68000c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c70c71b71c61c70ULL, 0xc71b71c61c70c71bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71b80001c71c71bULL, 0x80001c71c71b8000ULL, },
+        { 0x71c61c717fff71c6ULL, 0x1c717fff71c61c71ULL, },
+        { 0xe93d93e83e93e93dULL, 0x93e83e93e93d93e8ULL, },
+        { 0x4fa4fa4f7fff4fa4ULL, 0xfa4f7fff4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e28e387fff38e2ULL, 0x8e387fff38e28e38ULL, },
+        { 0x8000cd9850c47fffULL, 0x7fff16bcfcf68000ULL, },    /*  64  */
+        { 0x8428e72f75f51c48ULL, 0x5e5ec67813ba0308ULL, },
+        { 0x80009576e231e0c0ULL, 0x733fd25da9a6d520ULL, },
+        { 0xf8b9fd197fff378eULL, 0xd9589436a7bd92acULL, },
+        { 0x8428e72f75f51c48ULL, 0x5e5ec67813ba0308ULL, },
+        { 0xf77c00c67fff8e10ULL, 0x25ee80002a7e7fffULL, },
+        { 0xa818af0d07628000ULL, 0x3acf8219c06a7810ULL, },
+        { 0x6c0d16b07fffa956ULL, 0xa0e88000be81359cULL, },
+        { 0x80009576e231e0c0ULL, 0x733fd25da9a6d520ULL, },    /*  72  */
+        { 0xa818af0d07628000ULL, 0x3acf8219c06a7810ULL, },
+        { 0x8000800080008000ULL, 0x4fb08dfe80004a28ULL, },
+        { 0x1ca9c4f718008000ULL, 0xb5c98000800007b4ULL, },
+        { 0xf8b9fd197fff378eULL, 0xd9589436a7bd92acULL, },
+        { 0x6c0d16b07fffa956ULL, 0xa0e88000be81359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
new file mode 100644
index 0000000..3e1aa30
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_S.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaa9aaaaaaa9ULL, 0xaaaaaaa9aaaaaaa9ULL, },
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },
+        { 0xcccccccbcccccccbULL, 0xcccccccbcccccccbULL, },
+        { 0x3333333233333332ULL, 0x3333333233333332ULL, },
+        { 0xe38e38e28e38e38dULL, 0x38e38e37e38e38e2ULL, },
+        { 0x1c71c71b71c71c70ULL, 0xc71c71c61c71c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaa9aaaaaaa9ULL, 0xaaaaaaa9aaaaaaa9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8e38e38d80000000ULL, 0xe38e38e28e38e38dULL, },
+        { 0xc71c71c61c71c71bULL, 0x80000000c71c71c6ULL, },
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0x38e38e38e38e38e3ULL, 0x7fffffff38e38e38ULL, },
+        { 0x71c71c717fffffffULL, 0x1c71c71c71c71c71ULL, },
+        { 0xcccccccbcccccccbULL, 0xcccccccbcccccccbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0x9999999899999998ULL, 0x9999999899999998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xb05b05af80000000ULL, 0x05b05b04b05b05afULL, },
+        { 0xe93e93e83e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x3333333233333332ULL, 0x3333333233333332ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x7fffffff7fffffffULL, 0x7fffffff7fffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0x4fa4fa4f7fffffffULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xe38e38e28e38e38dULL, 0x38e38e37e38e38e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8e38e38d80000000ULL, 0xe38e38e28e38e38dULL, },
+        { 0x38e38e38e38e38e3ULL, 0x7fffffff38e38e38ULL, },
+        { 0xb05b05af80000000ULL, 0x05b05b04b05b05afULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0xc71c71c680000000ULL, 0x71c71c70c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71b71c71c70ULL, 0xc71c71c61c71c71bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c61c71c71bULL, 0x80000000c71c71c6ULL, },
+        { 0x71c71c717fffffffULL, 0x1c71c71c71c71c71ULL, },
+        { 0xe93e93e83e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x4fa4fa4f7fffffffULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e38e387fffffffULL, 0x8e38e38e38e38e38ULL, },
+        { 0x8000000050c4aa80ULL, 0x7ffffffffcf76018ULL, },    /*  64  */
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67813bb0308ULL, },
+        { 0x80000000e231e0c0ULL, 0x733fd25da9a6d520ULL, },
+        { 0xf8b9fd197fffffffULL, 0xd9589436a7be92acULL, },
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67813bb0308ULL, },
+        { 0xf77c00c67fffffffULL, 0x25ef76342a7ea5f8ULL, },
+        { 0xa818af0d07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x6c0d16b07fffffffULL, 0xa0e943f2be82359cULL, },
+        { 0x80000000e231e0c0ULL, 0x733fd25da9a6d520ULL, },    /*  72  */
+        { 0xa818af0d07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x8000000080000000ULL, 0x4fb18dfe80000000ULL, },
+        { 0x1ca9c4f718016dceULL, 0xb5ca4fd780000000ULL, },
+        { 0xf8b9fd197fffffffULL, 0xd9589436a7be92acULL, },
+        { 0x6c0d16b07fffffffULL, 0xa0e943f2be82359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_S_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
new file mode 100644
index 0000000..995da29
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_U.B
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_U.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xffffe2ffffe2ffffULL, 0xe2ffffe2ffffe2ffULL, },
+        { 0xc6ffffc6ffffc6ffULL, 0xffc6ffffc6ffffc6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffe38dffe38dffe3ULL, 0x8dffe38dffe38dffULL, },
+        { 0x71c6ff71c6ff71c6ULL, 0xff71c6ff71c6ff71ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe8ffffe8ffffe8ffULL, 0xffe8ffffe8ffffe8ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xffc16bffc16bffc1ULL, 0x6bffc16bffc16bffULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffe2ffffe2ffffULL, 0xe2ffffe2ffffe2ffULL, },
+        { 0xffe38dffe38dffe3ULL, 0x8dffe38dffe38dffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffc16bffc16bffc1ULL, 0x6bffc16bffc16bffULL, },
+        { 0xffff70ffff70ffffULL, 0x70ffff70ffff70ffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc6ffffc6ffffc6ffULL, 0xffc6ffffc6ffffc6ULL, },
+        { 0x71c6ff71c6ff71c6ULL, 0xff71c6ff71c6ff71ULL, },
+        { 0xe8ffffe8ffffe8ffULL, 0xffe8ffffe8ffffe8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e2ff38e2ff38e2ULL, 0xff38e2ff38e2ff38ULL, },
+        { 0xffd4ffff50c4aa80ULL, 0x96ce16bcfff6ff18ULL, },    /*  64  */
+        { 0xffffe6ff75f5ff48ULL, 0x5dffc678ffbaffffULL, },
+        { 0xffc4ffffe1ffe0c0ULL, 0x72ffd1ffffa6d520ULL, },
+        { 0xf8b9fcff8693ff8eULL, 0xd8ff93ffffbdffacULL, },
+        { 0xffffe6ff75f5ff48ULL, 0x5dffc678ffbaffffULL, },
+        { 0xffff00c69affff10ULL, 0x24ffff342a7ea4ffULL, },
+        { 0xffffaeffffffff88ULL, 0x39ffffffc06a77ffULL, },
+        { 0xffff16b0abc4ff56ULL, 0x9ffffff2be81ffffULL, },
+        { 0xffc4ffffe1ffe0c0ULL, 0x72ffd1ffffa6d520ULL, },    /*  72  */
+        { 0xffffaeffffffff88ULL, 0x39ffffffc06a77ffULL, },
+        { 0xffb4ffffffffffffULL, 0x4effffffff564a28ULL, },
+        { 0xffa9c4f7ffffffceULL, 0xb4ffffffff6dffb4ULL, },
+        { 0xf8b9fcff8693ff8eULL, 0xd8ff93ffffbdffacULL, },
+        { 0xffff16b0abc4ff56ULL, 0x9ffffff2be81ffffULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
new file mode 100644
index 0000000..2e32380
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_U.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xffffffffffffffffULL, 0xe38e38e38e38e38dULL, },
+        { 0xc71c71c71c71c71bULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0x8e38e38e38e38e38ULL, },
+        { 0x71c71c71c71c71c6ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe93e93e93e93e93dULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xffffffffffffffffULL, 0x6c16c16c16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xe38e38e38e38e38dULL, },
+        { 0xffffffffffffffffULL, 0x8e38e38e38e38e38ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x6c16c16c16c16c16ULL, },
+        { 0xffffffffffffffffULL, 0x71c71c71c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c71c71c71bULL, 0xffffffffffffffffULL, },
+        { 0x71c71c71c71c71c6ULL, 0xffffffffffffffffULL, },
+        { 0xe93e93e93e93e93dULL, 0xffffffffffffffffULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e2ULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0x96ce16bdfcf76018ULL, },    /*  64  */
+        { 0xffffffffffffffffULL, 0x5e5ec67913bb0308ULL, },
+        { 0xffffffffffffffffULL, 0x733fd25ea9a6d520ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
+        { 0xffffffffffffffffULL, 0x5e5ec67913bb0308ULL, },
+        { 0xffffffffffffffffULL, 0x25ef76342a7ea5f8ULL, },
+        { 0xffffffffffffffffULL, 0x3ad08219c06a7810ULL, },
+        { 0xffffffffffffffffULL, 0xa0e943f2be82359cULL, },
+        { 0xffffffffffffffffULL, 0x733fd25ea9a6d520ULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x3ad08219c06a7810ULL, },
+        { 0xffffffffffffffffULL, 0x4fb18dff56564a28ULL, },
+        { 0xffffffffffffffffULL, 0xb5ca4fd8546e07b4ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
+        { 0xffffffffffffffffULL, 0xa0e943f2be82359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
new file mode 100644
index 0000000..4c2e982
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_U.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xffffe38dffffffffULL, 0xe38dffffffffe38dULL, },
+        { 0xc71bffffffffc71bULL, 0xffffffffc71bffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffff8e38e38dffffULL, 0x8e38e38dffff8e38ULL, },
+        { 0x71c6ffffc71c71c6ULL, 0xffffc71c71c6ffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe93dffffffffe93dULL, 0xffffffffe93dffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xffff6c16c16bffffULL, 0x6c16c16bffff6c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffe38dffffffffULL, 0xe38dffffffffe38dULL, },
+        { 0xffff8e38e38dffffULL, 0x8e38e38dffff8e38ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffff6c16c16bffffULL, 0x6c16c16bffff6c16ULL, },
+        { 0xffff71c6ffffffffULL, 0x71c6ffffffff71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71bffffffffc71bULL, 0xffffffffc71bffffULL, },
+        { 0x71c6ffffc71c71c6ULL, 0xffffc71c71c6ffffULL, },
+        { 0xe93dffffffffe93dULL, 0xffffffffe93dffffULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e2ffffe38e38e2ULL, 0xffffe38e38e2ffffULL, },
+        { 0xffffffff50c4aa80ULL, 0x96ce16bcffffffffULL, },    /*  64  */
+        { 0xffffe72f75f5ffffULL, 0x5e5ec678ffffffffULL, },
+        { 0xffffffffe231e0c0ULL, 0x733fd25dffffd520ULL, },
+        { 0xf8b9fd198693ffffULL, 0xd9589436ffffffffULL, },
+        { 0xffffe72f75f5ffffULL, 0x5e5ec678ffffffffULL, },
+        { 0xffff00c69b26ffffULL, 0x25eeffff2a7ea5f8ULL, },
+        { 0xffffaf0dffffffffULL, 0x3acfffffc06a7810ULL, },
+        { 0xffff16b0abc4ffffULL, 0xa0e8ffffbe81ffffULL, },
+        { 0xffffffffe231e0c0ULL, 0x733fd25dffffd520ULL, },    /*  72  */
+        { 0xffffaf0dffffffffULL, 0x3acfffffc06a7810ULL, },
+        { 0xffffffffffffffffULL, 0x4fb0ffffffff4a28ULL, },
+        { 0xffffc4f7ffffffffULL, 0xb5c9ffffffffffffULL, },
+        { 0xf8b9fd198693ffffULL, 0xd9589436ffffffffULL, },
+        { 0xffff16b0abc4ffffULL, 0xa0e8ffffbe81ffffULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
new file mode 100644
index 0000000..8cf0741
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDS_U.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDS_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0xffffffffffffffffULL, 0xe38e38e2ffffffffULL, },
+        { 0xc71c71c6ffffffffULL, 0xffffffffc71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffe38e38e3ULL, 0x8e38e38dffffffffULL, },
+        { 0x71c71c71c71c71c6ULL, 0xffffffff71c71c71ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xe93e93e8ffffffffULL, 0xffffffffe93e93e8ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0xffffffffc16c16c1ULL, 0x6c16c16bffffffffULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xffffffffffffffffULL, 0xe38e38e2ffffffffULL, },
+        { 0xffffffffe38e38e3ULL, 0x8e38e38dffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffc16c16c1ULL, 0x6c16c16bffffffffULL, },
+        { 0xffffffffffffffffULL, 0x71c71c70ffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c6ffffffffULL, 0xffffffffc71c71c6ULL, },
+        { 0x71c71c71c71c71c6ULL, 0xffffffff71c71c71ULL, },
+        { 0xe93e93e8ffffffffULL, 0xffffffffe93e93e8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e2ULL, 0xffffffff38e38e38ULL, },
+        { 0xffffffff50c4aa80ULL, 0x96ce16bcffffffffULL, },    /*  64  */
+        { 0xffffffff75f61c48ULL, 0x5e5ec678ffffffffULL, },
+        { 0xffffffffe231e0c0ULL, 0x733fd25dffffffffULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589436ffffffffULL, },
+        { 0xffffffff75f61c48ULL, 0x5e5ec678ffffffffULL, },
+        { 0xffffffff9b278e10ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0xffffffffffffffffULL, 0x3ad08219c06a7810ULL, },
+        { 0xffffffffabc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0xffffffffe231e0c0ULL, 0x733fd25dffffffffULL, },    /*  72  */
+        { 0xffffffffffffffffULL, 0x3ad08219c06a7810ULL, },
+        { 0xffffffffffffffffULL, 0x4fb18dfeffffffffULL, },
+        { 0xffffffffffffffffULL, 0xb5ca4fd7ffffffffULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589436ffffffffULL, },
+        { 0xffffffffabc5a956ULL, 0xa0e943f2be82359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDS_U_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/=
tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
new file mode 100644
index 0000000..44d8921
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDV.B
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDV.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xa9a9a9a9a9a9a9a9ULL, 0xa9a9a9a9a9a9a9a9ULL, },
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },
+        { 0xcbcbcbcbcbcbcbcbULL, 0xcbcbcbcbcbcbcbcbULL, },
+        { 0x3232323232323232ULL, 0x3232323232323232ULL, },
+        { 0xe28d37e28d37e28dULL, 0x37e28d37e28d37e2ULL, },
+        { 0x1b70c61b70c61b70ULL, 0xc61b70c61b70c61bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xa9a9a9a9a9a9a9a9ULL, 0xa9a9a9a9a9a9a9a9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7676767676767676ULL, 0x7676767676767676ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8d38e28d38e28d38ULL, 0xe28d38e28d38e28dULL, },
+        { 0xc61b71c61b71c61bULL, 0x71c61b71c61b71c6ULL, },
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2121212121212121ULL, 0x2121212121212121ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x38e38d38e38d38e3ULL, 0x8d38e38d38e38d38ULL, },
+        { 0x71c61c71c61c71c6ULL, 0x1c71c61c71c61c71ULL, },
+        { 0xcbcbcbcbcbcbcbcbULL, 0xcbcbcbcbcbcbcbcbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7676767676767676ULL, 0x7676767676767676ULL, },
+        { 0x2121212121212121ULL, 0x2121212121212121ULL, },
+        { 0x9898989898989898ULL, 0x9898989898989898ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaf5a04af5a04af5aULL, 0x04af5a04af5a04afULL, },
+        { 0xe83d93e83d93e83dULL, 0x93e83d93e83d93e8ULL, },
+        { 0x3232323232323232ULL, 0x3232323232323232ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16b16c16b16c1ULL, 0x6b16c16b16c16b16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xe28d37e28d37e28dULL, 0x37e28d37e28d37e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8d38e28d38e28d38ULL, 0xe28d38e28d38e28dULL, },
+        { 0x38e38d38e38d38e3ULL, 0x8d38e38d38e38d38ULL, },
+        { 0xaf5a04af5a04af5aULL, 0x04af5a04af5a04afULL, },
+        { 0x16c16b16c16b16c1ULL, 0x6b16c16b16c16b16ULL, },
+        { 0xc61c70c61c70c61cULL, 0x70c61c70c61c70c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1b70c61b70c61b70ULL, 0xc61b70c61b70c61bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc61b71c61b71c61bULL, 0x71c61b71c61b71c6ULL, },
+        { 0x71c61c71c61c71c6ULL, 0x1c71c61c71c61c71ULL, },
+        { 0xe83d93e83d93e83dULL, 0x93e83d93e83d93e8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e28e38e28e38e2ULL, 0x8e38e28e38e28e38ULL, },
+        { 0x10d4cc9850c4aa80ULL, 0x96ce16bcfcf66018ULL, },    /*  64  */
+        { 0x8328e62f75f51c48ULL, 0x5d5ec67813ba0208ULL, },
+        { 0x34c49476e131e0c0ULL, 0x723fd15da9a6d520ULL, },
+        { 0xf8b9fc198693378eULL, 0xd8589336a7bd92acULL, },
+        { 0x8328e62f75f51c48ULL, 0x5d5ec67813ba0208ULL, },
+        { 0xf67c00c69a268e10ULL, 0x24ee76342a7ea4f8ULL, },
+        { 0xa718ae0d06625288ULL, 0x39cf8119c06a7710ULL, },
+        { 0x6b0d16b0abc4a956ULL, 0x9fe843f2be81349cULL, },
+        { 0x34c49476e131e0c0ULL, 0x723fd15da9a6d520ULL, },    /*  72  */
+        { 0xa718ae0d06625288ULL, 0x39cf8119c06a7710ULL, },
+        { 0x58b45c54729e1600ULL, 0x4eb08cfe56564a28ULL, },
+        { 0x1ca9c4f717006dceULL, 0xb4c94ed7546d07b4ULL, },
+        { 0xf8b9fc198693378eULL, 0xd8589336a7bd92acULL, },
+        { 0x6b0d16b0abc4a956ULL, 0x9fe843f2be81349cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/=
tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
new file mode 100644
index 0000000..858258b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDV.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDV.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaa9ULL, 0xaaaaaaaaaaaaaaa9ULL, },
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },
+        { 0xcccccccccccccccbULL, 0xcccccccccccccccbULL, },
+        { 0x3333333333333332ULL, 0x3333333333333332ULL, },
+        { 0xe38e38e38e38e38dULL, 0x38e38e38e38e38e2ULL, },
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaa9ULL, 0xaaaaaaaaaaaaaaa9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7777777777777776ULL, 0x7777777777777776ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0xc71c71c71c71c71bULL, 0x71c71c71c71c71c6ULL, },
+        { 0x5555555555555554ULL, 0x5555555555555554ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2222222222222221ULL, 0x2222222222222221ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xcccccccccccccccbULL, 0xcccccccccccccccbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7777777777777776ULL, 0x7777777777777776ULL, },
+        { 0x2222222222222221ULL, 0x2222222222222221ULL, },
+        { 0x9999999999999998ULL, 0x9999999999999998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xb05b05b05b05b05aULL, 0x05b05b05b05b05afULL, },
+        { 0xe93e93e93e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x3333333333333332ULL, 0x3333333333333332ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16c16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xe38e38e38e38e38dULL, 0x38e38e38e38e38e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8e38e38e38e38e38ULL, 0xe38e38e38e38e38dULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38e38e38e38ULL, },
+        { 0xb05b05b05b05b05aULL, 0x05b05b05b05b05afULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16c16c16c16ULL, },
+        { 0xc71c71c71c71c71cULL, 0x71c71c71c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71c71bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c71c71c71bULL, 0x71c71c71c71c71c6ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xe93e93e93e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e2ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x10d5cd9850c4aa80ULL, 0x96ce16bdfcf76018ULL, },    /*  64  */
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67913bb0308ULL, },
+        { 0x34c59576e231e0c0ULL, 0x733fd25ea9a6d520ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67913bb0308ULL, },
+        { 0xf77c00c69b278e10ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0xa818af0e07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0x34c59576e231e0c0ULL, 0x733fd25ea9a6d520ULL, },    /*  72  */
+        { 0xa818af0e07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x58b55d55739f1700ULL, 0x4fb18dff56564a28ULL, },
+        { 0x1ca9c4f818016dceULL, 0xb5ca4fd8546e07b4ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589437a7be92acULL, },
+        { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/=
tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
new file mode 100644
index 0000000..5daf7fc
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDV.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDV.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaa9aaa9aaa9aaa9ULL, 0xaaa9aaa9aaa9aaa9ULL, },
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },
+        { 0xcccbcccbcccbcccbULL, 0xcccbcccbcccbcccbULL, },
+        { 0x3332333233323332ULL, 0x3332333233323332ULL, },
+        { 0xe38d38e28e37e38dULL, 0x38e28e37e38d38e2ULL, },
+        { 0x1c70c71b71c61c70ULL, 0xc71b71c61c70c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaa9aaa9aaa9aaa9ULL, 0xaaa9aaa9aaa9aaa9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7776777677767776ULL, 0x7776777677767776ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8e38e38d38e28e38ULL, 0xe38d38e28e38e38dULL, },
+        { 0xc71b71c61c71c71bULL, 0x71c61c71c71b71c6ULL, },
+        { 0x5554555455545554ULL, 0x5554555455545554ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x38e38e38e38d38e3ULL, 0x8e38e38d38e38e38ULL, },
+        { 0x71c61c71c71c71c6ULL, 0x1c71c71c71c61c71ULL, },
+        { 0xcccbcccbcccbcccbULL, 0xcccbcccbcccbcccbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7776777677767776ULL, 0x7776777677767776ULL, },
+        { 0x2221222122212221ULL, 0x2221222122212221ULL, },
+        { 0x9998999899989998ULL, 0x9998999899989998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xb05a05af5b04b05aULL, 0x05af5b04b05a05afULL, },
+        { 0xe93d93e83e93e93dULL, 0x93e83e93e93d93e8ULL, },
+        { 0x3332333233323332ULL, 0x3332333233323332ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16c16c16b16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xe38d38e28e37e38dULL, 0x38e28e37e38d38e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8e38e38d38e28e38ULL, 0xe38d38e28e38e38dULL, },
+        { 0x38e38e38e38d38e3ULL, 0x8e38e38d38e38e38ULL, },
+        { 0xb05a05af5b04b05aULL, 0x05af5b04b05a05afULL, },
+        { 0x16c16c16c16b16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0xc71c71c61c70c71cULL, 0x71c61c70c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c70c71b71c61c70ULL, 0xc71b71c61c70c71bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71b71c61c71c71bULL, 0x71c61c71c71b71c6ULL, },
+        { 0x71c61c71c71c71c6ULL, 0x1c71c71c71c61c71ULL, },
+        { 0xe93d93e83e93e93dULL, 0x93e83e93e93d93e8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e28e38e38e38e2ULL, 0x8e38e38e38e28e38ULL, },
+        { 0x10d4cd9850c4aa80ULL, 0x96ce16bcfcf66018ULL, },    /*  64  */
+        { 0x8428e72f75f51c48ULL, 0x5e5ec67813ba0308ULL, },
+        { 0x34c49576e231e0c0ULL, 0x733fd25da9a6d520ULL, },
+        { 0xf8b9fd198693378eULL, 0xd9589436a7bd92acULL, },
+        { 0x8428e72f75f51c48ULL, 0x5e5ec67813ba0308ULL, },
+        { 0xf77c00c69b268e10ULL, 0x25ee76342a7ea5f8ULL, },
+        { 0xa818af0d07625288ULL, 0x3acf8219c06a7810ULL, },
+        { 0x6c0d16b0abc4a956ULL, 0xa0e843f2be81359cULL, },
+        { 0x34c49576e231e0c0ULL, 0x733fd25da9a6d520ULL, },    /*  72  */
+        { 0xa818af0d07625288ULL, 0x3acf8219c06a7810ULL, },
+        { 0x58b45d54739e1700ULL, 0x4fb08dfe56564a28ULL, },
+        { 0x1ca9c4f718006dceULL, 0xb5c94fd7546d07b4ULL, },
+        { 0xf8b9fd198693378eULL, 0xd9589436a7bd92acULL, },
+        { 0x6c0d16b0abc4a956ULL, 0xa0e843f2be81359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/=
tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
new file mode 100644
index 0000000..b1e42ec
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction ADDV.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "ADDV.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaa9aaaaaaa9ULL, 0xaaaaaaa9aaaaaaa9ULL, },
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },
+        { 0xcccccccbcccccccbULL, 0xcccccccbcccccccbULL, },
+        { 0x3333333233333332ULL, 0x3333333233333332ULL, },
+        { 0xe38e38e28e38e38dULL, 0x38e38e37e38e38e2ULL, },
+        { 0x1c71c71b71c71c70ULL, 0xc71c71c61c71c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaa9aaaaaaa9ULL, 0xaaaaaaa9aaaaaaa9ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x7777777677777776ULL, 0x7777777677777776ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8e38e38d38e38e38ULL, 0xe38e38e28e38e38dULL, },
+        { 0xc71c71c61c71c71bULL, 0x71c71c71c71c71c6ULL, },
+        { 0x5555555455555554ULL, 0x5555555455555554ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38d38e38e38ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xcccccccbcccccccbULL, 0xcccccccbcccccccbULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x7777777677777776ULL, 0x7777777677777776ULL, },
+        { 0x2222222122222221ULL, 0x2222222122222221ULL, },
+        { 0x9999999899999998ULL, 0x9999999899999998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xb05b05af5b05b05aULL, 0x05b05b04b05b05afULL, },
+        { 0xe93e93e83e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x3333333233333332ULL, 0x3333333233333332ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xddddddddddddddddULL, 0xddddddddddddddddULL, },
+        { 0x8888888888888888ULL, 0x8888888888888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x6666666666666666ULL, 0x6666666666666666ULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xe38e38e28e38e38dULL, 0x38e38e37e38e38e2ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8e38e38d38e38e38ULL, 0xe38e38e28e38e38dULL, },
+        { 0x38e38e38e38e38e3ULL, 0x8e38e38d38e38e38ULL, },
+        { 0xb05b05af5b05b05aULL, 0x05b05b04b05b05afULL, },
+        { 0x16c16c16c16c16c1ULL, 0x6c16c16b16c16c16ULL, },
+        { 0xc71c71c61c71c71cULL, 0x71c71c70c71c71c6ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x1c71c71b71c71c70ULL, 0xc71c71c61c71c71bULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c71c61c71c71bULL, 0x71c71c71c71c71c6ULL, },
+        { 0x71c71c71c71c71c6ULL, 0x1c71c71c71c71c71ULL, },
+        { 0xe93e93e83e93e93dULL, 0x93e93e93e93e93e8ULL, },
+        { 0x4fa4fa4fa4fa4fa4ULL, 0xfa4fa4fa4fa4fa4fULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x38e38e38e38e38e2ULL, 0x8e38e38e38e38e38ULL, },
+        { 0x10d5cd9850c4aa80ULL, 0x96ce16bcfcf76018ULL, },    /*  64  */
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67813bb0308ULL, },
+        { 0x34c59576e231e0c0ULL, 0x733fd25da9a6d520ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589436a7be92acULL, },
+        { 0x8428e72f75f61c48ULL, 0x5e5ec67813bb0308ULL, },
+        { 0xf77c00c69b278e10ULL, 0x25ef76342a7ea5f8ULL, },
+        { 0xa818af0d07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+        { 0x34c59576e231e0c0ULL, 0x733fd25da9a6d520ULL, },    /*  72  */
+        { 0xa818af0d07635288ULL, 0x3ad08219c06a7810ULL, },
+        { 0x58b55d54739f1700ULL, 0x4fb18dfe56564a28ULL, },
+        { 0x1ca9c4f718016dceULL, 0xb5ca4fd7546e07b4ULL, },
+        { 0xf8b9fd198694378eULL, 0xd9589436a7be92acULL, },
+        { 0x6c0d16b0abc5a956ULL, 0xa0e943f2be82359cULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_ADDV_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
new file mode 100644
index 0000000..5a923d6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction HADD_S.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "HADD_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffaaaaaaa9ULL, 0xffffffffaaaaaaa9ULL, },
+        { 0x0000000055555554ULL, 0x0000000055555554ULL, },
+        { 0xffffffffcccccccbULL, 0xffffffffcccccccbULL, },
+        { 0x0000000033333332ULL, 0x0000000033333332ULL, },
+        { 0xffffffff8e38e38dULL, 0xffffffffe38e38e2ULL, },
+        { 0x0000000071c71c70ULL, 0x000000001c71c71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0xffffffff8e38e38eULL, 0xffffffffe38e38e3ULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xffffffffaaaaaaa9ULL, 0xffffffffaaaaaaa9ULL, },    /*  16  */
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0xffffffff55555554ULL, 0xffffffff55555554ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff77777776ULL, 0xffffffff77777776ULL, },
+        { 0xffffffffddddddddULL, 0xffffffffddddddddULL, },
+        { 0xffffffff38e38e38ULL, 0xffffffff8e38e38dULL, },
+        { 0x000000001c71c71bULL, 0xffffffffc71c71c6ULL, },
+        { 0x0000000055555554ULL, 0x0000000055555554ULL, },    /*  24  */
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000022222221ULL, 0x0000000022222221ULL, },
+        { 0x0000000088888888ULL, 0x0000000088888888ULL, },
+        { 0xffffffffe38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0x00000000c71c71c6ULL, 0x0000000071c71c71ULL, },
+        { 0xffffffffcccccccbULL, 0xffffffffcccccccbULL, },    /*  32  */
+        { 0xffffffffccccccccULL, 0xffffffffccccccccULL, },
+        { 0xffffffff77777776ULL, 0xffffffff77777776ULL, },
+        { 0x0000000022222221ULL, 0x0000000022222221ULL, },
+        { 0xffffffff99999998ULL, 0xffffffff99999998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffff5b05b05aULL, 0xffffffffb05b05afULL, },
+        { 0x000000003e93e93dULL, 0xffffffffe93e93e8ULL, },
+        { 0x0000000033333332ULL, 0x0000000033333332ULL, },    /*  40  */
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0xffffffffddddddddULL, 0xffffffffddddddddULL, },
+        { 0x0000000088888888ULL, 0x0000000088888888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000066666666ULL, 0x0000000066666666ULL, },
+        { 0xffffffffc16c16c1ULL, 0x0000000016c16c16ULL, },
+        { 0x00000000a4fa4fa4ULL, 0x000000004fa4fa4fULL, },
+        { 0xffffffffe38e38e2ULL, 0x0000000038e38e37ULL, },    /*  48  */
+        { 0xffffffffe38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0xffffffff8e38e38dULL, 0xffffffffe38e38e2ULL, },
+        { 0x0000000038e38e38ULL, 0x000000008e38e38dULL, },
+        { 0xffffffffb05b05afULL, 0x0000000005b05b04ULL, },
+        { 0x0000000016c16c16ULL, 0x000000006c16c16bULL, },
+        { 0xffffffff71c71c71ULL, 0x000000001c71c71bULL, },
+        { 0x0000000055555554ULL, 0x0000000055555554ULL, },
+        { 0x000000001c71c71bULL, 0xffffffffc71c71c6ULL, },    /*  56  */
+        { 0x000000001c71c71cULL, 0xffffffffc71c71c7ULL, },
+        { 0xffffffffc71c71c6ULL, 0xffffffff71c71c71ULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xffffffffe93e93e8ULL, 0xffffffff93e93e93ULL, },
+        { 0x000000004fa4fa4fULL, 0xfffffffffa4fa4faULL, },
+        { 0xffffffffaaaaaaaaULL, 0xffffffffaaaaaaaaULL, },
+        { 0x000000008e38e38dULL, 0xffffffffe38e38e3ULL, },
+        { 0xffffffffb0cd3c0cULL, 0x0000000049e2bb6aULL, },    /*  64  */
+        { 0xffffffffd5feadd4ULL, 0x0000000060a65e5aULL, },
+        { 0xffffffff423a724cULL, 0xfffffffff6923072ULL, },
+        { 0xffffffffe69cc91aULL, 0xfffffffff4a9edfeULL, },
+        { 0x00000000242055a3ULL, 0x0000000011736b26ULL, },
+        { 0x000000004951c76bULL, 0x0000000028370e16ULL, },
+        { 0xffffffffb58d8be3ULL, 0xffffffffbe22e02eULL, },
+        { 0x0000000059efe2b1ULL, 0xffffffffbc3a9dbaULL, },
+        { 0xffffffffd4bd03eaULL, 0x000000002654770bULL, },    /*  72  */
+        { 0xfffffffff9ee75b2ULL, 0x000000003d1819fbULL, },
+        { 0xffffffff662a3a2aULL, 0xffffffffd303ec13ULL, },
+        { 0x000000000a8c90f8ULL, 0xffffffffd11ba99fULL, },
+        { 0x0000000098b16b8dULL, 0xffffffff8c6d38e4ULL, },
+        { 0x00000000bde2dd55ULL, 0xffffffffa330dbd4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_S_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_S_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
new file mode 100644
index 0000000..4b14853
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction HADD_S.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "HADD_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffa9ffa9ffa9ffa9ULL, 0xffa9ffa9ffa9ffa9ULL, },
+        { 0x0054005400540054ULL, 0x0054005400540054ULL, },
+        { 0xffcbffcbffcbffcbULL, 0xffcbffcbffcbffcbULL, },
+        { 0x0032003200320032ULL, 0x0032003200320032ULL, },
+        { 0xff8dffe20037ff8dULL, 0xffe20037ff8dffe2ULL, },
+        { 0x0070001bffc60070ULL, 0x001bffc60070001bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0xff8effe30038ff8eULL, 0xffe30038ff8effe3ULL, },
+        { 0x0071001cffc70071ULL, 0x001cffc70071001cULL, },
+        { 0xffa9ffa9ffa9ffa9ULL, 0xffa9ffa9ffa9ffa9ULL, },    /*  16  */
+        { 0xffaaffaaffaaffaaULL, 0xffaaffaaffaaffaaULL, },
+        { 0xff54ff54ff54ff54ULL, 0xff54ff54ff54ff54ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff76ff76ff76ff76ULL, 0xff76ff76ff76ff76ULL, },
+        { 0xffddffddffddffddULL, 0xffddffddffddffddULL, },
+        { 0xff38ff8dffe2ff38ULL, 0xff8dffe2ff38ff8dULL, },
+        { 0x001bffc6ff71001bULL, 0xffc6ff71001bffc6ULL, },
+        { 0x0054005400540054ULL, 0x0054005400540054ULL, },    /*  24  */
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0021002100210021ULL, 0x0021002100210021ULL, },
+        { 0x0088008800880088ULL, 0x0088008800880088ULL, },
+        { 0xffe30038008dffe3ULL, 0x0038008dffe30038ULL, },
+        { 0x00c60071001c00c6ULL, 0x0071001c00c60071ULL, },
+        { 0xffcbffcbffcbffcbULL, 0xffcbffcbffcbffcbULL, },    /*  32  */
+        { 0xffccffccffccffccULL, 0xffccffccffccffccULL, },
+        { 0xff76ff76ff76ff76ULL, 0xff76ff76ff76ff76ULL, },
+        { 0x0021002100210021ULL, 0x0021002100210021ULL, },
+        { 0xff98ff98ff98ff98ULL, 0xff98ff98ff98ff98ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xff5affaf0004ff5aULL, 0xffaf0004ff5affafULL, },
+        { 0x003dffe8ff93003dULL, 0xffe8ff93003dffe8ULL, },
+        { 0x0032003200320032ULL, 0x0032003200320032ULL, },    /*  40  */
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0xffddffddffddffddULL, 0xffddffddffddffddULL, },
+        { 0x0088008800880088ULL, 0x0088008800880088ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0066006600660066ULL, 0x0066006600660066ULL, },
+        { 0xffc10016006bffc1ULL, 0x0016006bffc10016ULL, },
+        { 0x00a4004ffffa00a4ULL, 0x004ffffa00a4004fULL, },
+        { 0xffe20037ff8dffe2ULL, 0x0037ff8dffe20037ULL, },    /*  48  */
+        { 0xffe30038ff8effe3ULL, 0x0038ff8effe30038ULL, },
+        { 0xff8dffe2ff38ff8dULL, 0xffe2ff38ff8dffe2ULL, },
+        { 0x0038008dffe30038ULL, 0x008dffe30038008dULL, },
+        { 0xffaf0004ff5affafULL, 0x0004ff5affaf0004ULL, },
+        { 0x0016006bffc10016ULL, 0x006bffc10016006bULL, },
+        { 0xff71001bffc6ff71ULL, 0x001bffc6ff71001bULL, },
+        { 0x00540054ff550054ULL, 0x0054ff5500540054ULL, },
+        { 0x001bffc60070001bULL, 0xffc60070001bffc6ULL, },    /*  56  */
+        { 0x001cffc70071001cULL, 0xffc70071001cffc7ULL, },
+        { 0xffc6ff71001bffc6ULL, 0xff71001bffc6ff71ULL, },
+        { 0x0071001c00c60071ULL, 0x001c00c60071001cULL, },
+        { 0xffe8ff93003dffe8ULL, 0xff93003dffe8ff93ULL, },
+        { 0x004ffffa00a4004fULL, 0xfffa00a4004ffffaULL, },
+        { 0xffaaffaa00a9ffaaULL, 0xffaa00a9ffaaffaaULL, },
+        { 0x008dffe30038008dULL, 0xffe30038008dffe3ULL, },
+        { 0xfff2ffb2008a0095ULL, 0x00b200690079ffbcULL, },    /*  64  */
+        { 0xff460049ffbb005dULL, 0x00420025003dffacULL, },
+        { 0xffe2ff90fff7ffd5ULL, 0x0023000a0029ffc4ULL, },
+        { 0xffd70033005900a3ULL, 0x003cffe30040ff50ULL, },
+        { 0x0065ffcc00af0007ULL, 0x007900190090005eULL, },
+        { 0xffb90063ffe0ffcfULL, 0x0009ffd50054004eULL, },
+        { 0x0055ffaa001cff47ULL, 0xffeaffba00400066ULL, },
+        { 0x004a004d007e0015ULL, 0x0003ff930057fff2ULL, },
+        { 0x0016ff7a001bffcbULL, 0x008e002400260031ULL, },    /*  72  */
+        { 0xff6a0011ff4cff93ULL, 0x001effe0ffea0021ULL, },
+        { 0x0006ff58ff88ff0bULL, 0xffffffc5ffd60039ULL, },
+        { 0xfffbfffbffeaffd9ULL, 0x0018ff9effedffc5ULL, },
+        { 0x00daffe200c00022ULL, 0xfff4ffe60024ffeeULL, },
+        { 0x002e0079fff1ffeaULL, 0xff84ffa2ffe8ffdeULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_S_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_S_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
new file mode 100644
index 0000000..26508ea
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction HADD_S.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "HADD_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffaaa9ffffaaa9ULL, 0xffffaaa9ffffaaa9ULL, },
+        { 0x0000555400005554ULL, 0x0000555400005554ULL, },
+        { 0xffffcccbffffcccbULL, 0xffffcccbffffcccbULL, },
+        { 0x0000333200003332ULL, 0x0000333200003332ULL, },
+        { 0x000038e2ffffe38dULL, 0xffff8e37000038e2ULL, },
+        { 0xffffc71b00001c70ULL, 0x000071c6ffffc71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x000038e3ffffe38eULL, 0xffff8e38000038e3ULL, },
+        { 0xffffc71c00001c71ULL, 0x000071c7ffffc71cULL, },
+        { 0xffffaaa9ffffaaa9ULL, 0xffffaaa9ffffaaa9ULL, },    /*  16  */
+        { 0xffffaaaaffffaaaaULL, 0xffffaaaaffffaaaaULL, },
+        { 0xffff5554ffff5554ULL, 0xffff5554ffff5554ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffff7776ffff7776ULL, 0xffff7776ffff7776ULL, },
+        { 0xffffddddffffddddULL, 0xffffddddffffddddULL, },
+        { 0xffffe38dffff8e38ULL, 0xffff38e2ffffe38dULL, },
+        { 0xffff71c6ffffc71bULL, 0x00001c71ffff71c6ULL, },
+        { 0x0000555400005554ULL, 0x0000555400005554ULL, },    /*  24  */
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000222100002221ULL, 0x0000222100002221ULL, },
+        { 0x0000888800008888ULL, 0x0000888800008888ULL, },
+        { 0x00008e38000038e3ULL, 0xffffe38d00008e38ULL, },
+        { 0x00001c71000071c6ULL, 0x0000c71c00001c71ULL, },
+        { 0xffffcccbffffcccbULL, 0xffffcccbffffcccbULL, },    /*  32  */
+        { 0xffffccccffffccccULL, 0xffffccccffffccccULL, },
+        { 0xffff7776ffff7776ULL, 0xffff7776ffff7776ULL, },
+        { 0x0000222100002221ULL, 0x0000222100002221ULL, },
+        { 0xffff9998ffff9998ULL, 0xffff9998ffff9998ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x000005afffffb05aULL, 0xffff5b04000005afULL, },
+        { 0xffff93e8ffffe93dULL, 0x00003e93ffff93e8ULL, },
+        { 0x0000333200003332ULL, 0x0000333200003332ULL, },    /*  40  */
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0xffffddddffffddddULL, 0xffffddddffffddddULL, },
+        { 0x0000888800008888ULL, 0x0000888800008888ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000666600006666ULL, 0x0000666600006666ULL, },
+        { 0x00006c16000016c1ULL, 0xffffc16b00006c16ULL, },
+        { 0xfffffa4f00004fa4ULL, 0x0000a4fafffffa4fULL, },
+        { 0xffffe38dffff8e37ULL, 0x000038e2ffffe38dULL, },    /*  48  */
+        { 0xffffe38effff8e38ULL, 0x000038e3ffffe38eULL, },
+        { 0xffff8e38ffff38e2ULL, 0xffffe38dffff8e38ULL, },
+        { 0x000038e3ffffe38dULL, 0x00008e38000038e3ULL, },
+        { 0xffffb05affff5b04ULL, 0x000005afffffb05aULL, },
+        { 0x000016c1ffffc16bULL, 0x00006c16000016c1ULL, },
+        { 0x00001c71ffff71c6ULL, 0xffffc71b00001c71ULL, },
+        { 0xffffaaaaffffaaa9ULL, 0x0000aaaaffffaaaaULL, },
+        { 0x00001c70000071c6ULL, 0xffffc71b00001c70ULL, },    /*  56  */
+        { 0x00001c71000071c7ULL, 0xffffc71c00001c71ULL, },
+        { 0xffffc71b00001c71ULL, 0xffff71c6ffffc71bULL, },
+        { 0x000071c60000c71cULL, 0x00001c71000071c6ULL, },
+        { 0xffffe93d00003e93ULL, 0xffff93e8ffffe93dULL, },
+        { 0x00004fa40000a4faULL, 0xfffffa4f00004fa4ULL, },
+        { 0x0000555400005555ULL, 0xffff555400005554ULL, },
+        { 0xffffe38d00008e38ULL, 0x000038e3ffffe38dULL, },
+        { 0xffff6f3600007da2ULL, 0x000056c5ffffae87ULL, },    /*  64  */
+        { 0xffff88cdffffef6aULL, 0x0000068100005177ULL, },
+        { 0xffff3714ffffb3e2ULL, 0x000012660000238fULL, },
+        { 0xffff9eb700000ab0ULL, 0xffffd43fffffe11bULL, },
+        { 0xffffe28a0000a2d3ULL, 0x00001e55ffffc54bULL, },
+        { 0xfffffc210000149bULL, 0xffffce110000683bULL, },
+        { 0xffffaa68ffffd913ULL, 0xffffd9f600003a53ULL, },
+        { 0x0000120b00002fe1ULL, 0xffff9bcffffff7dfULL, },
+        { 0xffff932600000f0fULL, 0x00003336ffff5b37ULL, },    /*  72  */
+        { 0xffffacbdffff80d7ULL, 0xffffe2f2fffffe27ULL, },
+        { 0xffff5b04ffff454fULL, 0xffffeed7ffffd03fULL, },
+        { 0xffffc2a7ffff9c1dULL, 0xffffb0b0ffff8dcbULL, },
+        { 0x0000571b0000b371ULL, 0xffff994fffff594eULL, },
+        { 0x000070b200002539ULL, 0xffff490bfffffc3eULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_S_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_S_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
new file mode 100644
index 0000000..76f36a7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction HADD_U.D
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "HADD_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x00000001fffffffeULL, 0x00000001fffffffeULL, },    /*   0  */
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },
+        { 0x00000001aaaaaaa9ULL, 0x00000001aaaaaaa9ULL, },
+        { 0x0000000155555554ULL, 0x0000000155555554ULL, },
+        { 0x00000001cccccccbULL, 0x00000001cccccccbULL, },
+        { 0x0000000133333332ULL, 0x0000000133333332ULL, },
+        { 0x000000018e38e38dULL, 0x00000001e38e38e2ULL, },
+        { 0x0000000171c71c70ULL, 0x000000011c71c71bULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x000000008e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0x0000000071c71c71ULL, 0x000000001c71c71cULL, },
+        { 0x00000001aaaaaaa9ULL, 0x00000001aaaaaaa9ULL, },    /*  16  */
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000155555554ULL, 0x0000000155555554ULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000177777776ULL, 0x0000000177777776ULL, },
+        { 0x00000000ddddddddULL, 0x00000000ddddddddULL, },
+        { 0x0000000138e38e38ULL, 0x000000018e38e38dULL, },
+        { 0x000000011c71c71bULL, 0x00000000c71c71c6ULL, },
+        { 0x0000000155555554ULL, 0x0000000155555554ULL, },    /*  24  */
+        { 0x0000000055555555ULL, 0x0000000055555555ULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000000aaaaaaaaULL, },
+        { 0x0000000122222221ULL, 0x0000000122222221ULL, },
+        { 0x0000000088888888ULL, 0x0000000088888888ULL, },
+        { 0x00000000e38e38e3ULL, 0x0000000138e38e38ULL, },
+        { 0x00000000c71c71c6ULL, 0x0000000071c71c71ULL, },
+        { 0x00000001cccccccbULL, 0x00000001cccccccbULL, },    /*  32  */
+        { 0x00000000ccccccccULL, 0x00000000ccccccccULL, },
+        { 0x0000000177777776ULL, 0x0000000177777776ULL, },
+        { 0x0000000122222221ULL, 0x0000000122222221ULL, },
+        { 0x0000000199999998ULL, 0x0000000199999998ULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },
+        { 0x000000015b05b05aULL, 0x00000001b05b05afULL, },
+        { 0x000000013e93e93dULL, 0x00000000e93e93e8ULL, },
+        { 0x0000000133333332ULL, 0x0000000133333332ULL, },    /*  40  */
+        { 0x0000000033333333ULL, 0x0000000033333333ULL, },
+        { 0x00000000ddddddddULL, 0x00000000ddddddddULL, },
+        { 0x0000000088888888ULL, 0x0000000088888888ULL, },
+        { 0x00000000ffffffffULL, 0x00000000ffffffffULL, },
+        { 0x0000000066666666ULL, 0x0000000066666666ULL, },
+        { 0x00000000c16c16c1ULL, 0x0000000116c16c16ULL, },
+        { 0x00000000a4fa4fa4ULL, 0x000000004fa4fa4fULL, },
+        { 0x00000001e38e38e2ULL, 0x0000000138e38e37ULL, },    /*  48  */
+        { 0x00000000e38e38e3ULL, 0x0000000038e38e38ULL, },
+        { 0x000000018e38e38dULL, 0x00000000e38e38e2ULL, },
+        { 0x0000000138e38e38ULL, 0x000000008e38e38dULL, },
+        { 0x00000001b05b05afULL, 0x0000000105b05b04ULL, },
+        { 0x0000000116c16c16ULL, 0x000000006c16c16bULL, },
+        { 0x0000000171c71c71ULL, 0x000000011c71c71bULL, },
+        { 0x0000000155555554ULL, 0x0000000055555554ULL, },
+        { 0x000000011c71c71bULL, 0x00000001c71c71c6ULL, },    /*  56  */
+        { 0x000000001c71c71cULL, 0x00000000c71c71c7ULL, },
+        { 0x00000000c71c71c6ULL, 0x0000000171c71c71ULL, },
+        { 0x0000000071c71c71ULL, 0x000000011c71c71cULL, },
+        { 0x00000000e93e93e8ULL, 0x0000000193e93e93ULL, },
+        { 0x000000004fa4fa4fULL, 0x00000000fa4fa4faULL, },
+        { 0x00000000aaaaaaaaULL, 0x00000001aaaaaaaaULL, },
+        { 0x000000008e38e38dULL, 0x00000000e38e38e3ULL, },
+        { 0x00000000b0cd3c0cULL, 0x0000000149e2bb6aULL, },    /*  64  */
+        { 0x00000000d5feadd4ULL, 0x0000000060a65e5aULL, },
+        { 0x00000001423a724cULL, 0x00000000f6923072ULL, },
+        { 0x00000000e69cc91aULL, 0x00000000f4a9edfeULL, },
+        { 0x00000001242055a3ULL, 0x0000000111736b26ULL, },
+        { 0x000000014951c76bULL, 0x0000000028370e16ULL, },
+        { 0x00000001b58d8be3ULL, 0x00000000be22e02eULL, },
+        { 0x0000000159efe2b1ULL, 0x00000000bc3a9dbaULL, },
+        { 0x00000000d4bd03eaULL, 0x000000012654770bULL, },    /*  72  */
+        { 0x00000000f9ee75b2ULL, 0x000000003d1819fbULL, },
+        { 0x00000001662a3a2aULL, 0x00000000d303ec13ULL, },
+        { 0x000000010a8c90f8ULL, 0x00000000d11ba99fULL, },
+        { 0x0000000098b16b8dULL, 0x000000018c6d38e4ULL, },
+        { 0x00000000bde2dd55ULL, 0x00000000a330dbd4ULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_U_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_U_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
new file mode 100644
index 0000000..a377c10
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction HADD_U.H
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "HADD_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x01fe01fe01fe01feULL, 0x01fe01fe01fe01feULL, },    /*   0  */
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },
+        { 0x01a901a901a901a9ULL, 0x01a901a901a901a9ULL, },
+        { 0x0154015401540154ULL, 0x0154015401540154ULL, },
+        { 0x01cb01cb01cb01cbULL, 0x01cb01cb01cb01cbULL, },
+        { 0x0132013201320132ULL, 0x0132013201320132ULL, },
+        { 0x018d01e20137018dULL, 0x01e20137018d01e2ULL, },
+        { 0x0170011b01c60170ULL, 0x011b01c60170011bULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x008e00e30038008eULL, 0x00e30038008e00e3ULL, },
+        { 0x0071001c00c70071ULL, 0x001c00c70071001cULL, },
+        { 0x01a901a901a901a9ULL, 0x01a901a901a901a9ULL, },    /*  16  */
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0154015401540154ULL, 0x0154015401540154ULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },
+        { 0x0176017601760176ULL, 0x0176017601760176ULL, },
+        { 0x00dd00dd00dd00ddULL, 0x00dd00dd00dd00ddULL, },
+        { 0x0138018d00e20138ULL, 0x018d00e20138018dULL, },
+        { 0x011b00c60171011bULL, 0x00c60171011b00c6ULL, },
+        { 0x0154015401540154ULL, 0x0154015401540154ULL, },    /*  24  */
+        { 0x0055005500550055ULL, 0x0055005500550055ULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },
+        { 0x00aa00aa00aa00aaULL, 0x00aa00aa00aa00aaULL, },
+        { 0x0121012101210121ULL, 0x0121012101210121ULL, },
+        { 0x0088008800880088ULL, 0x0088008800880088ULL, },
+        { 0x00e30138008d00e3ULL, 0x0138008d00e30138ULL, },
+        { 0x00c60071011c00c6ULL, 0x0071011c00c60071ULL, },
+        { 0x01cb01cb01cb01cbULL, 0x01cb01cb01cb01cbULL, },    /*  32  */
+        { 0x00cc00cc00cc00ccULL, 0x00cc00cc00cc00ccULL, },
+        { 0x0176017601760176ULL, 0x0176017601760176ULL, },
+        { 0x0121012101210121ULL, 0x0121012101210121ULL, },
+        { 0x0198019801980198ULL, 0x0198019801980198ULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },
+        { 0x015a01af0104015aULL, 0x01af0104015a01afULL, },
+        { 0x013d00e80193013dULL, 0x00e80193013d00e8ULL, },
+        { 0x0132013201320132ULL, 0x0132013201320132ULL, },    /*  40  */
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x00dd00dd00dd00ddULL, 0x00dd00dd00dd00ddULL, },
+        { 0x0088008800880088ULL, 0x0088008800880088ULL, },
+        { 0x00ff00ff00ff00ffULL, 0x00ff00ff00ff00ffULL, },
+        { 0x0066006600660066ULL, 0x0066006600660066ULL, },
+        { 0x00c10116006b00c1ULL, 0x0116006b00c10116ULL, },
+        { 0x00a4004f00fa00a4ULL, 0x004f00fa00a4004fULL, },
+        { 0x01e20137018d01e2ULL, 0x0137018d01e20137ULL, },    /*  48  */
+        { 0x00e30038008e00e3ULL, 0x0038008e00e30038ULL, },
+        { 0x018d00e20138018dULL, 0x00e20138018d00e2ULL, },
+        { 0x0138008d00e30138ULL, 0x008d00e30138008dULL, },
+        { 0x01af0104015a01afULL, 0x0104015a01af0104ULL, },
+        { 0x0116006b00c10116ULL, 0x006b00c10116006bULL, },
+        { 0x0171011b00c60171ULL, 0x011b00c60171011bULL, },
+        { 0x0154005401550154ULL, 0x0054015501540054ULL, },
+        { 0x011b01c60170011bULL, 0x01c60170011b01c6ULL, },    /*  56  */
+        { 0x001c00c70071001cULL, 0x00c70071001c00c7ULL, },
+        { 0x00c60171011b00c6ULL, 0x0171011b00c60171ULL, },
+        { 0x0071011c00c60071ULL, 0x011c00c60071011cULL, },
+        { 0x00e80193013d00e8ULL, 0x0193013d00e80193ULL, },
+        { 0x004f00fa00a4004fULL, 0x00fa00a4004f00faULL, },
+        { 0x00aa01aa00a900aaULL, 0x01aa00a900aa01aaULL, },
+        { 0x008d00e30138008dULL, 0x00e30138008d00e3ULL, },
+        { 0x00f201b2008a0095ULL, 0x00b20069017900bcULL, },    /*  64  */
+        { 0x0146014900bb005dULL, 0x01420025013d01acULL, },
+        { 0x00e2019000f700d5ULL, 0x0123010a012900c4ULL, },
+        { 0x00d70133005900a3ULL, 0x013c00e301400150ULL, },
+        { 0x016500cc00af0107ULL, 0x007901190090005eULL, },
+        { 0x01b9006300e000cfULL, 0x010900d50054014eULL, },
+        { 0x015500aa011c0147ULL, 0x00ea01ba00400066ULL, },
+        { 0x014a004d007e0115ULL, 0x01030193005700f2ULL, },
+        { 0x0116017a011b00cbULL, 0x008e012401260031ULL, },    /*  72  */
+        { 0x016a0111014c0093ULL, 0x011e00e000ea0121ULL, },
+        { 0x010601580188010bULL, 0x00ff01c500d60039ULL, },
+        { 0x00fb00fb00ea00d9ULL, 0x0118019e00ed00c5ULL, },
+        { 0x00da00e200c00122ULL, 0x00f400e6012400eeULL, },
+        { 0x012e007900f100eaULL, 0x018400a200e801deULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_U_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_U_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/test=
s/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
new file mode 100644
index 0000000..4f4c54a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -0,0 +1,151 @@
+/*
+ *  Test program for MSA instruction HADD_U.W
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
+#define TEST_COUNT_TOTAL (                                                =
\
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + =
\
+            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *instruction_name =3D "HADD_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] =3D {
+        { 0x0001fffe0001fffeULL, 0x0001fffe0001fffeULL, },    /*   0  */
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },
+        { 0x0001aaa90001aaa9ULL, 0x0001aaa90001aaa9ULL, },
+        { 0x0001555400015554ULL, 0x0001555400015554ULL, },
+        { 0x0001cccb0001cccbULL, 0x0001cccb0001cccbULL, },
+        { 0x0001333200013332ULL, 0x0001333200013332ULL, },
+        { 0x000138e20001e38dULL, 0x00018e37000138e2ULL, },
+        { 0x0001c71b00011c70ULL, 0x000171c60001c71bULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x000038e30000e38eULL, 0x00008e38000038e3ULL, },
+        { 0x0000c71c00001c71ULL, 0x000071c70000c71cULL, },
+        { 0x0001aaa90001aaa9ULL, 0x0001aaa90001aaa9ULL, },    /*  16  */
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0001555400015554ULL, 0x0001555400015554ULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },
+        { 0x0001777600017776ULL, 0x0001777600017776ULL, },
+        { 0x0000dddd0000ddddULL, 0x0000dddd0000ddddULL, },
+        { 0x0000e38d00018e38ULL, 0x000138e20000e38dULL, },
+        { 0x000171c60000c71bULL, 0x00011c71000171c6ULL, },
+        { 0x0001555400015554ULL, 0x0001555400015554ULL, },    /*  24  */
+        { 0x0000555500005555ULL, 0x0000555500005555ULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },
+        { 0x0000aaaa0000aaaaULL, 0x0000aaaa0000aaaaULL, },
+        { 0x0001222100012221ULL, 0x0001222100012221ULL, },
+        { 0x0000888800008888ULL, 0x0000888800008888ULL, },
+        { 0x00008e38000138e3ULL, 0x0000e38d00008e38ULL, },
+        { 0x00011c71000071c6ULL, 0x0000c71c00011c71ULL, },
+        { 0x0001cccb0001cccbULL, 0x0001cccb0001cccbULL, },    /*  32  */
+        { 0x0000cccc0000ccccULL, 0x0000cccc0000ccccULL, },
+        { 0x0001777600017776ULL, 0x0001777600017776ULL, },
+        { 0x0001222100012221ULL, 0x0001222100012221ULL, },
+        { 0x0001999800019998ULL, 0x0001999800019998ULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },
+        { 0x000105af0001b05aULL, 0x00015b04000105afULL, },
+        { 0x000193e80000e93dULL, 0x00013e93000193e8ULL, },
+        { 0x0001333200013332ULL, 0x0001333200013332ULL, },    /*  40  */
+        { 0x0000333300003333ULL, 0x0000333300003333ULL, },
+        { 0x0000dddd0000ddddULL, 0x0000dddd0000ddddULL, },
+        { 0x0000888800008888ULL, 0x0000888800008888ULL, },
+        { 0x0000ffff0000ffffULL, 0x0000ffff0000ffffULL, },
+        { 0x0000666600006666ULL, 0x0000666600006666ULL, },
+        { 0x00006c16000116c1ULL, 0x0000c16b00006c16ULL, },
+        { 0x0000fa4f00004fa4ULL, 0x0000a4fa0000fa4fULL, },
+        { 0x0001e38d00018e37ULL, 0x000138e20001e38dULL, },    /*  48  */
+        { 0x0000e38e00008e38ULL, 0x000038e30000e38eULL, },
+        { 0x00018e38000138e2ULL, 0x0000e38d00018e38ULL, },
+        { 0x000138e30000e38dULL, 0x00008e38000138e3ULL, },
+        { 0x0001b05a00015b04ULL, 0x000105af0001b05aULL, },
+        { 0x000116c10000c16bULL, 0x00006c16000116c1ULL, },
+        { 0x00011c71000171c6ULL, 0x0000c71b00011c71ULL, },
+        { 0x0001aaaa0000aaa9ULL, 0x0000aaaa0001aaaaULL, },
+        { 0x00011c70000171c6ULL, 0x0001c71b00011c70ULL, },    /*  56  */
+        { 0x00001c71000071c7ULL, 0x0000c71c00001c71ULL, },
+        { 0x0000c71b00011c71ULL, 0x000171c60000c71bULL, },
+        { 0x000071c60000c71cULL, 0x00011c71000071c6ULL, },
+        { 0x0000e93d00013e93ULL, 0x000193e80000e93dULL, },
+        { 0x00004fa40000a4faULL, 0x0000fa4f00004fa4ULL, },
+        { 0x0000555400015555ULL, 0x0001555400005554ULL, },
+        { 0x0000e38d00008e38ULL, 0x000138e30000e38dULL, },
+        { 0x00016f3600007da2ULL, 0x000056c50001ae87ULL, },    /*  64  */
+        { 0x000088cd0000ef6aULL, 0x0001068100015177ULL, },
+        { 0x000137140000b3e2ULL, 0x000112660001238fULL, },
+        { 0x00009eb700010ab0ULL, 0x0000d43f0001e11bULL, },
+        { 0x0001e28a0000a2d3ULL, 0x00001e550000c54bULL, },
+        { 0x0000fc210001149bULL, 0x0000ce110000683bULL, },
+        { 0x0001aa680000d913ULL, 0x0000d9f600003a53ULL, },
+        { 0x0001120b00012fe1ULL, 0x00009bcf0000f7dfULL, },
+        { 0x0001932600010f0fULL, 0x0000333600015b37ULL, },    /*  72  */
+        { 0x0000acbd000180d7ULL, 0x0000e2f20000fe27ULL, },
+        { 0x00015b040001454fULL, 0x0000eed70000d03fULL, },
+        { 0x0000c2a700019c1dULL, 0x0000b0b000018dcbULL, },
+        { 0x0001571b0000b371ULL, 0x0000994f0001594eULL, },
+        { 0x000070b200012539ULL, 0x0001490b0000fc3eULL, },
+};
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_U_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]=
);
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_HADD_U_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j])=
;
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results(instruction_name, TEST_COUNT_TOTAL, elapsed_time=
,
+                        &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
--
2.7.4
