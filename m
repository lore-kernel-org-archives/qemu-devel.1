Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7657C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A5621871
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5621871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hin8v-0007og-Ks
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1himW7-0006du-ES
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1himW4-0007Uc-2R
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1himVx-0007JY-Fi
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27A65308FC20;
 Wed,  3 Jul 2019 21:09:57 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43EF718992;
 Wed,  3 Jul 2019 21:09:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 18:08:15 -0300
Message-Id: <20190703210821.27550-38-ehabkost@redhat.com>
In-Reply-To: <20190703210821.27550-1-ehabkost@redhat.com>
References: <20190703210821.27550-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 03 Jul 2019 21:09:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v5 37/43] i386: Replace -noTSX, -IBRS,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old CPU models will be just aliases for specific versions of
the original CPU models.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628002844.24894-7-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 601 ++--------------------------------------------
 1 file changed, 21 insertions(+), 580 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 51beebdb27..f41917649d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1439,6 +1439,7 @@ typedef struct PropValue {
=20
 typedef struct X86CPUVersionDefinition {
     X86CPUVersion version;
+    const char *alias;
     PropValue *props;
 } X86CPUVersionDefinition;
=20
@@ -1855,7 +1856,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to Nehalem-IBRS */
+                .alias =3D "Nehalem-IBRS",
                 .props =3D (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -1866,36 +1867,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "Nehalem-IBRS",
-        .level =3D 11,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 26,
-        .stepping =3D 3,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_SSE3,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_LAHF_LM,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core i7 9xx (Nehalem Core i7, IBRS update)"=
,
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Westmere",
         .level =3D 11,
@@ -1925,7 +1896,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to Westmere-IBRS */
+                .alias =3D "Westmere-IBRS",
                 .props =3D (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -1936,39 +1907,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "Westmere-IBRS",
-        .level =3D 11,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 44,
-        .stepping =3D 1,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Westmere E56xx/L56xx/X56xx (IBRS update)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "SandyBridge",
         .level =3D 0xd,
@@ -2003,7 +1941,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to SandyBridge-IBRS */
+                .alias =3D "SandyBridge-IBRS",
                 .props =3D (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -2014,44 +1952,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "SandyBridge-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 42,
-        .stepping =3D 1,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
-            CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Xeon E312xx (Sandy Bridge, IBRS update)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "IvyBridge",
         .level =3D 0xd,
@@ -2089,7 +1989,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to IvyBridge-IBRS */
+                .alias =3D "IvyBridge-IBRS",
                 .props =3D (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -2100,131 +2000,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "IvyBridge-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 58,
-        .stepping =3D 9,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
-            CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_ERMS,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
-    {
-        .name =3D "Haswell-noTSX",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 60,
-        .stepping =3D 1,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Haswell, no TSX)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
-    {
-        .name =3D "Haswell-noTSX-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 60,
-        .stepping =3D 1,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Haswell, no TSX, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Haswell",
         .level =3D 0xd,
@@ -2265,7 +2040,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to Haswell-noTSX */
+                .alias =3D "Haswell-noTSX",
                 .props =3D (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2276,7 +2051,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             },
             {
                 .version =3D 3,
-                /* Equivalent to Haswell-IBRS */
+                .alias =3D "Haswell-IBRS",
                 .props =3D (PropValue[]) {
                     /* Restore TSX features removed by -v2 above */
                     { "hle", "on" },
@@ -2294,7 +2069,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             },
             {
                 .version =3D 4,
-                /* Equivalent to Haswell-noTSX-IBRS */
+                .alias =3D "Haswell-noTSX-IBRS",
                 .props =3D (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2308,138 +2083,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "Haswell-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 60,
-        .stepping =3D 4,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
-            CPUID_7_0_EBX_RTM,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Haswell, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
-    {
-        .name =3D "Broadwell-noTSX",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 61,
-        .stepping =3D 2,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFET=
CH,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
-            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Broadwell, no TSX)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
-    {
-        .name =3D "Broadwell-noTSX-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 61,
-        .stepping =3D 2,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFET=
CH,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
-            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Broadwell, no TSX, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Broadwell",
         .level =3D 0xd,
@@ -2481,7 +2124,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to Broadwell-noTSX */
+                .alias =3D "Broadwell-noTSX",
                 .props =3D (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2491,7 +2134,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             },
             {
                 .version =3D 3,
-                /* Equivalent to Broadwell-IBRS */
+                .alias =3D "Broadwell-IBRS",
                 .props =3D (PropValue[]) {
                     /* Restore TSX features removed by -v2 above */
                     { "hle", "on" },
@@ -2504,7 +2147,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             },
             {
                 .version =3D 4,
-                /* Equivalent to Broadwell-noTSX-IBRS */
+                .alias =3D "Broadwell-noTSX-IBRS",
                 .props =3D (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
@@ -2517,51 +2160,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "Broadwell-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 61,
-        .stepping =3D 2,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFET=
CH,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
-            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Broadwell, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Skylake-Client",
         .level =3D 0xd,
@@ -2610,7 +2208,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to Skylake-Client-IBRS */
+                .alias =3D "Skylake-Client-IBRS",
                 .props =3D (PropValue[]) {
                     { "spec-ctrl", "on" },
                     { "model-id",
@@ -2621,58 +2219,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "Skylake-Client-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 94,
-        .stepping =3D 3,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFET=
CH,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
-            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component,
-         * and the only one defined in Skylake (processor tracing)
-         * probably will block migration anyway.
-         */
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
-            CPUID_XSAVE_XGETBV1,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Core Processor (Skylake, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Skylake-Server",
         .level =3D 0xd,
@@ -2726,7 +2272,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to Skylake-Server-IBRS */
+                .alias =3D "Skylake-Server-IBRS",
                 .props =3D (PropValue[]) {
                     /* clflushopt was not added to Skylake-Server-IBRS *=
/
                     /* TODO: add -v3 including clflushopt */
@@ -2740,63 +2286,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "Skylake-Server-IBRS",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_INTEL,
-        .family =3D 6,
-        .model =3D 85,
-        .stepping =3D 4,
-        .features[FEAT_1_EDX] =3D
-            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX =
|
-            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID=
_MCA |
-            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 =
|
-            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
-            CPUID_DE | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
-            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
-            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
-            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
-            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOV=
BE |
-            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
-            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFET=
CH,
-        .features[FEAT_7_0_EDX] =3D
-            CPUID_7_0_EDX_SPEC_CTRL,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
-            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP =
|
-            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVP=
CID |
-            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
-            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
-            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
-            CPUID_7_0_EBX_AVX512VL,
-        .features[FEAT_7_0_ECX] =3D
-            CPUID_7_0_ECX_PKU,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component,
-         * and the only one defined in Skylake (processor tracing)
-         * probably will block migration anyway.
-         */
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
-            CPUID_XSAVE_XGETBV1,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .xlevel =3D 0x80000008,
-        .model_id =3D "Intel Xeon Processor (Skylake, IBRS)",
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Cascadelake-Server",
         .level =3D 0xd,
@@ -3258,7 +2747,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { .version =3D 1 },
             {
                 .version =3D 2,
-                /* Equivalent to EPYC-IBPB */
+                .alias =3D "EPYC-IBPB",
                 .props =3D (PropValue[]) {
                     { "ibpb", "on" },
                     { "model-id",
@@ -3269,61 +2758,6 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             { /* end of list */ }
         }
     },
-    {
-        .name =3D "EPYC-IBPB",
-        .level =3D 0xd,
-        .vendor =3D CPUID_VENDOR_AMD,
-        .family =3D 23,
-        .model =3D 1,
-        .stepping =3D 2,
-        .features[FEAT_1_EDX] =3D
-            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFL=
USH |
-            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE=
 |
-            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE =
|
-            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
-            CPUID_VME | CPUID_FP87,
-        .features[FEAT_1_ECX] =3D
-            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
-            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
-            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
-            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
-            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
-        .features[FEAT_8000_0001_EDX] =3D
-            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
-            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
-        .features[FEAT_8000_0001_ECX] =3D
-            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
-            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
-            CPUID_EXT3_TOPOEXT,
-        .features[FEAT_8000_0008_EBX] =3D
-            CPUID_8000_0008_EBX_IBPB,
-        .features[FEAT_7_0_EBX] =3D
-            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_=
AVX2 |
-            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSE=
ED |
-            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLU=
SHOPT |
-            CPUID_7_0_EBX_SHA_NI,
-        /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.12).
-         * KVM doesn't yet expose any XSAVES state save component.
-         */
-        .features[FEAT_XSAVE] =3D
-            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
-            CPUID_XSAVE_XGETBV1,
-        .features[FEAT_6_EAX] =3D
-            CPUID_6_EAX_ARAT,
-        .features[FEAT_SVM] =3D
-            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
-        .xlevel =3D 0x8000001E,
-        .model_id =3D "AMD EPYC Processor (with IBPB)",
-        .cache_info =3D &epyc_cache_info,
-        /*
-         * This CPU model will eventually be replaced by an alias,
-         * don't register any versions for it.
-         */
-        .versions =3D (X86CPUVersionDefinition[]) { { /* end of list */ =
} },
-    },
     {
         .name =3D "Dhyana",
         .level =3D 0xd,
@@ -4648,6 +4082,13 @@ static void x86_register_cpudef_types(X86CPUDefini=
tion *def)
         name =3D x86_cpu_versioned_model_name(def, vdef->version);
         x86_register_cpu_model_type(name, m);
         g_free(name);
+
+        if (vdef->alias) {
+            X86CPUModel *am =3D g_new0(X86CPUModel, 1);
+            am->cpudef =3D def;
+            am->version =3D vdef->version;
+            x86_register_cpu_model_type(vdef->alias, am);
+        }
     }
=20
 }
--=20
2.18.0.rc1.1.g3f1ff2140


