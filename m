Received: from eggs.gnu.org ([2001:4830:134:3::10]:49997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gUrSS-00031G-7s
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gUrSN-0000JT-V4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:04:40 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 6 Dec 2018 19:26:00 +0800
Message-Id: <1544095560-70807-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
References: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH]  pvpanic : update pvpanic document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Add mmio mode as a pci device support info in docs/specs/pvpanic.txt.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 docs/specs/pvpanic.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc..6d62d72 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -1,7 +1,7 @@
 PVPANIC DEVICE
 ==============
 
-pvpanic device is a simulated ISA device, through which a guest panic
+pvpanic device is a simulated device, through which a guest panic
 event is sent to qemu, and a QMP event is generated. This allows
 management apps (e.g. libvirt) to be notified and respond to the event.
 
@@ -9,6 +9,10 @@ The management app has the option of waiting for GUEST_PANICKED events,
 and/or polling for guest-panicked RunState, to learn when the pvpanic
 device has fired a panic event.
 
+The pvpanic device can be implemented as an ISA device (using IOPORT),
+or, since qemu 4.0, as a PCI device (using MMIO address space of pci
+device).
+
 ISA Interface
 -------------
 
@@ -19,6 +23,13 @@ Software should set only bits both itself and the device recognize.
 Currently, only bit 0 is recognized, setting it indicates a guest panic
 has happened.
 
+PCI Interface
+-------------
+
+The PCI interface is similar to the ISA interface except that it uses
+MMIO. For example, the arm virt machine could enable pvpanic-pci device 
+according to adding "-device pvpanic-pci" in qemu command.
+
 ACPI Interface
 --------------
 
-- 
1.8.3.1
