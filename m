Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E3FC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D1320685
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiuQ-0004bN-QH
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:15:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisf-0003J3-P2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisd-0002G1-Qk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisb-00028L-QO
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51CFD3089509;
	Thu, 25 Apr 2019 18:13:51 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0556E5C21A;
	Thu, 25 Apr 2019 18:13:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 15:13:39 -0300
Message-Id: <20190425181342.15360-2-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
References: <20190425181342.15360-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 25 Apr 2019 18:13:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/4] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Pu Wen <puwen@hygon.cn>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425181339.9qH7qYzUZOGzIXyfzX0YmVaWugfj7G5urc2FYzeJalw@z>

From: Pu Wen <puwen@hygon.cn>

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
Message-Id: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  2 ++
 target/i386/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 828067bd1c..0128910661 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -726,6 +726,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
=20
 #define CPUID_VENDOR_VIA   "CentaurHauls"
=20
+#define CPUID_VENDOR_HYGON    "HygonGenuine"
+
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability =
*/
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e1687f7547..d92b0f6fcc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2935,6 +2935,56 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .model_id =3D "AMD EPYC Processor (with IBPB)",
         .cache_info =3D &epyc_cache_info,
     },
+    {
+        .name =3D "Dhyana",
+        .level =3D 0xd,
+        .vendor =3D CPUID_VENDOR_HYGON,
+        .family =3D 24,
+        .model =3D 0,
+        .stepping =3D 1,
+        .features[FEAT_1_EDX] =3D
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFL=
USH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE=
 |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE =
|
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =3D
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =3D
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =3D
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
+        .features[FEAT_8000_0008_EBX] =3D
+            CPUID_8000_0008_EBX_IBPB,
+        .features[FEAT_7_0_EBX] =3D
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_=
AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSE=
ED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLU=
SHOPT,
+        /*
+         * Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component.
+         */
+        .features[FEAT_XSAVE] =3D
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =3D
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel =3D 0x8000001E,
+        .model_id =3D "Hygon Dhyana Processor",
+        .cache_info =3D &epyc_cache_info,
+    },
 };
=20
 typedef struct PropValue {
--=20
2.18.0.rc1.1.g3f1ff2140


