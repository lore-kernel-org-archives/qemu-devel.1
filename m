Received: from eggs.gnu.org ([2001:4830:134:3::10]:53876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qi-DQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiH-0004S7-88
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiH-0004Rj-2k
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E3FA4E326
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:54 +0100
Message-Id: <1487715299-21102-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/9] drop arch-specific graphic_*
 initialization.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Now that sparc and ppc can deal with uninitialized graphic_* variables
we can drop the #ifdefs and also move the variables out of arch_init.c
as they are not arch specific any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch_init.c | 11 -----------
 vl.c        |  3 +++
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 0810116..f41af1c 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -34,17 +34,6 @@
 #include "hw/acpi/acpi.h"
 #include "qemu/help_option.h"
 
-#ifdef TARGET_SPARC
-int graphic_width = 1024;
-int graphic_height = 768;
-int graphic_depth = 8;
-#else
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 32;
-#endif
-
-
 #if defined(TARGET_ALPHA)
 #define QEMU_ARCH QEMU_ARCH_ALPHA
 #elif defined(TARGET_ARM)
diff --git a/vl.c b/vl.c
index 27d9829..3be883e 100644
--- a/vl.c
+++ b/vl.c
@@ -135,6 +135,9 @@ const char *bios_name = NULL;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int request_opengl = -1;
 int display_opengl;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
 const char *mem_path = NULL;
-- 
1.8.3.1
