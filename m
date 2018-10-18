Received: from eggs.gnu.org ([2001:4830:134:3::10]:48363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyY-0007bk-7h
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyV-0006XX-1Q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyU-0006V9-Kr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id r17-v6so2746073wrt.9
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:58 +0200
Message-Id: <1539894735-14232-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/48] hyperv: rename kvm_hv_sint_route_set_sint
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

There's nothing kvm-specific in it so follow the suite and replace
"kvm_hv" prefix with "hyperv".

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-9-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/hyperv_testdev.c | 2 +-
 target/i386/hyperv.c     | 2 +-
 target/i386/hyperv.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index dbf4e7e..33bbd28 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -90,7 +90,7 @@ static void sint_route_set_sint(HypervTestDev *dev,
 
     sint_route = sint_route_find(dev, vp_index, sint);
 
-    kvm_hv_sint_route_set_sint(sint_route->sint_route);
+    hyperv_sint_route_set_sint(sint_route->sint_route);
 }
 
 static uint64_t hv_test_dev_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 4d8ef6f..fc537e7 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -185,7 +185,7 @@ void hyperv_sint_route_unref(HvSintRoute *sint_route)
     g_free(sint_route);
 }
 
-int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route)
+int hyperv_sint_route_set_sint(HvSintRoute *sint_route)
 {
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index cdf44a7..59e9f9a 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -28,7 +28,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
 void hyperv_sint_route_ref(HvSintRoute *sint_route);
 void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
-int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
+int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
 
 uint32_t hyperv_vp_index(X86CPU *cpu);
 X86CPU *hyperv_find_vcpu(uint32_t vp_index);
-- 
1.8.3.1
