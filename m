Received: from eggs.gnu.org ([2001:4830:134:3::10]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXV-0004z0-W0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXV-0007Ih-04
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:02 -0400
Received: from mail-pl0-x22c.google.com ([2607:f8b0:400e:c01::22c]:41915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXU-0007I0-Qa
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:00 -0400
Received: by mail-pl0-x22c.google.com with SMTP id az12-v6so13312176plb.8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:30 -1000
Message-Id: <20180612005145.3375-5-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 04/19] linux-user/sparc64: Add
 inotify_rm_watch and tee syscalls
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc64/syscall_nr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc64/syscall_nr.h b/linux-user/sparc64/syscall_nr.h
index 9391645598..0b91b896da 100644
--- a/linux-user/sparc64/syscall_nr.h
+++ b/linux-user/sparc64/syscall_nr.h
@@ -154,7 +154,7 @@
 #define TARGET_NR_poll               153 /* Common                                      */
 #define TARGET_NR_getdents64		154 /* Linux specific				   */
 #define TARGET_NR_fcntl64            155 /* Linux sparc32 Specific                      */
-/* #define TARGET_NR_getdirentries   156    SunOS Specific                              */
+#define TARGET_NR_inotify_rm_watch   156 /* Linux specific                              */
 #define TARGET_NR_statfs             157 /* Common                                      */
 #define TARGET_NR_fstatfs            158 /* Common                                      */
 #define TARGET_NR_umount             159 /* Common                                      */
@@ -278,7 +278,7 @@
 #define TARGET_NR_mq_notify		277
 #define TARGET_NR_mq_getsetattr	278
 #define TARGET_NR_waitid		279
-/*#define TARGET_NR_sys_setaltroot	280 available (was setaltroot) */
+#define TARGET_NR_tee                   280
 #define TARGET_NR_add_key		281
 #define TARGET_NR_request_key	282
 #define TARGET_NR_keyctl		283
-- 
2.17.1
