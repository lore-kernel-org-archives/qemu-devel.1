Received: from eggs.gnu.org ([2001:4830:134:3::10]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006QZ-QO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJd-0008Lq-D0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJd-0008L8-7u
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:01 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:32 +0100
Message-Id: <1483692945-9866-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 04/17] wctablet: drop wctablet_commands_names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

It is unused, except in a commented debug printf which is dropped too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 787da49..00498e1 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -81,29 +81,6 @@ uint8_t wctablet_commands[WC_COMMANDS_COUNT][7] = {
     {0x7e, 0x23, 0x0d, 0}                       // ~#\r
 };
 
-// Char strings with avaliable commands
-char wctablet_commands_names[WC_COMMANDS_COUNT][12] = {
-    "\\nSP\\n",
-    "~#",
-    "\\nTE\\n",
-    "RE\\n",
-    "AS1\\n",
-    "IC1\\n",
-    "OC1\\n",
-    "IT3\\r",
-    "SU3\\n",
-    "PH1\\n",
-    "\\rST\\n",
-    "\\rSP\\r",
-    "TE\\r",
-    "SP\\n",
-    "#AL1\\r",
-    "ST\\n",
-    "\\rTS&\\r",
-    "\\r\\nSP\\r\\n",
-    "~#\\r"
-};
-
 // Model string and config string
 uint8_t *WC_MODEL_STRING = (uint8_t *) "~#CT-0045R,V1.3-5,";
 size_t WC_MODEL_STRING_LENGTH = 18;
@@ -292,8 +269,6 @@ static int wctablet_chr_write(struct CharDriverState *s,
             wctablet_queue_output(tablet, codes, 7);
         }
 
-        // DPRINTF("-------- Command: %s\n", wctablet_commands_names[comm]);
-
         tablet->query_index = 0;
     }
 
-- 
1.8.3.1
