Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDF8C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962242054F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962242054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGMsw-0002Ac-QJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:08:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGMsB-0001ts-DK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGMsA-0003RY-2z
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:07:35 -0400
Received: from [110.188.70.11] (port=29349 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGMs7-0003Fj-TK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:07:34 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
	by spam2.hygon.cn with ESMTP id x3GC6qIA077720;
	Tue, 16 Apr 2019 20:06:53 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
	by MK-FE.hygon.cn with ESMTP id x3GC6GFB038363;
	Tue, 16 Apr 2019 20:06:16 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex02.Hygon.cn
	(172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3;
	Tue, 16 Apr 2019 20:06:47 +0800
From: Pu Wen <puwen@hygon.cn>
To: <qemu-devel@nongnu.org>
Date: Tue, 16 Apr 2019 20:06:13 +0800
Message-ID: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex02.Hygon.cn
	(172.23.18.12)
X-MAIL: spam2.hygon.cn x3GC6qIA077720
X-DNSRBL: 
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 110.188.70.11
Subject: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: ehabkost@redhat.com, mst@redhat.com, Pu Wen <puwen@hygon.cn>,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416120613.AssawzQA2abUYfiyuN7wt-IVhZBzgR3V8kbDv0fJLO0@z>

Add a new base CPU model called 'Dhyana' to model processors from Hygon
Dhyana(family 18h), which derived from AMD EPYC(family 17h).

The following features bits have been removed compare to AMD EPYC:
aes, pclmulqdq, sha_ni

The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
CPU model.

Reference:
[1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
v2->v3:
  - Remove the Dhyana machine types in the back-compat property tables
    since there is no Dhyana CPU model in older QEMU releases.

v1->v2:
  - Remove CPU model 'Dhyana' and rename the CPU model 'Dhyana-IBPB' to
    'Dhyana' because Dhyana CPUs already have the IBPB feature.

 target/i386/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d..d314c5f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2934,6 +2934,56 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "AMD EPYC Processor (with IBPB)",
         .cache_info = &epyc_cache_info,
     },
+    {
+        .name = "Dhyana",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_HYGON,
+        .family = 24,
+        .model = 0,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_IBPB,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT,
+        /*
+         * Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component.
+         */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel = 0x8000001E,
+        .model_id = "Hygon Dhyana Processor",
+        .cache_info = &epyc_cache_info,
+    },
 };
 
 typedef struct PropValue {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 83fb522..553dbe7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -726,6 +726,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_VENDOR_VIA   "CentaurHauls"
 
+#define CPUID_VENDOR_HYGON    "HygonGenuine"
+
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
-- 
2.7.4


