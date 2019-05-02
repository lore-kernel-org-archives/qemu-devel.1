Received: from eggs.gnu.org ([209.51.188.92]:42699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-0003V0-At
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ta-0007z6-Cv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tY-0007mD-Ej
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id o4so2024719wra.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:42 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 11:15:49 +0300
Message-Id: <20190502081554.5521-23-arilou@gmail.com>
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 22/27] gdbstub: Implement generic query
 qemu.Supported
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

qemu.Supported query reply back with the supported qemu query/set
commands (commands are seperated with a semicolon from each other).

gdb> maint packet qqemu.Supported

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 8bdfae4b29..00c07d6ec0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2127,6 +2127,11 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, GDB_ATTACHED);
 }
 
+static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "sstepbits;sstep");
+}
+
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
     {
@@ -2203,6 +2208,10 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_attached,
         .cmd = "Attached",
     },
+    {
+        .handler = handle_query_qemu_supported,
+        .cmd = "qemu.Supported",
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1
