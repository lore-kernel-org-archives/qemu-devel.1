Received: from eggs.gnu.org ([209.51.188.92]:42965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tk-0003bX-7j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008OW-Ce
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6th-0007k4-1V
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id p21so1486781wmc.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:41 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 11:15:48 +0300
Message-Id: <20190502081554.5521-22-arilou@gmail.com>
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 21/27] gdbstub: Clear unused variables in
 gdb_handle_packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index d678191705..8bdfae4b29 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2259,17 +2259,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
+    switch (line_buf[0]) {
     case '!':
         put_packet(s, "OK");
         break;
@@ -2486,8 +2480,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     default:
         /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
+        put_packet(s, "");
         break;
     }
 
-- 
2.20.1
