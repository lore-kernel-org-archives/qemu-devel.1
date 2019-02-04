Received: from eggs.gnu.org ([209.51.188.92]:60124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7x-00066m-AU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-0004Hc-Mf
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7v-0003u7-2B
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id g67so1017273wmd.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.37.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:37:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:00 +0100
Message-Id: <1549305379-51117-59-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 58/77] hw/s390/Makefile.objs: Create new
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

Make hw/s390x configurable and add new CONFIG_* to the
default-configs/s390x*-softmmu.mak. This will be used to
enable/disable vfio-ccw.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-14-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/s390x-softmmu.mak | 1 +
 hw/s390x/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index ca68806..a18c471 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -5,7 +5,7 @@ obj-y += sclpquiesce.o
 obj-y += sclpcpu.o
 obj-y += ipl.o
 obj-y += css.o
-obj-y += s390-virtio-ccw.o
+obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o
 obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
-- 
1.8.3.1
