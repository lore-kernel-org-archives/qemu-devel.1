Received: from eggs.gnu.org ([2001:4830:134:3::10]:50284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8h-0006lO-SC
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8h-00077U-4O
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZY8g-00077M-V0
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:35 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 15:18:18 +0800
Message-Id: <1486106298-3699-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1486106298-3699-1-git-send-email-peterx@redhat.com>
References: <1486106298-3699-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] kvm/ioapic: correct kvm ioapic version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/kvm/ioapic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 716d59a..98ca480 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -143,6 +143,11 @@ static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
 
     memory_region_init_reservation(&s->io_memory, NULL, "kvm-ioapic", 0x1000);
+    /*
+     * KVM ioapic only supports 0x11 now. This will only be used when
+     * we want to dump ioapic version.
+     */
+    s->version = 0x11;
 
     qdev_init_gpio_in(dev, kvm_ioapic_set_irq, IOAPIC_NUM_PINS);
 }
-- 
2.7.4
