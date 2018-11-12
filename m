Received: from eggs.gnu.org ([2001:4830:134:3::10]:40173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gM2mO-0002Ah-7h
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 22:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gM2mN-0003En-Dz
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 22:20:48 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Mon, 12 Nov 2018 19:42:20 +0800
Message-Id: <1542022940-46849-7-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1542022940-46849-1-git-send-email-peng.hao2@zte.com.cn>
References: <1542022940-46849-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V6 6/6]  pvpanic : update pvpanic document
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

Add mmio support info in docs/specs/pvpanic.txt.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 docs/specs/pvpanic.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc..5d8e9dc 100644
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
 
+When pvpanic device is implemented as a ISA device, it supports IOPORT 
+mode. If pvpanic device supports MMIO mode, it will be implemented as
+a SYSBUS device.
+
 ISA Interface
 -------------
 
@@ -19,6 +23,13 @@ Software should set only bits both itself and the device recognize.
 Currently, only bit 0 is recognized, setting it indicates a guest panic
 has happened.
 
+SYSBUS Interface
+--------------
+
+It is basically the same as ISA interface except that it uses MMIO. Pvpanic exposes
+a address space region 0x09060000--0x09060001 in arm virt machine.
+Currently only the first byte is used. 
+
 ACPI Interface
 --------------
 
-- 
1.8.3.1
