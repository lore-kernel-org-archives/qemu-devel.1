Received: from eggs.gnu.org ([209.51.188.92]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gz-00030l-2z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gp-0004LG-MT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gn-0004J5-Cb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:30 -0500
Received: by mail-wm1-x32c.google.com with SMTP id y139so4641385wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.16.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:16:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:07 +0100
Message-Id: <1549390526-24246-58-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 57/76] hw/s390/Makefile.objs: Create new
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
