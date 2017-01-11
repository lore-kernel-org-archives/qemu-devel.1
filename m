Received: from eggs.gnu.org ([2001:4830:134:3::10]:45498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgl-0003Ss-9n
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgi-0003SX-5q
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:03 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:36387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgh-0003SI-VD
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:00 -0500
Received: by mail-wj0-x241.google.com with SMTP id dh1so11694223wjb.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:18 +0100
Message-Id: <1484163327-111841-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/33] x86: ioapic: dump version for "info
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
1.8.3.1
