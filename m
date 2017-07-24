Received: from eggs.gnu.org ([2001:4830:134:3::10]:45567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePT-0001m4-Ql
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePQ-0007Bt-Ds
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 24 Jul 2017 16:32:06 +0200
Message-Id: <1500906730-26467-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
References: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] iotests: Remove a few tests from 'quick'
 group
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

A run of './check -qcow2 -g quick' on my machine produced only
two tests that took longer than 5 seconds; 178 took 18, and
189 took 7.  Remove them from the quick group.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0961f8c..287f0ea 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -175,7 +175,7 @@
 175 auto quick
 176 rw auto backing
 177 rw auto quick
-178 auto quick
+178 auto
 179 rw auto quick
 181 rw auto migration
 182 rw auto quick
@@ -183,4 +183,4 @@
 185 rw auto
 186 rw auto
 188 rw auto quick
-189 rw auto quick
+189 rw auto
-- 
1.8.3.1
