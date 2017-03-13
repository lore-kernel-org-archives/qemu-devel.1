Received: from eggs.gnu.org ([2001:4830:134:3::10]:43015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4g-0000kJ-Gq
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4f-0002YZ-L7
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4f-0002XW-El
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:33 -0500
Message-Id: <20170313195547.21466-17-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/30] trace: Fix parameter types in hw/i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/i386/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a213bfd..ca6ec22 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -41,7 +41,7 @@ amdvi_mmio_read_invalid(int max, hwaddr addr, unsigned size) "error: addr outsid
 amdvi_command_error(uint64_t status) "error: Executing commands with command buffer disabled 0x%"PRIx64
 amdvi_command_read_fail(uint64_t addr, uint32_t head) "error: fail to access memory at 0x%"PRIx64" + 0x%"PRIx32
 amdvi_command_exec(uint32_t head, uint32_t tail, uint64_t buf) "command buffer head at 0x%"PRIx32" command buffer tail at 0x%"PRIx32" command buffer base at 0x%"PRIx64
-amdvi_unhandled_command(uint8_t type) "unhandled command 0x%"PRIx8
+amdvi_unhandled_command(uint64_t type) "unhandled command 0x%"PRIx64
 amdvi_intr_inval(void) "Interrupt table invalidated"
 amdvi_iotlb_inval(void) "IOTLB pages invalidated"
 amdvi_prefetch_pages(void) "Pre-fetch of AMD-Vi pages requested"
-- 
2.9.3
