Received: from eggs.gnu.org ([2001:4830:134:3::10]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1k-0004Ad-G6
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gTm1i-0002gy-Tt
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:04:36 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 4 Dec 2018 03:26:49 +0800
Message-Id: <1543865209-50994-9-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V11 8/8]  pvpanic : update pvpanic document
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

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 docs/specs/pvpanic.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc..994f080 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -1,7 +1,7 @@
 PVPANIC DEVICE
 ==============
 
-pvpanic device is a simulated ISA device, through which a guest panic
+pvpanic device is a simulated device, through which a guest panic
 event is sent to qemu, and a QMP event is generated. This allows
 management apps (e.g. libvirt) to be notified and respond to the event.
 
@@ -9,6 +9,9 @@ The management app has the option of waiting for GUEST_PANICKED events,
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
+[0x9070000, 0x9070001], where currently only the first byte is used.
+
 ACPI Interface
 --------------
 
-- 
1.8.3.1
