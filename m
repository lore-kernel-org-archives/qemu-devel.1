Received: from eggs.gnu.org ([2001:4830:134:3::10]:42303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaLOn-0002SC-7Q
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaLOj-0007ma-7Y
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:03:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gaLOj-0007l3-1G
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:03:29 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 21 Dec 2018 15:03:21 +0100
Message-Id: <20181221140321.7750-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC] i386: Enable NPT and NRIPSAVE for Epyc CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

Epyc CPUs support NPT and NRIPSAVE features and KVM exposes these when
present. Add them to EPYC and EPYC-IBPB cpu models.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- RFC part: I'm not sure when these features first appeared, we may want =
to
  modify some Opteron_* models too.
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 677a3bd5fb..0a10fbeccc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2843,6 +2843,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =3D
             CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor",
         .cache_info =3D &epyc_cache_info,
@@ -2891,6 +2893,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =3D
             CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =3D
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor (with IBPB)",
         .cache_info =3D &epyc_cache_info,
--=20
2.19.2
