Received: from eggs.gnu.org ([2001:4830:134:3::10]:60998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cly1Q-0002dE-SM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cly1N-0003ep-4T
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:22:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cly1M-0003eh-UJ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 08:22:21 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  9 Mar 2017 13:22:15 +0000
Message-Id: <20170309132216.23482-2-dgilbert@redhat.com>
In-Reply-To: <20170309132216.23482-1-dgilbert@redhat.com>
References: <20170309132216.23482-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: pbonzini@redhat.com, lvivier@redhat.com, pasic@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Provide a helper to say whether a RAMBlock was created as a
shared mapping.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                    | 5 +++++
 include/exec/cpu-common.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/exec.c b/exec.c
index aabb035..1f25a12 100644
--- a/exec.c
+++ b/exec.c
@@ -2593,6 +2593,11 @@ MemoryRegion *get_system_io(void)
     return system_io;
 }
 
+bool qemu_ram_is_shared(RAMBlock *rb)
+{
+    return rb->flags & RAM_SHARED;
+}
+
 #endif /* !defined(CONFIG_USER_ONLY) */
 
 /* physical memory access (slow version, mainly for debug) */
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
