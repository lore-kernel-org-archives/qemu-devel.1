Received: from eggs.gnu.org ([2001:4830:134:3::10]:41817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clJyW-0008MG-0L
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clJyU-0001GD-2d
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clJyT-0001G0-Sz
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 13:36:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C3063D940
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 18:36:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  7 Mar 2017 18:36:36 +0000
Message-Id: <20170307183637.21245-2-dgilbert@redhat.com>
In-Reply-To: <20170307183637.21245-1-dgilbert@redhat.com>
References: <20170307183637.21245-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: pbonzini@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Provide a helper to say whether a RAMBlock was created as a
shared mapping.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                    | 5 +++++
 include/exec/cpu-common.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/exec.c b/exec.c
index aabb035..c2cc455 100644
--- a/exec.c
+++ b/exec.c
@@ -1560,6 +1560,11 @@ const char *qemu_ram_get_idstr(RAMBlock *rb)
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
