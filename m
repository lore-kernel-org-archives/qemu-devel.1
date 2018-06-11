Received: from eggs.gnu.org ([2001:4830:134:3::10]:52903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmF-0004ON-KJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmC-0001ec-PO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:48 +0200
Message-Id: <20180611142611.6609-7-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 06/29] qemu-option: Pull out "Supported options"
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

It really is up to the caller to decide what this list of options means.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509210023.20283-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c         | 1 +
 util/qemu-option.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index df3ec5b7fe..52008c5647 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -260,6 +260,7 @@ static int print_block_option_help(const char *filename, const char *fmt)
         create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
     }
 
+    printf("Supported options:\n");
     qemu_opts_print_help(create_opts);
     qemu_opts_free(create_opts);
     return 0;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 58d1c23893..ba44a0895c 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -220,7 +220,6 @@ void qemu_opts_print_help(QemuOptsList *list)
 
     assert(list);
     desc = list->desc;
-    printf("Supported options:\n");
     while (desc && desc->name) {
         printf("%-16s %s\n", desc->name,
                desc->help ? desc->help : "No description available");
-- 
2.17.1
