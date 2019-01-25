Received: from eggs.gnu.org ([209.51.188.92]:58102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOn-0007dH-VI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOl-0001s5-Vi
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:45 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOl-0001bx-GX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:43 -0500
Received: by mail-wm1-x344.google.com with SMTP id n190so6175861wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:32 +0100
Message-Id: <1548410831-19553-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/52] hw/s390/Makefile.objs: Create new
 CONFIG_* variables for s390x boards and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

Make hw/s390x configurable and add new CONFIG_* to the default-configs/s390x*-softmmu.mak.
This will be used to enable/disable vfio-ccw.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190123065618.3520-10-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/s390x-softmmu.mak | 1 +
 hw/s390x/Makefile.objs            | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 5eef375..8bb7e43 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
 CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
 CONFIG_VFIO_AP=$(CONFIG_LINUX)
+CONFIG_S390_CCW_VIRTIO=y
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index ca68806..a884aae 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -1,3 +1,4 @@
+ifeq ($(CONFIG_S390_CCW_VIRTIO),y)
 obj-y += s390-virtio-hcall.o
 obj-y += sclp.o
 obj-y += event-facility.o
@@ -33,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
+endif
-- 
1.8.3.1
