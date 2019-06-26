Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6181AC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD9220663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD9220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg4rv-00087S-AZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg4pt-00069r-GX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg4po-0003PO-6s
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39470 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg4pn-0003NE-Gf
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id CA8261A1E5A;
 Wed, 26 Jun 2019 12:07:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 8BFD21A21E9;
 Wed, 26 Jun 2019 12:07:20 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 12:07:08 +0200
Message-Id: <1561543629-20327-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561543629-20327-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561543629-20327-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v6 7/8] tests/tcg: target/mips: Fix some test
 cases for pack MSA instructions
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

Fix certian test cases for MSA pack instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 64 +++++++++++-----------
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 64 +++++++++++-----------
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 64 +++++++++++-----------
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 64 +++++++++++-----------
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 64 +++++++++++-----------
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 64 +++++++++++-----------
 12 files changed, 384 insertions(+), 384 deletions(-)

diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index 4a4c9d6..2f4ffd9 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0xf71a3ffcbe639308ULL, 0xf1d842a04f4d314eULL, },
         { 0xd8ff2b145aaacf80ULL, 0xf1d842a04f4d314eULL, },
         { 0xf1d842a04f4d314eULL, 0xf1d842a04f4d314eULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x675e7b0c6acc6240ULL, 0xd8a04d4ed8a04d4eULL, },    /*  80  */
+        { 0xf71a3ffcbe639308ULL, 0xa04ea04e5e0ccc40ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0x4e4e0c401afc6308ULL, },
+        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
+        { 0x675e7b0c6acc6240ULL, 0x40081480d8a04d4eULL, },
+        { 0xf71a3ffcbe639308ULL, 0x0880a04e5e0ccc40ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0x804e0c401afc6308ULL, },
+        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
+        { 0x675e7b0c6acc6240ULL, 0x40081480d8a04d4eULL, },    /*  88  */
+        { 0xf71a3ffcbe639308ULL, 0x0880a04e5e0ccc40ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0x804e0c401afc6308ULL, },
+        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
+        { 0x675e7b0c6acc6240ULL, 0x40081480d8a04d4eULL, },
+        { 0xf71a3ffcbe639308ULL, 0x0880a04e5e0ccc40ULL, },
+        { 0xd8ff2b145aaacf80ULL, 0x804e0c401afc6308ULL, },
+        { 0xf1d842a04f4d314eULL, 0x4e40fc08ff14aa80ULL, },
+        { 0x40081480d8a04d4eULL, 0x675e7b0c6acc6240ULL, },    /*  96  */
+        { 0x5e0ccc400880a04eULL, 0x675e7b0c6acc6240ULL, },
+        { 0x5e0ccc400c40804eULL, 0x675e7b0c6acc6240ULL, },
+        { 0x5e0ccc400c40404eULL, 0x675e7b0c6acc6240ULL, },
+        { 0x5e0ccc400c40404eULL, 0xf71a3ffcbe639308ULL, },
+        { 0x1afc63080c40404eULL, 0xf71a3ffcbe639308ULL, },
+        { 0x1afc6308fc08404eULL, 0xf71a3ffcbe639308ULL, },
+        { 0x1afc6308fc08084eULL, 0xf71a3ffcbe639308ULL, },
+        { 0x1afc6308fc08084eULL, 0xd8ff2b145aaacf80ULL, },    /* 104  */
+        { 0xff14aa80fc08084eULL, 0xd8ff2b145aaacf80ULL, },
+        { 0xff14aa801480084eULL, 0xd8ff2b145aaacf80ULL, },
+        { 0xff14aa801480804eULL, 0xd8ff2b145aaacf80ULL, },
+        { 0xff14aa801480804eULL, 0xf1d842a04f4d314eULL, },
+        { 0xd8a04d4e1480804eULL, 0xf1d842a04f4d314eULL, },
+        { 0xd8a04d4ea04e804eULL, 0xf1d842a04f4d314eULL, },
+        { 0xd8a04d4ea04e4e4eULL, 0xf1d842a04f4d314eULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index 67df606..3f0bd47 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0xfbbe00634d93c708ULL, 0x704f164d5e31e24eULL, },
         { 0xac5aaeaab9cf8b80ULL, 0x704f164d5e31e24eULL, },
         { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },    /*  80  */
