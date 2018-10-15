Received: from eggs.gnu.org ([2001:4830:134:3::10]:48136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fj-0005XQ-7I
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fi-0005FO-Eg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 19:28:17 +0200
Message-Id: <20181015172817.19796-6-mreitz@redhat.com>
In-Reply-To: <20181015172817.19796-1-mreitz@redhat.com>
References: <20181015172817.19796-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] fw_cfg: Drop newline in @file description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

There is no good reason why there should be a newline in this
description, so remove it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index f9ed053eab..19f8cc67ff 100644
--- a/vl.c
+++ b/vl.c
@@ -529,7 +529,7 @@ static QemuOptsList qemu_fw_cfg_opts = {
         }, {
             .name = "file",
             .type = QEMU_OPT_STRING,
-            .help = "Sets the name of the file from which\n"
+            .help = "Sets the name of the file from which "
                     "the fw_cfg blob will be loaded",
         }, {
             .name = "string",
-- 
2.17.1
