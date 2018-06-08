Received: from eggs.gnu.org ([2001:4830:134:3::10]:50629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlt-0003AP-Dx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGls-0004Lm-H0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGls-0004L8-9o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlr-0003l8-8d
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:09 +0100
Message-Id: <20180608124517.29475-24-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/31] target/m68k: Add trailing '\n' to
 qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20180606152128.449-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 37d6ffd8531..4b5dbdb51c9 100644
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
