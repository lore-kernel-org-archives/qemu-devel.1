Received: from eggs.gnu.org ([2001:4830:134:3::10]:36313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAvwp-0002xd-Ey
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAvwl-0000Iz-Mp
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gAvwj-00009e-RS
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:49:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 12 Oct 2018 13:49:12 +0200
Message-Id: <20181012114916.23532-4-david@redhat.com>
In-Reply-To: <20181012114916.23532-1-david@redhat.com>
References: <20181012114916.23532-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/7] range: pass const pointer where possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

If there are no changes, let's use a const pointer.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/range.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index f28f0c1825..7e75f4e655 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -39,7 +39,7 @@ struct Range {
     uint64_t upb;        /* inclusive upper bound */
 };
 
-static inline void range_invariant(Range *range)
+static inline void range_invariant(const Range *range)
 {
     assert(range->lob <= range->upb || range->lob == range->upb + 1);
 }
@@ -48,14 +48,14 @@ static inline void range_invariant(Range *range)
 #define range_empty ((Range){ .lob = 1, .upb = 0 })
 
 /* Is @range empty? */
-static inline bool range_is_empty(Range *range)
+static inline bool range_is_empty(const Range *range)
 {
     range_invariant(range);
     return range->lob > range->upb;
 }
 
 /* Does @range contain @val? */
-static inline bool range_contains(Range *range, uint64_t val)
+static inline bool range_contains(const Range *range, uint64_t val)
 {
     return val >= range->lob && val <= range->upb;
 }
-- 
2.17.1
