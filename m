Received: from eggs.gnu.org ([2001:4830:134:3::10]:51711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6L-0003YE-Ib
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6K-00081q-Oe
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:05 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6K-00081Q-Iu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:04 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so3426958wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:27 +0100
Message-Id: <1487255507-106654-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/23] kvm/ioapic: correct kvm ioapic version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1486106298-3699-4-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
