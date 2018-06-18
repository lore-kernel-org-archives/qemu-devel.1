Received: from eggs.gnu.org ([2001:4830:134:3::10]:57574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5o-0003jQ-Mq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5n-00056a-0Y
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:32 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:41571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5m-00056M-Qa
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:30 -0400
Received: by mail-pg0-x231.google.com with SMTP id l65-v6so7927596pgl.8
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:46 -1000
Message-Id: <20180618184046.6270-23-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 22/22] linux-user: Fix struct sigaltstack
 for openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.1
