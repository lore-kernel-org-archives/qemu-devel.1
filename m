Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CAECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411082064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411082064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUit-0004PJ-4D
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUWu-0006W8-WD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUWt-0006vK-2b
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUWs-0006ux-QI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:38:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F34E308FBB4;
 Tue, 15 Oct 2019 21:38:53 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB54310027A9;
 Tue, 15 Oct 2019 21:38:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 15/18] target/i386: drop the duplicated definition of cpuid
 AVX512_VBMI macro
Date: Tue, 15 Oct 2019 18:37:42 -0300
Message-Id: <20191015213745.22174-16-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 15 Oct 2019 21:38:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Tao Xu <tao3.xu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Drop the duplicated definition of cpuid AVX512_VBMI macro and rename
it as CPUID_7_0_ECX_AVX512_VBMI. Rename CPUID_7_0_ECX_VBMI2 as
CPUID_7_0_ECX_AVX512_VBMI2.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20190926021055.6970-3-tao3.xu@intel.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h           | 5 ++---
 target/i386/cpu.c           | 8 ++++----
 target/i386/hvf/x86_cpuid.c | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 93aad4655f..cedb5bc205 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -723,8 +723,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_AVX512VL          (1U << 31)
=20
 /* AVX-512 Vector Byte Manipulation Instruction */
-#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
-#define CPUID_7_0_ECX_VBMI              (1U << 1)
+#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)
 /* User-Mode Instruction Prevention */
 #define CPUID_7_0_ECX_UMIP              (1U << 2)
 /* Protection Keys for User-mode Pages */
@@ -732,7 +731,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 /* OS Enable Protection Keys */
 #define CPUID_7_0_ECX_OSPKE             (1U << 4)
 /* Additional AVX-512 Vector Byte Manipulation Instruction */
-#define CPUID_7_0_ECX_VBMI2             (1U << 6)
+#define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
 /* Galois Field New Instructions */
 #define CPUID_7_0_ECX_GFNI              (1U << 8)
 /* Vector AES Instructions */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 44f1bbdcac..daece62c19 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2645,8 +2645,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX=
 |
             CPUID_7_0_EBX_SMAP,
         .features[FEAT_7_0_ECX] =3D
-            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU =
|
-            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_E=
CX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
             CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
             CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
             CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
@@ -2703,8 +2703,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
         .features[FEAT_7_0_ECX] =3D
-            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU =
|
-            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_E=
CX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
             CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
             CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
             CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 4d957fe896..16762b6eb4 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_=
t idx,
                 ebx &=3D ~CPUID_7_0_EBX_INVPCID;
             }
=20
-            ecx &=3D CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VPOP=
CNTDQ;
+            ecx &=3D CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_VP=
OPCNTDQ;
             edx &=3D CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_=
4FMAPS;
         } else {
             ebx =3D 0;
--=20
2.21.0


