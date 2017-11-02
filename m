Received: from eggs.gnu.org ([2001:4830:134:3::10]:57185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eABvS-0007Nx-PR
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eABvP-000490-M7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eABvP-00047K-FU
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:36:35 -0400
From: P J P <ppandit@redhat.com>
Date: Thu,  2 Nov 2017 15:06:25 +0530
Message-Id: <20171102093625.32342-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] pc: restrict port92 register value to 2 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Niu Guoxiang <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Port 92 configuration register holds an 8-bit value. Of 8-bits,
bits 0-1 are used and 2-7 are reserved. Restrict the supplied
value to 2 bits.

Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/i386/pc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..883384a599 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -515,6 +515,7 @@ static void port92_write(void *opaque, hwaddr addr, uint64_t val,
     Port92State *s = opaque;
     int oldval = s->outport;
 
+    val &= 0x03;
     DPRINTF("port92: write 0x%02" PRIx64 "\n", val);
     s->outport = val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
-- 
2.13.6