+        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },
+        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },    /*  88  */
+        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x886ae6cc28625540ULL, 0x704f164d5e31e24eULL, },
+        { 0xfbbe00634d93c708ULL, 0x886ae6cc28625540ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },    /*  96  */
+        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
+        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
+        { 0x704f164d5e31e24eULL, 0x886ae6cc28625540ULL, },
+        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xfbbe00634d93c708ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },    /* 104  */
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x704f164d5e31e24eULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
+        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
+        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
+        { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index 22d043c..2eae01f 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0xbb1a52fc0063c708ULL, 0x88d8e2a0164de24eULL, },
         { 0xc6ff2514aeaa8b80ULL, 0x88d8e2a0164de24eULL, },
         { 0x88d8e2a0164de24eULL, 0x88d8e2a0164de24eULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0xe2a0e24ee2a0e24eULL, },    /*  80  */
+        { 0xbb1a52fc0063c708ULL, 0xe24ee24eb00c5540ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
+        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0xc7088b80e2a0e24eULL, },
+        { 0xbb1a52fc0063c708ULL, 0x8b80e24eb00c5540ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
+        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0xc7088b80e2a0e24eULL, },    /*  88  */
+        { 0xbb1a52fc0063c708ULL, 0x8b80e24eb00c5540ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
+        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
+        { 0x0b5eb00ce6cc5540ULL, 0xc7088b80e2a0e24eULL, },
+        { 0xbb1a52fc0063c708ULL, 0x8b80e24eb00c5540ULL, },
+        { 0xc6ff2514aeaa8b80ULL, 0xe24e554052fcc708ULL, },
+        { 0x88d8e2a0164de24eULL, 0x5540c70825148b80ULL, },
+        { 0xc7088b80e2a0e24eULL, 0x0b5eb00ce6cc5540ULL, },    /*  96  */
+        { 0xb00c55408b80e24eULL, 0x0b5eb00ce6cc5540ULL, },
+        { 0xb00c55405540e24eULL, 0x0b5eb00ce6cc5540ULL, },
+        { 0xb00c55405540e24eULL, 0x0b5eb00ce6cc5540ULL, },
+        { 0xb00c55405540e24eULL, 0xbb1a52fc0063c708ULL, },
+        { 0x52fcc7085540e24eULL, 0xbb1a52fc0063c708ULL, },
+        { 0x52fcc708c708e24eULL, 0xbb1a52fc0063c708ULL, },
+        { 0x52fcc708c708e24eULL, 0xbb1a52fc0063c708ULL, },
+        { 0x52fcc708c708e24eULL, 0xc6ff2514aeaa8b80ULL, },    /* 104  */
+        { 0x25148b80c708e24eULL, 0xc6ff2514aeaa8b80ULL, },
+        { 0x25148b808b80e24eULL, 0xc6ff2514aeaa8b80ULL, },
+        { 0x25148b808b80e24eULL, 0xc6ff2514aeaa8b80ULL, },
+        { 0x25148b808b80e24eULL, 0x88d8e2a0164de24eULL, },
+        { 0xe2a0e24e8b80e24eULL, 0x88d8e2a0164de24eULL, },
+        { 0xe2a0e24ee24ee24eULL, 0x88d8e2a0164de24eULL, },
+        { 0xe2a0e24ee24ee24eULL, 0x88d8e2a0164de24eULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index 1a9c2df..f7215d0 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x153f52fc4d93c708ULL, 0xa942e2a05e31e24eULL, },
         { 0xab2b2514b9cf8b80ULL, 0xa942e2a05e31e24eULL, },
         { 0xa942e2a05e31e24eULL, 0xa942e2a05e31e24eULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0xfe7bb00c28625540ULL, 0x5e31e24e5e31e24eULL, },    /*  80  */
+        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
+        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
+        { 0xfe7bb00c28625540ULL, 0xb9cf8b805e31e24eULL, },
+        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
+        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
+        { 0xfe7bb00c28625540ULL, 0xb9cf8b805e31e24eULL, },    /*  88  */
+        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
+        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
+        { 0xfe7bb00c28625540ULL, 0xb9cf8b805e31e24eULL, },
+        { 0x153f52fc4d93c708ULL, 0x5e31e24e28625540ULL, },
+        { 0xab2b2514b9cf8b80ULL, 0x286255404d93c708ULL, },
+        { 0xa942e2a05e31e24eULL, 0x4d93c708b9cf8b80ULL, },
+        { 0xb9cf8b805e31e24eULL, 0xfe7bb00c28625540ULL, },    /*  96  */
+        { 0x286255405e31e24eULL, 0xfe7bb00c28625540ULL, },
+        { 0x286255405e31e24eULL, 0xfe7bb00c28625540ULL, },
+        { 0x286255405e31e24eULL, 0xfe7bb00c28625540ULL, },
+        { 0x286255405e31e24eULL, 0x153f52fc4d93c708ULL, },
+        { 0x4d93c7085e31e24eULL, 0x153f52fc4d93c708ULL, },
+        { 0x4d93c7085e31e24eULL, 0x153f52fc4d93c708ULL, },
+        { 0x4d93c7085e31e24eULL, 0x153f52fc4d93c708ULL, },
+        { 0x4d93c7085e31e24eULL, 0xab2b2514b9cf8b80ULL, },    /* 104  */
+        { 0xb9cf8b805e31e24eULL, 0xab2b2514b9cf8b80ULL, },
+        { 0xb9cf8b805e31e24eULL, 0xab2b2514b9cf8b80ULL, },
+        { 0xb9cf8b805e31e24eULL, 0xab2b2514b9cf8b80ULL, },
+        { 0xb9cf8b805e31e24eULL, 0xa942e2a05e31e24eULL, },
+        { 0x5e31e24e5e31e24eULL, 0xa942e2a05e31e24eULL, },
+        { 0x5e31e24e5e31e24eULL, 0xa942e2a05e31e24eULL, },
+        { 0x5e31e24e5e31e24eULL, 0xa942e2a05e31e24eULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index 15ef377..6355338 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x12bb1552fb004dc7ULL, 0x8d88a9e270165ee2ULL, },
         { 0x27c6ab25acaeb98bULL, 0x8d88a9e270165ee2ULL, },
         { 0x8d88a9e270165ee2ULL, 0x8d88a9e270165ee2ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x4b0bfeb088e62855ULL, 0x8da9705e8da9705eULL, },    /*  80  */
+        { 0x12bb1552fb004dc7ULL, 0x8d708d704bfe8828ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
+        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
+        { 0x4b0bfeb088e62855ULL, 0x8d1227ac8da9705eULL, },
+        { 0x12bb1552fb004dc7ULL, 0x8d278d704bfe8828ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
+        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
+        { 0x4b0bfeb088e62855ULL, 0x8d1227ac8da9705eULL, },    /*  88  */
+        { 0x12bb1552fb004dc7ULL, 0x8d278d704bfe8828ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
+        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
+        { 0x4b0bfeb088e62855ULL, 0x8d1227ac8da9705eULL, },
+        { 0x12bb1552fb004dc7ULL, 0x8d278d704bfe8828ULL, },
+        { 0x27c6ab25acaeb98bULL, 0x8d8d4b881215fb4dULL, },
+        { 0x8d88a9e270165ee2ULL, 0x8d4b12fb27abacb9ULL, },
+        { 0x8d1227ac8da9705eULL, 0x4b0bfeb088e62855ULL, },    /*  96  */
+        { 0x4bfe88288d278d70ULL, 0x4b0bfeb088e62855ULL, },
+        { 0x4bfe88284b888d8dULL, 0x4b0bfeb088e62855ULL, },
+        { 0x4bfe88284b884b8dULL, 0x4b0bfeb088e62855ULL, },
+        { 0x4bfe88284b884b4bULL, 0x12bb1552fb004dc7ULL, },
+        { 0x1215fb4d4b884b4bULL, 0x12bb1552fb004dc7ULL, },
+        { 0x1215fb4d12fb4b4bULL, 0x12bb1552fb004dc7ULL, },
+        { 0x1215fb4d12fb124bULL, 0x12bb1552fb004dc7ULL, },
+        { 0x1215fb4d12fb1212ULL, 0x27c6ab25acaeb98bULL, },    /* 104  */
+        { 0x27abacb912fb1212ULL, 0x27c6ab25acaeb98bULL, },
+        { 0x27abacb927ac1212ULL, 0x27c6ab25acaeb98bULL, },
+        { 0x27abacb927ac2712ULL, 0x27c6ab25acaeb98bULL, },
+        { 0x27abacb927ac2727ULL, 0x8d88a9e270165ee2ULL, },
+        { 0x8da9705e27ac2727ULL, 0x8d88a9e270165ee2ULL, },
+        { 0x8da9705e8d702727ULL, 0x8d88a9e270165ee2ULL, },
+        { 0x8da9705e8d708d27ULL, 0x8d88a9e270165ee2ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index e3997cd..ac75526 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
         { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
         { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },    /*  80  */
+        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },
+        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },    /*  88  */
+        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x4b670b5efe7bb00cULL, 0x8df188d8a942e2a0ULL, },
+        { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x4b670b5efe7bb00cULL, },    /*  96  */
+        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x4b670b5efe7bb00cULL, },
+        { 0x4b670b5efe7bb00cULL, 0x12f7bb1a153f52fcULL, },
+        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
+        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
+        { 0x12f7bb1a153f52fcULL, 0x12f7bb1a153f52fcULL, },
+        { 0x12f7bb1a153f52fcULL, 0x27d8c6ffab2b2514ULL, },    /* 104  */
+        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x27d8c6ffab2b2514ULL, },
+        { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index 2a29ac0..12c1fa1 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x12f7153ffbbe4d93ULL, 0x8df1a942704f5e31ULL, },
         { 0x27d8ab2bac5ab9cfULL, 0x8df1a942704f5e31ULL, },
         { 0x8df1a942704f5e31ULL, 0x8df1a942704f5e31ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x4b67fe7b886a2862ULL, 0x8df1704f8df1704fULL, },    /*  80  */
+        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
+        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
+        { 0x4b67fe7b886a2862ULL, 0x8df127d88df1704fULL, },
+        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
+        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
+        { 0x4b67fe7b886a2862ULL, 0x8df127d88df1704fULL, },    /*  88  */
+        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
+        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
+        { 0x4b67fe7b886a2862ULL, 0x8df127d88df1704fULL, },
+        { 0x12f7153ffbbe4d93ULL, 0x8df18df14b67886aULL, },
+        { 0x27d8ab2bac5ab9cfULL, 0x8df14b6712f7fbbeULL, },
+        { 0x8df1a942704f5e31ULL, 0x8df112f727d8ac5aULL, },
+        { 0x8df127d88df1704fULL, 0x4b67fe7b886a2862ULL, },    /*  96  */
+        { 0x4b67886a8df18df1ULL, 0x4b67fe7b886a2862ULL, },
+        { 0x4b67886a4b678df1ULL, 0x4b67fe7b886a2862ULL, },
+        { 0x4b67886a4b674b67ULL, 0x4b67fe7b886a2862ULL, },
+        { 0x4b67886a4b674b67ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x12f7fbbe4b674b67ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x12f7fbbe12f74b67ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x12f7fbbe12f712f7ULL, 0x12f7153ffbbe4d93ULL, },
+        { 0x12f7fbbe12f712f7ULL, 0x27d8ab2bac5ab9cfULL, },    /* 104  */
+        { 0x27d8ac5a12f712f7ULL, 0x27d8ab2bac5ab9cfULL, },
+        { 0x27d8ac5a27d812f7ULL, 0x27d8ab2bac5ab9cfULL, },
+        { 0x27d8ac5a27d827d8ULL, 0x27d8ab2bac5ab9cfULL, },
+        { 0x27d8ac5a27d827d8ULL, 0x8df1a942704f5e31ULL, },
+        { 0x8df1704f27d827d8ULL, 0x8df1a942704f5e31ULL, },
+        { 0x8df1704f8df127d8ULL, 0x8df1a942704f5e31ULL, },
+        { 0x8df1704f8df18df1ULL, 0x8df1a942704f5e31ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index a3fbe25..b8979c3 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x12f7bb1afbbe0063ULL, 0x8df188d8704f164dULL, },
         { 0x27d8c6ffac5aaeaaULL, 0x8df188d8704f164dULL, },
         { 0x8df188d8704f164dULL, 0x8df188d8704f164dULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },    /*  80  */
+        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
+        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
+        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },
+        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
+        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
+        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },    /*  88  */
+        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
+        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
+        { 0x4b670b5e886ae6ccULL, 0x8df188d88df188d8ULL, },
+        { 0x12f7bb1afbbe0063ULL, 0x8df188d84b670b5eULL, },
+        { 0x27d8c6ffac5aaeaaULL, 0x8df188d812f7bb1aULL, },
+        { 0x8df188d8704f164dULL, 0x8df188d827d8c6ffULL, },
+        { 0x8df188d88df188d8ULL, 0x4b670b5e886ae6ccULL, },    /*  96  */
+        { 0x4b670b5e8df188d8ULL, 0x4b670b5e886ae6ccULL, },
+        { 0x4b670b5e4b670b5eULL, 0x4b670b5e886ae6ccULL, },
+        { 0x4b670b5e4b670b5eULL, 0x4b670b5e886ae6ccULL, },
+        { 0x4b670b5e4b670b5eULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x12f7bb1a4b670b5eULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x12f7bb1a12f7bb1aULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x12f7bb1a12f7bb1aULL, 0x12f7bb1afbbe0063ULL, },
+        { 0x12f7bb1a12f7bb1aULL, 0x27d8c6ffac5aaeaaULL, },    /* 104  */
+        { 0x27d8c6ff12f7bb1aULL, 0x27d8c6ffac5aaeaaULL, },
+        { 0x27d8c6ff27d8c6ffULL, 0x27d8c6ffac5aaeaaULL, },
+        { 0x27d8c6ff27d8c6ffULL, 0x27d8c6ffac5aaeaaULL, },
+        { 0x27d8c6ff27d8c6ffULL, 0x8df188d8704f164dULL, },
+        { 0x8df188d827d8c6ffULL, 0x8df188d8704f164dULL, },
+        { 0x8df188d88df188d8ULL, 0x8df188d8704f164dULL, },
+        { 0x8df188d88df188d8ULL, 0x8df188d8704f164dULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index eedb7d8..1839a26 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0x8080808080808080ULL, 0x8080808080808080ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },    /*  80  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x4040404040404040ULL, 0x4040404040404040ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8080808080808080ULL, 0x8080808080808080ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index 85a8f0d..ebc198f 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  80  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x886ae6cc28625540ULL, 0x886ae6cc28625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index 8d416bc..a724013 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },    /*  80  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x5540554055405540ULL, 0x5540554055405540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index fd8f02d..607ac4f 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -123,38 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
-        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
-        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
-        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
-        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
-        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
-        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
-        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
-        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
-        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
-        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
-        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
-        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
-        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
-        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
-        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },    /*  80  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x2862554028625540ULL, 0x2862554028625540ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /*  96  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },    /* 104  */
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
-- 
2.7.4


