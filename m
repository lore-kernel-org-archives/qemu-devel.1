Received: from eggs.gnu.org ([2001:4830:134:3::10]:51729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvu9M-0003qY-Ar
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvu9I-0006fz-ND
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:8130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvu9I-0006fS-Cr
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:15:36 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Wed,  5 Apr 2017 16:21:29 -0700
Message-Id: <1491434491-1765-2-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel]  [PATCH 1/3] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, pbonzini@redhat.com, eblake@redhat.com, Anthony Xu <anthony.xu@intel.com>

move xen-common.c to hw/xen/

Signed-off -by: Anthony Xu <anthony.xu@intel.com>


---
 Makefile.target                         | 2 --
 hw/xen/Makefile.objs                    | 2 +-
 xen-common.c => hw/xen/xen-common.c     | 0
 stubs/Makefile.objs                     | 1 +
 xen-common-stub.c => stubs/xen-common.c | 0
 5 files changed, 2 insertions(+), 3 deletions(-)
 rename xen-common.c => hw/xen/xen-common.c (100%)
 rename xen-common-stub.c => stubs/xen-common.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 7df2b8c..48c027f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,9 +150,7 @@ obj-y += migration/ram.o migration/savevm.o
 LIBS := $(libs_softmmu) $(LIBS)
 
 # xen support
-obj-$(CONFIG_XEN) += xen-common.o
 obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
-obj-$(call lnot,$(CONFIG_XEN)) += xen-common-stub.o
 obj-$(call lnot,$(CONFIG_XEN_I386)) += xen-hvm-stub.o
 
 # Hardware support
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 4be3ec9..64a70bc 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o
+common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o xen-common.o
 
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
diff --git a/xen-common.c b/hw/xen/xen-common.c
similarity index 100%
rename from xen-common.c
rename to hw/xen/xen-common.c
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 224f04b..6c80613 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -37,3 +37,4 @@ stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
+stub-obj-y += xen-common.o
diff --git a/xen-common-stub.c b/stubs/xen-common.c
similarity index 100%
rename from xen-common-stub.c
rename to stubs/xen-common.c
-- 
1.8.3.1
