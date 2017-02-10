Received: from eggs.gnu.org ([2001:4830:134:3::10]:46180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIyq-0008Kv-M0
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIyn-0002g8-IW
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ccIyn-0002g3-CE
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:45 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65EE33DBD9
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 21:43:45 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 10 Feb 2017 14:43:43 -0700
Message-ID: <20170210214331.22071.65786.stgit@gimli.home>
In-Reply-To: <20170210214127.22071.16525.stgit@gimli.home>
References: <20170210214127.22071.16525.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/3] hw/vfio: Add CONFIG switches for
 calxeda-xgmac and amd-xgbe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Both devices seem to be specific to the ARM platform. It's confusing
for the users if they show up on other target architectures, too
(e.g. when the user runs QEMU with "-device ?" to get a list of
supported devices). Thus let's introduce proper configuration switches
so that the devices are only compiled and included when they are
really required.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 default-configs/arm-softmmu.mak |    2 ++
 hw/vfio/Makefile.objs           |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 824fa71ba957..fdf40893aace 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -95,6 +95,8 @@ CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
 CONFIG_PCI_GENERIC=y
+CONFIG_VFIO_XGMAC=y
+CONFIG_VFIO_AMD_XGBE=y
 
 CONFIG_SDHCI=y
 CONFIG_INTEGRATOR_DEBUG=y
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index c25e32b02999..05e7fbb93fd4 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -2,7 +2,7 @@ ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
 obj-$(CONFIG_PCI) += pci.o pci-quirks.o
 obj-$(CONFIG_SOFTMMU) += platform.o
-obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
-obj-$(CONFIG_SOFTMMU) += amd-xgbe.o
+obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
+obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
 obj-$(CONFIG_SOFTMMU) += spapr.o
 endif
