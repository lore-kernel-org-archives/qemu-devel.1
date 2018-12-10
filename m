Received: from eggs.gnu.org ([2001:4830:134:3::10]:54943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWPtX-00038W-5Q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWPtP-0004q6-RJ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:03:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWPtO-0004mz-DE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:02:55 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 10 Dec 2018 16:02:50 -0200
Message-Id: <20181210180250.31299-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: Add "stibp" flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The STIBP flag may be supported by the host KVM module, so QEMU
can allow it to be configured manually, and it can be exposed to
guests when using "-cpu host".

No additional migration code is required because the whole
contents of spec_ctrl is already migrated in the "cpu/spec_ctrl"
section.

Corresponding KVM patch was submitted at:
https://lore.kernel.org/lkml/20181205191956.31480-1-ehabkost@redhat.com/

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f9..079678f282 100644
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
