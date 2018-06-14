Received: from eggs.gnu.org ([2001:4830:134:3::10]:55910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTOz0-0002Zx-Al
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTOyz-0007Su-DY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:55:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 14 Jun 2018 11:55:44 +0200
Message-Id: <20180614095544.31549-5-kwolf@redhat.com>
In-Reply-To: <20180614095544.31549-1-kwolf@redhat.com>
References: <20180614095544.31549-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] block: Remove dead deprecation warning
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

We removed all options from the 'deprecated' array, so the code is dead
and can be removed as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 695e10d398..4ab3d6ec0b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -774,8 +774,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     const char *filename;
     Error *local_err = NULL;
     int i;
-    const char *deprecated[] = {
-    };
 
     /* Change legacy command line options into QMP ones */
     static const struct {
@@ -852,16 +850,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         goto fail;
     }
 
-    /* Other deprecated options */
-    if (!qtest_enabled()) {
-        for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
-            if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
-                error_report("'%s' is deprecated, please use the corresponding "
-                             "option of '-device' instead", deprecated[i]);
-            }
-        }
-    }
-
     /* Media type */
     value = qemu_opt_get(legacy_opts, "media");
     if (value) {
-- 
2.13.6
