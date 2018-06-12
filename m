Received: from eggs.gnu.org ([2001:4830:134:3::10]:59223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXT-0004wJ-7G
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXS-0007GW-F1
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:59 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:41912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXS-0007G7-97
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:51:58 -0400
Received: by mail-pl0-x229.google.com with SMTP id az12-v6so13312117plb.8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:51:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:29 -1000
Message-Id: <20180612005145.3375-4-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/19] linux-user/microblaze: Fix typo in
 accept4 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
