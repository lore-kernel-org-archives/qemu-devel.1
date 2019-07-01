Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F77C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C05206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C05206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuEW-0002ek-PY
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hhu8N-000551-QA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hhu8D-00076t-7I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:06:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48942 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hhu8C-00067O-DN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:05:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 6D0CC1A1FF7;
 Mon,  1 Jul 2019 13:04:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 28A1F1A1E8D;
 Mon,  1 Jul 2019 13:04:51 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	arikalo@wavecomp.com
Date: Mon,  1 Jul 2019 13:04:34 +0200
Message-Id: <1561979080-26195-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 1/7] tcg/tests: target/mips: Amend MSA fixed
 point multiply tests
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Amend MSA fixed point multiply tests: add tests for MADD_Q.H, MADD_Q.W,
MADDR_Q.H, MADDR_Q.W, MSUB_Q.H, MSUB_Q.W, MSUBR_Q.H and MSUBR_Q.W.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h              |  16 ++
 .../ase/msa/fixed-multiply/test_msa_madd_q_h.c     | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_madd_q_w.c     | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_maddr_q_h.c    | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_maddr_q_w.c    | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msub_q_h.c     | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msub_q_w.c     | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msubr_q_h.c    | 216 +++++++++++++++++++++
 .../ase/msa/fixed-multiply/test_msa_msubr_q_w.c    | 216 +++++++++++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   |  16 ++
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   |  16 ++
 .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   |  16 ++
 .../mips/user/ase/msa/test_msa_compile_64r6el.sh   |  16 ++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh |   8 +
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh |   8 +
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh |   8 +
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh |   8 +
 17 files changed, 1840 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index b512b1d..4be7821 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -252,16 +252,32 @@ DO_MSA__WD__WS_WT(BNEG_D, bneg.d)
  */
 
 DO_MSA__WD__WS_WT(MADD_Q_H, madd_q.h)
+DO_MSA__WD__WD_WT(MADD_Q_H__DDT, madd_q.h)
+DO_MSA__WD__WS_WD(MADD_Q_H__DSD, madd_q.h)
 DO_MSA__WD__WS_WT(MADD_Q_W, madd_q.w)
+DO_MSA__WD__WD_WT(MADD_Q_W__DDT, madd_q.w)
+DO_MSA__WD__WS_WD(MADD_Q_W__DSD, madd_q.w)
 
 DO_MSA__WD__WS_WT(MADDR_Q_H, maddr_q.h)
+DO_MSA__WD__WD_WT(MADDR_Q_H__DDT, maddr_q.h)
+DO_MSA__WD__WS_WD(MADDR_Q_H__DSD, maddr_q.h)
 DO_MSA__WD__WS_WT(MADDR_Q_W, maddr_q.w)
+DO_MSA__WD__WD_WT(MADDR_Q_W__DDT, maddr_q.w)
+DO_MSA__WD__WS_WD(MADDR_Q_W__DSD, maddr_q.w)
 
 DO_MSA__WD__WS_WT(MSUB_Q_H, msub_q.h)
+DO_MSA__WD__WD_WT(MSUB_Q_H__DDT, msub_q.h)
+DO_MSA__WD__WS_WD(MSUB_Q_H__DSD, msub_q.h)
 DO_MSA__WD__WS_WT(MSUB_Q_W, msub_q.w)
+DO_MSA__WD__WD_WT(MSUB_Q_W__DDT, msub_q.w)
+DO_MSA__WD__WS_WD(MSUB_Q_W__DSD, msub_q.w)
 
 DO_MSA__WD__WS_WT(MSUBR_Q_H, msubr_q.h)
+DO_MSA__WD__WD_WT(MSUBR_Q_H__DDT, msubr_q.h)
+DO_MSA__WD__WS_WD(MSUBR_Q_H__DSD, msubr_q.h)
 DO_MSA__WD__WS_WT(MSUBR_Q_W, msubr_q.w)
