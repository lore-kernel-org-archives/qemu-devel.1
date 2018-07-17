Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFQ-00078v-O3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFM-0003f2-8F
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFM-0003e8-4G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA5F57D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:45 +0200
Message-Id: <20180717113402.5510-9-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 08/25] check: Only test rtl8139 when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

test-file-redirector uses rtl8139 in everything except s390.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a039b70f9b..c6156fe105 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -213,8 +213,8 @@ check-qtest-pci-y += tests/e1000-test$(EXESUF)
 gcov-files-pci-y += hw/net/e1000.c
 check-qtest-pci-y += tests/e1000e-test$(EXESUF)
 gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
-check-qtest-pci-y += tests/rtl8139-test$(EXESUF)
-gcov-files-pci-y += hw/net/rtl8139.c
+check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
+gcov-files-pci-$(CONFIG_RTL8139_PCI) += hw/net/rtl8139.c
 check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
 gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet.c
 gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet-pci.c
@@ -302,7 +302,7 @@ check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
+check-qtest-i386-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
 check-qtest-i386-y += tests/migration-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
@@ -352,7 +352,7 @@ gcov-files-ppc64-y += hw/usb/hcd-xhci.c
 check-qtest-ppc64-y += $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
+check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
-- 
2.17.1
