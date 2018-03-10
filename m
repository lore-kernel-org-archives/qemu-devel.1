Received: from eggs.gnu.org ([2001:4830:134:3::10]:55357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eumJf-00057S-Cd
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eumJe-000301-PN
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:46:11 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 10 Mar 2018 15:45:54 -0600
Message-Id: <20180310214554.157155-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: 163 is not quick
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

Testing on ext4, most 'quick' qcow2 tests took less than 5 seconds,
but 163 took more than 20.  Let's remove it from the quick set.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a2dfe79d862..657055bae1a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -167,7 +167,7 @@
 159 rw auto quick
 160 rw auto quick
 162 auto quick
-163 rw auto quick
+163 rw auto
 165 rw auto quick
 170 rw auto quick
 171 rw auto quick
-- 
2.14.3
