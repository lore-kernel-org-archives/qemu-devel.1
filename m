Received: from eggs.gnu.org ([2001:4830:134:3::10]:52258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLj-0004jQ-Kv
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLf-0001Nr-EE
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:27 +0200
Message-Id: <20180815125537.10651-12-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/21] qapi/block: Document restrictions for
 node names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

blockdev-add fails if an invalid node name is given, so we should
document what a valid node name even is.

Reported-by: Cong Li <coli@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Cong Li <coli@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 qapi/block-core.json | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b9084a394..f20efc97f7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3572,6 +3572,9 @@
 # @driver:        block driver name
 # @node-name:     the node name of the new node (Since 2.0).
 #                 This option is required on the top level of blockdev-add.
+#                 Valid node names start with an alphabetic character and may
+#                 contain only alphanumeric characters, '-', '.' and '_'. Their
+#                 maximum length is 31 characters.
 # @discard:       discard-related options (default: ignore)
 # @cache:         cache-related options
 # @read-only:     whether the block device should be read-only (default: false).
-- 
2.13.6
