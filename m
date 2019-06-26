Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F23C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5362720656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5362720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg51J-0007SJ-J5
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg4py-0006HI-2S
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg4pn-0003OC-A8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39219 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg4pm-0003LP-8F
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 18FBD1A1E6B;
 Wed, 26 Jun 2019 12:07:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 8B1531A23E2;
 Wed, 26 Jun 2019 12:07:19 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 12:07:04 +0200
Message-Id: <1561543629-20327-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561543629-20327-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561543629-20327-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v6 3/8] tests/tcg: target/mips: Amend tests for
 MSA int dot product instructions
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

Add tests for instructions whose result depends on the value in destination
register (prior to instruction execution).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h              |  40 ++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_d.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_h.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_w.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_d.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_h.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_w.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_d.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_h.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_w.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_d.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_h.c   | 214 +++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_w.c   | 214 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_compile.sh    |  24 +++
 tests/tcg/mips/user/ase/msa/test_msa_run.sh        |  12 ++
 15 files changed, 2644 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 2692394..cfb3b8b 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -413,6 +413,46 @@ DO_MSA__WD__WS_WT(DOTP_U_H, dotp_u.h)
 DO_MSA__WD__WS_WT(DOTP_U_W, dotp_u.w)
 DO_MSA__WD__WS_WT(DOTP_U_D, dotp_u.d)
 
