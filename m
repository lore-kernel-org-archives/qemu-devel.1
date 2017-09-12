Received: from eggs.gnu.org ([2001:4830:134:3::10]:41578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jincheng.miao@gmail.com>) id 1drRQf-0003hO-6f
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jincheng.miao@gmail.com>) id 1drRQa-0003Ik-52
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:19:21 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jincheng.miao@gmail.com>)
	id 1drRQZ-0003Hg-Uf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:19:16 -0400
Received: by mail-pg0-x244.google.com with SMTP id t3so4840359pgt.5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 09:19:14 -0700 (PDT)
From: jincheng.miao@gmail.com
Date: Tue, 12 Sep 2017 08:17:39 +0800
Message-Id: <1505175459-27177-1-git-send-email-jincheng.miao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg: Fix tci build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, peter.maydell@linaro.org, sw@weilnetz.de
Cc: qemu-devel@nongnu.org, Jincheng Miao <jincheng.miao@gmail.com>

From: Jincheng Miao <jincheng.miao@gmail.com>

The previous commit 659ef5cbb8 enable LDST_LABELS in tci target,
but which causes tci build error like:
tcg/tcg.c:116:13: error: ‘tcg_out_ldst_finalize’ used but never defined [-Werror]
 static bool tcg_out_ldst_finalize(TCGContext *s);
             ^
cc1: all warnings being treated as errors
make[1]: *** [tcg/tcg.o] Error 1
make: *** [subdir-x86_64-softmmu] Error 2

If this macro is not used in tci, we could just delete it.

Signed-off-by: Jincheng Miao <jincheng.miao@gmail.com>
---
 tcg/tci/tcg-target.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 5d692e1..26140d7 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -206,8 +206,4 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
     /* no need to flush icache explicitly */
 }
 
-#ifdef CONFIG_SOFTMMU
-#define TCG_TARGET_NEED_LDST_LABELS
-#endif
-
 #endif /* TCG_TARGET_H */
-- 
1.8.3.1
