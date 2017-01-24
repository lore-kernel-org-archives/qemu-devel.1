Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7o-0002id-6T
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7l-0002ao-IV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:11 +0300
Message-Id: <1b6498d7677e963da6ecadacf0feb85862188aae.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 07/31] qemu-options: cleanup duplicated help
 message for kernel_irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Po-Hsu Lin <po-hsu.lin@canonical.com>

Remove the duplicated help message for 'kernel_irqchip'.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 82b9991..84b7bd9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -32,7 +32,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
     "                supported accelerators are kvm, xen, tcg (default: tcg)\n"
-    "                kernel_irqchip=on|off controls accelerated irqchip support\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
-- 
2.1.4
