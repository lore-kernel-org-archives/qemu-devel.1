Received: from eggs.gnu.org ([2001:4830:134:3::10]:43507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssQ-0005vQ-7A
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKssM-0000pf-Pv
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fKssM-0000pT-KR
	for qemu-devel@nongnu.org; Mon, 21 May 2018 18:01:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 21 May 2018 19:01:33 -0300
Message-Id: <20180521220133.17445-4-ehabkost@redhat.com>
In-Reply-To: <20180521220133.17445-1-ehabkost@redhat.com>
References: <20180521220133.17445-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] i386: define the AMD 'virt-ssbd' CPUID
 feature bit (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

AMD Zen expose the Intel equivalant to Speculative Store Bypass Disable
via the 0x80000008_EBX[25] CPUID feature bit.

This needs to be exposed to guest OS to allow them to protect
against CVE-2018-3639.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180521215424.13520-3-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a1185b17d1..d95310ffd4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -836,7 +836,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "virt-ssbd", NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax =3D 0x80000008,
--=20
2.14.3
