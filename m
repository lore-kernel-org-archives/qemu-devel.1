Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF6C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B83E20673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B83E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIKZ-0007WC-Fa
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1heI7M-0003L3-Kq
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1heI7E-0005Jh-US
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:54:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37473 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1heI7A-00058C-NN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 72D871A45ED;
 Fri, 21 Jun 2019 13:53:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1F7EF1A45F3;
 Fri, 21 Jun 2019 13:53:51 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:53:39 +0200
Message-Id: <1561118020-30489-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561118020-30489-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561118020-30489-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v3 4/5] tests/tcg: target/mips: Add tests for
 MSA move instructions
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

Add tests for MSA move instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h              |   8 ++
 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c | 149 +++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 3f646ab..8f260f5 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -572,6 +572,14 @@ DO_MSA__WD__WS_WT(XOR_V, xor.v)
 
 
 /*
+ * Move
+ * ----
+ */
+
+DO_MSA__WD__WS(MOVE_V, move.v)
+
+
+/*
  * Pack
  * ----
  */
diff --git a/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c b/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
new file mode 100644
index 0000000..0683cfa
--- /dev/null
+++ b/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
@@ -0,0 +1,149 @@
+/*
+ *  Test program for MSA instruction MOVE.V
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
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
+
+
+int32_t main(void)
+{
+    char *isa_ase_name = "MSA";
+    char *group_name = "Bit Count";
+    char *instruction_name =  "MOVE.V";
+    int32_t ret;
+    uint32_t i;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b128_result[TEST_COUNT_TOTAL][2];
+    uint64_t b128_expect[TEST_COUNT_TOTAL][2] = {
+        { 0x0808080808080808ULL, 0x0808080808080808ULL, },    /*   0  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0101010101010101ULL, 0x0101010101010101ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0202020202020202ULL, 0x0202020202020202ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0301000301000301ULL, 0x0003010003010003ULL, },
+        { 0x0000020000020000ULL, 0x0200000200000200ULL, },
+        { 0x0404040404040404ULL, 0x0404040404040404ULL, },    /*   8  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0500000103050000ULL, 0x0103050000010305ULL, },
+        { 0x0002040000000204ULL, 0x0000000204000000ULL, },
+        { 0x0600020600020600ULL, 0x0206000206000206ULL, },
+        { 0x0004000004000004ULL, 0x0000040000040000ULL, },
+        { 0x0700050003000107ULL, 0x0005000300010700ULL, },
+        { 0x0006000400020000ULL, 0x0600040002000006ULL, },
+        { 0x0800080008000800ULL, 0x0800080008000800ULL, },    /*  16  */
+        { 0x0008000800080008ULL, 0x0008000800080008ULL, },
+        { 0x0801000300050007ULL, 0x0008010003000500ULL, },
+        { 0x0000020004000600ULL, 0x0800000200040006ULL, },
+        { 0x0802000600080200ULL, 0x0600080200060008ULL, },
+        { 0x0000040008000004ULL, 0x0008000004000800ULL, },
+        { 0x0803000801000700ULL, 0x0005000803000801ULL, },
+        { 0x0000060000040008ULL, 0x0200080000060000ULL, },
+        { 0x0804000804000804ULL, 0x0008040008040008ULL, },    /*  24  */
+        { 0x0000080000080000ULL, 0x0800000800000800ULL, },
+        { 0x0805000007000008ULL, 0x0100080300080500ULL, },
+        { 0x0000080200080400ULL, 0x0006000008000008ULL, },
+        { 0x0806000008020008ULL, 0x0600000802000806ULL, },
+        { 0x0000080400000800ULL, 0x0008040000080000ULL, },
+        { 0x0807000008050000ULL, 0x0803000008010008ULL, },
+        { 0x0000080600000804ULL, 0x0000080200000800ULL, },
+        { 0x0808000008080000ULL, 0x0808000008080000ULL, },    /*  32  */
+        { 0x0000080800000808ULL, 0x0000080800000808ULL, },
+        { 0x0808010000080300ULL, 0x0008050000080700ULL, },
+        { 0x0000000802000008ULL, 0x0400000806000008ULL, },
+        { 0x0808020000080600ULL, 0x0008080200000806ULL, },
+        { 0x0000000804000008ULL, 0x0800000008040000ULL, },
+        { 0x0808030000080801ULL, 0x0000080700000008ULL, },
+        { 0x0000000806000000ULL, 0x0804000008080200ULL, },
+        { 0x0808040000080804ULL, 0x0000080804000008ULL, },    /*  40  */
+        { 0x0000000808000000ULL, 0x0808000000080800ULL, },
+        { 0x0808050000000807ULL, 0x0000000808010000ULL, },
+        { 0x0000000808020000ULL, 0x0808040000000806ULL, },
+        { 0x0808060000000808ULL, 0x0200000808060000ULL, },
+        { 0x0000000808040000ULL, 0x0008080000000808ULL, },
+        { 0x0808070000000808ULL, 0x0500000008080300ULL, },
+        { 0x0000000808060000ULL, 0x0008080400000008ULL, },
+        { 0x0808080000000808ULL, 0x0800000008080800ULL, },    /*  48  */
+        { 0x0000000808080000ULL, 0x0008080800000008ULL, },
+        { 0x0808080100000008ULL, 0x0803000000080805ULL, },
+        { 0x0000000008080200ULL, 0x0000080804000000ULL, },
+        { 0x0808080200000008ULL, 0x0806000000080808ULL, },
+        { 0x0000000008080400ULL, 0x0000080808000000ULL, },
+        { 0x0808080300000008ULL, 0x0808010000000808ULL, },
+        { 0x0000000008080600ULL, 0x0000000808040000ULL, },
+        { 0x0808080400000008ULL, 0x0808040000000808ULL, },    /*  56  */
+        { 0x0000000008080800ULL, 0x0000000808080000ULL, },
+        { 0x0808080500000000ULL, 0x0808070000000008ULL, },
+        { 0x0000000008080802ULL, 0x0000000808080400ULL, },
+        { 0x0808080600000000ULL, 0x0808080200000008ULL, },
+        { 0x0000000008080804ULL, 0x0000000008080800ULL, },
+        { 0x0808080700000000ULL, 0x0808080500000000ULL, },
+        { 0x0000000008080806ULL, 0x0000000008080804ULL, },
+        { 0x0100030200000000ULL, 0x0000000007000100ULL, },    /*  64  */
+        { 0x0501000000010200ULL, 0x0004010000000006ULL, },
+        { 0x0100010101020101ULL, 0x0002020801000000ULL, },
+        { 0x0000000000000300ULL, 0x0104010201000301ULL, },
+        { 0x0101000000010000ULL, 0x0100000102020001ULL, },
+        { 0x0200010108000005ULL, 0x0000000007010000ULL, },
+        { 0x0100000000020100ULL, 0x0100000001040100ULL, },
+        { 0x0601000401010101ULL, 0x0106000000000001ULL, },
+        { 0x0000000200010300ULL, 0x0300030001010000ULL, },    /*  72  */
+        { 0x0100020000020302ULL, 0x0100010101030100ULL, },
+        { 0x0103040402020200ULL, 0x0102000000000000ULL, },
+        { 0x0101040400010001ULL, 0x0201030000010103ULL, },
+        { 0x0300000301000300ULL, 0x0100010200000200ULL, },
+        { 0x0100000600000001ULL, 0x0401000100000000ULL, },
+        { 0x0000000000010401ULL, 0x0300010402000000ULL, },
+        { 0x0100010104000201ULL, 0x0200020200000003ULL, },
+    };
+
+    reset_msa_registers();
+
+    gettimeofday(&start, NULL);
+
+    for (i = 0; i < TEST_COUNT_TOTAL; i++) {
+        if (i < PATTERN_INPUTS_COUNT) {
+            do_msa_MOVE_V(b128_pattern[i], b128_result[i]);
+        } else {
+            do_msa_MOVE_V(b128_random[i - PATTERN_INPUTS_COUNT],
+                          b128_result[i]);
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
-- 
2.7.4


