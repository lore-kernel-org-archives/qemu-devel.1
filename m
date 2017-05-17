Received: from eggs.gnu.org ([2001:4830:134:3::10]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzCP-0004hQ-2U
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzCO-0003jB-7w
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzCO-0003hu-26
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:39:48 -0300
Message-Id: <20170517134003.17110-8-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/22] kvmclock: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

kvmclock should be used by guests only when the appropriate CPUID
feature flags are set on the VCPU, and it is automatically
created by kvmclock_create() when those feature flags are set.
This means creating a kvmclock device using -device is useless.
Remove user_creatable from its device class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <thuth@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-8-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/clock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 7665bef999..13eca374cd 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -286,11 +286,6 @@ static void kvmclock_class_init(ObjectClass *klass, void *data)
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
     dc->props = kvmclock_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo kvmclock_info = {
-- 
2.11.0.259.g40922b1
