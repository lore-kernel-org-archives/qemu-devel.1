Received: from eggs.gnu.org ([2001:4830:134:3::10]:58770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzCb-0004q4-Sj
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzCb-0003n8-0e
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzCa-0003mq-QZ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:41:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:39:50 -0300
Message-Id: <20170517134003.17110-10-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/22] kvmvapic: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

The kvmvapic device is only usable when created by
apic_common_realize(), not using -device. Remove the
user_creatable flag from the device class.

Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-10-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvmvapic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 45f6267c93..82a49556af 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -856,11 +856,6 @@ static void vapic_class_init(ObjectClass *klass, void *data)
     dc->reset   = vapic_reset;
     dc->vmsd    = &vmstate_vapic;
     dc->realize = vapic_realize;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vapic_type = {
-- 
2.11.0.259.g40922b1
