Received: from eggs.gnu.org ([2001:4830:134:3::10]:55379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WN-Dw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVB-0003G6-Oh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:42 +0100
Message-Id: <91f760c0f3fd28e4baddf20c9bc7a9b9775eb593.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 14/32] qcow2: Add offset_to_l2_slice_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

Similar to offset_to_l2_index(), this function takes a guest offset
and returns the index in the L2 slice that contains its L2 entry.

An L2 slice has currently the same size as an L2 table (one cluster),
so both functions return the same value for now.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 2435fd786f..1894d1d028 100644
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
