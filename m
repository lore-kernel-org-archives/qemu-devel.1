Received: from eggs.gnu.org ([2001:4830:134:3::10]:52754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ0-0001oK-KK
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYu-0006tx-Ac
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:14 +0200
Message-Id: <20180523131155.12359-6-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/46] qemu-iotests: Add more tests to
 "migration" group
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

grep for "migrate" turns up a few test cases which use migration, but
haven't been in the "migration" group so far. Add them to the group.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/qemu-iotests/group | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index cc8cd8cc8e..60ba31b292 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -97,7 +97,7 @@
 088 rw auto quick
 089 rw auto quick
 090 rw auto quick
-091 rw auto
+091 rw auto migration
 092 rw auto quick
 093 auto
 094 rw auto quick
@@ -169,7 +169,7 @@
 162 auto quick
 163 rw auto
 165 rw auto quick
-169 rw auto quick
+169 rw auto quick migration
 170 rw auto quick
 171 rw auto quick
 172 auto
@@ -194,14 +194,14 @@
 192 rw auto quick
 194 rw auto migration quick
 195 rw auto quick
-196 rw auto quick
+196 rw auto quick migration
 197 rw auto quick
 198 rw auto
-199 rw auto
+199 rw auto migration
 200 rw auto
 201 rw auto migration
 202 rw auto quick
-203 rw auto
+203 rw auto migration
 204 rw auto quick
 205 rw auto quick
 206 rw auto
-- 
2.13.6
