Received: from eggs.gnu.org ([2001:4830:134:3::10]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkkN5-0005kU-U2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkkN1-0008Il-U9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:07:59 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 24 Aug 2017 07:07:50 +0200
Message-Id: <1503551270-30648-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] tests/test-hmp: Remove puv3 and
 tricore_testboard from the blacklist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Otubo <otubo@redhat.com>

The problem with puv3 has been fixed with 0ac241bcf9f9d99a252a352a162f
('unicore32: abort when entering "x 0" on the monitor') and the problem
with tricore_testboard has been fixed with b190f477e29c7cd03a8fee49c96d
('qemu-system-tricore: segfault when entering "x 0" on the monitor').

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-hmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 4382df0..9f286bf 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -192,8 +192,7 @@ static void add_machine_test_case(const char *mname)
     char *path;
 
     /* Ignore blacklisted machines that have known problems */
-    if (!strcmp("puv3", mname) || !strcmp("tricore_testboard", mname) ||
-        !strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
+    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
         return;
     }
 
-- 
1.8.3.1
