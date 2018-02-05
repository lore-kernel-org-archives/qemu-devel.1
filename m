Received: from eggs.gnu.org ([2001:4830:134:3::10]:43171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5W-0007tE-2N
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5R-0000yQ-Ix
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:42 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:14 +0200
Message-Id: <a1c45c5c5a76146dd1712d8d1e7b409ad539c718.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 14/39] qcow2: Add offset_to_l2_slice_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Similar to offset_to_l2_index(), this function takes a guest offset
and returns the index in the L2 slice that contains its L2 entry.

An L2 slice has currently the same size as an L2 table (one cluster),
so both functions return the same value for now.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index e0aee88811..87b5c4063e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -474,6 +474,11 @@ static inline int offset_to_l2_index(BDRVQcow2State *s, int64_t offset)
     return (offset >> s->cluster_bits) & (s->l2_size - 1);
 }
 
+static inline int offset_to_l2_slice_index(BDRVQcow2State *s, int64_t offset)
+{
+    return (offset >> s->cluster_bits) & (s->l2_slice_size - 1);
+}
+
 static inline int64_t align_offset(int64_t offset, int n)
 {
     offset = (offset + n - 1) & ~(n - 1);
-- 
2.11.0
