Received: from eggs.gnu.org ([2001:4830:134:3::10]:51661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs8-00034J-C7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs7-00046Y-Lk
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:44 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 28 Nov 2018 20:12:52 +0800
Message-Id: <1543407172-16175-10-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V10 9/9]  pvpanic : update pvpanic document
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
 docs/specs/pvpanic.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc..b1beea3 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -1,14 +1,17 @@
 PVPANIC DEVICE
 ==============
 
-pvpanic device is a simulated ISA device, through which a guest panic
-event is sent to qemu, and a QMP event is generated. This allows
+pvpanic device is a simulated ISA/SYSBUS device, through which a guest
+panic event is sent to qemu, and a QMP event is generated. This allows
 management apps (e.g. libvirt) to be notified and respond to the event.
 
 The management app has the option of waiting for GUEST_PANICKED events,
 and/or polling for guest-panicked RunState, to learn when the pvpanic
 device has fired a panic event.
 
+The pvpanic device can be implemented as an ISA device (using IOPORT), 
+or, since qemu 4.0, as a SYSBUS device (using MMIO).
+
 ISA Interface
 -------------
 
@@ -19,6 +22,13 @@ Software should set only bits both itself and the device recognize.
 Currently, only bit 0 is recognized, setting it indicates a guest panic
 has happened.
 
+SYSBUS Interface
+----------------
+
+The SYSBUS interface is similar to the ISA interface except that it uses
+MMIO. For example, the arm virt machine could put the pvpanic device at
+[0x9070000, 0x9070001] and currently only the first byte is used.
+
 ACPI Interface
 --------------
 
-- 
1.8.3.1
