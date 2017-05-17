Received: from eggs.gnu.org ([2001:4830:134:3::10]:59175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDR-0005jr-Tm
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDR-0004If-3E
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzDQ-0004IX-TK
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:39:58 -0300
Message-Id: <20170517134003.17110-18-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 17/22] hpet: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

hpet needs to be mapped and wired by the board code and won't
work with -device. Remove the user_creatable flag from the device
class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-18-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/timer/hpet.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 4dcbd5bb3d..a2c18b30c3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -771,11 +771,6 @@ static void hpet_device_class_init(ObjectClass *klass, void *data)
     dc->reset = hpet_reset;
     dc->vmsd = &vmstate_hpet;
     dc->props = hpet_device_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo hpet_device_info = {
-- 
2.11.0.259.g40922b1
