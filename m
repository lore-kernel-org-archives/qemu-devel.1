Received: from eggs.gnu.org ([2001:4830:134:3::10]:43047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4k-0000o2-0s
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4j-0002a9-6C
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4i-0002Zf-Vf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:13 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE994C05B1D3
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:36 -0500
Message-Id: <20170313195547.21466-20-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/30] trace: Fix parameter types in hw/isa
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
 hw/isa/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 9faca41..58179ef 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -1,8 +1,8 @@
 # See docs/tracing.txt for syntax documentation.

 # hw/isa/pc87312.c
-pc87312_io_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-pc87312_io_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
+pc87312_io_read(hwaddr addr, uint32_t val) "read addr=%" HWADDR_PRIx " val=%x"
+pc87312_io_write(hwaddr addr, uint64_t val) "write addr=%" HWADDR_PRIx " val=%" PRIx64
 pc87312_info_floppy(uint32_t base) "base 0x%x"
 pc87312_info_ide(uint32_t base) "base 0x%x"
 pc87312_info_parallel(uint32_t base, uint32_t irq) "base 0x%x, irq %u"
-- 
2.9.3
