Received: from eggs.gnu.org ([2001:4830:134:3::10]:41768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKslF-00024x-Dh
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKslE-00063D-AG
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:54:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fKslE-000632-6F
	for qemu-devel@nongnu.org; Mon, 21 May 2018 17:54:32 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 21 May 2018 22:54:23 +0100
Message-Id: <20180521215424.13520-3-berrange@redhat.com>
In-Reply-To: <20180521215424.13520-1-berrange@redhat.com>
References: <20180521215424.13520-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] i386: define the AMD 'virt-ssbd' CPUID
 feature bit (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

AMD Zen expose the Intel equivalant to Speculative Store Bypass Disable
via the 0x80000008_EBX[25] CPUID feature bit.

This needs to be exposed to guest OS to allow them to protect
against CVE-2018-3639.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
2.17.0
