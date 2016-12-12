Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGa1S-0008Ll-E8
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 18:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGa1R-00071w-L2
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 18:28:42 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 13 Dec 2016 00:28:33 +0100
Message-Id: <1481585316-31612-2-git-send-email-lvivier@redhat.com>
In-Reply-To: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qtest: add netfilter tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e98d3b6..be6209d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -283,6 +283,9 @@ gcov-files-ppc64-y += hw/usb/hcd-uhci.c
 check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-xhci.c
 check-qtest-ppc64-y += $(check-qtest-virtio-y)
+check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
+check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
+check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
 
 check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 
-- 
2.7.4
