Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF844C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C62213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C62213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfkSA-00034U-OT
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfkLF-00060b-14
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hfkLB-00031h-0a
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:14:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50972 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hfkL7-00026C-76
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:14:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 887351A46F3;
 Tue, 25 Jun 2019 14:13:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4E4591A46D9;
 Tue, 25 Jun 2019 14:13:16 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 14:12:53 +0200
Message-Id: <1561464774-20548-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561464774-20548-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561464774-20548-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 4/5] tests/tcg: target/mips: Amend tests for
 MSA int multiply instructions
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Amend tests for MSA int multiply instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_compile.sh    |  16 ++
 2 files changed, 230 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c

diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
new file mode 100644
index 0000000..7d7e16e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction MADDV.D
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
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
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
+
+#define TEST_COUNT_TOTAL (                                                \
+            (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Int Multiply";
+    char *instruction_name =  "MADDV.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+         { 0x0000000000000002ULL, 0x0000000000000002ULL, },    /*   0  */
+        { 0x0000000000000002ULL, 0x0000000000000002ULL, },
+        { 0x00000000aaaaaaaeULL, 0x00000000aaaaaaaeULL, },
+        { 0x0000000000000004ULL, 0x0000000000000004ULL, },
+        { 0x000000006666666cULL, 0x000000006666666cULL, },
+        { 0x0000000000000006ULL, 0x0000000000000006ULL, },
+        { 0x000000008e38e395ULL, 0xffffffffe38e38ebULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },    /*   8  */
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x0000000000000008ULL, 0x0000000000000008ULL, },
+        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },    /*  16  */
+        { 0x00000000aaaaaab4ULL, 0x00000000aaaaaab4ULL, },
+        { 0x38e38e3a71c71c7cULL, 0x38e38e3a71c71c7cULL, },
+        { 0x0000000155555560ULL, 0x0000000155555560ULL, },
+        { 0x2222222444444450ULL, 0x2222222444444450ULL, },
+        { 0x000000020000000cULL, 0x000000020000000cULL, },
+        { 0x2f684bdcb425ed16ULL, 0xf684bda397b425faULL, },
+        { 0x00000002aaaaaab8ULL, 0x00000002aaaaaab8ULL, },
+        { 0x000000020000000eULL, 0x000000020000000eULL, },    /*  24  */
+        { 0x000000020000000eULL, 0x000000020000000eULL, },
+        { 0xc71c71c8e38e38f2ULL, 0xc71c71c8e38e38f2ULL, },
+        { 0x0000000155555564ULL, 0x0000000155555564ULL, },
+        { 0xdddddddeccccccdcULL, 0xdddddddeccccccdcULL, },
+        { 0x00000000aaaaaabaULL, 0x00000000aaaaaabaULL, },
+        { 0xd097b42684bda13fULL, 0x097b425ef684bdb1ULL, },
+        { 0x0000000000000010ULL, 0x0000000000000010ULL, },
+        { 0x0000000066666678ULL, 0x0000000066666678ULL, },    /*  32  */
+        { 0x0000000066666678ULL, 0x0000000066666678ULL, },
+        { 0x2222222355555568ULL, 0x2222222355555568ULL, },
+        { 0x00000000cccccce0ULL, 0x00000000cccccce0ULL, },
+        { 0x147ae1491eb85200ULL, 0x147ae1491eb85200ULL, },
+        { 0x0000000133333348ULL, 0x0000000133333348ULL, },
+        { 0x1c71c71e3e93e954ULL, 0xfa4fa4fbb60b60ccULL, },
+        { 0x00000001999999b0ULL, 0x00000001999999b0ULL, },
+        { 0x000000013333334aULL, 0x000000013333334aULL, },    /*  40  */
+        { 0x000000013333334aULL, 0x000000013333334aULL, },
+        { 0xdddddddeeeeeef06ULL, 0xdddddddeeeeeef06ULL, },
+        { 0x00000000cccccce4ULL, 0x00000000cccccce4ULL, },
+        { 0xeb851eb8e147ae2cULL, 0xeb851eb8e147ae2cULL, },
+        { 0x000000006666667eULL, 0x000000006666667eULL, },
+        { 0xe38e38e3e93e9401ULL, 0x05b05b05c71c71dfULL, },
+        { 0x0000000000000018ULL, 0x0000000000000018ULL, },
+        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },    /*  48  */
+        { 0x000000008e38e3a7ULL, 0xffffffffe38e38fdULL, },
+        { 0x2f684bdb425ed0b1ULL, 0xf684bda17b425eebULL, },
+        { 0x000000011c71c736ULL, 0xffffffffc71c71e2ULL, },
+        { 0x1c71c71e27d27d42ULL, 0xfa4fa4fa49f49f66ULL, },
+        { 0x00000001aaaaaac5ULL, 0xffffffffaaaaaac7ULL, },
+        { 0x35ba781b4587e6d2ULL, 0x0fcd6e9d6b74f050ULL, },
+        { 0x0000000238e38e54ULL, 0xffffffff8e38e3acULL, },
+        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },    /*  56  */
+        { 0x00000001aaaaaac7ULL, 0xffffffffaaaaaac9ULL, },
+        { 0xd097b427a12f6869ULL, 0x097b425ebda12f87ULL, },
+        { 0x000000011c71c73aULL, 0xffffffffc71c71e6ULL, },
+        { 0xe38e38e477777796ULL, 0x05b05b05aaaaaacaULL, },
+        { 0x000000008e38e3adULL, 0xffffffffe38e3903ULL, },
+        { 0xca4587e781948b2fULL, 0xf032916206522c5fULL, },
+        { 0x0000000000000020ULL, 0x0000000000000020ULL, },
+        { 0x3e3ad4ae1266c2b0ULL, 0x1637d725aebdb734ULL, },    /*  64  */
+        { 0x4c74e0d60a3d6d94ULL, 0x1badd2dd9f4dac90ULL, },
+        { 0x6874e8f94205b90cULL, 0x27eb0c41af2c3022ULL, },
+        { 0x42dab657e16f25e8ULL, 0x06d6782e137656f2ULL, },
+        { 0x5114c27fd945d0ccULL, 0x0c4c73e604064c4eULL, },
+        { 0x68a91e898c276755ULL, 0x0f77ad378bdfb302ULL, },
+        { 0x54c82cde41d1cf13ULL, 0x0b6108a5f38e1598ULL, },
+        { 0x6f755d3eddd1234aULL, 0xfbbaace2f5421908ULL, },
+        { 0x8b75656215996ec2ULL, 0x07f7e64705209c9aULL, },    /*  72  */
+        { 0x779473b6cb43d680ULL, 0x03e141b56cceff30ULL, },
+        { 0xa6279a1866fb9f64ULL, 0x2631668db9e53ac1ULL, },
+        { 0x67a1f71bd99e4586ULL, 0x312ec9f6206e6e69ULL, },
+        { 0x4207c47a7907b262ULL, 0x101a35e284b89539ULL, },
+        { 0x5cb4f4db15070699ULL, 0x0073da1f866c98a9ULL, },
+        { 0x1e2f51de87a9acbbULL, 0x0b713d87ecf5cc51ULL, },
+        { 0x721d49ba5f0acfa8ULL, 0x5ba5bbe9afeae691ULL, },
+        { 0x4bcd68690d995de0ULL, 0x771da6b4b6c967ebULL, },    /*  80  */
+        { 0x4ea9a2cfbb5acd7bULL, 0x79dd6a73439e6387ULL, },
+        { 0x47c800b999dd2371ULL, 0x766d25914ef7a7a0ULL, },
+        { 0x41b0fa10eb77cf84ULL, 0x26e85189458965f8ULL, },
+        { 0x1fc448ce062c2944ULL, 0x31f490a9422a80e6ULL, },
+        { 0x211bdfadfd79770eULL, 0x3b25f4cac5763378ULL, },
+        { 0x16fbb87edd87b6f0ULL, 0x57c0b65fabdda20eULL, },
+        { 0x14621091eac4a5f6ULL, 0x4d29a25d32fa9ef6ULL, },
+        { 0x07832ded1c464b02ULL, 0x6396905709e3cfa4ULL, },    /*  88  */
+        { 0x0ff4a84eab8df3b9ULL, 0x6bc9a7d8c6adf2eaULL, },
+        { 0x21e53326bfbd0b05ULL, 0x8f8f3b9c679dff5aULL, },
+        { 0x191ed6a24e1576f9ULL, 0x9e8c2e402760373aULL, },
+        { 0x19b438400fc27751ULL, 0x819c4bbfd3ee6972ULL, },
+        { 0x1e0d5dc1094ae999ULL, 0x7496a289f5eff010ULL, },
+        { 0x11af620b7bc03943ULL, 0x8a11f229836addc7ULL, },
+        { 0x46fa45d0e84440fcULL, 0xe8d2c0211fb042bfULL, },
+        { 0x22142516b5a8adbcULL, 0xe1cf1923e186aad1ULL, },    /*  96  */
+        { 0x066ebbbb4ff6da44ULL, 0xd918d7e6a7e61877ULL, },
+        { 0x100acc9d22839a48ULL, 0xce291932929e367fULL, },
+        { 0x0dfe419d62a62f64ULL, 0xc020fe45a8cf7acfULL, },
+        { 0x2ba79b6ffbf3c63bULL, 0xb428f52c49fce695ULL, },
+        { 0x29b3b85200bdf100ULL, 0xb4ae7ea2f52aa5b9ULL, },
+        { 0x293bb84d6360c0b6ULL, 0xae33b26e4c493c49ULL, },
+        { 0x46a99fdf54f4862dULL, 0xae790dc5055f6f51ULL, },
+        { 0x18480e0fd728c7c3ULL, 0xa000ad7b15f8ebe0ULL, },    /* 104  */
+        { 0x1b8b97aa205e1239ULL, 0x89c78b8909c4a8e5ULL, },
+        { 0x09abb26b05ef649dULL, 0x74242fa1bd49e740ULL, },
+        { 0x04e233bc861d272bULL, 0x9c5343ab30f62f9fULL, },
+        { 0xda2da0d0884dc3d1ULL, 0xb824f201640b4147ULL, },
+        { 0x9d8b22ee1b9a2e0fULL, 0xb642ddf1edb0747fULL, },
+        { 0x7c81956533686a37ULL, 0xdd5181781dc3ad37ULL, },
+        { 0xc60b1905717ff25aULL, 0xe2af726e71ad7ad7ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDV_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDV_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDV_D__DDT(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    ((RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDV_D__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret = check_results_128(isa_ase_name, group_name, instruction_name,
+                            TEST_COUNT_TOTAL, elapsed_time,
+                            &b128_result[0][0], &b128_expect[0][0]);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
index 16920e8..d45ee4b 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
@@ -397,6 +397,22 @@
 # Int Multiply
 # ------------
 #
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddv_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddv_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddv_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_maddv_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddv_d
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_b.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubv_b
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_h.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubv_h
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_w.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubv_w
+/opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_msubv_d.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubv_d
 /opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_b.c          \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mulv_b
 /opt/img/bin/mips-img-linux-gnu-gcc    int-multiply/test_msa_mulv_h.c          \
-- 
2.7.4


