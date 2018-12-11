Received: from eggs.gnu.org ([2001:4830:134:3::10]:41386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMJ-0005YZ-Sv
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMH-0004yT-SF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMD-0004tm-Ud
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:10 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:16 -0200
Message-Id: <20181211180129.7661-12-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/24] numa: Match struct to typedef name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

There's no reason to violate our naming conventions by having a
struct with a different name than its typedef.  Messed up since
its introduction in commit 8c85901e, but made more obvious when
commit 3bfe5716 promoted it to typedefs.h.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181115211752.1295571-3-eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qemu/typedefs.h | 2 +-
 include/sysemu/numa.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index fed53f6de2..d59df20c4d 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -61,6 +61,7 @@ typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
+typedef struct NodeInfo NodeInfo;
 typedef struct NumaNodeMem NumaNodeMem;
 typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
@@ -113,7 +114,6 @@ typedef struct SSIBus SSIBus;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
-typedef struct node_info NodeInfo;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 21713b7e2f..b6ac7de43e 100644
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
2.18.0.rc1.1.g3f1ff2140
