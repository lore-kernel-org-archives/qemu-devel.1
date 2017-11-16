Received: from eggs.gnu.org ([2001:4830:134:3::10]:33822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpW-0001i9-Vv
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpW-0000BM-AD
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpW-0000AW-3X
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:38 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:20 +0100
Message-Id: <20171116115926.16627-6-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/11] target-i386: adds PV_TLB_FLUSH CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wanpeng Li <wanpeng.li@hotmail.com>, =?UTF-8?q?Radim=20Kr=C3=84m=C3=83=C2=A1=C3=85=E2=84=A2?= <rkrcmar@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Wanpeng Li <wanpeng.li@hotmail.com>

Adds PV_TLB_FLUSH CPUID feature bit.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Kr=C3=84m=C3=83=C2=A1=C3=85=E2=84=A2 <rkrcmar@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Message-Id: <1510299947-11287-1-git-send-email-wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f21a5e518..ecebc5a70a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -347,7 +347,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
         .feat_names =3D {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhal=
t",
-            NULL, NULL, NULL, NULL,
+            NULL, "kvm-pv-tlb-flush", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
--=20
2.14.3
