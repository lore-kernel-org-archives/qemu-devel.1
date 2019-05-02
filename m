Received: from eggs.gnu.org ([209.51.188.92]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69i-0004ao-Au
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69Z-0002ZP-Cq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69X-0000kq-Kb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id c12so1794156wrt.8
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:35 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 10:26:38 +0300
Message-Id: <20190502072641.4667-25-arilou@gmail.com>
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 24/27] gdbstub: Add another handler for
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
Cc: alex.bennee@linaro.org, liran.alon@oracle.com, Jon Doron <arilou@gmail.com>

Follow GDB general query/set packet conventions, qemu.sstep can now
be set with the following command as well:
gdb> maint packet Qqemu.sstep:Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index 6daf779af4..bceceeec57 100644
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