+DO_MSA__WD__WD_WT(MSUBR_Q_W__DDT, msubr_q.w)
+DO_MSA__WD__WS_WD(MSUBR_Q_W__DSD, msubr_q.w)
 
 DO_MSA__WD__WS_WT(MUL_Q_H, mul_q.h)
 DO_MSA__WD__WS_WT(MUL_Q_W, mul_q.w)
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
new file mode 100644
index 0000000..29a2990
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MADD_Q.H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MADD_Q.H";
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xfffefffdfffefffeULL, 0xfffdfffefffefffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },    /*   8  */
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },    /*  16  */
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0x38e138e138e138e1ULL, 0x38e138e138e138e1ULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0x221f221f221f221fULL, 0x221f221f221f221fULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0x12f2da0f4bd712f2ULL, 0xda0f4bd712f2da0fULL, },
+        { 0xfffbfffcfffcfffbULL, 0xfffcfffcfffbfffcULL, },
+        { 0xfffafffbfffbfffaULL, 0xfffbfffbfffafffbULL, },    /*  24  */
+        { 0xfffafffbfffbfffaULL, 0xfffbfffbfffafffbULL, },
+        { 0xc716c717c717c716ULL, 0xc717c717c716c717ULL, },
+        { 0xfff9fffafffafff9ULL, 0xfffafffafff9fffaULL, },
+        { 0xddd6ddd7ddd7ddd6ULL, 0xddd7ddd7ddd6ddd7ULL, },
+        { 0xfff7fff8fff8fff7ULL, 0xfff8fff8fff7fff8ULL, },
+        { 0xed0025e4b41ded00ULL, 0x25e4b41ded0025e4ULL, },
+        { 0xfff5fff6fff6fff5ULL, 0xfff6fff6fff5fff6ULL, },
+        { 0xfff5fff6fff6fff5ULL, 0xfff6fff6fff5fff6ULL, },    /*  32  */
+        { 0xfff5fff6fff6fff5ULL, 0xfff6fff6fff5fff6ULL, },
+        { 0x2217221822182217ULL, 0x2218221822172218ULL, },
+        { 0xfff4fff5fff5fff4ULL, 0xfff5fff5fff4fff5ULL, },
+        { 0x146f14701470146fULL, 0x14701470146f1470ULL, },
+        { 0xfff3fff4fff4fff3ULL, 0xfff4fff4fff3fff4ULL, },
+        { 0x0b53e9322d770b53ULL, 0xe9322d770b53e932ULL, },
+        { 0xfff2fff3fff3fff2ULL, 0xfff3fff3fff2fff3ULL, },
+        { 0xfff1fff2fff2fff1ULL, 0xfff2fff2fff1fff2ULL, },    /*  40  */
+        { 0xfff1fff2fff2fff1ULL, 0xfff2fff2fff1fff2ULL, },
+        { 0xddceddcfddcfddceULL, 0xddcfddcfddceddcfULL, },
+        { 0xffeffff0fff0ffefULL, 0xfff0fff0ffeffff0ULL, },
+        { 0xeb73eb74eb74eb73ULL, 0xeb74eb74eb73eb74ULL, },
+        { 0xffedffeeffeeffedULL, 0xffeeffeeffedffeeULL, },
+        { 0xf48c16afd26af48cULL, 0x16afd26af48c16afULL, },
+        { 0xffecffedffecffecULL, 0xffedffecffecffedULL, },
+        { 0xffecffecffecffecULL, 0xffecffecffecffecULL, },    /*  48  */
+        { 0xffecffecffecffecULL, 0xffecffecffecffecULL, },
+        { 0x12e2d9ff4bc712e2ULL, 0xd9ff4bc712e2d9ffULL, },
+        { 0xffebffebffecffebULL, 0xffebffecffebffebULL, },
+        { 0x0b4be9292d6f0b4bULL, 0xe9292d6f0b4be929ULL, },
+        { 0xffeaffeaffebffeaULL, 0xffeaffebffeaffeaULL, },
+        { 0x063c1932650f063cULL, 0x1932650f063c1932ULL, },
+        { 0xffe9ffe9ffebffe9ULL, 0xffe9ffebffe9ffe9ULL, },
+        { 0xffe8ffe9ffeaffe8ULL, 0xffe9ffeaffe8ffe9ULL, },    /*  56  */
+        { 0xffe8ffe9ffeaffe8ULL, 0xffe9ffeaffe8ffe9ULL, },
+        { 0xecf125d6b40fecf1ULL, 0x25d6b40fecf125d6ULL, },
+        { 0xffe6ffe8ffe8ffe6ULL, 0xffe8ffe8ffe6ffe8ULL, },
+        { 0xf48516a9d264f485ULL, 0x16a9d264f48516a9ULL, },
+        { 0xffe5ffe7ffe6ffe5ULL, 0xffe7ffe6ffe5ffe7ULL, },
+        { 0xf992e69e9ac2f992ULL, 0xe69e9ac2f992e69eULL, },
+        { 0xffe3ffe7ffe4ffe3ULL, 0xffe7ffe4ffe3ffe7ULL, },
+        { 0x6f9c04dd0ca138aaULL, 0x2c5200e6ffe731d8ULL, },    /*  64  */
+        { 0x739604c9251a12b8ULL, 0x377dfac7ffa6fe02ULL, },
+        { 0x7fff14cc0ef4c520ULL, 0x4ef5f5b700a7e6d8ULL, },
+        { 0x171110672cabb158ULL, 0x0bc4eb2201aef931ULL, },
+        { 0x1b0b105345248b66ULL, 0x16efe503016dc55bULL, },
+        { 0x1b2f10537427a4c0ULL, 0x19be0a1804f3fb27ULL, },
+        { 0x1df71014499cd899ULL, 0x1fa528c6f6de1330ULL, },
+        { 0x1a3a10257fffe5d0ULL, 0x0ebe68e9e8780024ULL, },
+        { 0x6860202869d99838ULL, 0x263663d9e979e8faULL, },    /*  72  */
+        { 0x6b281fe93f4ecc11ULL, 0x2c1d7fffdb640103ULL, },
+        { 0x7fff539865cb3619ULL, 0x38847fff139c0bc0ULL, },
+        { 0x369a456c32245120ULL, 0x15027fff4d19033dULL, },
+        { 0xcdac41074fdb3d58ULL, 0xd1d1756a4e201596ULL, },
+        { 0xc9ef41187fff4a8fULL, 0xc0ea7fff3fba028aULL, },
+        { 0x808a32ec4c586596ULL, 0x9d687fff7937fa07ULL, },
+        { 0xe31436ce7fff6c79ULL, 0x030a7fff7fff00c4ULL, },
+        { 0xfe192c037fff7fffULL, 0x04d47fff7e7a0049ULL, },    /*  80  */
+        { 0xfe292c257fff4707ULL, 0x058b3b197fff0078ULL, },
+        { 0xff5c101739ce0661ULL, 0x074420c72b2a009aULL, },
+        { 0xfecc12e4645704e6ULL, 0x00ca02430de90076ULL, },
+        { 0xffeb0f2b7fff0829ULL, 0x014002760dbe002cULL, },
+        { 0xffeb0f367fff0487ULL, 0x016f012210050048ULL, },
+        { 0xfff8058b39ce0068ULL, 0x01e100a00567005cULL, },
+        { 0xfff006826457004fULL, 0x0034000b01bd0046ULL, },
+        { 0xfffe05397fff0083ULL, 0x0052000b01b7001aULL, },    /*  88  */
+        { 0xfffe053d7fff0048ULL, 0x005e000501ff002aULL, },
+        { 0xffff01e839ce0006ULL, 0x007b000200ac0036ULL, },
+        { 0xfffe023d64570004ULL, 0x000d000000370029ULL, },
+        { 0xffff01cc7fff0006ULL, 0x001400000036000fULL, },
+        { 0xffff01cd7fff0003ULL, 0x00160000003e0018ULL, },
+        { 0xffff00a839ce0000ULL, 0x001c00000014001eULL, },
+        { 0xfffe00c564570000ULL, 0x0003000000060017ULL, },
+        { 0xffff009e7fff0000ULL, 0x0004000000050008ULL, },    /*  96  */
+        { 0xffff007e7fff0000ULL, 0x0006000000040003ULL, },
+        { 0xffff00657fff0000ULL, 0x0009000000030001ULL, },
+        { 0xffff00517fff0000ULL, 0x000e000000020000ULL, },
+        { 0xffff00517fff0000ULL, 0x0010000000020000ULL, },
+        { 0xffff00517fff0000ULL, 0x0012000000020000ULL, },
+        { 0xffff00517fff0000ULL, 0x0014000000020000ULL, },
+        { 0xffff00517fff0000ULL, 0x0016000000020000ULL, },
+        { 0xffff001d39ce0000ULL, 0x001c000000000000ULL, },    /* 104  */
+        { 0xffff000a1a1b0000ULL, 0x0024000000000000ULL, },
+        { 0xffff00030bca0000ULL, 0x002f000000000000ULL, },
+        { 0xffff000105530000ULL, 0x003d000000000000ULL, },
+        { 0xfffe0001093d0000ULL, 0x0006000000000000ULL, },
+        { 0xfffc000110090000ULL, 0x0000000000000000ULL, },
+        { 0xfff800011bd50000ULL, 0x0000000000000000ULL, },
+        { 0xfff0000130500000ULL, 0x0000000000000000ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_H(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_H(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_H__DDT(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     ((RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_H__DSD(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
new file mode 100644
index 0000000..529d60d
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MADD_Q.W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MADD_Q.W";
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xfffffffefffffffeULL, 0xfffffffdfffffffeULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },    /*   8  */
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },    /*  16  */
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0x38e38e3638e38e36ULL, 0x38e38e3638e38e36ULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0x2222221e2222221eULL, 0x2222221e2222221eULL, },
+        { 0xfffffffbfffffffbULL, 0xfffffffbfffffffbULL, },
+        { 0x12f684b94bda12f2ULL, 0xda12f68012f684b9ULL, },
+        { 0xfffffffbfffffffbULL, 0xfffffffbfffffffbULL, },
+        { 0xfffffffafffffffaULL, 0xfffffffafffffffaULL, },    /*  24  */
+        { 0xfffffffafffffffaULL, 0xfffffffafffffffaULL, },
+        { 0xc71c71c0c71c71c0ULL, 0xc71c71c0c71c71c0ULL, },
+        { 0xfffffff8fffffff8ULL, 0xfffffff8fffffff8ULL, },
+        { 0xddddddd5ddddddd5ULL, 0xddddddd5ddddddd5ULL, },
+        { 0xfffffff6fffffff6ULL, 0xfffffff6fffffff6ULL, },
+        { 0xed097b38b425ecffULL, 0x25ed0970ed097b38ULL, },
+        { 0xfffffff5fffffff4ULL, 0xfffffff4fffffff5ULL, },
+        { 0xfffffff5fffffff4ULL, 0xfffffff4fffffff5ULL, },    /*  32  */
+        { 0xfffffff5fffffff4ULL, 0xfffffff4fffffff5ULL, },
+        { 0x2222221722222216ULL, 0x2222221622222217ULL, },
+        { 0xfffffff4fffffff3ULL, 0xfffffff3fffffff4ULL, },
+        { 0x147ae13c147ae13bULL, 0x147ae13b147ae13cULL, },
+        { 0xfffffff4fffffff3ULL, 0xfffffff3fffffff4ULL, },
+        { 0x0b60b5ff2d82d821ULL, 0xe93e93dc0b60b5ffULL, },
+        { 0xfffffff3fffffff3ULL, 0xfffffff3fffffff3ULL, },
+        { 0xfffffff2fffffff2ULL, 0xfffffff2fffffff2ULL, },    /*  40  */
+        { 0xfffffff2fffffff2ULL, 0xfffffff2fffffff2ULL, },
+        { 0xddddddcfddddddcfULL, 0xddddddcfddddddcfULL, },
+        { 0xfffffff0fffffff0ULL, 0xfffffff0fffffff0ULL, },
+        { 0xeb851ea8eb851ea8ULL, 0xeb851ea8eb851ea8ULL, },
+        { 0xffffffefffffffefULL, 0xffffffefffffffefULL, },
+        { 0xf49f49e3d27d27c1ULL, 0x16c16c05f49f49e3ULL, },
+        { 0xffffffeeffffffeeULL, 0xffffffeeffffffeeULL, },
+        { 0xffffffeeffffffeeULL, 0xffffffedffffffeeULL, },    /*  48  */
+        { 0xffffffeeffffffeeULL, 0xffffffedffffffeeULL, },
+        { 0x12f684ac4bda12e5ULL, 0xda12f67212f684acULL, },
+        { 0xffffffeeffffffeeULL, 0xffffffecffffffeeULL, },
+        { 0x0b60b5f92d82d81cULL, 0xe93e93d50b60b5f9ULL, },
+        { 0xffffffedffffffeeULL, 0xffffffebffffffedULL, },
+        { 0x06522c2c6522c3e1ULL, 0x1948b0e706522c2cULL, },
+        { 0xffffffecffffffeeULL, 0xffffffeaffffffecULL, },
+        { 0xffffffebffffffedULL, 0xffffffeaffffffebULL, },    /*  56  */
+        { 0xffffffebffffffedULL, 0xffffffeaffffffebULL, },
+        { 0xed097b2db425ecf6ULL, 0x25ed0965ed097b2dULL, },
+        { 0xffffffeaffffffebULL, 0xffffffe9ffffffeaULL, },
+        { 0xf49f49ded27d27bdULL, 0x16c16c00f49f49deULL, },
+        { 0xffffffe9ffffffeaULL, 0xffffffe9ffffffe9ULL, },
+        { 0xf9add3a99add3bf7ULL, 0xe6b74eecf9add3a9ULL, },
+        { 0xffffffe8ffffffe8ULL, 0xffffffe8ffffffe8ULL, },
+        { 0x6fb7e8710cbdc0baULL, 0x2c6b142e000499ecULL, },    /*  64  */
+        { 0x73b239bf253787bbULL, 0x379780d7ffc424b2ULL, },
+        { 0x7fffffff0f12777aULL, 0x4f10996a00c57ee6ULL, },
+        { 0x1713a7162cca6b1fULL, 0x0be04dd301cca255ULL, },
+        { 0x1b0df86445443220ULL, 0x170cba7c018c2d1bULL, },
+        { 0x1b323a657448a831ULL, 0x19dc4690051313a9ULL, },
+        { 0x1dfa85ec49be7952ULL, 0x1fc3e11af6fe2ffbULL, },
+        { 0x1a3e24c87fffffffULL, 0x0edd19b6e8983fd8ULL, },
+        { 0x6863454e69daefbeULL, 0x26563249e9999a0cULL, },    /*  72  */
+        { 0x6b2b90d53f50c0dfULL, 0x2c3dccd3db84b65eULL, },
+        { 0x7fffffff65cdd2a2ULL, 0x38a5553713bd77aaULL, },
+        { 0x369baa383226e26fULL, 0x1523c32e4d39d083ULL, },
+        { 0xcdaf514f4fded614ULL, 0xd1f377974e40f3f2ULL, },
+        { 0xc9f2f02b7fffffffULL, 0xc10cb0333fdb03cfULL, },
+        { 0x808e9a644c590fccULL, 0x9d8b1e2a79575ca8ULL, },
+        { 0xe31932487fffffffULL, 0x032ce40b7fffffffULL, },
+        { 0xfe196fe57fffffffULL, 0x050bc0117e7bb00bULL, },    /*  80  */
+        { 0xfe299f467fffffffULL, 0x05cb2b207fffffffULL, },
+        { 0xff5d018239cf8b7fULL, 0x0798e21e2b2b2513ULL, },
+        { 0xfecdfe1e645a7d99ULL, 0x00d3dcf00dea608dULL, },
+        { 0xffebe0507fffffffULL, 0x0150aaf30dc02967ULL, },
+        { 0xffec8bad7fffffffULL, 0x01828e9310087db0ULL, },
+        { 0xfff9423b39cf8b7fULL, 0x01fae4ad056841b8ULL, },
+        { 0xfff35804645a7d99ULL, 0x003737ba01be3861ULL, },
+        { 0xffff2aee7fffffffULL, 0x0057bed401b8eeafULL, },    /*  88  */
+        { 0xffff32047fffffffULL, 0x0064bf7c02021ffbULL, },
+        { 0xffffb89f39cf8b7fULL, 0x00841c7300ad6409ULL, },
+        { 0xffff79fe645a7d99ULL, 0x000e642e0037e4a5ULL, },
+        { 0xfffff72f7fffffffULL, 0x0016de7600373b15ULL, },
+        { 0xfffff77a7fffffffULL, 0x001a420100406619ULL, },
+        { 0xfffffd0b39cf8b7fULL, 0x00226e950015b801ULL, },
+        { 0xfffffa72645a7d99ULL, 0x0003c03400070049ULL, },
+        { 0xffffffa27fffffffULL, 0x0005f5d70006eb0bULL, },    /*  96  */
+        { 0xfffffff97fffffffULL, 0x000978af0006d60eULL, },
+        { 0xffffffff7fffffffULL, 0x000f0d050006c150ULL, },
+        { 0xffffffff7fffffffULL, 0x0017eac30006acd1ULL, },
+        { 0xffffffff7fffffffULL, 0x001b76100007c878ULL, },
+        { 0xffffffff7fffffffULL, 0x001f87d000091335ULL, },
+        { 0xffffffff7fffffffULL, 0x002433ef000a94d9ULL, },
+        { 0xffffffff7fffffffULL, 0x0029914d000c5680ULL, },
+        { 0xffffffff39cf8b7fULL, 0x003681f800042937ULL, },    /* 104  */
+        { 0xffffffff1a1c28c3ULL, 0x004779e10001673fULL, },
+        { 0xffffffff0bcae025ULL, 0x005dba1000007928ULL, },
+        { 0xffffffff055376c1ULL, 0x007ae77c000028dcULL, },
+        { 0xfffffffe093ed554ULL, 0x000d636d00000d2bULL, },
+        { 0xfffffffc100c9463ULL, 0x0001755c0000043eULL, },
+        { 0xfffffff81bdc128cULL, 0x000028ab0000015eULL, },
+        { 0xfffffff0305c8babULL, 0x0000046e00000070ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_W(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_W(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_W__DDT(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     ((RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADD_Q_W__DSD(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
new file mode 100644
index 0000000..a4713f2
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MADDR_Q.H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MADDR_Q.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },    /*  16  */
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x38e538e538e538e5ULL, 0x38e538e538e538e5ULL, },
+        { 0x0001000100010001ULL, 0x0001000100010001ULL, },
+        { 0x2224222422242224ULL, 0x2224222422242224ULL, },
+        { 0x0002000200020002ULL, 0x0002000200020002ULL, },
+        { 0x12f9da154bdd12f9ULL, 0xda154bdd12f9da15ULL, },
+        { 0x0003000300020003ULL, 0x0003000200030003ULL, },
+        { 0x0002000200010002ULL, 0x0002000100020002ULL, },    /*  24  */
+        { 0x0002000200010002ULL, 0x0002000100020002ULL, },
+        { 0xc71ec71ec71dc71eULL, 0xc71ec71dc71ec71eULL, },
+        { 0x0001000100000001ULL, 0x0001000000010001ULL, },
+        { 0xdddedddedddddddeULL, 0xdddedddddddedddeULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
+        { 0xed0925edb425ed09ULL, 0x25edb425ed0925edULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },    /*  32  */
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x2222222322222222ULL, 0x2223222222222223ULL, },
+        { 0xffff0000ffffffffULL, 0x0000ffffffff0000ULL, },
+        { 0x147b147c147b147bULL, 0x147c147b147b147cULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0x0b61e93f2d840b61ULL, 0xe93f2d840b61e93fULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },    /*  40  */
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0xdddedddfdddedddeULL, 0xdddfdddedddedddfULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0xeb85eb86eb85eb85ULL, 0xeb86eb85eb85eb86ULL, },
+        { 0x0000000100000000ULL, 0x0001000000000001ULL, },
+        { 0xf49f16c2d27df49fULL, 0x16c2d27df49f16c2ULL, },
+        { 0xffff00000000ffffULL, 0x00000000ffff0000ULL, },
+        { 0xffff00000001ffffULL, 0x00000001ffff0000ULL, },    /*  48  */
+        { 0xffff00000001ffffULL, 0x00000001ffff0000ULL, },
+        { 0x12f6da134bdc12f6ULL, 0xda134bdc12f6da13ULL, },
+        { 0xffff00000002ffffULL, 0x00000002ffff0000ULL, },
+        { 0x0b60e93e2d860b60ULL, 0xe93e2d860b60e93eULL, },
+        { 0xffffffff0003ffffULL, 0xffff0003ffffffffULL, },
+        { 0x0651194765270651ULL, 0x1947652706511947ULL, },
+        { 0xfffffffe0004ffffULL, 0xfffe0004fffffffeULL, },
+        { 0xfffffffe0003ffffULL, 0xfffe0003fffffffeULL, },    /*  56  */
+        { 0xfffffffe0003ffffULL, 0xfffe0003fffffffeULL, },
+        { 0xed0925ecb428ed09ULL, 0x25ecb428ed0925ecULL, },
+        { 0xffffffff0002ffffULL, 0xffff0002ffffffffULL, },
+        { 0xf49e16c1d27ef49eULL, 0x16c1d27ef49e16c1ULL, },
+        { 0xfffeffff0001fffeULL, 0xffff0001fffeffffULL, },
+        { 0xf9ace6b69adef9acULL, 0xe6b69adef9ace6b6ULL, },
+        { 0xfffeffff0001fffeULL, 0xffff0001fffeffffULL, },
+        { 0x6fb804f50cbf38c5ULL, 0x2c6a0103000331f0ULL, },    /*  64  */
+        { 0x73b204e2253812d4ULL, 0x3796fae5ffc2fe1aULL, },
+        { 0x7fff14e60f13c53dULL, 0x4f0ff5d500c4e6f1ULL, },
+        { 0x171210822ccab176ULL, 0x0bdeeb4001ccf94aULL, },
+        { 0x1b0c106f45438b85ULL, 0x170ae522018bc574ULL, },
+        { 0x1b30106f7447a4e0ULL, 0x19d90a380512fb41ULL, },
+        { 0x1df8103049bdd8baULL, 0x1fc028e7f6fd134bULL, },
+        { 0x1a3c10417fffe5f1ULL, 0x0eda690ae8970040ULL, },
+        { 0x6862204569da985aULL, 0x265363fae999e917ULL, },    /*  72  */
+        { 0x6b2a20063f50cc34ULL, 0x2c3a7fffdb840121ULL, },
+        { 0x7fff53b565ce363dULL, 0x38a17fff13bd0bdfULL, },
+        { 0x369a458932275144ULL, 0x15207fff4d3a035dULL, },
+        { 0xcdad41254fde3d7dULL, 0xd1ef756a4e4215b6ULL, },
+        { 0xc9f141367fff4ab4ULL, 0xc1097fff3fdc02abULL, },
+        { 0x808c330a4c5865bbULL, 0x9d887fff7959fa29ULL, },
+        { 0xe31636ed7fff6c9fULL, 0x032b7fff7fff00e7ULL, },
+        { 0xfe192c1c7fff7fffULL, 0x05097fff7e7a0057ULL, },    /*  80  */
+        { 0xfe292c3e7fff4707ULL, 0x05c83b1a7fff008fULL, },
+        { 0xff5d102139cf0662ULL, 0x079520c82b2b00b8ULL, },
+        { 0xfece12f0645904e7ULL, 0x00d302440dea008eULL, },
+        { 0xffec0f357fff082bULL, 0x014f02780dc00035ULL, },
+        { 0xffed0f417fff0488ULL, 0x0181012410080057ULL, },
+        { 0xfff9059039cf0068ULL, 0x01f900a205680070ULL, },
+        { 0xfff3068864590050ULL, 0x0037000b01be0056ULL, },
+        { 0xffff053f7fff0085ULL, 0x0057000c01b90020ULL, },    /*  88  */
+        { 0xffff05437fff004aULL, 0x0064000602020035ULL, },
+        { 0x000001eb39cf0007ULL, 0x0083000300ad0044ULL, },
+        { 0x0000024164590005ULL, 0x000e000000380034ULL, },
+        { 0x000001cf7fff0008ULL, 0x0016000000370014ULL, },
+        { 0x000001d07fff0004ULL, 0x0019000000400021ULL, },
+        { 0x000000a939cf0000ULL, 0x002100000016002bULL, },
+        { 0x000000c664590000ULL, 0x0004000000070021ULL, },
+        { 0x0000009f7fff0000ULL, 0x000600000007000cULL, },    /*  96  */
+        { 0x000000807fff0000ULL, 0x000a000000070005ULL, },
+        { 0x000000677fff0000ULL, 0x0010000000070002ULL, },
+        { 0x000000537fff0000ULL, 0x0019000000070001ULL, },
+        { 0x000000537fff0000ULL, 0x001d000000080002ULL, },
+        { 0x000000537fff0000ULL, 0x0021000000090003ULL, },
+        { 0x000000537fff0000ULL, 0x00260000000a0005ULL, },
+        { 0x000000537fff0000ULL, 0x002c0000000c0008ULL, },
+        { 0x0000001e39cf0000ULL, 0x003a00000004000aULL, },    /* 104  */
+        { 0x0000000b1a1c0000ULL, 0x004c00000001000dULL, },
+        { 0x000000040bcb0000ULL, 0x0064000000000011ULL, },
+        { 0x0000000105530000ULL, 0x0083000000000016ULL, },
+        { 0x00000001093e0000ULL, 0x000e000000000011ULL, },
+        { 0x00000001100b0000ULL, 0x000200000000000dULL, },
+        { 0x000000011bd90000ULL, 0x000000000000000aULL, },
+        { 0x0000000130570000ULL, 0x0000000000000008ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_H(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_H(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_H__DDT(b128_random[i], b128_random[j],
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
+            do_msa_MADDR_Q_H__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
new file mode 100644
index 0000000..19eccbf
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MADDR_Q.W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MADDR_Q.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  16  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x38e38e3b38e38e3bULL, 0x38e38e3b38e38e3bULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x2222222522222225ULL, 0x2222222522222225ULL, },
+        { 0x0000000300000003ULL, 0x0000000300000003ULL, },
+        { 0x12f684c14bda12faULL, 0xda12f68812f684c1ULL, },
+        { 0x0000000400000003ULL, 0x0000000400000004ULL, },
+        { 0x0000000300000002ULL, 0x0000000300000003ULL, },    /*  24  */
+        { 0x0000000300000002ULL, 0x0000000300000003ULL, },
+        { 0xc71c71cac71c71c9ULL, 0xc71c71cac71c71caULL, },
+        { 0x0000000200000001ULL, 0x0000000200000002ULL, },
+        { 0xdddddddfdddddddeULL, 0xdddddddfdddddddfULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xed097b43b425ed0aULL, 0x25ed097ced097b43ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x2222222322222223ULL, 0x2222222422222223ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x147ae148147ae148ULL, 0x147ae149147ae148ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0b60b60c2d82d82eULL, 0xe93e93ea0b60b60cULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },    /*  40  */
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xdddddddfdddddddeULL, 0xdddddddfdddddddfULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xeb851eb9eb851eb8ULL, 0xeb851eb9eb851eb9ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xf49f49f5d27d27d3ULL, 0x16c16c17f49f49f5ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x12f684be4bda12f8ULL, 0xda12f68512f684beULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0x0b60b60c2d82d830ULL, 0xe93e93e90b60b60cULL, },
+        { 0x0000000000000003ULL, 0xffffffff00000000ULL, },
+        { 0x06522c3f6522c3f7ULL, 0x1948b0fb06522c3fULL, },
+        { 0x0000000000000004ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000003ULL, 0xffffffff00000000ULL, },    /*  56  */
+        { 0x0000000000000003ULL, 0xffffffff00000000ULL, },
+        { 0xed097b43b425ed0cULL, 0x25ed097bed097b43ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0xf49f49f5d27d27d4ULL, 0x16c16c17f49f49f5ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0xf9add3c19add3c0eULL, 0xe6b74f04f9add3c1ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x6fb7e8890cbdc0d3ULL, 0x2c6b144700049a05ULL, },    /*  64  */
+        { 0x73b239d7253787d5ULL, 0x379780f0ffc424ccULL, },
+        { 0x7fffffff0f127795ULL, 0x4f10998300c57f01ULL, },
+        { 0x1713a7162cca6b3bULL, 0x0be04ded01cca270ULL, },
+        { 0x1b0df8644544323dULL, 0x170cba96018c2d37ULL, },
+        { 0x1b323a657448a84fULL, 0x19dc46aa051313c6ULL, },
+        { 0x1dfa85ed49be7970ULL, 0x1fc3e135f6fe3018ULL, },
+        { 0x1a3e24ca7fffffffULL, 0x0edd19d1e8983ff6ULL, },
+        { 0x6863455169daefbfULL, 0x26563264e9999a2bULL, },    /*  72  */
+        { 0x6b2b90d93f50c0e0ULL, 0x2c3dccefdb84b67dULL, },
+        { 0x7fffffff65cdd2a4ULL, 0x38a5555313bd77c9ULL, },
+        { 0x369baa393226e271ULL, 0x1523c34a4d39d0a3ULL, },
+        { 0xcdaf51504fded617ULL, 0xd1f377b44e40f412ULL, },
+        { 0xc9f2f02d7fffffffULL, 0xc10cb0503fdb03f0ULL, },
+        { 0x808e9a674c590fccULL, 0x9d8b1e4779575ccaULL, },
+        { 0xe319324b7fffffffULL, 0x032ce4297fffffffULL, },
+        { 0xfe196fe67fffffffULL, 0x050bc0417e7bb00bULL, },    /*  80  */
+        { 0xfe299f487fffffffULL, 0x05cb2b577fffffffULL, },
+        { 0xff5d018339cf8b80ULL, 0x0798e2662b2b2514ULL, },
+        { 0xfecdfe20645a7d9bULL, 0x00d3dcf80dea608eULL, },
+        { 0xffebe0517fffffffULL, 0x0150ab000dc02968ULL, },
+        { 0xffec8baf7fffffffULL, 0x01828ea210087db2ULL, },
+        { 0xfff9423c39cf8b80ULL, 0x01fae4c1056841b9ULL, },
+        { 0xfff35806645a7d9bULL, 0x003737bc01be3862ULL, },
+        { 0xffff2aee7fffffffULL, 0x0057bed801b8eeb0ULL, },    /*  88  */
+        { 0xffff32047fffffffULL, 0x0064bf8102021ffcULL, },
+        { 0xffffb89f39cf8b80ULL, 0x00841c7a00ad640aULL, },
+        { 0xffff79fe645a7d9bULL, 0x000e642f0037e4a6ULL, },
+        { 0xfffff7307fffffffULL, 0x0016de7800373b16ULL, },
+        { 0xfffff77b7fffffffULL, 0x001a42040040661aULL, },
+        { 0xfffffd0c39cf8b80ULL, 0x00226e990015b802ULL, },
+        { 0xfffffa75645a7d9bULL, 0x0003c0350007004aULL, },
+        { 0xffffffa37fffffffULL, 0x0005f5d90006eb0dULL, },    /*  96  */
+        { 0xfffffffa7fffffffULL, 0x000978b30006d610ULL, },
+        { 0x000000007fffffffULL, 0x000f0d0c0006c153ULL, },
+        { 0x000000007fffffffULL, 0x0017eacf0006acd5ULL, },
+        { 0x000000007fffffffULL, 0x001b761e0007c87dULL, },
+        { 0x000000007fffffffULL, 0x001f87e00009133bULL, },
+        { 0x000000007fffffffULL, 0x00243402000a94e0ULL, },
+        { 0x000000007fffffffULL, 0x00299164000c5689ULL, },
+        { 0x0000000039cf8b80ULL, 0x003682160004293bULL, },    /* 104  */
+        { 0x000000001a1c28c4ULL, 0x00477a0900016741ULL, },
+        { 0x000000000bcae026ULL, 0x005dba4500007929ULL, },
+        { 0x00000000055376c2ULL, 0x007ae7c2000028ddULL, },
+        { 0x00000000093ed557ULL, 0x000d637500000d2cULL, },
+        { 0x00000000100c9469ULL, 0x0001755d0000043fULL, },
+        { 0x000000001bdc1297ULL, 0x000028ac0000015eULL, },
+        { 0x00000000305c8bbfULL, 0x0000046e00000071ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_W(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_W(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_MADDR_Q_W__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
new file mode 100644
index 0000000..b584736
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MSUB_Q.H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MSUB_Q.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffdfffdfffdfffdULL, 0xfffdfffdfffdfffdULL, },
+        { 0xfffcfffdfffcfffcULL, 0xfffdfffcfffcfffdULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },    /*   8  */
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffcfffcfffcfffcULL, 0xfffcfffcfffcfffcULL, },
+        { 0xfffbfffbfffbfffbULL, 0xfffbfffbfffbfffbULL, },    /*  16  */
+        { 0xfffbfffbfffbfffbULL, 0xfffbfffbfffbfffbULL, },
+        { 0xc716c716c716c716ULL, 0xc716c716c716c716ULL, },
+        { 0xfff9fff9fff9fff9ULL, 0xfff9fff9fff9fff9ULL, },
+        { 0xddd6ddd6ddd6ddd6ULL, 0xddd6ddd6ddd6ddd6ULL, },
+        { 0xfff8fff8fff8fff8ULL, 0xfff8fff8fff8fff8ULL, },
+        { 0xed0125e4b41ced01ULL, 0x25e4b41ced0125e4ULL, },
+        { 0xfff7fff6fff6fff7ULL, 0xfff6fff6fff7fff6ULL, },
+        { 0xfff7fff6fff6fff7ULL, 0xfff6fff6fff7fff6ULL, },    /*  24  */
+        { 0xfff7fff6fff6fff7ULL, 0xfff6fff6fff7fff6ULL, },
+        { 0x38da38d938d938daULL, 0x38d938d938da38d9ULL, },
+        { 0xfff6fff5fff5fff6ULL, 0xfff5fff5fff6fff5ULL, },
+        { 0x2218221722172218ULL, 0x2217221722182217ULL, },
+        { 0xfff6fff5fff5fff6ULL, 0xfff5fff5fff6fff5ULL, },
+        { 0x12ecda084bcf12ecULL, 0xda084bcf12ecda08ULL, },
+        { 0xfff6fff5fff5fff6ULL, 0xfff5fff5fff6fff5ULL, },
+        { 0xfff5fff4fff4fff5ULL, 0xfff4fff4fff5fff4ULL, },    /*  32  */
+        { 0xfff5fff4fff4fff5ULL, 0xfff4fff4fff5fff4ULL, },
+        { 0xddd2ddd1ddd1ddd2ULL, 0xddd1ddd1ddd2ddd1ULL, },
+        { 0xfff4fff3fff3fff4ULL, 0xfff3fff3fff4fff3ULL, },
+        { 0xeb78eb77eb77eb78ULL, 0xeb77eb77eb78eb77ULL, },
+        { 0xfff3fff2fff2fff3ULL, 0xfff2fff2fff3fff2ULL, },
+        { 0xf49216b3d26ef492ULL, 0x16b3d26ef49216b3ULL, },
+        { 0xfff2fff1fff1fff2ULL, 0xfff1fff1fff2fff1ULL, },
+        { 0xfff2fff1fff1fff2ULL, 0xfff1fff1fff2fff1ULL, },    /*  40  */
+        { 0xfff2fff1fff1fff2ULL, 0xfff1fff1fff2fff1ULL, },
+        { 0x2214221322132214ULL, 0x2213221322142213ULL, },
+        { 0xfff2fff1fff1fff2ULL, 0xfff1fff1fff2fff1ULL, },
+        { 0x146d146c146c146dULL, 0x146c146c146d146cULL, },
+        { 0xfff2fff1fff1fff2ULL, 0xfff1fff1fff2fff1ULL, },
+        { 0x0b52e92f2d740b52ULL, 0xe92f2d740b52e92fULL, },
+        { 0xfff1fff0fff1fff1ULL, 0xfff0fff1fff1fff0ULL, },
+        { 0xfff0fff0fff0fff0ULL, 0xfff0fff0fff0fff0ULL, },    /*  48  */
+        { 0xfff0fff0fff0fff0ULL, 0xfff0fff0fff0fff0ULL, },
+        { 0xecf925dcb414ecf9ULL, 0x25dcb414ecf925dcULL, },
+        { 0xffefffefffeeffefULL, 0xffefffeeffefffefULL, },
+        { 0xf48e16b0d26af48eULL, 0x16b0d26af48e16b0ULL, },
+        { 0xffeeffeeffedffeeULL, 0xffeeffedffeeffeeULL, },
+        { 0xf99be6a59ac8f99bULL, 0xe6a59ac8f99be6a5ULL, },
+        { 0xffedffedffebffedULL, 0xffedffebffedffedULL, },
+        { 0xffedffecffebffedULL, 0xffecffebffedffecULL, },    /*  56  */
+        { 0xffedffecffebffedULL, 0xffecffebffedffecULL, },
+        { 0x12e3d9fe4bc512e3ULL, 0xd9fe4bc512e3d9feULL, },
+        { 0xffedffebffebffedULL, 0xffebffebffedffebULL, },
+        { 0x0b4de9292d6e0b4dULL, 0xe9292d6e0b4de929ULL, },
+        { 0xffecffeaffebffecULL, 0xffeaffebffecffeaULL, },
+        { 0x063e1932650e063eULL, 0x1932650e063e1932ULL, },
+        { 0xffecffe8ffebffecULL, 0xffe8ffebffecffe8ULL, },
+        { 0x9032faf1f32dc724ULL, 0xd37cfee8ffe7cdf6ULL, },    /*  64  */
+        { 0x8c37fb04dab3ed15ULL, 0xc8500506002701cbULL, },
+        { 0x8000eb00f0d83aacULL, 0xb0d70a15ff2518f4ULL, },
+        { 0xe8edef64d3204e73ULL, 0xf40714a9fe1d069aULL, },
+        { 0xe4f2ef77baa67464ULL, 0xe8db1ac7fe5d3a6fULL, },
+        { 0xe4cdef768ba25b09ULL, 0xe60bf5b1fad604a2ULL, },
+        { 0xe204efb4b62c272fULL, 0xe023d70208eaec98ULL, },
+        { 0xe5c0efa2800019f7ULL, 0xf10996de174fffa3ULL, },
+        { 0x9799df9e9625678eULL, 0xd9909bed164d16ccULL, },    /*  72  */
+        { 0x94d0dfdcc0af33b4ULL, 0xd3a880002461fec2ULL, },
+        { 0x8000ac2c9a31c9abULL, 0xc7408000ec28f404ULL, },
+        { 0xc964ba57cdd7aea3ULL, 0xeac18000b2aafc86ULL, },
+        { 0x3251bebbb01fc26aULL, 0x2df18a94b1a2ea2cULL, },
+        { 0x360dbea98000b532ULL, 0x3ed78000c007fd37ULL, },
+        { 0x7f71ccd4b3a69a2aULL, 0x62588000868905b9ULL, },
+        { 0x1ce6c8f180009346ULL, 0xfcb580008000fefbULL, },
+        { 0x37e5be19a862dbafULL, 0xfea58b5e8000fe57ULL, },    /*  80  */
+        { 0x39c0be4bdd7bcb85ULL, 0xfed88000953fff6aULL, },
+        { 0x5f7d948aca8d9bc1ULL, 0xff3480008000ff95ULL, },
+        { 0x0bb4a742f1e1847fULL, 0xfe7e80008000ff7cULL, },
+        { 0x16a395c8f655d6c0ULL, 0xff618b5e8000ff29ULL, },
+        { 0x1763961afc30c464ULL, 0xff788000953fffb4ULL, },
+        { 0x26ab8000fa188e23ULL, 0xffa280008000ffcaULL, },
+        { 0x04bd964dfe708000ULL, 0xff4e80008000ffbdULL, },
+        { 0x092a817dfeeed540ULL, 0xffb68b5e8000ff93ULL, },    /*  88  */
+        { 0x097881deff94c239ULL, 0xffc08000953fffd9ULL, },
+        { 0x0fa88000ff5889feULL, 0xffd380008000ffe4ULL, },
+        { 0x01eb964dffd38000ULL, 0xffaa80008000ffddULL, },
+        { 0x03b5817dffe1d540ULL, 0xffdc8b5e8000ffc7ULL, },
+        { 0x03d481defff3c239ULL, 0xffe18000953fffebULL, },
+        { 0x06548000ffeb89feULL, 0xffea80008000fff1ULL, },
+        { 0x00c6964dfffa8000ULL, 0xffd680008000ffedULL, },
+        { 0x017e817dfffbd540ULL, 0xffee8b5e8000ffe1ULL, },    /*  96  */
+        { 0x02e28000fffcf1b8ULL, 0xfff895b98000ffcdULL, },
+        { 0x05938000fffdfb3aULL, 0xfffc9f298000ffadULL, },
+        { 0x0ac88000fffdfe67ULL, 0xfffea7c28000ff79ULL, },
+        { 0x0b238063fffefdb0ULL, 0xfffe8000953fffd0ULL, },
+        { 0x0b8180c5fffffca8ULL, 0xfffe8000a6f7ffefULL, },
+        { 0x0be28127fffffb2bULL, 0xfffe8000b5befffaULL, },
+        { 0x0c478189fffff904ULL, 0xfffe8000c211fffdULL, },
+        { 0x144c8000fffef2a8ULL, 0xfffe80009905fffdULL, },    /* 104  */
+        { 0x218f8000fffce682ULL, 0xfffe80008000fffdULL, },
+        { 0x377d8000fff9cf4eULL, 0xfffe80008000fffdULL, },
+        { 0x5bc08000fff5a2fbULL, 0xfffe80008000fffdULL, },
+        { 0x0b3f964dfffd8d66ULL, 0xfffc80008000fffcULL, },
+        { 0x0160a8b7ffff8000ULL, 0xfff880008000fffbULL, },
+        { 0x002bb7ecffff8000ULL, 0xfff080008000fff9ULL, },
+        { 0x0005c47affff8000ULL, 0xffe180008000fff7ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_H(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_H(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_H__DDT(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     ((RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_H__DSD(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
new file mode 100644
index 0000000..5619192
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MSUB_Q.W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MSUB_Q.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },    /*   0  */
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xfffffffefffffffeULL, 0xfffffffefffffffeULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffdfffffffdULL, 0xfffffffdfffffffdULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffdfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },    /*   8  */
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffcfffffffcULL, 0xfffffffcfffffffcULL, },
+        { 0xfffffffbfffffffbULL, 0xfffffffbfffffffbULL, },    /*  16  */
+        { 0xfffffffbfffffffbULL, 0xfffffffbfffffffbULL, },
+        { 0xc71c71c1c71c71c1ULL, 0xc71c71c1c71c71c1ULL, },
+        { 0xfffffffafffffffaULL, 0xfffffffafffffffaULL, },
+        { 0xddddddd7ddddddd7ULL, 0xddddddd7ddddddd7ULL, },
+        { 0xfffffff9fffffff9ULL, 0xfffffff9fffffff9ULL, },
+        { 0xed097b3ab425ed01ULL, 0x25ed0973ed097b3aULL, },
+        { 0xfffffff7fffffff7ULL, 0xfffffff7fffffff7ULL, },
+        { 0xfffffff7fffffff7ULL, 0xfffffff7fffffff7ULL, },    /*  24  */
+        { 0xfffffff7fffffff7ULL, 0xfffffff7fffffff7ULL, },
+        { 0x38e38e3038e38e30ULL, 0x38e38e3038e38e30ULL, },
+        { 0xfffffff7fffffff7ULL, 0xfffffff7fffffff7ULL, },
+        { 0x2222221922222219ULL, 0x2222221922222219ULL, },
+        { 0xfffffff7fffffff7ULL, 0xfffffff7fffffff7ULL, },
+        { 0x12f684b44bda12edULL, 0xda12f67c12f684b4ULL, },
+        { 0xfffffff6fffffff7ULL, 0xfffffff7fffffff6ULL, },
+        { 0xfffffff5fffffff6ULL, 0xfffffff6fffffff5ULL, },    /*  32  */
+        { 0xfffffff5fffffff6ULL, 0xfffffff6fffffff5ULL, },
+        { 0xddddddd2ddddddd3ULL, 0xddddddd3ddddddd2ULL, },
+        { 0xfffffff4fffffff5ULL, 0xfffffff5fffffff4ULL, },
+        { 0xeb851eabeb851eacULL, 0xeb851eaceb851eabULL, },
+        { 0xfffffff2fffffff3ULL, 0xfffffff3fffffff2ULL, },
+        { 0xf49f49e6d27d27c4ULL, 0x16c16c09f49f49e6ULL, },
+        { 0xfffffff1fffffff1ULL, 0xfffffff1fffffff1ULL, },
+        { 0xfffffff1fffffff1ULL, 0xfffffff1fffffff1ULL, },    /*  40  */
+        { 0xfffffff1fffffff1ULL, 0xfffffff1fffffff1ULL, },
+        { 0x2222221322222213ULL, 0x2222221322222213ULL, },
+        { 0xfffffff1fffffff1ULL, 0xfffffff1fffffff1ULL, },
+        { 0x147ae138147ae138ULL, 0x147ae138147ae138ULL, },
+        { 0xfffffff0fffffff0ULL, 0xfffffff0fffffff0ULL, },
+        { 0x0b60b5fb2d82d81dULL, 0xe93e93d90b60b5fbULL, },
+        { 0xffffffefffffffefULL, 0xffffffefffffffefULL, },
+        { 0xffffffeeffffffeeULL, 0xffffffefffffffeeULL, },    /*  48  */
+        { 0xffffffeeffffffeeULL, 0xffffffefffffffeeULL, },
+        { 0xed097b2fb425ecf6ULL, 0x25ed0969ed097b2fULL, },
+        { 0xffffffecffffffecULL, 0xffffffeeffffffecULL, },
+        { 0xf49f49e0d27d27bdULL, 0x16c16c04f49f49e0ULL, },
+        { 0xffffffebffffffeaULL, 0xffffffedffffffebULL, },
+        { 0xf9add3ab9add3bf6ULL, 0xe6b74ef0f9add3abULL, },
+        { 0xffffffeaffffffe8ULL, 0xffffffecffffffeaULL, },
+        { 0xffffffeaffffffe8ULL, 0xffffffebffffffeaULL, },    /*  56  */
+        { 0xffffffeaffffffe8ULL, 0xffffffebffffffeaULL, },
+        { 0x12f684a74bda12deULL, 0xda12f66f12f684a7ULL, },
+        { 0xffffffe9ffffffe8ULL, 0xffffffeaffffffe9ULL, },
+        { 0x0b60b5f42d82d815ULL, 0xe93e93d20b60b5f4ULL, },
+        { 0xffffffe8ffffffe7ULL, 0xffffffe8ffffffe8ULL, },
+        { 0x06522c276522c3d9ULL, 0x1948b0e406522c27ULL, },
+        { 0xffffffe7ffffffe7ULL, 0xffffffe7ffffffe7ULL, },
+        { 0x9048175df3423f14ULL, 0xd394eba0fffb65e2ULL, },    /*  64  */
+        { 0x8c4dc60edac87812ULL, 0xc8687ef6003bdb1bULL, },
+        { 0x80000000f0ed8852ULL, 0xb0ef6662ff3a80e6ULL, },
+        { 0xe8ec58e8d33594acULL, 0xf41fb1f8fe335d76ULL, },
+        { 0xe4f20799babbcdaaULL, 0xe8f3454efe73d2afULL, },
+        { 0xe4cdc5978bb75798ULL, 0xe623b939faecec20ULL, },
+        { 0xe2057a0fb6418676ULL, 0xe03c1eae0901cfcdULL, },
+        { 0xe5c1db3280000000ULL, 0xf122e6111767bfefULL, },
+        { 0x979cbaab96251040ULL, 0xd9a9cd7d166665baULL, },    /*  72  */
+        { 0x94d46f23c0af3f1eULL, 0xd3c232f2247b4967ULL, },
+        { 0x800000009a322d5aULL, 0xc75aaa8dec42881aULL, },
+        { 0xc96455c6cdd91d8cULL, 0xeadc3c95b2c62f40ULL, },
+        { 0x3250aeaeb02129e6ULL, 0x2e0c882bb1bf0bd0ULL, },
+        { 0x360d0fd180000000ULL, 0x3ef34f8ec024fbf2ULL, },
+        { 0x7f716597b3a6f032ULL, 0x6274e19686a8a318ULL, },
+        { 0x1ce6cdb280000000ULL, 0xfcd31bb480000000ULL, },
+        { 0x37e70b49a8625540ULL, 0xfeb1f7e080000000ULL, },    /*  80  */
+        { 0x39c31699dd7c5546ULL, 0xfee37780953f52fcULL, },
+        { 0x5f82316fca8f431eULL, 0xff3c0af780000000ULL, },
+        { 0x0bb5432ff1e2e177ULL, 0xfe8d6e9580000000ULL, },
+        { 0x16a56af3f656d2b3ULL, 0xff67ba1b80000000ULL, },
+        { 0x17664384fc31bf42ULL, 0xff7e4aa4953f52fcULL, },
+        { 0x26b0cbfdfa1b830bULL, 0xffa6ab9180000000ULL, },
+        { 0x04be31a4fe719ab1ULL, 0xff57124580000000ULL, },
+        { 0x092c8a1ffeef4c68ULL, 0xffba958e80000000ULL, },    /*  88  */
+        { 0x097aa960ff949347ULL, 0xffc4dede953f52fcULL, },
+        { 0x0fac7158ff59ab27ULL, 0xffd7471a80000000ULL, },
+        { 0x01ebdf01ffd41248ULL, 0xffb2fdd380000000ULL, },
+        { 0x03b76546ffe1ee50ULL, 0xffe05b1780000000ULL, },
+        { 0x03d70afdfff427aaULL, 0xffe50b86953f52fcULL, },
+        { 0x065971c1ffeda8dfULL, 0xffed6fa980000000ULL, },
+        { 0x00c741e8fffb2801ULL, 0xffdce50280000000ULL, },
+        { 0x01816947fffcaf39ULL, 0xfff1931580000000ULL, },    /*  96  */
+        { 0x02e97a17fffdbb03ULL, 0xfffa128380000000ULL, },
+        { 0x05a1edf3fffe7250ULL, 0xfffd906f80000000ULL, },
+        { 0x0ae508c5fffeefc8ULL, 0xfffeffc380000000ULL, },
+        { 0x0b41cf1bffff94c3ULL, 0xffff25bb953f52fcULL, },
+        { 0x0ba1ab79ffffd5c1ULL, 0xffff4613a6f7bf69ULL, },
+        { 0x0c04b828ffffef5bULL, 0xffff61a0b5bf25caULL, },
+        { 0x0c6b104efffff971ULL, 0xffff7918c21285a5ULL, },
+        { 0x148886c7fffff5d8ULL, 0xffffa3179907b21bULL, },    /* 104  */
+        { 0x21f39335fffff046ULL, 0xffffc00380000000ULL, },
+        { 0x38235e38ffffe7a6ULL, 0xffffd3ee80000000ULL, },
+        { 0x5cd2ce93ffffda4bULL, 0xffffe1a680000000ULL, },
+        { 0x0b60ff8afffff60aULL, 0xffffc69a80000000ULL, },
+        { 0x01651818fffffd5eULL, 0xffff937480000000ULL, },
+        { 0x002bc65fffffff4dULL, 0xffff32bb80000000ULL, },
+        { 0x00055dbfffffffd0ULL, 0xfffe7bd280000000ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_W(b128_pattern[i], b128_pattern[j],
+                            b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_W(b128_random[i], b128_random[j],
+                            b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                         (PATTERN_INPUTS_SHORT_COUNT)) +
+                                        RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_W__DDT(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     ((RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUB_Q_W__DSD(b128_random[i], b128_random[j],
+                                 b128_result[
+                                     ((PATTERN_INPUTS_SHORT_COUNT) *
+                                      (PATTERN_INPUTS_SHORT_COUNT)) +
+                                     (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                      (RANDOM_INPUTS_SHORT_COUNT)) +
+                                     RANDOM_INPUTS_SHORT_COUNT * i + j]);
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
new file mode 100644
index 0000000..0be6d51
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MSUBR_Q.H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MSUBR_Q.H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x00000000ffff0000ULL, 0x0000ffff00000000ULL, },
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
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xc71bc71bc71bc71bULL, 0xc71bc71bc71bc71bULL, },
+        { 0xffffffffffffffffULL, 0xffffffffffffffffULL, },
+        { 0xdddcdddcdddcdddcULL, 0xdddcdddcdddcdddcULL, },
+        { 0xfffefffefffefffeULL, 0xfffefffefffefffeULL, },
+        { 0xed0725ebb423ed07ULL, 0x25ebb423ed0725ebULL, },
+        { 0xfffdfffdfffefffdULL, 0xfffdfffefffdfffdULL, },
+        { 0xfffefffefffffffeULL, 0xfffefffffffefffeULL, },    /*  24  */
+        { 0xfffefffefffffffeULL, 0xfffefffffffefffeULL, },
+        { 0x38e238e238e338e2ULL, 0x38e238e338e238e2ULL, },
+        { 0xffffffff0000ffffULL, 0xffff0000ffffffffULL, },
+        { 0x2222222222232222ULL, 0x2222222322222222ULL, },
+        { 0x0000000000010000ULL, 0x0000000100000000ULL, },
+        { 0x12f7da134bdb12f7ULL, 0xda134bdb12f7da13ULL, },
+        { 0x0001000000010001ULL, 0x0000000100010000ULL, },
+        { 0x0001000000010001ULL, 0x0000000100010000ULL, },    /*  32  */
+        { 0x0001000000010001ULL, 0x0000000100010000ULL, },
+        { 0xdddedddddddedddeULL, 0xdddddddedddeddddULL, },
+        { 0x0001000000010001ULL, 0x0000000100010000ULL, },
+        { 0xeb85eb84eb85eb85ULL, 0xeb84eb85eb85eb84ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0xf49f16c1d27cf49fULL, 0x16c1d27cf49f16c1ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },    /*  40  */
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x2222222122222222ULL, 0x2221222222222221ULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x147b147a147b147bULL, 0x147a147b147b147aULL, },
+        { 0x0000ffff00000000ULL, 0xffff00000000ffffULL, },
+        { 0x0b61e93e2d830b61ULL, 0xe93e2d830b61e93eULL, },
+        { 0x0001000000000001ULL, 0x0000000000010000ULL, },
+        { 0x00010000ffff0001ULL, 0x0000ffff00010000ULL, },    /*  48  */
+        { 0x00010000ffff0001ULL, 0x0000ffff00010000ULL, },
+        { 0xed0a25edb424ed0aULL, 0x25edb424ed0a25edULL, },
+        { 0x00010000fffe0001ULL, 0x0000fffe00010000ULL, },
+        { 0xf4a016c2d27af4a0ULL, 0x16c2d27af4a016c2ULL, },
+        { 0x00010001fffd0001ULL, 0x0001fffd00010001ULL, },
+        { 0xf9afe6b99ad9f9afULL, 0xe6b99ad9f9afe6b9ULL, },
+        { 0x00010002fffc0001ULL, 0x0002fffc00010002ULL, },
+        { 0x00010002fffd0001ULL, 0x0002fffd00010002ULL, },    /*  56  */
+        { 0x00010002fffd0001ULL, 0x0002fffd00010002ULL, },
+        { 0x12f7da144bd812f7ULL, 0xda144bd812f7da14ULL, },
+        { 0x00010001fffe0001ULL, 0x0001fffe00010001ULL, },
+        { 0x0b62e93f2d820b62ULL, 0xe93f2d820b62e93fULL, },
+        { 0x00020001ffff0002ULL, 0x0001ffff00020001ULL, },
+        { 0x0654194a65220654ULL, 0x194a65220654194aULL, },
+        { 0x00020001ffff0002ULL, 0x0001ffff00020001ULL, },
+        { 0x9048fb0bf341c73bULL, 0xd396fefdfffdce10ULL, },    /*  64  */
+        { 0x8c4efb1edac8ed2cULL, 0xc86a051b003e01e6ULL, },
+        { 0x8000eb1af0ed3ac3ULL, 0xb0f10a2bff3c190fULL, },
+        { 0xe8edef7ed3364e8aULL, 0xf42214c0fe3406b6ULL, },
+        { 0xe4f3ef91babd747bULL, 0xe8f61adefe753a8cULL, },
+        { 0xe4cfef918bb95b20ULL, 0xe627f5c8faee04bfULL, },
+        { 0xe207efd0b6432746ULL, 0xe040d7190903ecb5ULL, },
+        { 0xe5c3efbf80001a0fULL, 0xf12696f61769ffc0ULL, },
+        { 0x979ddfbb962567a6ULL, 0xd9ad9c06166716e9ULL, },    /*  72  */
+        { 0x94d5dffac0af33ccULL, 0xd3c68000247cfedfULL, },
+        { 0x8000ac4b9a31c9c4ULL, 0xc75f8000ec43f421ULL, },
+        { 0xc965ba77cdd8aebdULL, 0xeae08000b2c6fca3ULL, },
+        { 0x3252bedbb021c284ULL, 0x2e118a95b1beea4aULL, },
+        { 0x360ebeca8000b54dULL, 0x3ef78000c024fd55ULL, },
+        { 0x7f73ccf6b3a79a46ULL, 0x6278800086a705d7ULL, },
+        { 0x1ce9c91380009362ULL, 0xfcd580008000ff19ULL, },
+        { 0x37ebbe42a862dbb9ULL, 0xfeb38b5e8000fe89ULL, },    /*  80  */
+        { 0x39c7be75dd7ccb94ULL, 0xfee48000953fff7cULL, },
+        { 0x5f8994cfca8f9bdeULL, 0xff3c80008000ffa2ULL, },
+        { 0x0bb6a77cf1e284a3ULL, 0xfe8d80008000ff8cULL, },
+        { 0x16a7960ef656d6ccULL, 0xff688b5e8000ff44ULL, },
+        { 0x17689660fc31c475ULL, 0xff7f8000953fffbeULL, },
+        { 0x26b48000fa1a8e43ULL, 0xffa780008000ffd1ULL, },
+        { 0x04bf964dfe718000ULL, 0xff5880008000ffc6ULL, },
+        { 0x092e817dfeefd540ULL, 0xffbb8b5e8000ffa2ULL, },    /*  88  */
+        { 0x097c81dfff94c239ULL, 0xffc58000953fffdfULL, },
+        { 0x0faf8000ff5989ffULL, 0xffd780008000ffe9ULL, },
+        { 0x01ec964dffd48000ULL, 0xffb280008000ffe4ULL, },
+        { 0x03b8817dffe2d540ULL, 0xffe08b5e8000ffd3ULL, },
+        { 0x03d881dffff4c239ULL, 0xffe58000953ffff0ULL, },
+        { 0x065b8000ffed89ffULL, 0xffed80008000fff5ULL, },
+        { 0x00c7964dfffb8000ULL, 0xffdc80008000fff2ULL, },
+        { 0x0181817dfffdd540ULL, 0xfff18b5e8000ffe9ULL, },    /*  96  */
+        { 0x02e98000fffef1b9ULL, 0xfffa95ba8000ffdbULL, },
+        { 0x05a18000fffffb3bULL, 0xfffe9f2a8000ffc4ULL, },
+        { 0x0ae38000fffffe68ULL, 0xffffa7c48000ff9fULL, },
+        { 0x0b4080630000fdb2ULL, 0xffff8000953fffdeULL, },
+        { 0x0ba080c60000fcabULL, 0xffff8000a6f7fff4ULL, },
+        { 0x0c0381280000fb2fULL, 0xffff8000b5befffcULL, },
+        { 0x0c69818a0000f90aULL, 0xffff8000c211ffffULL, },
+        { 0x148580000000f2b4ULL, 0xffff80009905ffffULL, },    /* 104  */
+        { 0x21ee80000000e69aULL, 0xffff80008000ffffULL, },
+        { 0x381a80000000cf7cULL, 0xffff80008000ffffULL, },
+        { 0x5cc480000000a354ULL, 0xffff80008000ffffULL, },
+        { 0x0b5f964d00008dd4ULL, 0xfffe80008000ffffULL, },
+        { 0x0165a8b700008000ULL, 0xfffc80008000ffffULL, },
+        { 0x002cb7ec00008000ULL, 0xfff880008000ffffULL, },
+        { 0x0005c47b00008000ULL, 0xfff180008000ffffULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUBR_Q_H(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUBR_Q_H(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MSUBR_Q_H__DDT(b128_random[i], b128_random[j],
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
+            do_msa_MSUBR_Q_H__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c
new file mode 100644
index 0000000..7d57cb5
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c
@@ -0,0 +1,216 @@
+/*
+ *  Test program for MSA instruction MSUBR_Q.W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2019  RT-RK Computer Based Systems LLC
+ *  Copyright (C) 2019  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
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
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Fixed Multiply";
+    char *instruction_name =  "MSUBR_Q.W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },    /*  16  */
+        { 0x0000000100000001ULL, 0x0000000100000001ULL, },
+        { 0x38e38e3b38e38e3bULL, 0x38e38e3b38e38e3bULL, },
+        { 0x0000000200000002ULL, 0x0000000200000002ULL, },
+        { 0x2222222522222225ULL, 0x2222222522222225ULL, },
+        { 0x0000000300000003ULL, 0x0000000300000003ULL, },
+        { 0x12f684c14bda12faULL, 0xda12f68812f684c1ULL, },
+        { 0x0000000400000003ULL, 0x0000000400000004ULL, },
+        { 0x0000000300000002ULL, 0x0000000300000003ULL, },    /*  24  */
+        { 0x0000000300000002ULL, 0x0000000300000003ULL, },
+        { 0xc71c71cac71c71c9ULL, 0xc71c71cac71c71caULL, },
+        { 0x0000000200000001ULL, 0x0000000200000002ULL, },
+        { 0xdddddddfdddddddeULL, 0xdddddddfdddddddfULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xed097b43b425ed0aULL, 0x25ed097ced097b43ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },    /*  32  */
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x2222222322222223ULL, 0x2222222422222223ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x147ae148147ae148ULL, 0x147ae149147ae148ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x0b60b60c2d82d82eULL, 0xe93e93ea0b60b60cULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },    /*  40  */
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xdddddddfdddddddeULL, 0xdddddddfdddddddfULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xeb851eb9eb851eb8ULL, 0xeb851eb9eb851eb9ULL, },
+        { 0x0000000100000000ULL, 0x0000000100000001ULL, },
+        { 0xf49f49f5d27d27d3ULL, 0x16c16c17f49f49f5ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },    /*  48  */
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0x12f684be4bda12f8ULL, 0xda12f68512f684beULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0x0b60b60c2d82d830ULL, 0xe93e93e90b60b60cULL, },
+        { 0x0000000000000003ULL, 0xffffffff00000000ULL, },
+        { 0x06522c3f6522c3f7ULL, 0x1948b0fb06522c3fULL, },
+        { 0x0000000000000004ULL, 0xffffffff00000000ULL, },
+        { 0x0000000000000003ULL, 0xffffffff00000000ULL, },    /*  56  */
+        { 0x0000000000000003ULL, 0xffffffff00000000ULL, },
+        { 0xed097b43b425ed0cULL, 0x25ed097bed097b43ULL, },
+        { 0x0000000000000002ULL, 0x0000000000000000ULL, },
+        { 0xf49f49f5d27d27d4ULL, 0x16c16c17f49f49f5ULL, },
+        { 0x0000000000000001ULL, 0x0000000000000000ULL, },
+        { 0xf9add3c19add3c0eULL, 0xe6b74f04f9add3c1ULL, },
+        { 0x0000000000000000ULL, 0x0000000100000000ULL, },
+        { 0x6fb7e8890cbdc0d3ULL, 0x2c6b144700049a05ULL, },    /*  64  */
+        { 0x73b239d7253787d5ULL, 0x379780f0ffc424ccULL, },
+        { 0x7fffffff0f127795ULL, 0x4f10998300c57f01ULL, },
+        { 0x1713a7162cca6b3bULL, 0x0be04ded01cca270ULL, },
+        { 0x1b0df8644544323dULL, 0x170cba96018c2d37ULL, },
+        { 0x1b323a657448a84fULL, 0x19dc46aa051313c6ULL, },
+        { 0x1dfa85ed49be7970ULL, 0x1fc3e135f6fe3018ULL, },
+        { 0x1a3e24ca7fffffffULL, 0x0edd19d1e8983ff6ULL, },
+        { 0x6863455169daefbfULL, 0x26563264e9999a2bULL, },    /*  72  */
+        { 0x6b2b90d93f50c0e0ULL, 0x2c3dccefdb84b67dULL, },
+        { 0x7fffffff65cdd2a4ULL, 0x38a5555313bd77c9ULL, },
+        { 0x369baa393226e271ULL, 0x1523c34a4d39d0a3ULL, },
+        { 0xcdaf51504fded617ULL, 0xd1f377b44e40f412ULL, },
+        { 0xc9f2f02d7fffffffULL, 0xc10cb0503fdb03f0ULL, },
+        { 0x808e9a674c590fccULL, 0x9d8b1e4779575ccaULL, },
+        { 0xe319324b7fffffffULL, 0x032ce4297fffffffULL, },
+        { 0xfe196fe67fffffffULL, 0x050bc0417e7bb00bULL, },    /*  80  */
+        { 0xfe299f487fffffffULL, 0x05cb2b577fffffffULL, },
+        { 0xff5d018339cf8b80ULL, 0x0798e2662b2b2514ULL, },
+        { 0xfecdfe20645a7d9bULL, 0x00d3dcf80dea608eULL, },
+        { 0xffebe0517fffffffULL, 0x0150ab000dc02968ULL, },
+        { 0xffec8baf7fffffffULL, 0x01828ea210087db2ULL, },
+        { 0xfff9423c39cf8b80ULL, 0x01fae4c1056841b9ULL, },
+        { 0xfff35806645a7d9bULL, 0x003737bc01be3862ULL, },
+        { 0xffff2aee7fffffffULL, 0x0057bed801b8eeb0ULL, },    /*  88  */
+        { 0xffff32047fffffffULL, 0x0064bf8102021ffcULL, },
+        { 0xffffb89f39cf8b80ULL, 0x00841c7a00ad640aULL, },
+        { 0xffff79fe645a7d9bULL, 0x000e642f0037e4a6ULL, },
+        { 0xfffff7307fffffffULL, 0x0016de7800373b16ULL, },
+        { 0xfffff77b7fffffffULL, 0x001a42040040661aULL, },
+        { 0xfffffd0c39cf8b80ULL, 0x00226e990015b802ULL, },
+        { 0xfffffa75645a7d9bULL, 0x0003c0350007004aULL, },
+        { 0xffffffa37fffffffULL, 0x0005f5d90006eb0dULL, },    /*  96  */
+        { 0xfffffffa7fffffffULL, 0x000978b30006d610ULL, },
+        { 0x000000007fffffffULL, 0x000f0d0c0006c153ULL, },
+        { 0x000000007fffffffULL, 0x0017eacf0006acd5ULL, },
+        { 0x000000007fffffffULL, 0x001b761e0007c87dULL, },
+        { 0x000000007fffffffULL, 0x001f87e00009133bULL, },
+        { 0x000000007fffffffULL, 0x00243402000a94e0ULL, },
+        { 0x000000007fffffffULL, 0x00299164000c5689ULL, },
+        { 0x0000000039cf8b80ULL, 0x003682160004293bULL, },    /* 104  */
+        { 0x000000001a1c28c4ULL, 0x00477a0900016741ULL, },
+        { 0x000000000bcae026ULL, 0x005dba4500007929ULL, },
+        { 0x00000000055376c2ULL, 0x007ae7c2000028ddULL, },
+        { 0x00000000093ed557ULL, 0x000d637500000d2cULL, },
+        { 0x00000000100c9469ULL, 0x0001755d0000043fULL, },
+        { 0x000000001bdc1297ULL, 0x000028ac0000015eULL, },
+        { 0x00000000305c8bbfULL, 0x0000046e00000071ULL, },
+};
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < PATTERN_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < PATTERN_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_W(b128_pattern[i], b128_pattern[j],
+                             b128_result[PATTERN_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_W(b128_random[i], b128_random[j],
+                             b128_result[((PATTERN_INPUTS_SHORT_COUNT) *
+                                          (PATTERN_INPUTS_SHORT_COUNT)) +
+                                         RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_MADDR_Q_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_MADDR_Q_W__DSD(b128_random[i], b128_random[j],
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
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
index 7a88ca2..537267c 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
@@ -88,6 +88,22 @@
 # Fixed Multiply
 # --------------
 #
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_madd_q_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_madd_q_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddr_q_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddr_q_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msub_q_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c        \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msub_q_w_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubr_q_h_32r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c       \
+-EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubr_q_w_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c         \
 -EB -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mul_q_h_32r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c         \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
index dbe04dc..49f8aa0 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
@@ -88,6 +88,22 @@
 # Fixed Multiply
 # --------------
 #
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_madd_q_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_madd_q_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddr_q_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_maddr_q_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msub_q_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c        \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msub_q_w_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubr_q_h_32r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c       \
+-EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_msubr_q_w_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c         \
 -EL -static -mabi=32 -march=mips32r6 -mmsa -o  /tmp/test_msa_mul_q_h_32r6el
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c         \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
index 73adabb..f4346d6 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.sh
@@ -88,6 +88,22 @@
 # Fixed Multiply
 # --------------
 #
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c        \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_madd_q_h_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c        \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_madd_q_w_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c       \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddr_q_h_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c       \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddr_q_w_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c        \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msub_q_h_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c        \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msub_q_w_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c       \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubr_q_h_64r6eb
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c       \
+-EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubr_q_w_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c         \
 -EB -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mul_q_h_64r6eb
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c         \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
index afe4311..2912b17 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_compile_64r6el.sh
@@ -88,6 +88,22 @@
 # Fixed Multiply
 # --------------
 #
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_madd_q_h_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_madd_q_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_madd_q_w_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddr_q_h_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_maddr_q_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_maddr_q_w_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_h.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msub_q_h_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msub_q_w.c        \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msub_q_w_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_h.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubr_q_h_64r6el
+/opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_msubr_q_w.c       \
+-EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_msubr_q_w_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_h.c         \
 -EL -static -mabi=64 -march=mips64r6 -mmsa -o  /tmp/test_msa_mul_q_h_64r6el
 /opt/img/bin/mips-img-linux-gnu-gcc  fixed-multiply/test_msa_mul_q_w.c         \
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
index 70b2549..e979762 100644
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
@@ -55,6 +55,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_32r6eb
 # Fixed Multiply
 # --------------
 #
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_w_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_h_32r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_w_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_32r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_32r6eb
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
index 4e07930..0e3e0e2 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
@@ -55,6 +55,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_32r6el
 # Fixed Multiply
 # --------------
 #
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_w_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_h_32r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_w_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_32r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_32r6el
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
index c127c1a..e58f177 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
@@ -55,6 +55,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_64r6eb
 # Fixed Multiply
 # --------------
 #
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_h_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_w_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_h_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_w_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_h_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_w_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_h_64r6eb
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_w_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_64r6eb
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_64r6eb
diff --git a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
index 380d876..7a89bd6 100755
--- a/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
+++ b/tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh
@@ -55,6 +55,14 @@ $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_bset_d_64r6el
 # Fixed Multiply
 # --------------
 #
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_h_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_madd_q_w_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_h_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_maddr_q_w_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_h_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msub_q_w_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_h_64r6el
+$PATH_TO_QEMU -cpu I6400  /tmp/test_msa_msubr_q_w_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_h_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mul_q_w_64r6el
 $PATH_TO_QEMU -cpu I6400  /tmp/test_msa_mulr_q_h_64r6el
-- 
2.7.4


