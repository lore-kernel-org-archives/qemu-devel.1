Received: from eggs.gnu.org ([2001:4830:134:3::10]:40362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006hw-1T
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKR-0000DX-Bk
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKR-00005K-51
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:33 -0400
Message-Id: <20181025172057.20414-25-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 24/48] translator: add .ctx_base_offset and
 .ctx_size to TranslatorOps
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/translator.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index a28147b3dd..e20ca9f854 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -106,6 +106,8 @@ typedef struct DisasContextBase {
  *
  * @disas_log:
  *      Print instruction disassembly to log.
+ * @ctx_base_offset: offset of DisasContextBase within DisasContext.
+ * @ctx_size: size of DisasContext.
  */
 typedef struct TranslatorOps {
     void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
@@ -117,6 +119,8 @@ typedef struct TranslatorOps {
                            struct qemu_plugin_insn *plugin_insn);
     void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
     void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
+    size_t ctx_base_offset;
+    size_t ctx_size;
 } TranslatorOps;
 
 /**
-- 
2.17.1
