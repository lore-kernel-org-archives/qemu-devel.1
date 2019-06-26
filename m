Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4117BC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF6F2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF6F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6Xv-0002gv-NV
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43822)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6Nc-0001ln-EL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NR-0006Ok-0P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60783 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NP-0005uB-HK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2DAB91A46A2;
 Wed, 26 Jun 2019 13:45:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BFD521A46A3;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:43 +0200
Message-Id: <1561549550-3501-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 10/17] tests/tcg: target/mips: Add tests for MSA
 bit move instructions
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

Add tests for MSA bit move instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1561543629-20327-2-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/include/wrappers_msa.h              |  32 ++-
 .../mips/user/ase/msa/bit-move/test_msa_binsl_b.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_d.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_h.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_w.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_b.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_d.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_h.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_w.c  | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c   | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_bmz_v.c    | 214 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-move/test_msa_bsel_v.c   | 214 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_compile.sh    |  22 +++
 tests/tcg/mips/user/ase/msa/test_msa_run.sh        |  11 ++
 14 files changed, 2415 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 9570aa8..17fd277 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -124,8 +124,9 @@ static inline void do_msa_##suffix(const void *input1,                 \
 }
 
 #define DO_MSA__WD__WD_WT(suffix, mnemonic)                            \
-static inline void do_msa_##suffix(void *input1, void *input2,         \
-                                   void *output)                       \
+static inline void do_msa_##suffix(const void *input1,                 \
+                                   const void *input2,                 \
+                                   const void *output)                 \
 {                                                                      \
    __asm__ volatile (                                                  \
       "move $t0, %0\n\t"                                               \
@@ -142,8 +143,9 @@ static inline void do_msa_##suffix(void *input1, void *input2,         \
 }
 
 #define DO_MSA__WD__WS_WD(suffix, mnemonic)                            \
-static inline void do_msa_##suffix(void *input1, void *input2,         \
-                                   void *output)                       \
+static inline void do_msa_##suffix(const void *input1,                 \
+                                   const void *input2,                 \
+                                   const void *output)                 \
 {                                                                      \
    __asm__ volatile (                                                  \
       "move $t0, %0\n\t"                                               \
@@ -187,18 +189,40 @@ DO_MSA__WD__WS(PCNT_D, pcnt.d)
  */
 
 DO_MSA__WD__WS_WT(BINSL_B, binsl.b)
+DO_MSA__WD__WD_WT(BINSL_B__DDT, binsl.b)
+DO_MSA__WD__WS_WD(BINSL_B__DSD, binsl.b)
 DO_MSA__WD__WS_WT(BINSL_H, binsl.h)
+DO_MSA__WD__WD_WT(BINSL_H__DDT, binsl.h)
+DO_MSA__WD__WS_WD(BINSL_H__DSD, binsl.h)
 DO_MSA__WD__WS_WT(BINSL_W, binsl.w)
+DO_MSA__WD__WD_WT(BINSL_W__DDT, binsl.w)
+DO_MSA__WD__WS_WD(BINSL_W__DSD, binsl.w)
 DO_MSA__WD__WS_WT(BINSL_D, binsl.d)
+DO_MSA__WD__WD_WT(BINSL_D__DDT, binsl.d)
+DO_MSA__WD__WS_WD(BINSL_D__DSD, binsl.d)
 
 DO_MSA__WD__WS_WT(BINSR_B, binsr.b)
+DO_MSA__WD__WD_WT(BINSR_B__DDT, binsr.b)
+DO_MSA__WD__WS_WD(BINSR_B__DSD, binsr.b)
 DO_MSA__WD__WS_WT(BINSR_H, binsr.h)
+DO_MSA__WD__WD_WT(BINSR_H__DDT, binsr.h)
+DO_MSA__WD__WS_WD(BINSR_H__DSD, binsr.h)
 DO_MSA__WD__WS_WT(BINSR_W, binsr.w)
+DO_MSA__WD__WD_WT(BINSR_W__DDT, binsr.w)
+DO_MSA__WD__WS_WD(BINSR_W__DSD, binsr.w)
 DO_MSA__WD__WS_WT(BINSR_D, binsr.d)
+DO_MSA__WD__WD_WT(BINSR_D__DDT, binsr.d)
+DO_MSA__WD__WS_WD(BINSR_D__DSD, binsr.d)
 
 DO_MSA__WD__WS_WT(BMNZ_V, bmnz.v)
+DO_MSA__WD__WD_WT(BMNZ_V__DDT, bmnz.v)
+DO_MSA__WD__WS_WD(BMNZ_V__DSD, bmnz.v)
 DO_MSA__WD__WS_WT(BMZ_V, bmz.v)
+DO_MSA__WD__WD_WT(BMZ_V__DDT, bmz.v)
+DO_MSA__WD__WS_WD(BMZ_V__DSD, bmz.v)
 DO_MSA__WD__WS_WT(BSEL_V, bsel.v)
+DO_MSA__WD__WD_WT(BSEL_V__DDT, bsel.v)
+DO_MSA__WD__WS_WD(BSEL_V__DSD, bsel.v)
 
 
 /*
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
new file mode 100644
index 0000000..4a34f69
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSL.B
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSL.B";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x9c71e7cc71675471ULL, 0x4767015ffe71c70cULL, },    /*  64  */
+        { 0x8c6be7cc29675571ULL, 0x4767015ffe7ba70cULL, },
+        { 0x8c6be7cc29625571ULL, 0x4b670b5efe7bb30cULL, },
+        { 0x8c6ae7cc29625541ULL, 0x4b670b5efe7bb30cULL, },
+        { 0x8caa01642982c541ULL, 0x1bf7bb1a143b33fcULL, },
+        { 0xfcbe01644d92c741ULL, 0x1bf7bb1a143f53fcULL, },
+        { 0xfcbe01644d93c741ULL, 0x12f7bb1a143f53fcULL, },
+        { 0xfcbe01604d93c709ULL, 0x12f7bb1a143f53fcULL, },
+        { 0xfc5eafa8cdd38b89ULL, 0x22d8cbfeaa2f5314ULL, },    /*  72  */
+        { 0xac5aafa8b9c38b89ULL, 0x22d8cbfeaa2b3314ULL, },
+        { 0xac5aafa8b9cf8b89ULL, 0x27d8c7ffaa2b2714ULL, },
+        { 0xac5aafa8b9cf8b81ULL, 0x27d8c7ffaa2b2714ULL, },
+        { 0x2c5a1748392fe301ULL, 0x87f187d9a84ba7a4ULL, },
+        { 0x7c4e17485d3fe201ULL, 0x87f187d9a842e7a4ULL, },
+        { 0x744e17485d31e201ULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },    /*  80  */
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },    /*  88  */
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x744f174c5f31e24fULL, 0x8df189d8a842e3a4ULL, },
+        { 0x8c6ae6cc28714240ULL, 0x49710958a862b30cULL, },    /*  96  */
+        { 0x8c6ae6cc28714240ULL, 0x49710958a862b30cULL, },
+        { 0x8c6ae6cc28714240ULL, 0x49710958a862b30cULL, },
+        { 0x8c6ae6cc28714240ULL, 0x49710958a862b30cULL, },
+        { 0xfcaa006428b1c240ULL, 0x09f18958282253fcULL, },
+        { 0xfcaa006428b1c240ULL, 0x09f18958282253fcULL, },
+        { 0xfcaa006428b1c240ULL, 0x09f18958282253fcULL, },
+        { 0xfcaa006428b1c240ULL, 0x09f18958282253fcULL, },
+        { 0xac4a80aca8f182c0ULL, 0x09f1c9d8a8222314ULL, },    /* 104  */
+        { 0xac4a80aca8f182c0ULL, 0x09f1c9d8a8222314ULL, },
+        { 0xac4a80aca8f182c0ULL, 0x09f1c9d8a8222314ULL, },
+        { 0xac4a80aca8f182c0ULL, 0x09f1c9d8a8222314ULL, },
+        { 0x744a004c2831e240ULL, 0x89f189d8a842e3a4ULL, },
+        { 0x744a004c2831e240ULL, 0x89f189d8a842e3a4ULL, },
+        { 0x744a004c2831e240ULL, 0x89f189d8a842e3a4ULL, },
+        { 0x744a004c2831e240ULL, 0x89f189d8a842e3a4ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_B__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSL_B__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
new file mode 100644
index 0000000..0fc44fa
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSL.D
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSL.D";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x9c71c71c71c71c71ULL, 0x4b6471c71c71c71cULL, },    /*  64  */
+        { 0x8871c71c71c71c71ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x8871c71c71c71c71ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886bc71c71c71c71ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886bc71c71c71c71ULL, 0x12f70b5efe7bb00cULL, },
+        { 0xfbebc71c71c71c71ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbebc71c71c71c71ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbfc71c71c71c71ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbfc71c71c71c71ULL, 0x27dfbb1a153f52fcULL, },    /*  72  */
+        { 0xac3fc71c71c71c71ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac3fc71c71c71c71ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5bc71c71c71c71ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x2c5bc71c71c71c71ULL, 0x8df0c6ffab2b2514ULL, },
+        { 0x705bc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x705bc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },    /*  80  */
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },    /*  88  */
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704fc71c71c71c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x886ae6cc28625c71ULL, 0x4b670b5ef942e2a4ULL, },    /*  96  */
+        { 0x886ae6cc28625c71ULL, 0x4b670b5ef942e2a4ULL, },
+        { 0x886ae6cc28625c71ULL, 0x4b670b5ef942e2a4ULL, },
+        { 0x886ae6cc28625c71ULL, 0x4b670b5ef942e2a4ULL, },
+        { 0xfbbe00634d93dc71ULL, 0x12f7bb1a1142e2a4ULL, },
+        { 0xfbbe00634d93dc71ULL, 0x12f7bb1a1142e2a4ULL, },
+        { 0xfbbe00634d93dc71ULL, 0x12f7bb1a1142e2a4ULL, },
+        { 0xfbbe00634d93dc71ULL, 0x12f7bb1a1142e2a4ULL, },
+        { 0xac5aaeaab9cf9c71ULL, 0x27d8c6ffa942e2a4ULL, },    /* 104  */
+        { 0xac5aaeaab9cf9c71ULL, 0x27d8c6ffa942e2a4ULL, },
+        { 0xac5aaeaab9cf9c71ULL, 0x27d8c6ffa942e2a4ULL, },
+        { 0xac5aaeaab9cf9c71ULL, 0x27d8c6ffa942e2a4ULL, },
+        { 0x704f164d5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704f164d5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704f164d5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704f164d5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_D__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSL_D__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
new file mode 100644
index 0000000..cc2db04
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSL.H
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSL.H";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x8871e6cc31c71c71ULL, 0x4b1c0b5ffe71b00cULL, },    /*  64  */
+        { 0x886be6cc21c75571ULL, 0x4b1c0b5ffe7bb00cULL, },
+        { 0x886be6cc28625571ULL, 0x4b1c0b5efe7bb00cULL, },
+        { 0x886ae6cc28625541ULL, 0x4b1c0b5efe7bb00cULL, },
+        { 0xfbaa00644862d541ULL, 0x121cbb1a153b52fcULL, },
+        { 0xfbbe00644862c741ULL, 0x121cbb1a153f52fcULL, },
+        { 0xfbbe00644d93c741ULL, 0x129cbb1a153f52fcULL, },
+        { 0xfbbe00604d93c709ULL, 0x129cbb1a153f52fcULL, },
+        { 0xac5eaea8ad93c709ULL, 0x279cc6feab2f2514ULL, },    /*  72  */
+        { 0xac5aaea8bd938b89ULL, 0x279cc6feab2b2514ULL, },
+        { 0xac5aaea8b9cf8b89ULL, 0x279cc6ffab2b2514ULL, },
+        { 0xac5aaea8b9cf8b81ULL, 0x279cc6ffab2b2514ULL, },
+        { 0x705a164859cf8b81ULL, 0x8d9c88d9a94be2a4ULL, },
+        { 0x704e164859cfe201ULL, 0x8d9c88d9a942e2a4ULL, },
+        { 0x704e16485e31e201ULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },    /*  80  */
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },    /*  88  */
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x704f164c5e31e24fULL, 0x8d9c88d8a942e2a4ULL, },
+        { 0x886ae6cc1e315540ULL, 0x4b640b58e942b2a4ULL, },    /*  96  */
+        { 0x886ae6cc1e315540ULL, 0x4b640b58e942b2a4ULL, },
+        { 0x886ae6cc1e315540ULL, 0x4b640b58e942b2a4ULL, },
+        { 0x886ae6cc1e315540ULL, 0x4b640b58e942b2a4ULL, },
+        { 0xfbaa00645e31d540ULL, 0x1364bb58094252a4ULL, },
+        { 0xfbaa00645e31d540ULL, 0x1364bb58094252a4ULL, },
+        { 0xfbaa00645e31d540ULL, 0x1364bb58094252a4ULL, },
+        { 0xfbaa00645e31d540ULL, 0x1364bb58094252a4ULL, },
+        { 0xac4aa8649e31d540ULL, 0x2364c6d8a94222a4ULL, },    /* 104  */
+        { 0xac4aa8649e31d540ULL, 0x2364c6d8a94222a4ULL, },
+        { 0xac4aa8649e31d540ULL, 0x2364c6d8a94222a4ULL, },
+        { 0xac4aa8649e31d540ULL, 0x2364c6d8a94222a4ULL, },
+        { 0x704a10645e31d540ULL, 0x8b6488d8a942e2a4ULL, },
+        { 0x704a10645e31d540ULL, 0x8b6488d8a942e2a4ULL, },
+        { 0x704a10645e31d540ULL, 0x8b6488d8a942e2a4ULL, },
+        { 0x704a10645e31d540ULL, 0x8b6488d8a942e2a4ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_H__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSL_H__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
new file mode 100644
index 0000000..21d6eec
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSL.W
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSL.W";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x8869c71c71c71c71ULL, 0x4b670b5ffe79c71cULL, },    /*  64  */
+        { 0x8869c71c28471c71ULL, 0x4b670b5ffe7bb00cULL, },
+        { 0x8869c71c28471c71ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x8869c71c28631c71ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbb9c71c28631c71ULL, 0x12f7bb1a153bb00cULL, },
+        { 0xfbb9c71c4de31c71ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbb9c71c4de31c71ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbdc71c4d931c71ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xac5dc71ccd931c71ULL, 0x27d8c6feab2f52fcULL, },    /*  72  */
+        { 0xac5dc71cb9931c71ULL, 0x27d8c6feab2b2514ULL, },
+        { 0xac5dc71cb9931c71ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac59c71cb9cf1c71ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x7049c71c39cf1c71ULL, 0x8df188d9a9432514ULL, },
+        { 0x7049c71c5e4f1c71ULL, 0x8df188d9a942e2a4ULL, },
+        { 0x7049c71c5e4f1c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },    /*  80  */
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },    /*  88  */
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704dc71c5e311c71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x886ae6cc28625c71ULL, 0x4b670b58f942e2a4ULL, },    /*  96  */
+        { 0x886ae6cc28625c71ULL, 0x4b670b58f942e2a4ULL, },
+        { 0x886ae6cc28625c71ULL, 0x4b670b58f942e2a4ULL, },
+        { 0x886ae6cc28625c71ULL, 0x4b670b58f942e2a4ULL, },
+        { 0xfbbae6cc4d93dc71ULL, 0x12f7bb581142e2a4ULL, },
+        { 0xfbbae6cc4d93dc71ULL, 0x12f7bb581142e2a4ULL, },
+        { 0xfbbae6cc4d93dc71ULL, 0x12f7bb581142e2a4ULL, },
+        { 0xfbbae6cc4d93dc71ULL, 0x12f7bb581142e2a4ULL, },
+        { 0xac5ae6ccb9cf9c71ULL, 0x27d8c6d8a942e2a4ULL, },    /* 104  */
+        { 0xac5ae6ccb9cf9c71ULL, 0x27d8c6d8a942e2a4ULL, },
+        { 0xac5ae6ccb9cf9c71ULL, 0x27d8c6d8a942e2a4ULL, },
+        { 0xac5ae6ccb9cf9c71ULL, 0x27d8c6d8a942e2a4ULL, },
+        { 0x704ae6cc5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704ae6cc5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704ae6cc5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+        { 0x704ae6cc5e31dc71ULL, 0x8df188d8a942e2a4ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSL_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSL_W__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
new file mode 100644
index 0000000..b1927c5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSR.B
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSR.B";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c72e60c70c21570ULL, 0xcb677bde7e7bc60cULL, },    /*  64  */
+        { 0x186ae60c68c25570ULL, 0xcb677bde7e7bc00cULL, },
+        { 0x086ae60c68625570ULL, 0x4b670b5e7e7bf00cULL, },
+        { 0x086ae60c28625540ULL, 0x4b670b5e7e7bf00cULL, },
+        { 0x096e800329634740ULL, 0x42f70b1a157ff01cULL, },
+        { 0x0b3e80030d63c740ULL, 0x42f70b1a153ff21cULL, },
+        { 0x1b3e80030d93c740ULL, 0x12f73b1a153fd21cULL, },
+        { 0x1bbe80234d93c708ULL, 0x12f73b1a153fd21cULL, },
+        { 0x1abaae2a4d97cb08ULL, 0x17d8367f2b3bd314ULL, },    /*  72  */
+        { 0x1cdaae2a799f8b08ULL, 0x17d8367f2b2bd514ULL, },
+        { 0x0cdaae2a79cf8b08ULL, 0x27d846ff2b2be514ULL, },
+        { 0x0c5aae2a39cf8b00ULL, 0x27d846ff2b2be514ULL, },
+        { 0x0c5f962d38c9a200ULL, 0x2df148d82922e400ULL, },
+        { 0x004f962d1ec1e200ULL, 0x2df148d82942e200ULL, },
+        { 0x104f962d1e31e200ULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },    /*  80  */
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },    /*  88  */
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x104f960d5e31e24eULL, 0x8df108d82942e200ULL, },
+        { 0x106ae60c2832e540ULL, 0x8bf309d82a43e000ULL, },    /*  96  */
+        { 0x106ae60c2832d540ULL, 0x8bf70bd82e4be000ULL, },
+        { 0x106ae60c2832d540ULL, 0x8b670bd87e4be000ULL, },
+        { 0x106ae60c2832d540ULL, 0x8b670bd87e4be000ULL, },
+        { 0x116e80032933c740ULL, 0x82f70bd8154fe000ULL, },
+        { 0x133e80032933c740ULL, 0x82f70bd8153fe000ULL, },
+        { 0x1b3e80032933c740ULL, 0x82f70bd8153fe000ULL, },
+        { 0x1b3e80032933c740ULL, 0x82f70bd8153fe000ULL, },
+        { 0x1c5a800a293f8b40ULL, 0x87d806d92b2be100ULL, },    /* 104  */
+        { 0x0c5a800a29cf8b40ULL, 0x27d846db2b2be100ULL, },
+        { 0x0c5a800a29cf8b40ULL, 0x27d846df2b2be100ULL, },
+        { 0x0c5a800a29cf8b40ULL, 0x27d846ff2b2be100ULL, },
+        { 0x105f800d2a318240ULL, 0x8dd908d82922e200ULL, },
+        { 0x104f800d2e318240ULL, 0x8dd908d82922e200ULL, },
+        { 0x104f800d5e318240ULL, 0x8dd908d82922e200ULL, },
+        { 0x104f800d5e318240ULL, 0x8dd908d82922e200ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_B(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_B(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_B__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSR_B__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
new file mode 100644
index 0000000..6499415
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSR.D
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSR.D";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c70ULL, 0xc71c71c71c71d00cULL, },    /*  64  */
+        { 0x1c71c71c71c71d40ULL, 0xcb670b5efe7bb00cULL, },
+        { 0x1c71c71c71c71d40ULL, 0xcb670b5efe7bb00cULL, },
+        { 0x1c71c71c71c75540ULL, 0xcb670b5efe7bb00cULL, },
+        { 0x1c71c71c71c75540ULL, 0xcb670b5efe7bb2fcULL, },
+        { 0x1c71c71c71c75508ULL, 0xd2f7bb1a153f52fcULL, },
+        { 0x1c71c71c71c75508ULL, 0xd2f7bb1a153f52fcULL, },
+        { 0x1c71c71c71c74708ULL, 0xd2f7bb1a153f52fcULL, },
+        { 0x1c71c71c71c74708ULL, 0xd2f7bb1a153f4514ULL, },    /*  72  */
+        { 0x1c71c71c71c74780ULL, 0xc7d8c6ffab2b2514ULL, },
+        { 0x1c71c71c71c74780ULL, 0xc7d8c6ffab2b2514ULL, },
+        { 0x1c71c71c71c70b80ULL, 0xc7d8c6ffab2b2514ULL, },
+        { 0x1c71c71c71c70b80ULL, 0xc7d8c6ffab2b22a0ULL, },
+        { 0x1c71c71c71c70a4eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c70a4eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },    /*  80  */
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },    /*  88  */
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c7624eULL, 0xcdf188d8a942e2a0ULL, },
+        { 0x1c71c71c71c75540ULL, 0xcdf188d8fe7bb00cULL, },    /*  96  */
+        { 0x1c71c71c71c75540ULL, 0xcdf188d8fe7bb00cULL, },
+        { 0x1c71c71c71c75540ULL, 0xcdf188d8fe7bb00cULL, },
+        { 0x1c71c71c71c75540ULL, 0xcdf188d8fe7bb00cULL, },
+        { 0x1c71c71c71c75540ULL, 0xcdf188d8fe7bb2fcULL, },
+        { 0x1c71c71c71c75540ULL, 0xd2f7bb1a153f52fcULL, },
+        { 0x1c71c71c71c75540ULL, 0xd2f7bb1a153f52fcULL, },
+        { 0x1c71c71c71c75540ULL, 0xd2f7bb1a153f52fcULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6ffab2b2514ULL, },    /* 104  */
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6ffab2b2514ULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6ffab2b2514ULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6ffab2b2514ULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6ffab22e2a0ULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6fea942e2a0ULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6fea942e2a0ULL, },
+        { 0x1c71c71c71c75540ULL, 0xc7d8c6fea942e2a0ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_D(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_D(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_D__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSR_D__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
new file mode 100644
index 0000000..2dc3dbe
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSR.H
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSR.H";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x186ac6cc71c21c70ULL, 0xc7670b5e1e7bd00cULL, },    /*  64  */
+        { 0x086ac6cc71c21d40ULL, 0xc7670b5efe7bd00cULL, },
+        { 0x086ac6cc28621d40ULL, 0xc7670b5efe7bd00cULL, },
+        { 0x886ae6cc28625540ULL, 0xc7670b5efe7bd00cULL, },
+        { 0x8bbee06328635540ULL, 0xc7f73b1af53fd2fcULL, },
+        { 0xfbbee06328635508ULL, 0xc7f73b1a153fd2fcULL, },
+        { 0xfbbee0634d935508ULL, 0xc6f7bb1a153fd2fcULL, },
+        { 0xfbbec0634d934708ULL, 0xc6f7bb1a153fd2fcULL, },
+        { 0xfc5aceaa4d974708ULL, 0xc6d8c6ff1b2bc514ULL, },    /*  72  */
+        { 0xac5aceaa4d9f4780ULL, 0xc6d8c6ffab2bc514ULL, },
+        { 0xac5aceaab9cf4780ULL, 0xc7d8c6ffab2bc514ULL, },
+        { 0xac5aeeaab9cf0b80ULL, 0xc7d8c6ffab2bc514ULL, },
+        { 0xa84ff64db9c90b80ULL, 0xc7f188d8a942c2a0ULL, },
+        { 0xf04ff64db9c10a4eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0xf04ff64d5e310a4eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },    /*  80  */
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },    /*  88  */
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e31624eULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x886ae6cc5e325540ULL, 0xc7f3895ea943c2a0ULL, },    /*  96  */
+        { 0x886ae6cc5e325540ULL, 0xc7f78b5ea94bc2a0ULL, },
+        { 0x886ae6cc5e325540ULL, 0xc7678b5eae7bc2a0ULL, },
+        { 0x886ae6cc5e325540ULL, 0xc7678b5eae7bc2a0ULL, },
+        { 0x8bbee0635e335540ULL, 0xc7f7bb1aa53fc2a0ULL, },
+        { 0xfbbee0635e335540ULL, 0xc7f7bb1a153fc2a0ULL, },
+        { 0xfbbee0635e335540ULL, 0xc7f7bb1a153fc2a0ULL, },
+        { 0xfbbee0635e335540ULL, 0xc7f7bb1a153fc2a0ULL, },
+        { 0xac5ae06a5e3f5540ULL, 0xc7d8beffab2bc2a0ULL, },    /* 104  */
+        { 0xac5ae6aab9cf5540ULL, 0xc7d8c6ffab2bc2a0ULL, },
+        { 0xac5ae6aab9cf5540ULL, 0xc7d8c6ffab2bc2a0ULL, },
+        { 0xac5ae6aab9cf5540ULL, 0xc7d8c6ffab2bc2a0ULL, },
+        { 0xa84fe64d5e315540ULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e315540ULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e315540ULL, 0xc7f188d8a942c2a0ULL, },
+        { 0x704fd64d5e315540ULL, 0xc7f188d8a942c2a0ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_H(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_H(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_H__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSR_H__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
new file mode 100644
index 0000000..5073187
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BINSR.W
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BINSR.W";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c6cc71c71c70ULL, 0xcb670b5e1c71d00cULL, },    /*  64  */
+        { 0x1c71c6cc71c71d40ULL, 0xcb670b5e1e7bb00cULL, },
+        { 0x1c71c6cc71c71d40ULL, 0x4b670b5e1e7bb00cULL, },
+        { 0x1c71e6cc71c75540ULL, 0x4b670b5e1e7bb00cULL, },
+        { 0x1c71e06371c75540ULL, 0x12f7bb1a1e7bb2fcULL, },
+        { 0x1c71e06371c75508ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x1c71e06371c75508ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x1c71c06371c74708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0x1c71ceaa71c74708ULL, 0x27d8c6ff153f4514ULL, },    /*  72  */
+        { 0x1c71ceaa71c74780ULL, 0x27d8c6ff0b2b2514ULL, },
+        { 0x1c71ceaa71c74780ULL, 0x27d8c6ff0b2b2514ULL, },
+        { 0x1c71eeaa71c70b80ULL, 0x27d8c6ff0b2b2514ULL, },
+        { 0x1c71f64d71c70b80ULL, 0x0df188d80b2b22a0ULL, },
+        { 0x1c71f64d71c70a4eULL, 0x0df188d80942e2a0ULL, },
+        { 0x1c71f64d71c70a4eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },    /*  80  */
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },    /*  88  */
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c7624eULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71e6cc71c75540ULL, 0x8d670b5e0942e2a0ULL, },    /*  96  */
+        { 0x1c71e6cc71c75540ULL, 0xcb670b5e0942e2a0ULL, },
+        { 0x1c71e6cc71c75540ULL, 0xcb670b5e0942e2a0ULL, },
+        { 0x1c71e6cc71c75540ULL, 0xcb670b5e0942e2a0ULL, },
+        { 0x1c71e06371c75540ULL, 0x92f7bb1a0942e2a0ULL, },
+        { 0x1c71e06371c75540ULL, 0x92f7bb1a0942e2a0ULL, },
+        { 0x1c71e06371c75540ULL, 0x92f7bb1a0942e2a0ULL, },
+        { 0x1c71e06371c75540ULL, 0x92f7bb1a0942e2a0ULL, },
+        { 0x1c71e06a71c75540ULL, 0x97d8c6ff0942e2a0ULL, },    /* 104  */
+        { 0x1c71e6aa71c75540ULL, 0x27d8c6ff0942e2a0ULL, },
+        { 0x1c71e6aa71c75540ULL, 0x27d8c6ff0942e2a0ULL, },
+        { 0x1c71e6aa71c75540ULL, 0x27d8c6ff0942e2a0ULL, },
+        { 0x1c71e64d71c75540ULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c75540ULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c75540ULL, 0x8df188d80942e2a0ULL, },
+        { 0x1c71d64d71c75540ULL, 0x8df188d80942e2a0ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_W(b128_pattern[i], b128_pattern[j],
+                           b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_W(b128_random[i], b128_random[j],
+                           b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                        (PATTERN_INPUTS_SHORT_COUNT)) +
+                                       RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BINSR_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_BINSR_W__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
new file mode 100644
index 0000000..ba1c635
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BMNZ.V
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BMNZ.V";
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
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x9c7be7dc79e75d71ULL, 0xcf7f7bdffe7bf71cULL, },    /*  64  */
+        { 0x8c6be7dc38665d71ULL, 0xcf6f4bdffe7bb50cULL, },
+        { 0x886be7dc28625571ULL, 0xcb670b5efe7bb00cULL, },
+        { 0x886ae7dc28625571ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x882a015008024531ULL, 0x02670b1a143b100cULL, },
+        { 0xfbbe01734d93c739ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe01734d93c739ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbbe01734d93c739ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xfbdea7bb6dd38339ULL, 0x13d0b25eab2f62f4ULL, },    /*  72  */
+        { 0xa85aa7ba29c38331ULL, 0x03d0825eab2b2014ULL, },
+        { 0xac5aafbab9cf8bb1ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0xac5aafbab9cf8bb1ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x245a0f7e99adcaf1ULL, 0x2df9ccf9a942a510ULL, },
+        { 0x744e0f5ddc3dcaf9ULL, 0x2df9ccf9a942e7a0ULL, },
+        { 0x704e075d5c31c279ULL, 0x0df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },    /*  80  */
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },    /*  88  */
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x704f175d5e31e27fULL, 0x8df188d8a942e2a0ULL, },
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },    /*  96  */
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },
+        { 0x000a004008004000ULL, 0x0061081800020000ULL, },
+        { 0x000a004008004000ULL, 0x0061081800020000ULL, },
+        { 0x000a004008004000ULL, 0x0061081800020000ULL, },
+        { 0x000a004008004000ULL, 0x0061081800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },    /* 104  */
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMNZ_V(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMNZ_V(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMNZ_V__DDT(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   ((RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMNZ_V__DSD(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
new file mode 100644
index 0000000..b38ddc2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BMZ.V
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BMZ.V";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  16  */
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },    /*  24  */
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },    /*  32  */
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },    /*  40  */
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },    /*  48  */
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },    /*  56  */
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x0860c60c20421440ULL, 0x430401461c71800cULL, },    /*  64  */
+        { 0x0860e68c20621440ULL, 0x4b040146fe71a00cULL, },
+        { 0x0860e6cc20625440ULL, 0x4b270946fe71b00cULL, },
+        { 0x8860e6cc20625540ULL, 0x4b270b46fe79b00cULL, },
+        { 0xfbf4e6ef65f3d748ULL, 0x5bb7bb46ff7df2fcULL, },
+        { 0xfbb400634593c708ULL, 0x12b7bb02153d52fcULL, },
+        { 0xfbb400634593c708ULL, 0x12b7bb02153d52fcULL, },
+        { 0xfbb400634593c708ULL, 0x12b7bb02153d52fcULL, },
+        { 0xac300862918fcf80ULL, 0x26bfcfa31539151cULL, },    /*  72  */
+        { 0xac70aeeab1cfcf80ULL, 0x27bfcfe7bf39351cULL, },
+        { 0xac50aeaab1cf8b80ULL, 0x2798c6e7ab292514ULL, },
+        { 0xac50aeaab1cf8b80ULL, 0x2798c6e7ab292514ULL, },
+        { 0xf845b6897653a30eULL, 0x879082c6ab2962a4ULL, },
+        { 0xf845160d5633a34eULL, 0x8f9082c2a969e2a4ULL, },
+        { 0xf845164d5633e34eULL, 0x8fb18ac2a969e2a4ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },    /*  80  */
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },    /*  88  */
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0x7045164d5631e24eULL, 0x8db188c0a940e2a0ULL, },
+        { 0xf86ff6cd7e73f74eULL, 0xcff78bdeff7bf2acULL, },    /*  96  */
+        { 0xf86ff6cd7e73f74eULL, 0xcff78bdeff7bf2acULL, },
+        { 0xf86ff6cd7e73f74eULL, 0xcff78bdeff7bf2acULL, },
+        { 0xf86ff6cd7e73f74eULL, 0xcff78bdeff7bf2acULL, },
+        { 0xfbfff6ef7ff3f74eULL, 0xdff7bbdeff7ff2fcULL, },
+        { 0xfbfff6ef7ff3f74eULL, 0xdff7bbdeff7ff2fcULL, },
+        { 0xfbfff6ef7ff3f74eULL, 0xdff7bbdeff7ff2fcULL, },
+        { 0xfbfff6ef7ff3f74eULL, 0xdff7bbdeff7ff2fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },    /* 104  */
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMZ_V(b128_pattern[i], b128_pattern[j],
+                         b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMZ_V(b128_random[i], b128_random[j],
+                         b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMZ_V__DDT(b128_random[i], b128_random[j],
+                              b128_result[
+                                  ((PATTERN_INPUTS_SHORT_COUNT) *
+                                   (PATTERN_INPUTS_SHORT_COUNT)) +
+                                  ((RANDOM_INPUTS_SHORT_COUNT) *
+                                   (RANDOM_INPUTS_SHORT_COUNT)) +
+                                  RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BMZ_V__DSD(b128_random[i], b128_random[j],
+                              b128_result[
+                                  ((PATTERN_INPUTS_SHORT_COUNT) *
+                                   (PATTERN_INPUTS_SHORT_COUNT)) +
+                                  (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                   (RANDOM_INPUTS_SHORT_COUNT)) +
+                                  RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c
new file mode 100644
index 0000000..062e5a2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c
@@ -0,0 +1,214 @@
+/*
+ *  Test program for MSA instruction BSEL.V
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
+    char *group_name = "Bit Move";
+    char *instruction_name =  "BSEL.V";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0xeeeeeeeeeeeeeeeeULL, 0xeeeeeeeeeeeeeeeeULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0xefcefcefcefcefceULL, 0xfcefcefcefcefcefULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*   8  */
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
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xaaaaaaaaaaaaaaaaULL, 0xaaaaaaaaaaaaaaaaULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0xaa8aa8aa8aa8aa8aULL, 0xa8aa8aa8aa8aa8aaULL, },
+        { 0x0820820820820820ULL, 0x8208208208208208ULL, },
+        { 0x5d75d75d75d75d75ULL, 0xd75d75d75d75d75dULL, },    /*  24  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x5555555555555555ULL, 0x5555555555555555ULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x4544544544544544ULL, 0x5445445445445445ULL, },
+        { 0x1451451451451451ULL, 0x4514514514514514ULL, },
+        { 0xdcddcddcddcddcddULL, 0xcddcddcddcddcddcULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x4444444444444444ULL, 0x4444444444444444ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xccccccccccccccccULL, 0xccccccccccccccccULL, },
+        { 0x0c40c40c40c40c40ULL, 0xc40c40c40c40c40cULL, },
+        { 0x3f73f73f73f73f73ULL, 0xf73f73f73f73f73fULL, },    /*  40  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x1111111111111111ULL, 0x1111111111111111ULL, },
+        { 0x2222222222222222ULL, 0x2222222222222222ULL, },
+        { 0x3333333333333333ULL, 0x3333333333333333ULL, },
+        { 0x2302302302302302ULL, 0x3023023023023023ULL, },
+        { 0x1031031031031031ULL, 0x0310310310310310ULL, },
+        { 0xf3bf3bf3bf3bf3bfULL, 0x3bf3bf3bf3bf3bf3ULL, },    /*  48  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x4104104104104104ULL, 0x1041041041041041ULL, },
+        { 0xe28e28e28e28e28eULL, 0x28e28e28e28e28e2ULL, },
+        { 0x2302302302302302ULL, 0x3023023023023023ULL, },
+        { 0xe38e38e38e38e38eULL, 0x38e38e38e38e38e3ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },    /*  56  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x1451451451451451ULL, 0x4514514514514514ULL, },
+        { 0x0c60c60c60c60c60ULL, 0xc60c60c60c60c60cULL, },
+        { 0x1031031031031031ULL, 0x0310310310310310ULL, },
+        { 0x0c40c40c40c40c40ULL, 0xc40c40c40c40c40cULL, },
+        { 0x1c71c71c71c71c71ULL, 0xc71c71c71c71c71cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  64  */
+        { 0x882a004008024500ULL, 0x02670b1a143b100cULL, },
+        { 0x884ae68c28621140ULL, 0x4b40025eea6ba004ULL, },
+        { 0x006a064c08204440ULL, 0x09670958bc52b008ULL, },
+        { 0xfbfe066f4db3c748ULL, 0x1bf7bb5abd7ff2fcULL, },
+        { 0xfbbe00634d93c708ULL, 0x12f7bb1a153f52fcULL, },
+        { 0xa81a002209838300ULL, 0x02d0821a012b0014ULL, },
+        { 0x73ae00414c11c608ULL, 0x10f7b918151652e8ULL, },
+        { 0x8c7aaeeab9ce4d80ULL, 0x276f4fffbe3b351cULL, },    /*  72  */
+        { 0xa83a00620983c700ULL, 0x02f78b1a153b101cULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x204a060818018200ULL, 0x05d080d8a9022000ULL, },
+        { 0x504f164d4e30604eULL, 0x89610858a842e2a0ULL, },
+        { 0x700e00415c11c208ULL, 0x04f18898010242a0ULL, },
+        { 0x204b160c1a21a246ULL, 0x8dd080d8a942a000ULL, },
+        { 0x704f164d5e31e24eULL, 0x8df188d8a942e2a0ULL, },
+        { 0x004a064c08204040ULL, 0x09610858a842a000ULL, },    /*  80  */
+        { 0x000a004008004000ULL, 0x0061081800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },    /*  88  */
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x000a000008000000ULL, 0x0040001800020000ULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },    /*  96  */
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0x886ae6cc28625540ULL, 0x4b670b5efe7bb00cULL, },
+        { 0xfbfee6ef6df3d748ULL, 0x5bf7bb5eff7ff2fcULL, },
+        { 0xfbfee6ef6df3d748ULL, 0x5bf7bb5eff7ff2fcULL, },
+        { 0xfbfee6ef6df3d748ULL, 0x5bf7bb5eff7ff2fcULL, },
+        { 0xfbfee6ef6df3d748ULL, 0x5bf7bb5eff7ff2fcULL, },
+        { 0xfffeeeeffdffdfc8ULL, 0x7fffffffff7ff7fcULL, },    /* 104  */
+        { 0xfffeeeeffdffdfc8ULL, 0x7fffffffff7ff7fcULL, },
+        { 0xfffeeeeffdffdfc8ULL, 0x7fffffffff7ff7fcULL, },
+        { 0xfffeeeeffdffdfc8ULL, 0x7fffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+        { 0xfffffeefffffffceULL, 0xffffffffff7ff7fcULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSEL_V(b128_pattern[i], b128_pattern[j],
+                          b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSEL_V(b128_random[i], b128_random[j],
+                          b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                       (PATTERN_INPUTS_SHORT_COUNT)) +
+                                      RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSEL_V__DDT(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   ((RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_BSEL_V__DSD(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
index 2a39d89..37a4fdc 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile.sh
@@ -32,6 +32,28 @@
 # Bit move
 # --------
 #
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsl_b
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsl_h
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsl_w
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsl_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsl_d
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_b.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsr_b
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsr_h
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsr_w
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_binsr_d.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_binsr_d
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmnz_v.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_bmnz_v
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bmz_v.c          \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_bmz_v
+/opt/img/bin/mips-img-linux-gnu-gcc         bit-move/test_msa_bsel_v.c         \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o   /tmp/test_msa_bsel_v
 
 #
 # Bit Set
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run.sh b/tests/tcg/mips/user/ase/msa/test_msa_run.sh
index 278d93b..6c244a2 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run.sh
@@ -22,6 +22,17 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_pcnt_d
 # Bit move
 # --------
 #
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsl_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_b
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_h
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_w
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_binsr_d
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmnz_v
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bmz_v
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bsel_v
 
 #
 # Bit Set
-- 
2.7.4


