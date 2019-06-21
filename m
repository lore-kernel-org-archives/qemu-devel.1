Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F06C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 10:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CF920665
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 10:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CF920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heGM3-0002hI-11
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 06:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1heGHE-0006Xx-1y
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1heGH9-0005dZ-D5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:56:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38663 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1heGH8-0005cZ-W1
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:56:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D801C1A45ED;
 Fri, 21 Jun 2019 11:54:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 602C71A452A;
 Fri, 21 Jun 2019 11:54:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 11:54:44 +0200
Message-Id: <1561110888-14022-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561110888-14022-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561110888-14022-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 06/10] tests/tcg: target/mips: Amend tests for
 MSA pack instructions
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

Add tests for cases when destination register is the same as one
of source registers.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1561031359-6727-3-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/include/wrappers_msa.h              | 24 +++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 58 +++++++++++++++++++++-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 58 +++++++++++++++++++++-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 58 +++++++++++++++++++++-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 58 +++++++++++++++++++++-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 58 +++++++++++++++++++++-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 58 +++++++++++++++++++++-
 13 files changed, 708 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 5d28cb5..9570aa8 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -555,19 +555,43 @@ DO_MSA__WD__WS_WT(XOR_V, xor.v)
  */
 
 DO_MSA__WD__WS_WT(PCKEV_B, pckev.b)
+DO_MSA__WD__WD_WT(PCKEV_B__DDT, pckev.b)
+DO_MSA__WD__WS_WD(PCKEV_B__DSD, pckev.b)
 DO_MSA__WD__WS_WT(PCKEV_H, pckev.h)
+DO_MSA__WD__WD_WT(PCKEV_H__DDT, pckev.h)
+DO_MSA__WD__WS_WD(PCKEV_H__DSD, pckev.h)
 DO_MSA__WD__WS_WT(PCKEV_W, pckev.w)
+DO_MSA__WD__WD_WT(PCKEV_W__DDT, pckev.w)
+DO_MSA__WD__WS_WD(PCKEV_W__DSD, pckev.w)
 DO_MSA__WD__WS_WT(PCKEV_D, pckev.d)
+DO_MSA__WD__WD_WT(PCKEV_D__DDT, pckev.d)
+DO_MSA__WD__WS_WD(PCKEV_D__DSD, pckev.d)
 
 DO_MSA__WD__WS_WT(PCKOD_B, pckod.b)
+DO_MSA__WD__WD_WT(PCKOD_B__DDT, pckod.b)
+DO_MSA__WD__WS_WD(PCKOD_B__DSD, pckod.b)
 DO_MSA__WD__WS_WT(PCKOD_H, pckod.h)
+DO_MSA__WD__WD_WT(PCKOD_H__DDT, pckod.h)
+DO_MSA__WD__WS_WD(PCKOD_H__DSD, pckod.h)
 DO_MSA__WD__WS_WT(PCKOD_W, pckod.w)
+DO_MSA__WD__WD_WT(PCKOD_W__DDT, pckod.w)
+DO_MSA__WD__WS_WD(PCKOD_W__DSD, pckod.w)
 DO_MSA__WD__WS_WT(PCKOD_D, pckod.d)
+DO_MSA__WD__WD_WT(PCKOD_D__DDT, pckod.d)
+DO_MSA__WD__WS_WD(PCKOD_D__DSD, pckod.d)
 
 DO_MSA__WD__WS_WT(VSHF_B, vshf.b)
+DO_MSA__WD__WD_WT(VSHF_B__DDT, vshf.b)
+DO_MSA__WD__WS_WD(VSHF_B__DSD, vshf.b)
 DO_MSA__WD__WS_WT(VSHF_H, vshf.h)
+DO_MSA__WD__WD_WT(VSHF_H__DDT, vshf.h)
+DO_MSA__WD__WS_WD(VSHF_H__DSD, vshf.h)
 DO_MSA__WD__WS_WT(VSHF_W, vshf.w)
+DO_MSA__WD__WD_WT(VSHF_W__DDT, vshf.w)
+DO_MSA__WD__WS_WD(VSHF_W__DSD, vshf.w)
 DO_MSA__WD__WS_WT(VSHF_D, vshf.d)
