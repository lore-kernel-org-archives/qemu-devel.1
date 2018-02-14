Received: from eggs.gnu.org ([2001:4830:134:3::10]:43631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7X-0006Xj-W5
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7X-0007GE-3Q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7W-0007G7-VH
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:33 +0100
Message-Id: <1518607234-17739-18-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 17/18] tests/Makefile: Derive
 check-qtest-ppc64-y from check-qtest-ppc-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

ppc64 is a superset of ppc, so the ppc64 tests should include all
the ppc tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c27a9a5..95ce99e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -320,15 +320,12 @@ check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
 
-check-qtest-ppc64-y = tests/spapr-phb-test$(EXESUF)
-gcov-files-ppc64-y = ppc64-softmmu/hw/ppc/spapr_pci.c
-check-qtest-ppc64-y += tests/endianness-test$(EXESUF)
-check-qtest-ppc64-y += tests/boot-order-test$(EXESUF)
-check-qtest-ppc64-y += tests/prom-env-test$(EXESUF)
+check-qtest-ppc64-y = $(check-qtest-ppc-y)
+gcov-files-ppc64-y = $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-ppc-y))
+check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
+gcov-files-ppc64-y += ppc64-softmmu/hw/ppc/spapr_pci.c
 check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
-check-qtest-ppc64-y += tests/drive_del-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
-check-qtest-ppc64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-ppc64-y += tests/usb-hcd-ohci-test$(EXESUF)
-- 
1.8.3.1
