Received: from eggs.gnu.org ([2001:4830:134:3::10]:48528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEIDu-00046c-6D
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEIDt-0001tI-EK
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:04:06 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  6 Dec 2016 10:03:45 -0600
Message-Id: <20161206160345.22425-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.8] qapi: Document DEVICE_TRAY_MOVED
 addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org

Commit 2d76e72 failed to add a versioning tag to 'id'.

I audited all qapi*.json files from v2.7.0 to the current
state of the tree, and didn't find any other additions where
we failed to use a version tag.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Doc-only, so safe for 2.8. But we're also close enough to -rc3
that I'm fine if it has to go in later via -stable.

 qapi/block.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block.json b/qapi/block.json
index 937df05..8e9f590 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -199,7 +199,7 @@
 #          reasons, but it can be empty ("") if the image does not
 #          have a device name associated.
 #
-# @id: The name or QOM path of the guest device
+# @id: The name or QOM path of the guest device (since 2.8)
 #
 # @tray-open: true if the tray has been opened or false if it has been closed
 #
-- 
2.9.3
