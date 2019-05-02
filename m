Received: from eggs.gnu.org ([209.51.188.92]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6ti-0003ZJ-2Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008Mo-2T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-0007vw-Uv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id s15so1967051wra.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:45 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 11:15:51 +0300
Message-Id: <20190502081554.5521-25-arilou@gmail.com>
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 24/27] gdbstub: Add another handler for
 setting qemu.sstep
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

Follow GDB general query/set packet conventions, qemu.sstep can now
be set with the following command as well:
gdb> maint packet Qqemu.sstep:Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 88ff6224e6..34da10260d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2260,6 +2260,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
+    {
+        .handler = handle_set_qemu_sstep,
+        .cmd = "qemu.sstep:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1
