Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8W-0005WY-V9
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8U-0007Z7-CH
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUp8U-0007Ye-6G
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60CC87F7AB
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 07:31:21 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Dec 2017 15:31:02 +0800
Message-Id: <20171229073104.3810-4-peterx@redhat.com>
In-Reply-To: <20171229073104.3810-1-peterx@redhat.com>
References: <20171229073104.3810-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] ioapic: some proper indents when dump info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

So that now it looks better when with other irqchips.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/ioapic_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index c62ba27018..a02c135b24 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -59,7 +59,7 @@ void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
     uint32_t remote_irr = 0;
     int i;
 
-    monitor_printf(mon, "ioapic ver=0x%x id=0x%02x sel=0x%02x",
+    monitor_printf(mon, "ioapic0: ver=0x%x id=0x%02x sel=0x%02x",
                    s->version, s->id, s->ioregsel);
     if (s->ioregsel) {
         monitor_printf(mon, " (redir[%u])\n",
@@ -71,7 +71,7 @@ void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
         uint64_t entry = s->ioredtbl[i];
         uint32_t delm = (uint32_t)((entry & IOAPIC_LVT_DELIV_MODE) >>
                                    IOAPIC_LVT_DELIV_MODE_SHIFT);
-        monitor_printf(mon, "pin %-2u 0x%016"PRIx64" dest=%"PRIx64
+        monitor_printf(mon, "  pin %-2u 0x%016"PRIx64" dest=%"PRIx64
                        " vec=%-3"PRIu64" %s %-5s %-6s %-6s %s\n",
                        i, entry,
                        (entry >> IOAPIC_LVT_DEST_SHIFT) &
@@ -86,8 +86,8 @@ void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
         remote_irr |= entry & IOAPIC_LVT_TRIGGER_MODE ?
                         (entry & IOAPIC_LVT_REMOTE_IRR ? (1 << i) : 0) : 0;
     }
-    ioapic_irr_dump(mon, "IRR", s->irr);
-    ioapic_irr_dump(mon, "Remote IRR", remote_irr);
+    ioapic_irr_dump(mon, "  IRR", s->irr);
+    ioapic_irr_dump(mon, "  Remote IRR", remote_irr);
 }
 
 void ioapic_reset_common(DeviceState *dev)
-- 
2.14.3
