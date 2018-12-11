Received: from eggs.gnu.org ([2001:4830:134:3::10]:41150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLw-0005I5-RM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLt-0004e7-Mi
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLt-0004Zw-DW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:49 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:11 -0200
Message-Id: <20181211180129.7661-7-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/24] range: pass const pointer where possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

If there are no changes, let's use a const pointer.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181023152306.3123-4-david@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
