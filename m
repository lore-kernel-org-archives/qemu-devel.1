Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 06:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C47A20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 06:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C47A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCHwQ-0002gB-Ed
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 02:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iCHsA-0000Fd-8R
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iCHs8-0004oo-5Q
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:30:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:4527)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iCHs7-0004l4-Te
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 02:30:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Sep 2019 23:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; d="scan'208";a="182429905"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga008.jf.intel.com with ESMTP; 22 Sep 2019 23:30:53 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com, sgarzare@redhat.com, philmd@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Subject: [PATCH v3 2/2] target/i386: drop the duplicated definition of cpuid
 AVX512_VBMI marco
Date: Mon, 23 Sep 2019 14:30:41 +0800
Message-Id: <20190923063041.12420-3-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923063041.12420-1-tao3.xu@intel.com>
References: <20190923063041.12420-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop the duplicated definition of cpuid AVX512_VBMI marco and rename it
as CPUID_7_0_ECX_AVX512_VBMI.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c           | 4 ++--
 target/i386/cpu.h           | 3 +--
 target/i386/hvf/x86_cpuid.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e0bac31e8..f87fe88259 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2412,7 +2412,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
             CPUID_7_0_EBX_SMAP,
         .features[FEAT_7_0_ECX] =
-            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
             CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
             CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
             CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
@@ -2470,7 +2470,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
         .features[FEAT_7_0_ECX] =
-            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
             CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
             CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
             CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fa4c4cad79..61f6287294 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_AVX512VL          (1U << 31)
 
 /* AVX-512 Vector Byte Manipulation Instruction */
-#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
-#define CPUID_7_0_ECX_VBMI              (1U << 1)
+#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)
 /* User-Mode Instruction Prevention */
 #define CPUID_7_0_ECX_UMIP              (1U << 2)
 /* Protection Keys for User-mode Pages */
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 4d957fe896..16762b6eb4 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                 ebx &= ~CPUID_7_0_EBX_INVPCID;
             }
 
-            ecx &= CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
+            ecx &= CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
             edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
         } else {
             ebx = 0;
-- 
2.20.1


