Received: from eggs.gnu.org ([2001:4830:134:3::10]:59386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cP9zI-0003uP-Ag
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cP9zG-0004lu-IZ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:29:56 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  5 Jan 2017 16:29:44 +0100
Message-Id: <1483630188-32021-2-git-send-email-lvivier@redhat.com>
In-Reply-To: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
References: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] qtest: add netfilter tests for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
---
 tests/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4841d58..8d6ac7a 100644
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
2.7.4
