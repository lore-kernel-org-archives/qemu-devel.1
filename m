Received: from eggs.gnu.org ([2001:4830:134:3::10]:33652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehof-0003DK-4W
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoe-00037m-Df
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoe-00033y-73
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoT-0006qQ-Co
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:11 +0000
Message-Id: <1516887809-6265-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/21] target/arm: Mark disas_set_insn_syndrome
 inline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

If it isn't used when translate.h is included,
we'll get a compiler Werror.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180119045438.28582-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index cd7313a..3f4df91 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -108,7 +108,7 @@ static inline int default_exception_el(DisasContext *s)
             ? 3 : MAX(1, s->current_el);
 }
 
-static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
+static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 {
     /* We don't need to save all of the syndrome so we mask and shift
      * out unneeded bits to help the sleb128 encoder do a better job.
-- 
2.7.4
