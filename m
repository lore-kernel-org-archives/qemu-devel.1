Received: from eggs.gnu.org ([2001:4830:134:3::10]:44678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaKA6-0008F8-0j
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaKA1-0005IM-TM
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:44:17 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 21 Dec 2018 13:44:10 +0100
Message-Id: <20181221124410.11920-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-stable@nongnu.org

Marshaling of processor tracing MSRs is not yet implemented in
QEMU, mark the feature as unmigratable.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c54c41e7a..a6a597d2bf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1012,6 +1012,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
             .needs_ecx =3D true, .ecx =3D 0,
             .reg =3D R_EBX,
         },
+        .unmigratable_features =3D CPUID_7_0_EBX_INTEL_PT,
         .tcg_features =3D TCG_7_0_EBX_FEATURES,
     },
     [FEAT_7_0_ECX] =3D {
--=20
2.20.1
