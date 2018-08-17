Received: from eggs.gnu.org ([2001:4830:134:3::10]:48675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTf1-0005Ut-7k
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTez-0006Ld-PN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqTex-0006JT-Qe
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 22:33:59 -0300
Message-Id: <20180817013400.13353-8-ehabkost@redhat.com>
In-Reply-To: <20180817013400.13353-1-ehabkost@redhat.com>
References: <20180817013400.13353-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] target-i386: adds PV_SEND_IPI CPUID feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

From: Wanpeng Li <wanpengli@tencent.com>

Adds PV_SEND_IPI CPUID feature bit.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba7abe59cc..52a77a7d08 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -868,7 +868,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
         .feat_names =3D {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhal=
t",
-            NULL, "kvm-pv-tlb-flush", NULL, NULL,
+            NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
--=20
2.18.0.rc1.1.g3f1ff2140
