Received: from eggs.gnu.org ([2001:4830:134:3::10]:43046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4k-0000o0-0Z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4h-0002ZW-Gx
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4h-0002ZB-AU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:11 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C27B25E405
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:34 -0500
Message-Id: <20170313195547.21466-18-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/30] trace: Fix parameter types in hw/input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/input/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/input/trace-events b/hw/input/trace-events
index f3bfbed..8d599ff 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -16,8 +16,8 @@ ps2_kbd_init(void *s) "%p"
 ps2_mouse_init(void *s) "%p"

 # hw/input/milkymist-softusb.c
-milkymist_softusb_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_softusb_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_softusb_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_softusb_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
 milkymist_softusb_mevt(uint8_t m) "m %d"
 milkymist_softusb_kevt(uint8_t m) "m %d"
 milkymist_softusb_pulse_irq(void) "Pulse IRQ"
-- 
2.9.3
