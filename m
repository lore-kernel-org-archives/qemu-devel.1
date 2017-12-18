Received: from eggs.gnu.org ([2001:4830:134:3::10]:32984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQz00-0005s4-8X
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQyzz-0003jp-Ea
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:14:44 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 18 Dec 2017 18:14:31 +0100
Message-Id: <1513617273-7988-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1513617273-7988-1-git-send-email-thuth@redhat.com>
References: <1513617273-7988-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] block: Remove the obsolete -drive
 boot=on|off parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

It's not working anymore since QEMU v1.3.0 - time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 blockdev.c    | 11 -----------
 qemu-doc.texi |  6 ------
 2 files changed, 17 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 56a6b24..c21ba27 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -734,10 +734,6 @@ QemuOptsList qemu_legacy_drive_opts = {
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
@@ -872,13 +868,6 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
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
index f7317df..e313bf1 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2373,12 +2373,6 @@ deprecated.
 
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
1.8.3.1
