Received: from eggs.gnu.org ([2001:4830:134:3::10]:39775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2v-0004Jm-BA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWp2n-0001vB-IC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWp2i-0001qT-98
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:54:13 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 18:53:46 -0200
Message-Id: <20181211205346.11118-5-ehabkost@redhat.com>
In-Reply-To: <20181211205346.11118-1-ehabkost@redhat.com>
References: <20181211205346.11118-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] i386: Add "stibp" flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

The STIBP flag may be supported by the host KVM module, so QEMU
can allow it to be configured manually, and it can be exposed to
guests when using "-cpu host".

No additional migration code is required because the whole
contents of spec_ctrl is already migrated in the "cpu/spec_ctrl"
section.

Corresponding KVM patch was submitted at:
https://lore.kernel.org/lkml/20181205191956.31480-1-ehabkost@redhat.com/

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181210180250.31299-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 86a934d450..12f559b6af 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1042,7 +1042,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, "pconfig", NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, "spec-ctrl", NULL,
+            NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", NULL, "ssbd",
         },
         .cpuid = {
-- 
2.18.0.rc1.1.g3f1ff2140
