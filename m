Received: from eggs.gnu.org ([2001:4830:134:3::10]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyU-0007Y7-Nh
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyP-0006T6-3X
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyO-0006Ph-8J
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id r63-v6so1568231wma.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:53 +0200
Message-Id: <1539894735-14232-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/48] hyperv: cosmetic: g_malloc -> g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-4-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 3065d76..47368b7 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -88,7 +88,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     HvSintRoute *sint_route;
     int r, gsi;
 
-    sint_route = g_malloc0(sizeof(*sint_route));
+    sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
     if (r) {
         goto err;
-- 
1.8.3.1
