Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AFCC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E71208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E71208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDIi-0002cb-4h
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59695)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBlM-0004PV-4G
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hZBl6-0008E5-CY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50257 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hZBl5-00088b-4H
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:06:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AB9451A1EAE;
 Fri,  7 Jun 2019 12:05:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1E5581A1D0E;
 Fri,  7 Jun 2019 12:05:50 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 12:05:40 +0200
Message-Id: <1559901944-4578-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559901944-4578-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 06/10] tests/tcg: target/mips: Add tests for MSA
 shift instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add tests for MSA shift instructions. This includes following
instructions:

  * SLL.B - shift left logical (bytes)
  * SLL.H - shift left logical (halfwords)
  * SLL.W - shift left logical (words)
  * SLL.D - shift left logical (doublewords)
  * SRA.B - shift right arithmetic (bytes)
  * SRA.H - shift right arithmetic (halfwords)
  * SRA.W - shift right arithmetic (words)
  * SRA.D - shift right arithmetic (doublewords)
  * SRAR.B - shift right arithmetic rounded (bytes)
  * SRAR.H - shift right arithmetic rounded (halfwords)
  * SRAR.W - shift right arithmetic rounded (words)
  * SRAR.D - shift right arithmetic rounded (doublewords)
  * SRL.B - shift right logical (bytes)
  * SRL.H - shift right logical (halfwords)
  * SRL.W - shift right logical (words)
  * SRL.D - shift right logical (doublewords)
  * SRLR.B - shift right logical rounded (bytes)
  * SRLR.H - shift right logical rounded (halfwords)
  * SRLR.W - shift right logical rounded (words)
  * SRLR.D - shift right logical rounded (doublewords)

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559838440-9866-7-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_b.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_d.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_h.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srar_w.c  | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c  | 153 +++++++++++++++++++++
 .../tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c  | 153 +++++++++++++++++++++
 20 files changed, 3060 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c

diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
new file mode 100644
index 0000000..f5096ee
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SLL.B
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
+    char *instruction_name = "SLL.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xe0e0e0e0e0e0e0e0ULL, 0xe0e0e0e0e0e0e0e0ULL, },
+        { 0xf0f0f0f0f0f0f0f0ULL, 0xf0f0f0f0f0f0f0f0ULL, },
+        { 0xf8f8f8f8f8f8f8f8ULL, 0xf8f8f8f8f8f8f8f8ULL, },
+        { 0xf8c0fff8c0fff8c0ULL, 0xfff8c0fff8c0fff8ULL, },
+        { 0xf0fe80f0fe80f0feULL, 0x80f0fe80f0fe80f0ULL, },
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
+        { 0xa8a8a8a8a8a8a8a8ULL, 0xa8a8a8a8a8a8a8a8ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
+        { 0xa0a0a0a0a0a0a0a0ULL, 0xa0a0a0a0a0a0a0a0ULL, },
+        { 0x5050505050505050ULL, 0x5050505050505050ULL, },
+        { 0x5080aa5080aa5080ULL, 0xaa5080aa5080aa50ULL, },
+        { 0xa05400a05400a054ULL, 0x00a05400a05400a0ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5454545454545454ULL, 0x5454545454545454ULL, },
+        { 0xa0a0a0a0a0a0a0a0ULL, 0xa0a0a0a0a0a0a0a0ULL, },
+        { 0x5050505050505050ULL, 0x5050505050505050ULL, },
+        { 0xa8a8a8a8a8a8a8a8ULL, 0xa8a8a8a8a8a8a8a8ULL, },
+        { 0xa84055a84055a840ULL, 0x55a84055a84055a8ULL, },
+        { 0x50aa8050aa8050aaULL, 0x8050aa8050aa8050ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3030303030303030ULL, 0x3030303030303030ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0xc0c0c0c0c0c0c0c0ULL, 0xc0c0c0c0c0c0c0c0ULL, },
+        { 0x6060606060606060ULL, 0x6060606060606060ULL, },
+        { 0x6000cc6000cc6000ULL, 0xcc6000cc6000cc60ULL, },
+        { 0xc09800c09800c098ULL, 0x00c09800c09800c0ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x6060606060606060ULL, 0x6060606060606060ULL, },
+        { 0x3030303030303030ULL, 0x3030303030303030ULL, },
+        { 0x9898989898989898ULL, 0x9898989898989898ULL, },
+        { 0x98c03398c03398c0ULL, 0x3398c03398c03398ULL, },
+        { 0x3066803066803066ULL, 0x8030668030668030ULL, },
+        { 0x8000008000008000ULL, 0x0080000080000080ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x8c38e08c38e08c38ULL, 0xe08c38e08c38e08cULL, },
+        { 0x60c00060c00060c0ULL, 0x0060c00060c00060ULL, },
+        { 0x30e08030e08030e0ULL, 0x8030e08030e08030ULL, },
+        { 0x1870c01870c01870ULL, 0xc01870c01870c018ULL, },
+        { 0x1880381880381880ULL, 0x3818803818803818ULL, },
+        { 0x301c00301c00301cULL, 0x00301c00301c0030ULL, },
+        { 0x0080800080800080ULL, 0x8000808000808000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x70c41c70c41c70c4ULL, 0x1c70c41c70c41c70ULL, },
+        { 0x8020e08020e08020ULL, 0xe08020e08020e080ULL, },
+        { 0xc01070c01070c010ULL, 0x70c01070c01070c0ULL, },
+        { 0xe08838e08838e088ULL, 0x38e08838e08838e0ULL, },
+        { 0xe040c7e040c7e040ULL, 0xc7e040c7e040c7e0ULL, },
+        { 0xc0e280c0e280c0e2ULL, 0x80c0e280c0e280c0ULL, },
+        { 0x88a880c02888a040ULL, 0x5880588080d8b0c0ULL, },    /*  64  */
+        { 0x4080e66000108040ULL, 0x2c805878c080c0c0ULL, },
+        { 0x80a880305000a840ULL, 0x8067c000f0d800c0ULL, },
+        { 0x8800808000c45400ULL, 0x60ce0b5efcecc00cULL, },
+        { 0xfbf800304d4ce008ULL, 0x9080d88040f852c0ULL, },
+        { 0xd8800018a0988008ULL, 0x4880d868a08048c0ULL, },
+        { 0xb0f8008c9a803808ULL, 0x00f7c000a8f840c0ULL, },
+        { 0xfb00006040261c00ULL, 0x40eebb1a2afc48fcULL, },
+        { 0xac6880a0b93c6080ULL, 0x380030c0c0582540ULL, },    /*  72  */
+        { 0x6080ae5020788080ULL, 0x9c0030fc60809440ULL, },
+        { 0xc06880a872805880ULL, 0x80d880805858a040ULL, },
+        { 0xac008040409e2c00ULL, 0xe0b0c6ff56ac9414ULL, },
+        { 0x703c80d05ec4404eULL, 0x688040004010e200ULL, },
+        { 0x80c01668c088004eULL, 0x3480406020008800ULL, },
+        { 0x003c8034bc80104eULL, 0x80f1000048104000ULL, },
+        { 0x708080a080628880ULL, 0xa0e288d8520888a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_B(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
new file mode 100644
index 0000000..8be216b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SLL.D
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
+    char *instruction_name = "SLL.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfffffc0000000000ULL, 0xfffffc0000000000ULL, },
+        { 0xffffffffffe00000ULL, 0xffffffffffe00000ULL, },
+        { 0xfffffffffffff000ULL, 0xfffffffffffff000ULL, },
+        { 0xfff8000000000000ULL, 0xfff8000000000000ULL, },
+        { 0xffffffffffffc000ULL, 0xfffffff800000000ULL, },
+        { 0xfffe000000000000ULL, 0xfffffffff0000000ULL, },
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
+        { 0xaaaaa80000000000ULL, 0xaaaaa80000000000ULL, },
+        { 0x5555555555400000ULL, 0x5555555555400000ULL, },
+        { 0xaaaaaaaaaaaaa000ULL, 0xaaaaaaaaaaaaa000ULL, },
+        { 0x5550000000000000ULL, 0x5550000000000000ULL, },
+        { 0xaaaaaaaaaaaa8000ULL, 0x5555555000000000ULL, },
+        { 0x5554000000000000ULL, 0xaaaaaaaaa0000000ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555540000000000ULL, 0x5555540000000000ULL, },
+        { 0xaaaaaaaaaaa00000ULL, 0xaaaaaaaaaaa00000ULL, },
+        { 0x5555555555555000ULL, 0x5555555555555000ULL, },
+        { 0xaaa8000000000000ULL, 0xaaa8000000000000ULL, },
+        { 0x5555555555554000ULL, 0xaaaaaaa800000000ULL, },
+        { 0xaaaa000000000000ULL, 0x5555555550000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333300000000000ULL, 0x3333300000000000ULL, },
+        { 0x9999999999800000ULL, 0x9999999999800000ULL, },
+        { 0xccccccccccccc000ULL, 0xccccccccccccc000ULL, },
+        { 0x6660000000000000ULL, 0x6660000000000000ULL, },
+        { 0x3333333333330000ULL, 0x6666666000000000ULL, },
+        { 0x9998000000000000ULL, 0xccccccccc0000000ULL, },
+        { 0x8000000000000000ULL, 0x8000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcccccc0000000000ULL, 0xcccccc0000000000ULL, },
+        { 0x6666666666600000ULL, 0x6666666666600000ULL, },
+        { 0x3333333333333000ULL, 0x3333333333333000ULL, },
+        { 0x9998000000000000ULL, 0x9998000000000000ULL, },
+        { 0xccccccccccccc000ULL, 0x9999999800000000ULL, },
+        { 0x6666000000000000ULL, 0x3333333330000000ULL, },
+        { 0x0000000000000000ULL, 0x8000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e380000000000ULL, 0x38e38c0000000000ULL, },
+        { 0x1c71c71c71c00000ULL, 0xc71c71c71c600000ULL, },
+        { 0xe38e38e38e38e000ULL, 0x38e38e38e38e3000ULL, },
+        { 0x1c70000000000000ULL, 0xc718000000000000ULL, },
+        { 0x8e38e38e38e38000ULL, 0x1c71c71800000000ULL, },
+        { 0xc71c000000000000ULL, 0x8e38e38e30000000ULL, },
+        { 0x8000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c40000000000ULL, 0xc71c700000000000ULL, },
+        { 0xe38e38e38e200000ULL, 0x38e38e38e3800000ULL, },
+        { 0x1c71c71c71c71000ULL, 0xc71c71c71c71c000ULL, },
+        { 0xe388000000000000ULL, 0x38e0000000000000ULL, },
+        { 0x71c71c71c71c4000ULL, 0xe38e38e000000000ULL, },
+        { 0x38e2000000000000ULL, 0x71c71c71c0000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x70b5efe7bb00c000ULL, },    /*  64  */
+        { 0x6ae6cc2862554000ULL, 0xc000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0xb5efe7bb00c00000ULL, },
+        { 0xb9b30a1895500000ULL, 0xfe7bb00c00000000ULL, },
+        { 0xfbbe00634d93c708ULL, 0x7bb1a153f52fc000ULL, },
+        { 0xbe00634d93c70800ULL, 0xc000000000000000ULL, },
+        { 0xfbbe00634d93c708ULL, 0xb1a153f52fc00000ULL, },
+        { 0x8018d364f1c20000ULL, 0x153f52fc00000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x8c6ffab2b2514000ULL, },    /*  72  */
+        { 0x5aaeaab9cf8b8000ULL, 0x4000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x6ffab2b251400000ULL, },
+        { 0xabaaae73e2e00000ULL, 0xab2b251400000000ULL, },
+        { 0x704f164d5e31e24eULL, 0x188d8a942e2a0000ULL, },
+        { 0x4f164d5e31e24e00ULL, 0x0000000000000000ULL, },
+        { 0x704f164d5e31e24eULL, 0x8d8a942e2a000000ULL, },
+        { 0xc593578c78938000ULL, 0xa942e2a000000000ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_D(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
new file mode 100644
index 0000000..6a7cc6b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SLL.H
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
+    char *instruction_name = "SLL.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfc00fc00fc00fc00ULL, 0xfc00fc00fc00fc00ULL, },
+        { 0xffe0ffe0ffe0ffe0ULL, 0xffe0ffe0ffe0ffe0ULL, },
+        { 0xf000f000f000f000ULL, 0xf000f000f000f000ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xc000fff8ff00c000ULL, 0xfff8ff00c000fff8ULL, },
+        { 0xfffef000ff80fffeULL, 0xf000ff80fffef000ULL, },
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
+        { 0xa800a800a800a800ULL, 0xa800a800a800a800ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
+        { 0xa000a000a000a000ULL, 0xa000a000a000a000ULL, },
+        { 0x5550555055505550ULL, 0x5550555055505550ULL, },
+        { 0x80005550aa008000ULL, 0x5550aa0080005550ULL, },
+        { 0x5554a00055005554ULL, 0xa00055005554a000ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5400540054005400ULL, 0x5400540054005400ULL, },
+        { 0xaaa0aaa0aaa0aaa0ULL, 0xaaa0aaa0aaa0aaa0ULL, },
+        { 0x5000500050005000ULL, 0x5000500050005000ULL, },
+        { 0xaaa8aaa8aaa8aaa8ULL, 0xaaa8aaa8aaa8aaa8ULL, },
+        { 0x4000aaa855004000ULL, 0xaaa855004000aaa8ULL, },
+        { 0xaaaa5000aa80aaaaULL, 0x5000aa80aaaa5000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3000300030003000ULL, 0x3000300030003000ULL, },
+        { 0x9980998099809980ULL, 0x9980998099809980ULL, },
+        { 0xc000c000c000c000ULL, 0xc000c000c000c000ULL, },
+        { 0x6660666066606660ULL, 0x6660666066606660ULL, },
+        { 0x00006660cc000000ULL, 0x6660cc0000006660ULL, },
+        { 0x9998c00066009998ULL, 0xc00066009998c000ULL, },
+        { 0x8000800080008000ULL, 0x8000800080008000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcc00cc00cc00cc00ULL, 0xcc00cc00cc00cc00ULL, },
+        { 0x6660666066606660ULL, 0x6660666066606660ULL, },
+        { 0x3000300030003000ULL, 0x3000300030003000ULL, },
+        { 0x9998999899989998ULL, 0x9998999899989998ULL, },
+        { 0xc00099983300c000ULL, 0x99983300c0009998ULL, },
+        { 0x6666300099806666ULL, 0x3000998066663000ULL, },
+        { 0x0000800000000000ULL, 0x8000000000008000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38008c00e0003800ULL, 0x8c00e00038008c00ULL, },
+        { 0x71c01c60c70071c0ULL, 0x1c60c70071c01c60ULL, },
+        { 0xe00030008000e000ULL, 0x30008000e0003000ULL, },
+        { 0x1c70c71871c01c70ULL, 0xc71871c01c70c718ULL, },
+        { 0x8000c71838008000ULL, 0xc71838008000c718ULL, },
+        { 0xc71c30001c00c71cULL, 0x30001c00c71c3000ULL, },
+        { 0x8000000080008000ULL, 0x0000800080000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc40070001c00c400ULL, 0x70001c00c4007000ULL, },
+        { 0x8e20e38038e08e20ULL, 0xe38038e08e20e380ULL, },
+        { 0x1000c00070001000ULL, 0xc00070001000c000ULL, },
+        { 0xe38838e08e38e388ULL, 0x38e08e38e38838e0ULL, },
+        { 0x400038e0c7004000ULL, 0x38e0c700400038e0ULL, },
+        { 0x38e2c000e38038e2ULL, 0xc000e38038e2c000ULL, },
+        { 0xa800c000a1885540ULL, 0xb3808000d800c000ULL, },    /*  64  */
+        { 0x8000366043104000ULL, 0xb38078008000c000ULL, },
+        { 0xa800300000005540ULL, 0x67000000d80000c0ULL, },
+        { 0x0000800050c40000ULL, 0x96ce5e00f9ecb00cULL, },
+        { 0xf8003000364cc708ULL, 0x7b808000f800c000ULL, },
+        { 0x800003186c980800ULL, 0x7b8068008000c000ULL, },
+        { 0xf8008c008000c708ULL, 0xf7000000f8002fc0ULL, },
+        { 0x000060009b260000ULL, 0x25ee1a0054fc52fcULL, },
+        { 0x6800a000e73c8b80ULL, 0xec00c00058004000ULL, },    /*  72  */
+        { 0x80007550ce788000ULL, 0xec00fc0080004000ULL, },
+        { 0x6800a80080008b80ULL, 0xd800800058005140ULL, },
+        { 0x00004000739e0000ULL, 0x4fb0ff00acac2514ULL, },
+        { 0x3c00d00078c4e24eULL, 0xf880000010000000ULL, },
+        { 0xc000b268f1884e00ULL, 0xf880600000000000ULL, },
+        { 0x3c0034008000e24eULL, 0xf100000010002a00ULL, },
+        { 0x8000a000bc628000ULL, 0x1be2d800a508e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_H(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
new file mode 100644
index 0000000..7348f7f
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SLL.W
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
+    char *instruction_name = "SLL.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfffffc00fffffc00ULL, 0xfffffc00fffffc00ULL, },
+        { 0xffe00000ffe00000ULL, 0xffe00000ffe00000ULL, },
+        { 0xfffff000fffff000ULL, 0xfffff000fffff000ULL, },
+        { 0xfff80000fff80000ULL, 0xfff80000fff80000ULL, },
+        { 0xfffffff8ffffc000ULL, 0xff000000fffffff8ULL, },
+        { 0xf0000000fffe0000ULL, 0xffffff80f0000000ULL, },
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
+        { 0xaaaaa800aaaaa800ULL, 0xaaaaa800aaaaa800ULL, },
+        { 0x5540000055400000ULL, 0x5540000055400000ULL, },
+        { 0xaaaaa000aaaaa000ULL, 0xaaaaa000aaaaa000ULL, },
+        { 0x5550000055500000ULL, 0x5550000055500000ULL, },
+        { 0x55555550aaaa8000ULL, 0xaa00000055555550ULL, },
+        { 0xa000000055540000ULL, 0x55555500a0000000ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555540055555400ULL, 0x5555540055555400ULL, },
+        { 0xaaa00000aaa00000ULL, 0xaaa00000aaa00000ULL, },
+        { 0x5555500055555000ULL, 0x5555500055555000ULL, },
+        { 0xaaa80000aaa80000ULL, 0xaaa80000aaa80000ULL, },
+        { 0xaaaaaaa855554000ULL, 0x55000000aaaaaaa8ULL, },
+        { 0x50000000aaaa0000ULL, 0xaaaaaa8050000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333300033333000ULL, 0x3333300033333000ULL, },
+        { 0x9980000099800000ULL, 0x9980000099800000ULL, },
+        { 0xccccc000ccccc000ULL, 0xccccc000ccccc000ULL, },
+        { 0x6660000066600000ULL, 0x6660000066600000ULL, },
+        { 0x6666666033330000ULL, 0xcc00000066666660ULL, },
+        { 0xc000000099980000ULL, 0x66666600c0000000ULL, },
+        { 0x8000000080000000ULL, 0x8000000080000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xcccccc00cccccc00ULL, 0xcccccc00cccccc00ULL, },
+        { 0x6660000066600000ULL, 0x6660000066600000ULL, },
+        { 0x3333300033333000ULL, 0x3333300033333000ULL, },
+        { 0x9998000099980000ULL, 0x9998000099980000ULL, },
+        { 0x99999998ccccc000ULL, 0x3300000099999998ULL, },
+        { 0x3000000066660000ULL, 0x9999998030000000ULL, },
+        { 0x8000000000000000ULL, 0x0000000080000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38e38c00e38e3800ULL, 0x8e38e00038e38c00ULL, },
+        { 0x1c60000071c00000ULL, 0xc70000001c600000ULL, },
+        { 0xe38e30008e38e000ULL, 0x38e38000e38e3000ULL, },
+        { 0xc71800001c700000ULL, 0x71c00000c7180000ULL, },
+        { 0x1c71c71838e38000ULL, 0x380000001c71c718ULL, },
+        { 0x30000000c71c0000ULL, 0x71c71c0030000000ULL, },
+        { 0x0000000080000000ULL, 0x8000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0xc71c70001c71c400ULL, 0x71c71c00c71c7000ULL, },
+        { 0xe38000008e200000ULL, 0x38e00000e3800000ULL, },
+        { 0x1c71c00071c71000ULL, 0xc71c70001c71c000ULL, },
+        { 0x38e00000e3880000ULL, 0x8e38000038e00000ULL, },
+        { 0xe38e38e0c71c4000ULL, 0xc7000000e38e38e0ULL, },
+        { 0xc000000038e20000ULL, 0x8e38e380c0000000ULL, },
+        { 0xae6cc00028625540ULL, 0x80000000bb00c000ULL, },    /*  64  */
+        { 0x4357366062554000ULL, 0x78000000c0000000ULL, },
+        { 0xab9b300028625540ULL, 0x0000000000c00000ULL, },
+        { 0x5cd9800095500000ULL, 0x5e000000fe7bb00cULL, },
+        { 0xe00630004d93c708ULL, 0x80000000f52fc000ULL, },
+        { 0xddf0031893c70800ULL, 0x68000000c0000000ULL, },
+        { 0xf8018c004d93c708ULL, 0x000000002fc00000ULL, },
+        { 0xc00c6000f1c20000ULL, 0x1a000000153f52fcULL, },
+        { 0xaaeaa000b9cf8b80ULL, 0xc0000000b2514000ULL, },    /*  72  */
+        { 0x62d57550cf8b8000ULL, 0xfc00000040000000ULL, },
+        { 0x6abaa800b9cf8b80ULL, 0x8000000051400000ULL, },
+        { 0x55d54000e2e00000ULL, 0xff000000ab2b2514ULL, },
+        { 0xf164d0005e31e24eULL, 0x000000002e2a0000ULL, },
+        { 0x8278b26831e24e00ULL, 0x6000000000000000ULL, },
+        { 0x3c5934005e31e24eULL, 0x000000002a000000ULL, },
+        { 0xe2c9a00078938000ULL, 0xd8000000a942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_W(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SLL_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
new file mode 100644
index 0000000..e8184e5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRA.B
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
+    char *instruction_name = "SRA.B";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xeaeaeaeaeaeaeaeaULL, 0xeaeaeaeaeaeaeaeaULL, },
+        { 0xfdfdfdfdfdfdfdfdULL, 0xfdfdfdfdfdfdfdfdULL, },
+        { 0xfafafafafafafafaULL, 0xfafafafafafafafaULL, },
+        { 0xf5f5f5f5f5f5f5f5ULL, 0xf5f5f5f5f5f5f5f5ULL, },
+        { 0xf5feaaf5feaaf5feULL, 0xaaf5feaaf5feaaf5ULL, },
+        { 0xfad5fffad5fffad5ULL, 0xfffad5fffad5fffaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1515151515151515ULL, 0x1515151515151515ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0a0a0a0a0a0a0a0aULL, 0x0a0a0a0a0a0a0a0aULL, },
+        { 0x0a01550a01550a01ULL, 0x550a01550a01550aULL, },
+        { 0x052a00052a00052aULL, 0x00052a00052a0005ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xf3f3f3f3f3f3f3f3ULL, 0xf3f3f3f3f3f3f3f3ULL, },
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },
+        { 0xfcfcfcfcfcfcfcfcULL, 0xfcfcfcfcfcfcfcfcULL, },
+        { 0xf9f9f9f9f9f9f9f9ULL, 0xf9f9f9f9f9f9f9f9ULL, },
+        { 0xf9ffccf9ffccf9ffULL, 0xccf9ffccf9ffccf9ULL, },
+        { 0xfce6fffce6fffce6ULL, 0xfffce6fffce6fffcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0c0c0c0c0c0c0c0cULL, 0x0c0c0c0c0c0c0c0cULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0x0600330600330600ULL, 0x3306003306003306ULL, },
+        { 0x0319000319000319ULL, 0x0003190003190003ULL, },
+        { 0xffff00ffff00ffffULL, 0x00ffff00ffff00ffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xf8e30ef8e30ef8e3ULL, 0x0ef8e30ef8e30ef8ULL, },
+        { 0xfffc01fffc01fffcULL, 0x01fffc01fffc01ffULL, },
+        { 0xfef803fef803fef8ULL, 0x03fef803fef803feULL, },
+        { 0xfcf107fcf107fcf1ULL, 0x07fcf107fcf107fcULL, },
+        { 0xfcfe38fcfe38fcfeULL, 0x38fcfe38fcfe38fcULL, },
+        { 0xfec700fec700fec7ULL, 0x00fec700fec700feULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x071cf1071cf1071cULL, 0xf1071cf1071cf107ULL, },
+        { 0x0003fe0003fe0003ULL, 0xfe0003fe0003fe00ULL, },
+        { 0x0107fc0107fc0107ULL, 0xfc0107fc0107fc01ULL, },
+        { 0x030ef8030ef8030eULL, 0xf8030ef8030ef803ULL, },
+        { 0x0301c70301c70301ULL, 0xc70301c70301c703ULL, },
+        { 0x0138ff0138ff0138ULL, 0xff0138ff0138ff01ULL, },
+        { 0x881afffc28180240ULL, 0x09000101ff0fb000ULL, },    /*  64  */
+        { 0xf101e6f9010c0040ULL, 0x12000117ff00ec00ULL, },
+        { 0xf81afff314000a40ULL, 0x00670000ff0ffd00ULL, },
+        { 0x8800fffe00311501ULL, 0x02330b5eff1eec0cULL, },
+        { 0xfbef00064de4fe08ULL, 0x02fff700000752ffULL, },
+        { 0xfffe000c02f2ff08ULL, 0x04fff706000014ffULL, },
+        { 0xffef001826fff808ULL, 0x00f7fe00020702ffULL, },
+        { 0xfbff000301c9f100ULL, 0x00fbbb1a0a0f14fcULL, },
+        { 0xac16fefab9f3fc80ULL, 0x04fff8fffe052501ULL, },    /*  72  */
+        { 0xf501aef5fdf9ff80ULL, 0x09fff8fffd000901ULL, },
+        { 0xfa16feeadcfff180ULL, 0x00d8fffff5050101ULL, },
+        { 0xac00fefdfee7e2feULL, 0x01ecc6ffd50a0914ULL, },
+        { 0x701300045e0cff4eULL, 0xf1fff1fffe08e2faULL, },
+        { 0x0e0116090206ff4eULL, 0xe3fff1f6fd00f8faULL, },
+        { 0x071300132f00fc4eULL, 0xfff1fefff508fffaULL, },
+        { 0x700000020118f801ULL, 0xfcf888d8d410f8a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_B(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
new file mode 100644
index 0000000..32da4c5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRA.D
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
+    char *instruction_name = "SRA.D";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffeaaaaaULL, 0xffffffffffeaaaaaULL, },
+        { 0xfffffd5555555555ULL, 0xfffffd5555555555ULL, },
+        { 0xfffaaaaaaaaaaaaaULL, 0xfffaaaaaaaaaaaaaULL, },
+        { 0xfffffffffffff555ULL, 0xfffffffffffff555ULL, },
+        { 0xfffeaaaaaaaaaaaaULL, 0xfffffffff5555555ULL, },
+        { 0xffffffffffffd555ULL, 0xfffffffaaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000155555ULL, 0x0000000000155555ULL, },
+        { 0x000002aaaaaaaaaaULL, 0x000002aaaaaaaaaaULL, },
+        { 0x0005555555555555ULL, 0x0005555555555555ULL, },
+        { 0x0000000000000aaaULL, 0x0000000000000aaaULL, },
+        { 0x0001555555555555ULL, 0x000000000aaaaaaaULL, },
+        { 0x0000000000002aaaULL, 0x0000000555555555ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xfffffffffff33333ULL, 0xfffffffffff33333ULL, },
+        { 0xfffffe6666666666ULL, 0xfffffe6666666666ULL, },
+        { 0xfffcccccccccccccULL, 0xfffcccccccccccccULL, },
+        { 0xfffffffffffff999ULL, 0xfffffffffffff999ULL, },
+        { 0xffff333333333333ULL, 0xfffffffff9999999ULL, },
+        { 0xffffffffffffe666ULL, 0xfffffffcccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x00000000000cccccULL, 0x00000000000cccccULL, },
+        { 0x0000019999999999ULL, 0x0000019999999999ULL, },
+        { 0x0003333333333333ULL, 0x0003333333333333ULL, },
+        { 0x0000000000000666ULL, 0x0000000000000666ULL, },
+        { 0x0000ccccccccccccULL, 0x0000000006666666ULL, },
+        { 0x0000000000001999ULL, 0x0000000333333333ULL, },
+        { 0xffffffffffffffffULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xfffffffffff8e38eULL, 0x00000000000e38e3ULL, },
+        { 0xffffff1c71c71c71ULL, 0x000001c71c71c71cULL, },
+        { 0xfffe38e38e38e38eULL, 0x00038e38e38e38e3ULL, },
+        { 0xfffffffffffffc71ULL, 0x000000000000071cULL, },
+        { 0xffff8e38e38e38e3ULL, 0x00000000071c71c7ULL, },
+        { 0xfffffffffffff1c7ULL, 0x000000038e38e38eULL, },
+        { 0x0000000000000000ULL, 0xffffffffffffffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000071c71ULL, 0xfffffffffff1c71cULL, },
+        { 0x000000e38e38e38eULL, 0xfffffe38e38e38e3ULL, },
+        { 0x0001c71c71c71c71ULL, 0xfffc71c71c71c71cULL, },
+        { 0x000000000000038eULL, 0xfffffffffffff8e3ULL, },
+        { 0x000071c71c71c71cULL, 0xfffffffff8e38e38ULL, },
+        { 0x0000000000000e38ULL, 0xfffffffc71c71c71ULL, },
+        { 0x886ae6cc28625540ULL, 0x0004b670b5efe7bbULL, },    /*  64  */
+        { 0xff886ae6cc286255ULL, 0x0000000000000004ULL, },
+        { 0x886ae6cc28625540ULL, 0x000004b670b5efe7ULL, },
+        { 0xfffe21ab9b30a189ULL, 0x000000004b670b5eULL, },
+        { 0xfbbe00634d93c708ULL, 0x00012f7bb1a153f5ULL, },
+        { 0xfffbbe00634d93c7ULL, 0x0000000000000001ULL, },
+        { 0xfbbe00634d93c708ULL, 0x0000012f7bb1a153ULL, },
+        { 0xffffeef8018d364fULL, 0x0000000012f7bb1aULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x00027d8c6ffab2b2ULL, },    /*  72  */
+        { 0xffac5aaeaab9cf8bULL, 0x0000000000000002ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x0000027d8c6ffab2ULL, },
+        { 0xfffeb16abaaae73eULL, 0x0000000027d8c6ffULL, },
+        { 0x704f164d5e31e24eULL, 0xfff8df188d8a942eULL, },
+        { 0x00704f164d5e31e2ULL, 0xfffffffffffffff8ULL, },
+        { 0x704f164d5e31e24eULL, 0xfffff8df188d8a94ULL, },
+        { 0x0001c13c593578c7ULL, 0xffffffff8df188d8ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_D(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
new file mode 100644
index 0000000..372d7ff
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRA.H
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
+    char *instruction_name = "SRA.H";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffeaffeaffeaffeaULL, 0xffeaffeaffeaffeaULL, },
+        { 0xfd55fd55fd55fd55ULL, 0xfd55fd55fd55fd55ULL, },
+        { 0xfffafffafffafffaULL, 0xfffafffafffafffaULL, },
+        { 0xf555f555f555f555ULL, 0xf555f555f555f555ULL, },
+        { 0xfffef555ffaafffeULL, 0xf555ffaafffef555ULL, },
+        { 0xd555fffaff55d555ULL, 0xfffaff55d555fffaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015001500150015ULL, 0x0015001500150015ULL, },
+        { 0x02aa02aa02aa02aaULL, 0x02aa02aa02aa02aaULL, },
+        { 0x0005000500050005ULL, 0x0005000500050005ULL, },
+        { 0x0aaa0aaa0aaa0aaaULL, 0x0aaa0aaa0aaa0aaaULL, },
+        { 0x00010aaa00550001ULL, 0x0aaa005500010aaaULL, },
+        { 0x2aaa000500aa2aaaULL, 0x000500aa2aaa0005ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xfff3fff3fff3fff3ULL, 0xfff3fff3fff3fff3ULL, },
+        { 0xfe66fe66fe66fe66ULL, 0xfe66fe66fe66fe66ULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xf999f999f999f999ULL, 0xf999f999f999f999ULL, },
+        { 0xfffff999ffccffffULL, 0xf999ffccfffff999ULL, },
+        { 0xe666fffcff99e666ULL, 0xfffcff99e666fffcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000c000c000c000cULL, 0x000c000c000c000cULL, },
+        { 0x0199019901990199ULL, 0x0199019901990199ULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x0666066606660666ULL, 0x0666066606660666ULL, },
+        { 0x0000066600330000ULL, 0x0666003300000666ULL, },
+        { 0x1999000300661999ULL, 0x0003006619990003ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xfff8000effe3fff8ULL, 0x000effe3fff8000eULL, },
+        { 0xff1c01c7fc71ff1cULL, 0x01c7fc71ff1c01c7ULL, },
+        { 0xfffe0003fff8fffeULL, 0x0003fff8fffe0003ULL, },
+        { 0xfc71071cf1c7fc71ULL, 0x071cf1c7fc71071cULL, },
+        { 0xffff071cff8effffULL, 0x071cff8effff071cULL, },
+        { 0xf1c70003ff1cf1c7ULL, 0x0003ff1cf1c70003ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0007fff1001c0007ULL, 0xfff1001c0007fff1ULL, },
+        { 0x00e3fe38038e00e3ULL, 0xfe38038e00e3fe38ULL, },
+        { 0x0001fffc00070001ULL, 0xfffc00070001fffcULL, },
+        { 0x038ef8e30e38038eULL, 0xf8e30e38038ef8e3ULL, },
+        { 0x0000f8e300710000ULL, 0xf8e300710000f8e3ULL, },
+        { 0x0e38fffc00e30e38ULL, 0xfffc00e30e38fffcULL, },
+        { 0xffe2fffe0a185540ULL, 0x00960000fffffffbULL, },    /*  64  */
+        { 0xfffefcd9050c0055ULL, 0x00960002fffffffbULL, },
+        { 0xffe2fff900005540ULL, 0x004b0000fffffb00ULL, },
+        { 0xffffffff14310001ULL, 0x25b3000bff9eb00cULL, },
+        { 0xfffe00001364c708ULL, 0x0025fffe00020005ULL, },
+        { 0xffff000c09b2ffc7ULL, 0x0025ffee00000005ULL, },
+        { 0xfffe00000000c708ULL, 0x0012ffff0002052fULL, },
+        { 0xffff000026c9ffffULL, 0x097bffbb054f52fcULL, },
+        { 0xffebfffaee738b80ULL, 0x004ffffffff50002ULL, },    /*  72  */
+        { 0xfffef5d5f739ff8bULL, 0x004ffff1ffff0002ULL, },
+        { 0xffebffebffff8b80ULL, 0x0027fffffff50251ULL, },
+        { 0xfffffffddce7fffeULL, 0x13ecffc6eaca2514ULL, },
+        { 0x001c0001178ce24eULL, 0xff1bfffefff5fffeULL, },
+        { 0x000102c90bc6ffe2ULL, 0xff1bffe2fffffffeULL, },
+        { 0x001c00050000e24eULL, 0xff8dfffffff5fe2aULL, },
+        { 0x000000002f18ffffULL, 0xc6f8ff88ea50e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_H(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
new file mode 100644
index 0000000..0b91aca
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRA.W
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
+    char *instruction_name = "SRA.W";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffeaaaaaffeaaaaaULL, 0xffeaaaaaffeaaaaaULL, },
+        { 0xfffffd55fffffd55ULL, 0xfffffd55fffffd55ULL, },
+        { 0xfffaaaaafffaaaaaULL, 0xfffaaaaafffaaaaaULL, },
+        { 0xfffff555fffff555ULL, 0xfffff555fffff555ULL, },
+        { 0xf5555555fffeaaaaULL, 0xffffffaaf5555555ULL, },
+        { 0xfffffffaffffd555ULL, 0xff555555fffffffaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015555500155555ULL, 0x0015555500155555ULL, },
+        { 0x000002aa000002aaULL, 0x000002aa000002aaULL, },
+        { 0x0005555500055555ULL, 0x0005555500055555ULL, },
+        { 0x00000aaa00000aaaULL, 0x00000aaa00000aaaULL, },
+        { 0x0aaaaaaa00015555ULL, 0x000000550aaaaaaaULL, },
+        { 0x0000000500002aaaULL, 0x00aaaaaa00000005ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xfff33333fff33333ULL, 0xfff33333fff33333ULL, },
+        { 0xfffffe66fffffe66ULL, 0xfffffe66fffffe66ULL, },
+        { 0xfffcccccfffcccccULL, 0xfffcccccfffcccccULL, },
+        { 0xfffff999fffff999ULL, 0xfffff999fffff999ULL, },
+        { 0xf9999999ffff3333ULL, 0xffffffccf9999999ULL, },
+        { 0xfffffffcffffe666ULL, 0xff999999fffffffcULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000ccccc000cccccULL, 0x000ccccc000cccccULL, },
+        { 0x0000019900000199ULL, 0x0000019900000199ULL, },
+        { 0x0003333300033333ULL, 0x0003333300033333ULL, },
+        { 0x0000066600000666ULL, 0x0000066600000666ULL, },
+        { 0x066666660000ccccULL, 0x0000003306666666ULL, },
+        { 0x0000000300001999ULL, 0x0066666600000003ULL, },
+        { 0xffffffffffffffffULL, 0x00000000ffffffffULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xfff8e38effe38e38ULL, 0x000e38e3fff8e38eULL, },
+        { 0xffffff1cfffffc71ULL, 0x000001c7ffffff1cULL, },
+        { 0xfffe38e3fff8e38eULL, 0x00038e38fffe38e3ULL, },
+        { 0xfffffc71fffff1c7ULL, 0x0000071cfffffc71ULL, },
+        { 0xfc71c71cfffe38e3ULL, 0x00000038fc71c71cULL, },
+        { 0xfffffffeffffc71cULL, 0x0071c71cfffffffeULL, },
+        { 0x0000000000000000ULL, 0xffffffff00000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00071c71001c71c7ULL, 0xfff1c71c00071c71ULL, },
+        { 0x000000e30000038eULL, 0xfffffe38000000e3ULL, },
+        { 0x0001c71c00071c71ULL, 0xfffc71c70001c71cULL, },
+        { 0x0000038e00000e38ULL, 0xfffff8e30000038eULL, },
+        { 0x038e38e30001c71cULL, 0xffffffc7038e38e3ULL, },
+        { 0x00000001000038e3ULL, 0xff8e38e300000001ULL, },
+        { 0xfff886ae28625540ULL, 0x00000001ffffe7bbULL, },    /*  64  */
+        { 0xf10d5cd900286255ULL, 0x00000012ffffffffULL, },
+        { 0xffe21ab928625540ULL, 0x00000000ffffffe7ULL, },
+        { 0xfffc43570000a189ULL, 0x0000004bfe7bb00cULL, },
+        { 0xffffbbe04d93c708ULL, 0x00000000000153f5ULL, },
+        { 0xff77c00c004d93c7ULL, 0x0000000400000001ULL, },
+        { 0xfffeef804d93c708ULL, 0x0000000000000153ULL, },
+        { 0xffffddf00001364fULL, 0x00000012153f52fcULL, },
+        { 0xfffac5aab9cf8b80ULL, 0x00000000fffab2b2ULL, },    /*  72  */
+        { 0xf58b55d5ffb9cf8bULL, 0x00000009fffffffaULL, },
+        { 0xffeb16abb9cf8b80ULL, 0x00000000fffffab2ULL, },
+        { 0xfffd62d5fffee73eULL, 0x00000027ab2b2514ULL, },
+        { 0x000704f15e31e24eULL, 0xfffffffefffa942eULL, },
+        { 0x0e09e2c9005e31e2ULL, 0xffffffe3fffffffaULL, },
+        { 0x001c13c55e31e24eULL, 0xfffffffffffffa94ULL, },
+        { 0x00038278000178c7ULL, 0xffffff8da942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_W(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRA_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
new file mode 100644
index 0000000..647b6b4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRAR.B
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
+    char *instruction_name = "SRAR.B";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000ff0000ff0000ULL, 0xff0000ff0000ff00ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xebebebebebebebebULL, 0xebebebebebebebebULL, },
+        { 0xfdfdfdfdfdfdfdfdULL, 0xfdfdfdfdfdfdfdfdULL, },
+        { 0xfbfbfbfbfbfbfbfbULL, 0xfbfbfbfbfbfbfbfbULL, },
+        { 0xf5f5f5f5f5f5f5f5ULL, 0xf5f5f5f5f5f5f5f5ULL, },
+        { 0xf5ffaaf5ffaaf5ffULL, 0xaaf5ffaaf5ffaaf5ULL, },
+        { 0xfbd5fffbd5fffbd5ULL, 0xfffbd5fffbd5fffbULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1515151515151515ULL, 0x1515151515151515ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0b0b0b0b0b0b0b0bULL, 0x0b0b0b0b0b0b0b0bULL, },
+        { 0x0b01550b01550b01ULL, 0x550b01550b01550bULL, },
+        { 0x052b01052b01052bULL, 0x01052b01052b0105ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xf3f3f3f3f3f3f3f3ULL, 0xf3f3f3f3f3f3f3f3ULL, },
+        { 0xfefefefefefefefeULL, 0xfefefefefefefefeULL, },
+        { 0xfdfdfdfdfdfdfdfdULL, 0xfdfdfdfdfdfdfdfdULL, },
+        { 0xfafafafafafafafaULL, 0xfafafafafafafafaULL, },
+        { 0xfaffccfaffccfaffULL, 0xccfaffccfaffccfaULL, },
+        { 0xfde600fde600fde6ULL, 0x00fde600fde600fdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0d0d0d0d0d0d0d0dULL, 0x0d0d0d0d0d0d0d0dULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0x0601330601330601ULL, 0x3306013306013306ULL, },
+        { 0x031a00031a00031aULL, 0x00031a00031a0003ULL, },
+        { 0x00ff0000ff0000ffULL, 0x0000ff0000ff0000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xf9e40ef9e40ef9e4ULL, 0x0ef9e40ef9e40ef9ULL, },
+        { 0xfffc02fffc02fffcULL, 0x02fffc02fffc02ffULL, },
+        { 0xfef904fef904fef9ULL, 0x04fef904fef904feULL, },
+        { 0xfcf207fcf207fcf2ULL, 0x07fcf207fcf207fcULL, },
+        { 0xfcfe38fcfe38fcfeULL, 0x38fcfe38fcfe38fcULL, },
+        { 0xfec700fec700fec7ULL, 0x00fec700fec700feULL, },
+        { 0x0001000001000001ULL, 0x0000010000010000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x071cf2071cf2071cULL, 0xf2071cf2071cf207ULL, },
+        { 0x0104fe0104fe0104ULL, 0xfe0104fe0104fe01ULL, },
+        { 0x0207fc0207fc0207ULL, 0xfc0207fc0207fc02ULL, },
+        { 0x040ef9040ef9040eULL, 0xf9040ef9040ef904ULL, },
+        { 0x0402c70402c70402ULL, 0xc70402c70402c704ULL, },
+        { 0x0239000239000239ULL, 0x0002390002390002ULL, },
+        { 0x881b00fd28190340ULL, 0x09010101000fb001ULL, },    /*  64  */
+        { 0xf102e6fa010c0140ULL, 0x130101180001ec01ULL, },
+        { 0xf91b00f314010b40ULL, 0x01670001000ffe01ULL, },
+        { 0x880100fe01311501ULL, 0x02340b5eff1fec0cULL, },
+        { 0xfbf000064de5fe08ULL, 0x0200f70000085200ULL, },
+        { 0xffff000c02f20008ULL, 0x0500f70701001500ULL, },
+        { 0x00f0001927fff908ULL, 0x00f7ff0003080300ULL, },
+        { 0xfbff000301caf200ULL, 0x01fcbb1a0b1015fcULL, },
+        { 0xac17fffbb9f4fc80ULL, 0x0500f900ff052501ULL, },    /*  72  */
+        { 0xf601aef5fefaff80ULL, 0x0a00f900fd000901ULL, },
+        { 0xfb17ffebdd00f180ULL, 0x00d8ff00f5050101ULL, },
+        { 0xac01fffdffe8e3feULL, 0x01ecc6ffd60b0914ULL, },
+        { 0x701400055e0cff4eULL, 0xf200f1ffff08e2faULL, },
+        { 0x0e01160a0306004eULL, 0xe300f1f6fd01f9faULL, },
+        { 0x071400132f00fc4eULL, 0xfff1fe00f508fffaULL, },
+        { 0x700100020119f901ULL, 0xfcf988d8d511f9a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
new file mode 100644
index 0000000..1669d42
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRAR.D
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
+    char *instruction_name = "SRAR.D";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffffffffffeaaaabULL, 0xffffffffffeaaaabULL, },
+        { 0xfffffd5555555555ULL, 0xfffffd5555555555ULL, },
+        { 0xfffaaaaaaaaaaaabULL, 0xfffaaaaaaaaaaaabULL, },
+        { 0xfffffffffffff555ULL, 0xfffffffffffff555ULL, },
+        { 0xfffeaaaaaaaaaaabULL, 0xfffffffff5555555ULL, },
+        { 0xffffffffffffd555ULL, 0xfffffffaaaaaaaabULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000155555ULL, 0x0000000000155555ULL, },
+        { 0x000002aaaaaaaaabULL, 0x000002aaaaaaaaabULL, },
+        { 0x0005555555555555ULL, 0x0005555555555555ULL, },
+        { 0x0000000000000aabULL, 0x0000000000000aabULL, },
+        { 0x0001555555555555ULL, 0x000000000aaaaaabULL, },
+        { 0x0000000000002aabULL, 0x0000000555555555ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xfffffffffff33333ULL, 0xfffffffffff33333ULL, },
+        { 0xfffffe6666666666ULL, 0xfffffe6666666666ULL, },
+        { 0xfffccccccccccccdULL, 0xfffccccccccccccdULL, },
+        { 0xfffffffffffff99aULL, 0xfffffffffffff99aULL, },
+        { 0xffff333333333333ULL, 0xfffffffff999999aULL, },
+        { 0xffffffffffffe666ULL, 0xfffffffccccccccdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x00000000000ccccdULL, 0x00000000000ccccdULL, },
+        { 0x000001999999999aULL, 0x000001999999999aULL, },
+        { 0x0003333333333333ULL, 0x0003333333333333ULL, },
+        { 0x0000000000000666ULL, 0x0000000000000666ULL, },
+        { 0x0000cccccccccccdULL, 0x0000000006666666ULL, },
+        { 0x000000000000199aULL, 0x0000000333333333ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xfffffffffff8e38eULL, 0x00000000000e38e4ULL, },
+        { 0xffffff1c71c71c72ULL, 0x000001c71c71c71cULL, },
+        { 0xfffe38e38e38e38eULL, 0x00038e38e38e38e4ULL, },
+        { 0xfffffffffffffc72ULL, 0x000000000000071cULL, },
+        { 0xffff8e38e38e38e4ULL, 0x00000000071c71c7ULL, },
+        { 0xfffffffffffff1c7ULL, 0x000000038e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000071c72ULL, 0xfffffffffff1c71cULL, },
+        { 0x000000e38e38e38eULL, 0xfffffe38e38e38e4ULL, },
+        { 0x0001c71c71c71c72ULL, 0xfffc71c71c71c71cULL, },
+        { 0x000000000000038eULL, 0xfffffffffffff8e4ULL, },
+        { 0x000071c71c71c71cULL, 0xfffffffff8e38e39ULL, },
+        { 0x0000000000000e39ULL, 0xfffffffc71c71c72ULL, },
+        { 0x886ae6cc28625540ULL, 0x0004b670b5efe7bbULL, },    /*  64  */
+        { 0xff886ae6cc286255ULL, 0x0000000000000005ULL, },
+        { 0x886ae6cc28625540ULL, 0x000004b670b5efe8ULL, },
+        { 0xfffe21ab9b30a189ULL, 0x000000004b670b5fULL, },
+        { 0xfbbe00634d93c708ULL, 0x00012f7bb1a153f5ULL, },
+        { 0xfffbbe00634d93c7ULL, 0x0000000000000001ULL, },
+        { 0xfbbe00634d93c708ULL, 0x0000012f7bb1a154ULL, },
+        { 0xffffeef8018d364fULL, 0x0000000012f7bb1aULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x00027d8c6ffab2b2ULL, },    /*  72  */
+        { 0xffac5aaeaab9cf8cULL, 0x0000000000000002ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x0000027d8c6ffab3ULL, },
+        { 0xfffeb16abaaae73eULL, 0x0000000027d8c700ULL, },
+        { 0x704f164d5e31e24eULL, 0xfff8df188d8a942eULL, },
+        { 0x00704f164d5e31e2ULL, 0xfffffffffffffff9ULL, },
+        { 0x704f164d5e31e24eULL, 0xfffff8df188d8a94ULL, },
+        { 0x0001c13c593578c8ULL, 0xffffffff8df188d9ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
new file mode 100644
index 0000000..b63a544
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRAR.H
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
+    char *instruction_name = "SRAR.H";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffebffebffebffebULL, 0xffebffebffebffebULL, },
+        { 0xfd55fd55fd55fd55ULL, 0xfd55fd55fd55fd55ULL, },
+        { 0xfffbfffbfffbfffbULL, 0xfffbfffbfffbfffbULL, },
+        { 0xf555f555f555f555ULL, 0xf555f555f555f555ULL, },
+        { 0xfffff555ffabffffULL, 0xf555ffabfffff555ULL, },
+        { 0xd555fffbff55d555ULL, 0xfffbff55d555fffbULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015001500150015ULL, 0x0015001500150015ULL, },
+        { 0x02ab02ab02ab02abULL, 0x02ab02ab02ab02abULL, },
+        { 0x0005000500050005ULL, 0x0005000500050005ULL, },
+        { 0x0aab0aab0aab0aabULL, 0x0aab0aab0aab0aabULL, },
+        { 0x00010aab00550001ULL, 0x0aab005500010aabULL, },
+        { 0x2aab000500ab2aabULL, 0x000500ab2aab0005ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xfff3fff3fff3fff3ULL, 0xfff3fff3fff3fff3ULL, },
+        { 0xfe66fe66fe66fe66ULL, 0xfe66fe66fe66fe66ULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xf99af99af99af99aULL, 0xf99af99af99af99aULL, },
+        { 0xfffff99affcdffffULL, 0xf99affcdfffff99aULL, },
+        { 0xe666fffdff9ae666ULL, 0xfffdff9ae666fffdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000d000d000d000dULL, 0x000d000d000d000dULL, },
+        { 0x019a019a019a019aULL, 0x019a019a019a019aULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x0666066606660666ULL, 0x0666066606660666ULL, },
+        { 0x0001066600330001ULL, 0x0666003300010666ULL, },
+        { 0x199a00030066199aULL, 0x00030066199a0003ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xfff9000effe4fff9ULL, 0x000effe4fff9000eULL, },
+        { 0xff1c01c7fc72ff1cULL, 0x01c7fc72ff1c01c7ULL, },
+        { 0xfffe0004fff9fffeULL, 0x0004fff9fffe0004ULL, },
+        { 0xfc72071cf1c7fc72ULL, 0x071cf1c7fc72071cULL, },
+        { 0x0000071cff8e0000ULL, 0x071cff8e0000071cULL, },
+        { 0xf1c70004ff1cf1c7ULL, 0x0004ff1cf1c70004ULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0007fff2001c0007ULL, 0xfff2001c0007fff2ULL, },
+        { 0x00e4fe39038e00e4ULL, 0xfe39038e00e4fe39ULL, },
+        { 0x0002fffc00070002ULL, 0xfffc00070002fffcULL, },
+        { 0x038ef8e40e39038eULL, 0xf8e40e39038ef8e4ULL, },
+        { 0x0000f8e400720000ULL, 0xf8e400720000f8e4ULL, },
+        { 0x0e39fffc00e40e39ULL, 0xfffc00e40e39fffcULL, },
+        { 0xffe2fffe0a195540ULL, 0x009700000000fffbULL, },    /*  64  */
+        { 0xfffefcda050c0055ULL, 0x009700030000fffbULL, },
+        { 0xffe2fffa00005540ULL, 0x004b00000000fb01ULL, },
+        { 0xffffffff14310001ULL, 0x25b4000bff9fb00cULL, },
+        { 0xffff00001365c708ULL, 0x0026ffff00030005ULL, },
+        { 0x0000000c09b2ffc7ULL, 0x0026ffef00000005ULL, },
+        { 0xffff00000001c708ULL, 0x0013ffff00030530ULL, },
+        { 0x0000000026caffffULL, 0x097cffbb055052fcULL, },
+        { 0xffebfffbee748b80ULL, 0x0050fffffff50002ULL, },    /*  72  */
+        { 0xfffff5d5f73aff8cULL, 0x0050fff2ffff0002ULL, },
+        { 0xffebffecffff8b80ULL, 0x00280000fff50251ULL, },
+        { 0xfffffffddce8fffeULL, 0x13ecffc7eacb2514ULL, },
+        { 0x001c0001178ce24eULL, 0xff1cfffefff5fffeULL, },
+        { 0x000202ca0bc6ffe2ULL, 0xff1cffe2fffffffeULL, },
+        { 0x001c00060001e24eULL, 0xff8efffffff5fe2aULL, },
+        { 0x000100012f190000ULL, 0xc6f9ff89ea51e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
new file mode 100644
index 0000000..a1a82a3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRAR.W
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
+    char *instruction_name = "SRAR.W";
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xffeaaaabffeaaaabULL, 0xffeaaaabffeaaaabULL, },
+        { 0xfffffd55fffffd55ULL, 0xfffffd55fffffd55ULL, },
+        { 0xfffaaaabfffaaaabULL, 0xfffaaaabfffaaaabULL, },
+        { 0xfffff555fffff555ULL, 0xfffff555fffff555ULL, },
+        { 0xf5555555fffeaaabULL, 0xffffffabf5555555ULL, },
+        { 0xfffffffbffffd555ULL, 0xff555555fffffffbULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015555500155555ULL, 0x0015555500155555ULL, },
+        { 0x000002ab000002abULL, 0x000002ab000002abULL, },
+        { 0x0005555500055555ULL, 0x0005555500055555ULL, },
+        { 0x00000aab00000aabULL, 0x00000aab00000aabULL, },
+        { 0x0aaaaaab00015555ULL, 0x000000550aaaaaabULL, },
+        { 0x0000000500002aabULL, 0x00aaaaab00000005ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xfff33333fff33333ULL, 0xfff33333fff33333ULL, },
+        { 0xfffffe66fffffe66ULL, 0xfffffe66fffffe66ULL, },
+        { 0xfffccccdfffccccdULL, 0xfffccccdfffccccdULL, },
+        { 0xfffff99afffff99aULL, 0xfffff99afffff99aULL, },
+        { 0xf999999affff3333ULL, 0xffffffcdf999999aULL, },
+        { 0xfffffffdffffe666ULL, 0xff99999afffffffdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000ccccd000ccccdULL, 0x000ccccd000ccccdULL, },
+        { 0x0000019a0000019aULL, 0x0000019a0000019aULL, },
+        { 0x0003333300033333ULL, 0x0003333300033333ULL, },
+        { 0x0000066600000666ULL, 0x0000066600000666ULL, },
+        { 0x066666660000cccdULL, 0x0000003306666666ULL, },
+        { 0x000000030000199aULL, 0x0066666600000003ULL, },
+        { 0x00000000ffffffffULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xfff8e38effe38e39ULL, 0x000e38e4fff8e38eULL, },
+        { 0xffffff1cfffffc72ULL, 0x000001c7ffffff1cULL, },
+        { 0xfffe38e4fff8e38eULL, 0x00038e39fffe38e4ULL, },
+        { 0xfffffc72fffff1c7ULL, 0x0000071cfffffc72ULL, },
+        { 0xfc71c71cfffe38e4ULL, 0x00000039fc71c71cULL, },
+        { 0xfffffffeffffc71cULL, 0x0071c71cfffffffeULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00071c72001c71c7ULL, 0xfff1c71c00071c72ULL, },
+        { 0x000000e40000038eULL, 0xfffffe39000000e4ULL, },
+        { 0x0001c71c00071c72ULL, 0xfffc71c70001c71cULL, },
+        { 0x0000038e00000e39ULL, 0xfffff8e40000038eULL, },
+        { 0x038e38e40001c71cULL, 0xffffffc7038e38e4ULL, },
+        { 0x00000002000038e4ULL, 0xff8e38e400000002ULL, },
+        { 0xfff886ae28625540ULL, 0x00000001ffffe7bbULL, },    /*  64  */
+        { 0xf10d5cda00286255ULL, 0x0000001300000000ULL, },
+        { 0xffe21aba28625540ULL, 0x00000001ffffffe8ULL, },
+        { 0xfffc43570000a189ULL, 0x0000004bfe7bb00cULL, },
+        { 0xffffbbe04d93c708ULL, 0x00000000000153f5ULL, },
+        { 0xff77c00c004d93c7ULL, 0x0000000500000001ULL, },
+        { 0xfffeef804d93c708ULL, 0x0000000000000154ULL, },
+        { 0xffffddf00001364fULL, 0x00000013153f52fcULL, },
+        { 0xfffac5abb9cf8b80ULL, 0x00000001fffab2b2ULL, },    /*  72  */
+        { 0xf58b55d5ffb9cf8cULL, 0x0000000afffffffbULL, },
+        { 0xffeb16acb9cf8b80ULL, 0x00000000fffffab3ULL, },
+        { 0xfffd62d5fffee73eULL, 0x00000028ab2b2514ULL, },
+        { 0x000704f15e31e24eULL, 0xfffffffefffa942eULL, },
+        { 0x0e09e2ca005e31e2ULL, 0xffffffe3fffffffbULL, },
+        { 0x001c13c65e31e24eULL, 0xfffffffffffffa94ULL, },
+        { 0x00038279000178c8ULL, 0xffffff8ea942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRAR_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
new file mode 100644
index 0000000..e2785fa
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRL.B
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
+    char *instruction_name = "SRL.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x3f3f3f3f3f3f3f3fULL, 0x3f3f3f3f3f3f3f3fULL, },
+        { 0x0707070707070707ULL, 0x0707070707070707ULL, },
+        { 0x0f0f0f0f0f0f0f0fULL, 0x0f0f0f0f0f0f0f0fULL, },
+        { 0x1f1f1f1f1f1f1f1fULL, 0x1f1f1f1f1f1f1f1fULL, },
+        { 0x1f03ff1f03ff1f03ULL, 0xff1f03ff1f03ff1fULL, },
+        { 0x0f7f010f7f010f7fULL, 0x010f7f010f7f010fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2a2a2a2a2a2a2a2aULL, 0x2a2a2a2a2a2a2a2aULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0a0a0a0a0a0a0a0aULL, 0x0a0a0a0a0a0a0a0aULL, },
+        { 0x1515151515151515ULL, 0x1515151515151515ULL, },
+        { 0x1502aa1502aa1502ULL, 0xaa1502aa1502aa15ULL, },
+        { 0x0a55010a55010a55ULL, 0x010a55010a55010aULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1515151515151515ULL, 0x1515151515151515ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0a0a0a0a0a0a0a0aULL, 0x0a0a0a0a0a0a0a0aULL, },
+        { 0x0a01550a01550a01ULL, 0x550a01550a01550aULL, },
+        { 0x052a00052a00052aULL, 0x00052a00052a0005ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0x0c0c0c0c0c0c0c0cULL, 0x0c0c0c0c0c0c0c0cULL, },
+        { 0x1919191919191919ULL, 0x1919191919191919ULL, },
+        { 0x1903cc1903cc1903ULL, 0xcc1903cc1903cc19ULL, },
+        { 0x0c66010c66010c66ULL, 0x010c66010c66010cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0c0c0c0c0c0c0c0cULL, 0x0c0c0c0c0c0c0c0cULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0x0600330600330600ULL, 0x3306003306003306ULL, },
+        { 0x0319000319000319ULL, 0x0003190003190003ULL, },
+        { 0x0101000101000101ULL, 0x0001010001010001ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x38230e38230e3823ULL, 0x0e38230e38230e38ULL, },
+        { 0x0704010704010704ULL, 0x0107040107040107ULL, },
+        { 0x0e08030e08030e08ULL, 0x030e08030e08030eULL, },
+        { 0x1c11071c11071c11ULL, 0x071c11071c11071cULL, },
+        { 0x1c02381c02381c02ULL, 0x381c02381c02381cULL, },
+        { 0x0e47000e47000e47ULL, 0x000e47000e47000eULL, },
+        { 0x0000010000010000ULL, 0x0100000100000100ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x071c31071c31071cULL, 0x31071c31071c3107ULL, },
+        { 0x0003060003060003ULL, 0x0600030600030600ULL, },
+        { 0x01070c01070c0107ULL, 0x0c01070c01070c01ULL, },
+        { 0x030e18030e18030eULL, 0x18030e18030e1803ULL, },
+        { 0x0301c70301c70301ULL, 0xc70301c70301c703ULL, },
+        { 0x0138010138010138ULL, 0x0101380101380101ULL, },
+        { 0x881a030c28180240ULL, 0x09000101030fb000ULL, },    /*  64  */
+        { 0x1101e619010c0040ULL, 0x1200011707002c00ULL, },
+        { 0x081a033314000a40ULL, 0x006700001f0f0500ULL, },
+        { 0x8800030600311501ULL, 0x02330b5e7f1e2c0cULL, },
+        { 0xfb2f00064d240608ULL, 0x020117000007520fULL, },
+        { 0x1f02000c02120108ULL, 0x040117060000140fULL, },
+        { 0x0f2f001826011808ULL, 0x00f702000207020fULL, },
+        { 0xfb01000301493100ULL, 0x007bbb1a0a0f14fcULL, },
+        { 0xac16020ab9330480ULL, 0x0401180302052501ULL, },    /*  72  */
+        { 0x1501ae1505190180ULL, 0x0901183f05000901ULL, },
+        { 0x0a16022a5c011180ULL, 0x00d8030115050101ULL, },
+        { 0xac00020502672202ULL, 0x016cc6ff550a0914ULL, },
+        { 0x701300045e0c074eULL, 0x110111030208e20aULL, },
+        { 0x0e0116090206014eULL, 0x230111360500380aULL, },
+        { 0x071300132f001c4eULL, 0x01f102011508070aULL, },
+        { 0x7000000201183801ULL, 0x047888d8541038a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_B(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
new file mode 100644
index 0000000..7eab568
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRL.D
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
+    char *instruction_name = "SRL.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x00000000003fffffULL, 0x00000000003fffffULL, },
+        { 0x000007ffffffffffULL, 0x000007ffffffffffULL, },
+        { 0x000fffffffffffffULL, 0x000fffffffffffffULL, },
+        { 0x0000000000001fffULL, 0x0000000000001fffULL, },
+        { 0x0003ffffffffffffULL, 0x000000001fffffffULL, },
+        { 0x0000000000007fffULL, 0x0000000fffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x00000000002aaaaaULL, 0x00000000002aaaaaULL, },
+        { 0x0000055555555555ULL, 0x0000055555555555ULL, },
+        { 0x000aaaaaaaaaaaaaULL, 0x000aaaaaaaaaaaaaULL, },
+        { 0x0000000000001555ULL, 0x0000000000001555ULL, },
+        { 0x0002aaaaaaaaaaaaULL, 0x0000000015555555ULL, },
+        { 0x0000000000005555ULL, 0x0000000aaaaaaaaaULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000155555ULL, 0x0000000000155555ULL, },
+        { 0x000002aaaaaaaaaaULL, 0x000002aaaaaaaaaaULL, },
+        { 0x0005555555555555ULL, 0x0005555555555555ULL, },
+        { 0x0000000000000aaaULL, 0x0000000000000aaaULL, },
+        { 0x0001555555555555ULL, 0x000000000aaaaaaaULL, },
+        { 0x0000000000002aaaULL, 0x0000000555555555ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000333333ULL, 0x0000000000333333ULL, },
+        { 0x0000066666666666ULL, 0x0000066666666666ULL, },
+        { 0x000cccccccccccccULL, 0x000cccccccccccccULL, },
+        { 0x0000000000001999ULL, 0x0000000000001999ULL, },
+        { 0x0003333333333333ULL, 0x0000000019999999ULL, },
+        { 0x0000000000006666ULL, 0x0000000cccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x00000000000cccccULL, 0x00000000000cccccULL, },
+        { 0x0000019999999999ULL, 0x0000019999999999ULL, },
+        { 0x0003333333333333ULL, 0x0003333333333333ULL, },
+        { 0x0000000000000666ULL, 0x0000000000000666ULL, },
+        { 0x0000ccccccccccccULL, 0x0000000006666666ULL, },
+        { 0x0000000000001999ULL, 0x0000000333333333ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x000000000038e38eULL, 0x00000000000e38e3ULL, },
+        { 0x0000071c71c71c71ULL, 0x000001c71c71c71cULL, },
+        { 0x000e38e38e38e38eULL, 0x00038e38e38e38e3ULL, },
+        { 0x0000000000001c71ULL, 0x000000000000071cULL, },
+        { 0x00038e38e38e38e3ULL, 0x00000000071c71c7ULL, },
+        { 0x00000000000071c7ULL, 0x000000038e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000001ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000071c71ULL, 0x000000000031c71cULL, },
+        { 0x000000e38e38e38eULL, 0x00000638e38e38e3ULL, },
+        { 0x0001c71c71c71c71ULL, 0x000c71c71c71c71cULL, },
+        { 0x000000000000038eULL, 0x00000000000018e3ULL, },
+        { 0x000071c71c71c71cULL, 0x0000000018e38e38ULL, },
+        { 0x0000000000000e38ULL, 0x0000000c71c71c71ULL, },
+        { 0x886ae6cc28625540ULL, 0x0004b670b5efe7bbULL, },    /*  64  */
+        { 0x00886ae6cc286255ULL, 0x0000000000000004ULL, },
+        { 0x886ae6cc28625540ULL, 0x000004b670b5efe7ULL, },
+        { 0x000221ab9b30a189ULL, 0x000000004b670b5eULL, },
+        { 0xfbbe00634d93c708ULL, 0x00012f7bb1a153f5ULL, },
+        { 0x00fbbe00634d93c7ULL, 0x0000000000000001ULL, },
+        { 0xfbbe00634d93c708ULL, 0x0000012f7bb1a153ULL, },
+        { 0x0003eef8018d364fULL, 0x0000000012f7bb1aULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x00027d8c6ffab2b2ULL, },    /*  72  */
+        { 0x00ac5aaeaab9cf8bULL, 0x0000000000000002ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x0000027d8c6ffab2ULL, },
+        { 0x0002b16abaaae73eULL, 0x0000000027d8c6ffULL, },
+        { 0x704f164d5e31e24eULL, 0x0008df188d8a942eULL, },
+        { 0x00704f164d5e31e2ULL, 0x0000000000000008ULL, },
+        { 0x704f164d5e31e24eULL, 0x000008df188d8a94ULL, },
+        { 0x0001c13c593578c7ULL, 0x000000008df188d8ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_D(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
new file mode 100644
index 0000000..99f2564
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRL.H
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
+    char *instruction_name = "SRL.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x003f003f003f003fULL, 0x003f003f003f003fULL, },
+        { 0x07ff07ff07ff07ffULL, 0x07ff07ff07ff07ffULL, },
+        { 0x000f000f000f000fULL, 0x000f000f000f000fULL, },
+        { 0x1fff1fff1fff1fffULL, 0x1fff1fff1fff1fffULL, },
+        { 0x00031fff00ff0003ULL, 0x1fff00ff00031fffULL, },
+        { 0x7fff000f01ff7fffULL, 0x000f01ff7fff000fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x002a002a002a002aULL, 0x002a002a002a002aULL, },
+        { 0x0555055505550555ULL, 0x0555055505550555ULL, },
+        { 0x000a000a000a000aULL, 0x000a000a000a000aULL, },
+        { 0x1555155515551555ULL, 0x1555155515551555ULL, },
+        { 0x0002155500aa0002ULL, 0x155500aa00021555ULL, },
+        { 0x5555000a01555555ULL, 0x000a01555555000aULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015001500150015ULL, 0x0015001500150015ULL, },
+        { 0x02aa02aa02aa02aaULL, 0x02aa02aa02aa02aaULL, },
+        { 0x0005000500050005ULL, 0x0005000500050005ULL, },
+        { 0x0aaa0aaa0aaa0aaaULL, 0x0aaa0aaa0aaa0aaaULL, },
+        { 0x00010aaa00550001ULL, 0x0aaa005500010aaaULL, },
+        { 0x2aaa000500aa2aaaULL, 0x000500aa2aaa0005ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x0666066606660666ULL, 0x0666066606660666ULL, },
+        { 0x000c000c000c000cULL, 0x000c000c000c000cULL, },
+        { 0x1999199919991999ULL, 0x1999199919991999ULL, },
+        { 0x0003199900cc0003ULL, 0x199900cc00031999ULL, },
+        { 0x6666000c01996666ULL, 0x000c01996666000cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000c000c000c000cULL, 0x000c000c000c000cULL, },
+        { 0x0199019901990199ULL, 0x0199019901990199ULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x0666066606660666ULL, 0x0666066606660666ULL, },
+        { 0x0000066600330000ULL, 0x0666003300000666ULL, },
+        { 0x1999000300661999ULL, 0x0003006619990003ULL, },
+        { 0x0001000000010001ULL, 0x0000000100010000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0038000e00230038ULL, 0x000e00230038000eULL, },
+        { 0x071c01c70471071cULL, 0x01c70471071c01c7ULL, },
+        { 0x000e00030008000eULL, 0x00030008000e0003ULL, },
+        { 0x1c71071c11c71c71ULL, 0x071c11c71c71071cULL, },
+        { 0x0003071c008e0003ULL, 0x071c008e0003071cULL, },
+        { 0x71c70003011c71c7ULL, 0x0003011c71c70003ULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00070031001c0007ULL, 0x0031001c00070031ULL, },
+        { 0x00e30638038e00e3ULL, 0x0638038e00e30638ULL, },
+        { 0x0001000c00070001ULL, 0x000c00070001000cULL, },
+        { 0x038e18e30e38038eULL, 0x18e30e38038e18e3ULL, },
+        { 0x000018e300710000ULL, 0x18e30071000018e3ULL, },
+        { 0x0e38000c00e30e38ULL, 0x000c00e30e38000cULL, },
+        { 0x0022000e0a185540ULL, 0x00960000001f000bULL, },    /*  64  */
+        { 0x00021cd9050c0055ULL, 0x009600020001000bULL, },
+        { 0x0022003900005540ULL, 0x004b0000001f0b00ULL, },
+        { 0x0001000714310001ULL, 0x25b3000b3f9eb00cULL, },
+        { 0x003e00001364c708ULL, 0x0025000200020005ULL, },
+        { 0x0003000c09b200c7ULL, 0x0025002e00000005ULL, },
+        { 0x003e00000000c708ULL, 0x001200010002052fULL, },
+        { 0x0001000026c90003ULL, 0x097b00bb054f52fcULL, },
+        { 0x002b000a2e738b80ULL, 0x004f000300150002ULL, },    /*  72  */
+        { 0x000215d51739008bULL, 0x004f003100010002ULL, },
+        { 0x002b002b00018b80ULL, 0x0027000100150251ULL, },
+        { 0x000100055ce70002ULL, 0x13ec00c62aca2514ULL, },
+        { 0x001c0001178ce24eULL, 0x011b00020015000eULL, },
+        { 0x000102c90bc600e2ULL, 0x011b00220001000eULL, },
+        { 0x001c00050000e24eULL, 0x008d000100150e2aULL, },
+        { 0x000000002f180003ULL, 0x46f800882a50e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_H(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
new file mode 100644
index 0000000..34294f1
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRL.W
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
+    char *instruction_name = "SRL.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x003fffff003fffffULL, 0x003fffff003fffffULL, },
+        { 0x000007ff000007ffULL, 0x000007ff000007ffULL, },
+        { 0x000fffff000fffffULL, 0x000fffff000fffffULL, },
+        { 0x00001fff00001fffULL, 0x00001fff00001fffULL, },
+        { 0x1fffffff0003ffffULL, 0x000000ff1fffffffULL, },
+        { 0x0000000f00007fffULL, 0x01ffffff0000000fULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x002aaaaa002aaaaaULL, 0x002aaaaa002aaaaaULL, },
+        { 0x0000055500000555ULL, 0x0000055500000555ULL, },
+        { 0x000aaaaa000aaaaaULL, 0x000aaaaa000aaaaaULL, },
+        { 0x0000155500001555ULL, 0x0000155500001555ULL, },
+        { 0x155555550002aaaaULL, 0x000000aa15555555ULL, },
+        { 0x0000000a00005555ULL, 0x015555550000000aULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015555500155555ULL, 0x0015555500155555ULL, },
+        { 0x000002aa000002aaULL, 0x000002aa000002aaULL, },
+        { 0x0005555500055555ULL, 0x0005555500055555ULL, },
+        { 0x00000aaa00000aaaULL, 0x00000aaa00000aaaULL, },
+        { 0x0aaaaaaa00015555ULL, 0x000000550aaaaaaaULL, },
+        { 0x0000000500002aaaULL, 0x00aaaaaa00000005ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0033333300333333ULL, 0x0033333300333333ULL, },
+        { 0x0000066600000666ULL, 0x0000066600000666ULL, },
+        { 0x000ccccc000cccccULL, 0x000ccccc000cccccULL, },
+        { 0x0000199900001999ULL, 0x0000199900001999ULL, },
+        { 0x1999999900033333ULL, 0x000000cc19999999ULL, },
+        { 0x0000000c00006666ULL, 0x019999990000000cULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000ccccc000cccccULL, 0x000ccccc000cccccULL, },
+        { 0x0000019900000199ULL, 0x0000019900000199ULL, },
+        { 0x0003333300033333ULL, 0x0003333300033333ULL, },
+        { 0x0000066600000666ULL, 0x0000066600000666ULL, },
+        { 0x066666660000ccccULL, 0x0000003306666666ULL, },
+        { 0x0000000300001999ULL, 0x0066666600000003ULL, },
+        { 0x0000000100000001ULL, 0x0000000000000001ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0038e38e00238e38ULL, 0x000e38e30038e38eULL, },
+        { 0x0000071c00000471ULL, 0x000001c70000071cULL, },
+        { 0x000e38e30008e38eULL, 0x00038e38000e38e3ULL, },
+        { 0x00001c71000011c7ULL, 0x0000071c00001c71ULL, },
+        { 0x1c71c71c000238e3ULL, 0x000000381c71c71cULL, },
+        { 0x0000000e0000471cULL, 0x0071c71c0000000eULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00071c71001c71c7ULL, 0x0031c71c00071c71ULL, },
+        { 0x000000e30000038eULL, 0x00000638000000e3ULL, },
+        { 0x0001c71c00071c71ULL, 0x000c71c70001c71cULL, },
+        { 0x0000038e00000e38ULL, 0x000018e30000038eULL, },
+        { 0x038e38e30001c71cULL, 0x000000c7038e38e3ULL, },
+        { 0x00000001000038e3ULL, 0x018e38e300000001ULL, },
+        { 0x000886ae28625540ULL, 0x00000001000fe7bbULL, },    /*  64  */
+        { 0x110d5cd900286255ULL, 0x000000120000000fULL, },
+        { 0x00221ab928625540ULL, 0x0000000000000fe7ULL, },
+        { 0x000443570000a189ULL, 0x0000004bfe7bb00cULL, },
+        { 0x000fbbe04d93c708ULL, 0x00000000000153f5ULL, },
+        { 0x1f77c00c004d93c7ULL, 0x0000000400000001ULL, },
+        { 0x003eef804d93c708ULL, 0x0000000000000153ULL, },
+        { 0x0007ddf00001364fULL, 0x00000012153f52fcULL, },
+        { 0x000ac5aab9cf8b80ULL, 0x00000000000ab2b2ULL, },    /*  72  */
+        { 0x158b55d500b9cf8bULL, 0x000000090000000aULL, },
+        { 0x002b16abb9cf8b80ULL, 0x0000000000000ab2ULL, },
+        { 0x000562d50002e73eULL, 0x00000027ab2b2514ULL, },
+        { 0x000704f15e31e24eULL, 0x00000002000a942eULL, },
+        { 0x0e09e2c9005e31e2ULL, 0x000000230000000aULL, },
+        { 0x001c13c55e31e24eULL, 0x0000000100000a94ULL, },
+        { 0x00038278000178c7ULL, 0x0000008da942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_W(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRL_W(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
new file mode 100644
index 0000000..c6961a4
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRLR.B
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
+    char *instruction_name = "SRLR.B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },
+        { 0x1010101010101010ULL, 0x1010101010101010ULL, },
+        { 0x2020202020202020ULL, 0x2020202020202020ULL, },
+        { 0x2004ff2004ff2004ULL, 0xff2004ff2004ff20ULL, },
+        { 0x1080021080021080ULL, 0x0210800210800210ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2b2b2b2b2b2b2b2bULL, 0x2b2b2b2b2b2b2b2bULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0b0b0b0b0b0b0b0bULL, 0x0b0b0b0b0b0b0b0bULL, },
+        { 0x1515151515151515ULL, 0x1515151515151515ULL, },
+        { 0x1503aa1503aa1503ULL, 0xaa1503aa1503aa15ULL, },
+        { 0x0b55010b55010b55ULL, 0x010b55010b55010bULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x1515151515151515ULL, 0x1515151515151515ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0505050505050505ULL, 0x0505050505050505ULL, },
+        { 0x0b0b0b0b0b0b0b0bULL, 0x0b0b0b0b0b0b0b0bULL, },
+        { 0x0b01550b01550b01ULL, 0x550b01550b01550bULL, },
+        { 0x052b01052b01052bULL, 0x01052b01052b0105ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0x0d0d0d0d0d0d0d0dULL, 0x0d0d0d0d0d0d0d0dULL, },
+        { 0x1a1a1a1a1a1a1a1aULL, 0x1a1a1a1a1a1a1a1aULL, },
+        { 0x1a03cc1a03cc1a03ULL, 0xcc1a03cc1a03cc1aULL, },
+        { 0x0d66020d66020d66ULL, 0x020d66020d66020dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x0d0d0d0d0d0d0d0dULL, 0x0d0d0d0d0d0d0d0dULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0303030303030303ULL, 0x0303030303030303ULL, },
+        { 0x0606060606060606ULL, 0x0606060606060606ULL, },
+        { 0x0601330601330601ULL, 0x3306013306013306ULL, },
+        { 0x031a00031a00031aULL, 0x00031a00031a0003ULL, },
+        { 0x0201000201000201ULL, 0x0002010002010002ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x39240e39240e3924ULL, 0x0e39240e39240e39ULL, },
+        { 0x0704020704020704ULL, 0x0207040207040207ULL, },
+        { 0x0e09040e09040e09ULL, 0x040e09040e09040eULL, },
+        { 0x1c12071c12071c12ULL, 0x071c12071c12071cULL, },
+        { 0x1c02381c02381c02ULL, 0x381c02381c02381cULL, },
+        { 0x0e47000e47000e47ULL, 0x000e47000e47000eULL, },
+        { 0x0001020001020001ULL, 0x0200010200010200ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x071c32071c32071cULL, 0x32071c32071c3207ULL, },
+        { 0x0104060104060104ULL, 0x0601040601040601ULL, },
+        { 0x02070c02070c0207ULL, 0x0c02070c02070c02ULL, },
+        { 0x040e19040e19040eULL, 0x19040e19040e1904ULL, },
+        { 0x0402c70402c70402ULL, 0xc70402c70402c704ULL, },
+        { 0x0239020239020239ULL, 0x0202390202390202ULL, },
+        { 0x881b040d28190340ULL, 0x09010101040fb001ULL, },    /*  64  */
+        { 0x1102e61a010c0140ULL, 0x1301011808012c01ULL, },
+        { 0x091b043314010b40ULL, 0x01670001200f0601ULL, },
+        { 0x8801040601311501ULL, 0x02340b5e7f1f2c0cULL, },
+        { 0xfb3000064d250608ULL, 0x0202170000085210ULL, },
+        { 0x1f03000c02120208ULL, 0x0502170701001510ULL, },
+        { 0x1030001927011908ULL, 0x00f7030003080310ULL, },
+        { 0xfb010003014a3200ULL, 0x017cbb1a0b1015fcULL, },
+        { 0xac17030bb9340480ULL, 0x0502190403052501ULL, },    /*  72  */
+        { 0x1601ae15061a0180ULL, 0x0a02194005000901ULL, },
+        { 0x0b17032b5d021180ULL, 0x00d8030215050101ULL, },
+        { 0xac01030503682302ULL, 0x016cc6ff560b0914ULL, },
+        { 0x701400055e0c074eULL, 0x120211030308e20aULL, },
+        { 0x0e01160a0306024eULL, 0x230211360501390aULL, },
+        { 0x071400132f001c4eULL, 0x01f102021508070aULL, },
+        { 0x7001000201193901ULL, 0x047988d8551139a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_B(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_B(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
new file mode 100644
index 0000000..af6206b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRLR.D
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
+    char *instruction_name = "SRLR.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000400000ULL, 0x0000000000400000ULL, },
+        { 0x0000080000000000ULL, 0x0000080000000000ULL, },
+        { 0x0010000000000000ULL, 0x0010000000000000ULL, },
+        { 0x0000000000002000ULL, 0x0000000000002000ULL, },
+        { 0x0004000000000000ULL, 0x0000000020000000ULL, },
+        { 0x0000000000008000ULL, 0x0000001000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x00000000002aaaabULL, 0x00000000002aaaabULL, },
+        { 0x0000055555555555ULL, 0x0000055555555555ULL, },
+        { 0x000aaaaaaaaaaaabULL, 0x000aaaaaaaaaaaabULL, },
+        { 0x0000000000001555ULL, 0x0000000000001555ULL, },
+        { 0x0002aaaaaaaaaaabULL, 0x0000000015555555ULL, },
+        { 0x0000000000005555ULL, 0x0000000aaaaaaaabULL, },
+        { 0x0000000000000001ULL, 0x0000000000000001ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0000000000155555ULL, 0x0000000000155555ULL, },
+        { 0x000002aaaaaaaaabULL, 0x000002aaaaaaaaabULL, },
+        { 0x0005555555555555ULL, 0x0005555555555555ULL, },
+        { 0x0000000000000aabULL, 0x0000000000000aabULL, },
+        { 0x0001555555555555ULL, 0x000000000aaaaaabULL, },
+        { 0x0000000000002aabULL, 0x0000000555555555ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000333333ULL, 0x0000000000333333ULL, },
+        { 0x0000066666666666ULL, 0x0000066666666666ULL, },
+        { 0x000ccccccccccccdULL, 0x000ccccccccccccdULL, },
+        { 0x000000000000199aULL, 0x000000000000199aULL, },
+        { 0x0003333333333333ULL, 0x000000001999999aULL, },
+        { 0x0000000000006666ULL, 0x0000000ccccccccdULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x00000000000ccccdULL, 0x00000000000ccccdULL, },
+        { 0x000001999999999aULL, 0x000001999999999aULL, },
+        { 0x0003333333333333ULL, 0x0003333333333333ULL, },
+        { 0x0000000000000666ULL, 0x0000000000000666ULL, },
+        { 0x0000cccccccccccdULL, 0x0000000006666666ULL, },
+        { 0x000000000000199aULL, 0x0000000333333333ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x000000000038e38eULL, 0x00000000000e38e4ULL, },
+        { 0x0000071c71c71c72ULL, 0x000001c71c71c71cULL, },
+        { 0x000e38e38e38e38eULL, 0x00038e38e38e38e4ULL, },
+        { 0x0000000000001c72ULL, 0x000000000000071cULL, },
+        { 0x00038e38e38e38e4ULL, 0x00000000071c71c7ULL, },
+        { 0x00000000000071c7ULL, 0x000000038e38e38eULL, },
+        { 0x0000000000000000ULL, 0x0000000000000002ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0000000000071c72ULL, 0x000000000031c71cULL, },
+        { 0x000000e38e38e38eULL, 0x00000638e38e38e4ULL, },
+        { 0x0001c71c71c71c72ULL, 0x000c71c71c71c71cULL, },
+        { 0x000000000000038eULL, 0x00000000000018e4ULL, },
+        { 0x000071c71c71c71cULL, 0x0000000018e38e39ULL, },
+        { 0x0000000000000e39ULL, 0x0000000c71c71c72ULL, },
+        { 0x886ae6cc28625540ULL, 0x0004b670b5efe7bbULL, },    /*  64  */
+        { 0x00886ae6cc286255ULL, 0x0000000000000005ULL, },
+        { 0x886ae6cc28625540ULL, 0x000004b670b5efe8ULL, },
+        { 0x000221ab9b30a189ULL, 0x000000004b670b5fULL, },
+        { 0xfbbe00634d93c708ULL, 0x00012f7bb1a153f5ULL, },
+        { 0x00fbbe00634d93c7ULL, 0x0000000000000001ULL, },
+        { 0xfbbe00634d93c708ULL, 0x0000012f7bb1a154ULL, },
+        { 0x0003eef8018d364fULL, 0x0000000012f7bb1aULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x00027d8c6ffab2b2ULL, },    /*  72  */
+        { 0x00ac5aaeaab9cf8cULL, 0x0000000000000002ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x0000027d8c6ffab3ULL, },
+        { 0x0002b16abaaae73eULL, 0x0000000027d8c700ULL, },
+        { 0x704f164d5e31e24eULL, 0x0008df188d8a942eULL, },
+        { 0x00704f164d5e31e2ULL, 0x0000000000000009ULL, },
+        { 0x704f164d5e31e24eULL, 0x000008df188d8a94ULL, },
+        { 0x0001c13c593578c8ULL, 0x000000008df188d9ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_D(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_D(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
new file mode 100644
index 0000000..885a013
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRLR.H
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
+    char *instruction_name = "SRLR.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0040004000400040ULL, 0x0040004000400040ULL, },
+        { 0x0800080008000800ULL, 0x0800080008000800ULL, },
+        { 0x0010001000100010ULL, 0x0010001000100010ULL, },
+        { 0x2000200020002000ULL, 0x2000200020002000ULL, },
+        { 0x0004200001000004ULL, 0x2000010000042000ULL, },
+        { 0x8000001002008000ULL, 0x0010020080000010ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x002b002b002b002bULL, 0x002b002b002b002bULL, },
+        { 0x0555055505550555ULL, 0x0555055505550555ULL, },
+        { 0x000b000b000b000bULL, 0x000b000b000b000bULL, },
+        { 0x1555155515551555ULL, 0x1555155515551555ULL, },
+        { 0x0003155500ab0003ULL, 0x155500ab00031555ULL, },
+        { 0x5555000b01555555ULL, 0x000b01555555000bULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015001500150015ULL, 0x0015001500150015ULL, },
+        { 0x02ab02ab02ab02abULL, 0x02ab02ab02ab02abULL, },
+        { 0x0005000500050005ULL, 0x0005000500050005ULL, },
+        { 0x0aab0aab0aab0aabULL, 0x0aab0aab0aab0aabULL, },
+        { 0x00010aab00550001ULL, 0x0aab005500010aabULL, },
+        { 0x2aab000500ab2aabULL, 0x000500ab2aab0005ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0033003300330033ULL, 0x0033003300330033ULL, },
+        { 0x0666066606660666ULL, 0x0666066606660666ULL, },
+        { 0x000d000d000d000dULL, 0x000d000d000d000dULL, },
+        { 0x199a199a199a199aULL, 0x199a199a199a199aULL, },
+        { 0x0003199a00cd0003ULL, 0x199a00cd0003199aULL, },
+        { 0x6666000d019a6666ULL, 0x000d019a6666000dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000d000d000d000dULL, 0x000d000d000d000dULL, },
+        { 0x019a019a019a019aULL, 0x019a019a019a019aULL, },
+        { 0x0003000300030003ULL, 0x0003000300030003ULL, },
+        { 0x0666066606660666ULL, 0x0666066606660666ULL, },
+        { 0x0001066600330001ULL, 0x0666003300010666ULL, },
+        { 0x199a00030066199aULL, 0x00030066199a0003ULL, },
+        { 0x0002000000010002ULL, 0x0000000100020000ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0039000e00240039ULL, 0x000e00240039000eULL, },
+        { 0x071c01c70472071cULL, 0x01c70472071c01c7ULL, },
+        { 0x000e00040009000eULL, 0x00040009000e0004ULL, },
+        { 0x1c72071c11c71c72ULL, 0x071c11c71c72071cULL, },
+        { 0x0004071c008e0004ULL, 0x071c008e0004071cULL, },
+        { 0x71c70004011c71c7ULL, 0x0004011c71c70004ULL, },
+        { 0x0000000200010000ULL, 0x0002000100000002ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00070032001c0007ULL, 0x0032001c00070032ULL, },
+        { 0x00e40639038e00e4ULL, 0x0639038e00e40639ULL, },
+        { 0x0002000c00070002ULL, 0x000c00070002000cULL, },
+        { 0x038e18e40e39038eULL, 0x18e40e39038e18e4ULL, },
+        { 0x000018e400720000ULL, 0x18e40072000018e4ULL, },
+        { 0x0e39000c00e40e39ULL, 0x000c00e40e39000cULL, },
+        { 0x0022000e0a195540ULL, 0x009700000020000bULL, },    /*  64  */
+        { 0x00021cda050c0055ULL, 0x009700030002000bULL, },
+        { 0x0022003a00005540ULL, 0x004b000000200b01ULL, },
+        { 0x0001000714310001ULL, 0x25b4000b3f9fb00cULL, },
+        { 0x003f00001365c708ULL, 0x0026000300030005ULL, },
+        { 0x0004000c09b200c7ULL, 0x0026002f00000005ULL, },
+        { 0x003f00000001c708ULL, 0x0013000100030530ULL, },
+        { 0x0002000026ca0003ULL, 0x097c00bb055052fcULL, },
+        { 0x002b000b2e748b80ULL, 0x0050000300150002ULL, },    /*  72  */
+        { 0x000315d5173a008cULL, 0x0050003200010002ULL, },
+        { 0x002b002c00018b80ULL, 0x0028000200150251ULL, },
+        { 0x000100055ce80002ULL, 0x13ec00c72acb2514ULL, },
+        { 0x001c0001178ce24eULL, 0x011c00020015000eULL, },
+        { 0x000202ca0bc600e2ULL, 0x011c00220001000eULL, },
+        { 0x001c00060001e24eULL, 0x008e000100150e2aULL, },
+        { 0x000100012f190004ULL, 0x46f900892a51e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_H(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_H(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
new file mode 100644
index 0000000..172b5ba
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
@@ -0,0 +1,153 @@
+/*
+ *  Test program for MSA instruction SRLR.W
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
+    char *instruction_name = "SRLR.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0040000000400000ULL, 0x0040000000400000ULL, },
+        { 0x0000080000000800ULL, 0x0000080000000800ULL, },
+        { 0x0010000000100000ULL, 0x0010000000100000ULL, },
+        { 0x0000200000002000ULL, 0x0000200000002000ULL, },
+        { 0x2000000000040000ULL, 0x0000010020000000ULL, },
+        { 0x0000001000008000ULL, 0x0200000000000010ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x002aaaab002aaaabULL, 0x002aaaab002aaaabULL, },
+        { 0x0000055500000555ULL, 0x0000055500000555ULL, },
+        { 0x000aaaab000aaaabULL, 0x000aaaab000aaaabULL, },
+        { 0x0000155500001555ULL, 0x0000155500001555ULL, },
+        { 0x155555550002aaabULL, 0x000000ab15555555ULL, },
+        { 0x0000000b00005555ULL, 0x015555550000000bULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x0015555500155555ULL, 0x0015555500155555ULL, },
+        { 0x000002ab000002abULL, 0x000002ab000002abULL, },
+        { 0x0005555500055555ULL, 0x0005555500055555ULL, },
+        { 0x00000aab00000aabULL, 0x00000aab00000aabULL, },
+        { 0x0aaaaaab00015555ULL, 0x000000550aaaaaabULL, },
+        { 0x0000000500002aabULL, 0x00aaaaab00000005ULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0033333300333333ULL, 0x0033333300333333ULL, },
+        { 0x0000066600000666ULL, 0x0000066600000666ULL, },
+        { 0x000ccccd000ccccdULL, 0x000ccccd000ccccdULL, },
+        { 0x0000199a0000199aULL, 0x0000199a0000199aULL, },
+        { 0x1999999a00033333ULL, 0x000000cd1999999aULL, },
+        { 0x0000000d00006666ULL, 0x0199999a0000000dULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x000ccccd000ccccdULL, 0x000ccccd000ccccdULL, },
+        { 0x0000019a0000019aULL, 0x0000019a0000019aULL, },
+        { 0x0003333300033333ULL, 0x0003333300033333ULL, },
+        { 0x0000066600000666ULL, 0x0000066600000666ULL, },
+        { 0x066666660000cccdULL, 0x0000003306666666ULL, },
+        { 0x000000030000199aULL, 0x0066666600000003ULL, },
+        { 0x0000000200000001ULL, 0x0000000000000002ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0038e38e00238e39ULL, 0x000e38e40038e38eULL, },
+        { 0x0000071c00000472ULL, 0x000001c70000071cULL, },
+        { 0x000e38e40008e38eULL, 0x00038e39000e38e4ULL, },
+        { 0x00001c72000011c7ULL, 0x0000071c00001c72ULL, },
+        { 0x1c71c71c000238e4ULL, 0x000000391c71c71cULL, },
+        { 0x0000000e0000471cULL, 0x0071c71c0000000eULL, },
+        { 0x0000000000000001ULL, 0x0000000200000000ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x00071c72001c71c7ULL, 0x0031c71c00071c72ULL, },
+        { 0x000000e40000038eULL, 0x00000639000000e4ULL, },
+        { 0x0001c71c00071c72ULL, 0x000c71c70001c71cULL, },
+        { 0x0000038e00000e39ULL, 0x000018e40000038eULL, },
+        { 0x038e38e40001c71cULL, 0x000000c7038e38e4ULL, },
+        { 0x00000002000038e4ULL, 0x018e38e400000002ULL, },
+        { 0x000886ae28625540ULL, 0x00000001000fe7bbULL, },    /*  64  */
+        { 0x110d5cda00286255ULL, 0x0000001300000010ULL, },
+        { 0x00221aba28625540ULL, 0x0000000100000fe8ULL, },
+        { 0x000443570000a189ULL, 0x0000004bfe7bb00cULL, },
+        { 0x000fbbe04d93c708ULL, 0x00000000000153f5ULL, },
+        { 0x1f77c00c004d93c7ULL, 0x0000000500000001ULL, },
+        { 0x003eef804d93c708ULL, 0x0000000000000154ULL, },
+        { 0x0007ddf00001364fULL, 0x00000013153f52fcULL, },
+        { 0x000ac5abb9cf8b80ULL, 0x00000001000ab2b2ULL, },    /*  72  */
+        { 0x158b55d500b9cf8cULL, 0x0000000a0000000bULL, },
+        { 0x002b16acb9cf8b80ULL, 0x0000000000000ab3ULL, },
+        { 0x000562d50002e73eULL, 0x00000028ab2b2514ULL, },
+        { 0x000704f15e31e24eULL, 0x00000002000a942eULL, },
+        { 0x0e09e2ca005e31e2ULL, 0x000000230000000bULL, },
+        { 0x001c13c65e31e24eULL, 0x0000000100000a94ULL, },
+        { 0x00038279000178c8ULL, 0x0000008ea942e2a0ULL, },
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_W(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_SRLR_W(b128_random[i], b128_random[j],
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


