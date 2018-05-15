Received: from eggs.gnu.org ([2001:4830:134:3::10]:39151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4i-000714-BF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4e-0001mv-Cz
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:21 +0200
Message-Id: <20180515154033.19899-26-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/37] block: BLK_PERM_WRITE includes
 ..._UNCHANGED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Currently we never actually check whether the WRITE_UNCHANGED
permission has been taken for unchanging writes.  But the one check that
is commented out checks both WRITE and WRITE_UNCHANGED; and considering
that WRITE_UNCHANGED is already documented as being weaker than WRITE,
we should probably explicitly document WRITE to include WRITE_UNCHANGED.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180421132929.21610-3-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index cdec3639a3..397b5e8d44 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -205,6 +205,9 @@ enum {
      * This permission (which is weaker than BLK_PERM_WRITE) is both enough and
      * required for writes to the block node when the caller promises that
      * the visible disk content doesn't change.
+     *
+     * As the BLK_PERM_WRITE permission is strictly stronger, either is
+     * sufficient to perform an unchanging write.
      */
     BLK_PERM_WRITE_UNCHANGED    = 0x04,
 
-- 
2.13.6
