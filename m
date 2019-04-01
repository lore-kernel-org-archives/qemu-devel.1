Received: from eggs.gnu.org ([209.51.188.92]:40033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAstA-0002wg-Ir
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAst9-0003LT-9Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:05:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hAst9-0003Dc-1X
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:05:55 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so4160747pll.13
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 02:05:38 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Mon,  1 Apr 2019 14:35:03 +0530
Message-Id: <20190401090503.9016-2-aruna.15@cse.mrt.ac.lk>
In-Reply-To: <20190401090503.9016-1-aruna.15@cse.mrt.ac.lk>
References: <20190401090503.9016-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel] [PATCH 2/2] Header cleanups- Tabs replaced with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

Declarations were moved out of qemu-common.h for functions declared in utils/ files.
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 include/qemu/id.h       | 4 ++--
 include/qemu/readline.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/id.h b/include/qemu/id.h
index 3a651fb9d2..f3451344e2 100644
--- a/include/qemu/id.h
+++ b/include/qemu/id.h
@@ -1,8 +1,8 @@
 #ifndef QEMU_ID_H
 #define QEMU_ID_H
 
-#define qemu_isalnum(c)		isalnum((unsigned char)(c))
-#define qemu_isalpha(c)		isalpha((unsigned char)(c))
+#define qemu_isalnum(c)    isalnum((unsigned char)(c))
+#define qemu_isalpha(c)    isalpha((unsigned char)(c))
 
 typedef enum IdSubSystems {
     ID_QDEV,
diff --git a/include/qemu/readline.h b/include/qemu/readline.h
index 4cbf7ead5a..67859a3028 100644
--- a/include/qemu/readline.h
+++ b/include/qemu/readline.h
@@ -1,7 +1,7 @@
 #ifndef READLINE_H
 #define READLINE_H
 
-#define qemu_isspace(c)		isspace((unsigned char)(c))
+#define qemu_isspace(c)    isspace((unsigned char)(c))
 
 #define READLINE_CMD_BUF_SIZE 4095
 #define READLINE_MAX_CMDS 64
-- 
2.17.1
