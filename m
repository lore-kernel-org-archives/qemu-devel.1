Received: from eggs.gnu.org ([208.118.235.92]:54613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPG3-0002kn-WA
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPG0-0003vk-ON
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:57846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPG0-0003ov-DX
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:00 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:33:55 +0800
Message-Id: <20181227063419.12981-2-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 01/25] build: actually use CONFIG_PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Do not link it unconditionally into all binaries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 6d6597c065..9d7e7cd1b8 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += pam.o
+common-obj-$(CONFIG_PAM) += pam.o
 
 # PPC devices
 common-obj-$(CONFIG_PREP_PCI) += prep.o
-- 
2.17.1
