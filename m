Received: from eggs.gnu.org ([2001:4830:134:3::10]:58886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6yx-0002S4-AW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6yw-0000ZW-K0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:26:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 09:26:20 -0500
Message-Id: <20170717142620.6970-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Remove a few tests from 'quick' group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>

A run of './check -qcow2 -g quick' on my machine produced only
two tests that took longer than 5 seconds; 178 took 18, and
189 took 7.  Remove them from the quick group.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 2aba585287..01f12d6781 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -175,11 +175,11 @@
 175 auto quick
 176 rw auto backing
 177 rw auto quick
-178 auto quick
+178 auto
 179 rw auto quick
 181 rw auto migration
 182 rw auto quick
 183 rw auto migration
 185 rw auto
 188 rw auto quick
-189 rw auto quick
+189 rw auto
-- 
2.13.3
