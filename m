Received: from eggs.gnu.org ([2001:4830:134:3::10]:46588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk6-00035P-UI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk4-0006eC-ST
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:57 +1100
Message-Id: <20170112020327.24882-38-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 37/67] qtest: add netfilter tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f776404..08ddf59 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -284,6 +284,9 @@ gcov-files-ppc64-y += hw/usb/hcd-uhci.c
 check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-xhci.c
 check-qtest-ppc64-y += $(check-qtest-virtio-y)
+check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
+check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
+check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 
-- 
2.9.3
