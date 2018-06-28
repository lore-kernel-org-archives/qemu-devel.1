Received: from eggs.gnu.org ([2001:4830:134:3::10]:38390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB5-0007ma-QR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB4-00016i-CL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:03 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:51035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB4-00015m-61
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:02 -0400
Received: by mail-wm0-x22b.google.com with SMTP id e16-v6so10988374wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:58 +0200
Message-Id: <1530216310-52873-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 48/60] ioapic: some proper indents when dump info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

So that now it looks better when with other irqchips.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171229073104.3810-4-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index c62ba27..a02c135 100644
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
1.8.3.1
