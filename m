Received: from eggs.gnu.org ([2001:4830:134:3::10]:46767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaLb4-0008Lk-IJ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaLb0-00007N-Bx
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gaLb0-00006y-0D
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:16:10 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 21 Dec 2018 15:16:04 +0100
Message-Id: <20181221141604.16935-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] i386/kvm: add a comment explaining why
 .feat_names are commented out for Hyper-V feature bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Hyper-V .feat_names are, unlike hardware features, commented out and it i=
s
not obvious why we do that. Document the current status quo.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 677a3bd5fb..18a486c5a0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -929,6 +929,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WOR=
DS] =3D {
          */
         .no_autoenable_flags =3D ~0U,
     },
+    /*
+     * .feat_names are commented out for Hyper-V enlightenments because =
we
+     * don't want to have two different ways for enabling them on QEMU c=
ommand
+     * line. Some features (e.g. "hyperv_time", "hyperv_vapic", ...) req=
uire
+     * enabling several feature bits simultaneously, exposing these bits
+     * individually may just confuse guests.
+     */
     [FEAT_HYPERV_EAX] =3D {
         .type =3D CPUID_FEATURE_WORD,
         .feat_names =3D {
--=20
2.19.2
