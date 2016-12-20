Received: from eggs.gnu.org ([2001:4830:134:3::10]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORv-0001Qt-J6
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORu-0008T5-Qv
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJORu-0008Sy-Ki
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Dec 2016 15:43:11 -0200
Message-Id: <1482255793-19057-6-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 5/7] kvm: Move kvm*.c files to accel/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

While doing it, rename kvm-all.c to kvm-common.c to follow the
same pattern used for xen.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile.target                 | 2 --
 kvm-all.c => accel/kvm-common.c | 0
 kvm-stub.c => accel/kvm-stub.c  | 0
 MAINTAINERS                     | 3 +--
 accel/Makefile.objs             | 3 +++
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename kvm-all.c => accel/kvm-common.c (100%)
 rename kvm-stub.c => accel/kvm-stub.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 5e78bb0..70a1261 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -136,8 +136,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o bootdevice.o
 obj-y += hw/
-obj-$(CONFIG_KVM) += kvm-all.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-y += memory.o cputlb.o
 obj-y += memory_mapping.o
 obj-y += dump.o
diff --git a/kvm-all.c b/accel/kvm-common.c
similarity index 100%
rename from kvm-all.c
rename to accel/kvm-common.c
diff --git a/kvm-stub.c b/accel/kvm-stub.c
similarity index 100%
rename from kvm-stub.c
rename to accel/kvm-stub.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e25438..9c6dae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -261,8 +261,7 @@ Overall
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: kvm-*
-F: */kvm.*
+F: */kvm*
 F: include/sysemu/kvm*.h
 
 ARM
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 6f3630e..3f3866d 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,2 +1,5 @@
 obj-$(CONFIG_XEN) += xen-common.o
 obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
+
+obj-$(CONFIG_KVM) += kvm-common.o
+obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-- 
2.7.4
