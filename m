Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36CC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EA12081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EA12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jGY-0005qN-JF
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7x-0004fa-Hq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7w-00029X-Ce
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7w-00028g-3y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEmMt-1hvvnu1rh5-00GJZm; Tue, 10 Sep 2019 18:36:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:47 +0200
Message-Id: <20190910163600.19971-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0KXaXHtt6r83pzwF5arVoOGeOG2MJZuwiWfdj6t9LUAuKaYJDOi
 KsXZfV/1poENgUcxzfe3k6IpKK2jX6ZTcTo3x5gQqnkKdQavG+p5K2aAK6Cxa5EOlnSgERM
 5d+l3DtXNeSrmJXmG4RuGsIAyNvOnMobh78rYctUyOVT4JfUVw1dTLgCe7eqzPJKYVuXklH
 MMYLLmkRVcUX7J48+l7yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S01fj9U4d/k=:gRbZXPngHBiiycGGbUtTrB
 g1+PyRCWvXGj9g95EuHEM3B09b2N3CQK5qeNq/Xbp4PikkuzX3e3kaeUjqz7uozjTMK18D27O
 KCR6AKdzPiEfFF8Mj/jIabT/CAhNvgPgBv3fsAH6xCn9Ve5GXnzujem9UVx0dg62sCLhH+Cjj
 4HxlKeR3Shii4y2E41tuw5sLOjqy3xEfJBGSU/sy9FoOerw87wPeQIWx9P3X+lMidNX3S9Q6Q
 PEbxme2e7v7XnAvbJ35e7mx4dE8XnZQ77PNeFMg8Php6ylHBbRA68KPrgaYb2kwJsip9q9FYZ
 rTdpxIxWaPFz02+tmu/d1ZNN7sfZoQFhw57dRQ5HCCv7iY3C/xYmpaFzI2vufEBjcrK9bb5vL
 AkuH9MXnboS0BtCU8zXO8xW0OyRqq7ByuvYLYhv7biR68XBbfOHrjmF7JXvYn2RsnW2ElF7uE
 t7Mf2b1097DdTfqtAdhe+3HKxzOdXmUwT1IS+J04cX3x2ZZIvdcF+x0n2PlE+965xVOtq36Yc
 4CYExUP8PphzAbWl/uL2XvI+rIpqD7lhGV0yeNGZEGzEivSuI6MEJv8B4AwShgyR0rxrWP73E
 l5va/CQhQi+V8j4NXIljjqkXXe5zZcGcmVtANhBOTgTrJtrQuYWaC5FLgbgc8ID4xBu6EzXqI
 3X6gV8g5ELSLx48K4f9IJNVruP3Y2UihlVLQlOon8US8AEW6fxcxqi0tlBtaivwk0U+/tr9fU
 1gOMo45DrKFVk38nZpnG658xLXbjloGxaZM2C1BZla5PHE5hTbqF67ls7mKjboaJUnxfsyeoi
 o/nnITporo6yuO5CFPFsGNUQnV1IfgXNntx7DZRCAKxvk44+Fg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 02/15] linux-user: Add AT_HWCAP2 for
 aarch64-linux-user
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Add the HWCAP2_* bits from kernel version v5.3-rc3.
Enable the bits corresponding to ARMv8.5-CondM and ARMv8.5-FRINT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190809171156.3476-1-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3365e192eb3f..43c16a846d33 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -607,9 +607,23 @@ enum {
     ARM_HWCAP_A64_SB            = 1 << 29,
     ARM_HWCAP_A64_PACA          = 1 << 30,
     ARM_HWCAP_A64_PACG          = 1UL << 31,
+
+    ARM_HWCAP2_A64_DCPODP       = 1 << 0,
+    ARM_HWCAP2_A64_SVE2         = 1 << 1,
+    ARM_HWCAP2_A64_SVEAES       = 1 << 2,
+    ARM_HWCAP2_A64_SVEPMULL     = 1 << 3,
+    ARM_HWCAP2_A64_SVEBITPERM   = 1 << 4,
+    ARM_HWCAP2_A64_SVESHA3      = 1 << 5,
+    ARM_HWCAP2_A64_SVESM4       = 1 << 6,
+    ARM_HWCAP2_A64_FLAGM2       = 1 << 7,
+    ARM_HWCAP2_A64_FRINT        = 1 << 8,
 };
 
-#define ELF_HWCAP get_elf_hwcap()
+#define ELF_HWCAP   get_elf_hwcap()
+#define ELF_HWCAP2  get_elf_hwcap2()
+
+#define GET_FEATURE_ID(feat, hwcap) \
+    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
 static uint32_t get_elf_hwcap(void)
 {
@@ -621,8 +635,6 @@ static uint32_t get_elf_hwcap(void)
     hwcaps |= ARM_HWCAP_A64_CPUID;
 
     /* probe for the extra features */
-#define GET_FEATURE_ID(feat, hwcap) \
-    do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
     GET_FEATURE_ID(aa64_aes, ARM_HWCAP_A64_AES);
     GET_FEATURE_ID(aa64_pmull, ARM_HWCAP_A64_PMULL);
@@ -645,11 +657,22 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
 
-#undef GET_FEATURE_ID
+    return hwcaps;
+}
+
+static uint32_t get_elf_hwcap2(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
+    GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
 
     return hwcaps;
 }
 
+#undef GET_FEATURE_ID
+
 #endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
-- 
2.21.0


