Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHlW-0007n1-R1
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHlT-0008Jc-Nk
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:24:22 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:54 +0300
Message-Id: <183861456d5e01649df9591a535486c10d72e060.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 08/22] qemu-img: remove references to GEN_DOCS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: John Snow <jsnow@redhat.com>

Nothing seemingly uses this.
(jcody: commit 77bd1119ba even mentions that it appears unused)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c             | 2 --
 qemu-options-wrapper.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 60e45ec103..2b5a5706b6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -123,7 +123,6 @@ static void QEMU_NORETURN help(void)
            "  " arg_string "\n"
 #include "qemu-img-cmds.h"
 #undef DEF
-#undef GEN_DOCS
            "\n"
            "Command parameters:\n"
            "  'filename' is a disk image filename\n"
@@ -4716,7 +4715,6 @@ static const img_cmd_t img_cmds[] = {
     { option, callback },
 #include "qemu-img-cmds.h"
 #undef DEF
-#undef GEN_DOCS
     { NULL, NULL, },
 };
 
diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 13bfea0294..6f548e3922 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -34,7 +34,6 @@
 #undef DEF
 #undef DEFHEADING
 #undef ARCHHEADING
-#undef GEN_DOCS
 
 #undef QEMU_OPTIONS_GENERATE_ENUM
 #undef QEMU_OPTIONS_GENERATE_HELP
-- 
2.11.0
