Received: from eggs.gnu.org ([2001:4830:134:3::10]:53781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNP1U-0005dy-CV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNP1T-00051M-Q4
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:18:00 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Nov 2018 15:17:52 -0600
Message-Id: <20181115211752.1295571-3-eblake@redhat.com>
In-Reply-To: <20181115211752.1295571-1-eblake@redhat.com>
References: <20181115211752.1295571-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] numa: Match struct to typedef name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

There's no reason to violate our naming conventions by having a
struct with a different name than its typedef.  Messed up since
its introduction in commit 8c85901e, but made more obvious when
commit 3bfe5716 promoted it to typedefs.h.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/typedefs.h | 2 +-
 include/sysemu/numa.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 45eab4078eb..a9cfe1b2c2e 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -61,6 +61,7 @@ typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
+typedef struct NodeInfo NodeInfo;
 typedef struct NumaNodeMem NumaNodeMem;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
@@ -112,7 +113,6 @@ typedef struct SSIBus SSIBus;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
-typedef struct node_info NodeInfo;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 21713b7e2f6..b6ac7de43ed 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -9,7 +9,7 @@
 extern int nb_numa_nodes;   /* Number of NUMA nodes */
 extern bool have_numa_distance;

-struct node_info {
+struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
-- 
2.17.2
