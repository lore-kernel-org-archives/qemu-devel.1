Received: from eggs.gnu.org ([2001:4830:134:3::10]:45154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9vma-0007t5-L6
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 12:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9vmZ-0003AA-UI
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 12:54:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 21 Apr 2018 18:54:19 +0200
Message-Id: <20180421165423.30759-4-mreitz@redhat.com>
In-Reply-To: <20180421165423.30759-1-mreitz@redhat.com>
References: <20180421165423.30759-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] qemu-option: Pull out "Supported options"
 print
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

It really is up to the caller to decide what this list of options means.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c         | 1 +
 util/qemu-option.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 375fe852e0..6dd8e95bb2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -261,6 +261,7 @@ static int print_block_option_help(const char *filename, const char *fmt)
         create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
     }
 
+    printf("Supported options:\n");
     qemu_opts_print_help(create_opts);
     qemu_opts_free(create_opts);
     return 0;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index d0756fda58..95e6cf4e49 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -218,7 +218,6 @@ void qemu_opts_print_help(QemuOptsList *list)
 
     assert(list);
     desc = list->desc;
-    printf("Supported options:\n");
     while (desc && desc->name) {
         printf("%-16s %s\n", desc->name,
                desc->help ? desc->help : "No description available");
-- 
2.14.3
