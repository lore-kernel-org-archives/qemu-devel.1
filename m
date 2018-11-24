Received: from eggs.gnu.org ([2001:4830:134:3::10]:48086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQTAt-00007J-Qf
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gQT44-0005ia-4H
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 03:13:20 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 25 Nov 2018 00:34:33 +0800
Message-Id: <1543077273-16201-10-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543077273-16201-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543077273-16201-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH 10/10]  pvpanic : update pvpanic document
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
 docs/specs/pvpanic.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc..2d06ee5 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -1,14 +1,18 @@
 PVPANIC DEVICE
 ==============
 
-pvpanic device is a simulated ISA device, through which a guest panic
-event is sent to qemu, and a QMP event is generated. This allows
+pvpanic device is a simulated ISA/SysBus device, through which a guest
+panic event is sent to qemu, and a QMP event is generated. This allows
 management apps (e.g. libvirt) to be notified and respond to the event.
 
-The management app has the option of waiting for GUEST_PANICKED events,
+The ma:wqnagement app has the option of waiting for GUEST_PANICKED events,
 and/or polling for guest-panicked RunState, to learn when the pvpanic
 device has fired a panic event.
 
+When pvpanic device is implemented as a ISA device, it supports IOPORT
+mode. Since QEMU v3.2 pvpanic also supports MMIO mode, it will be 
+implemented as a SYSBUS device.
+
 ISA Interface
 -------------
 
@@ -19,6 +23,14 @@ Software should set only bits both itself and the device recognize.
 Currently, only bit 0 is recognized, setting it indicates a guest panic
 has happened.
 
+SYSBUS Interface
+----------------
+
+The SYSBUS interface is similar to the ISA interface except that it uses
+MMIO. For example, the arm virt machine could put the pvpanic device at
+[0x9070000, 0x9070001] and currently only the first byte is used.
+
+
 ACPI Interface
 --------------
 
-- 
1.8.3.1
