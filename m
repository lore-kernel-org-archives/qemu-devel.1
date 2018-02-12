Received: from eggs.gnu.org ([2001:4830:134:3::10]:52613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTe-00006W-QY
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTd-0003Rw-Rg
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:44:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Feb 2018 13:44:48 +0100
Message-Id: <1518439489-2724-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1518439489-2724-1-git-send-email-thuth@redhat.com>
References: <1518439489-2724-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] tests/Makefile: Derive check-qtest-ppc64-y
 from check-qtest-ppc-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org

ppc64 is a superset of ppc, so the ppc64 tests should include all
the ppc tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 78bd163..3ac874c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -319,15 +319,12 @@ check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
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
