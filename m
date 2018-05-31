Received: from eggs.gnu.org ([2001:4830:134:3::10]:35045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOF2k-0007CU-U7
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOF2k-0004D9-34
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:30 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:41414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOF2j-0004Cu-TN
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:18:30 -0400
Received: by mail-pg0-x234.google.com with SMTP id d14-v6so9103768pgv.8
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 21:18:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 30 May 2018 21:18:22 -0700
Message-Id: <20180531041822.5761-3-richard.henderson@linaro.org>
In-Reply-To: <20180531041822.5761-1-richard.henderson@linaro.org>
References: <20180531041822.5761-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: Fix struct sigaltstack for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, shorne@gmail.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 2a4e00b035..901097972a 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -7,8 +7,8 @@
 
 typedef struct target_sigaltstack {
     abi_long ss_sp;
+    abi_int ss_flags;
     abi_ulong ss_size;
-    abi_long ss_flags;
 } target_stack_t;
 
 /* sigaltstack controls  */
-- 
2.17.0
