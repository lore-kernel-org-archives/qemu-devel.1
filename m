Received: from eggs.gnu.org ([2001:4830:134:3::10]:35349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPMUT-0004Xe-U4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPMUT-00064v-1V
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPMUS-00064d-Ri
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C67DA80C0C
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 05:23:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 26 Jun 2017 07:22:58 +0200
Message-Id: <1498454578-18709-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1498454578-18709-1-git-send-email-thuth@redhat.com>
References: <1498454578-18709-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 7/7] hw/misc/edu: Compile the edu device as
 common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

edu.c does not contain any target-specific code, so we can put
it into common-obj-y to compile it only once for all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 2019846..7fc4e41 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
 common-obj-$(CONFIG_SGA) += sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
+common-obj-$(CONFIG_EDU) += edu.o
 
 common-obj-y += unimp.o
 
@@ -53,7 +54,6 @@ obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
-obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
-- 
1.8.3.1
