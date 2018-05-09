Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGWCT-0008SZ-5m
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGWCS-00029f-HJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:00:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 23:00:19 +0200
Message-Id: <20180509210023.20283-4-mreitz@redhat.com>
In-Reply-To: <20180509210023.20283-1-mreitz@redhat.com>
References: <20180509210023.20283-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/7] qemu-option: Pull out "Supported
 options" print
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

It really is up to the caller to decide what this list of options means.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c         | 1 +
 util/qemu-option.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 347cf2ed9f..c84d047872 100644
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
