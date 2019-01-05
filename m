Received: from eggsout.gnu.org ([209.51.188.92]:53058 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gfbsJ-0002mp-EP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 21:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gfbsG-0007qz-3o
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 21:39:47 -0500
From: Li Qiang <liq3ea@163.com>
Date: Fri,  4 Jan 2019 18:38:31 -0800
Message-Id: <20190105023831.66910-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] ioapic: use TYPE_FOO MACRO than constant string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, lvivier@redhat.com, Li Qiang <liq3ea@163.com>

Make them more QOMConventional.
Cc:qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/i386/kvm/ioapic.c     | 2 +-
 hw/i386/pc.c             | 4 ++--
 hw/intc/ioapic.c         | 2 +-
 include/hw/i386/ioapic.h | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 5b40d75439..e453692199 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -163,7 +163,7 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo kvm_ioapic_info = {
-    .name  = "kvm-ioapic",
+    .name  = TYPE_KVM_IOAPIC,
     .parent = TYPE_IOAPIC_COMMON,
     .instance_size = sizeof(KVMIOAPICState),
     .class_init = kvm_ioapic_class_init,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f248662e97..af68a61615 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1665,9 +1665,9 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     unsigned int i;
 
     if (kvm_ioapic_in_kernel()) {
-        dev = qdev_create(NULL, "kvm-ioapic");
+        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
     } else {
-        dev = qdev_create(NULL, "ioapic");
+        dev = qdev_create(NULL, TYPE_IOAPIC);
     }
     if (parent_name) {
         object_property_add_child(object_resolve_path(parent_name, NULL),
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 4e529729b4..9d75f84d3b 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -429,7 +429,7 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ioapic_info = {
-    .name          = "ioapic",
+    .name          = TYPE_IOAPIC,
     .parent        = TYPE_IOAPIC_COMMON,
     .instance_size = sizeof(IOAPICCommonState),
     .class_init    = ioapic_class_init,
diff --git a/include/hw/i386/ioapic.h b/include/hw/i386/ioapic.h
index 9c8816f11f..59fcb158a7 100644
--- a/include/hw/i386/ioapic.h
+++ b/include/hw/i386/ioapic.h
@@ -23,6 +23,9 @@
 #define IOAPIC_NUM_PINS 24
 #define IO_APIC_DEFAULT_ADDRESS 0xfec00000
 
+#define TYPE_KVM_IOAPIC "kvm-ioapic"
+#define TYPE_IOAPIC "ioapic"
+
 void ioapic_eoi_broadcast(int vector);
 
 #endif /* HW_IOAPIC_H */
-- 
2.17.1
