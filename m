Received: from eggs.gnu.org ([209.51.188.92]:60950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQe-0000hQ-Ao
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQc-0002Uc-Vb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQc-0002PM-NU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so12760929wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:26:36 +0300
Message-Id: <20190425132636.31636-22-arilou@gmail.com>
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 21/21] gdbstub: Clear unused variables in
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
Cc: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8838241209..32aeefbbe6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2268,17 +2268,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
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
+    switch(line_buf[0]) {
     case '!':
         put_packet(s, "OK");
         break;
@@ -2495,8 +2489,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
