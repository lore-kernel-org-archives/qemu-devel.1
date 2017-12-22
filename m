Received: from eggs.gnu.org ([2001:4830:134:3::10]:57118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6W-0005ez-OI
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6V-0002L7-Tg
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:25 +0100
Message-Id: <20171222151846.28110-15-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 14/35] block: Remove the obsolete -drive
 boot=on|off parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

It's not working anymore since QEMU v1.3.0 - time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c    | 11 -----------
 qemu-doc.texi |  6 ------
 2 files changed, 17 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 9c3a430cfb..29d569a24e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -735,10 +735,6 @@ QemuOptsList qemu_legacy_drive_opts = {
             .type = QEMU_OPT_STRING,
             .help = "chs translation (auto, lba, none)",
         },{
-            .name = "boot",
-            .type = QEMU_OPT_BOOL,
-            .help = "(deprecated, ignored)",
-        },{
             .name = "addr",
             .type = QEMU_OPT_STRING,
             .help = "pci address (virtio only)",
@@ -873,13 +869,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         goto fail;
     }
 
-    /* Deprecated option boot=[on|off] */
-    if (qemu_opt_get(legacy_opts, "boot") != NULL) {
-        fprintf(stderr, "qemu-kvm: boot=on|off is deprecated and will be "
-                "ignored. Future versions will reject this parameter. Please "
-                "update your scripts.\n");
-    }
-
     /* Other deprecated options */
     if (!qtest_enabled()) {
         for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 90bea7331d..ed55bd477d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2589,12 +2589,6 @@ deprecated.
 
 @section System emulator command line arguments
 
-@subsection -drive boot=on|off (since 1.3.0)
-
-The ``boot=on|off'' option to the ``-drive'' argument is
-ignored. Applications should use the ``bootindex=N'' parameter
-to set an absolute ordering between devices instead.
-
 @subsection -tdf (since 1.3.0)
 
 The ``-tdf'' argument is ignored. The behaviour implemented
-- 
2.13.6
