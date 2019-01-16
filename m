Received: from eggs.gnu.org ([209.51.188.92]:46717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjgGy-0004SN-HB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjgGx-0005sm-NR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:10:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gjgGx-0005jy-C4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:10:03 -0500
From: Zhang Yi <yi.z.zhang@linux.intel.com>
Date: Wed, 16 Jan 2019 16:10:17 +0800
Message-Id: <5a9ab3832eacb1e4bc6649f72bcf2969074573f1.1547624239.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH V9 1/6] numa: Fixed the memory leak of numa
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>

object_get_canonical_path_component() returns a string which
must be freed using g_free().

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Reviewed-by: Pankaj gupta <pagupta@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/numa.c b/numa.c
index 50ec016..3875e1e 100644
--- a/numa.c
+++ b/numa.c
@@ -533,6 +533,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
             error_report("memory backend %s is used multiple times. Each "
                          "-numa option must use a different memdev value.",
                          path);
+            g_free(path);
             exit(1);
         }
 
-- 
2.7.4
