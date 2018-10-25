Received: from eggs.gnu.org ([2001:4830:134:3::10]:40415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKi-0006hx-Ky
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0000Px-RH
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKh-00009E-J5
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:40 -0400
Message-Id: <20181025172057.20414-32-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 31/48] target/mips: prepare for 2-pass
 translation (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

XXX: fill in plugin_insn

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index efafc6e795..46ed40cf8f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -25455,6 +25455,8 @@ static const TranslatorOps mips_tr_ops = {
     .translate_insn     = mips_tr_translate_insn,
     .tb_stop            = mips_tr_tb_stop,
     .disas_log          = mips_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
-- 
2.17.1
