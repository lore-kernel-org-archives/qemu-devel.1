Received: from eggs.gnu.org ([2001:4830:134:3::10]:53462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIV-000473-8Y
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIU-0006N0-IW
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIU-0006Lu-Cd
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:06 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9657C7FE8C
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:32:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:27 +0100
Message-Id: <20170120133139.31080-24-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/35] x86: ioapic: dump version for "info
 ioapic"
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

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1483952153-7221-3-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 1b7ec5e..97c4f9c 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -58,7 +58,8 @@ void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
     uint32_t remote_irr = 0;
     int i;
 
-    monitor_printf(mon, "ioapic id=0x%02x sel=0x%02x", s->id, s->ioregsel);
+    monitor_printf(mon, "ioapic ver=0x%x id=0x%02x sel=0x%02x",
+                   s->version, s->id, s->ioregsel);
     if (s->ioregsel) {
         monitor_printf(mon, " (redir[%u])\n",
                        (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >> 1);
-- 
2.9.3