+DO_MSA__WD__WD_WT(VSHF_D__DDT, vshf.d)
+DO_MSA__WD__WS_WD(VSHF_D__DSD, vshf.d)
 
 
 /*
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index 70cef5b..4a4c9d6 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0xf71a3ffcbe639308ULL, 0xf1d842a04f4d314eULL, },
         { 0xd8ff2b145aaacf80ULL, 0xf1d842a04f4d314eULL, },
         { 0xf1d842a04f4d314eULL, 0xf1d842a04f4d314eULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_B__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKEV_B__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index 8a1d18f..67df606 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0xfbbe00634d93c708ULL, 0x704f164d5e31e24eULL, },
         { 0xac5aaeaab9cf8b80ULL, 0x704f164d5e31e24eULL, },
         { 0x704f164d5e31e24eULL, 0x704f164d5e31e24eULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_D__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKEV_D__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index c8636ba..22d043c 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0xbb1a52fc0063c708ULL, 0x88d8e2a0164de24eULL, },
         { 0xc6ff2514aeaa8b80ULL, 0x88d8e2a0164de24eULL, },
         { 0x88d8e2a0164de24eULL, 0x88d8e2a0164de24eULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_H__DDT(b128_random[i], b128_random[j],
+                              b128_result[
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
+            do_msa_PCKEV_H__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index 7ceab05..1a9c2df 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x153f52fc4d93c708ULL, 0xa942e2a05e31e24eULL, },
         { 0xab2b2514b9cf8b80ULL, 0xa942e2a05e31e24eULL, },
         { 0xa942e2a05e31e24eULL, 0xa942e2a05e31e24eULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKEV_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKEV_W__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index b6f5e08..15ef377 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x12bb1552fb004dc7ULL, 0x8d88a9e270165ee2ULL, },
         { 0x27c6ab25acaeb98bULL, 0x8d88a9e270165ee2ULL, },
         { 0x8d88a9e270165ee2ULL, 0x8d88a9e270165ee2ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_B__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKOD_B__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index c4b2386..e3997cd 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x12f7bb1a153f52fcULL, 0x8df188d8a942e2a0ULL, },
         { 0x27d8c6ffab2b2514ULL, 0x8df188d8a942e2a0ULL, },
         { 0x8df188d8a942e2a0ULL, 0x8df188d8a942e2a0ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_D__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKOD_D__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index 36329e7..2a29ac0 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x12f7153ffbbe4d93ULL, 0x8df1a942704f5e31ULL, },
         { 0x27d8ab2bac5ab9cfULL, 0x8df1a942704f5e31ULL, },
         { 0x8df1a942704f5e31ULL, 0x8df1a942704f5e31ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_H__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKOD_H__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index 3bc4223..a3fbe25 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x12f7bb1afbbe0063ULL, 0x8df188d8704f164dULL, },
         { 0x27d8c6ffac5aaeaaULL, 0x8df188d8704f164dULL, },
         { 0x8df188d8704f164dULL, 0x8df188d8704f164dULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_PCKOD_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_PCKOD_W__DSD(b128_random[i], b128_random[j],
+                                b128_result[
+                                    ((PATTERN_INPUTS_SHORT_COUNT) *
+                                     (PATTERN_INPUTS_SHORT_COUNT)) +
+                                    (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                     (RANDOM_INPUTS_SHORT_COUNT)) +
+                                    RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index 16f63c2..eedb7d8 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0x8080808080808080ULL, 0x8080808080808080ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_B__DDT(b128_random[i], b128_random[j],
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
+            do_msa_VSHF_B__DSD(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index 5033b63..85a8f0d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0xac5aaeaab9cf8b80ULL, 0xac5aaeaab9cf8b80ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_D__DDT(b128_random[i], b128_random[j],
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
+            do_msa_VSHF_D__DSD(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index 7de1f36..8d416bc 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0x8b808b808b808b80ULL, 0x8b808b808b808b80ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_H__DDT(b128_random[i], b128_random[j],
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
+            do_msa_VSHF_H__DSD(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index c19fb72..fd8f02d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -28,7 +28,7 @@
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-            (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
+            3 * (RANDOM_INPUTS_SHORT_COUNT) * (RANDOM_INPUTS_SHORT_COUNT))
 
 
 int32_t main(void)
@@ -123,6 +123,38 @@ int32_t main(void)
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
         { 0xb9cf8b80b9cf8b80ULL, 0xb9cf8b80b9cf8b80ULL, },
         { 0x0000000000000000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  80  */
+        { 0x00000000fc000000ULL, 0x000015000000001aULL, },
+        { 0x0000000014000000ULL, 0x0000ab00000000ffULL, },
+        { 0x00000000a0000000ULL, 0x0000a900000000d8ULL, },
+        { 0x000040000000000cULL, 0x9300003f00120000ULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000800000000014ULL, 0x9300003f00120000ULL, },
+        { 0x00004e00000000a0ULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0x8800000000fee6aaULL, },    /*  88  */
+        { 0x0000000000000000ULL, 0xfb000000001500aaULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x0000000000000000ULL, 0x7000000000a916aaULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /*  96  */
+        { 0x00000800000000fcULL, 0x6200007be64b0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeccULL, },
+        { 0x00006a0000550000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x9300003f00120000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae63ULL, },
+        { 0x0000be0000c70000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },    /* 104  */
+        { 0x00000800000000fcULL, 0xcf00002bae270000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abaeaaULL, },
+        { 0x00005a00008b0000ULL, 0x0000000000000000ULL, },
+        { 0x000000000c000000ULL, 0x0000fe000000005eULL, },
+        { 0x00000800000000fcULL, 0x31000042168d0000ULL, },
+        { 0x0000000000000000ULL, 0xac00000000abae4dULL, },
+        { 0x00004f0000e20000ULL, 0x0000000000000000ULL, },
     };
 
     reset_msa_registers();
@@ -145,6 +177,30 @@ int32_t main(void)
         }
     }
 
+    for (i = 0; i < RANDOM_INPUTS_SHORT_COUNT; i++) {
+        for (j = 0; j < RANDOM_INPUTS_SHORT_COUNT; j++) {
+            do_msa_VSHF_W__DDT(b128_random[i], b128_random[j],
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
+            do_msa_VSHF_W__DSD(b128_random[i], b128_random[j],
+                               b128_result[
+                                   ((PATTERN_INPUTS_SHORT_COUNT) *
+                                    (PATTERN_INPUTS_SHORT_COUNT)) +
+                                   (2 * (RANDOM_INPUTS_SHORT_COUNT) *
+                                    (RANDOM_INPUTS_SHORT_COUNT)) +
+                                   RANDOM_INPUTS_SHORT_COUNT * i + j]);
+        }
+    }
+
     gettimeofday(&end, NULL);
 
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
-- 
2.7.4


