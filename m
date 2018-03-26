Received: from eggs.gnu.org ([2001:4830:134:3::10]:45352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEM-0002wu-JL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEL-0003u8-Hj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:42 +0200
Message-Id: <20180326143600.7724-2-kwolf@redhat.com>
In-Reply-To: <20180326143600.7724-1-kwolf@redhat.com>
References: <20180326143600.7724-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/19] iotests: 163 is not quick
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

From: Eric Blake <eblake@redhat.com>

Testing on ext4, most 'quick' qcow2 tests took less than 5 seconds,
but 163 took more than 20.  Let's remove it from the quick set.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index efe0e958f2..0c2983f4cd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -167,7 +167,7 @@
 159 rw auto quick
 160 rw auto quick
 162 auto quick
-163 rw auto quick
+163 rw auto
 165 rw auto quick
 169 rw auto quick
 170 rw auto quick
-- 
2.13.6
