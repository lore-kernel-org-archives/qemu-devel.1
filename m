Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E45C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE9A2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgetN-0008Gq-C4
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgelF-0000M6-M2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgelC-0006rv-Pd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgelC-0006rR-H9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB4D3308424E
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 00:29:01 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D130B6012E;
 Fri, 28 Jun 2019 00:29:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 21:28:41 -0300
Message-Id: <20190628002844.24894-7-ehabkost@redhat.com>
In-Reply-To: <20190628002844.24894-1-ehabkost@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 28 Jun 2019 00:29:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/9] i386: Replace -noTSX, -IBRS,
 -IBPB CPU models with aliases
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
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old CPU models will be just aliases for specific versions of
the original CPU models.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
(New patch, added to series in v2)
---
 target/i386/cpu.c | 601 ++--------------------------------------------
 1 file changed, 21 insertions(+), 580 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5d33e75890..cddea91b1f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1439,6 +1439,7 @@ typedef struct PropValue {
 
 typedef struct X86CPUVersionDefinition {
     X86CPUVersion version;
+    const char *alias;
     PropValue *props;
 } X86CPUVersionDefinition;
 
@@ -1855,7 +1856,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to Nehalem-IBRS */
+                .alias = "Nehalem-IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -1866,36 +1867,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "Nehalem-IBRS",
-        .level = 11,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 26,
-        .stepping = 3,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_SSE3,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_LAHF_LM,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core i7 9xx (Nehalem Core i7, IBRS update)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Westmere",
         .level = 11,
@@ -1925,7 +1896,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to Westmere-IBRS */
+                .alias = "Westmere-IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -1936,39 +1907,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "Westmere-IBRS",
-        .level = 11,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 44,
-        .stepping = 1,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Westmere E56xx/L56xx/X56xx (IBRS update)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "SandyBridge",
         .level = 0xd,
@@ -2003,7 +1941,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to SandyBridge-IBRS */
+                .alias = "SandyBridge-IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -2014,44 +1952,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "SandyBridge-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 42,
-        .stepping = 1,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
-            CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Xeon E312xx (Sandy Bridge, IBRS update)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "IvyBridge",
         .level = 0xd,
@@ -2089,7 +1989,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to IvyBridge-IBRS */
+                .alias = "IvyBridge-IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -2100,131 +2000,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "IvyBridge-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 58,
-        .stepping = 9,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
-            CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_ERMS,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
-    {
-        .name = "Haswell-noTSX",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 60,
-        .stepping = 1,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Haswell, no TSX)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
-    {
-        .name = "Haswell-noTSX-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 60,
-        .stepping = 1,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Haswell, no TSX, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Haswell",
         .level = 0xd,
@@ -2265,7 +2040,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to Haswell-noTSX */
+                .alias = "Haswell-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2276,7 +2051,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                /* Equivalent to Haswell-IBRS */
+                .alias = "Haswell-IBRS",
                 .props = (PropValue[]) {
                     /* Restore TSX features removed by -v2 above */
                     { "hle", "on" },
@@ -2294,7 +2069,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 4,
-                /* Equivalent to Haswell-noTSX-IBRS */
+                .alias = "Haswell-noTSX-IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2308,138 +2083,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "Haswell-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 60,
-        .stepping = 4,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
-            CPUID_7_0_EBX_RTM,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Haswell, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
-    {
-        .name = "Broadwell-noTSX",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 61,
-        .stepping = 2,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
-            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Broadwell, no TSX)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
-    {
-        .name = "Broadwell-noTSX-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 61,
-        .stepping = 2,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
-            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Broadwell, no TSX, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Broadwell",
         .level = 0xd,
@@ -2481,7 +2124,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to Broadwell-noTSX */
+                .alias = "Broadwell-noTSX",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2491,7 +2134,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                /* Equivalent to Broadwell-IBRS */
+                .alias = "Broadwell-IBRS",
                 .props = (PropValue[]) {
                     /* Restore TSX features removed by -v2 above */
                     { "hle", "on" },
@@ -2504,7 +2147,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 4,
-                /* Equivalent to Broadwell-noTSX-IBRS */
+                .alias = "Broadwell-noTSX-IBRS",
                 .props = (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2517,51 +2160,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "Broadwell-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 61,
-        .stepping = 2,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
-            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Broadwell, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Skylake-Client",
         .level = 0xd,
@@ -2610,7 +2208,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to Skylake-Client-IBRS */
+                .alias = "Skylake-Client-IBRS",
                 .props = (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -2621,58 +2219,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "Skylake-Client-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 94,
-        .stepping = 3,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
-            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component,
-         * and the only one defined in Skylake (processor tracing)
-         * probably will block migration anyway.
-         */
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
-            CPUID_XSAVE_XGETBV1,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Core Processor (Skylake, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Skylake-Server",
         .level = 0xd,
@@ -2726,7 +2272,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to Skylake-Server-IBRS */
+                .alias = "Skylake-Server-IBRS",
                 .props = (PropValue[]) {
                     /* clflushopt was not added to Skylake-Server-IBRS */
                     /* TODO: add -v3 including clflushopt */
@@ -2740,63 +2286,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "Skylake-Server-IBRS",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_INTEL,
-        .family = 6,
-        .model = 85,
-        .stepping = 4,
-        .features[FEAT_1_EDX] =
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
-            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
-        .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
-            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
-            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
-            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
-            CPUID_7_0_EBX_AVX512VL,
-        .features[FEAT_7_0_ECX] =
-            CPUID_7_0_ECX_PKU,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component,
-         * and the only one defined in Skylake (processor tracing)
-         * probably will block migration anyway.
-         */
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
-            CPUID_XSAVE_XGETBV1,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .xlevel = 0x80000008,
-        .model_id = "Intel Xeon Processor (Skylake, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Cascadelake-Server",
         .level = 0xd,
@@ -3187,7 +2676,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { .version = 1 },
             {
                 .version = 2,
-                /* Equivalent to EPYC-IBPB */
+                .alias = "EPYC-IBPB",
                 .props = (PropValue[]) {
                     { "ibpb", "on" },
                     { "model-id",
@@ -3198,61 +2687,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
-    {
-        .name = "EPYC-IBPB",
-        .level = 0xd,
-        .vendor = CPUID_VENDOR_AMD,
-        .family = 23,
-        .model = 1,
-        .stepping = 2,
-        .features[FEAT_1_EDX] =
-            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
-            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
-            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
-            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
-            CPUID_VME | CPUID_FP87,
-        .features[FEAT_1_ECX] =
-            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
-            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
-            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
-            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
-        .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
-            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =
-            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
-            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
-            CPUID_EXT3_TOPOEXT,
-        .features[FEAT_8000_0008_EBX] =
-            CPUID_8000_0008_EBX_IBPB,
-        .features[FEAT_7_0_EBX] =
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
-            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
-            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
-            CPUID_7_0_EBX_SHA_NI,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component.
-         */
-        .features[FEAT_XSAVE] =
-            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
-            CPUID_XSAVE_XGETBV1,
-        .features[FEAT_6_EAX] =
-            CPUID_6_EAX_ARAT,
-        .features[FEAT_SVM] =
-            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
-        .xlevel = 0x8000001E,
-        .model_id = "AMD EPYC Processor (with IBPB)",
-        .cache_info = &epyc_cache_info,
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions = (X86CPUVersionDefinition[]) { { /* end of list */ } },
-    },
     {
         .name = "Dhyana",
         .level = 0xd,
@@ -4577,6 +4011,13 @@ static void x86_register_cpudef_types(X86CPUDefinition *def)
         name = x86_cpu_versioned_model_name(def, vdef->version);
         x86_register_cpu_model_type(name, m);
         g_free(name);
+
+        if (vdef->alias) {
+            X86CPUModel *am = g_new0(X86CPUModel, 1);
+            am->cpudef = def;
+            am->version = vdef->version;
+            x86_register_cpu_model_type(vdef->alias, am);
+        }
     }
 
 }
-- 
2.18.0.rc1.1.g3f1ff2140


