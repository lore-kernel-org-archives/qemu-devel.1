Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEN9r-0001LH-IO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEN9q-0005tM-PW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:57:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu,  3 May 2018 18:56:46 -0400
Message-Id: <20180503225648.13153-4-jsnow@redhat.com>
In-Reply-To: <20180503225648.13153-1-jsnow@redhat.com>
References: <20180503225648.13153-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] qemu-img: remove references to GEN_DOCS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>

Nothing seemingly uses this.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-img.c             | 2 --
 qemu-options-wrapper.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 855fa52514..a01425372d 100644
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
@@ -4685,7 +4684,6 @@ static const img_cmd_t img_cmds[] = {
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
2.14.3
