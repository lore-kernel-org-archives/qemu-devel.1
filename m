Received: from eggs.gnu.org ([2001:4830:134:3::10]:54692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxv-0005Xh-1S
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxu-0001if-BY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:55 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:35237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQzxu-0001iU-5c
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:54 -0400
Received: by mail-pg0-x230.google.com with SMTP id 15-v6so5175472pge.2
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:48:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Jun 2018 11:48:43 -0700
Message-Id: <20180607184844.30126-4-richard.henderson@linaro.org>
In-Reply-To: <20180607184844.30126-1-richard.henderson@linaro.org>
References: <20180607184844.30126-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] linux-user/microblaze: Fix typo in accept4
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/syscall_nr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
index 0704449bae..761208e9e6 100644
--- a/linux-user/microblaze/syscall_nr.h
+++ b/linux-user/microblaze/syscall_nr.h
@@ -363,7 +363,7 @@
 #define TARGET_NR_shutdown		359 /* new */
 #define TARGET_NR_sendmsg		360 /* new */
 #define TARGET_NR_recvmsg		361 /* new */
-#define TARGET_NR_accept04		362 /* new */
+#define TARGET_NR_accept4		362 /* new */
 #define TARGET_NR_preadv                363 /* new */
 #define TARGET_NR_pwritev               364 /* new */
 #define TARGET_NR_rt_tgsigqueueinfo     365 /* new */
-- 
2.17.1
