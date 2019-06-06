Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04262C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F9720673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F9720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYu4X-0004dH-Od
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:12:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYu04-0000im-5B
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYtzw-00063o-V2
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:08:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51425 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hYtzw-000610-5J
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:08:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id DA2831A2223;
	Thu,  6 Jun 2019 17:07:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 916C21A2218;
	Thu,  6 Jun 2019 17:07:00 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:06:42 +0200
Message-Id: <1559833603-29660-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559833603-29660-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559833603-29660-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 09/10] tests/tcg: target/mips: Add tests for
 MSA FP max/min instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add tests for MSA FP max/min instructions. This includes following
instructions:

  * FMAX.W - float maximum (words)
  * FMAX.D - float maximum (doublewords)
  * FMAX_A.W - float maximum absolute (words)
  * FMAX_A.D - float maximum absolute (doublewords)
  * FMIN.W - float minimum (words)
  * FMIN.D - float minimum (doublewords)
  * FMIN_A.W - float minimum absolute (words)
  * FMIN_A.D - float minimum absolute (doublewords)

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../user/ase/msa/float-max-min/test_msa_fmax_a_d.c | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmax_a_w.c | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmax_d.c   | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmax_w.c   | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_a_d.c | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_a_w.c | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_d.c   | 155 +++++++++++++++++++++
 .../user/ase/msa/float-max-min/test_msa_fmin_w.c   | 155 +++++++++++++++++++++
 8 files changed, 1240 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c

diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
new file mode 100644
index 0000000..1807cab
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMAX_A.D
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
+    char *instruction_name = "FMAX_A.D";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x5555555555555555ULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_A_D(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_A_D(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
new file mode 100644
index 0000000..b999b1f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMAX_A.W
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
+    char *instruction_name = "FMAX_A.W";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaa71c71c71ULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xe38e38e355555555ULL, 0x55555555e38e38e3ULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xcccccccc71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333371c71c71ULL, 0xc71c71c733333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e355555555ULL, 0x55555555e38e38e3ULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xe38e38e333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e371c71c71ULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaa71c71c71ULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0xcccccccc71c71c71ULL, 0xccccccccccccccccULL, },
+        { 0x3333333371c71c71ULL, 0xc71c71c733333333ULL, },
+        { 0xe38e38e371c71c71ULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xfbbe00635e31e24eULL, 0x12f7bb1aa942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00635e31e24eULL, 0x12f7bb1aa942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_A_W(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_A_W(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
new file mode 100644
index 0000000..b5ce6c7
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMAX.D
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
+    char *instruction_name = "FMAX.D";
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
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0x38e38e38e38e38e3ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5efe7bb00cULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
new file mode 100644
index 0000000..5fafd30
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMAX.W
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
+    char *instruction_name = "FMAX.W";
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
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0000000000000000ULL, 0x38e38e3800000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x000000001c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0x38e38e38aaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x38e38e3833333333ULL, },
+        { 0x3333333371c71c71ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x38e38e3800000000ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0x38e38e38aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x3333333333333333ULL, 0x38e38e3833333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0x000000001c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x5555555571c71c71ULL, 0x5555555555555555ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333371c71c71ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc4d93c708ULL, 0x4b670b5e153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5eab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5ea942e2a0ULL, },
+        { 0x886ae6cc4d93c708ULL, 0x4b670b5e153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaa4d93c708ULL, 0x27d8c6ff153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5eab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaa4d93c708ULL, 0x27d8c6ff153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffa942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x4b670b5ea942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x27d8c6ffa942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMAX_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
new file mode 100644
index 0000000..c0b4001
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMIN_A.D
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
+    char *instruction_name = "FMIN_A.D";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x5555555555555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x38e38e38e38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0x38e38e38e38e38e3ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_A_D(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_A_D(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
new file mode 100644
index 0000000..d174fcd
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMIN_A.W
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
+    char *instruction_name = "FMIN_A.W";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x1c71c71caaaaaaaaULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x555555558e38e38eULL, 0x38e38e3855555555ULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x1c71c71cccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x333333338e38e38eULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c33333333ULL, 0x333333331c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaa8e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x555555558e38e38eULL, 0x38e38e3855555555ULL, },
+        { 0xcccccccc8e38e38eULL, 0x38e38e38ccccccccULL, },
+        { 0x333333338e38e38eULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c8e38e38eULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71caaaaaaaaULL, 0xaaaaaaaa1c71c71cULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71cccccccccULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c33333333ULL, 0x333333331c71c71cULL, },
+        { 0x1c71c71c8e38e38eULL, 0x38e38e381c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x704f164d4d93c708ULL, 0x8df188d8153f52fcULL, },
+        { 0x886ae6cc28625540ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xac5aaeaab9cf8b80ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d4d93c708ULL, 0x8df188d8153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_A_W(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_A_W(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
new file mode 100644
index 0000000..62c149f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMIN.D
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
+    char *instruction_name = "FMIN.D";
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
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e38e38e38eULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c71c71c71c71cULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },    /*  72  */
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
new file mode 100644
index 0000000..c5815a6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
@@ -0,0 +1,155 @@
+/*
+ *  Test program for MSA instruction FMIN.W
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
+    char *instruction_name = "FMIN.W";
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
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0xaaaaaaaae38e38e3ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x33333333e38e38e3ULL, },
+        { 0x1c71c71c33333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x00000000e38e38e3ULL, },
+        { 0xe38e38e3aaaaaaaaULL, 0xaaaaaaaae38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e3ccccccccULL, 0xcccccccce38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x33333333e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0xc71c71c700000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xc71c71c7aaaaaaaaULL, },
+        { 0x1c71c71c55555555ULL, 0xc71c71c71c71c71cULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x1c71c71c33333333ULL, 0xc71c71c71c71c71cULL, },
+        { 0xe38e38e38e38e38eULL, 0xc71c71c7e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0xfbbe006328625540ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6fffe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8fe7bb00cULL, },
+        { 0xfbbe006328625540ULL, 0x12f7bb1afe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe0063b9cf8b80ULL, 0x12f7bb1aab2b2514ULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6fffe7bb00cULL, },    /*  72  */
+        { 0xfbbe0063b9cf8b80ULL, 0x12f7bb1aab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8ab2b2514ULL, },
+        { 0x886ae6cc28625540ULL, 0x8df188d8fe7bb00cULL, },
+        { 0xfbbe00634d93c708ULL, 0x8df188d8a942e2a0ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8df188d8ab2b2514ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_FMIN_W(b128_random[i], b128_random[j],
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


