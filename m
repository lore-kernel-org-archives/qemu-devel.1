Received: from eggs.gnu.org ([2001:4830:134:3::10]:39448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGG-000501-Ki
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGA-0003jq-NI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:26 -0300
Message-Id: <20180606152128.449-10-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/11] target/m68k: Add trailing '\n' to
 qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 37d6ffd853..4b5dbdb51c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1556,7 +1556,7 @@ DISAS_INSN(undef)
     /* ??? This is both instructions that are as yet unimplemented
        for the 680x0 series, as well as those that are implemented
        but actually illegal for CPU32 or pre-68020.  */
-    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x",
+    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
                   insn, s->insn_pc);
     gen_exception(s, s->insn_pc, EXCP_UNSUPPORTED);
 }
-- 
2.17.1
