Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70597C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 02:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A22F222BD
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 02:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A22F222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDJGT-0001hI-Aw
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 22:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iDJFM-0000QG-H3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iDJFJ-00086O-W3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:11:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:8123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iDJFJ-0007zX-Oz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:11:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 19:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="340608107"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga004.jf.intel.com with ESMTP; 25 Sep 2019 19:11:00 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com, sgarzare@redhat.com, philmd@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Subject: [PATCH v5 1/2] target/i386: clean up comments over 80 chars per line
Date: Thu, 26 Sep 2019 10:10:54 +0800
Message-Id: <20190926021055.6970-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926021055.6970-1-tao3.xu@intel.com>
References: <20190926021055.6970-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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

Add some comments, clean up comments over 80 chars per line. And there
is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD, remove
the extra enter and spaces.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 target/i386/cpu.h | 164 ++++++++++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 57 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5f6e3a029a..fa4c4cad79 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -641,63 +641,113 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_SVM_PAUSEFILTER  (1U << 10)
 #define CPUID_SVM_PFTHRESHOLD  (1U << 12)
 
-#define CPUID_7_0_EBX_FSGSBASE (1U << 0)
-#define CPUID_7_0_EBX_BMI1     (1U << 3)
-#define CPUID_7_0_EBX_HLE      (1U << 4)
-#define CPUID_7_0_EBX_AVX2     (1U << 5)
-#define CPUID_7_0_EBX_SMEP     (1U << 7)
-#define CPUID_7_0_EBX_BMI2     (1U << 8)
-#define CPUID_7_0_EBX_ERMS     (1U << 9)
-#define CPUID_7_0_EBX_INVPCID  (1U << 10)
-#define CPUID_7_0_EBX_RTM      (1U << 11)
-#define CPUID_7_0_EBX_MPX      (1U << 14)
-#define CPUID_7_0_EBX_AVX512F  (1U << 16) /* AVX-512 Foundation */
-#define CPUID_7_0_EBX_AVX512DQ (1U << 17) /* AVX-512 Doubleword & Quadword Instrs */
-#define CPUID_7_0_EBX_RDSEED   (1U << 18)
-#define CPUID_7_0_EBX_ADX      (1U << 19)
-#define CPUID_7_0_EBX_SMAP     (1U << 20)
-#define CPUID_7_0_EBX_AVX512IFMA (1U << 21) /* AVX-512 Integer Fused Multiply Add */
-#define CPUID_7_0_EBX_PCOMMIT  (1U << 22) /* Persistent Commit */
-#define CPUID_7_0_EBX_CLFLUSHOPT (1U << 23) /* Flush a Cache Line Optimized */
-#define CPUID_7_0_EBX_CLWB     (1U << 24) /* Cache Line Write Back */
-#define CPUID_7_0_EBX_INTEL_PT (1U << 25) /* Intel Processor Trace */
-#define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
-#define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
-#define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
-#define CPUID_7_0_EBX_SHA_NI   (1U << 29) /* SHA1/SHA256 Instruction Extensions */
-#define CPUID_7_0_EBX_AVX512BW (1U << 30) /* AVX-512 Byte and Word Instructions */
-#define CPUID_7_0_EBX_AVX512VL (1U << 31) /* AVX-512 Vector Length Extensions */
-
-#define CPUID_7_0_ECX_AVX512BMI (1U << 1)
-#define CPUID_7_0_ECX_VBMI     (1U << 1)  /* AVX-512 Vector Byte Manipulation Instrs */
-#define CPUID_7_0_ECX_UMIP     (1U << 2)
-#define CPUID_7_0_ECX_PKU      (1U << 3)
-#define CPUID_7_0_ECX_OSPKE    (1U << 4)
-#define CPUID_7_0_ECX_VBMI2    (1U << 6) /* Additional VBMI Instrs */
-#define CPUID_7_0_ECX_GFNI     (1U << 8)
-#define CPUID_7_0_ECX_VAES     (1U << 9)
-#define CPUID_7_0_ECX_VPCLMULQDQ (1U << 10)
-#define CPUID_7_0_ECX_AVX512VNNI (1U << 11)
-#define CPUID_7_0_ECX_AVX512BITALG (1U << 12)
-#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
-#define CPUID_7_0_ECX_LA57     (1U << 16)
-#define CPUID_7_0_ECX_RDPID    (1U << 22)
-#define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
-#define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
-#define CPUID_7_0_ECX_MOVDIR64B (1U << 28) /* MOVDIR64B Instruction */
-
-#define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
-#define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
-#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
-#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
-#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)  /*Core Capability*/
-#define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
-
-#define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
-
-#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
-                                                                             do not invalidate cache */
-#define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
+/* Support RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE */
+#define CPUID_7_0_EBX_FSGSBASE          (1U << 0)
+/* 1st Group of Advanced Bit Manipulation Extensions */
+#define CPUID_7_0_EBX_BMI1              (1U << 3)
+/* Hardware Lock Elision */
+#define CPUID_7_0_EBX_HLE               (1U << 4)
+/* Intel Advanced Vector Extensions 2 */
+#define CPUID_7_0_EBX_AVX2              (1U << 5)
+/* Supervisor-mode Execution Prevention */
+#define CPUID_7_0_EBX_SMEP              (1U << 7)
+/* 2nd Group of Advanced Bit Manipulation Extensions */
+#define CPUID_7_0_EBX_BMI2              (1U << 8)
+/* Enhanced REP MOVSB/STOSB */
+#define CPUID_7_0_EBX_ERMS              (1U << 9)
+/* Invalidate Process-Context Identifier */
+#define CPUID_7_0_EBX_INVPCID           (1U << 10)
+/* Restricted Transactional Memory */
+#define CPUID_7_0_EBX_RTM               (1U << 11)
+/* Memory Protection Extension */
+#define CPUID_7_0_EBX_MPX               (1U << 14)
+/* AVX-512 Foundation */
+#define CPUID_7_0_EBX_AVX512F           (1U << 16)
+/* AVX-512 Doubleword & Quadword Instruction */
+#define CPUID_7_0_EBX_AVX512DQ          (1U << 17)
+/* Read Random SEED */
+#define CPUID_7_0_EBX_RDSEED            (1U << 18)
+/* ADCX and ADOX instructions */
+#define CPUID_7_0_EBX_ADX               (1U << 19)
+/* Supervisor Mode Access Prevention */
+#define CPUID_7_0_EBX_SMAP              (1U << 20)
+/* AVX-512 Integer Fused Multiply Add */
+#define CPUID_7_0_EBX_AVX512IFMA        (1U << 21)
+/* Persistent Commit */
+#define CPUID_7_0_EBX_PCOMMIT           (1U << 22)
+/* Flush a Cache Line Optimized */
+#define CPUID_7_0_EBX_CLFLUSHOPT        (1U << 23)
+/* Cache Line Write Back */
+#define CPUID_7_0_EBX_CLWB              (1U << 24)
+/* Intel Processor Trace */
+#define CPUID_7_0_EBX_INTEL_PT          (1U << 25)
+/* AVX-512 Prefetch */
+#define CPUID_7_0_EBX_AVX512PF          (1U << 26)
+/* AVX-512 Exponential and Reciprocal */
+#define CPUID_7_0_EBX_AVX512ER          (1U << 27)
+/* AVX-512 Conflict Detection */
+#define CPUID_7_0_EBX_AVX512CD          (1U << 28)
+/* SHA1/SHA256 Instruction Extensions */
+#define CPUID_7_0_EBX_SHA_NI            (1U << 29)
+/* AVX-512 Byte and Word Instructions */
+#define CPUID_7_0_EBX_AVX512BW          (1U << 30)
+/* AVX-512 Vector Length Extensions */
+#define CPUID_7_0_EBX_AVX512VL          (1U << 31)
+
+/* AVX-512 Vector Byte Manipulation Instruction */
+#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
+#define CPUID_7_0_ECX_VBMI              (1U << 1)
+/* User-Mode Instruction Prevention */
+#define CPUID_7_0_ECX_UMIP              (1U << 2)
+/* Protection Keys for User-mode Pages */
+#define CPUID_7_0_ECX_PKU               (1U << 3)
+/* OS Enable Protection Keys */
+#define CPUID_7_0_ECX_OSPKE             (1U << 4)
+/* Additional AVX-512 Vector Byte Manipulation Instruction */
+#define CPUID_7_0_ECX_VBMI2             (1U << 6)
+/* Galois Field New Instructions */
+#define CPUID_7_0_ECX_GFNI              (1U << 8)
+/* Vector AES Instructions */
+#define CPUID_7_0_ECX_VAES              (1U << 9)
+/* Carry-Less Multiplication Quadword */
+#define CPUID_7_0_ECX_VPCLMULQDQ        (1U << 10)
+/* Vector Neural Network Instructions */
+#define CPUID_7_0_ECX_AVX512VNNI        (1U << 11)
+/* Support for VPOPCNT[B,W] and VPSHUFBITQMB */
+#define CPUID_7_0_ECX_AVX512BITALG      (1U << 12)
+/* POPCNT for vectors of DW/QW */
+#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ  (1U << 14)
+/* 5-level Page Tables */
+#define CPUID_7_0_ECX_LA57              (1U << 16)
+/* Read Processor ID */
+#define CPUID_7_0_ECX_RDPID             (1U << 22)
+/* Cache Line Demote Instruction */
+#define CPUID_7_0_ECX_CLDEMOTE          (1U << 25)
+/* Move Doubleword as Direct Store Instruction */
+#define CPUID_7_0_ECX_MOVDIRI           (1U << 27)
+/* Move 64 Bytes as Direct Store Instruction */
+#define CPUID_7_0_ECX_MOVDIR64B         (1U << 28)
+
+/* AVX512 Neural Network Instructions */
+#define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
+/* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
+/* Speculation Control */
+#define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
+/* Arch Capabilities */
+#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)
+/* Core Capability */
+#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)
+/* Speculative Store Bypass Disable */
+#define CPUID_7_0_EDX_SPEC_CTRL_SSBD    (1U << 31)
+
+/* AVX512 BFloat16 Instruction */
+#define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+
+/* Write back and do not invalidate cache */
+#define CPUID_8000_0008_EBX_WBNOINVD    (1U << 9)
+/* Indirect Branch Prediction Barrier */
+#define CPUID_8000_0008_EBX_IBPB        (1U << 12)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
-- 
2.20.1


