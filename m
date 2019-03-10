Received: from eggs.gnu.org ([209.51.188.92]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQE-0003LE-5q
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQD-00019p-I8
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQD-00018h-BX
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:33 -0500
Received: by mail-wm1-x344.google.com with SMTP id y15so1053858wma.0
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:23 +0100
Message-Id: <20190310003428.11723-2-f4bug@amsat.org>
In-Reply-To: <20190310003428.11723-1-f4bug@amsat.org>
References: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/6] target/m68k: Reduce the l1 TCGLabel scope
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6217a683f1..ab801b6ceb 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3019,7 +3019,6 @@ DISAS_INSN(branch)
     int32_t offset;
     uint32_t base;
     int op;
-    TCGLabel *l1;
 
     base = s->pc;
     op = (insn >> 8) & 0xf;
@@ -3035,7 +3034,7 @@ DISAS_INSN(branch)
     }
     if (op > 1) {
         /* Bcc */
-        l1 = gen_new_label();
+        TCGLabel *l1 = gen_new_label();
         gen_jmpcc(s, ((insn >> 8) & 0xf) ^ 1, l1);
         gen_jmp_tb(s, 1, base + offset);
         gen_set_label(l1);
-- 
2.19.1
