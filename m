Received: from eggs.gnu.org ([2001:4830:134:3::10]:59375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbk-0006LE-J5
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbj-0003xG-O3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:21:08 +0200
Message-Id: <20180615142108.27814-27-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/26] block: Remove dead deprecation warning
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

We removed all options from the 'deprecated' array, so the code is dead
and can be removed as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index d1ab425085..7f65cd7497 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -775,8 +775,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     const char *filename;
     Error *local_err = NULL;
     int i;
-    const char *deprecated[] = {
-    };
 
     /* Change legacy command line options into QMP ones */
     static const struct {
@@ -853,16 +851,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
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