+DO_MSA__WD__WS_WT(DPADD_S_H, dpadd_s.h)
+DO_MSA__WD__WD_WT(DPADD_S_H__DDT, dpadd_s.h)
+DO_MSA__WD__WS_WD(DPADD_S_H__DSD, dpadd_s.h)
+DO_MSA__WD__WS_WT(DPADD_S_W, dpadd_s.w)
+DO_MSA__WD__WD_WT(DPADD_S_W__DDT, dpadd_s.w)
+DO_MSA__WD__WS_WD(DPADD_S_W__DSD, dpadd_s.w)
+DO_MSA__WD__WS_WT(DPADD_S_D, dpadd_s.d)
+DO_MSA__WD__WD_WT(DPADD_S_D__DDT, dpadd_s.d)
+DO_MSA__WD__WS_WD(DPADD_S_D__DSD, dpadd_s.d)
+
+DO_MSA__WD__WS_WT(DPADD_U_H, dpadd_u.h)
+DO_MSA__WD__WD_WT(DPADD_U_H__DDT, dpadd_u.h)
+DO_MSA__WD__WS_WD(DPADD_U_H__DSD, dpadd_u.h)
+DO_MSA__WD__WS_WT(DPADD_U_W, dpadd_u.w)
+DO_MSA__WD__WD_WT(DPADD_U_W__DDT, dpadd_u.w)
+DO_MSA__WD__WS_WD(DPADD_U_W__DSD, dpadd_u.w)
+DO_MSA__WD__WS_WT(DPADD_U_D, dpadd_u.d)
+DO_MSA__WD__WD_WT(DPADD_U_D__DDT, dpadd_u.d)
+DO_MSA__WD__WS_WD(DPADD_U_D__DSD, dpadd_u.d)
+
+DO_MSA__WD__WS_WT(DPSUB_S_H, dpsub_s.h)
+DO_MSA__WD__WD_WT(DPSUB_S_H__DDT, dpsub_s.h)
+DO_MSA__WD__WS_WD(DPSUB_S_H__DSD, dpsub_s.h)
+DO_MSA__WD__WS_WT(DPSUB_S_W, dpsub_s.w)
+DO_MSA__WD__WD_WT(DPSUB_S_W__DDT, dpsub_s.w)
+DO_MSA__WD__WS_WD(DPSUB_S_W__DSD, dpsub_s.w)
+DO_MSA__WD__WS_WT(DPSUB_S_D, dpsub_s.d)
+DO_MSA__WD__WD_WT(DPSUB_S_D__DDT, dpsub_s.d)
+DO_MSA__WD__WS_WD(DPSUB_S_D__DSD, dpsub_s.d)
+
+DO_MSA__WD__WS_WT(DPSUB_U_H, dpsub_u.h)
+DO_MSA__WD__WD_WT(DPSUB_U_H__DDT, dpsub_u.h)
+DO_MSA__WD__WS_WD(DPSUB_U_H__DSD, dpsub_u.h)
+DO_MSA__WD__WS_WT(DPSUB_U_W, dpsub_u.w)
+DO_MSA__WD__WD_WT(DPSUB_U_W__DDT, dpsub_u.w)
+DO_MSA__WD__WS_WD(DPSUB_U_W__DSD, dpsub_u.w)
+DO_MSA__WD__WS_WT(DPSUB_U_D, dpsub_u.d)
+DO_MSA__WD__WD_WT(DPSUB_U_D__DDT, dpsub_u.d)
+DO_MSA__WD__WS_WD(DPSUB_U_D__DSD, dpsub_u.d)
+
 
 /*
  * Int Max Min
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
new file mode 100644
index 0000000..d039e1a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPADD_S.D
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPADD_S.D";
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
+            do_msa_DPADD_S_D(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_D(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_D__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_D__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
new file mode 100644
index 0000000..bcaafe3
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPADD_S.H
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPADD_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },    /*   0  */
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x00ae00ae00ae00aeULL, 0x00ae00ae00ae00aeULL, },
+        { 0x0004000400040004ULL, 0x0004000400040004ULL, },
+        { 0x006c006c006c006cULL, 0x006c006c006c006cULL, },
+        { 0x0006000600060006ULL, 0x0006000600060006ULL, },
+        { 0x0095ffeb00400095ULL, 0xffeb00400095ffebULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },    /*   8  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x00b400b400b400b4ULL, 0x00b400b400b400b4ULL, },    /*  16  */
+        { 0x00b400b400b400b4ULL, 0x00b400b400b400b4ULL, },
+        { 0x3a7c3a7c3a7c3a7cULL, 0x3a7c3a7c3a7c3a7cULL, },
+        { 0x0160016001600160ULL, 0x0160016001600160ULL, },
+        { 0x2450245024502450ULL, 0x2450245024502450ULL, },
+        { 0x020c020c020c020cULL, 0x020c020c020c020cULL, },
+        { 0x3216f8fa15883216ULL, 0xf8fa15883216f8faULL, },
+        { 0x02b802b802b802b8ULL, 0x02b802b802b802b8ULL, },
+        { 0x020e020e020e020eULL, 0x020e020e020e020eULL, },    /*  24  */
+        { 0x020e020e020e020eULL, 0x020e020e020e020eULL, },
+        { 0xc8f2c8f2c8f2c8f2ULL, 0xc8f2c8f2c8f2c8f2ULL, },
+        { 0x0164016401640164ULL, 0x0164016401640164ULL, },
+        { 0xdedcdedcdedcdedcULL, 0xdedcdedcdedcdedcULL, },
+        { 0x00ba00ba00ba00baULL, 0x00ba00ba00ba00baULL, },
+        { 0xd13f09b1ed78d13fULL, 0x09b1ed78d13f09b1ULL, },
+        { 0x0010001000100010ULL, 0x0010001000100010ULL, },
+        { 0x0078007800780078ULL, 0x0078007800780078ULL, },    /*  32  */
+        { 0x0078007800780078ULL, 0x0078007800780078ULL, },
+        { 0x2368236823682368ULL, 0x2368236823682368ULL, },
+        { 0x00e000e000e000e0ULL, 0x00e000e000e000e0ULL, },
+        { 0x1600160016001600ULL, 0x1600160016001600ULL, },
+        { 0x0148014801480148ULL, 0x0148014801480148ULL, },
+        { 0x1e54fbcc0d101e54ULL, 0xfbcc0d101e54fbccULL, },
+        { 0x01b001b001b001b0ULL, 0x01b001b001b001b0ULL, },
+        { 0x014a014a014a014aULL, 0x014a014a014a014aULL, },    /*  40  */
+        { 0x014a014a014a014aULL, 0x014a014a014a014aULL, },
+        { 0xdf06df06df06df06ULL, 0xdf06df06df06df06ULL, },
+        { 0x00e400e400e400e4ULL, 0x00e400e400e400e4ULL, },
+        { 0xec2cec2cec2cec2cULL, 0xec2cec2cec2cec2cULL, },
+        { 0x007e007e007e007eULL, 0x007e007e007e007eULL, },
+        { 0xe40105dff4f0e401ULL, 0x05dff4f0e40105dfULL, },
+        { 0x0018001800180018ULL, 0x0018001800180018ULL, },
+        { 0x00a7fffd005200a7ULL, 0xfffd005200a7fffdULL, },    /*  48  */
+        { 0x00a7fffd005200a7ULL, 0xfffd005200a7fffdULL, },
+        { 0x30b1f6eb13ce30b1ULL, 0xf6eb13ce30b1f6ebULL, },
+        { 0x0136ffe2008c0136ULL, 0xffe2008c0136ffe2ULL, },
+        { 0x1e42fa660c541e42ULL, 0xfa660c541e42fa66ULL, },
+        { 0x01c5ffc700c601c5ULL, 0xffc700c601c5ffc7ULL, },
+        { 0x37d20f503fca37d2ULL, 0x0f503fca37d20f50ULL, },
+        { 0x0254ffac01000254ULL, 0xffac01000254ffacULL, },
+        { 0x01c7ffc900c801c7ULL, 0xffc900c801c7ffc9ULL, },    /*  56  */
+        { 0x01c7ffc900c801c7ULL, 0xffc900c801c7ffc9ULL, },
+        { 0xd2690987edf8d269ULL, 0x0987edf8d2690987ULL, },
+        { 0x013affe60090013aULL, 0xffe60090013affe6ULL, },
+        { 0xe49605caf530e496ULL, 0x05caf530e49605caULL, },
+        { 0x00ad0003005800adULL, 0x0003005800ad0003ULL, },
+        { 0xcb2ff05fc18ecb2fULL, 0xf05fc18ecb2ff05fULL, },
+        { 0x0020002000200020ULL, 0x0020002000200020ULL, },
+        { 0x64440d542be42c59ULL, 0x3f8a231d3b3d19b0ULL, },    /*  64  */
+        { 0x4b48f9380e321b6cULL, 0x413129b25958ffe0ULL, },
+        { 0x97ec1304f058d493ULL, 0x3c8626d66eabf540ULL, },
+        { 0x8422012411cade1dULL, 0x14cc12fe8f0ffa20ULL, },
+        { 0x6b26ed08f418cd30ULL, 0x16731993ad2ae050ULL, },
+        { 0x7c43135139aada21ULL, 0x18082ed0be64faa4ULL, },
+        { 0x66b3f20f392cf02eULL, 0x1c2e3e58c200062eULL, },
+        { 0x50250fd64095f94cULL, 0x149f5aa0cb1bfe12ULL, },
+        { 0x9cc929a222bbb273ULL, 0x0ff457c4e06ef372ULL, },    /*  72  */
+        { 0x87390860223dc880ULL, 0x141a674ce40afefcULL, },
+        { 0xc26d3f883f4f3df9ULL, 0x204b7471077c05e5ULL, },
+        { 0xb9731e9e1bdc24afULL, 0x111e8fc92f75fa0fULL, },
+        { 0xa5a90cbe3d4e2e39ULL, 0xe9647bf14fd9feefULL, },
+        { 0x8f1b2a8544b73757ULL, 0xe1d5983958f4f6d3ULL, },
+        { 0x8621099b21441e0dULL, 0xd2a8b39180edeafdULL, },
+        { 0xcf8222a84d293955ULL, 0x0732f211af821281ULL, },
+        { 0xb24e311468e36182ULL, 0x1d5df7b5739a06edULL, },    /*  80  */
+        { 0x9fb838d0948447f9ULL, 0x1c22f28463ef0925ULL, },
+        { 0xa63c3700ca342b06ULL, 0x1b16f62c40350d56ULL, },
+        { 0x91603bbac05427d0ULL, 0x0dabf3fc381feb90ULL, },
+        { 0xed2843f4d67c28c3ULL, 0xef47f1f54694ece0ULL, },
+        { 0xe3373f50950e1df3ULL, 0xeb96f4e231bee6f8ULL, },
+        { 0x00111042b00d1732ULL, 0xf8f3f7b81663e296ULL, },
+        { 0x0550257c952a23bcULL, 0xfd4e0730286f0ddaULL, },
+        { 0x2418088a94861e5bULL, 0x1bcf191d5d740802ULL, },    /*  88  */
+        { 0x1d34dae8a7fc1a85ULL, 0x1f6e155281a10a8aULL, },
+        { 0x25f8ef24c16f4c23ULL, 0x12f7103e9bd702c4ULL, },
+        { 0x33b0f882bf8c4de5ULL, 0x0b68ff0eb3981908ULL, },
+        { 0xfaa812ea88fc60b6ULL, 0x38790427823a1198ULL, },
+        { 0x11760a6866984906ULL, 0x38280709862a18aaULL, },
+        { 0x355ee4445e3624a9ULL, 0x3a70056ab5ba156aULL, },
+        { 0x6990f6508b1005efULL, 0x19d2f282bd2beb34ULL, },
+        { 0x09f8e7147ee80358ULL, 0x0ea3c3a4d25af434ULL, },    /*  96  */
+        { 0x0270e58e89681a57ULL, 0xed529f3dfdf4fa64ULL, },
+        { 0x2fe0ff749ea038b9ULL, 0x08bfb178f83600f4ULL, },
+        { 0x0c98e7fe6a903991ULL, 0xf0f0da2312380064ULL, },
+        { 0x272ce738ba222968ULL, 0xf060e7ef217afed4ULL, },
+        { 0x1b11fce0969a2387ULL, 0xebe0ecf24235fee0ULL, },
+        { 0x1628f080a22617f4ULL, 0xeb86f0ea54aafebcULL, },
+        { 0x0b6abf0075b21275ULL, 0xee56f2fe4664ff28ULL, },
+        { 0x2d12d3d2642dcfbbULL, 0xde28f62c3ff20223ULL, },    /* 104  */
+        { 0x24a2f1b03fd408a0ULL, 0xd2baf84428ad0529ULL, },
+        { 0xf7c6115e36c734f8ULL, 0xd6a8f9d00d740916ULL, },
+        { 0xe656ec5832b62134ULL, 0xde02fb961c9f0c1bULL, },
+        { 0xf580051836e82d2eULL, 0xed2a0e7efa190093ULL, },
+        { 0xc9300cbe462435ecULL, 0xf33df43e02952973ULL, },
+        { 0xbff0f9ec66bc299eULL, 0xf581f02ee651f985ULL, },
+        { 0x9e90f34e7f2c06f4ULL, 0x01e3f07e04092877ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_H(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_H(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_H__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_H__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
new file mode 100644
index 0000000..90562ab
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPADD_S.W
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPADD_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },    /*   0  */
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x0000aaae0000aaaeULL, 0x0000aaae0000aaaeULL, },
+        { 0x0000000400000004ULL, 0x0000000400000004ULL, },
+        { 0x0000666c0000666cULL, 0x0000666c0000666cULL, },
+        { 0x0000000600000006ULL, 0x0000000600000006ULL, },
+        { 0xffffe39500008e40ULL, 0x000038ebffffe395ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },    /*   8  */
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000000800000008ULL, 0x0000000800000008ULL, },
+        { 0x0000aab40000aab4ULL, 0x0000aab40000aab4ULL, },    /*  16  */
+        { 0x0000aab40000aab4ULL, 0x0000aab40000aab4ULL, },
+        { 0x38e51c7c38e51c7cULL, 0x38e51c7c38e51c7cULL, },
+        { 0x0001556000015560ULL, 0x0001556000015560ULL, },
+        { 0x2224445022244450ULL, 0x2224445022244450ULL, },
+        { 0x0002000c0002000cULL, 0x0002000c0002000cULL, },
+        { 0xf686ed162f6b0988ULL, 0x12f925faf686ed16ULL, },
+        { 0x0002aab80002aab8ULL, 0x0002aab80002aab8ULL, },
+        { 0x0002000e0002000eULL, 0x0002000e0002000eULL, },    /*  24  */
+        { 0x0002000e0002000eULL, 0x0002000e0002000eULL, },
+        { 0xc71e38f2c71e38f2ULL, 0xc71e38f2c71e38f2ULL, },
+        { 0x0001556400015564ULL, 0x0001556400015564ULL, },
+        { 0xdddeccdcdddeccdcULL, 0xdddeccdcdddeccdcULL, },
+        { 0x0000aaba0000aabaULL, 0x0000aaba0000aabaULL, },
+        { 0x097ba13fd0982f78ULL, 0xed09bdb1097ba13fULL, },
+        { 0x0000001000000010ULL, 0x0000001000000010ULL, },
+        { 0x0000667800006678ULL, 0x0000667800006678ULL, },    /*  32  */
+        { 0x0000667800006678ULL, 0x0000667800006678ULL, },
+        { 0x2223556822235568ULL, 0x2223556822235568ULL, },
+        { 0x0000cce00000cce0ULL, 0x0000cce00000cce0ULL, },
+        { 0x147c5200147c5200ULL, 0x147c5200147c5200ULL, },
+        { 0x0001334800013348ULL, 0x0001334800013348ULL, },
+        { 0xfa50e9541c73a510ULL, 0x0b6260ccfa50e954ULL, },
+        { 0x000199b0000199b0ULL, 0x000199b0000199b0ULL, },
+        { 0x0001334a0001334aULL, 0x0001334a0001334aULL, },    /*  40  */
+        { 0x0001334a0001334aULL, 0x0001334a0001334aULL, },
+        { 0xdddeef06dddeef06ULL, 0xdddeef06dddeef06ULL, },
+        { 0x0000cce40000cce4ULL, 0x0000cce40000cce4ULL, },
+        { 0xeb85ae2ceb85ae2cULL, 0xeb85ae2ceb85ae2cULL, },
+        { 0x0000667e0000667eULL, 0x0000667e0000667eULL, },
+        { 0x05b09401e38e82f0ULL, 0xf49f71df05b09401ULL, },
+        { 0x0000001800000018ULL, 0x0000001800000018ULL, },
+        { 0xffffe3a700008e52ULL, 0x000038fdffffe3a7ULL, },    /*  48  */
+        { 0xffffe3a700008e52ULL, 0x000038fdffffe3a7ULL, },
+        { 0xf684d0b12f6997ceULL, 0x12f75eebf684d0b1ULL, },
+        { 0xffffc73600011c8cULL, 0x000071e2ffffc736ULL, },
+        { 0xfa4f7d421c738e54ULL, 0x0b619f66fa4f7d42ULL, },
+        { 0xffffaac50001aac6ULL, 0x0000aac7ffffaac5ULL, },
+        { 0x0fcce6d235bcf9caULL, 0x3f36f0500fcce6d2ULL, },
+        { 0xffff8e5400023900ULL, 0x0000e3acffff8e54ULL, },
+        { 0xffffaac70001aac8ULL, 0x0000aac9ffffaac7ULL, },    /*  56  */
+        { 0xffffaac70001aac8ULL, 0x0000aac9ffffaac7ULL, },
+        { 0x097b6869d0994bf8ULL, 0xed0a2f87097b6869ULL, },
+        { 0xffffc73a00011c90ULL, 0x000071e6ffffc73aULL, },
+        { 0x05b07796e38f1130ULL, 0xf49faaca05b07796ULL, },
+        { 0xffffe3ad00008e58ULL, 0x00003903ffffe3adULL, },
+        { 0xf0328b2fca45cd8eULL, 0xc0ca2c5ff0328b2fULL, },
+        { 0x0000002000000020ULL, 0x0000002000000020ULL, },
+        { 0x3a57fe9422c255a4ULL, 0x16b6ba1518facfc9ULL, },    /*  64  */
+        { 0x3c4b6c241c0669eaULL, 0x193d8a02feefaadeULL, },
+        { 0x6b6084e0ea284328ULL, 0x2271e08cf3dc0f77ULL, },
+        { 0x34b7f0f2ef20736aULL, 0xfb8f1ed3fd8c7dadULL, },
+        { 0x36ab5e82e86487b0ULL, 0xfe15eec0e38158c2ULL, },
+        { 0x36bda5cf0c93ba59ULL, 0x120897b5002b2653ULL, },
+        { 0x38025a59113b8b36ULL, 0x2453b4030525b498ULL, },
+        { 0x362cc9c2346212c9ULL, 0x3bf2477af46d1b56ULL, },
+        { 0x6541e27e0283ec07ULL, 0x45269e04e9597fefULL, },    /*  72  */
+        { 0x66869708072bbce4ULL, 0x5771ba52ee540e34ULL, },
+        { 0x9bb32f904f6ed245ULL, 0x6a56b2930fcf50fdULL, },
+        { 0x6feae478431ee5e4ULL, 0x731e8c13284ca993ULL, },
+        { 0x3942508a48171626ULL, 0x4c3bca5a31fd17c9ULL, },
+        { 0x376cbff36b3d9db9ULL, 0x63da5dd121447e87ULL, },
+        { 0x0ba474db5eedb158ULL, 0x6ca2375139c1d71dULL, },
+        { 0x3edb00658507867dULL, 0xd6e9ca725a84f021ULL, },
+        { 0x21746d8f492aab6bULL, 0xc86ec10d5ef05719ULL, },    /*  80  */
+        { 0x21105bf47228d8e1ULL, 0xd541f981830d22c5ULL, },
+        { 0xf90ba39c64a9aab9ULL, 0xd00d1cd8b17e0558ULL, },
+        { 0xedf1ebed93975370ULL, 0xd7fd3855cb7afcd4ULL, },
+        { 0xf85b68939e46773eULL, 0xceb49456ccc86662ULL, },
+        { 0xf8a465f666205360ULL, 0xe8078ebee9b86012ULL, },
+        { 0xdaa6e8fa242ed740ULL, 0xfd8488e8ff04a562ULL, },
+        { 0xc84291663638bd8eULL, 0x360ea9ec09bfe9aaULL, },
+        { 0xed300e0228a5c87eULL, 0x42280c3610aaee67ULL, },    /*  88  */
+        { 0xed8592684150f62dULL, 0x43c5604a0c58a5a1ULL, },
+        { 0x1661583a33e11b5dULL, 0x38e0b738fb2ab5fdULL, },
+        { 0x27e2359b43cb17c4ULL, 0x4169f958054c48f1ULL, },
+        { 0x0ff9c2b35666c87aULL, 0x546263e7ee7c57c1ULL, },
+        { 0x0f9e0bba7cf02cdcULL, 0x3fbf94eb097a6841ULL, },
+        { 0x06c9e6ca464484ecULL, 0x61838f28157007d3ULL, },
+        { 0x0791b5936e65c7d8ULL, 0x6a978c3b0d46a893ULL, },
+        { 0x0b5ca2c16d1c8082ULL, 0x84d8b2a628807419ULL, },    /*  96  */
+        { 0x0f3c4ea553ddefbaULL, 0x5d23288204008ac5ULL, },
+        { 0x006066f95bad42d4ULL, 0x7a5e585328976801ULL, },
+        { 0xf610532580647c0eULL, 0xa2551d9f07de4a9aULL, },
+        { 0xf65aca543e1e0beaULL, 0x936bdec820b433d4ULL, },
+        { 0xf66f1d9c4e4a0274ULL, 0x945159553437f0d0ULL, },
+        { 0xf6a34c5265777892ULL, 0x744c4f1e33a0fa19ULL, },
+        { 0xf6e8ae026961c977ULL, 0x679ecf7e36000115ULL, },
+        { 0x13ee44e6654e7066ULL, 0x828c7150244331b9ULL, },    /* 104  */
+        { 0xf787434e16614d78ULL, 0x55caaa201f72a96eULL, },
+        { 0xe4e9b290ecfd62e7ULL, 0x76440870087d3a2cULL, },
+        { 0x065e2c1ac531b8faULL, 0x86cb35600e1a0d9bULL, },
+        { 0x0d00c2eeb7cb8587ULL, 0xa3f3f27b07c3312fULL, },
+        { 0x0d62db84ab6f1a84ULL, 0xd3421106ff7d27d5ULL, },
+        { 0x10143b76893e48fbULL, 0xdf44d938fb177a2fULL, },
+        { 0x1c4ff82055152453ULL, 0xffe7837ceebc407dULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_W(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_W(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_W__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_S_W__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
new file mode 100644
index 0000000..106dc73
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPADD_U.D
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPADD_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffffffc00000002ULL, 0xfffffffc00000002ULL, },    /*   0  */
+        { 0xfffffffc00000002ULL, 0xfffffffc00000002ULL, },
+        { 0x5555554eaaaaaaaeULL, 0x5555554eaaaaaaaeULL, },
+        { 0xfffffff800000004ULL, 0xfffffff800000004ULL, },
+        { 0x9999998e6666666cULL, 0x9999998e6666666cULL, },
+        { 0xfffffff400000006ULL, 0xfffffff400000006ULL, },
+        { 0x71c71c638e38e395ULL, 0x1c71c70de38e38ebULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },    /*   8  */
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0xfffffff000000008ULL, 0xfffffff000000008ULL, },
+        { 0x55555542aaaaaab4ULL, 0x55555542aaaaaab4ULL, },    /*  16  */
+        { 0x55555542aaaaaab4ULL, 0x55555542aaaaaab4ULL, },
+        { 0x38e38e2471c71c7cULL, 0x38e38e2471c71c7cULL, },
+        { 0xaaaaaa9555555560ULL, 0xaaaaaa9555555560ULL, },
+        { 0xbbbbbba444444450ULL, 0xbbbbbba444444450ULL, },
+        { 0xffffffe80000000cULL, 0xffffffe80000000cULL, },
+        { 0xf684bd87b425ed16ULL, 0xbda12f4e97b425faULL, },
+        { 0x5555553aaaaaaab8ULL, 0x5555553aaaaaaab8ULL, },
+        { 0xffffffe40000000eULL, 0xffffffe40000000eULL, },    /*  24  */
+        { 0xffffffe40000000eULL, 0xffffffe40000000eULL, },
+        { 0x71c71c54e38e38f2ULL, 0x71c71c54e38e38f2ULL, },
+        { 0xaaaaaa8d55555564ULL, 0xaaaaaa8d55555564ULL, },
+        { 0x33333314ccccccdcULL, 0x33333314ccccccdcULL, },
+        { 0x55555536aaaaaabaULL, 0x55555536aaaaaabaULL, },
+        { 0xd097b40684bda13fULL, 0xb425ece9f684bdb1ULL, },
+        { 0xffffffe000000010ULL, 0xffffffe000000010ULL, },
+        { 0x9999997666666678ULL, 0x9999997666666678ULL, },    /*  32  */
+        { 0x9999997666666678ULL, 0x9999997666666678ULL, },
+        { 0xaaaaaa8555555568ULL, 0xaaaaaa8555555568ULL, },
+        { 0x3333330ccccccce0ULL, 0x3333330ccccccce0ULL, },
+        { 0x7ae147851eb85200ULL, 0x7ae147851eb85200ULL, },
+        { 0xcccccca333333348ULL, 0xcccccca333333348ULL, },
+        { 0xf49f49c93e93e954ULL, 0xb05b0584b60b60ccULL, },
+        { 0x66666639999999b0ULL, 0x66666639999999b0ULL, },
+        { 0xcccccc9f3333334aULL, 0xcccccc9f3333334aULL, },    /*  40  */
+        { 0xcccccc9f3333334aULL, 0xcccccc9f3333334aULL, },
+        { 0x111110e2eeeeef06ULL, 0x111110e2eeeeef06ULL, },
+        { 0x33333304cccccce4ULL, 0x33333304cccccce4ULL, },
+        { 0x851eb822e147ae2cULL, 0x851eb822e147ae2cULL, },
+        { 0x9999996a6666667eULL, 0x9999996a6666667eULL, },
+        { 0xe38e38b3e93e9401ULL, 0xd27d27a2c71c71dfULL, },
+        { 0xffffffd000000018ULL, 0xffffffd000000018ULL, },
+        { 0x71c71c3f8e38e3a7ULL, 0x1c71c6e9e38e38fdULL, },    /*  48  */
+        { 0x71c71c3f8e38e3a7ULL, 0x1c71c6e9e38e38fdULL, },
+        { 0x684bd9df425ed0b1ULL, 0xda12f6507b425eebULL, },
+        { 0xe38e38af1c71c736ULL, 0x38e38e03c71c71e2ULL, },
+        { 0x0b60b5d527d27d42ULL, 0x1c71c6e549f49f66ULL, },
+        { 0x5555551eaaaaaac5ULL, 0x5555551daaaaaac7ULL, },
+        { 0x6e9e061a4587e6d2ULL, 0x2c3f35816b74f050ULL, },
+        { 0xc71c718e38e38e54ULL, 0x71c71c378e38e3acULL, },
+        { 0x5555551aaaaaaac7ULL, 0x55555519aaaaaac9ULL, },    /*  56  */
+        { 0x5555551aaaaaaac7ULL, 0x55555519aaaaaac9ULL, },
+        { 0xb425eccda12f6869ULL, 0xed097b05bda12f87ULL, },
+        { 0xe38e38a71c71c73aULL, 0x38e38dfbc71c71e6ULL, },
+        { 0x5555551777777796ULL, 0xeeeeeeb0aaaaaacaULL, },
+        { 0x71c71c338e38e3adULL, 0x1c71c6dde38e3903ULL, },
+        { 0xca4587a781948b2fULL, 0x61f9ad9406522c5fULL, },
+        { 0xffffffc000000020ULL, 0xffffffc000000020ULL, },
+        { 0x4f10a2061266c2b0ULL, 0x132f36fdaebdb734ULL, },    /*  64  */
+        { 0xe173955d0a3d6d94ULL, 0x2de485b19f4dac90ULL, },
+        { 0x5a9b88364205b90cULL, 0xe3c89435af2c3022ULL, },
+        { 0xa5506be1e16f25e8ULL, 0xb5d99e2c137656f2ULL, },
+        { 0x37b35f38d945d0ccULL, 0xd08eece004064c4eULL, },
+        { 0x46c3bc088c276755ULL, 0xd3ba26318bdfb302ULL, },
+        { 0x288f407241d1cf13ULL, 0xe4e2d49bf38e1598ULL, },
+        { 0xb38b871fddd1234aULL, 0xfd7386eef5421908ULL, },
+        { 0x2cb379f915996ec2ULL, 0xb357957305209c9aULL, },    /*  72  */
+        { 0x0e7efe62cb43d680ULL, 0xc48043dd6cceff30ULL, },
+        { 0x0966991866fb9f64ULL, 0x3d26b2ddb9e53ac1ULL, },
+        { 0x9961eeb6d99e4586ULL, 0xc46ae4f9206e6e69ULL, },
+        { 0xe416d2627907b262ULL, 0x967beeef84b89539ULL, },
+        { 0x6f13191015070699ULL, 0xaf0ca142866c98a9ULL, },
+        { 0xff0e6eae87a9acbbULL, 0x3650d35decf5cc51ULL, },
+        { 0x52fc668a5f0acfa8ULL, 0xf4ee28afafeae691ULL, },
+        { 0x8e335693216733a0ULL, 0xebf294e7e1b7da9fULL, },    /*  80  */
+        { 0x242889888a96ab79ULL, 0x1029e138e123d999ULL, },
+        { 0xa117d2200713df49ULL, 0xa936d669733f9d55ULL, },
+        { 0xea5eaf7c9d524d27ULL, 0x533cccdee6d6ad0dULL, },
+        { 0x8014252a44e6c8b7ULL, 0x5139a5a2ff917d2dULL, },
+        { 0x12e82535692eaeadULL, 0x6c74742f3b1a47edULL, },
+        { 0x6bfad303a455af5fULL, 0xa4da8c7753e03c42ULL, },
+        { 0xd7d1673544f2b638ULL, 0x37b76789ca48e5eaULL, },
+        { 0x55b32da89b1ab874ULL, 0x1136a063291c7430ULL, },    /*  88  */
+        { 0xd8fa08f2c6e9500cULL, 0x15e6a0cfa25fce7eULL, },
+        { 0xfb6ec0cb14ee46c0ULL, 0x85e0ab776ca06e87ULL, },
+        { 0x7170744f4e43c44fULL, 0x17ee0476d6f5954fULL, },
+        { 0xba3c379c6c72bc03ULL, 0xf4a9e78f41249a57ULL, },
+        { 0x923c97db1bf9726fULL, 0x0c32ba5fa7655f81ULL, },
+        { 0x08ff0c9a1b07a05dULL, 0x7e05b61db39e9936ULL, },
+        { 0x16e37ad7ce0b9d05ULL, 0x3aa86333e7ca176eULL, },
+        { 0x4396d885c2a89499ULL, 0x3259d55cbbd56e50ULL, },    /*  96  */
+        { 0x86505184e2848fd5ULL, 0xfbe6ef6acb48e5d8ULL, },
+        { 0xf19ecbd2f0d9cb45ULL, 0x102d8886fc3ba2e4ULL, },
+        { 0x985e99073ad19cddULL, 0x0fae6c4a600fe8c8ULL, },
+        { 0x40076fc7eafc7c7aULL, 0x18d0edce69b82b2cULL, },
+        { 0xc633d71b8943703fULL, 0x236de461c55a6368ULL, },
+        { 0xb2b44afd6be31aa8ULL, 0x366f22bc07569aa2ULL, },
+        { 0x832148e5fdab87bfULL, 0x3b138b90c7099132ULL, },
+        { 0x9388b611f0bd2a51ULL, 0xc95a7ba92714878aULL, },    /* 104  */
+        { 0xa598b2d7184dc31bULL, 0x02d31201c0d1f3a9ULL, },
+        { 0x26b9d9c7d27ede61ULL, 0x84305afc61d71edcULL, },
+        { 0xd994c5da2b819a07ULL, 0xda2ed7517c38dd10ULL, },
+        { 0x490b25198d55f4bbULL, 0xa54a7d332b34db68ULL, },
+        { 0x9d17b063519fea3aULL, 0x1d81a65b0c1f8770ULL, },
+        { 0x000b355286100badULL, 0x35e1e113d0b4c238ULL, },
+        { 0x316423fb99a16a0dULL, 0xddbffc10af9e9540ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_D(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_D(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_D__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_D__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
new file mode 100644
index 0000000..5fae97e
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPADD_U.H
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPADD_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfc02fc02fc02fc02ULL, 0xfc02fc02fc02fc02ULL, },    /*   0  */
+        { 0xfc02fc02fc02fc02ULL, 0xfc02fc02fc02fc02ULL, },
+        { 0x4eae4eae4eae4eaeULL, 0x4eae4eae4eae4eaeULL, },
+        { 0xf804f804f804f804ULL, 0xf804f804f804f804ULL, },
+        { 0x8e6c8e6c8e6c8e6cULL, 0x8e6c8e6c8e6c8e6cULL, },
+        { 0xf406f406f406f406ULL, 0xf406f406f406f406ULL, },
+        { 0x63950debb9406395ULL, 0x0debb94063950debULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },    /*   8  */
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0xf008f008f008f008ULL, 0xf008f008f008f008ULL, },
+        { 0x42b442b442b442b4ULL, 0x42b442b442b442b4ULL, },    /*  16  */
+        { 0x42b442b442b442b4ULL, 0x42b442b442b442b4ULL, },
+        { 0x247c247c247c247cULL, 0x247c247c247c247cULL, },
+        { 0x9560956095609560ULL, 0x9560956095609560ULL, },
+        { 0xa450a450a450a450ULL, 0xa450a450a450a450ULL, },
+        { 0xe80ce80ce80ce80cULL, 0xe80ce80ce80ce80cULL, },
+        { 0xdd16a3fa6b88dd16ULL, 0xa3fa6b88dd16a3faULL, },
+        { 0x3ab83ab83ab83ab8ULL, 0x3ab83ab83ab83ab8ULL, },
+        { 0xe40ee40ee40ee40eULL, 0xe40ee40ee40ee40eULL, },    /*  24  */
+        { 0xe40ee40ee40ee40eULL, 0xe40ee40ee40ee40eULL, },
+        { 0x54f254f254f254f2ULL, 0x54f254f254f254f2ULL, },
+        { 0x8d648d648d648d64ULL, 0x8d648d648d648d64ULL, },
+        { 0x14dc14dc14dc14dcULL, 0x14dc14dc14dc14dcULL, },
+        { 0x36ba36ba36ba36baULL, 0x36ba36ba36ba36baULL, },
+        { 0xb13f94b17878b13fULL, 0x94b17878b13f94b1ULL, },
+        { 0xe010e010e010e010ULL, 0xe010e010e010e010ULL, },
+        { 0x7678767876787678ULL, 0x7678767876787678ULL, },    /*  32  */
+        { 0x7678767876787678ULL, 0x7678767876787678ULL, },
+        { 0x8568856885688568ULL, 0x8568856885688568ULL, },
+        { 0x0ce00ce00ce00ce0ULL, 0x0ce00ce00ce00ce0ULL, },
+        { 0x5200520052005200ULL, 0x5200520052005200ULL, },
+        { 0xa348a348a348a348ULL, 0xa348a348a348a348ULL, },
+        { 0xc95484cc4110c954ULL, 0x84cc4110c95484ccULL, },
+        { 0x39b039b039b039b0ULL, 0x39b039b039b039b0ULL, },
+        { 0x9f4a9f4a9f4a9f4aULL, 0x9f4a9f4a9f4a9f4aULL, },    /*  40  */
+        { 0x9f4a9f4a9f4a9f4aULL, 0x9f4a9f4a9f4a9f4aULL, },
+        { 0xe306e306e306e306ULL, 0xe306e306e306e306ULL, },
+        { 0x04e404e404e404e4ULL, 0x04e404e404e404e4ULL, },
+        { 0x562c562c562c562cULL, 0x562c562c562c562cULL, },
+        { 0x6a7e6a7e6a7e6a7eULL, 0x6a7e6a7e6a7e6a7eULL, },
+        { 0xb401a2df91f0b401ULL, 0xa2df91f0b401a2dfULL, },
+        { 0xd018d018d018d018ULL, 0xd018d018d018d018ULL, },
+        { 0x3fa7e9fd95523fa7ULL, 0xe9fd95523fa7e9fdULL, },    /*  48  */
+        { 0x3fa7e9fd95523fa7ULL, 0xe9fd95523fa7e9fdULL, },
+        { 0x34b1a5eb18ce34b1ULL, 0xa5eb18ce34b1a5ebULL, },
+        { 0xaf3603e25a8caf36ULL, 0x03e25a8caf3603e2ULL, },
+        { 0xd542e566f854d542ULL, 0xe566f854d542e566ULL, },
+        { 0x1ec51dc71fc61ec5ULL, 0x1dc71fc61ec51dc7ULL, },
+        { 0x36d2f3507aca36d2ULL, 0xf3507aca36d2f350ULL, },
+        { 0x8e5437ace5008e54ULL, 0x37ace5008e5437acULL, },
+        { 0x1ac719c91bc81ac7ULL, 0x19c91bc81ac719c9ULL, },    /*  56  */
+        { 0x1ac719c91bc81ac7ULL, 0x19c91bc81ac719c9ULL, },
+        { 0x7869b087eaf87869ULL, 0xb087eaf87869b087ULL, },
+        { 0xa73afbe65290a73aULL, 0xfbe65290a73afbe6ULL, },
+        { 0x1796b0ca4b301796ULL, 0xb0ca4b301796b0caULL, },
+        { 0x33adde03895833adULL, 0xde03895833adde03ULL, },
+        { 0x8b2f225ff38e8b2fULL, 0x225ff38e8b2f225fULL, },
+        { 0xc020c020c020c020ULL, 0xc020c020c020c020ULL, },
+        { 0x34443154ebe4ec59ULL, 0xff8ae31df73d39b0ULL, },    /*  64  */
+        { 0x084880383032306cULL, 0x6831f4b22a587de0ULL, },
+        { 0x88eca4049c587e93ULL, 0xca865ad6e8ab9840ULL, },
+        { 0xe522f524bdcadd1dULL, 0x54ccaffeb00f3b20ULL, },
+        { 0xb926440802182130ULL, 0xbd73c193e32a7f50ULL, },
+        { 0x3c436a516daabc21ULL, 0xad084cd0f46491a4ULL, },
+        { 0x27b3ac0f1c2c2c2eULL, 0x802ef7580d00b12eULL, },
+        { 0xd025c9d65495de4cULL, 0x729f70a02b1b9712ULL, },
+        { 0x50c9eda2c0bb2c73ULL, 0xd4f4d6c4e96eb172ULL, },    /*  72  */
+        { 0x3c392f606f3d9c80ULL, 0xa81a814c020ad0fcULL, },
+        { 0xcf6d16889c4f27f9ULL, 0x644b18717b7cd7e5ULL, },
+        { 0x3673589e07dcc9afULL, 0x451e58c9f775050fULL, },
+        { 0x92a9a9be294e2839ULL, 0xcf64adf1bed9a7efULL, },
+        { 0x3b1bc78561b7da57ULL, 0xc1d52739dcf48dd3ULL, },
+        { 0xa221099bcd447c0dULL, 0xa2a8679158edbafdULL, },
+        { 0xeb8222a8f9295b55ULL, 0xd3326611d982e681ULL, },
+        { 0x9e2ec7142fc38eccULL, 0x252170b1ef468aadULL, },    /*  80  */
+        { 0x5b3cced0addf038eULL, 0x4792d47b141b612dULL, },
+        { 0xad78e4f4df354c2fULL, 0xcd93f2f8260072b6ULL, },
+        { 0x1e3041f03b3c9d99ULL, 0xc8df44c83f16491aULL, },
+        { 0x42003b965b6cf7faULL, 0x5d309124882a7c82ULL, },
+        { 0x82b67598b4cfbfcbULL, 0x920afeb79da82432ULL, },
+        { 0x1a0a2a0ede448d00ULL, 0xb0b8797422bf2d4eULL, },
+        { 0x288031e03ccc097aULL, 0xbee01b9c6a6f85c8ULL, },
+        { 0x72c0106694442af7ULL, 0x50aa560d08f0ea98ULL, },    /*  88  */
+        { 0x710637d8e7d45355ULL, 0xfa50963144a8cb2cULL, },
+        { 0xbf0eecaa3a2faae6ULL, 0x63e63b048e4cebf3ULL, },
+        { 0x16f03414587a870eULL, 0x72f35dbcffa25349ULL, },
+        { 0x860072bc94eeb761ULL, 0xf61ea6c34a7a8fc5ULL, },
+        { 0x0962bb704a1c48aaULL, 0x245c33d36e927f7fULL, },
+        { 0x31e284ea963ac4c2ULL, 0x77782d72d0929bc6ULL, },
+        { 0x8d10d6a4d868ace6ULL, 0x29fba58a7f86a05cULL, },
+        { 0xde98199821f81f82ULL, 0x9afbdf4d3dea12acULL, },    /*  96  */
+        { 0x9378a92e86104a4dULL, 0x2d160528eade271cULL, },
+        { 0x134065aca120761fULL, 0x431f140f3db4433cULL, },
+        { 0x37d8497ac688a50dULL, 0x63391a6dd0b6741cULL, },
+        { 0x0e1578a8502e25b8ULL, 0xa12e387d0e90b4d4ULL, },
+        { 0x2b65b9a082a8483bULL, 0xd8e26e173326bf2cULL, },
+        { 0xa084f7800a3a820bULL, 0xc220c0c740af27aaULL, },
+        { 0x9f5c29002e8ae771ULL, 0xeea4613d7100db80ULL, },
+        { 0x2a8844debf5e9d5eULL, 0x9d46e906bc7b0527ULL, },    /* 104  */
+        { 0x769006829567219dULL, 0xf041a3364eb808ecULL, },
+        { 0xf87860ea545d8208ULL, 0x4ba95712a1ba1c84ULL, },
+        { 0xc9483d8edc44cc9eULL, 0xe5aeac4a2c832ae0ULL, },
+        { 0x37706d823a10b0daULL, 0x079d461a6b55dbf4ULL, },
+        { 0x72109dfa526c8ea6ULL, 0x9f45813ac7e235caULL, },
+        { 0xa8e0f6aa85343e96ULL, 0x37cdf6b28585e2d4ULL, },
+        { 0x37803ef0bffea306ULL, 0x17150f92ff9c2ed8ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_H(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_H(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_H__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_H__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
new file mode 100644
index 0000000..2bea9f6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPADD_U.W
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPADD_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffc0002fffc0002ULL, 0xfffc0002fffc0002ULL, },    /*   0  */
+        { 0xfffc0002fffc0002ULL, 0xfffc0002fffc0002ULL, },
+        { 0x554eaaae554eaaaeULL, 0x554eaaae554eaaaeULL, },
+        { 0xfff80004fff80004ULL, 0xfff80004fff80004ULL, },
+        { 0x998e666c998e666cULL, 0x998e666c998e666cULL, },
+        { 0xfff40006fff40006ULL, 0xfff40006fff40006ULL, },
+        { 0x1c63e39571b88e40ULL, 0xc70e38eb1c63e395ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },    /*   8  */
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0xfff00008fff00008ULL, 0xfff00008fff00008ULL, },
+        { 0x5542aab45542aab4ULL, 0x5542aab45542aab4ULL, },    /*  16  */
+        { 0x5542aab45542aab4ULL, 0x5542aab45542aab4ULL, },
+        { 0x38cf1c7c38cf1c7cULL, 0x38cf1c7c38cf1c7cULL, },
+        { 0xaa955560aa955560ULL, 0xaa955560aa955560ULL, },
+        { 0xbba44450bba44450ULL, 0xbba44450bba44450ULL, },
+        { 0xffe8000cffe8000cULL, 0xffe8000cffe8000cULL, },
+        { 0xbd87ed16f66b0988ULL, 0x84a425fabd87ed16ULL, },
+        { 0x553aaab8553aaab8ULL, 0x553aaab8553aaab8ULL, },
+        { 0xffe4000effe4000eULL, 0xffe4000effe4000eULL, },    /*  24  */
+        { 0xffe4000effe4000eULL, 0xffe4000effe4000eULL, },
+        { 0x71aa38f271aa38f2ULL, 0x71aa38f271aa38f2ULL, },
+        { 0xaa8d5564aa8d5564ULL, 0xaa8d5564aa8d5564ULL, },
+        { 0x3314ccdc3314ccdcULL, 0x3314ccdc3314ccdcULL, },
+        { 0x5536aaba5536aabaULL, 0x5536aaba5536aabaULL, },
+        { 0xb406a13fd0782f78ULL, 0x9794bdb1b406a13fULL, },
+        { 0xffe00010ffe00010ULL, 0xffe00010ffe00010ULL, },
+        { 0x9976667899766678ULL, 0x9976667899766678ULL, },    /*  32  */
+        { 0x9976667899766678ULL, 0x9976667899766678ULL, },
+        { 0xaa855568aa855568ULL, 0xaa855568aa855568ULL, },
+        { 0x330ccce0330ccce0ULL, 0x330ccce0330ccce0ULL, },
+        { 0x7ab852007ab85200ULL, 0x7ab852007ab85200ULL, },
+        { 0xcca33348cca33348ULL, 0xcca33348cca33348ULL, },
+        { 0xb02fe954f473a510ULL, 0x6beb60ccb02fe954ULL, },
+        { 0x663999b0663999b0ULL, 0x663999b0663999b0ULL, },
+        { 0xcc9f334acc9f334aULL, 0xcc9f334acc9f334aULL, },    /*  40  */
+        { 0xcc9f334acc9f334aULL, 0xcc9f334acc9f334aULL, },
+        { 0x10e2ef0610e2ef06ULL, 0x10e2ef0610e2ef06ULL, },
+        { 0x3304cce43304cce4ULL, 0x3304cce43304cce4ULL, },
+        { 0x84efae2c84efae2cULL, 0x84efae2c84efae2cULL, },
+        { 0x996a667e996a667eULL, 0x996a667e996a667eULL, },
+        { 0xd24d9401e35e82f0ULL, 0xc13c71dfd24d9401ULL, },
+        { 0xffd00018ffd00018ULL, 0xffd00018ffd00018ULL, },
+        { 0x1c3fe3a771948e52ULL, 0xc6ea38fd1c3fe3a7ULL, },    /*  48  */
+        { 0x1c3fe3a771948e52ULL, 0xc6ea38fd1c3fe3a7ULL, },
+        { 0xd9dfd0b1681797ceULL, 0x4ba65eebd9dfd0b1ULL, },
+        { 0x38afc736e3591c8cULL, 0x8e0471e238afc736ULL, },
+        { 0x1c3c7d420b298e54ULL, 0x2d4c9f661c3c7d42ULL, },
+        { 0x551faac5551daac6ULL, 0x551eaac7551faac5ULL, },
+        { 0x2c08e6d26e64f9caULL, 0xb0c4f0502c08e6d2ULL, },
+        { 0x718f8e54c6e23900ULL, 0x1c38e3ac718f8e54ULL, },
+        { 0x551baac75519aac8ULL, 0x551aaac9551baac7ULL, },    /*  56  */
+        { 0x551baac75519aac8ULL, 0x551aaac9551baac7ULL, },
+        { 0xecce6869b3e94bf8ULL, 0x25b12f87ecce6869ULL, },
+        { 0x38a7c73ae3511c90ULL, 0x8dfc71e638a7c73aULL, },
+        { 0xeeb1779655171130ULL, 0x884aaacaeeb17796ULL, },
+        { 0x1c33e3ad71888e58ULL, 0xc6de39031c33e3adULL, },
+        { 0x61ba8b2fca05cd8eULL, 0x32522c5f61ba8b2fULL, },
+        { 0xffc00020ffc00020ULL, 0xffc00020ffc00020ULL, },
+        { 0x1883fe94228255a4ULL, 0x1676ba1575c8cfc9ULL, },    /*  64  */
+        { 0x9f026c24710669eaULL, 0x245b8a02c3f8aadeULL, },
+        { 0x985184e0bcca4328ULL, 0x38ede08c879f0f77ULL, },
+        { 0xe844f0f21702736aULL, 0x68d01ed3cbb87dadULL, },
+        { 0x6ec35e82658687b0ULL, 0x76b4eec019e858c2ULL, },
+        { 0x6651a5cf17c5ba59ULL, 0x00db97b536922653ULL, },
+        { 0x10115a59bc888b36ULL, 0x953fb40350cbb498ULL, },
+        { 0x7e8ac9c2890512c9ULL, 0x03c7477aa84e1b56ULL, },
+        { 0x77d9e27ed4c8ec07ULL, 0x18599e046bf47fefULL, },    /*  72  */
+        { 0x21999708798bbce4ULL, 0xacbdba52862e0e34ULL, },
+        { 0x0cce2f904c6cd245ULL, 0x4da0b293fdff50fdULL, },
+        { 0x67a1e4780c1be5e4ULL, 0xce178c138ffda993ULL, },
+        { 0xb795508a66541626ULL, 0xfdf9ca5ad41717c9ULL, },
+        { 0x260ebff332d09db9ULL, 0x6c815dd12b997e87ULL, },
+        { 0x80e274dbf27fb158ULL, 0xecf83751bd97d71dULL, },
+        { 0xb4190065dd35867dULL, 0x84d1ca72f61ef021ULL, },
+        { 0x146be93b2ce39d07ULL, 0xb4edb1658fe8e617ULL, },    /*  80  */
+        { 0x28da2b76b4930398ULL, 0x43fbb752e67034d3ULL, },
+        { 0x6202107639989575ULL, 0xdd1056c8882a591fULL, },
+        { 0x8e704692d2e83f33ULL, 0x8605bb9831163f53ULL, },
+        { 0x19f6294a0938f7c3ULL, 0xb5d3886b8d6db0c9ULL, },
+        { 0x338d977ccca46e03ULL, 0x26ffd0ded278d778ULL, },
+        { 0xbd9d53669d1f0d1fULL, 0xcf6d52287e678700ULL, },
+        { 0x18106087e287df80ULL, 0x6e5a3285497c7c8eULL, },
+        { 0x7be90cbb50b10f2eULL, 0x91193a91e83049caULL, },    /*  88  */
+        { 0xf5c762fa74f1dd41ULL, 0xc6a6d96a1360b472ULL, },
+        { 0xdec724f4426380a0ULL, 0x8e924c103a77a87aULL, },
+        { 0x43bb09c1cc850053ULL, 0x06479b02f6444a68ULL, },
+        { 0x709d98fbece3b6fdULL, 0x0f02ef4f1e3d11f4ULL, },
+        { 0xdf964592c2f0673eULL, 0xbf06914326915827ULL, },
+        { 0xa595174288afc04eULL, 0x4dac2c104d1f338eULL, },
+        { 0xf0400b1764f99f91ULL, 0x904ab47cadc0214cULL, },
+        { 0x7a4505ebaa0a3823ULL, 0xc2ce09ca715dec1cULL, },    /*  96  */
+        { 0xc0c227c1d78e87b7ULL, 0xfc9e0ad8846cfb1bULL, },
+        { 0x4b501be126c0ecd3ULL, 0x47813bbab4be1843ULL, },
+        { 0x8c94284d7bbb0613ULL, 0x5f37b7ed7918a6b1ULL, },
+        { 0x16e12feca5f2470cULL, 0xecb24110b92e33d5ULL, },
+        { 0x2d734e2e0f77e762ULL, 0x2dc8706ed959cbd3ULL, },
+        { 0x5a430652c80bfcc7ULL, 0x835871922d75cf6eULL, },
+        { 0xb30826c2c930c150ULL, 0xe0148a4e74790481ULL, },
+        { 0x46021066c48e3720ULL, 0x6e76bee0c30066e8ULL, },    /* 104  */
+        { 0x80543cd67141b3f2ULL, 0x14074d905449ba08ULL, },
+        { 0x003ba47a25839f81ULL, 0x536fe6e8a79655ebULL, },
+        { 0x709b823c97a86aeeULL, 0x13e9a6a824155b79ULL, },
+        { 0xad5a661d2dfbd29aULL, 0x780997c18cea8383ULL, },
+        { 0x024c799cf912e891ULL, 0x0bb620125e8129b7ULL, },
+        { 0x0de66afc224e0f31ULL, 0x23590398c1ea5059ULL, },
+        { 0x1d512ac23c5b270dULL, 0x38de17a18940924dULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_W(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_W(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_W__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPADD_U_W__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
new file mode 100644
index 0000000..560e29a
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPSUB_S.D
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPSUB_S.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },    /*   0  */
+        { 0xfffffffffffffffeULL, 0xfffffffffffffffeULL, },
+        { 0xffffffff55555552ULL, 0xffffffff55555552ULL, },
+        { 0xfffffffffffffffcULL, 0xfffffffffffffffcULL, },
+        { 0xffffffff99999994ULL, 0xffffffff99999994ULL, },
+        { 0xfffffffffffffffaULL, 0xfffffffffffffffaULL, },
+        { 0xffffffff71c71c6bULL, 0x000000001c71c715ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },    /*   8  */
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xfffffffffffffff8ULL, 0xfffffffffffffff8ULL, },
+        { 0xffffffff5555554cULL, 0xffffffff5555554cULL, },    /*  16  */
+        { 0xffffffff5555554cULL, 0xffffffff5555554cULL, },
+        { 0xc71c71c58e38e384ULL, 0xc71c71c58e38e384ULL, },
+        { 0xfffffffeaaaaaaa0ULL, 0xfffffffeaaaaaaa0ULL, },
+        { 0xdddddddbbbbbbbb0ULL, 0xdddddddbbbbbbbb0ULL, },
+        { 0xfffffffdfffffff4ULL, 0xfffffffdfffffff4ULL, },
+        { 0xd097b4234bda12eaULL, 0x097b425c684bda06ULL, },
+        { 0xfffffffd55555548ULL, 0xfffffffd55555548ULL, },
+        { 0xfffffffdfffffff2ULL, 0xfffffffdfffffff2ULL, },    /*  24  */
+        { 0xfffffffdfffffff2ULL, 0xfffffffdfffffff2ULL, },
+        { 0x38e38e371c71c70eULL, 0x38e38e371c71c70eULL, },
+        { 0xfffffffeaaaaaa9cULL, 0xfffffffeaaaaaa9cULL, },
+        { 0x2222222133333324ULL, 0x2222222133333324ULL, },
+        { 0xffffffff55555546ULL, 0xffffffff55555546ULL, },
+        { 0x2f684bd97b425ec1ULL, 0xf684bda1097b424fULL, },
+        { 0xfffffffffffffff0ULL, 0xfffffffffffffff0ULL, },
+        { 0xffffffff99999988ULL, 0xffffffff99999988ULL, },    /*  32  */
+        { 0xffffffff99999988ULL, 0xffffffff99999988ULL, },
+        { 0xdddddddcaaaaaa98ULL, 0xdddddddcaaaaaa98ULL, },
+        { 0xffffffff33333320ULL, 0xffffffff33333320ULL, },
+        { 0xeb851eb6e147ae00ULL, 0xeb851eb6e147ae00ULL, },
+        { 0xfffffffeccccccb8ULL, 0xfffffffeccccccb8ULL, },
+        { 0xe38e38e1c16c16acULL, 0x05b05b0449f49f34ULL, },
+        { 0xfffffffe66666650ULL, 0xfffffffe66666650ULL, },
+        { 0xfffffffeccccccb6ULL, 0xfffffffeccccccb6ULL, },    /*  40  */
+        { 0xfffffffeccccccb6ULL, 0xfffffffeccccccb6ULL, },
+        { 0x22222221111110faULL, 0x22222221111110faULL, },
+        { 0xffffffff3333331cULL, 0xffffffff3333331cULL, },
+        { 0x147ae1471eb851d4ULL, 0x147ae1471eb851d4ULL, },
+        { 0xffffffff99999982ULL, 0xffffffff99999982ULL, },
+        { 0x1c71c71c16c16bffULL, 0xfa4fa4fa38e38e21ULL, },
+        { 0xffffffffffffffe8ULL, 0xffffffffffffffe8ULL, },
+        { 0xffffffff71c71c59ULL, 0x000000001c71c703ULL, },    /*  48  */
+        { 0xffffffff71c71c59ULL, 0x000000001c71c703ULL, },
+        { 0xd097b424bda12f4fULL, 0x097b425e84bda115ULL, },
+        { 0xfffffffee38e38caULL, 0x0000000038e38e1eULL, },
+        { 0xe38e38e1d82d82beULL, 0x05b05b05b60b609aULL, },
+        { 0xfffffffe5555553bULL, 0x0000000055555539ULL, },
+        { 0xca4587e4ba78192eULL, 0xf0329162948b0fb0ULL, },
+        { 0xfffffffdc71c71acULL, 0x0000000071c71c54ULL, },
+        { 0xfffffffe55555539ULL, 0x0000000055555537ULL, },    /*  56  */
+        { 0xfffffffe55555539ULL, 0x0000000055555537ULL, },
+        { 0x2f684bd85ed09797ULL, 0xf684bda1425ed079ULL, },
+        { 0xfffffffee38e38c6ULL, 0x0000000038e38e1aULL, },
+        { 0x1c71c71b8888886aULL, 0xfa4fa4fa55555536ULL, },
+        { 0xffffffff71c71c53ULL, 0x000000001c71c6fdULL, },
+        { 0x35ba78187e6b74d1ULL, 0x0fcd6e9df9add3a1ULL, },
+        { 0xffffffffffffffe0ULL, 0xffffffffffffffe0ULL, },
+        { 0xc1c52b51ed993d50ULL, 0xe9c828da514248ccULL, },    /*  64  */
+        { 0xb38b1f29f5c2926cULL, 0xe4522d2260b25370ULL, },
+        { 0x978b1706bdfa46f4ULL, 0xd814f3be50d3cfdeULL, },
+        { 0xbd2549a81e90da18ULL, 0xf92987d1ec89a90eULL, },
+        { 0xaeeb3d8026ba2f34ULL, 0xf3b38c19fbf9b3b2ULL, },
+        { 0x9756e17673d898abULL, 0xf08852c874204cfeULL, },
+        { 0xab37d321be2e30edULL, 0xf49ef75a0c71ea68ULL, },
+        { 0x908aa2c1222edcb6ULL, 0x0445531d0abde6f8ULL, },
+        { 0x748a9a9dea66913eULL, 0xf80819b8fadf6366ULL, },    /*  72  */
+        { 0x886b8c4934bc2980ULL, 0xfc1ebe4a933100d0ULL, },
+        { 0x59d865e79904609cULL, 0xd9ce9972461ac53fULL, },
+        { 0x985e08e42661ba7aULL, 0xced13609df919197ULL, },
+        { 0xbdf83b8586f84d9eULL, 0xefe5ca1d7b476ac7ULL, },
+        { 0xa34b0b24eaf8f967ULL, 0xff8c25e079936757ULL, },
+        { 0xe1d0ae2178565345ULL, 0xf48ec278130a33afULL, },
+        { 0x8de2b645a0f53058ULL, 0xa45a44165015196fULL, },
+        { 0x6792d4f3d7eea55cULL, 0xbfd22ee1a25aa627ULL, },    /*  80  */
+        { 0x75702d5b9af89c83ULL, 0xcc593d1da09f7be9ULL, },
+        { 0x801c3e1c97724195ULL, 0xb4c868d4067dd2d2ULL, },
+        { 0xdeafd0d6f0bea5c3ULL, 0x957877eb733b98b2ULL, },
+        { 0xd1883629f50ec77bULL, 0xb587d85cf1ffef10ULL, },
+        { 0xd4133b37d7cbfcc8ULL, 0xbc35d373b6f24df8ULL, },
+        { 0xbab344ed957a4c42ULL, 0xae8dcb499ce6cd0bULL, },
+        { 0x004c193eb947b2ddULL, 0x68b0a9907b71a293ULL, },
+        { 0x0b979b74995fc935ULL, 0x4a9602f12aa080cfULL, },    /*  88  */
+        { 0x2ae2653846d12eb1ULL, 0x4185939a2d850f91ULL, },
+        { 0x4c5017cc0eed7401ULL, 0x466840b4575dc0d7ULL, },
+        { 0x255760c7e1e38957ULL, 0x8360b1037a4f3497ULL, },
+        { 0x3b88c1c3a41f6803ULL, 0xa8cf0d07b592cd69ULL, },
+        { 0x585dd51272f3e482ULL, 0xb5723c3756218857ULL, },
+        { 0x94c1c43b5f5b538eULL, 0xdd9794c5786cc9c2ULL, },
+        { 0xa0b80278cc3c6a8bULL, 0xf710a53506ea3e4aULL, },
+        { 0x7c607ecd0201d92bULL, 0xf9bcdab0e105825cULL, },    /*  96  */
+        { 0xb628bad7d2470e0fULL, 0xfb660e974362496cULL, },
+        { 0x9ae11df599c281fbULL, 0xfd2738784b8dbfeaULL, },
+        { 0x7bc5bf3b5e23aeffULL, 0xfe707ab5676dfce2ULL, },
+        { 0x614dabb2dc4e0a36ULL, 0xf5f8795b76d8fd08ULL, },
+        { 0x6dbd1a209fc658b0ULL, 0xecd982bc128c8ceaULL, },
+        { 0x8cb93c5d61b1a8d0ULL, 0xecbaa1839f7e477aULL, },
+        { 0x6d33947e52d25a59ULL, 0xf62aab8428f0bf14ULL, },
+        { 0xa7970469e4259b2dULL, 0x0543881aad9efd08ULL, },    /* 104  */
+        { 0x8310e5e55f8149f3ULL, 0xe925758a04d06282ULL, },
+        { 0x746e208dd13c0f61ULL, 0xee4c7bccbccd15e4ULL, },
+        { 0x8da69743b598403fULL, 0xdac93db8514253e0ULL, },
+        { 0xdb31a0aea0a5cde6ULL, 0xe5bd105b853454a0ULL, },
+        { 0x0e6cfc3a89e7bd7cULL, 0xb06ea3bad3a90bd8ULL, },
+        { 0x338cc47438edb042ULL, 0x7df572596f6dffe8ULL, },
+        { 0x07fce3091840a942ULL, 0xdbd5224936527bd0ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_D(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_D(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_D__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_D__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
new file mode 100644
index 0000000..3fb88ab
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPSUB_S.H
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPSUB_S.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },    /*   0  */
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xff52ff52ff52ff52ULL, 0xff52ff52ff52ff52ULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xff94ff94ff94ff94ULL, 0xff94ff94ff94ff94ULL, },
+        { 0xfffafffafffafffaULL, 0xfffafffafffafffaULL, },
+        { 0xff6b0015ffc0ff6bULL, 0x0015ffc0ff6b0015ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },    /*   8  */
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xff4cff4cff4cff4cULL, 0xff4cff4cff4cff4cULL, },    /*  16  */
+        { 0xff4cff4cff4cff4cULL, 0xff4cff4cff4cff4cULL, },
+        { 0xc584c584c584c584ULL, 0xc584c584c584c584ULL, },
+        { 0xfea0fea0fea0fea0ULL, 0xfea0fea0fea0fea0ULL, },
+        { 0xdbb0dbb0dbb0dbb0ULL, 0xdbb0dbb0dbb0dbb0ULL, },
+        { 0xfdf4fdf4fdf4fdf4ULL, 0xfdf4fdf4fdf4fdf4ULL, },
+        { 0xcdea0706ea78cdeaULL, 0x0706ea78cdea0706ULL, },
+        { 0xfd48fd48fd48fd48ULL, 0xfd48fd48fd48fd48ULL, },
+        { 0xfdf2fdf2fdf2fdf2ULL, 0xfdf2fdf2fdf2fdf2ULL, },    /*  24  */
+        { 0xfdf2fdf2fdf2fdf2ULL, 0xfdf2fdf2fdf2fdf2ULL, },
+        { 0x370e370e370e370eULL, 0x370e370e370e370eULL, },
+        { 0xfe9cfe9cfe9cfe9cULL, 0xfe9cfe9cfe9cfe9cULL, },
+        { 0x2124212421242124ULL, 0x2124212421242124ULL, },
+        { 0xff46ff46ff46ff46ULL, 0xff46ff46ff46ff46ULL, },
+        { 0x2ec1f64f12882ec1ULL, 0xf64f12882ec1f64fULL, },
+        { 0xfff0fff0fff0fff0ULL, 0xfff0fff0fff0fff0ULL, },
+        { 0xff88ff88ff88ff88ULL, 0xff88ff88ff88ff88ULL, },    /*  32  */
+        { 0xff88ff88ff88ff88ULL, 0xff88ff88ff88ff88ULL, },
+        { 0xdc98dc98dc98dc98ULL, 0xdc98dc98dc98dc98ULL, },
+        { 0xff20ff20ff20ff20ULL, 0xff20ff20ff20ff20ULL, },
+        { 0xea00ea00ea00ea00ULL, 0xea00ea00ea00ea00ULL, },
+        { 0xfeb8feb8feb8feb8ULL, 0xfeb8feb8feb8feb8ULL, },
+        { 0xe1ac0434f2f0e1acULL, 0x0434f2f0e1ac0434ULL, },
+        { 0xfe50fe50fe50fe50ULL, 0xfe50fe50fe50fe50ULL, },
+        { 0xfeb6feb6feb6feb6ULL, 0xfeb6feb6feb6feb6ULL, },    /*  40  */
+        { 0xfeb6feb6feb6feb6ULL, 0xfeb6feb6feb6feb6ULL, },
+        { 0x20fa20fa20fa20faULL, 0x20fa20fa20fa20faULL, },
+        { 0xff1cff1cff1cff1cULL, 0xff1cff1cff1cff1cULL, },
+        { 0x13d413d413d413d4ULL, 0x13d413d413d413d4ULL, },
+        { 0xff82ff82ff82ff82ULL, 0xff82ff82ff82ff82ULL, },
+        { 0x1bfffa210b101bffULL, 0xfa210b101bfffa21ULL, },
+        { 0xffe8ffe8ffe8ffe8ULL, 0xffe8ffe8ffe8ffe8ULL, },
+        { 0xff590003ffaeff59ULL, 0x0003ffaeff590003ULL, },    /*  48  */
+        { 0xff590003ffaeff59ULL, 0x0003ffaeff590003ULL, },
+        { 0xcf4f0915ec32cf4fULL, 0x0915ec32cf4f0915ULL, },
+        { 0xfeca001eff74fecaULL, 0x001eff74feca001eULL, },
+        { 0xe1be059af3ace1beULL, 0x059af3ace1be059aULL, },
+        { 0xfe3b0039ff3afe3bULL, 0x0039ff3afe3b0039ULL, },
+        { 0xc82ef0b0c036c82eULL, 0xf0b0c036c82ef0b0ULL, },
+        { 0xfdac0054ff00fdacULL, 0x0054ff00fdac0054ULL, },
+        { 0xfe390037ff38fe39ULL, 0x0037ff38fe390037ULL, },    /*  56  */
+        { 0xfe390037ff38fe39ULL, 0x0037ff38fe390037ULL, },
+        { 0x2d97f67912082d97ULL, 0xf67912082d97f679ULL, },
+        { 0xfec6001aff70fec6ULL, 0x001aff70fec6001aULL, },
+        { 0x1b6afa360ad01b6aULL, 0xfa360ad01b6afa36ULL, },
+        { 0xff53fffdffa8ff53ULL, 0xfffdffa8ff53fffdULL, },
+        { 0x34d10fa13e7234d1ULL, 0x0fa13e7234d10fa1ULL, },
+        { 0xffe0ffe0ffe0ffe0ULL, 0xffe0ffe0ffe0ffe0ULL, },
+        { 0x9bbcf2acd41cd3a7ULL, 0xc076dce3c4c3e650ULL, },    /*  64  */
+        { 0xb4b806c8f1cee494ULL, 0xbecfd64ea6a80020ULL, },
+        { 0x6814ecfc0fa82b6dULL, 0xc37ad92a91550ac0ULL, },
+        { 0x7bdefedcee3621e3ULL, 0xeb34ed0270f105e0ULL, },
+        { 0x94da12f80be832d0ULL, 0xe98de66d52d61fb0ULL, },
+        { 0x83bdecafc65625dfULL, 0xe7f8d130419c055cULL, },
+        { 0x994d0df1c6d40fd2ULL, 0xe3d2c1a83e00f9d2ULL, },
+        { 0xafdbf02abf6b06b4ULL, 0xeb61a56034e501eeULL, },
+        { 0x6337d65edd454d8dULL, 0xf00ca83c1f920c8eULL, },    /*  72  */
+        { 0x78c7f7a0ddc33780ULL, 0xebe698b41bf60104ULL, },
+        { 0x3d93c078c0b1c207ULL, 0xdfb58b8ff884fa1bULL, },
+        { 0x468de162e424db51ULL, 0xeee27037d08b05f1ULL, },
+        { 0x5a57f342c2b2d1c7ULL, 0x169c840fb0270111ULL, },
+        { 0x70e5d57bbb49c8a9ULL, 0x1e2b67c7a70c092dULL, },
+        { 0x79dff665debce1f3ULL, 0x2d584c6f7f131503ULL, },
+        { 0x307edd58b2d7c6abULL, 0xf8ce0def507eed7fULL, },
+        { 0x12d2ebaaceb9ef2dULL, 0x0f44139e1494e19bULL, },    /*  80  */
+        { 0x07500cecbf88e9fcULL, 0x109a22b12d84e9f5ULL, },
+        { 0xed7c0a0c9689dd79ULL, 0xfe3a2a165149ee24ULL, },
+        { 0xcf880594d43cb481ULL, 0x00ba413659fef988ULL, },
+        { 0xea40f026c424ed7dULL, 0x1ce42a975ba6fcf8ULL, },
+        { 0xfa52e174e584e55aULL, 0x19f040936a55fe20ULL, },
+        { 0xdb86fe7ec64b0603ULL, 0x13a14ea67f40fbeaULL, },
+        { 0x115cd8c4cd3c05cdULL, 0x1699652699e9f314ULL, },
+        { 0xf33cc884be3c10e4ULL, 0x399852dba428ee14ULL, },    /*  88  */
+        { 0x0273f878eba21554ULL, 0x31ee6cb7a1dcf428ULL, },
+        { 0xdaad1e38d3d148edULL, 0x27a784e6885df2c4ULL, },
+        { 0x04ea0acced565727ULL, 0x33f546b6479bdaa0ULL, },
+        { 0x0fe60140cf623084ULL, 0x29715ee078b0d340ULL, },
+        { 0x097de88007d93f14ULL, 0x2a887b768288e2aaULL, },
+        { 0xe07fb5d0025365dfULL, 0x116297ca6cdaedb8ULL, },
+        { 0xc74ecab2f1b47bc3ULL, 0x1ec35e229b5ad07eULL, },
+        { 0x8c4ab55e1124622cULL, 0x2e844d9c6f52bb96ULL, },    /*  96  */
+        { 0x3746c0d800b436a2ULL, 0x52ee6f0548caaafeULL, },
+        { 0x3412b2381dcc3c34ULL, 0x4226686a634c9036ULL, },
+        { 0x44feb5ac2d2c1b48ULL, 0x1f863d063f8e6aaeULL, },
+        { 0x45ced628325f1f0bULL, 0x190e4cdb56714772ULL, },
+        { 0x3a43c6b04bc8259aULL, 0x17ca65193394327cULL, },
+        { 0x4cabe5a01d613107ULL, 0x14467dc849f92468ULL, },
+        { 0x383d0ac03df53bb8ULL, 0x1554a52945b51a80ULL, },
+        { 0x352bf8744cc532afULL, 0x1f4190b4693720beULL, },    /* 104  */
+        { 0x37711cdc568e2109ULL, 0x24b0770882d72146ULL, },
+        { 0x21c319bc5896349eULL, 0x12b492065fe41709ULL, },
+        { 0x42090ae65cb41b62ULL, 0x0416792084231302ULL, },
+        { 0x226211dc497800b0ULL, 0x072cb6d850f915fcULL, },
+        { 0xf5441b3a17b21910ULL, 0x0ce58de86df716f2ULL, },
+        { 0xe51807761e2e171eULL, 0x10b4544095541446ULL, },
+        { 0xe980e35e0a5c10acULL, 0x137085a05b4f30deULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_H(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_H(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_H__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_H__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
new file mode 100644
index 0000000..b95878b
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPSUB_S.W
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPSUB_S.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },    /*   0  */
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xffff5552ffff5552ULL, 0xffff5552ffff5552ULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xffff9994ffff9994ULL, 0xffff9994ffff9994ULL, },
+        { 0xfffffffafffffffaULL, 0xfffffffafffffffaULL, },
+        { 0x00001c6bffff71c0ULL, 0xffffc71500001c6bULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },    /*   8  */
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xffff554cffff554cULL, 0xffff554cffff554cULL, },    /*  16  */
+        { 0xffff554cffff554cULL, 0xffff554cffff554cULL, },
+        { 0xc71ae384c71ae384ULL, 0xc71ae384c71ae384ULL, },
+        { 0xfffeaaa0fffeaaa0ULL, 0xfffeaaa0fffeaaa0ULL, },
+        { 0xdddbbbb0dddbbbb0ULL, 0xdddbbbb0dddbbbb0ULL, },
+        { 0xfffdfff4fffdfff4ULL, 0xfffdfff4fffdfff4ULL, },
+        { 0x097912ead094f678ULL, 0xed06da06097912eaULL, },
+        { 0xfffd5548fffd5548ULL, 0xfffd5548fffd5548ULL, },
+        { 0xfffdfff2fffdfff2ULL, 0xfffdfff2fffdfff2ULL, },    /*  24  */
+        { 0xfffdfff2fffdfff2ULL, 0xfffdfff2fffdfff2ULL, },
+        { 0x38e1c70e38e1c70eULL, 0x38e1c70e38e1c70eULL, },
+        { 0xfffeaa9cfffeaa9cULL, 0xfffeaa9cfffeaa9cULL, },
+        { 0x2221332422213324ULL, 0x2221332422213324ULL, },
+        { 0xffff5546ffff5546ULL, 0xffff5546ffff5546ULL, },
+        { 0xf6845ec12f67d088ULL, 0x12f6424ff6845ec1ULL, },
+        { 0xfffffff0fffffff0ULL, 0xfffffff0fffffff0ULL, },
+        { 0xffff9988ffff9988ULL, 0xffff9988ffff9988ULL, },    /*  32  */
+        { 0xffff9988ffff9988ULL, 0xffff9988ffff9988ULL, },
+        { 0xdddcaa98dddcaa98ULL, 0xdddcaa98dddcaa98ULL, },
+        { 0xffff3320ffff3320ULL, 0xffff3320ffff3320ULL, },
+        { 0xeb83ae00eb83ae00ULL, 0xeb83ae00eb83ae00ULL, },
+        { 0xfffeccb8fffeccb8ULL, 0xfffeccb8fffeccb8ULL, },
+        { 0x05af16ace38c5af0ULL, 0xf49d9f3405af16acULL, },
+        { 0xfffe6650fffe6650ULL, 0xfffe6650fffe6650ULL, },
+        { 0xfffeccb6fffeccb6ULL, 0xfffeccb6fffeccb6ULL, },    /*  40  */
+        { 0xfffeccb6fffeccb6ULL, 0xfffeccb6fffeccb6ULL, },
+        { 0x222110fa222110faULL, 0x222110fa222110faULL, },
+        { 0xffff331cffff331cULL, 0xffff331cffff331cULL, },
+        { 0x147a51d4147a51d4ULL, 0x147a51d4147a51d4ULL, },
+        { 0xffff9982ffff9982ULL, 0xffff9982ffff9982ULL, },
+        { 0xfa4f6bff1c717d10ULL, 0x0b608e21fa4f6bffULL, },
+        { 0xffffffe8ffffffe8ULL, 0xffffffe8ffffffe8ULL, },
+        { 0x00001c59ffff71aeULL, 0xffffc70300001c59ULL, },    /*  48  */
+        { 0x00001c59ffff71aeULL, 0xffffc70300001c59ULL, },
+        { 0x097b2f4fd0966832ULL, 0xed08a115097b2f4fULL, },
+        { 0x000038cafffee374ULL, 0xffff8e1e000038caULL, },
+        { 0x05b082bee38c71acULL, 0xf49e609a05b082beULL, },
+        { 0x0000553bfffe553aULL, 0xffff55390000553bULL, },
+        { 0xf033192eca430636ULL, 0xc0c90fb0f033192eULL, },
+        { 0x000071acfffdc700ULL, 0xffff1c54000071acULL, },
+        { 0x00005539fffe5538ULL, 0xffff553700005539ULL, },    /*  56  */
+        { 0x00005539fffe5538ULL, 0xffff553700005539ULL, },
+        { 0xf68497972f66b408ULL, 0x12f5d079f6849797ULL, },
+        { 0x000038c6fffee370ULL, 0xffff8e1a000038c6ULL, },
+        { 0xfa4f886a1c70eed0ULL, 0x0b605536fa4f886aULL, },
+        { 0x00001c53ffff71a8ULL, 0xffffc6fd00001c53ULL, },
+        { 0x0fcd74d135ba3272ULL, 0x3f35d3a10fcd74d1ULL, },
+        { 0xffffffe0ffffffe0ULL, 0xffffffe0ffffffe0ULL, },
+        { 0xc5a8016cdd3daa5cULL, 0xe94945ebe7053037ULL, },    /*  64  */
+        { 0xc3b493dce3f99616ULL, 0xe6c275fe01105522ULL, },
+        { 0x949f7b2015d7bcd8ULL, 0xdd8e1f740c23f089ULL, },
+        { 0xcb480f0e10df8c96ULL, 0x0470e12d02738253ULL, },
+        { 0xc954a17e179b7850ULL, 0x01ea11401c7ea73eULL, },
+        { 0xc9425a31f36c45a7ULL, 0xedf7684bffd4d9adULL, },
+        { 0xc7fda5a7eec474caULL, 0xdbac4bfdfada4b68ULL, },
+        { 0xc9d3363ecb9ded37ULL, 0xc40db8860b92e4aaULL, },
+        { 0x9abe1d82fd7c13f9ULL, 0xbad961fc16a68011ULL, },    /*  72  */
+        { 0x997968f8f8d4431cULL, 0xa88e45ae11abf1ccULL, },
+        { 0x644cd070b0912dbbULL, 0x95a94d6df030af03ULL, },
+        { 0x90151b88bce11a1cULL, 0x8ce173edd7b3566dULL, },
+        { 0xc6bdaf76b7e8e9daULL, 0xb3c435a6ce02e837ULL, },
+        { 0xc893400d94c26247ULL, 0x9c25a22fdebb8179ULL, },
+        { 0xf45b8b25a1124ea8ULL, 0x935dc8afc63e28e3ULL, },
+        { 0xc124ff9b7af87983ULL, 0x2916358ea57b0fdfULL, },
+        { 0xa3bdf52f3f1bc6d3ULL, 0x1a9b7790a9e67552ULL, },    /*  80  */
+        { 0xa2394ebc1f432fbaULL, 0x38d091638b040700ULL, },
+        { 0x9c98e9da3d8da28dULL, 0x17578e46633c7554ULL, },
+        { 0xca2304601c11139aULL, 0xecce6f4f9252c75cULL, },
+        { 0xb167fd62111ca498ULL, 0xed848a6b7ffb85a6ULL, },
+        { 0xb01a590af79618c4ULL, 0xcf3de0319d05b479ULL, },
+        { 0xb2490b42008cb27aULL, 0xcfbf82ea8729672eULL, },
+        { 0xd36607e1f75b1a82ULL, 0x8006f7ab6a0e64dcULL, },
+        { 0xbf56e259efe4672cULL, 0xa61769778a2f91d2ULL, },    /*  88  */
+        { 0xbe4f061a0bbba5e0ULL, 0xc922e830b7ade689ULL, },
+        { 0xaac85110e5ef76abULL, 0xcc5f9db0a366adc6ULL, },
+        { 0xc91b5b88fd4a93d2ULL, 0x879c58c17a96cfbaULL, },
+        { 0xb8799dfa21be5efeULL, 0xa721331f6c3d78f0ULL, },
+        { 0xb76ef97e2ca86ef4ULL, 0xbb78ca223c0de8adULL, },
+        { 0x9da743266b64f51cULL, 0xba24b1045354f4faULL, },
+        { 0xc2f3162f429e4870ULL, 0x764125c06e4d3512ULL, },
+        { 0xa89d5e1d1ffccbf4ULL, 0x51bf6a197f87f33bULL, },    /*  96  */
+        { 0x890f17ff2c462c7cULL, 0x34f589127c4cc49aULL, },
+        { 0x53dc26951679feb0ULL, 0x2aa458e36a7c8cdeULL, },
+        { 0x7ed4f0c1135e605eULL, 0x1a22c08d472920e2ULL, },
+        { 0x80f6d8c622f1e674ULL, 0x071f986d36987e53ULL, },
+        { 0x7ee91ba012abf971ULL, 0xeab87172091da737ULL, },
+        { 0x80fac8d20b8e2fb8ULL, 0x0ad43e562523cff0ULL, },
+        { 0x7ef3481012ac516eULL, 0x1acdbd0e31a33d13ULL, },
+        { 0xbf53a8023cd97b5aULL, 0x07b9c024393d8136ULL, },    /* 104  */
+        { 0x8e3cb38085aaebe3ULL, 0xf84dd1305e923ebfULL, },
+        { 0x50c22f685af8caedULL, 0xef14166874d2544dULL, },
+        { 0x7a3548245bc2dee5ULL, 0xf6b38ff08f52b803ULL, },
+        { 0x3e4f96f53628fefdULL, 0xbe65c7ed60e1faffULL, },
+        { 0x2c2056e3221de63fULL, 0x871151e081227a9dULL, },
+        { 0x113314bc1293f380ULL, 0x774bb8df643781b9ULL, },
+        { 0x07d911730a4b3a5dULL, 0x8b56a81c77aef6ebULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_W(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_W(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_W__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_S_W__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
new file mode 100644
index 0000000..fc6c4e6
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPSUB_U.D
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPSUB_U.D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x00000003fffffffeULL, 0x00000003fffffffeULL, },    /*   0  */
+        { 0x00000003fffffffeULL, 0x00000003fffffffeULL, },
+        { 0xaaaaaab155555552ULL, 0xaaaaaab155555552ULL, },
+        { 0x00000007fffffffcULL, 0x00000007fffffffcULL, },
+        { 0x6666667199999994ULL, 0x6666667199999994ULL, },
+        { 0x0000000bfffffffaULL, 0x0000000bfffffffaULL, },
+        { 0x8e38e39c71c71c6bULL, 0xe38e38f21c71c715ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },    /*   8  */
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0x0000000ffffffff8ULL, 0x0000000ffffffff8ULL, },
+        { 0xaaaaaabd5555554cULL, 0xaaaaaabd5555554cULL, },    /*  16  */
+        { 0xaaaaaabd5555554cULL, 0xaaaaaabd5555554cULL, },
+        { 0xc71c71db8e38e384ULL, 0xc71c71db8e38e384ULL, },
+        { 0x5555556aaaaaaaa0ULL, 0x5555556aaaaaaaa0ULL, },
+        { 0x4444445bbbbbbbb0ULL, 0x4444445bbbbbbbb0ULL, },
+        { 0x00000017fffffff4ULL, 0x00000017fffffff4ULL, },
+        { 0x097b42784bda12eaULL, 0x425ed0b1684bda06ULL, },
+        { 0xaaaaaac555555548ULL, 0xaaaaaac555555548ULL, },
+        { 0x0000001bfffffff2ULL, 0x0000001bfffffff2ULL, },    /*  24  */
+        { 0x0000001bfffffff2ULL, 0x0000001bfffffff2ULL, },
+        { 0x8e38e3ab1c71c70eULL, 0x8e38e3ab1c71c70eULL, },
+        { 0x55555572aaaaaa9cULL, 0x55555572aaaaaa9cULL, },
+        { 0xcccccceb33333324ULL, 0xcccccceb33333324ULL, },
+        { 0xaaaaaac955555546ULL, 0xaaaaaac955555546ULL, },
+        { 0x2f684bf97b425ec1ULL, 0x4bda1316097b424fULL, },
+        { 0x0000001ffffffff0ULL, 0x0000001ffffffff0ULL, },
+        { 0x6666668999999988ULL, 0x6666668999999988ULL, },    /*  32  */
+        { 0x6666668999999988ULL, 0x6666668999999988ULL, },
+        { 0x5555557aaaaaaa98ULL, 0x5555557aaaaaaa98ULL, },
+        { 0xccccccf333333320ULL, 0xccccccf333333320ULL, },
+        { 0x851eb87ae147ae00ULL, 0x851eb87ae147ae00ULL, },
+        { 0x3333335cccccccb8ULL, 0x3333335cccccccb8ULL, },
+        { 0x0b60b636c16c16acULL, 0x4fa4fa7b49f49f34ULL, },
+        { 0x999999c666666650ULL, 0x999999c666666650ULL, },
+        { 0x33333360ccccccb6ULL, 0x33333360ccccccb6ULL, },    /*  40  */
+        { 0x33333360ccccccb6ULL, 0x33333360ccccccb6ULL, },
+        { 0xeeeeef1d111110faULL, 0xeeeeef1d111110faULL, },
+        { 0xccccccfb3333331cULL, 0xccccccfb3333331cULL, },
+        { 0x7ae147dd1eb851d4ULL, 0x7ae147dd1eb851d4ULL, },
+        { 0x6666669599999982ULL, 0x6666669599999982ULL, },
+        { 0x1c71c74c16c16bffULL, 0x2d82d85d38e38e21ULL, },
+        { 0x0000002fffffffe8ULL, 0x0000002fffffffe8ULL, },
+        { 0x8e38e3c071c71c59ULL, 0xe38e39161c71c703ULL, },    /*  48  */
+        { 0x8e38e3c071c71c59ULL, 0xe38e39161c71c703ULL, },
+        { 0x97b42620bda12f4fULL, 0x25ed09af84bda115ULL, },
+        { 0x1c71c750e38e38caULL, 0xc71c71fc38e38e1eULL, },
+        { 0xf49f4a2ad82d82beULL, 0xe38e391ab60b609aULL, },
+        { 0xaaaaaae15555553bULL, 0xaaaaaae255555539ULL, },
+        { 0x9161f9e5ba78192eULL, 0xd3c0ca7e948b0fb0ULL, },
+        { 0x38e38e71c71c71acULL, 0x8e38e3c871c71c54ULL, },
+        { 0xaaaaaae555555539ULL, 0xaaaaaae655555537ULL, },    /*  56  */
+        { 0xaaaaaae555555539ULL, 0xaaaaaae655555537ULL, },
+        { 0x4bda13325ed09797ULL, 0x12f684fa425ed079ULL, },
+        { 0x1c71c758e38e38c6ULL, 0xc71c720438e38e1aULL, },
+        { 0xaaaaaae88888886aULL, 0x1111114f55555536ULL, },
+        { 0x8e38e3cc71c71c53ULL, 0xe38e39221c71c6fdULL, },
+        { 0x35ba78587e6b74d1ULL, 0x9e06526bf9add3a1ULL, },
+        { 0x0000003fffffffe0ULL, 0x0000003fffffffe0ULL, },
+        { 0xb0ef5df9ed993d50ULL, 0xecd0c902514248ccULL, },    /*  64  */
+        { 0x1e8c6aa2f5c2926cULL, 0xd21b7a4e60b25370ULL, },
+        { 0xa56477c9bdfa46f4ULL, 0x1c376bca50d3cfdeULL, },
+        { 0x5aaf941e1e90da18ULL, 0x4a2661d3ec89a90eULL, },
+        { 0xc84ca0c726ba2f34ULL, 0x2f71131ffbf9b3b2ULL, },
+        { 0xb93c43f773d898abULL, 0x2c45d9ce74204cfeULL, },
+        { 0xd770bf8dbe2e30edULL, 0x1b1d2b640c71ea68ULL, },
+        { 0x4c7478e0222edcb6ULL, 0x028c79110abde6f8ULL, },
+        { 0xd34c8606ea66913eULL, 0x4ca86a8cfadf6366ULL, },    /*  72  */
+        { 0xf181019d34bc2980ULL, 0x3b7fbc22933100d0ULL, },
+        { 0xf69966e79904609cULL, 0xc2d94d22461ac53fULL, },
+        { 0x669e11492661ba7aULL, 0x3b951b06df919197ULL, },
+        { 0x1be92d9d86f84d9eULL, 0x698411107b476ac7ULL, },
+        { 0x90ece6efeaf8f967ULL, 0x50f35ebd79936757ULL, },
+        { 0x00f1915178565345ULL, 0xc9af2ca2130a33afULL, },
+        { 0xad039975a0f53058ULL, 0x0b11d7505015196fULL, },
+        { 0x376d4d72ebbc7b1cULL, 0xb833881ecd4918dbULL, },    /*  80  */
+        { 0xb97c39c63d30eb26ULL, 0x9983e1a16fddbe3bULL, },
+        { 0x103118e687f4c4aaULL, 0x36d2d322776b1540ULL, },
+        { 0xd7103f328f5683b0ULL, 0xc97816b7d22d1890ULL, },
+        { 0x4dd93b94622edfd8ULL, 0xbd32853a6649bd9eULL, },
+        { 0xe38ab03df0d4eedcULL, 0xa6b087fab9ab9432ULL, },
+        { 0x9b8bc7cd79738e5aULL, 0x1099960abd7ff844ULL, },
+        { 0x2a9e79f404df0445ULL, 0x8a1a574d141add54ULL, },
+        { 0x1323c575df66a395ULL, 0x4d70aaa974eb601eULL, },    /*  88  */
+        { 0xbc9ea974b0ce57aeULL, 0x3dff93a625e35e6cULL, },
+        { 0xbd4cca940103a7a6ULL, 0x1b03e192077feba2ULL, },
+        { 0x69e12c9b9ff2608eULL, 0x0713d9101835bf32ULL, },
+        { 0x183a0715853e498aULL, 0xeced28ff102b04faULL, },
+        { 0xd806808efcdcfa1bULL, 0xda07aee4d9a29bfcULL, },
+        { 0x8f0ceb4c5a20614fULL, 0x2693974265c37330ULL, },
+        { 0x2f219f4eacacaf61ULL, 0xcde749de29866580ULL, },
+        { 0xfac6c540b5ec9bf9ULL, 0x67fa3d30bf85f9fcULL, },    /*  96  */
+        { 0x58719a8af58d41b9ULL, 0x8af69bdae8797a8cULL, },
+        { 0x0293ed8dc2154481ULL, 0x7aef92fa834de3f0ULL, },
+        { 0xe296644d91f354e5ULL, 0xd4332e315ac37ee4ULL, },
+        { 0xd78a5344aa8ce0f6ULL, 0xbcf1bf88825a127aULL, },
+        { 0xcfe6e77bd50e6bfaULL, 0xa42046c9a6110292ULL, },
+        { 0xc2e4e16ef7883199ULL, 0x8a2eb57c71a6b370ULL, },
+        { 0xb83af7ab54b68847ULL, 0x7682eb14d9902e98ULL, },
+        { 0xfeb58099fb6e2639ULL, 0xd298a4d4f4eef1ccULL, },    /* 104  */
+        { 0x9cbae3e8d8c9b31fULL, 0x0e0c2c1a33a56ab0ULL, },
+        { 0x95dc4a7a980a468fULL, 0xe95439aa32919b0aULL, },
+        { 0xc29c82993429f90bULL, 0xa33308195e2c1fecULL, },
+        { 0x5a0a569e52e5f3acULL, 0x0a72368b53acb754ULL, },
+        { 0x140968eb707c3bbeULL, 0xcd5491c571071d8cULL, },
+        { 0xe1db913744288b2bULL, 0x10c008b6922667d4ULL, },
+        { 0x65b190239a38c686ULL, 0xa6d4ec5b01d651c4ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_D(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_D(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_D__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_D__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
new file mode 100644
index 0000000..741c887
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPSUB_U.H
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPSUB_U.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x03fe03fe03fe03feULL, 0x03fe03fe03fe03feULL, },    /*   0  */
+        { 0x03fe03fe03fe03feULL, 0x03fe03fe03fe03feULL, },
+        { 0xb152b152b152b152ULL, 0xb152b152b152b152ULL, },
+        { 0x07fc07fc07fc07fcULL, 0x07fc07fc07fc07fcULL, },
+        { 0x7194719471947194ULL, 0x7194719471947194ULL, },
+        { 0x0bfa0bfa0bfa0bfaULL, 0x0bfa0bfa0bfa0bfaULL, },
+        { 0x9c6bf21546c09c6bULL, 0xf21546c09c6bf215ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },    /*   8  */
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0x0ff80ff80ff80ff8ULL, 0x0ff80ff80ff80ff8ULL, },
+        { 0xbd4cbd4cbd4cbd4cULL, 0xbd4cbd4cbd4cbd4cULL, },    /*  16  */
+        { 0xbd4cbd4cbd4cbd4cULL, 0xbd4cbd4cbd4cbd4cULL, },
+        { 0xdb84db84db84db84ULL, 0xdb84db84db84db84ULL, },
+        { 0x6aa06aa06aa06aa0ULL, 0x6aa06aa06aa06aa0ULL, },
+        { 0x5bb05bb05bb05bb0ULL, 0x5bb05bb05bb05bb0ULL, },
+        { 0x17f417f417f417f4ULL, 0x17f417f417f417f4ULL, },
+        { 0x22ea5c06947822eaULL, 0x5c06947822ea5c06ULL, },
+        { 0xc548c548c548c548ULL, 0xc548c548c548c548ULL, },
+        { 0x1bf21bf21bf21bf2ULL, 0x1bf21bf21bf21bf2ULL, },    /*  24  */
+        { 0x1bf21bf21bf21bf2ULL, 0x1bf21bf21bf21bf2ULL, },
+        { 0xab0eab0eab0eab0eULL, 0xab0eab0eab0eab0eULL, },
+        { 0x729c729c729c729cULL, 0x729c729c729c729cULL, },
+        { 0xeb24eb24eb24eb24ULL, 0xeb24eb24eb24eb24ULL, },
+        { 0xc946c946c946c946ULL, 0xc946c946c946c946ULL, },
+        { 0x4ec16b4f87884ec1ULL, 0x6b4f87884ec16b4fULL, },
+        { 0x1ff01ff01ff01ff0ULL, 0x1ff01ff01ff01ff0ULL, },
+        { 0x8988898889888988ULL, 0x8988898889888988ULL, },    /*  32  */
+        { 0x8988898889888988ULL, 0x8988898889888988ULL, },
+        { 0x7a987a987a987a98ULL, 0x7a987a987a987a98ULL, },
+        { 0xf320f320f320f320ULL, 0xf320f320f320f320ULL, },
+        { 0xae00ae00ae00ae00ULL, 0xae00ae00ae00ae00ULL, },
+        { 0x5cb85cb85cb85cb8ULL, 0x5cb85cb85cb85cb8ULL, },
+        { 0x36ac7b34bef036acULL, 0x7b34bef036ac7b34ULL, },
+        { 0xc650c650c650c650ULL, 0xc650c650c650c650ULL, },
+        { 0x60b660b660b660b6ULL, 0x60b660b660b660b6ULL, },    /*  40  */
+        { 0x60b660b660b660b6ULL, 0x60b660b660b660b6ULL, },
+        { 0x1cfa1cfa1cfa1cfaULL, 0x1cfa1cfa1cfa1cfaULL, },
+        { 0xfb1cfb1cfb1cfb1cULL, 0xfb1cfb1cfb1cfb1cULL, },
+        { 0xa9d4a9d4a9d4a9d4ULL, 0xa9d4a9d4a9d4a9d4ULL, },
+        { 0x9582958295829582ULL, 0x9582958295829582ULL, },
+        { 0x4bff5d216e104bffULL, 0x5d216e104bff5d21ULL, },
+        { 0x2fe82fe82fe82fe8ULL, 0x2fe82fe82fe82fe8ULL, },
+        { 0xc05916036aaec059ULL, 0x16036aaec0591603ULL, },    /*  48  */
+        { 0xc05916036aaec059ULL, 0x16036aaec0591603ULL, },
+        { 0xcb4f5a15e732cb4fULL, 0x5a15e732cb4f5a15ULL, },
+        { 0x50cafc1ea57450caULL, 0xfc1ea57450cafc1eULL, },
+        { 0x2abe1a9a07ac2abeULL, 0x1a9a07ac2abe1a9aULL, },
+        { 0xe13be239e03ae13bULL, 0xe239e03ae13be239ULL, },
+        { 0xc92e0cb08536c92eULL, 0x0cb08536c92e0cb0ULL, },
+        { 0x71acc8541b0071acULL, 0xc8541b0071acc854ULL, },
+        { 0xe539e637e438e539ULL, 0xe637e438e539e637ULL, },    /*  56  */
+        { 0xe539e637e438e539ULL, 0xe637e438e539e637ULL, },
+        { 0x87974f7915088797ULL, 0x4f79150887974f79ULL, },
+        { 0x58c6041aad7058c6ULL, 0x041aad7058c6041aULL, },
+        { 0xe86a4f36b4d0e86aULL, 0x4f36b4d0e86a4f36ULL, },
+        { 0xcc5321fd76a8cc53ULL, 0x21fd76a8cc5321fdULL, },
+        { 0x74d1dda10c7274d1ULL, 0xdda10c7274d1dda1ULL, },
+        { 0x3fe03fe03fe03fe0ULL, 0x3fe03fe03fe03fe0ULL, },
+        { 0xcbbcceac141c13a7ULL, 0x00761ce308c3c650ULL, },    /*  64  */
+        { 0xf7b87fc8cfcecf94ULL, 0x97cf0b4ed5a88220ULL, },
+        { 0x77145bfc63a8816dULL, 0x357aa52a175567c0ULL, },
+        { 0x1ade0adc423622e3ULL, 0xab3450024ff1c4e0ULL, },
+        { 0x46dabbf8fde8ded0ULL, 0x428d3e6d1cd680b0ULL, },
+        { 0xc3bd95af925643dfULL, 0x52f8b3300b9c6e5cULL, },
+        { 0xd84d53f1e3d4d3d2ULL, 0x7fd208a8f3004ed2ULL, },
+        { 0x2fdb362aab6b21b4ULL, 0x8d618f60d4e568eeULL, },
+        { 0xaf37125e3f45d38dULL, 0x2b0c293c16924e8eULL, },    /*  72  */
+        { 0xc3c7d0a090c36380ULL, 0x57e67eb4fdf62f04ULL, },
+        { 0x3093e97863b1d807ULL, 0x9bb5e78f8484281bULL, },
+        { 0xc98da762f8243651ULL, 0xbae2a737088bfaf1ULL, },
+        { 0x6d575642d6b2d7c7ULL, 0x309c520f41275811ULL, },
+        { 0xc4e5387b9e4925a9ULL, 0x3e2bd8c7230c722dULL, },
+        { 0x5ddff66532bc83f3ULL, 0x5d58986fa7134503ULL, },
+        { 0x147edd5806d7a4abULL, 0x2cce99ef267e197fULL, },
+        { 0xd5b2d0aab3994377ULL, 0xcd083b9ac440025bULL, },    /*  80  */
+        { 0x80bf8eec25e70baaULL, 0xb6e600dda46ca823ULL, },
+        { 0xe79991b05061b0b1ULL, 0xd91c24ba24bc8d1fULL, },
+        { 0x5352504a2070df63ULL, 0x473b74aadc80fd45ULL, },
+        { 0x0546cd72f0907c98ULL, 0x1ab13142c4b84c19ULL, },
+        { 0xcc6ba15c55b01774ULL, 0x6e1606c3875c1b25ULL, },
+        { 0x1dbdf6d689f3d0f7ULL, 0x4ac43fe21dbb145aULL, },
+        { 0xd6baa1542922ce15ULL, 0x697e5fbada60ca72ULL, },
+        { 0x1806cdbe15b6846fULL, 0x18091759d3f43a3aULL, },    /*  88  */
+        { 0xfc0a8444a6e31a5bULL, 0x0daafd828699ee8eULL, },
+        { 0x4f36fd647760debdULL, 0x7c3fb8561364c110ULL, },
+        { 0x1bfcc992394ee12bULL, 0xfca40e06ed110caeULL, },
+        { 0xa54ca0a4128a8bb6ULL, 0x70d40b38f9c0fc46ULL, },
+        { 0xcb1d6138bde219f9ULL, 0x9c68fd7fb61366a6ULL, },
+        { 0x3887fa1a7e8f8fe6ULL, 0x2ce4bb5039504af0ULL, },
+        { 0xf65edccc34eccb94ULL, 0x3e041478ff0f739cULL, },
+        { 0x4cc27494d274632dULL, 0x2a3ee78cfad81d3cULL, },    /*  96  */
+        { 0xd40e966c853c370eULL, 0x04feaa379b04067cULL, },
+        { 0x5da2b998597c214bULL, 0x9da08eb7ff4efc8cULL, },
+        { 0xe9269a421c1c0396ULL, 0x2f41456bdcd248bcULL, },
+        { 0xe87f80bc039cfc91ULL, 0xed3c08269718789cULL, },
+        { 0xa6c53808a9213425ULL, 0xa2aefe7284cdb89cULL, },
+        { 0x71cd34f063590a91ULL, 0xef6839544786e41cULL, },
+        { 0x6adcd8201277fe43ULL, 0x7a42072920b97f84ULL, },
+        { 0xd64c3010a53c52d9ULL, 0x2ffcd8e8ec4662d9ULL, },    /* 104  */
+        { 0x2bcc04d0fd7bb9d3ULL, 0x54334ac042e043bbULL, },
+        { 0xc73077f8e331ebe0ULL, 0x1c5f5244f12a2b70ULL, },
+        { 0x309c82661787fc47ULL, 0xc7f3cf1c49211c79ULL, },
+        { 0xeb78588cf53e082dULL, 0x75954984106eb821ULL, },
+        { 0x5fa026e08f6af367ULL, 0xa8dfb35ce9820111ULL, },
+        { 0x04b0e03c469efd7fULL, 0x7a6806a42e2df58fULL, },
+        { 0xcca0baf00eacf773ULL, 0xd54e79140435c3e5ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_H(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_H(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_H__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_H__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c
new file mode 100644
index 0000000..3e1b711
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction DPSUB_U.W
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
+    char *group_name = "Int Dot Product";
+    char *instruction_name =  "DPSUB_U.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0003fffe0003fffeULL, 0x0003fffe0003fffeULL, },    /*   0  */
+        { 0x0003fffe0003fffeULL, 0x0003fffe0003fffeULL, },
+        { 0xaab15552aab15552ULL, 0xaab15552aab15552ULL, },
+        { 0x0007fffc0007fffcULL, 0x0007fffc0007fffcULL, },
+        { 0x6671999466719994ULL, 0x6671999466719994ULL, },
+        { 0x000bfffa000bfffaULL, 0x000bfffa000bfffaULL, },
+        { 0xe39c1c6b8e4771c0ULL, 0x38f1c715e39c1c6bULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },    /*   8  */
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0x000ffff8000ffff8ULL, 0x000ffff8000ffff8ULL, },
+        { 0xaabd554caabd554cULL, 0xaabd554caabd554cULL, },    /*  16  */
+        { 0xaabd554caabd554cULL, 0xaabd554caabd554cULL, },
+        { 0xc730e384c730e384ULL, 0xc730e384c730e384ULL, },
+        { 0x556aaaa0556aaaa0ULL, 0x556aaaa0556aaaa0ULL, },
+        { 0x445bbbb0445bbbb0ULL, 0x445bbbb0445bbbb0ULL, },
+        { 0x0017fff40017fff4ULL, 0x0017fff40017fff4ULL, },
+        { 0x427812ea0994f678ULL, 0x7b5bda06427812eaULL, },
+        { 0xaac55548aac55548ULL, 0xaac55548aac55548ULL, },
+        { 0x001bfff2001bfff2ULL, 0x001bfff2001bfff2ULL, },    /*  24  */
+        { 0x001bfff2001bfff2ULL, 0x001bfff2001bfff2ULL, },
+        { 0x8e55c70e8e55c70eULL, 0x8e55c70e8e55c70eULL, },
+        { 0x5572aa9c5572aa9cULL, 0x5572aa9c5572aa9cULL, },
+        { 0xcceb3324cceb3324ULL, 0xcceb3324cceb3324ULL, },
+        { 0xaac95546aac95546ULL, 0xaac95546aac95546ULL, },
+        { 0x4bf95ec12f87d088ULL, 0x686b424f4bf95ec1ULL, },
+        { 0x001ffff0001ffff0ULL, 0x001ffff0001ffff0ULL, },
+        { 0x6689998866899988ULL, 0x6689998866899988ULL, },    /*  32  */
+        { 0x6689998866899988ULL, 0x6689998866899988ULL, },
+        { 0x557aaa98557aaa98ULL, 0x557aaa98557aaa98ULL, },
+        { 0xccf33320ccf33320ULL, 0xccf33320ccf33320ULL, },
+        { 0x8547ae008547ae00ULL, 0x8547ae008547ae00ULL, },
+        { 0x335cccb8335cccb8ULL, 0x335cccb8335cccb8ULL, },
+        { 0x4fd016ac0b8c5af0ULL, 0x94149f344fd016acULL, },
+        { 0x99c6665099c66650ULL, 0x99c6665099c66650ULL, },
+        { 0x3360ccb63360ccb6ULL, 0x3360ccb63360ccb6ULL, },    /*  40  */
+        { 0x3360ccb63360ccb6ULL, 0x3360ccb63360ccb6ULL, },
+        { 0xef1d10faef1d10faULL, 0xef1d10faef1d10faULL, },
+        { 0xccfb331cccfb331cULL, 0xccfb331cccfb331cULL, },
+        { 0x7b1051d47b1051d4ULL, 0x7b1051d47b1051d4ULL, },
+        { 0x6695998266959982ULL, 0x6695998266959982ULL, },
+        { 0x2db26bff1ca17d10ULL, 0x3ec38e212db26bffULL, },
+        { 0x002fffe8002fffe8ULL, 0x002fffe8002fffe8ULL, },
+        { 0xe3c01c598e6b71aeULL, 0x3915c703e3c01c59ULL, },    /*  48  */
+        { 0xe3c01c598e6b71aeULL, 0x3915c703e3c01c59ULL, },
+        { 0x26202f4f97e86832ULL, 0xb459a11526202f4fULL, },
+        { 0xc75038ca1ca6e374ULL, 0x71fb8e1ec75038caULL, },
+        { 0xe3c382bef4d671acULL, 0xd2b3609ae3c382beULL, },
+        { 0xaae0553baae2553aULL, 0xaae15539aae0553bULL, },
+        { 0xd3f7192e919b0636ULL, 0x4f3b0fb0d3f7192eULL, },
+        { 0x8e7071ac391dc700ULL, 0xe3c71c548e7071acULL, },
+        { 0xaae45539aae65538ULL, 0xaae55537aae45539ULL, },    /*  56  */
+        { 0xaae45539aae65538ULL, 0xaae55537aae45539ULL, },
+        { 0x133197974c16b408ULL, 0xda4ed07913319797ULL, },
+        { 0xc75838c61caee370ULL, 0x72038e1ac75838c6ULL, },
+        { 0x114e886aaae8eed0ULL, 0x77b55536114e886aULL, },
+        { 0xe3cc1c538e7771a8ULL, 0x3921c6fde3cc1c53ULL, },
+        { 0x9e4574d135fa3272ULL, 0xcdadd3a19e4574d1ULL, },
+        { 0x003fffe0003fffe0ULL, 0x003fffe0003fffe0ULL, },
+        { 0xe77c016cdd7daa5cULL, 0xe98945eb8a373037ULL, },    /*  64  */
+        { 0x60fd93dc8ef99616ULL, 0xdba475fe3c075522ULL, },
+        { 0x67ae7b204335bcd8ULL, 0xc7121f747860f089ULL, },
+        { 0x17bb0f0ee8fd8c96ULL, 0x972fe12d34478253ULL, },
+        { 0x913ca17e9a797850ULL, 0x894b1140e617a73eULL, },
+        { 0x99ae5a31e83a45a7ULL, 0xff24684bc96dd9adULL, },
+        { 0xefeea5a7437774caULL, 0x6ac04bfdaf344b68ULL, },
+        { 0x8175363e76faed37ULL, 0xfc38b88657b1e4aaULL, },
+        { 0x88261d822b3713f9ULL, 0xe7a661fc940b8011ULL, },    /*  72  */
+        { 0xde6668f88674431cULL, 0x534245ae79d1f1ccULL, },
+        { 0xf331d070b3932dbbULL, 0xb25f4d6d0200af03ULL, },
+        { 0x985e1b88f3e41a1cULL, 0x31e873ed7002566dULL, },
+        { 0x486aaf7699abe9daULL, 0x020635a62be8e837ULL, },
+        { 0xd9f1400dcd2f6247ULL, 0x937ea22fd4668179ULL, },
+        { 0x7f1d8b250d804ea8ULL, 0x1307c8af426828e3ULL, },
+        { 0x4be6ff9b22ca7983ULL, 0x7b2e358e09e10fdfULL, },
+        { 0x3d0470dbf4d6b86fULL, 0x548567e8f5250450ULL, },    /*  80  */
+        { 0x00d897321b41b715ULL, 0x02517c05df66c875ULL, },
+        { 0x991ec80ea3b5c306ULL, 0xa18dc9b22cff8e2fULL, },
+        { 0x44850796bb133f8dULL, 0xdc2a4cc591614211ULL, },
+        { 0x192b30fc8866f607ULL, 0x97e8c289d36e61aaULL, },
+        { 0x0058689e9fcad43dULL, 0xfe7a0cc7a239bc40ULL, },
+        { 0xb8bc4cc2b8296867ULL, 0xccf01b9e1a7e74adULL, },
+        { 0x61014864181c5d2cULL, 0x4c8bc05ea1b0cc11ULL, },
+        { 0xec0d0e4af547db74ULL, 0x2d758eed74a13bb5ULL, },    /*  88  */
+        { 0x03e797060056a10fULL, 0xc1a1d5f8579892eaULL, },
+        { 0x9a3ca5d4a8548905ULL, 0xfd2bfd1807c0081aULL, },
+        { 0x4820b48cf1454f6bULL, 0xe982ac5dfb74445aULL, },
+        { 0x7eec2fbcb0c3c941ULL, 0x9d1459e9d27d4766ULL, },
+        { 0x020a22e0debbd140ULL, 0x4fbb0ef3a9e0453bULL, },
+        { 0xe8df4a9ccb0c350bULL, 0x37b3761e2e442cffULL, },
+        { 0x7c3604df51731065ULL, 0xd9add64be7d81e17ULL, },
+        { 0x35a1aacf3f24481fULL, 0x900caa26ecaf303bULL, },    /*  96  */
+        { 0x7f0fd7311d2a2997ULL, 0x5e11155ee03d0362ULL, },
+        { 0x7959c1ef0ab6e6c3ULL, 0x41695f03ff01377bULL, },
+        { 0x89d8f6a1bc2ded57ULL, 0x29ed46aadb5c8a3cULL, },
+        { 0x01ec800ecaa24ac8ULL, 0xf32ccdbb9c58b788ULL, },
+        { 0xffd7297c53176782ULL, 0x4acc984953e0cc00ULL, },
+        { 0x04316ff6e9707c3dULL, 0xd5f54b0b0ac9f7e0ULL, },
+        { 0xffe6fc76421c7405ULL, 0x8f42f98ab98b12e9ULL, },
+        { 0xa75ea33ed2e809e1ULL, 0xb6fdbf643abee85cULL, },    /* 104  */
+        { 0xc75019063471bcc9ULL, 0x05bcd250f1d0ad42ULL, },
+        { 0x300d94eaa78224eaULL, 0x615cfa00370a0c2aULL, },
+        { 0xaa1a04f419d03dccULL, 0x8fe0ca60107a1a34ULL, },
+        { 0x5f0bb18ad9b000d4ULL, 0xd3ed3780ee630840ULL, },
+        { 0x25e24aa388dc4d8cULL, 0x40c1586349788fbaULL, },
+        { 0x0ec344de11f41ac8ULL, 0xed9aea2a99a95e8aULL, },
+        { 0x02499bebf3ac5a24ULL, 0xecb186c0e06045b8ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_W(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_W(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_W__DDT(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      ((RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_DPSUB_U_W__DSD(b128_random[i], b128_random[j],
+                                  b128_result[
+                                      ((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                       (RANDOM_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
index 8ef836d..16920e8 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
@@ -294,6 +294,30 @@
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_u_w
 /opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dotp_u_d.c        \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dotp_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpadd_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpadd_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_s_d.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpadd_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpadd_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpadd_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpadd_u_d.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpadd_u_d
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpsub_s_h
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpsub_s_w
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_s_d.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpsub_s_d
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpsub_u_h
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpsub_u_w
+/opt/img/bin/mips-img-linux-gnu-gcc int-dot-product/test_msa_dpsub_u_d.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_dpsub_u_d
 
 #
 # Int Max Min
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run.sh b/tests/tcg/mips/user/ase/msa/test_msa_run.sh
index b6785e3..181f67d 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run.sh
@@ -173,6 +173,18 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_s_d
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_h
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_w
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dotp_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpadd_u_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_s_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_dpsub_u_d
 
 #
 # Int Max Min
-- 
2.7.4



