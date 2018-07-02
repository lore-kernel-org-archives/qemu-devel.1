Received: from eggs.gnu.org ([2001:4830:134:3::10]:49089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UO-0004dW-Vn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UK-0008MY-FD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:40 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:45041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0UK-0008MC-9w
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:36 -0400
Received: by mail-pg0-x22d.google.com with SMTP id r1-v6so1582505pgp.11
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:36 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:21 +0900
Message-Id: <20180702151023.24532-24-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 23/25] linux-user: Fix struct sigaltstack for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 linux-user/openrisc/target_signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index c352a8b333..8283eaf544 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -5,8 +5,8 @@
 
 typedef struct target_sigaltstack {
     abi_long ss_sp;
+    abi_int ss_flags;
     abi_ulong ss_size;
-    abi_long ss_flags;
 } target_stack_t;
 
 /* sigaltstack controls  */
-- 
2.17.0
