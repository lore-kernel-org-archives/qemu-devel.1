Received: from eggs.gnu.org ([2001:4830:134:3::10]:43128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4n-0000rP-UT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4n-0002cT-8Z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4n-0002cD-2X
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:17 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2264FC05493A
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:41 -0500
Message-Id: <20170313195547.21466-25-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/30] trace: Fix parameter types in hw/sd
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
 hw/sd/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index b17e7ba..b835ae4 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,5 @@
 # See docs/tracing.txt for syntax documentation.

 # hw/sd/milkymist-memcard.c
-milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_memcard_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_memcard_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
-- 
2.9.3
