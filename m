Received: from eggs.gnu.org ([209.51.188.92]:60408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9w-0002LM-Lx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1h1t9v-0003Ld-V9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:34:04 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu,  7 Mar 2019 16:33:57 +0300
Message-Id: <1551965640-164939-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/4] iotests: open notrun files in text mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Replace the binary mode with the default text one when *.notrun
files are opened for skipped tests. That change is made for the
compatibility with Python 3 which returns error otherwise.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4910fb2..35b63fc 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -712,7 +712,7 @@ def notrun(reason):
     # Each test in qemu-iotests has a number ("seq")
     seq = os.path.basename(sys.argv[0])
 
-    open('%s/%s.notrun' % (output_dir, seq), 'wb').write(reason + '\n')
+    open('%s/%s.notrun' % (output_dir, seq), 'w').write(reason + '\n')
     print('%s not run: %s' % (seq, reason))
     sys.exit(0)
 
-- 
1.8.3.1
