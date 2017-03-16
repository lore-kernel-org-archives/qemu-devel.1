Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI9-0003Ox-TW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI9-00009A-6B
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1coRI9-00008c-11
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F375A7E9DA
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:01:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 16 Mar 2017 10:01:40 +0100
Message-Id: <20170316090141.13421-6-quintela@redhat.com>
In-Reply-To: <20170316090141.13421-1-quintela@redhat.com>
References: <20170316090141.13421-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Provide a helper to say whether a RAMBlock was created as a
shared mapping.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 exec.c                    | 5 +++++
 include/exec/cpu-common.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/exec.c b/exec.c
index a22f5a0..e57a8a2 100644
--- a/exec.c
+++ b/exec.c
@@ -1561,6 +1561,11 @@ const char *qemu_ram_get_idstr(RAMBlock *rb)
     return rb->idstr;
 }
 
+bool qemu_ram_is_shared(RAMBlock *rb)
+{
+    return rb->flags & RAM_SHARED;
+}
+
 /* Called with iothread lock held.  */
 void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
 {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b62f0d8..4d45a72 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -69,6 +69,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
+bool qemu_ram_is_shared(RAMBlock *rb);
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
-- 
2.9.3
