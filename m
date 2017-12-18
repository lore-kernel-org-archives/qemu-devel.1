Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFF-0002XU-EH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFD-0004bD-Tz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:29 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFD-0004ZK-KW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:27 -0500
Received: by mail-pl0-x242.google.com with SMTP id 62so3774707pld.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:14 -0800
Message-Id: <20171218173022.18418-2-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/9] target/arm: Mark disas_set_insn_syndrome
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

If it isn't used when translate.h is included,
we'll get a compiler Werror.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index cd7313ace7..3f4df91e5e 100644
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
2.14.3
