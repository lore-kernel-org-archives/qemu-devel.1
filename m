Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED210C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1ABF20854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ABF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLY1H-0007Cb-PA
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 15:02:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paul.c.lai@intel.com>) id 1hLY01-0006UH-Nb
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paul.c.lai@intel.com>) id 1hLY00-0004eQ-Ef
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:01:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:29737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <paul.c.lai@intel.com>)
	id 1hLY00-0004bB-60
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:01:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Apr 2019 12:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; d="scan'208";a="147079588"
Received: from pclaidev.sc.intel.com ([143.183.85.146])
	by orsmga003.jf.intel.com with ESMTP; 30 Apr 2019 12:00:59 -0700
From: Paul Lai <paul.c.lai@intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 11:59:18 -0700
Message-Id: <20190430185918.14937-1-paul.c.lai@intel.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [Qemu-devel v2] Introduce SnowRidge CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: wei.w.wang@intel.com, luwei.kang@intel.com, tao3.xu@intel.com,
	paul.c.lai@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430185918.J3m9xL-WoQ0Hvr5t3ZMvXj5J62XCEgahW0a4hG7ulP4@z>

SnowRidge CPU supports Accelerator Infrastrcture Architecture (MOVDIRI,
MOVDIR64B), CLDEMOTE and SPLIT_LOCK_DISABLE.

MOVDIRI, MOVDIR64B, and CLDEMOTE are found via CPUID.
The availability of SPLIT_LOCK_DISABLE is check via msr access

References can be found in either:
 https://software.intel.com/en-us/articles/intel-sdm
 https://software.intel.com/en-us/download/intel-architecture-instruction-set-extensions-and-future-features-programming-reference

Signed-off-by: Paul Lai <paul.c.lai@intel.com>
Tested-by: Tao3 Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..1c03d9f6b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2663,6 +2663,74 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Icelake)",
     },
+    {
+        .name = "SnowRidge",
+        .level = 27,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 134,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            /* missing: CPUID_PN CPUID_IA64 */
+            /* missing: CPUID_DTS, CPUID_HT, CPUID_TM, CPUID_PBE */
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE |
+            CPUID_TSC | CPUID_MSR | CPUID_PAE | CPUID_MCE |
+            CPUID_CX8 | CPUID_APIC | CPUID_SEP |
+            CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH |
+            CPUID_MMX |
+            CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
+            CPUID_EXT_VMX |
+            CPUID_EXT_SSSE3 |
+            CPUID_EXT_CX16 |
+            CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES | CPUID_EXT_XSAVE |
+            CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL |
+            CPUID_EXT2_NX |
+            CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE |
+            CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_MPX |  /* missing bits 13, 15 */
+            CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP |
+            /* missing bit 5 */
+            CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_MOVDIRI | CPUID_7_0_ECX_CLDEMOTE |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /*
+         * Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component,
+         * and the only one defined in Skylake (processor tracing)
+         * probably will block migration anyway.
+         */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Atom Processor (SnowRidge)",
+    },
     {
         .name = "KnightsMill",
         .level = 0xd,
-- 
2.17.2


