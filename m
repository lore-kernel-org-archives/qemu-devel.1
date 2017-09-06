Received: from eggs.gnu.org ([2001:4830:134:3::10]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqO-0008MR-Dc
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqI-0001VN-Pn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:24 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqI-0001Te-Jt
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:18 -0400
Received: by mail-pg0-x230.google.com with SMTP id q68so156062pgq.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:41 -0700
Message-Id: <20170906160612.22769-2-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/32] tcg: Add generic DISAS_NORETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

This will allow some amount of cleanup to happen before
switching the backends over to enum DisasJumpType.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 440fc31b37..b434988979 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -63,6 +63,7 @@ typedef ram_addr_t tb_page_addr_t;
 #define DISAS_JUMP    1 /* only pc was modified dynamically */
 #define DISAS_TB_JUMP 2 /* only pc was modified statically */
 #define DISAS_UPDATE  3 /* cpu state was modified dynamically */
+#define DISAS_NORETURN 4 /* the tb has already been exited */
 
 #include "qemu/log.h"
 
-- 
2.13.5
