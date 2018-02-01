Received: from eggs.gnu.org ([2001:4830:134:3::10]:38910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIgk-0004Hv-LW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ehIgb-00064F-0N
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:30:18 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu,  1 Feb 2018 12:28:11 -0500
Message-Id: <1517506091-10396-4-git-send-email-wei@redhat.com>
In-Reply-To: <1517506091-10396-1-git-send-email-wei@redhat.com>
References: <1517506091-10396-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] tests: Enable xhci test arm/aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com

Signed-off-by: Wei Huang <wei@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e28277c..a79a7b8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -366,10 +366,12 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/drive_del-test$(EXESUF)
+check-qtest-arm-y += tests/usb-hcd-xhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/drive_del-test$(EXESUF)
+check-qtest-aarch64-y += tests/usb-hcd-xhci-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
-- 
1.8.3.1
