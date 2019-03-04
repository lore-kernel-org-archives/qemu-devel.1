Received: from eggs.gnu.org ([209.51.188.92]:45603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCK-0001ju-L0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCJ-0003bX-QC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCJ-0003av-IX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:19 -0500
Received: by mail-wr1-x435.google.com with SMTP id q1so6645616wrp.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:22 +0100
Message-Id: <1551723614-1823-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/54] 9pfs: remove unnecessary conditionals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

The VIRTIO_9P || VIRTFS && XEN condition can be computed in hw/Makefile.objs,
removing an "if" from hw/9pfs/Makefile.objs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/9pfs/Makefile.objs | 2 --
 hw/Makefile.objs      | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index 8ac0496..70ded6f 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -1,11 +1,9 @@
-ifeq ($(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN)),y)
 common-obj-y  = 9p.o 9p-util.o
 common-obj-y += 9p-local.o 9p-xattr.o
 common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
 common-obj-y += coth.o cofs.o codir.o cofile.o
 common-obj-y += coxattr.o 9p-synth.o
 common-obj-y += 9p-proxy.o
-endif
 
 common-obj-$(CONFIG_XEN) += xen-9p-backend.o
 obj-$(CONFIG_VIRTIO_9P) += virtio-9p-device.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e2fcd6a..2d9b42d 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,4 @@
-devices-dirs-$(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO),$(CONFIG_XEN))) += 9pfs/
+devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-$(CONFIG_SOFTMMU) += acpi/
 devices-dirs-$(CONFIG_SOFTMMU) += adc/
 devices-dirs-$(CONFIG_SOFTMMU) += audio/
-- 
1.8.3.1
